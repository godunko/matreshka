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
with XSD_To_Ada.Utils;

package body XSD_To_Ada.Mappings is

   -----------------------------
   -- Ada_Type_Qualified_Name --
   -----------------------------

   function Ada_Type_Qualified_Name
    (Self          : Mapping'Class;
     XSD_Type_Name : League.Strings.Universal_String;
     Min_Occur     : Boolean;
     Max_Occur     : Boolean) return League.Strings.Universal_String is
   begin
      if Self.Mapping.Contains (XSD_Type_Name) then
         return Self.Mapping.Element (XSD_Type_Name).Ada_Name;

      else
         return
           League.Strings.To_Universal_String
            ("Payloads." & XSD_To_Ada.Utils.Add_Separator (XSD_Type_Name));
      end if;
   end Ada_Type_Qualified_Name;

   --------------------
   -- Is_Type_In_Map --
   --------------------

   function Is_Type_In_Map
    (Self          : Mapping'Class;
     XSD_Type_Name : League.Strings.Universal_String) return Boolean is
   begin
      return Self.Mapping.Contains (XSD_Type_Name);
   end Is_Type_In_Map;

end XSD_To_Ada.Mappings;
