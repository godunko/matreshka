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

with System;
with League.Strings;

package Matreshka.Unbounded_Naturals is
   pragma Preelaborate;
   pragma Remote_Types;

   type Double is mod System.Max_Binary_Modulus;
   --  This type is twice wider then Digit

   type Digit is mod 2 ** (Double'Size / 2);
   --  One digit in internal representation of Number

   type Number is array (Positive range <>) of Digit;
   --  Representation of unbounded natural

   procedure Value
     (Text   : League.Strings.Universal_String;
      Result : out Number;
      Last   : out Natural;
      Base   : Digit := 10);
   --  Convert Text into Result. Accept text as number with given Base.
   --  Result should have enough space.
   --  Last set to last used index in Result.

   procedure Append_Image
     (Result : in out League.Strings.Universal_String;
      Left   : in out Number;
      Base   : Digit := 10);
   --  Convert Left to string using given Base and append to Result

   function Less (Left, Right  : Number) return Boolean;
   --  Compare two numbers

   procedure Add
     (Left   : Number;
      Right  : Number;
      Result : out Number;
      Last   : out Natural);
   --  Result = Left + Right. Result should have enough space.
   --  Last set to last used index in Result.

   procedure Subtract
     (Left   : Number;
      Right  : Number;
      Result : out Number;
      Last   : out Natural);
   --  Result = Left - Right. Result should have enough space.
   --  Last set to last used index in Result.

   procedure Multiply
     (Left   : Number;
      Right  : Number;
      Result : in out Number;
      Last   : out Natural);
   --  Result = Left * Right. Result should have enough space.
   --  Last set to last used index in Result.

   procedure Fast_Devide
     (Left   : Number;
      Right  : Digit;
      Result : out Number;
      Last   : out Natural;
      Rest   : out Digit);
   --  Result = Left / Right and Rest = Left mod Right.
   --  Result should have enough space.
   --  Last set to last used index in Result.

   procedure Devide
     (Left   : in out Number;
      Right  : Number;
      Result : out Digit);
   --  Result = Left / Right.
   --  Left'Length should be Right'Length + 1

   procedure Normalize_For_Devide
     (Left   : in out Number;
      Right  : in out Number;
      Mult   : out Digit);

   function Fit_Integer
     (Left     : Number;
      Negative : Boolean) return Boolean;
   --  Check if Left in Integer'Range

   function To_Integer
     (Left     : Number;
      Negative : Boolean) return Integer;
   --  Convert Left to integer if Fit_Integer

end Matreshka.Unbounded_Naturals;
