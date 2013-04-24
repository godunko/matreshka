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
-- Copyright © 2011-2013, Vadim Godunko <vgodunko@gmail.com>                --
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
with League.Strings;

with Matreshka.XML.Counters;
limited with Matreshka.DOM_Nodes.Attributes;
limited with Matreshka.DOM_Nodes.Documents;
limited with Matreshka.DOM_Nodes.Elements;
limited with XML.DOM.Visitors;

package Matreshka.DOM_Nodes is

   pragma Preelaborate;

   type Abstract_Node is abstract tagged;

   --  Access types for all type of DOM nodes.

   type Attribute_Access is
     access all Matreshka.DOM_Nodes.Attributes.Abstract_Attribute'Class;
   type Document_Access is
     access all Matreshka.DOM_Nodes.Documents.Abstract_Document'Class;
   type Element_Access is
     access all Matreshka.DOM_Nodes.Elements.Abstract_Element'Class;
   type Node_Access is access all Abstract_Node'Class;

   procedure Reference (Self : not null Node_Access);
   pragma Inline (Reference);
   --  Increments reference counter.

   procedure Dereference (Self : in out Node_Access);
   --  Decrements reference counter; deallocate object when its value went to
   --  zero.

   -------------------
   -- Abstract_Node --
   -------------------

   type Abstract_Node is abstract tagged limited record
      Counter  : aliased Matreshka.XML.Counters.Counter;
      Is_Root  : Boolean := True;
      --  Node is root node of subtree, associated with document but not part
      --  of it.
      Owner    : Node_Access;
      --  Parent node or associated document when Is_Root set to True.
      Previous : Node_Access;
      Next     : Node_Access;
      First    : Node_Access;
      Last     : Node_Access;
   end record;

   not overriding function Get_Local_Name
    (Self : not null access constant Abstract_Node)
       return League.Strings.Universal_String;
   --  Returns the local part of the qualified name of this node.

   not overriding function Get_Namespace_URI
    (Self : not null access constant Abstract_Node)
       return League.Strings.Universal_String;
   --  The namespace URI of this node, or null if it is unspecified (see XML
   --  Namespaces).

   not overriding procedure Append_Child
    (Self  : not null access Abstract_Node;
     Child : not null Node_Access);
   --  Appends child to the list of children nodes. Derived types need to
   --  override this subprogram to implement specific checks.

   not overriding procedure Finalize (Self : not null access Abstract_Node);

   not overriding procedure Remove_From_Parent
    (Self : not null access Abstract_Node);
   --  Removes node from the corresponding list of nodes of node's parent.
   --  This subprogram is overridden by Abstract_Attribute type to remove
   --  attribute node from list of attributes of parent element node.

   not overriding procedure Enter_Element
    (Self    : not null access Abstract_Node;
     Visitor : in out Standard.XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out Standard.XML.DOM.Visitors.Traverse_Control) is abstract;
   --  Dispatch call to corresponding subprogram of visitor interface.

   not overriding procedure Leave_Element
    (Self    : not null access Abstract_Node;
     Visitor : in out Standard.XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out Standard.XML.DOM.Visitors.Traverse_Control) is abstract;
   --  Dispatch call to corresponding subprogram of visitor interface.

   not overriding procedure Visit_Element
    (Self     : not null access Abstract_Node;
     Iterator : in out Standard.XML.DOM.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Standard.XML.DOM.Visitors.Abstract_Visitor'Class;
     Control  : in out Standard.XML.DOM.Visitors.Traverse_Control) is abstract;
   --  Dispatch call to corresponding subprogram of iterator interface.

   procedure Initialize
    (Self     : not null access Abstract_Node'Class;
     Document : Matreshka.DOM_Nodes.Document_Access);

end Matreshka.DOM_Nodes;
