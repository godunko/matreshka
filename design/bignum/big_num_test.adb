------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
--                                                                          --
--                            Testsuite Component                           --
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

with League.Unbounded_Integers;
with League.Strings;

procedure Big_Num_Test is
   use type League.Strings.Universal_String;
   use type League.Unbounded_Integers.Unbounded_Integer;

   Left  : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("12345678901234567890");
   Right : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("45678901234567890123");
   L : constant League.Unbounded_Integers.Unbounded_Integer :=
     League.Unbounded_Integers.From_Universal_String (Left);
   R : constant League.Unbounded_Integers.Unbounded_Integer :=
     League.Unbounded_Integers.From_Universal_String (Right);
   V : constant League.Unbounded_Integers.Unbounded_Integer :=
     League.Unbounded_Integers.From_Integer (1_000_000_000);
begin
   if L = R then
      raise Constraint_Error;
   elsif L /= L then
      raise Constraint_Error;
   elsif R < L then
      raise Constraint_Error;
   elsif R <= L then
      raise Constraint_Error;
   elsif L > R then
      raise Constraint_Error;
   elsif L >= R then
      raise Constraint_Error;
   elsif League.Unbounded_Integers.To_Universal_String (-L) /=
     League.Strings.To_Universal_String ("-12345678901234567890")
   then
      raise Constraint_Error;
   elsif League.Unbounded_Integers.To_Universal_String (L + R) /=
     League.Strings.To_Universal_String ("58024580135802458013")
   then
      raise Constraint_Error;
   elsif League.Unbounded_Integers.To_Universal_String (R - L) /=
     League.Strings.To_Universal_String ("33333222333333322233")
   then
      raise Constraint_Error;
   elsif League.Unbounded_Integers.To_Universal_String (L - R) /=
     League.Strings.To_Universal_String ("-33333222333333322233")
   then
      raise Constraint_Error;
   elsif League.Unbounded_Integers.To_Universal_String (L * R) /=
     League.Strings.To_Universal_String
       ("563937047203182456423718379870903950470")
   then
      raise Constraint_Error;
   elsif League.Unbounded_Integers.To_Universal_String (R / L) /=
     League.Strings.To_Universal_String ("3")
   then
      raise Constraint_Error;
   elsif League.Unbounded_Integers.To_Universal_String (L / R) /=
     League.Strings.To_Universal_String ("0")
   then
      raise Constraint_Error;
   elsif League.Unbounded_Integers.To_Universal_String (R mod L) /=
     League.Strings.To_Universal_String ("8641864530864186453")
   then
      raise Constraint_Error;
   elsif L mod R /= L then
      raise Constraint_Error;
   elsif League.Unbounded_Integers.To_Universal_String ((L / V) ** 5) /=
     League.Strings.To_Universal_String
       ("286797186146124672141322529603829810439261970494501")
   then
      raise Constraint_Error;
   end if;
end Big_Num_Test;
