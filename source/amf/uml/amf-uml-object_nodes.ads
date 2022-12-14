------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Ada Modeling Framework                          --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2011-2012, Vadim Godunko <vgodunko@gmail.com>                --
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
--  This file is generated, don't edit it.
------------------------------------------------------------------------------
--  Object nodes have support for token selection, limitation on the number of 
--  tokens, specifying the state required for tokens, and carrying control 
--  values.
--  
--  An object node is an abstract activity node that is part of defining 
--  object flow in an activity.
------------------------------------------------------------------------------
with AMF.UML.Activity_Nodes;
limited with AMF.UML.Behaviors;
limited with AMF.UML.States.Collections;
with AMF.UML.Typed_Elements;
limited with AMF.UML.Value_Specifications;

package AMF.UML.Object_Nodes is

   pragma Preelaborate;

   type UML_Object_Node is limited interface
     and AMF.UML.Activity_Nodes.UML_Activity_Node
     and AMF.UML.Typed_Elements.UML_Typed_Element;

   type UML_Object_Node_Access is
     access all UML_Object_Node'Class;
   for UML_Object_Node_Access'Storage_Size use 0;

   not overriding function Get_In_State
    (Self : not null access constant UML_Object_Node)
       return AMF.UML.States.Collections.Set_Of_UML_State is abstract;
   --  Getter of ObjectNode::inState.
   --
   --  The required states of the object available at this point in the 
   --  activity.

   not overriding function Get_Is_Control_Type
    (Self : not null access constant UML_Object_Node)
       return Boolean is abstract;
   --  Getter of ObjectNode::isControlType.
   --
   --  Tells whether the type of the object node is to be treated as control.

   not overriding procedure Set_Is_Control_Type
    (Self : not null access UML_Object_Node;
     To   : Boolean) is abstract;
   --  Setter of ObjectNode::isControlType.
   --
   --  Tells whether the type of the object node is to be treated as control.

   not overriding function Get_Ordering
    (Self : not null access constant UML_Object_Node)
       return AMF.UML.UML_Object_Node_Ordering_Kind is abstract;
   --  Getter of ObjectNode::ordering.
   --
   --  Tells whether and how the tokens in the object node are ordered for 
   --  selection to traverse edges outgoing from the object node.

   not overriding procedure Set_Ordering
    (Self : not null access UML_Object_Node;
     To   : AMF.UML.UML_Object_Node_Ordering_Kind) is abstract;
   --  Setter of ObjectNode::ordering.
   --
   --  Tells whether and how the tokens in the object node are ordered for 
   --  selection to traverse edges outgoing from the object node.

   not overriding function Get_Selection
    (Self : not null access constant UML_Object_Node)
       return AMF.UML.Behaviors.UML_Behavior_Access is abstract;
   --  Getter of ObjectNode::selection.
   --
   --  Selects tokens for outgoing edges.

   not overriding procedure Set_Selection
    (Self : not null access UML_Object_Node;
     To   : AMF.UML.Behaviors.UML_Behavior_Access) is abstract;
   --  Setter of ObjectNode::selection.
   --
   --  Selects tokens for outgoing edges.

   not overriding function Get_Upper_Bound
    (Self : not null access constant UML_Object_Node)
       return AMF.UML.Value_Specifications.UML_Value_Specification_Access is abstract;
   --  Getter of ObjectNode::upperBound.
   --
   --  The maximum number of tokens allowed in the node. Objects cannot flow 
   --  into the node if the upper bound is reached.

   not overriding procedure Set_Upper_Bound
    (Self : not null access UML_Object_Node;
     To   : AMF.UML.Value_Specifications.UML_Value_Specification_Access) is abstract;
   --  Setter of ObjectNode::upperBound.
   --
   --  The maximum number of tokens allowed in the node. Objects cannot flow 
   --  into the node if the upper bound is reached.

end AMF.UML.Object_Nodes;
