------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
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

package body Matreshka.Unbounded_Naturals is

   procedure Add
     (Left   : Number;
      Right  : Number;
      Result : out Number;
      Last   : out Natural;
      Mult   : Digit := 1;
      Carry  : out Digit) with Inline;

   procedure Add
     (Left   : Number;
      Right  : Number;
      Result : out Number;
      Last   : out Natural;
      Mult   : Digit) with Inline;

   procedure Subtract
     (Left   : Number;
      Right  : Number;
      Result : out Number;
      Last   : out Natural;
      Mult   : Digit := 1;
      Carry  : out Digit) with Inline;

   function Get_Last (Text : Number) return Natural;

   ---------
   -- Add --
   ---------

   procedure Add
     (Left   : Number;
      Right  : Number;
      Result : out Number;
      Last   : out Natural;
      Mult   : Digit := 1;
      Carry  : out Digit)
   is
      Temp  : Double;
      Max   : constant Natural := Natural'Max (Left'Length, Right'Length);
   begin
      if Max > Result'Length then
         raise Constraint_Error;
      end if;

      Carry := 0;

      for Offset in 0 .. Max - 1 loop
         if Right'First + Offset in Right'Range then
            Temp := Double (Right (Right'First + Offset)) * Double (Mult);
         else
            Temp := 0;
         end if;

         if Left'First + Offset in Left'Range then
            Temp := Double (Left (Left'First + Offset)) + Temp;
         end if;

         Temp := Temp + Double (Carry);
         Result (Result'First + Offset) := Digit (Temp mod Digit'Modulus);
         Carry := Digit (Temp / Digit'Modulus);
      end loop;

      Last := Result'First + Max - 1;
   end Add;

   ---------
   -- Add --
   ---------

   procedure Add
     (Left   : Number;
      Right  : Number;
      Result : out Number;
      Last   : out Natural;
      Mult   : Digit)
   is
      Carry : Digit;
   begin
      Add (Left, Right, Result, Last, Mult, Carry);

      if Carry /= 0 then
         if Last >= Result'Last then
            raise Constraint_Error;
         end if;

         Last := Last + 1;
         Result (Last) := Carry;
      end if;
   end Add;

   ---------
   -- Add --
   ---------

   procedure Add
     (Left   : Number;
      Right  : Number;
      Result : out Number;
      Last   : out Natural) is
   begin
      Add (Left, Right, Result, Last, 1);
   end Add;


   ------------
   -- Devide --
   ------------

   procedure Devide
     (Left   : in out Number;
      Right  : Number;
      Result : out Digit)
   is
      function Get_Digit (Left, Right : Number) return Digit;

      function Merge (High, Low : Digit) return Double;

      function Merge (High, Low : Digit) return Double is
      begin
         return Double (High) * Digit'Modulus + Double (Low);
      end Merge;

      function Get_Digit (Left, Right : Number) return Digit is
         Temp   : Double;
         Result : Double;
      begin
         if Left (Left'Last) = Right (Right'Last) then
            Result := Double (Digit'Last);
         else
            Result := Merge (Left (Left'Last), Left (Left'Last - 1));
            Result := Result / Double (Right (Right'Last));
         end if;

         loop
            Temp := Merge (Left (Left'Last), Left (Left'Last - 1));
            Temp := Temp - Result * Double (Right (Right'Last));
            exit when Temp >= Digit'Modulus;

            Temp := Merge (Digit (Temp), Left (Left'Last - 2));
            exit when Result * Double (Right (Right'Last - 1)) <= Temp;

            Result := Result - 1;
         end loop;

         return Digit (Result);
      end Get_Digit;

      Carry : Digit;
      Last  : Natural;
   begin
      Result := Get_Digit (Left, Right);

      Subtract
        (Left   => Left,
         Right  => Right,
         Result => Left,
         Last   => Last,
         Mult   => Result,
         Carry  => Carry);

      if Carry /= 0 then
         Result := Result - 1;

         Add
           (Left   => Left,
            Right  => Right,
            Result => Left,
            Last   => Last);
      end if;
   end Devide;

   -----------------
   -- Fast_Devide --
   -----------------

   procedure Fast_Devide
     (Left   : Number;
      Right  : Digit;
      Result : out Number;
      Last   : out Natural;
      Rest   : out Digit)
   is
      Temp   : Double := 0;
   begin
      for J in reverse Left'Range loop
         Temp := Temp * Digit'Modulus + Double (Left (J));
         Result (J) := Digit (Temp / Double (Right));
         Temp := Temp mod Double (Right);
      end loop;

      Rest := Digit (Temp);
      Last := Get_Last (Result);
   end Fast_Devide;

   -----------------
   -- Fit_Integer --
   -----------------

   function Fit_Integer
     (Left     : Number;
      Negative : Boolean) return Boolean is
   begin
      if Left'Length = 0 then
         return True;
      elsif Left'Length = 1 then
         if Negative then
            return Left (1) <= Digit (Integer'Last) + 1;
         else
            return Left (1) <= Digit (Integer'Last);
         end if;
      else
         return False;
      end if;
   end Fit_Integer;

   ----------------
   -- To_Integer --
   ----------------

   function To_Integer
     (Left     : Number;
      Negative : Boolean) return Integer is
   begin
      if Left'Length = 0 then
         return 0;
      elsif Left'Length = 1 then
         if Negative then
            return -Integer (Left (1) - 1) - 1;
         else
            return Integer (Left (1));
         end if;
      else
         raise Constraint_Error;
      end if;
   end To_Integer;

   --------------
   -- Get_Last --
   --------------

   function Get_Last (Text : Number) return Natural is
   begin
      for J in reverse Text'Range loop
         if Text (J) /= 0 then
            return J;
         end if;
      end loop;

      return Text'First - 1;
   end Get_Last;

   -----------
   -- Image --
   -----------

   procedure Append_Image
     (Result : in out League.Strings.Universal_String;
      Left   : in out Number;
      Base   : Digit := 10)
   is
      function Length return Natural;
      --  Maximum result length

      ------------
      -- Length --
      ------------

      function Length return Natural is
         Bits : constant Natural := Left'Length * Digit'Size;
      begin
         case Base is
            when 2 .. 3 =>
               return Bits;
            when 4 .. 7 =>
               return Bits / 2;
            when 8 .. 15 =>
               return Bits / 3;
            when 16 =>
               return Bits / 4;
            when others =>
               raise Constraint_Error;
         end case;
      end Length;

      Index : Natural := Left'Last;
      Char  : Wide_Wide_Character;
      Text  : Wide_Wide_String (1 .. Length);
      First : Positive := Text'Last + 1;
      Rest  : Digit;
   begin
      if Left'Length = 0 then
         Result.Append ("0");
         return;
      end if;

      while Index >= Left'First loop
         Fast_Devide
           (Left   => Left (Left'First .. Index),
            Right  => Base,
            Result => Left (Left'First .. Index),
            Last   => Index,
            Rest   => Rest);

         case Rest is
            when 0 .. 9 =>
               Char := Wide_Wide_Character'Val
                 (Rest + Wide_Wide_Character'Pos ('0'));
            when 10 .. 15 =>
               Char := Wide_Wide_Character'Val
                 (Rest + Wide_Wide_Character'Pos ('a') - 10);
            when others =>
               raise Constraint_Error;
         end case;

         First := First - 1;
         Text (First) := Char;
      end loop;

      Result.Append (Text (First .. Text'Last));
   end Append_Image;

   ----------
   -- Less --
   ----------

   function Less (Left, Right  : Number) return Boolean is
   begin
      if Left'Length /= Right'Length then
         return Left'Length < Right'Length;
      end if;

      for J in reverse Left'Range loop
         if Left (J) < Right (J) then
            return True;
         elsif Left (J) > Right (J) then
            return False;
         end if;
      end loop;

      return False;
   end Less;

   --------------
   -- Multiply --
   --------------

   procedure Multiply
     (Left   : Number;
      Right  : Number;
      Result : in out Number;
      Last   : out Natural)
   is
      Temp   : Digit;
      Length : Natural := Result'First - 1;
      Mult   : Number (Result'Range);
   begin
      for J in Left'Range loop
         Temp := Left (J);
         Mult (J .. J + Right'Length - 1) := Right;
         Mult (Mult'First .. J - 1) := (others => 0);

         Add
           (Left   => Result (Result'First .. Length),
            Right  => Mult (Mult'First .. J + Right'Length - 1),
            Result => Result,
            Last   => Length,
            Mult   => Temp);
      end loop;

      Last := Length;
   end Multiply;

   --------------------------
   -- Normalize_For_Devide --
   --------------------------

   procedure Normalize_For_Devide
     (Left   : in out Number;
      Right  : in out Number;
      Mult   : out Digit)
   is
      Zero  : constant Number (1 .. 0) := (1 .. 0 => 0);
      Last  : Natural;
   begin
      Mult := Digit (Digit'Modulus / (Double (Right (Right'Last)) + 1));

      if Mult /= 1 then
         Add
           (Left   => Zero,
            Right  => Left,
            Result => Left,
            Last   => Last,
            Mult   => Mult);

         Add
           (Left   => Zero,
            Right  => Right,
            Result => Right,
            Last   => Last,
            Mult   => Mult);
      end if;
   end Normalize_For_Devide;

   --------------
   -- Subtract --
   --------------

   procedure Subtract
     (Left   : Number;
      Right  : Number;
      Result : out Number;
      Last   : out Natural;
      Mult   : Digit := 1;
      Carry  : out Digit)
   is
      Temp  : Double;
      Max   : constant Natural := Natural'Max (Left'Length, Right'Length);
   begin
      if Max > Result'Length then
         raise Constraint_Error;
      end if;

      Carry := 0;

      for Offset in 0 .. Max - 1 loop
         if Right'First + Offset in Right'Range then
            Temp := Double (Right (Right'First + Offset)) * Double (Mult);
         else
            Temp := 0;
         end if;

         if Left'First + Offset in Left'Range then
            Temp := Double (Left (Left'First + Offset)) - Temp;
         else
            Temp := -Temp;
         end if;

         Temp := Temp - Double (Carry);
         Result (Result'First + Offset) := Digit (Temp mod Digit'Modulus);
         Carry := -Digit (Temp / Digit'Modulus);
      end loop;

      Last := Result'First + Max - 1;
   end Subtract;

   --------------
   -- Subtract --
   --------------

   procedure Subtract
     (Left   : Number;
      Right  : Number;
      Result : out Number;
      Last   : out Natural)
   is
      Carry : Digit;
   begin
      Subtract (Left, Right, Result, Last, 1, Carry);

      if Carry /= 0 then
         if Last >= Result'Last then
            raise Constraint_Error;
         end if;

         Last := Last + 1;
         Result (Last) := -Carry;
      end if;
   end Subtract;

   -----------
   -- Value --
   -----------

   procedure Value
     (Text   : League.Strings.Universal_String;
      Result : out Number;
      Last   : out Natural;
      Base   : Digit := 10)
   is
      subtype Char is Wide_Wide_Character;
      Left  : Number (1 .. 1);
      Temp  : Char;
      Stop  : Natural := Result'First - 1;
      Skip  : Boolean := False;
   begin
      Result (Result'First) := 0;

      for J in 1 .. Text.Length loop
         Temp := Text.Element (J).To_Wide_Wide_Character;

         case Temp is
            when '0' .. '9' =>
               Left (1) := Digit (Char'Pos (Temp) - Char'Pos ('0'));
            when 'a' .. 'f' =>
               Left (1) := Digit (Char'Pos (Temp) - Char'Pos ('a') + 10);
            when 'A' .. 'F' =>
               Left (1) := Digit (Char'Pos (Temp) - Char'Pos ('A') + 10);
            when others =>
               Skip := True;
         end case;

         if Skip then
            Skip := False;
         else
            Add (Left,
                 Result (Result'First .. Stop),
                 Result,
                 Stop,
                 Base);
         end if;
      end loop;
      Last := Stop;
   end Value;

end Matreshka.Unbounded_Naturals;
