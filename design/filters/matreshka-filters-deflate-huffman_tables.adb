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

with Interfaces;

package body Matreshka.Filters.Deflate.Huffman_Tables is

   type Shiftable is new Interfaces.Unsigned_32;

   function Reverse_Bits
     (Value  : Bits;
      Length : Bit_Streams.Bit_Count) return Bits;
   pragma Inline (Reverse_Bits);

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
     (Self : in out Huffman_Table;
      Map  : Length_Map)
   is
      use type Length;

      type Codes is array (Length) of Bits;

      Min_Len    : Bit_Streams.Bit_Count := Length'Last;
      Max_Len    : Bit_Streams.Bit_Count := Length'First;
      Next_Code  : Bits := 0;
      Step       : Bits;
      Count      : Shiftable;
      Len        : Bit_Streams.Bit_Count;
      Counts     : Codes;
      Min_Codes  : Codes;

   begin
      Find_Max_Max_Length:
         for J in Map'Range loop
            if Map (J) > 0 then
               if Map (J) > Max_Len then
                  Max_Len := Map (J);
               end if;

               if Map (J) < Min_Len then
                  Min_Len := Map (J);
               end if;
            end if;
         end loop Find_Max_Max_Length;

      Self.Max_Length := Max_Len;
      Self.Mask := 2 ** Natural (Max_Len) - 1;

      Counts (Min_Len .. Max_Len) := (others => 0);

      Calculate_Counts :
         for J in Map'Range loop
            if Map (J) /= 0 then
               Counts (Map (J)) := Counts (Map (J)) + 1;
            end if;
         end loop Calculate_Counts;

      Min_Codes (Min_Len) := 0;

      Calculate_Min_Codes :
         for J in Min_Len .. Max_Len - 1 loop
            Min_Codes (J + 1) := (Min_Codes (J) + Counts (J)) * 2;
         end loop Calculate_Min_Codes;

      Set_Values :
         for K in Map'Range loop
            Len := Map (K);
            if Len /= 0 then
               Next_Code := Reverse_Bits (Min_Codes (Len), Len);
               Min_Codes (Len) := Min_Codes (Len) + 1;
               Count := Shift_Left (1, Natural (Len));
               Step  := Bits (Count);
               Count := Shift_Left (1, Natural (Max_Len - Len));

               for J in 1 .. Count loop
                  Self.Values (Next_Code) := K;
                  Next_Code := Next_Code + Step;
               end loop;
            end if;
         end loop Set_Values;

      Self.Length := Map;
   end Initialize;

   ----------
   -- Read --
   ----------

   function Read
     (Self  : Huffman_Table;
      Input : in out Matreshka.Filters.Deflate.Bit_Streams.Bit_Stream;
      Value : in out Encoded_Element)
      return Boolean
   is
      use type Bit_Streams.Bit_Count;

      Result : Encoded_Element;
      Raw    : Bits := 0;
      Got    : Bit_Streams.Bit_Count := 0;
   begin
      Input.Read_Ahead
        (Count => Self.Max_Length,
         Got   => Got,
         Value => Raw);

      Result := Self.Values (Raw);

      if Self.Length (Result) <= Got then
         Input.Skip (Self.Length (Result));
         Value := Result;
         return True;
      else
         return False;
      end if;
   end Read;

   ------------------
   -- Reverse_Bits --
   ------------------

   function Reverse_Bits
     (Value  : Bits;
      Length : Bit_Streams.Bit_Count) return Bits
   is
      Result  : Shiftable := 0;
      Current : Shiftable := Shiftable (Value);
   begin
      for I in 1 .. Length loop
         Result  := Shift_Left  (Result, 1) or (Current and 1);
         Current := Shift_Right (Current, 1);
      end loop;

      return Bits (Result);
   end Reverse_Bits;

end Matreshka.Filters.Deflate.Huffman_Tables;
