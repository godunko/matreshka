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
with AMF.Internals.UML_Named_Elements;
with AMF.UML.Activities;
with AMF.UML.Activity_Edges.Collections;
with AMF.UML.Activity_Groups.Collections;
with AMF.UML.Activity_Nodes;
with AMF.UML.Activity_Partitions.Collections;
with AMF.UML.Behaviors;
with AMF.UML.Classifiers.Collections;
with AMF.UML.Dependencies.Collections;
with AMF.UML.Interruptible_Activity_Regions;
with AMF.UML.Named_Elements;
with AMF.UML.Namespaces;
with AMF.UML.Object_Flows;
with AMF.UML.Packages.Collections;
with AMF.UML.Redefinable_Elements.Collections;
with AMF.UML.String_Expressions;
with AMF.UML.Structured_Activity_Nodes;
with AMF.UML.Value_Specifications;
with AMF.Visitors;

package AMF.Internals.UML_Object_Flows is

   type UML_Object_Flow_Proxy is
     limited new AMF.Internals.UML_Named_Elements.UML_Named_Element_Proxy
       and AMF.UML.Object_Flows.UML_Object_Flow with null record;

   overriding function Get_Is_Multicast
    (Self : not null access constant UML_Object_Flow_Proxy)
       return Boolean;
   --  Getter of ObjectFlow::isMulticast.
   --
   --  Tells whether the objects in the flow are passed by multicasting.

   overriding procedure Set_Is_Multicast
    (Self : not null access UML_Object_Flow_Proxy;
     To   : Boolean);
   --  Setter of ObjectFlow::isMulticast.
   --
   --  Tells whether the objects in the flow are passed by multicasting.

   overriding function Get_Is_Multireceive
    (Self : not null access constant UML_Object_Flow_Proxy)
       return Boolean;
   --  Getter of ObjectFlow::isMultireceive.
   --
   --  Tells whether the objects in the flow are gathered from respondents to
   --  multicasting.

   overriding procedure Set_Is_Multireceive
    (Self : not null access UML_Object_Flow_Proxy;
     To   : Boolean);
   --  Setter of ObjectFlow::isMultireceive.
   --
   --  Tells whether the objects in the flow are gathered from respondents to
   --  multicasting.

   overriding function Get_Selection
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Behaviors.UML_Behavior_Access;
   --  Getter of ObjectFlow::selection.
   --
   --  Selects tokens from a source object node.

   overriding procedure Set_Selection
    (Self : not null access UML_Object_Flow_Proxy;
     To   : AMF.UML.Behaviors.UML_Behavior_Access);
   --  Setter of ObjectFlow::selection.
   --
   --  Selects tokens from a source object node.

   overriding function Get_Transformation
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Behaviors.UML_Behavior_Access;
   --  Getter of ObjectFlow::transformation.
   --
   --  Changes or replaces data tokens flowing along edge.

   overriding procedure Set_Transformation
    (Self : not null access UML_Object_Flow_Proxy;
     To   : AMF.UML.Behaviors.UML_Behavior_Access);
   --  Setter of ObjectFlow::transformation.
   --
   --  Changes or replaces data tokens flowing along edge.

   overriding function Get_Activity
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Activities.UML_Activity_Access;
   --  Getter of ActivityEdge::activity.
   --
   --  Activity containing the edge.

   overriding procedure Set_Activity
    (Self : not null access UML_Object_Flow_Proxy;
     To   : AMF.UML.Activities.UML_Activity_Access);
   --  Setter of ActivityEdge::activity.
   --
   --  Activity containing the edge.

   overriding function Get_Guard
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Value_Specifications.UML_Value_Specification_Access;
   --  Getter of ActivityEdge::guard.
   --
   --  Specification evaluated at runtime to determine if the edge can be
   --  traversed.

   overriding procedure Set_Guard
    (Self : not null access UML_Object_Flow_Proxy;
     To   : AMF.UML.Value_Specifications.UML_Value_Specification_Access);
   --  Setter of ActivityEdge::guard.
   --
   --  Specification evaluated at runtime to determine if the edge can be
   --  traversed.

   overriding function Get_In_Group
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Activity_Groups.Collections.Set_Of_UML_Activity_Group;
   --  Getter of ActivityEdge::inGroup.
   --
   --  Groups containing the edge.

   overriding function Get_In_Partition
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Activity_Partitions.Collections.Set_Of_UML_Activity_Partition;
   --  Getter of ActivityEdge::inPartition.
   --
   --  Partitions containing the edge.

   overriding function Get_In_Structured_Node
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Structured_Activity_Nodes.UML_Structured_Activity_Node_Access;
   --  Getter of ActivityEdge::inStructuredNode.
   --
   --  Structured activity node containing the edge.

   overriding procedure Set_In_Structured_Node
    (Self : not null access UML_Object_Flow_Proxy;
     To   : AMF.UML.Structured_Activity_Nodes.UML_Structured_Activity_Node_Access);
   --  Setter of ActivityEdge::inStructuredNode.
   --
   --  Structured activity node containing the edge.

   overriding function Get_Interrupts
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Interruptible_Activity_Regions.UML_Interruptible_Activity_Region_Access;
   --  Getter of ActivityEdge::interrupts.
   --
   --  Region that the edge can interrupt.

   overriding procedure Set_Interrupts
    (Self : not null access UML_Object_Flow_Proxy;
     To   : AMF.UML.Interruptible_Activity_Regions.UML_Interruptible_Activity_Region_Access);
   --  Setter of ActivityEdge::interrupts.
   --
   --  Region that the edge can interrupt.

   overriding function Get_Redefined_Edge
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Activity_Edges.Collections.Set_Of_UML_Activity_Edge;
   --  Getter of ActivityEdge::redefinedEdge.
   --
   --  Inherited edges replaced by this edge in a specialization of the
   --  activity.

   overriding function Get_Source
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Activity_Nodes.UML_Activity_Node_Access;
   --  Getter of ActivityEdge::source.
   --
   --  Node from which tokens are taken when they traverse the edge.

   overriding procedure Set_Source
    (Self : not null access UML_Object_Flow_Proxy;
     To   : AMF.UML.Activity_Nodes.UML_Activity_Node_Access);
   --  Setter of ActivityEdge::source.
   --
   --  Node from which tokens are taken when they traverse the edge.

   overriding function Get_Target
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Activity_Nodes.UML_Activity_Node_Access;
   --  Getter of ActivityEdge::target.
   --
   --  Node to which tokens are put when they traverse the edge.

   overriding procedure Set_Target
    (Self : not null access UML_Object_Flow_Proxy;
     To   : AMF.UML.Activity_Nodes.UML_Activity_Node_Access);
   --  Setter of ActivityEdge::target.
   --
   --  Node to which tokens are put when they traverse the edge.

   overriding function Get_Weight
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Value_Specifications.UML_Value_Specification_Access;
   --  Getter of ActivityEdge::weight.
   --
   --  The minimum number of tokens that must traverse the edge at the same
   --  time.

   overriding procedure Set_Weight
    (Self : not null access UML_Object_Flow_Proxy;
     To   : AMF.UML.Value_Specifications.UML_Value_Specification_Access);
   --  Setter of ActivityEdge::weight.
   --
   --  The minimum number of tokens that must traverse the edge at the same
   --  time.

   overriding function Get_Is_Leaf
    (Self : not null access constant UML_Object_Flow_Proxy)
       return Boolean;
   --  Getter of RedefinableElement::isLeaf.
   --
   --  Indicates whether it is possible to further redefine a
   --  RedefinableElement. If the value is true, then it is not possible to
   --  further redefine the RedefinableElement. Note that this property is
   --  preserved through package merge operations; that is, the capability to
   --  redefine a RedefinableElement (i.e., isLeaf=false) must be preserved in
   --  the resulting RedefinableElement of a package merge operation where a
   --  RedefinableElement with isLeaf=false is merged with a matching
   --  RedefinableElement with isLeaf=true: the resulting RedefinableElement
   --  will have isLeaf=false. Default value is false.

   overriding procedure Set_Is_Leaf
    (Self : not null access UML_Object_Flow_Proxy;
     To   : Boolean);
   --  Setter of RedefinableElement::isLeaf.
   --
   --  Indicates whether it is possible to further redefine a
   --  RedefinableElement. If the value is true, then it is not possible to
   --  further redefine the RedefinableElement. Note that this property is
   --  preserved through package merge operations; that is, the capability to
   --  redefine a RedefinableElement (i.e., isLeaf=false) must be preserved in
   --  the resulting RedefinableElement of a package merge operation where a
   --  RedefinableElement with isLeaf=false is merged with a matching
   --  RedefinableElement with isLeaf=true: the resulting RedefinableElement
   --  will have isLeaf=false. Default value is false.

   overriding function Get_Redefined_Element
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Redefinable_Elements.Collections.Set_Of_UML_Redefinable_Element;
   --  Getter of RedefinableElement::redefinedElement.
   --
   --  The redefinable element that is being redefined by this element.

   overriding function Get_Redefinition_Context
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Classifiers.Collections.Set_Of_UML_Classifier;
   --  Getter of RedefinableElement::redefinitionContext.
   --
   --  References the contexts that this element may be redefined from.

   overriding function Get_Client_Dependency
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Dependencies.Collections.Set_Of_UML_Dependency;
   --  Getter of NamedElement::clientDependency.
   --
   --  Indicates the dependencies that reference the client.

   overriding function Get_Name_Expression
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.String_Expressions.UML_String_Expression_Access;
   --  Getter of NamedElement::nameExpression.
   --
   --  The string expression used to define the name of this named element.

   overriding procedure Set_Name_Expression
    (Self : not null access UML_Object_Flow_Proxy;
     To   : AMF.UML.String_Expressions.UML_String_Expression_Access);
   --  Setter of NamedElement::nameExpression.
   --
   --  The string expression used to define the name of this named element.

   overriding function Get_Namespace
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Namespaces.UML_Namespace_Access;
   --  Getter of NamedElement::namespace.
   --
   --  Specifies the namespace that owns the NamedElement.

   overriding function Get_Qualified_Name
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.Optional_String;
   --  Getter of NamedElement::qualifiedName.
   --
   --  A name which allows the NamedElement to be identified within a
   --  hierarchy of nested Namespaces. It is constructed from the names of the
   --  containing namespaces starting at the root of the hierarchy and ending
   --  with the name of the NamedElement itself.

   overriding function Is_Consistent_With
    (Self : not null access constant UML_Object_Flow_Proxy;
     Redefinee : AMF.UML.Redefinable_Elements.UML_Redefinable_Element_Access)
       return Boolean;
   --  Operation RedefinableElement::isConsistentWith.
   --
   --  The query isConsistentWith() specifies, for any two RedefinableElements
   --  in a context in which redefinition is possible, whether redefinition
   --  would be logically consistent. By default, this is false; this
   --  operation must be overridden for subclasses of RedefinableElement to
   --  define the consistency conditions.

   overriding function Is_Redefinition_Context_Valid
    (Self : not null access constant UML_Object_Flow_Proxy;
     Redefined : AMF.UML.Redefinable_Elements.UML_Redefinable_Element_Access)
       return Boolean;
   --  Operation RedefinableElement::isRedefinitionContextValid.
   --
   --  The query isRedefinitionContextValid() specifies whether the
   --  redefinition contexts of this RedefinableElement are properly related
   --  to the redefinition contexts of the specified RedefinableElement to
   --  allow this element to redefine the other. By default at least one of
   --  the redefinition contexts of this element must be a specialization of
   --  at least one of the redefinition contexts of the specified element.

   overriding function All_Owning_Packages
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Packages.Collections.Set_Of_UML_Package;
   --  Operation NamedElement::allOwningPackages.
   --
   --  The query allOwningPackages() returns all the directly or indirectly
   --  owning packages.

   overriding function Is_Distinguishable_From
    (Self : not null access constant UML_Object_Flow_Proxy;
     N : AMF.UML.Named_Elements.UML_Named_Element_Access;
     Ns : AMF.UML.Namespaces.UML_Namespace_Access)
       return Boolean;
   --  Operation NamedElement::isDistinguishableFrom.
   --
   --  The query isDistinguishableFrom() determines whether two NamedElements
   --  may logically co-exist within a Namespace. By default, two named
   --  elements are distinguishable if (a) they have unrelated types or (b)
   --  they have related types but different names.

   overriding function Namespace
    (Self : not null access constant UML_Object_Flow_Proxy)
       return AMF.UML.Namespaces.UML_Namespace_Access;
   --  Operation NamedElement::namespace.
   --
   --  Missing derivation for NamedElement::/namespace : Namespace

   overriding procedure Enter_Element
    (Self    : not null access constant UML_Object_Flow_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Leave_Element
    (Self    : not null access constant UML_Object_Flow_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Visit_Element
    (Self     : not null access constant UML_Object_Flow_Proxy;
     Iterator : in out AMF.Visitors.Abstract_Iterator'Class;
     Visitor  : in out AMF.Visitors.Abstract_Visitor'Class;
     Control  : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

end AMF.Internals.UML_Object_Flows;
