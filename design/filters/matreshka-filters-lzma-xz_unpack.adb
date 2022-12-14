------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2013, Vadim Godunko <vgodunko@gmail.com>                     --
-- All rights reserved.                                                     --
--                                                                          --
-- Redistribution and use in source and binary forms, with or without       --
-- modification, are permitted provided that the following conditions       --
-- are met:                                                                 --
--                                                                          --
--  * Redistributions of source code must retain the above copyright        --
--    notice, this list of conditions and the following disclaimer.         --
--                                                                          --
--  * Redistributions in binary form must reproduce the above copyright     --
--    notice, this list of conditions and the following disclaimer in the   --
--    documentation and/or other materials provided with the distribution.  --
--                                                                          --
--  * Neither the name of the Vadim Godunko, IE nor the names of its        --
--    contributors may be used to endorse or promote products derived from  --
--    this software without specific prior written permission.              --
--                                                                          --
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     --
-- HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   --
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED --
-- TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   --
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   --
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     --
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       --
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision: 3946 $ $Date: 2013-06-16 21:48:41 +0300 (Вс., 16 июня 2013) $
------------------------------------------------------------------------------

package body Matreshka.Filters.LZMA.XZ_Unpack is

   State_Move : constant array (Packet_Name, State) of State :=
     (Lit =>
        (STATE_LIT_LIT | STATE_MATCH_LIT_LIT | STATE_REP_LIT_LIT |
         STATE_SHORTREP_LIT_LIT => STATE_LIT_LIT,
         STATE_MATCH_LIT        => STATE_MATCH_LIT_LIT,
         STATE_REP_LIT          => STATE_REP_LIT_LIT,
         STATE_SHORTREP_LIT     => STATE_SHORTREP_LIT_LIT,
         STATE_LIT_MATCH        => STATE_MATCH_LIT,
         STATE_LIT_LONGREP      => STATE_REP_LIT,
         STATE_LIT_SHORTREP     => STATE_SHORTREP_LIT,
         STATE_NONLIT_MATCH     => STATE_MATCH_LIT,
         STATE_NONLIT_REP       => STATE_REP_LIT),
      Match =>
        (Literal_State      => STATE_LIT_MATCH, others => STATE_NONLIT_MATCH),
      Short_Rep =>
        (Literal_State      => STATE_LIT_SHORTREP, others => STATE_NONLIT_REP),
      Long_Rep =>
        (Literal_State      => STATE_LIT_LONGREP, others => STATE_NONLIT_REP));

   generic
      type Array_Index is range <>;

      type Probability_Array is array (Array_Index) of Probability;
   procedure Range_Coder_Bit_Tree
     (Self   : in out Range_Decoder;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Prob   : in out Probability_Array;
      Result : out Interfaces.Unsigned_8);

   -----------
   -- Flush --
   -----------

   overriding procedure Flush
     (Self   : in out Filter;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector)
   is
      pragma Unreferenced (Self);
      pragma Unreferenced (Output);
   begin
      null;
   end Flush;

   ---------------------------
   -- Normalize_Range_Coder --
   ---------------------------

   procedure Normalize_Range_Coder
     (Self   : in out Range_Decoder;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count)
   is
      use type Interfaces.Unsigned_32;
   begin
      if Self.Bound < 16#1_00_00_00# then
         if Index <= Input.Length then
            Self.Bound := Interfaces.Shift_Left (Self.Bound, 8);
            Self.Code := Interfaces.Shift_Left (Self.Code, 8)
              + Interfaces.Unsigned_32 (Input.Element (Index));
            Index := Index + 1;
         else
            raise Constraint_Error;
         end if;
      end if;
   end Normalize_Range_Coder;

   ---------------------
   -- Range_Coder_Bit --
   ---------------------

   procedure Range_Coder_Bit
     (Self   : in out Range_Decoder;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Prob   : in out Probability;
      Result : out Boolean)
   is
      use type Interfaces.Unsigned_32;

      Bound         : Interfaces.Unsigned_32;

   begin
      Normalize_Range_Coder (Self, Input, Index);

      Bound :=
        Interfaces.Shift_Right (Self.Bound, RC_BIT_MODEL_TOTAL_BITS)
        * Interfaces.Unsigned_32 (Prob);

      Result := Self.Code >= Bound;

      if Result then
         Self.Bound := Self.Bound - Bound;
         Self.Code := Self.Code - Bound;
         Prob := Prob - Prob / 2 ** RC_MOVE_BITS;
      else
         Self.Bound := Bound;
         Prob := Prob + (-Prob) / 2 ** RC_MOVE_BITS;
      end if;

   end Range_Coder_Bit;

   --------------------------
   -- Range_Coder_Bit_Tree --
   --------------------------

   procedure Range_Coder_Bit_Tree
     (Self   : in out Range_Decoder;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Prob   : in out Probability_Array;
      Result : out Interfaces.Unsigned_8)
   is
      use type Interfaces.Unsigned_8;

      Value : Array_Index'Base := 1;
      Bit    : Boolean;
   begin
      while Value < Array_Index'Last loop
         Range_Coder_Bit (Self, Input, Index, Prob (Value), Bit);
         Value := 2 * Value + Boolean'Pos (Bit);
      end loop;

      Result := Interfaces.Unsigned_8 (Value - Array_Index'Last);
   end Range_Coder_Bit_Tree;

   procedure Range_Coder_Bit_Tree_256 is
     new Range_Coder_Bit_Tree (Probability_Index, Probability_Array);

   procedure Range_Coder_Bit_Tree_8 is
     new Range_Coder_Bit_Tree (Length_Index_8, Length_Array_8);

   procedure Range_Coder_Bit_Tree_6 is
     new Range_Coder_Bit_Tree (Slot, Slot_Probability_Array);

   ----------------------------------
   -- Range_Coder_Bit_Tree_Reverse --
   ----------------------------------

   procedure Range_Coder_Bit_Tree_Reverse
     (Self   : in out Range_Decoder;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Prob   : in out Special_Distance_Array;
      Bits   : Positive;
      Offset : Dist_Offset;
      Result : out Interfaces.Unsigned_8)
   is
      use type Interfaces.Unsigned_8;

      Point  : Interfaces.Unsigned_8 := 1;
      Symbol : Interfaces.Unsigned_8 := 1;
      Bit    : Boolean;
   begin
      Result := 0;
      for J in 1 .. Bits loop
         Range_Coder_Bit (Self, Input, Index, Prob (Symbol + Offset), Bit);
         Symbol := 2 * Symbol + Boolean'Pos (Bit);

         if Bit then
            Result := Result + Point;
         end if;

         Point := Interfaces.Shift_Left (Point, 1);
      end loop;
   end Range_Coder_Bit_Tree_Reverse;

   ------------------------
   -- Range_Coder_Direct --
   ------------------------

   procedure Range_Coder_Direct
     (Self   : in out Range_Decoder;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Bits   : Positive;
      Result : in out Ada.Streams.Stream_Element_Count)
   is
      use type Interfaces.Unsigned_32;
      Bit    : Boolean;
   begin
      for J in 1 .. Bits loop
         Normalize_Range_Coder (Self, Input, Index);
         Self.Bound := Interfaces.Shift_Right (Self.Bound, 1);
         Self.Code := Self.Code - Self.Bound;
         Bit := Self.Code < 16#8000_0000#;

         if not Bit then
            Self.Code := Self.Code + Self.Bound;
         end if;

         Result := 2 * Result + Boolean'Pos (Bit);
      end loop;
   end Range_Coder_Direct;

   -----------------------------
   -- Read_Block_Header_Bytes --
   -----------------------------

   not overriding procedure Read_Block_Header_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Ok : out Boolean)
   is
      use type Ada.Streams.Stream_Element;
      use type Interfaces.Unsigned_8;
      use type Interfaces.Unsigned_32;
   begin
      while Self.Count <= Self.Block_Header.Header_Size
         and Index <= Input.Length
      loop
         case Self.Count is
            when 1 =>
               if Input.Element (Index) = 0 then
                  Self.Block_Header.Header_Size := 0;
                  Ok := True;
                  return;
               end if;

               Self.Block_Header.CRC32 := 0;
               Self.Block_Header.Header_Size :=
                 4 * Ada.Streams.Stream_Element_Offset (Input.Element (Index))
                 + 4;
            when 2 =>
               Self.Block_Header.Flags :=
                 Interfaces.Unsigned_8 (Input.Element (Index));

               if Self.Block_Header.Flags /= 0 then
                  raise Constraint_Error with "unimplemented";
               end if;
            when 3 =>
               Self.Block_Header.Filter_Id :=
                 Interfaces.Unsigned_8 (Input.Element (Index));

               if Self.Block_Header.Filter_Id /= 16#21# then
                  raise Constraint_Error with "unimplemented";
               end if;

            when 4 =>
               if Input.Element (Index) /= 1 then
                  raise Constraint_Error with "unexpected Filter prop length";
               end if;

            when 5 =>
               Self.Block_Header.Filter_Prop :=
                 Interfaces.Unsigned_8 (Input.Element (Index));

               if Self.Block_Header.Filter_Prop = 40 then
                  Self.Block_Header.Dictionary_Size := 16#FFFF_FFFF#;
               elsif (Self.Block_Header.Filter_Prop and 1) = 0 then
                  Self.Block_Header.Dictionary_Size :=
                    Ada.Streams.Stream_Element_Offset
                      (Interfaces.Shift_Left
                           (2 + Interfaces.Unsigned_32
                                (Self.Block_Header.Filter_Prop and 1),
                            Natural (Self.Block_Header.Filter_Prop) / 2 + 11));
               end if;

               Self.Dictionary.Set_Size (Self.Block_Header.Dictionary_Size);
            when 6 .. 8 =>
               null;  --  Padding

            when 9 .. 12 =>
               Self.Block_Header.CRC32 := Self.Block_Header.CRC32 or
                 Interfaces.Shift_Left
                   (Interfaces.Unsigned_32 (Input.Element (Index)),
                    Natural (Self.Count - 9) * 8);
            when others =>
               raise Program_Error;
         end case;

         Self.Count := Self.Count + 1;
         Index := Index + 1;
      end loop;

      if Self.Count = Self.Block_Header.Header_Size + 1 then
         Self.Count := 1;
         Ok := True;
      else
         Ok := False;
      end if;
   end Read_Block_Header_Bytes;

   ---------------------------------
   -- Read_Compressed_Chunk_Bytes --
   ---------------------------------

   not overriding procedure Read_Compressed_Chunk_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector;
      Ok     : out Boolean)

   is
      function Left_Bytes return Ada.Streams.Stream_Element_Count;
      function Have_Bytes return Ada.Streams.Stream_Element_Count;

      Init_Bytes : constant := 5;  --  One byte ignored, others go into range
      Bit        : Boolean;
      Old_Index  : constant Ada.Streams.Stream_Element_Count := Index;

      ----------------
      -- Have_Bytes --
      ----------------

      function Have_Bytes return Ada.Streams.Stream_Element_Count is
      begin
         return Input.Length - Index + 1;
      end Have_Bytes;

      ----------------
      -- Left_Bytes --
      ----------------

      function Left_Bytes return Ada.Streams.Stream_Element_Count is
      begin
         return Self.Packet_Header.Compressed_Size - Self.Count + 1
           + Old_Index - Index;
      end Left_Bytes;

      use type Interfaces.Unsigned_32;
   begin
      if not Self.Saved.Is_Empty then
         declare
            Joined : League.Stream_Element_Vectors.Stream_Element_Vector;
            Saved  : constant Ada.Streams.Stream_Element_Count :=
              Self.Saved.Length;
         begin
            if Index /= 1 then
               raise Constraint_Error;
            end if;

            Self.Saved.Append (Input);
            Joined := Self.Saved;
            Self.Saved.Clear;
            Self.Read_Compressed_Chunk_Bytes (Joined, Index, Output, Ok);
            Index := Index - Saved;
            return;
         end;
      end if;

      while ((Left_Bytes in 1 .. LZMA_IN_REQUIRED  --  we are at end of chunk
             --  we have all chunk available
             and Have_Bytes >= Left_Bytes)
            or
            (Left_Bytes >= LZMA_IN_REQUIRED  --  we are not at end of chunk
             --  we have LZMA_IN_REQUIRED available
             and Have_Bytes >= LZMA_IN_REQUIRED))
          and Self.To_Write > 0
      loop
         case Self.Count + Index - Old_Index is
            when 1 .. Init_Bytes =>
               Self.Decoder.Range_Decoder.Code :=
                 Interfaces.Shift_Left (Self.Decoder.Range_Decoder.Code, 8)
                   + Interfaces.Unsigned_32 (Input.Element (Index));

               Index := Index + 1;
            when others =>
               declare
                  Lit_Prob : Probability renames Self.Decoder.Is_Match
                    (Self.Decoder.State,
                     Self.Dictionary.Position
                       and Self.Decoder.Property.Pos_Mask);
               begin
                  Range_Coder_Bit
                    (Self.Decoder.Range_Decoder, Input, Index, Lit_Prob, Bit);

                  if Bit = False then
                     Self.Read_Literal (Input, Index, Output);
                     Self.To_Write := Self.To_Write - 1;
                  else
                     Range_Coder_Bit
                       (Self.Decoder.Range_Decoder, Input, Index,
                        Self.Decoder.Is_Rep (Self.Decoder.State),
                        Bit);

                     if Bit = False then
                        Self.Read_Match (Input, Index, Output);
                     else
                        Self.Read_Rep_Match (Input, Index, Output);
                     end if;
                  end if;
               end;
         end case;
      end loop;

      if Self.To_Write = 0 then
         --  We need normalize because it could affect input stream
         Normalize_Range_Coder (Self.Decoder.Range_Decoder, Input, Index);
         Reset (Self.Decoder.Range_Decoder);

         Self.Count := 1;
         Ok := True;
      else
         Self.Count := Self.Count + Index - Old_Index;

         for J in Index .. Input.Length loop
            Self.Saved.Append (Input.Element (J));
         end loop;

         Ok := False;
      end if;
   end Read_Compressed_Chunk_Bytes;

   --------------------------------
   -- Read_Compressed_Size_Bytes --
   --------------------------------

   not overriding procedure Read_Compressed_Size_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Ok : out Boolean)
   is
      use type Interfaces.Unsigned_32;
   begin
      while Self.Count in 1 .. 4 and Index <= Input.Length loop
         case Self.Count is
            when 1 =>
               Self.Packet_Header.Uncompressed_Size :=
                 Ada.Streams.Stream_Element_Offset
                   (Interfaces.Shift_Left
                     (Interfaces.Unsigned_32
                       (Self.Packet_Header.Uncompressed_Size), 16)
                    + Interfaces.Shift_Left
                        (Interfaces.Unsigned_32 (Input.Element (Index)), 8));
            when 2 =>
               Self.Packet_Header.Uncompressed_Size :=
                 Self.Packet_Header.Uncompressed_Size
                   + Ada.Streams.Stream_Element_Offset (Input.Element (Index))
                   + 1;
            when 3 =>
               Self.Packet_Header.Compressed_Size :=
                 Ada.Streams.Stream_Element_Offset
                   (Interfaces.Shift_Left
                     (Interfaces.Unsigned_32 (Input.Element (Index)), 8));
            when 4 =>
               Self.Packet_Header.Compressed_Size :=
                 Self.Packet_Header.Compressed_Size
                   + Ada.Streams.Stream_Element_Offset (Input.Element (Index))
                   + 1;
            when others =>
               raise Constraint_Error;
         end case;

         Self.Count := Self.Count + 1;
         Index := Index + 1;
      end loop;

      if Self.Packet_Header.Properties_Reset then
         if Self.Count = 5 and Index <= Input.Length then
            Set_Property (Self.Decoder, Natural (Input.Element (Index)));
            Index := Index + 1;
            Self.Count := 1;
            Self.To_Write := Self.Packet_Header.Uncompressed_Size;
            Ok := True;
         end if;
      elsif Self.Count = 5 then
         Self.Count := 1;
         Self.To_Write := Self.Packet_Header.Uncompressed_Size;
         Ok := True;
      else
         Ok := False;
      end if;
   end Read_Compressed_Size_Bytes;

   -----------------
   -- Read_Length --
   -----------------

   not overriding procedure Read_Length
     (Self    : Filter;
      RD      : in out Range_Decoder;
      Input   : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index   : in out Ada.Streams.Stream_Element_Count;
      LD      : in out Length_Decoder;
      Length  : out Ada.Streams.Stream_Element_Count)
   is
      Next  : Interfaces.Unsigned_8;
      Bit    : Boolean;
      Pos    : constant Position_State_Index :=
        Self.Dictionary.Position and Self.Decoder.Property.Pos_Mask;
   begin
      Range_Coder_Bit (RD, Input, Index, LD.Choice, Bit);

      if Bit = False then  --  Read Low length
         Range_Coder_Bit_Tree_8 (RD, Input, Index, LD.Low (Pos), Next);
         Length := MATCH_LEN_MIN + Ada.Streams.Stream_Element_Count (Next);
      else
         Range_Coder_Bit (RD, Input, Index, LD.Choice_2, Bit);

         if Bit = False then  --  Read Middle length
            Range_Coder_Bit_Tree_8 (RD, Input, Index, LD.Middle (Pos), Next);
            Length := MATCH_LEN_MIN + LEN_LOW_SYMBOLS +
              Ada.Streams.Stream_Element_Count (Next);
         else
            Range_Coder_Bit_Tree_256 (RD, Input, Index, LD.High, Next);
            Length := MATCH_LEN_MIN + LEN_LOW_SYMBOLS + LEN_MID_SYMBOLS +
              Ada.Streams.Stream_Element_Count (Next);
         end if;
      end if;
   end Read_Length;

   ------------------
   -- Read_Literal --
   ------------------

   not overriding procedure Read_Literal
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector)
   is
      use type Interfaces.Unsigned_8;
      use type Ada.Streams.Stream_Element;

      Prev  : Ada.Streams.Stream_Element := Self.Dictionary.Get (0);
      Codec : Codec_Index;
      Pos   : constant Position_State_Index :=
        Self.Dictionary.Position and Self.Decoder.Property.Literal_Pos_Mask;
      Next : Interfaces.Unsigned_8;
   begin
      Codec := Codec_Index
        (Interfaces.Shift_Right
           (Interfaces.Unsigned_8 (Prev), 8 - Self.Decoder.Property.LC)
         + Interfaces.Shift_Right
           (Interfaces.Unsigned_8 (Pos), Self.Decoder.Property.LC));

      if Self.Decoder.State in Literal_State then
         Range_Coder_Bit_Tree_256
           (Self.Decoder.Range_Decoder, Input, Index,
            Self.Decoder.Literal (Codec, Lit),
            Next);
         Output.Append (Ada.Streams.Stream_Element (Next));
         Self.Dictionary.Put ((1 => Ada.Streams.Stream_Element (Next)));
      else
         Prev := Self.Dictionary.Get (Self.Decoder.Rep (1));

         declare
            Bit      : Boolean;
            Prev_Bit : Boolean;
            Kind     : Codec_Kind := One;
            Symbol   : Probability_Index'Base := 1;
         begin
            for J in 1 .. 8 loop
               if Kind /= Lit then
                  Prev_Bit := Prev > 127;

                  If Prev_Bit then
                     Kind := One;
                  else
                     Kind := Zero;
                  end if;

                  Prev := Prev * 2;
               end if;

               Range_Coder_Bit
                 (Self.Decoder.Range_Decoder, Input, Index,
                  Self.Decoder.Literal (Codec, Kind) (Symbol),
                  Bit);

               Symbol := 2 * Symbol + Boolean'Pos (Bit);

               if Kind /= Lit and Bit /= Prev_Bit then
                  Kind := Lit;
               end if;
            end loop;

            Output.Append
              (Ada.Streams.Stream_Element (Symbol - 256));
            Self.Dictionary.Put
              ((1 => Ada.Streams.Stream_Element (Symbol - 256)));
         end;
      end if;

      Self.Decoder.State := State_Move (Lit, Self.Decoder.State);
   end Read_Literal;

   ----------------
   -- Read_Match --
   ----------------

   not overriding procedure Read_Match
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector)
   is
      use type Interfaces.Unsigned_8;

      Distance : Ada.Streams.Stream_Element_Count;
      Length   : Ada.Streams.Stream_Element_Count;
      State    : Distance_State;
      Next     : Interfaces.Unsigned_8;
      Value    : Interfaces.Unsigned_8;
   begin
      Self.Decoder.State := State_Move (Match, Self.Decoder.State);
      Self.Decoder.Rep (2 .. 4) := Self.Decoder.Rep (1 .. 3);

      Self.Read_Length
        (Self.Decoder.Range_Decoder,
         Input, Index,
         Self.Decoder.Length, Length);

      if Length < Other_Distance_State then
         State := Distance_State (Length);
      else
         State := Other_Distance_State;
      end if;

      Range_Coder_Bit_Tree_6
        (Self.Decoder.Range_Decoder, Input, Index,
         Self.Decoder.Dist_Slot (State),
         Next);

      if Next < DIST_MODEL_START then
         Distance := Ada.Streams.Stream_Element_Count (Next);
      elsif Next < DIST_MODEL_END then
         Range_Coder_Bit_Tree_Reverse
           (Self   => Self.Decoder.Range_Decoder,
            Input  => Input,
            Index  => Index,
            Prob   => Self.Decoder.Special_Dist,
            Bits   => Positive (Next / 2 - 1),
            Offset => Special_Offset (Next),
            Result => Value);

         Next := Next + Special_Offset (Next) + Value;

         Distance := Ada.Streams.Stream_Element_Count (Next);
      else
         Distance := 2 + Ada.Streams.Stream_Element_Count (Next and 1);

         Range_Coder_Direct
           (Self   => Self.Decoder.Range_Decoder,
            Input  => Input,
            Index  => Index,
            Bits   => Positive (Next / 2 - 1 - ALIGN_BITS),
            Result => Distance);

         Range_Coder_Bit_Tree_Reverse
           (Self   => Self.Decoder.Range_Decoder,
            Input  => Input,
            Index  => Index,
            Prob   => Self.Decoder.Special_Dist,
            Bits   => ALIGN_BITS,
            Offset => Allign_Offset,
            Result => Next);

         Distance := Distance * ALIGN_SIZE
           + Ada.Streams.Stream_Element_Count (Next);
      end if;

      Self.Dictionary.Repeat
        (Index  => Distance,
         Length => Length,
         Output => Output);

      Self.Decoder.Rep (1) := Distance;
      Self.To_Write := Self.To_Write - Length;
   end Read_Match;

   ------------------------------
   -- Read_Packet_Header_Bytes --
   ------------------------------

   not overriding procedure Read_Packet_Header_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Ok : out Boolean)
   is
      use type Interfaces.Unsigned_8;
   begin
      if Index <= Input.Length then
         Self.Packet_Header.Control_Byte :=
           Interfaces.Unsigned_8 (Input.Element (Index));

         Self.Packet_Header.Last_Packet      := False;
         Self.Packet_Header.Dictionary_Reset := False;
         Self.Packet_Header.State_Reset      := False;
         Self.Packet_Header.Properties_Reset := False;
         Self.Packet_Header.Compressed_Chunk := False;

         case Self.Packet_Header.Control_Byte is
            when 0 =>
               Self.Packet_Header.Last_Packet := True;
            when 1 =>
               Self.Packet_Header.Dictionary_Reset := True;
            when 2 =>
               null;
            when 16#E0# .. 16#FF# =>
               Self.Packet_Header.Dictionary_Reset := True;
               Self.Packet_Header.Properties_Reset := True;
               Self.Packet_Header.State_Reset      := True;
               Self.Packet_Header.Compressed_Chunk := True;
            when 16#C0# .. 16#DF# =>
               Self.Packet_Header.Properties_Reset := True;
               Self.Packet_Header.State_Reset      := True;
               Self.Packet_Header.Compressed_Chunk := True;
            when 16#A0# .. 16#BF# =>
               Self.Packet_Header.State_Reset      := True;
               Self.Packet_Header.Compressed_Chunk := True;
            when 16#80# .. 16#9F# =>
               Self.Packet_Header.Compressed_Chunk := True;
            when others =>
               raise Constraint_Error with "data error";
         end case;

         if Self.Packet_Header.Compressed_Chunk then
            Self.Packet_Header.Uncompressed_Size :=
              Ada.Streams.Stream_Element_Offset
                (Self.Packet_Header.Control_Byte and 16#1F#);
         end if;

         if Self.Packet_Header.Dictionary_Reset then
            Self.Dictionary.Reset;
         end if;

         if Self.Packet_Header.State_Reset
           and not Self.Packet_Header.Properties_Reset
         then
            Reset (Self.Decoder);
         end if;

         Self.Count := 1;
         Index := Index + 1;
         Ok := True;
      else
         Ok := False;
      end if;
   end Read_Packet_Header_Bytes;

   --------------------
   -- Read_Rep_Match --
   --------------------

   not overriding procedure Read_Rep_Match
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector)
   is
      Bit : Boolean;
      Rep_Index : Positive := 4;
      Distance : Ada.Streams.Stream_Element_Count;
      Length   : Ada.Streams.Stream_Element_Count := 0;
   begin
      for J in Self.Decoder.Is_Rep_Prob'Range (1) loop
         Range_Coder_Bit
           (Self.Decoder.Range_Decoder, Input, Index,
            Self.Decoder.Is_Rep_Prob (J, Self.Decoder.State),
            Bit);

         if Bit = False then
            Rep_Index := J;
            exit;
         end if;
      end loop;

      --  Move Rep_Index to first element on Rep
      Distance := Self.Decoder.Rep (Rep_Index);
      Self.Decoder.Rep (2 .. Rep_Index) :=
        Self.Decoder.Rep (1 .. Rep_Index - 1);
      Self.Decoder.Rep (1) := Distance;

      if Rep_Index = 1 tHen
         declare
            Long_Prob : Probability renames Self.Decoder.Is_Rep0_Long
              (Self.Decoder.State,
               Self.Dictionary.Position and Self.Decoder.Property.Pos_Mask);
         begin
            Range_Coder_Bit
              (Self.Decoder.Range_Decoder, Input, Index, Long_Prob, Bit);

            if Bit = False then
               Length := 1;
               Self.Decoder.State :=
                 State_Move (Short_Rep, Self.Decoder.State);
            end if;
         end;
      end if;

      if Length = 0 then
         Self.Read_Length
           (Self.Decoder.Range_Decoder,
            Input, Index,
            Self.Decoder.Rep_Length, Length);

         Self.Decoder.State := State_Move (Long_Rep, Self.Decoder.State);
      end if;

      Self.Dictionary.Repeat
        (Index  => Distance,
         Length => Length,
         Output => Output);

      Self.To_Write := Self.To_Write - Length;
   end Read_Rep_Match;

   ------------------------------
   -- Read_Stream_Header_Bytes --
   ------------------------------

   not overriding procedure Read_Stream_Header_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Ok     : out Boolean)
   is
      use type Interfaces.Unsigned_16;
      use type Interfaces.Unsigned_32;
   begin
      while Self.Count in 1 .. 12 and Index <= Input.Length loop
         case Self.Count is
            when 1 .. 6 =>
               Self.Stream_Header.Magic (Self.Count) := Input.Element (Index);
            when 7 .. 8 =>
               Self.Stream_Header.Flags :=
                 Interfaces.Shift_Left (Self.Stream_Header.Flags, 8)
                   or Interfaces.Unsigned_16 (Input.Element (Index));
            when 9 .. 12 =>
               Self.Stream_Header.CRC32 := Self.Stream_Header.CRC32 or
                 Interfaces.Shift_Left
                   (Interfaces.Unsigned_32 (Input.Element (Index)),
                    Natural (Self.Count - 9) * 8);
            when others =>
               raise Constraint_Error;
         end case;

         Self.Count := Self.Count + 1;
         Index := Index + 1;
      end loop;

      if Self.Count = 13 then
         Self.Count := 1;
         Self.Block_Header.Header_Size := 2;  --  Minimum header size
         Ok := True;
      else
         Ok := False;
      end if;
   end Read_Stream_Header_Bytes;

   -----------------------------------
   -- Read_Uncompressed_Chunk_Bytes --
   -----------------------------------

   not overriding procedure Read_Uncompressed_Chunk_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector;
      Ok     : out Boolean)

   is
      use type Interfaces.Unsigned_16;
      use type Interfaces.Unsigned_32;

      Length : constant Ada.Streams.Stream_Element_Offset :=
        Ada.Streams.Stream_Element_Offset'Min
          (Self.Packet_Header.Uncompressed_Size - Self.Count + 1,
           Input.Length - Index + 1);
   begin
      if Length > 0 then
         for J in Index .. Index + Length - 1 loop
            Self.Dictionary.Put ((1 => Input.Element (J)));
            Output.Append (Input.Element (J));
         end loop;

         Self.Count := Self.Count + Length;
         Index := Index + Length;
      end if;

      if Self.Count = Self.Packet_Header.Uncompressed_Size + 1 then
         Self.Count := 1;
         Ok := True;
      else
         Ok := False;
      end if;
   end Read_Uncompressed_Chunk_Bytes;

   ----------------------------------
   -- Read_Uncompressed_Size_Bytes --
   ----------------------------------

   not overriding procedure Read_Uncompressed_Size_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Ok     : out Boolean)
   is
   begin
      while Self.Count in 1 .. 2 and Index <= Input.Length loop
         case Self.Count is
            when 1 =>
               Self.Packet_Header.Uncompressed_Size :=
                 Ada.Streams.Stream_Element_Offset
                   (Interfaces.Shift_Left
                        (Interfaces.Unsigned_16 (Input.Element (Index)), 8));
            when 2 =>
               Self.Packet_Header.Uncompressed_Size :=
                 Self.Packet_Header.Uncompressed_Size
                   + Ada.Streams.Stream_Element_Offset (Input.Element (Index))
                   + 1;
            when others =>
               raise Constraint_Error;
         end case;

         Self.Count := Self.Count + 1;
         Index := Index + 1;
      end loop;

      if Self.Count = 3 then
         Self.Count := 1;
         Ok := True;
      else
         Ok := False;
      end if;
   end  Read_Uncompressed_Size_Bytes;

   ----------
   -- Read --
   ----------

   overriding procedure Read
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector)
   is
      --  Index inside Input
      Index : Ada.Streams.Stream_Element_Offset := 1;
      Ok    : Boolean;
   begin
      --  If previous processing canceled due to lack of input then continue
      --  from interrupted stage
      case Self.Last_Stage is
         when Read_Stream_Header =>
            goto Read_Stream_Header_Label;
         when Read_Block =>
            goto Read_Block_Label;
         when Read_Packet =>
            goto Read_Packet_Label;
         when Read_Compressed_Size =>
            goto Read_Compressed_Size_Label;
         when Read_Compressed_Chunk =>
            goto Read_Compressed_Chunk_Label;
         when Read_Uncompressed_Size =>
            goto Read_Uncompressed_Size_Label;
         when Read_Uncompressed_Chunk =>
            goto Read_Uncompressed_Chunk_Label;
         when Read_Completed =>
            goto Read_Completed_Label;
      end case;

      <<Read_Stream_Header_Label>>
      Self.Read_Stream_Header_Bytes (Input, Index, Ok);
      if not Ok then
         return;
      end if;

      <<Read_Block_Label>>
      Self.Read_Block_Header_Bytes (Input, Index, Ok);
      if not Ok then
         Self.Last_Stage := Read_Block;
         return;
      end if;

      <<Read_Packet_Label>>
      Self.Read_Packet_Header_Bytes (Input, Index, Ok);
      if not Ok then
         Self.Last_Stage := Read_Packet;
         return;
      elsif Self.Packet_Header.Last_Packet then
         goto Read_Completed_Label;
      elsif not Self.Packet_Header.Compressed_Chunk then
         goto Read_Uncompressed_Size_Label;
      end if;

      <<Read_Compressed_Size_Label>>
      Self.Read_Compressed_Size_Bytes (Input, Index, Ok);
      if not Ok then
         Self.Last_Stage := Read_Compressed_Size;
         return;
      end if;

      <<Read_Compressed_Chunk_Label>>
      Self.Read_Compressed_Chunk_Bytes (Input, Index, Output, Ok);
      if not Ok then
         Self.Last_Stage := Read_Compressed_Chunk;
         return;
      else
         goto Read_Packet_Label;
      end if;

      <<Read_Uncompressed_Size_Label>>
      Self.Read_Uncompressed_Size_Bytes (Input, Index, Ok);
      if not Ok then
         Self.Last_Stage := Read_Uncompressed_Size;
         return;
      end if;

      <<Read_Uncompressed_Chunk_Label>>
      Self.Read_Uncompressed_Chunk_Bytes (Input, Index, Output, Ok);
      if not Ok then
         Self.Last_Stage := Read_Uncompressed_Chunk;
         return;
      else
         goto Read_Packet_Label;
      end if;

      <<Read_Completed_Label>>
      Self.Last_Stage := Read_Completed;
      return;
   end Read;

   -----------
   -- Reset --
   -----------

   procedure Reset (Self : in out LZMA_Decoder) is
   begin
      Self.State := STATE_LIT_LIT;
      Reset (Self.Range_Decoder);
      Self.Is_Match := (others => (others => Half));
      Self.Literal := (others => (others => (others => Half)));
      Self.Is_Rep := (others => Half);
      Self.Length :=
        (Choice | Choice_2 => Half,
         High   => (others => Half),
         Middle => (others => (others => Half)),
         Low    => (others => (others => Half)));
      Self.Dist_Slot := (others => (others => Half));
      Self.Special_Dist := (others => Half);
      Self.Is_Rep_Prob := (others => (others => Half));
      Self.Is_Rep0_Long := (others => (others => Half));
      Self.Rep_Length :=
        (Choice | Choice_2 => Half,
         High   => (others => Half),
         Middle => (others => (others => Half)),
         Low    => (others => (others => Half)));
   end Reset;

   -----------
   -- Reset --
   -----------

   procedure Reset (Self : in out Range_Decoder) is
   begin
      Self.Bound := Interfaces.Unsigned_32'Last;
      Self.Code := 0;
   end Reset;

   ------------------
   -- Set_Property --
   ------------------

   procedure Set_Property
     (Self     : in out LZMA_Decoder;
      Value    : Natural)
   is
      Property : LZMA_Property renames Self.Property;
      Next     : Natural;
   begin
      Property.PB  := Value / (9 * 5);
      Next         := Value mod (9 * 5);
      Property.LP  := Next / 9;
      Property.LC  := Next mod 9;
      Property.Pos_Mask := 2 ** Property.PB - 1;
      Property.Literal_Pos_Mask := 2 ** Property.LP - 1;
      Reset (Self);
   end Set_Property;

end Matreshka.Filters.LZMA.XZ_Unpack;
