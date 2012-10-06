------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2012, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Ada.Wide_Wide_Text_IO;

with League.Strings;
with XML.SAX.Attributes;
with XML.SAX.Pretty_Writers;

package body WSDL.Debug is

   WSDL_Namespace_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://www.w3.org/ns/wsdl");

   Description_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("description");
   Interface_Element     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("interface");

   Name_Attribute             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("name");
   Target_Namespace_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("targetNamespace");

   ----------
   -- Dump --
   ----------

   procedure Dump (Description : WSDL.AST.Descriptions.Description_Access) is
      Attributes : XML.SAX.Attributes.SAX_Attributes;
      Writer     : XML.SAX.Pretty_Writers.SAX_Pretty_Writer;

   begin
      Writer.Set_Offset (2);
      Writer.Start_Document;
      Writer.Start_Prefix_Mapping
       (League.Strings.To_Universal_String ("wsdl"), WSDL_Namespace_URI);
      Attributes.Set_Value
       (Target_Namespace_Attribute, Description.Target_Namespace);
      Writer.Start_Element
       (WSDL_Namespace_URI, Description_Element, Attributes);

      for J of Description.Interfaces loop
         Attributes.Clear;
         Attributes.Set_Value (Name_Attribute, J.Local_Name);
         Writer.Start_Element
          (WSDL_Namespace_URI, Interface_Element, Attributes);
         Writer.End_Element (WSDL_Namespace_URI, Interface_Element);
      end loop;

      Writer.End_Element (WSDL_Namespace_URI, Description_Element);
      Writer.End_Document;

      Ada.Wide_Wide_Text_IO.Put_Line (Writer.Text.To_Wide_Wide_String);
   end Dump;

end WSDL.Debug;
