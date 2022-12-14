------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2013-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
with League.Strings.Hash;

with XSD_To_Ada.Utils;

package body XSD_To_Ada.Mappings is

   use type League.Strings.Universal_String;

   -----------------------------
   -- Ada_Type_Qualified_Name --
   -----------------------------

   function Ada_Type_Qualified_Name
     (Self             : Mapping'Class;
      XSD_Type_Name    : League.Strings.Universal_String;
      Min_Occurs       : Boolean := False;
      Max_Occurs       : Boolean := False)
      return League.Strings.Universal_String
   is
      K : Key := (XSD_Type_Name, Single);
   begin

      if Max_Occurs then
         K.Multiplicity := Vector;
      elsif Min_Occurs then
         K.Multiplicity := Optional;
      end if;

      if Self.Mapping.Contains (K) then
         return Self.Mapping.Element (K).Ada_Name;
      else
         if Max_Occurs then
            return "IATS_Types."
              & XSD_To_Ada.Utils.Add_Separator (XSD_Type_Name) & "_Vector";
         elsif Min_Occurs then
            return "IATS_Types.Optional_"
              & XSD_To_Ada.Utils.Add_Separator (XSD_Type_Name);
         else
            return "IATS_Types."
              & XSD_To_Ada.Utils.Add_Separator (XSD_Type_Name);
         end if;
      end if;
   end Ada_Type_Qualified_Name;

   ----------
   -- Hash --
   ----------

   function Hash (Value : Key) return Ada.Containers.Hash_Type is
      use type Ada.Containers.Hash_Type;
   begin
      return League.Strings.Hash (Value.Name) +
        Multiplicity_Kind'Pos (Value.Multiplicity);
   end Hash;

end XSD_To_Ada.Mappings;
