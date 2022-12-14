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
-- Copyright © 2010-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
pragma Ada_2012;

private with Ada.Containers.Hashed_Maps;

with League.Strings;

package League.Environment_Variables is

   type Environment_Variable_Set is tagged private
     with Iterator_Element  => League.Strings.Universal_String,
          Constant_Indexing => Value;

   procedure Clear (Self : in out Environment_Variable_Set'Class);

   function Contains
    (Self : Environment_Variable_Set'Class;
     Name : League.Strings.Universal_String) return Boolean;

   procedure Insert
    (Self  : in out Environment_Variable_Set'Class;
     Name  : League.Strings.Universal_String;
     Value : League.Strings.Universal_String);

   procedure Remove
    (Self  : in out Environment_Variable_Set'Class;
     Name  : League.Strings.Universal_String);

   function Value
    (Self          : Environment_Variable_Set'Class;
     Name          : League.Strings.Universal_String;
     Default_Value : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String)
       return League.Strings.Universal_String;

   overriding function "="
    (Left  : Environment_Variable_Set;
     Right : Environment_Variable_Set) return Boolean;

private

   type Key_Type is new League.Strings.Universal_String with null record;

   function Hash (Item : Key_Type) return Ada.Containers.Hash_Type;

   package Universal_String_Maps is
     new Ada.Containers.Hashed_Maps
          (Key_Type,
           League.Strings.Universal_String,
           Hash,
           "=",
           League.Strings."=");

   type Environment_Variable_Set is tagged record
      Data : Universal_String_Maps.Map;
   end record;

end League.Environment_Variables;
