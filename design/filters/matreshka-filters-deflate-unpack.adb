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
--  $Revision$ $Date$
------------------------------------------------------------------------------
--  Filter processes binary data by compress/decompress, encrypt/decrypt and
--  other purposes.

package body Matreshka.Filters.Deflate.Unpack is

   type Extra_Bits is record
      Extra_Bits  : Bit_Streams.Bit_Count;
      Base_Length : Cycle_Index;
   end record;
   --  This record stores number of extra bits to read for some length code
   --  and corresponding length.

   Length_Codes : constant array (Length_Range) of Extra_Bits :=
     ((0, 3), (0, 4), (0, 5), (0, 6), (0, 7), (0, 8), (0, 9), (0, 10),
      (1, 11), (1, 13), (1, 15), (1, 17),
      (2, 19), (2, 23), (2, 27), (2, 31),
      (3, 35), (3, 43), (3, 51), (3, 59),
      (4, 67), (4, 83), (4, 99), (4, 115),
      (5, 131), (5, 163), (5, 195), (5, 227),
      (0,258));
   --  This table stores number of extra bits to read for each length code
   --  and corresponding length.

   Distance_Codes : constant array (Distance_Code) of Extra_Bits :=
     ((0, 1),  (0, 2),  (0, 3),  (0, 4),  (1, 5),  (1, 7),  (2, 9),   (2, 13),
      (3, 17), (3, 25), (4, 33), (4, 49), (5, 65), (5, 97), (6, 129), (6, 193),
      (7, 257), (7, 385), (8, 513), (8, 769), (9, 1025), (9, 1537),
      (10, 2049), (10, 3073), (11, 4097), (11, 6145), (12, 8193), (12, 12289),
      (13, 16385), (13, 24577));
   --  This table stores number of extra bits to read for each length code
   --  and corresponding length.

   Fixed_Literal_Table  : Literal_Tables.Huffman_Table;
   Fixed_Distance_Table : Distance_Tables.Huffman_Table;
   --  Predefined (fixed) Huffman tables for deflate method.

   generic
      with package Value_Tables is new Huffman_Tables(<>);

      Input  : in out Matreshka.Filters.Deflate.Bit_Streams.Bit_Stream;
      Length : in out Length_Code;
      Index  : in out Value_Tables.Encoded_Element;
      Map    : in out Value_Tables.Length_Map;
   function Extract_Table (LHT : Length_Tables.Huffman_Table) return Boolean;
   --  Read one or more elements of Map starting from given Index from Input
   --  using LHT table. Return True and increment Index on success.
   --  If Input has not enought data return False and save some read data into
   --  Length to continue on next call.

   -------------------
   -- Extract_Table --
   -------------------

   function Extract_Table (LHT : Length_Tables.Huffman_Table) return Boolean is
      use type Bit_Streams.Bits;
      use type Value_Tables.Encoded_Element;
      Ok   : Boolean;
      Raw  : Bit_Streams.Bits := 0;
      Last : Value_Tables.Encoded_Element;
   begin
      if Length = 0 and then not LHT.Read (Input, Length) then
