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
-- Copyright © 2010, Vadim Godunko <vgodunko@gmail.com>                     --
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

package body League.Environment_Variables is

   ---------
   -- "=" --
   ---------

   overriding function "="
    (Left  : Environment_Variable_Set;
     Right : Environment_Variable_Set) return Boolean
   is
      pragma Unreferenced (Left);
      pragma Unreferenced (Right);

   begin
      return False;
   end "=";

   -----------
   -- Clear --
   -----------

   procedure Clear (Self : in out Environment_Variable_Set'Class) is
   begin
      null;
   end Clear;

   --------------
   -- Contains --
   --------------

   function Contains
    (Self : Environment_Variable_Set'Class;
     Name : League.Strings.Universal_String) return Boolean
   is
      pragma Unreferenced (Self);
      pragma Unreferenced (Name);

   begin
      return False;
   end Contains;

   ------------
   -- Insert --
   ------------

   procedure Insert
    (Self  : in out Environment_Variable_Set'Class;
     Name  : League.Strings.Universal_String;
     Value : League.Strings.Universal_String) is
   begin
      null;
   end Insert;

   ------------
   -- Remove --
   ------------

   procedure Remove
    (Self  : in out Environment_Variable_Set'Class;
     Name  : League.Strings.Universal_String) is
   begin
      null;
   end Remove;

   -----------
   -- Value --
   -----------

   function Value
    (Self          : Environment_Variable_Set'Class;
     Name          : League.Strings.Universal_String;
     Default_Value : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String)
         return League.Strings.Universal_String
   is
      pragma Unreferenced (Self);
      pragma Unreferenced (Name);

   begin
      return Default_Value;
   end Value;

end League.Environment_Variables;
