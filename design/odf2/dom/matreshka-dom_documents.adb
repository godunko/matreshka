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
-- Copyright © 2014, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Matreshka.DOM_Attributes;
with Matreshka.DOM_Elements;

package body Matreshka.DOM_Documents is

   -------------------------
   -- Create_Attribute_NS --
   -------------------------

   overriding function Create_Attribute_NS
    (Self           : not null access Document_Node;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return not null XML.DOM.Attributes.DOM_Attribute_Access
   is
      Node : constant not null Matreshka.DOM_Nodes.Node_Access
        := new Matreshka.DOM_Attributes.Attribute_L2_Node;

   begin
      Matreshka.DOM_Attributes.Constructors.Initialize
       (Matreshka.DOM_Attributes.Attribute_L2_Node'Class (Node.all)'Access,
        Self);

      return XML.DOM.Attributes.DOM_Attribute_Access (Node);
   end Create_Attribute_NS;

   -----------------------
   -- Create_Element_NS --
   -----------------------

   overriding function Create_Element_NS
    (Self           : not null access Document_Node;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return not null XML.DOM.Elements.DOM_Element_Access
   is
      Node : constant not null Matreshka.DOM_Nodes.Node_Access
        := new Matreshka.DOM_Elements.Element_Node;

   begin
      Matreshka.DOM_Elements.Constructors.Initialize
       (Matreshka.DOM_Elements.Element_Node'Class (Node.all)'Access, Self);

      return XML.DOM.Elements.DOM_Element_Access (Node);
   end Create_Element_NS;

   ----------------------
   -- Create_Text_Node --
   ----------------------

   overriding function Create_Text_Node
    (Self : not null access Document_Node;
     Data : League.Strings.Universal_String)
       return not null XML.DOM.Texts.DOM_Text_Access is
   begin
      raise Program_Error;
      return null;
   end Create_Text_Node;

   ----------------
   -- Enter_Node --
   ----------------

   overriding procedure Enter_Node
    (Self    : not null access Document_Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Visitor.Enter_Document
       (XML.DOM.Documents.DOM_Document_Access (Self), Control);
   end Enter_Node;

   -------------------
   -- Get_Node_Name --
   -------------------

   overriding function Get_Node_Name
    (Self : not null access constant Document_Node)
       return League.Strings.Universal_String
   is
      pragma Unreferenced (Self);

   begin
      return League.Strings.To_Universal_String ("#document");
   end Get_Node_Name;

   -------------------
   -- Get_Node_Type --
   -------------------

   overriding function Get_Node_Type
    (Self : not null access constant Document_Node)
       return XML.DOM.Node_Type
   is
      pragma Unreferenced (Self);

   begin
      return XML.DOM.Document_Node;
   end Get_Node_Type;

   ----------------
   -- Leave_Node --
   ----------------

   overriding procedure Leave_Node
    (Self    : not null access Document_Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Visitor.Leave_Document
       (XML.DOM.Documents.DOM_Document_Access (Self), Control);
   end Leave_Node;

   ----------------
   -- Visit_Node --
   ----------------

   overriding procedure Visit_Node
    (Self     : not null access Document_Node;
     Iterator : in out XML.DOM.Visitors.Abstract_Iterator'Class;
     Visitor  : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control  : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Iterator.Visit_Document
       (Visitor, XML.DOM.Documents.DOM_Document_Access (Self), Control);
   end Visit_Node;

end Matreshka.DOM_Documents;
