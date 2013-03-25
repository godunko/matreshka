------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
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
with Matreshka.XML.DOM_Nodes.Attributes;
with Matreshka.XML.DOM_Nodes.Elements;
with XML.DOM.Documents.Internals;
with XML.DOM.Visitors;

package body Matreshka.XML.DOM_Nodes.Documents is

   ----------------------
   -- Create_Attribute --
   ----------------------

   not overriding function Create_Attribute
    (Self           : not null access Abstract_Document;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return not null Matreshka.XML.DOM_Nodes.Attribute_Access is
   begin
      return Result :
        constant not null Matreshka.XML.DOM_Nodes.Attribute_Access
          := new Matreshka.XML.DOM_Nodes.Attributes.Attribute_V2_Node
      do
         declare
            Node : Matreshka.XML.DOM_Nodes.Attributes.Attribute_V2_Node
              renames Matreshka.XML.DOM_Nodes.Attributes.Attribute_V2_Node
                       (Result.all);

         begin
            Matreshka.XML.DOM_Nodes.Attributes.Initialize
             (Node'Access,
              Self,
              Namespace_URI,
              Qualified_Name);
         end;
      end return;
   end Create_Attribute;

   --------------------
   -- Create_Element --
   --------------------

   not overriding function Create_Element
    (Self           : not null access Abstract_Document;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return not null Matreshka.XML.DOM_Nodes.Element_Access is
   begin
      return Result :
        constant not null Matreshka.XML.DOM_Nodes.Element_Access
          := new Matreshka.XML.DOM_Nodes.Elements.Element_Node
      do
         declare
            Node : Matreshka.XML.DOM_Nodes.Elements.Element_Node
              renames Matreshka.XML.DOM_Nodes.Elements.Element_Node
                       (Result.all);

         begin
            Matreshka.XML.DOM_Nodes.Elements.Initialize
             (Node'Access,
              Self,
              Namespace_URI,
              Qualified_Name);
         end;
      end return;
   end Create_Element;

   -------------------
   -- Enter_Element --
   -------------------

   overriding procedure Enter_Element
    (Self    : not null access Abstract_Document;
     Visitor : in out Standard.XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out Standard.XML.DOM.Visitors.Traverse_Control) is
   begin
      Visitor.Enter_Document
       (Standard.XML.DOM.Documents.Internals.Create
         (Matreshka.XML.DOM_Nodes.Document_Access (Self)),
        Control);
   end Enter_Element;

   -------------------
   -- Leave_Element --
   -------------------

   overriding procedure Leave_Element
    (Self    : not null access Abstract_Document;
     Visitor : in out Standard.XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out Standard.XML.DOM.Visitors.Traverse_Control) is
   begin
      Visitor.Leave_Document
       (Standard.XML.DOM.Documents.Internals.Create
         (Matreshka.XML.DOM_Nodes.Document_Access (Self)),
        Control);
   end Leave_Element;

   -------------------
   -- Visit_Element --
   -------------------

   overriding procedure Visit_Element
    (Self     : not null access Abstract_Document;
     Iterator : in out Standard.XML.DOM.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Standard.XML.DOM.Visitors.Abstract_Visitor'Class;
     Control  : in out Standard.XML.DOM.Visitors.Traverse_Control) is
   begin
      Iterator.Visit_Document
       (Visitor,
        Standard.XML.DOM.Documents.Internals.Create
         (Matreshka.XML.DOM_Nodes.Document_Access (Self)),
        Control);
   end Visit_Element;

end Matreshka.XML.DOM_Nodes.Documents;