--         Length := 0;
         return False;
      end if;

      --  Read extra bits if needed
      if Length in Direct_Length_Code then
        Ok := True;
      elsif Length in Copy_Length_Code then
        Ok := Input.Read (Count => 2, Value => Raw);
      elsif Length in Zero_Length_Code then
        Ok := Input.Read (Count => 3, Value => Raw);
      elsif Length in Long_Zero_Length_Code then
        Ok := Input.Read (Count => 7, Value => Raw);
      end if;

      if not Ok then
         return False;
      end if;

      --  Compute Map's element(s)
      if Length in Direct_Length_Code then
         Map (Index) := Value_Tables.Length (Length);
         Index := Index + 1;
      elsif Length in Copy_Length_Code then
         Last := Index + Value_Tables.Encoded_Element (2 + Raw);
         Map (Index .. Last) := (others => Map (Index - 1));
         Index := Last + 1;
      elsif Length in Zero_Length_Code then
        Last := Index + Value_Tables.Encoded_Element(2 + Raw);
        Map (Index .. Last) := (others => 0);
        Index := Last + 1;
      elsif Length in Long_Zero_Length_Code then
        Last := Index + Value_Tables.Encoded_Element (10 + Raw);
        Map (Index .. Last) := (others => 0);
        Index := Last + 1;
      end if;

      Length := 0;
      return True;
   end Extract_Table;

   -----------
   -- Flush --
   -----------

   overriding procedure Flush
     (Self   : in out Filter;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector)
   is
      pragma Unreferenced (Output);
   begin
      if not Self.Last_Block then
         raise Constraint_Error with "Unexpected end of input";
      end if;
   end Flush;

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

   ----------
   -- Read --
   ----------

   overriding procedure Read
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector)
   is
      use type Bit_Streams.Bits;
      use type Bit_Streams.Bit_Count;
      --  This function encodes control structures as a lot of goto statements
      --  to be able to cancel execution in case of lack of input and resume
      --  it latter.

      Length_Order : constant array (Length_Code) of Length_Code :=
        (16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15);
      --  Order of length code sequence inside stream

      function Extract_Literal_Table is new Extract_Table
        (Value_Tables => Literal_Tables,
         Input        => Self.Input,
         Length       => Self.Next_Length_Code,
         Index        => Self.Next_Literal,
         Map          => Self.Literal_Length);

      function Extract_Distance_Table is new Extract_Table
        (Value_Tables => Distance_Tables,
         Input        => Self.Input,
         Length       => Self.Next_Length_Code,
         Index        => Self.Next_Distance,
         Map          => Self.Distance_Length);

      procedure Copy_Cycle_Buffer
        (Cycle    : in out Cycle_Buffer;
         Index    : in out Cycle_Index;
         Length   : Cycle_Index;
         Distance : Cycle_Index) is
      begin
         if Length > Distance  or else
           Distance > Index or else
           Length - 1 >= Cycle'Last - Index
         then  --  Slow copy
            for i in 1 .. Length loop
               Cycle (Index) := Cycle (Index - Distance);
               Output.Append (Cycle (Index));
               Index := Index + 1;
            end loop;
         else  --  Fast copy
            declare
               Last : constant Cycle_Index := Index + Length - 1;
            begin
               Cycle (Index .. Last) :=
                 Cycle (Index - Distance .. Last - Distance);
               Output.Append
                 (Ada.Streams.Stream_Element_Array (Cycle (Index .. Last)));
               Index := Last + 1;
            end;
         end if;
      end Copy_Cycle_Buffer;

      Value    : Bit_Streams.Bits := 0;
      Distance : Cycle_Index;

   begin
      Self.Input.Append (Input);

      --  If previous processing canceled due to lack of input then continue
      --  from interrupted stage
      case Self.Last_Stage is
         when Read_Block =>
            goto Read_Block_Label;
         when Dynamic_Huffman_Block =>
            goto Dynamic_Huffman_Block_Label;
         when Read_Length_Codes =>
            goto Read_Length_Codes_Label;
         when Read_Literal_Codes =>
            goto Read_Literal_Codes_Label;
         when Read_Distance_Codes =>
            goto Read_Distance_Codes_Label;
         when Read_Literal =>
            goto Read_Literal_Label;
         when Read_Length_Extra =>
            goto Read_Length_Extra_Label;
         when Read_Distance =>
            goto Read_Distance_Label;
         when Read_Distance_Extra =>
            goto Read_Distance_Extra_Label;
         when Read_Fixed_Literal =>
            goto Read_Fixed_Literal_Label;
         when Read_Fixed_Length_Extra =>
            goto Read_Fixed_Length_Extra_Label;
         when Read_Fixed_Distance =>
            goto Read_Fixed_Distance_Label;
         when Read_Fixed_Distance_Extra =>
            goto Read_Fixed_Distance_Extra_Label;
      end case;

      <<Read_Block_Label>>
      if not Self.Input.Has_Bits (3) then
         Self.Last_Stage := Read_Block;
         return;
      end if;
      Self.Input.Read (Count => 1, Value => Value);
      Self.Last_Block := Boolean'Val (Value);
      Self.Input.Read (Count => 2, Value => Value);
      Self.Block_Kind := Unpack.Block_Kind'Val (Value);

      case Self.Block_Kind is
         when Dynamic_Huffman_Block =>
            null;  --  goto Dynamic_Huffman_Block_Label;
         when Fixed_Huffman_Block =>
            goto Read_Fixed_Literal_Label;
         when others =>
            raise Constraint_Error with "Not implemented";
      end case;

      <<Dynamic_Huffman_Block_Label>>
      if not Self.Input.Has_Bits (5 + 5 + 4) then
         Self.Last_Stage := Dynamic_Huffman_Block;
         return;
      end if;

      Self.Input.Read (Count => 5, Value => Value);
      Self.Max_Literal := Literal (Value + 256);
      Self.Input.Read (Count => 5, Value => Value);
      Self.Max_Distance := Distance_Code (Value);
      Self.Input.Read (Count => 4, Value => Value);
      Self.Max_Length_Code := Length_Code (Value + 3);
      Self.Next_Length_Code := 0;

      <<Read_Length_Codes_Label>>
      while Self.Next_Length_Code <= Self.Max_Length_Code loop
         if not Self.Input.Read (Count => 3, Value => Value) then
            Self.Last_Stage := Read_Length_Codes;
            return;
         end if;

         Self.Length_Codes (Length_Order (Self.Next_Length_Code)) :=
           Length_Tables.Length (Value);

         Self.Next_Length_Code := Self.Next_Length_Code + 1;
      end loop;

      Self.Length_Table.Initialize (Self.Length_Codes);
      Self.Next_Length_Code := 0;
      Self.Next_Literal := 0;

      <<Read_Literal_Codes_Label>>
      while Self.Next_Literal <= Self.Max_Literal loop
         if not Extract_Literal_Table (Self.Length_Table) then
            Self.Last_Stage := Read_Literal_Codes;
            return;
         end if;
      end loop;

      Self.Literal_Table.Initialize (Self.Literal_Length);
      Self.Next_Length_Code := 0;
      Self.Next_Distance := 0;

      <<Read_Distance_Codes_Label>>
      while Self.Next_Distance <= Self.Max_Distance loop
         if not Extract_Distance_Table (Self.Length_Table) then
            Self.Last_Stage := Read_Distance_Codes;
            return;
         end if;
      end loop;

      Self.Distance_Table.Initialize (Self.Distance_Length);

      <<Read_Literal_Label>>
      if not Self.Literal_Table.Read (Self.Input, Self.Next_Literal) then
         Self.Last_Stage := Read_Literal;
         return;
      end if;

      case Self.Next_Literal is
         when Literal_Range =>
            Self.Buffer (Self.Index) :=
              Ada.Streams.Stream_Element (Self.Next_Literal);
            Output.Append (Self.Buffer (Self.Index));
            Self.Index := Self.Index + 1;
            goto Read_Literal_Label;

         when End_Of_Block =>
            if Self.Last_Block then
               return;
            else
               goto Read_Block_Label;
            end if;

         when 286 .. 287 =>
            raise Constraint_Error with "Unexpected data in stream";

         when Length_Range =>
            null;
      end case;

      <<Read_Length_Extra_Label>>
      if not Self.Input.Read
        (Count => Length_Codes (Self.Next_Literal).Extra_Bits,
         Value => Value)
      then
         Self.Last_Stage := Read_Length_Extra;
         return;
      end if;

      Self.Length := Length_Codes (Self.Next_Literal).Base_Length
        + Cycle_Index (Value);

      <<Read_Distance_Label>>
      if not Self.Distance_Table.Read (Self.Input, Self.Next_Distance) then
         Self.Last_Stage := Read_Distance;
         return;
      end if;

      <<Read_Distance_Extra_Label>>
      if not Self.Input.Read
        (Count => Distance_Codes (Self.Next_Distance).Extra_Bits,
         Value => Value)
      then
         Self.Last_Stage := Read_Distance_Extra;
         return;
      end if;

      Distance := Distance_Codes (Self.Next_Distance).Base_Length
        + Cycle_Index (Value);

      Copy_Cycle_Buffer (Self.Buffer, Self.Index, Self.Length, Distance);

      goto Read_Literal_Label;

      --  This is copy-paste of dynamic code, the difference is fixed tables
      --  are used instead of dynamic

      <<Read_Fixed_Literal_Label>>
      if not Fixed_Literal_Table.Read (Self.Input, Self.Next_Literal) then
         Self.Last_Stage := Read_Fixed_Literal;
         return;
      end if;

      case Self.Next_Literal is
         when Literal_Range =>
            Self.Buffer (Self.Index) :=
              Ada.Streams.Stream_Element (Self.Next_Literal);
            Output.Append (Self.Buffer (Self.Index));
            Self.Index := Self.Index + 1;
            goto Read_Fixed_Literal_Label;

         when End_Of_Block =>
            if Self.Last_Block then
               return;
            else
               goto Read_Block_Label;
            end if;

         when 286 .. 287 =>
            raise Constraint_Error with "Unexpected data in stream";

         when Length_Range =>
            null;
      end case;

      <<Read_Fixed_Length_Extra_Label>>
      if not Self.Input.Read
        (Count => Length_Codes (Self.Next_Literal).Extra_Bits,
         Value => Value)
      then
         Self.Last_Stage := Read_Fixed_Length_Extra;
         return;
      end if;

      Self.Length := Length_Codes (Self.Next_Literal).Base_Length
        + Cycle_Index (Value);

      <<Read_Fixed_Distance_Label>>
      if not Fixed_Distance_Table.Read (Self.Input, Self.Next_Distance) then
         Self.Last_Stage := Read_Fixed_Distance;
         return;
      end if;

      <<Read_Fixed_Distance_Extra_Label>>
      if not Self.Input.Read
        (Count => Distance_Codes (Self.Next_Distance).Extra_Bits,
         Value => Value)
      then
         Self.Last_Stage := Read_Fixed_Distance_Extra;
         return;
      end if;

      Distance := Distance_Codes (Self.Next_Distance).Base_Length
        + Cycle_Index (Value);

      Copy_Cycle_Buffer (Self.Buffer, Self.Index, Self.Length, Distance);

      goto Read_Fixed_Literal_Label;

   end Read;

end Matreshka.Filters.Deflate.Unpack;
