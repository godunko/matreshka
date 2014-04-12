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

package body Matreshka.Filters.Deflate.Pack is

   procedure Internal_Read
     (Self     : in out Filter'Class;
      Input    : League.Stream_Element_Vectors.Stream_Element_Vector;
      Output   : in out League.Stream_Element_Vectors.Stream_Element_Vector;
      Complete : Boolean);

   procedure Output_Block_Header
     (Output : in out Matreshka.Filters.Bit_Streams.Bit_Stream);

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is
      Literal_Length : constant Literal_Tables.Length_Map :=
        (000 .. 143 => 8,
         144 .. 255 => 9,
         256 .. 279 => 7,
         280 .. 287 => 8);
      --  Predefined lengths for fixed literal table
      Distance_Length : constant Distance_Tables.Length_Map := (others => 5);
      --  Predefined lengths for fixed distance table
   begin
      Fixed_Literal_Table.Initialize (Literal_Length);
      Fixed_Distance_Table.Initialize (Distance_Length);
   end Initialize;

   -------------------------
   -- Output_Block_Header --
   -------------------------

   procedure Output_Block_Header
     (Output : in out Matreshka.Filters.Bit_Streams.Bit_Stream) is
   begin
      Output.Write  --  Last block
        (Count => 1,
         Value => 1);

      Output.Write  --  static huffman
        (Count => 2,
         Value => Block_Kind'Pos (Fixed_Huffman_Block));
   end Output_Block_Header;

   ----------
   -- Read --
   ----------

   overriding procedure Read
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector) is
   begin
      if Input.Is_Empty then
         return;
      end if;

      Internal_Read
        (Self     => Self,
         Input    => Input,
         Output   => Output,
         Complete => False);
   end Read;

   -------------------
   -- Internal_Read --
   -------------------

   procedure Internal_Read
     (Self     : in out Filter'Class;
      Input    : League.Stream_Element_Vectors.Stream_Element_Vector;
      Output   : in out League.Stream_Element_Vectors.Stream_Element_Vector;
      Complete : Boolean)
   is

      procedure Advance_Last_Buffer_Index (Count : Length_Step);
      --  Make next Count bytes of input buffer available for search.
      --  Precondition: Buffer has Count bytes

      procedure Find_Best_Matched
        (Min_Length : Length_Step;
         Where      : out Cycle_Index;
         Length     : out Length_Step;
         Not_Enough : in out Boolean);
      --  Ищем в буфере цепочку аналогичную входной строке
      --  С максимальной длинной (не короче Min_Length, самую "правую").
      --  Если нашли вернем позицию Where и длинну Length, иначе Length = 1
      --  if Not_Enough then search failed due to no enough input data

      function Buffer_Has_Data return Boolean;
      --  Check if buffer has more input bytes

      procedure Send_Literal (Value : Ada.Streams.Stream_Element);
      --  Output literal
      procedure Send_Back_Reference (A : Look_Ahead_Data);
      --  Output back reference
      procedure Swap (A, B : in out Look_Ahead_Position);
      --  Switch A and B values

      Buf : Buffer renames Self.Buf;
      P : Ada.Streams.Stream_Element_Count := 1;
      Input_Length : constant Ada.Streams.Stream_Element_Count := Input.Length;
      use type Ada.Streams.Stream_Element_Count;

      function End_Of_File return Boolean;

      -----------------
      -- End_Of_File --
      -----------------

      function End_Of_File return Boolean is
      begin
         return P > Input_Length;
      end End_Of_File;

      -------------------------------
      -- Advance_Last_Buffer_Index --
      -------------------------------

      procedure Advance_Last_Buffer_Index (Count : Length_Step) is
      begin
         Buf.Index := Buf.Index + Count;
      end Advance_Last_Buffer_Index;

      ---------------------
      -- Buffer_Has_Data --
      ---------------------

      function Buffer_Has_Data return Boolean is
      begin
         return Buf.Index /= Buf.Last + 1;
      end Buffer_Has_Data;

      -----------------------
      -- Find_Best_Matched --
      -----------------------

      procedure Find_Best_Matched
        (Min_Length : Length_Step;
         Where      : out Cycle_Index;
         Length     : out Length_Step;
         Not_Enough : in out Boolean)
      is
         pragma Unreferenced (Min_Length);
         use type Ada.Streams.Stream_Element;

         From : Cycle_Index;
      begin
         Length := 1;

         if Buf.Filled then
            From := Buf.Last + 1;
         elsif Buf.Index = 0 then
            --  No chars before Buf.Index, so search is impossible
            Where := Cycle_Index'First;
            return;
         else
            From := 0;
         end if;

         for K in reverse From .. Buf.Index - 1 loop
            for J in 0 .. Length_Step'Last - 1 loop
               if Buf.Index + J = Buf.Last + 1 then
                  if End_Of_File then
                     Not_Enough := True;
                     exit;
                  else
                     Buf.Last := Buf.Last + 1;
                     --  if Buf.Filled then delete_hash (Buf.Last)
                     Buf.Data (Buf.Last) := Input.Element (P); P := P + 1;
                  end if;
               end if;

               exit when Buf.Data (K + J) /= Buf.Data (Buf.Index + J);

               if J + 1 > Length then
                  Where := Buf.Index - K;
                  Length := J + 1;
               end if;
            end loop;
         end loop;
      end Find_Best_Matched;

      ------------------
      -- Send_Literal --
      ------------------

      procedure Send_Literal (Value : Ada.Streams.Stream_Element) is
         Code : constant Literal := Literal (Value);
      begin
         Fixed_Literal_Table.Write
           (Value  => Code,
            Output => Self.Output);
      end Send_Literal;

      --------------
      -- Send_Ptr --
      --------------

      procedure Send_Back_Reference (A : Look_Ahead_Data) is
         Length_Code   : Literal := Length_Range'Last;
         Distance_Code : Deflate.Distance_Code := Distance_Codes'Last;
         Bits          : Bit_Streams.Bits;
      begin
         for J in Length_Codes'First .. Length_Codes'Last - 1 loop
            if A.Length < Length_Codes (J + 1).Base_Length then
               Length_Code := J;
               exit;
            end if;
         end loop;

         Fixed_Literal_Table.Write
           (Value  => Length_Code,
            Output => Self.Output);

         Bits := Bit_Streams.Bits
           (A.Length - Length_Codes (Length_Code).Base_Length);

         Self.Output.Write
           (Count => Length_Codes (Length_Code).Extra_Bits,
            Value => Bits);

         for J in Distance_Codes'First .. Distance_Codes'Last - 1 loop
            if A.Where < Distance_Codes (J + 1).Base_Length then
               Distance_Code := J;
               exit;
            end if;
         end loop;

         Fixed_Distance_Table.Write
           (Value  => Distance_Code,
            Output => Self.Output);

         Bits := Bit_Streams.Bits
           (A.Where - Distance_Codes (Distance_Code).Base_Length);

         Self.Output.Write
           (Count => Distance_Codes (Distance_Code).Extra_Bits,
            Value => Bits);
      end Send_Back_Reference;

      ----------
      -- Swap --
      ----------

      procedure Swap (A, B : in out Look_Ahead_Position) is
         Tmp : constant Look_Ahead_Position := A;
      begin
         A := B;
         B := Tmp;
      end Swap;

      LA         : Look_Ahead_Data_Array    renames Self.Context.LA;
      A          : Look_Ahead_Position   renames Self.Context.A;  --  f[m-2]
      B          : Look_Ahead_Position   renames Self.Context.B;  --  f[m-1]
      M          : Look_Ahead_Count'Base renames Self.Context.M;
      K          : Look_Ahead_Kinds      renames Self.Context.K;
      C          : Length_Step;  --  f[m-1] - f[m-2]
      Where      : Cycle_Index;
      Length     : Length_Step;
      Not_Enough : Boolean := False;
   begin
      case Self.Last_Stage is
         when Empty =>
            goto Empty_Label;
         when Completed_Search =>
            goto Completed_Search_Label;
         when Incomplete_Search =>
            goto Incomplete_Search_Label;
      end case;

      <<Empty_Label>>
      --  Begin of pack stream, initialize Buffer and Output stream
      if Input.Length <= Max_Distance then
         declare
            Len : constant Cycle_Index := Cycle_Index(Input.Length - 1);

            type Piece is array (Cycle_Index range 0 .. Len) of
              Ada.Streams.Stream_Element;

            --  Trivial proceduree Fill is used to apply type view convention,
            --  because it only possible as 'in out' actual parammeter
            procedure Fill (V : in out Piece) is
            begin
               V := Piece (Input.To_Stream_Element_Array);
            end Fill;
         begin
            Fill (Piece (Buf.Data (0 .. Len)));
            Buf.Last   := Len;
            P := Input.Length + 1;
         end;
      else
         for J in Buf.Data'Range loop
            Buf.Data (J) :=
              Input.Element (Ada.Streams.Stream_Element_Offset (J + 1));
         end loop;

         Buf.Last := Cycle_Index'Last;
         P := Max_Distance + 1;
      end if;

      Buf.Filled := False;
      Buf.Index  := Cycle_Index'Last;

      Output_Block_Header (Self.Output);

      Advance_Last_Buffer_Index (1);  -- Step one byte forward

      <<Completed_Search_Label>>
      --  Previous search of optimal pack sequence completed, start new search
      A      := 0;  --  How long search prev-prev search went
      B      := 1;  --  How long search prev search went
      --  Remember literal for case when we will decide to skip it
      Self.Context.Skipped := Buf.Data (Buf.Index);

      --  Over: for M in LA'Range (1) loop
      M := 1;
      --  for K in LA'Range (2) loop
      K := Use_Current;

      <<Incomplete_Search_Label>>
      C := Length_Step (B - A);
      Find_Best_Matched (C + 1, Where, Length, Not_Enough);

      if Not_Enough and not Complete then
         Self.Last_Stage := Incomplete_Search;
         Self.Output.Get_Data (Output);
         return;
      end if;

      LA (M, K).Where := Where;
      LA (M, K).Length := Length;
      Advance_Last_Buffer_Index (C);

      if Length < Length_Step'Max (3, C + 1) then
         goto Break;  --  exit Over;
      end if;

      A := A + Look_Ahead_Position (Length);
      Swap (A, B);

      if K = Use_Current then
         K := Skip_Current;
         goto Incomplete_Search_Label;
      end if;
      --  end loop;

      K := Use_Current;
      M := M + 1;

      if M <= Max_Look_Ahead_Count then
         goto Incomplete_Search_Label;
      end if;
      --  end loop Over;

      <<Break>>
      case K is
         when Use_Current =>
            Send_Literal (Self.Context.Skipped);

            for J in 1 .. M - 1 loop
               Send_Back_Reference (LA (J, Skip_Current));
            end loop;

         when Skip_Current =>
            for J in 1 .. M loop
               Send_Back_Reference (LA (J, Use_Current));
            end loop;
      end case;

      if not End_Of_File or Buffer_Has_Data then
         goto Completed_Search_Label;
      end if;

      Self.Last_Stage := Completed_Search;
      Self.Output.Get_Data (Output);
   end Internal_Read;

   -----------
   -- Flush --
   -----------

   overriding procedure Flush
     (Self   : in out Filter;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector)
   is
   begin
      case Self.Last_Stage is
         when Empty =>
            Output_Block_Header (Self.Output);
         when Completed_Search =>
            null;
         when Incomplete_Search =>
            Internal_Read
              (Self     => Self,
               Input    =>
                  League.Stream_Element_Vectors.Empty_Stream_Element_Vector,
               Output   => Output,
               Complete => True);
      end case;

      if Self.Output.Has_Bits (1) then
         Self.Output.Write (Count => 7, Value => 0);
      end if;

      Self.Output.Get_Data (Output);
      Self.Output.Reset;
   end Flush;

end Matreshka.Filters.Deflate.Pack;
