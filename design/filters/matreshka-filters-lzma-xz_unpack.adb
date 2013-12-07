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

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is
   begin
      null;
   end Initialize;

   ---------------------------
   -- Normalize_Range_Coder --
   ---------------------------

   not overriding procedure Normalize_Range_Coder
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count)
   is
      use type Interfaces.Unsigned_32;
      Range_Decoder : XZ_Unpack.Range_Decoder renames
        Self.Decoder.Range_Decoder;
   begin
      if Range_Decoder.Bound < 16#1_00_00_00# then
         if Index <= Input.Length then
            Range_Decoder.Bound := Interfaces.Shift_Left
              (Range_Decoder.Bound, 8);
            Range_Decoder.Code := Interfaces.Shift_Left (Range_Decoder.Code, 8)
              + Interfaces.Unsigned_32 (Input.Element (Index));
         else
            raise Constraint_Error;
         end if;
      end if;
   end Normalize_Range_Coder;

   ---------------------
   -- Range_Coder_Bit --
   ---------------------

   not overriding function Range_Coder_Bit
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Prob   : in out Probability) return Boolean
   is
      use type Interfaces.Unsigned_32;

      Result        : Boolean;
      Bound         : Interfaces.Unsigned_32;
      Range_Decoder : XZ_Unpack.Range_Decoder renames
        Self.Decoder.Range_Decoder;

   begin
      Self.Normalize_Range_Coder (Input, Index);

      Bound :=
        Interfaces.Shift_Right (Range_Decoder.Bound, Probability'Modulus)
        * Interfaces.Unsigned_32 (Prob);

      Result := Range_Decoder.Code >= Bound;

      if Result then
         Range_Decoder.Bound := Range_Decoder.Bound - Bound;
         Range_Decoder.Code := Range_Decoder.Code - Bound;
         Prob := (-Prob) / 2 ** RC_MOVE_BITS;
      else
         Range_Decoder.Bound := Bound;
         Prob := Prob / 2 ** RC_MOVE_BITS;
      end if;

      return Result;
   end Range_Coder_Bit;

   --------------------------
   -- Range_Coder_Bit_Tree --
   --------------------------

   not overriding function Range_Coder_Bit_Tree
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Prob   : in out Probability;
      Bits   : Positive) return Interfaces.Unsigned_8
   is
      use type Interfaces.Unsigned_8;

      Result : Interfaces.Unsigned_8 := 0;
      Bit    : Boolean;
   begin
      for J in 1 .. Bits loop
         Bit := Self.Range_Coder_Bit (Input, Index, Prob);  --  FIX Prob
         Result := Interfaces.Shift_Left (Result, 1) + Boolean'Pos (Bit);
      end loop;

      return Result;
   end Range_Coder_Bit_Tree;

   -----------------------------
   -- Read_Block_Header_Bytes --
   -----------------------------

   not overriding function Read_Block_Header_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count) return Boolean
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
                  return True;
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
         return True;
      else
         return False;
      end if;
   end Read_Block_Header_Bytes;

   ---------------------------------
   -- Read_Compressed_Chunk_Bytes --
   ---------------------------------

   not overriding function Read_Compressed_Chunk_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector)
      return Boolean
   is
      function Left_Bytes return Ada.Streams.Stream_Element_Count;

      Init_Bytes : constant := 5;  --  One byte ignored, others go into range
      Bit        : Boolean;
      Have_Bytes : constant Ada.Streams.Stream_Element_Count :=
        Input.Length - Index + 1;

      ----------------
      -- Left_Bytes --
      ----------------

      function Left_Bytes return Ada.Streams.Stream_Element_Count is
      begin
         return Self.Packet_Header.Compressed_Size - Self.Count + 1;
      end Left_Bytes;

      use type Interfaces.Unsigned_32;
   begin
      while (Left_Bytes <= LZMA_IN_REQUIRED  --  we are at end of chunk
             --  we have all chunk available
             and Have_Bytes >= Left_Bytes)
          or
            (Left_Bytes >= LZMA_IN_REQUIRED  --  we are not at end of chunk
             --  we have LZMA_IN_REQUIRED available
             and Have_Bytes >= LZMA_IN_REQUIRED)
      loop
         case Self.Count is
            when 1 .. Init_Bytes =>
               Self.Decoder.Range_Decoder.Bound :=
                 Interfaces.Shift_Left (Self.Decoder.Range_Decoder.Bound, 8)
                   + Interfaces.Unsigned_32 (Input.Element (Index));
            when others =>
               declare
                  Prob : Probability renames Self.Decoder.Is_Match
                    (Self.Decoder.State, Self.Decoder.Index);
               begin
                  Bit := Self.Range_Coder_Bit (Input, Index, Prob);

                  if not Bit then
                     Self.Read_Literal (Input, Index, Output);
                  end if;
               end;
         end case;

         Self.Count := Self.Count + 1;
         Index := Index + 1;
      end loop;

      if Self.Count = Self.Packet_Header.Compressed_Size + 1 then
         Self.Count := 1;
         return True;
      else
         return False;
      end if;
   end Read_Compressed_Chunk_Bytes;

   --------------------------------
   -- Read_Compressed_Size_Bytes --
   --------------------------------

   not overriding function Read_Compressed_Size_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count) return Boolean
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
            Self.Count := 1;
            Index := Index + 1;
            return True;
         end if;
      elsif Self.Count = 5 then
         Self.Count := 1;
         return True;
      end if;

      return False;
   end Read_Compressed_Size_Bytes;

   ------------------
   -- Read_Literal --
   ------------------

   not overriding procedure Read_Literal
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector)
   is
      Prev : Ada.Streams.Stream_Element := 0;
      Next : Interfaces.Unsigned_8;
   begin
      Prev := Ada.Streams.Stream_Element
        (Interfaces.Shift_Right
           (Interfaces.Unsigned_8 (Prev),
            8 - Self.Decoder.Property.LC));

      if Self.Decoder.State in Literal_State then
         declare
            Prob : Probability renames
              Self.Decoder.Literal (Self.Decoder.Index, Prev);
         begin
            Next := Self.Range_Coder_Bit_Tree (Input, Index, Prob, 8);
            Output.Append (Ada.Streams.Stream_Element (Next));
         end;
      end if;
   end Read_Literal;

   ------------------------------
   -- Read_Packet_Header_Bytes --
   ------------------------------

   not overriding function Read_Packet_Header_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count) return Boolean
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
            Self.Decoder.Index := 0;
         end if;

         if Self.Packet_Header.State_Reset
           and not Self.Packet_Header.Properties_Reset
         then
            Reset (Self.Decoder);
         end if;

         Self.Count := 1;
         Index := Index + 1;
         return True;
      end if;

      return False;
   end Read_Packet_Header_Bytes;

   ------------------------------
   -- Read_Stream_Header_Bytes --
   ------------------------------

   not overriding function Read_Stream_Header_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count) return Boolean
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
         return True;
      else
         return False;
      end if;
   end Read_Stream_Header_Bytes;

   -----------------------------------
   -- Read_Uncompressed_Chunk_Bytes --
   -----------------------------------

   not overriding function Read_Uncompressed_Chunk_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector)
      return Boolean
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
         return True;
      else
         return False;
      end if;
   end Read_Uncompressed_Chunk_Bytes;

   ----------------------------------
   -- Read_Uncompressed_Size_Bytes --
   ----------------------------------

   not overriding function Read_Uncompressed_Size_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count) return Boolean
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
         return True;
      else
         return False;
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
      end case;

      <<Read_Stream_Header_Label>>
      if not Self.Read_Stream_Header_Bytes (Input, Index) then
         return;
      end if;

      <<Read_Block_Label>>
      if not Self.Read_Block_Header_Bytes (Input, Index) then
         Self.Last_Stage := Read_Block;
         return;
      end if;

      <<Read_Packet_Label>>
      if not Self.Read_Packet_Header_Bytes (Input, Index) then
         Self.Last_Stage := Read_Packet;
         return;
      elsif Self.Packet_Header.Last_Packet then
         --  ???  Self.Last_Stage := Read_Stream_Header;
         return;
      elsif not Self.Packet_Header.Compressed_Chunk then
         goto Read_Uncompressed_Size_Label;
      end if;

      <<Read_Compressed_Size_Label>>
      if not Self.Read_Compressed_Size_Bytes (Input, Index) then
         Self.Last_Stage := Read_Compressed_Size;
         return;
      end if;

      <<Read_Compressed_Chunk_Label>>
      if not Self.Read_Compressed_Chunk_Bytes (Input, Index, Output) then
         Self.Last_Stage := Read_Uncompressed_Chunk;
         return;
      else
         goto Read_Packet_Label;
      end if;

      <<Read_Uncompressed_Size_Label>>
      if not Self.Read_Uncompressed_Size_Bytes (Input, Index) then
         Self.Last_Stage := Read_Uncompressed_Size;
         return;
      end if;

      <<Read_Uncompressed_Chunk_Label>>
      if not Self.Read_Uncompressed_Chunk_Bytes (Input, Index, Output) then
         Self.Last_Stage := Read_Uncompressed_Chunk;
         return;
      else
         goto Read_Packet_Label;
      end if;
   end Read;

   -----------
   -- Reset --
   -----------

   procedure Reset (Self : in out LZMA_Decoder) is
   begin
      Self.State := STATE_LIT_LIT;
      Reset (Self.Range_Decoder);
      Self.Is_Match := (others => (others => Half));
      Self.Literal := (others => (others => Half));
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
      Reset (Self);
   end Set_Property;

end Matreshka.Filters.LZMA.XZ_Unpack;
