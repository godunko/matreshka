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
-- Copyright © 2012-2013, Vadim Godunko <vgodunko@gmail.com>                --
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

package Matreshka.DOM_Nodes.Documents is

   pragma Preelaborate;

   -----------------------
   -- Abstract_Document --
   -----------------------

   type Abstract_Document is
     abstract new Matreshka.DOM_Nodes.Abstract_Node with record
      First_Detached : Matreshka.DOM_Nodes.Node_Access;
      Last_Detached  : Matreshka.DOM_Nodes.Node_Access;
      --  List of nodes which is not direct or indirect children of root node
      --  of document or document's document type node. All created nodes are
      --  added to this list.
   end record;

   not overriding function Create_Attribute
    (Self           : not null access Abstract_Document;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return not null Matreshka.DOM_Nodes.Attribute_Access;

   not overriding function Create_Element
    (Self           : not null access Abstract_Document;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return not null Matreshka.DOM_Nodes.Element_Access;

   not overriding function Create_Text
    (Self : not null access Abstract_Document;
     Data : League.Strings.Universal_String)
       return not null Matreshka.DOM_Nodes.Text_Access;

   overriding procedure Enter_Element
    (Self    : not null access Abstract_Document;
     Visitor : in out Standard.XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out Standard.XML.DOM.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Leave_Element
    (Self    : not null access Abstract_Document;
     Visitor : in out Standard.XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out Standard.XML.DOM.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Visit_Element
    (Self     : not null access Abstract_Document;
     Iterator : in out Standard.XML.DOM.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Standard.XML.DOM.Visitors.Abstract_Visitor'Class;
     Control  : in out Standard.XML.DOM.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

   type Document_Type is record
      Namespace_URI : League.Strings.Universal_String;
      Local_Name    : League.Strings.Universal_String;
   end record;

   not overriding function Create
    (The_Type : not null access Document_Type)
       return Abstract_Document is abstract;
   --  Dispatching constructor to be used to create and initialize document
   --  node.

   -------------------
   -- Document_Node --
   -------------------

   type Document_Node is
     new Matreshka.DOM_Nodes.Documents.Abstract_Document with null record;

   overriding function Create
    (The_Type : not null access Document_Type) return Document_Node;

end Matreshka.DOM_Nodes.Documents;
