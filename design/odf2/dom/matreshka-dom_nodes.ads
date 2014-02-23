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
with League.Strings;

with XML.DOM.Nodes;
with XML.DOM.Visitors;

package Matreshka.DOM_Nodes is

   pragma Preelaborate;

   type Node is tagged;

   type Node_Access is access all Node'Class;

   type Node is abstract limited new XML.DOM.Nodes.DOM_Node with record
      Document : Node_Access;
      Parent   : Node_Access;
      First    : Node_Access;
      Last     : Node_Access;
      Previous : Node_Access;
      Next     : Node_Access;
      --  Previous and next nodes in the doubly linked list of nodes. Each
      --  node, except document node, is member of one of three lists:
      --   - parent's list of children nodes;
      --   - element's list of attribute nodes;
      --   - document's list of detached nodes.
   end record;

   not overriding procedure Enter_Node
    (Self    : not null access Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is abstract;
   --  Dispatch call to corresponding subprogram of visitor interface.

   not overriding procedure Leave_Node
    (Self    : not null access Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is abstract;
   --  Dispatch call to corresponding subprogram of visitor interface.

   not overriding procedure Visit_Node
    (Self     : not null access Node;
     Iterator : in out XML.DOM.Visitors.Abstract_Iterator'Class;
     Visitor  : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control  : in out XML.DOM.Visitors.Traverse_Control) is abstract;
   --  Dispatch call to corresponding subprogram of iterator interface.

   overriding function Append_Child
    (Self : not null access Node;
     Node : not null XML.DOM.Nodes.DOM_Node_Access)
       return not null XML.DOM.Nodes.DOM_Node_Access;
   --  Generic implementation of appending child node. Specialized nodes must
   --  override it to add required checks.

   overriding function Get_Node_Value
    (Self : not null access constant Node)
       return League.Strings.Universal_String;

   overriding procedure Set_Node_Value
    (Self      : not null access Node;
     New_Value : League.Strings.Universal_String);

   package Constructors is

      procedure Initialize
       (Self     : not null access Node'Class;
        Document : not null Node_Access);

   end Constructors;

end Matreshka.DOM_Nodes;
