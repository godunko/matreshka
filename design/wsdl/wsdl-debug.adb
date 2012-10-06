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

with WSDL.AST.Interfaces;
with WSDL.Iterators.Containment;
with WSDL.Visitors;

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

   type WSDL_Printer is
     limited new WSDL.Visitors.WSDL_Visitor with
   record
      Writer : XML.SAX.Pretty_Writers.SAX_Pretty_Writer;
   end record;

   overriding procedure Enter_Description
    (Self    : in out WSDL_Printer;
     Node    : not null WSDL.AST.Descriptions.Description_Access;
     Control : in out WSDL.Iterators.Traverse_Control);

   overriding procedure Leave_Description
    (Self    : in out WSDL_Printer;
     Node    : not null WSDL.AST.Descriptions.Description_Access;
     Control : in out WSDL.Iterators.Traverse_Control);

   overriding procedure Enter_Interface
    (Self    : in out WSDL_Printer;
     Node    : not null WSDL.AST.Interfaces.Interface_Access;
     Control : in out WSDL.Iterators.Traverse_Control);

   overriding procedure Leave_Interface
    (Self    : in out WSDL_Printer;
     Node    : not null WSDL.AST.Interfaces.Interface_Access;
     Control : in out WSDL.Iterators.Traverse_Control);

   ----------
   -- Dump --
   ----------

   procedure Dump (Description : WSDL.AST.Descriptions.Description_Access) is
      Printer  : WSDL_Printer;
      Iterator : WSDL.Iterators.Containment.Containment_Iterator;
      Control  : WSDL.Iterators.Traverse_Control := WSDL.Iterators.Continue;

   begin
      Iterator.Visit (Printer, WSDL.AST.Node_Access (Description), Control);
   end Dump;

   -----------------------
   -- Enter_Description --
   -----------------------

   overriding procedure Enter_Description
    (Self    : in out WSDL_Printer;
     Node    : not null WSDL.AST.Descriptions.Description_Access;
     Control : in out WSDL.Iterators.Traverse_Control)
   is
      Attributes : XML.SAX.Attributes.SAX_Attributes;

   begin
      Self.Writer.Set_Offset (2);
      Self.Writer.Start_Document;
      Self.Writer.Start_Prefix_Mapping
       (League.Strings.To_Universal_String ("wsdl"), WSDL_Namespace_URI);
      Attributes.Set_Value
       (Target_Namespace_Attribute, Node.Target_Namespace);
      Self.Writer.Start_Element
       (WSDL_Namespace_URI, Description_Element, Attributes);
   end Enter_Description;

   ---------------------
   -- Enter_Interface --
   ---------------------

   overriding procedure Enter_Interface
    (Self    : in out WSDL_Printer;
     Node    : not null WSDL.AST.Interfaces.Interface_Access;
     Control : in out WSDL.Iterators.Traverse_Control)
   is
      Attributes : XML.SAX.Attributes.SAX_Attributes;

   begin
      Attributes.Set_Value (Name_Attribute, Node.Local_Name);
      Self.Writer.Start_Element
       (WSDL_Namespace_URI, Interface_Element, Attributes);
   end Enter_Interface;

   -----------------------
   -- Leave_Description --
   -----------------------

   overriding procedure Leave_Description
    (Self    : in out WSDL_Printer;
     Node    : not null WSDL.AST.Descriptions.Description_Access;
     Control : in out WSDL.Iterators.Traverse_Control) is
   begin
      Self.Writer.End_Element (WSDL_Namespace_URI, Description_Element);
      Self.Writer.End_Document;

      Ada.Wide_Wide_Text_IO.Put_Line (Self.Writer.Text.To_Wide_Wide_String);
   end Leave_Description;

   ---------------------
   -- Leave_Interface --
   ---------------------

   overriding procedure Leave_Interface
    (Self    : in out WSDL_Printer;
     Node    : not null WSDL.AST.Interfaces.Interface_Access;
     Control : in out WSDL.Iterators.Traverse_Control) is
   begin
      Self.Writer.End_Element (WSDL_Namespace_URI, Interface_Element);
   end Leave_Interface;

end WSDL.Debug;
