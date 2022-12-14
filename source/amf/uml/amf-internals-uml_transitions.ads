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
with AMF.String_Collections;
with AMF.UML.Behaviors;
with AMF.UML.Classifiers.Collections;
with AMF.UML.Constraints.Collections;
with AMF.UML.Dependencies.Collections;
with AMF.UML.Element_Imports.Collections;
with AMF.UML.Named_Elements.Collections;
with AMF.UML.Namespaces;
with AMF.UML.Package_Imports.Collections;
with AMF.UML.Packageable_Elements.Collections;
with AMF.UML.Packages.Collections;
with AMF.UML.Redefinable_Elements.Collections;
with AMF.UML.Regions;
with AMF.UML.State_Machines;
with AMF.UML.String_Expressions;
with AMF.UML.Transitions;
with AMF.UML.Triggers.Collections;
with AMF.UML.Vertexs;
with AMF.Visitors;

package AMF.Internals.UML_Transitions is

   type UML_Transition_Proxy is
     limited new AMF.Internals.UML_Named_Elements.UML_Named_Element_Proxy
       and AMF.UML.Transitions.UML_Transition with null record;

   overriding function Get_Container
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Regions.UML_Region_Access;
   --  Getter of Transition::container.
   --
   --  Designates the region that owns this transition.

   overriding procedure Set_Container
    (Self : not null access UML_Transition_Proxy;
     To   : AMF.UML.Regions.UML_Region_Access);
   --  Setter of Transition::container.
   --
   --  Designates the region that owns this transition.

   overriding function Get_Effect
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Behaviors.UML_Behavior_Access;
   --  Getter of Transition::effect.
   --
   --  Specifies an optional behavior to be performed when the transition
   --  fires.

   overriding procedure Set_Effect
    (Self : not null access UML_Transition_Proxy;
     To   : AMF.UML.Behaviors.UML_Behavior_Access);
   --  Setter of Transition::effect.
   --
   --  Specifies an optional behavior to be performed when the transition
   --  fires.

   overriding function Get_Guard
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Constraints.UML_Constraint_Access;
   --  Getter of Transition::guard.
   --
   --  A guard is a constraint that provides a fine-grained control over the
   --  firing of the transition. The guard is evaluated when an event
   --  occurrence is dispatched by the state machine. If the guard is true at
   --  that time, the transition may be enabled, otherwise, it is disabled.
   --  Guards should be pure expressions without side effects. Guard
   --  expressions with side effects are ill formed.

   overriding procedure Set_Guard
    (Self : not null access UML_Transition_Proxy;
     To   : AMF.UML.Constraints.UML_Constraint_Access);
   --  Setter of Transition::guard.
   --
   --  A guard is a constraint that provides a fine-grained control over the
   --  firing of the transition. The guard is evaluated when an event
   --  occurrence is dispatched by the state machine. If the guard is true at
   --  that time, the transition may be enabled, otherwise, it is disabled.
   --  Guards should be pure expressions without side effects. Guard
   --  expressions with side effects are ill formed.

   overriding function Get_Kind
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.UML_Transition_Kind;
   --  Getter of Transition::kind.
   --
   --  Indicates the precise type of the transition.

   overriding procedure Set_Kind
    (Self : not null access UML_Transition_Proxy;
     To   : AMF.UML.UML_Transition_Kind);
   --  Setter of Transition::kind.
   --
   --  Indicates the precise type of the transition.

   overriding function Get_Redefined_Transition
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Transitions.UML_Transition_Access;
   --  Getter of Transition::redefinedTransition.
   --
   --  The transition that is redefined by this transition.

   overriding procedure Set_Redefined_Transition
    (Self : not null access UML_Transition_Proxy;
     To   : AMF.UML.Transitions.UML_Transition_Access);
   --  Setter of Transition::redefinedTransition.
   --
   --  The transition that is redefined by this transition.

   overriding function Get_Redefinition_Context
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Classifiers.UML_Classifier_Access;
   --  Getter of Transition::redefinitionContext.
   --
   --  References the classifier in which context this element may be
   --  redefined.

   overriding function Get_Source
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Vertexs.UML_Vertex_Access;
   --  Getter of Transition::source.
   --
   --  Designates the originating vertex (state or pseudostate) of the
   --  transition.

   overriding procedure Set_Source
    (Self : not null access UML_Transition_Proxy;
     To   : AMF.UML.Vertexs.UML_Vertex_Access);
   --  Setter of Transition::source.
   --
   --  Designates the originating vertex (state or pseudostate) of the
   --  transition.

   overriding function Get_Target
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Vertexs.UML_Vertex_Access;
   --  Getter of Transition::target.
   --
   --  Designates the target vertex that is reached when the transition is
   --  taken.

   overriding procedure Set_Target
    (Self : not null access UML_Transition_Proxy;
     To   : AMF.UML.Vertexs.UML_Vertex_Access);
   --  Setter of Transition::target.
   --
   --  Designates the target vertex that is reached when the transition is
   --  taken.

   overriding function Get_Trigger
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Triggers.Collections.Set_Of_UML_Trigger;
   --  Getter of Transition::trigger.
   --
   --  Specifies the triggers that may fire the transition.

   overriding function Get_Element_Import
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Element_Imports.Collections.Set_Of_UML_Element_Import;
   --  Getter of Namespace::elementImport.
   --
   --  References the ElementImports owned by the Namespace.

   overriding function Get_Imported_Member
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element;
   --  Getter of Namespace::importedMember.
   --
   --  References the PackageableElements that are members of this Namespace
   --  as a result of either PackageImports or ElementImports.

   overriding function Get_Member
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Named_Elements.Collections.Set_Of_UML_Named_Element;
   --  Getter of Namespace::member.
   --
   --  A collection of NamedElements identifiable within the Namespace, either
   --  by being owned or by being introduced by importing or inheritance.

   overriding function Get_Owned_Member
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Named_Elements.Collections.Set_Of_UML_Named_Element;
   --  Getter of Namespace::ownedMember.
   --
   --  A collection of NamedElements owned by the Namespace.

   overriding function Get_Owned_Rule
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Constraints.Collections.Set_Of_UML_Constraint;
   --  Getter of Namespace::ownedRule.
   --
   --  Specifies a set of Constraints owned by this Namespace.

   overriding function Get_Package_Import
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Package_Imports.Collections.Set_Of_UML_Package_Import;
   --  Getter of Namespace::packageImport.
   --
   --  References the PackageImports owned by the Namespace.

   overriding function Get_Client_Dependency
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Dependencies.Collections.Set_Of_UML_Dependency;
   --  Getter of NamedElement::clientDependency.
   --
   --  Indicates the dependencies that reference the client.

   overriding function Get_Name_Expression
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.String_Expressions.UML_String_Expression_Access;
   --  Getter of NamedElement::nameExpression.
   --
   --  The string expression used to define the name of this named element.

   overriding procedure Set_Name_Expression
    (Self : not null access UML_Transition_Proxy;
     To   : AMF.UML.String_Expressions.UML_String_Expression_Access);
   --  Setter of NamedElement::nameExpression.
   --
   --  The string expression used to define the name of this named element.

   overriding function Get_Namespace
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Namespaces.UML_Namespace_Access;
   --  Getter of NamedElement::namespace.
   --
   --  Specifies the namespace that owns the NamedElement.

   overriding function Get_Qualified_Name
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.Optional_String;
   --  Getter of NamedElement::qualifiedName.
   --
   --  A name which allows the NamedElement to be identified within a
   --  hierarchy of nested Namespaces. It is constructed from the names of the
   --  containing namespaces starting at the root of the hierarchy and ending
   --  with the name of the NamedElement itself.

   overriding function Get_Is_Leaf
    (Self : not null access constant UML_Transition_Proxy)
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
    (Self : not null access UML_Transition_Proxy;
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
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Redefinable_Elements.Collections.Set_Of_UML_Redefinable_Element;
   --  Getter of RedefinableElement::redefinedElement.
   --
   --  The redefinable element that is being redefined by this element.

   overriding function Get_Redefinition_Context
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Classifiers.Collections.Set_Of_UML_Classifier;
   --  Getter of RedefinableElement::redefinitionContext.
   --
   --  References the contexts that this element may be redefined from.

   overriding function Containing_State_Machine
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.State_Machines.UML_State_Machine_Access;
   --  Operation Transition::containingStateMachine.
   --
   --  The query containingStateMachine() returns the state machine that
   --  contains the transition either directly or transitively.

   overriding function Is_Consistent_With
    (Self : not null access constant UML_Transition_Proxy;
     Redefinee : AMF.UML.Redefinable_Elements.UML_Redefinable_Element_Access)
       return Boolean;
   --  Operation Transition::isConsistentWith.
   --
   --  The query isConsistentWith() specifies that a redefining transition is
   --  consistent with a redefined transition provided that the redefining
   --  transition has the following relation to the redefined transition: A
   --  redefining transition redefines all properties of the corresponding
   --  redefined transition, except the source state and the trigger.

   overriding function Redefinition_Context
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Classifiers.UML_Classifier_Access;
   --  Operation Transition::redefinitionContext.
   --
   --  The redefinition context of a transition is the nearest containing
   --  statemachine.

   overriding function Exclude_Collisions
    (Self : not null access constant UML_Transition_Proxy;
     Imps : AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element)
       return AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element;
   --  Operation Namespace::excludeCollisions.
   --
   --  The query excludeCollisions() excludes from a set of
   --  PackageableElements any that would not be distinguishable from each
   --  other in this namespace.

   overriding function Get_Names_Of_Member
    (Self : not null access constant UML_Transition_Proxy;
     Element : AMF.UML.Named_Elements.UML_Named_Element_Access)
       return AMF.String_Collections.Set_Of_String;
   --  Operation Namespace::getNamesOfMember.
   --
   --  The query getNamesOfMember() takes importing into account. It gives
   --  back the set of names that an element would have in an importing
   --  namespace, either because it is owned, or if not owned then imported
   --  individually, or if not individually then from a package.
   --  The query getNamesOfMember() gives a set of all of the names that a
   --  member would have in a Namespace. In general a member can have multiple
   --  names in a Namespace if it is imported more than once with different
   --  aliases. The query takes account of importing. It gives back the set of
   --  names that an element would have in an importing namespace, either
   --  because it is owned, or if not owned then imported individually, or if
   --  not individually then from a package.

   overriding function Import_Members
    (Self : not null access constant UML_Transition_Proxy;
     Imps : AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element)
       return AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element;
   --  Operation Namespace::importMembers.
   --
   --  The query importMembers() defines which of a set of PackageableElements
   --  are actually imported into the namespace. This excludes hidden ones,
   --  i.e., those which have names that conflict with names of owned members,
   --  and also excludes elements which would have the same name when imported.

   overriding function Imported_Member
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element;
   --  Operation Namespace::importedMember.
   --
   --  The importedMember property is derived from the ElementImports and the
   --  PackageImports. References the PackageableElements that are members of
   --  this Namespace as a result of either PackageImports or ElementImports.

   overriding function Members_Are_Distinguishable
    (Self : not null access constant UML_Transition_Proxy)
       return Boolean;
   --  Operation Namespace::membersAreDistinguishable.
   --
   --  The Boolean query membersAreDistinguishable() determines whether all of
   --  the namespace's members are distinguishable within it.

   overriding function Owned_Member
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Named_Elements.Collections.Set_Of_UML_Named_Element;
   --  Operation Namespace::ownedMember.
   --
   --  Missing derivation for Namespace::/ownedMember : NamedElement

   overriding function All_Owning_Packages
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Packages.Collections.Set_Of_UML_Package;
   --  Operation NamedElement::allOwningPackages.
   --
   --  The query allOwningPackages() returns all the directly or indirectly
   --  owning packages.

   overriding function Is_Distinguishable_From
    (Self : not null access constant UML_Transition_Proxy;
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
    (Self : not null access constant UML_Transition_Proxy)
       return AMF.UML.Namespaces.UML_Namespace_Access;
   --  Operation NamedElement::namespace.
   --
   --  Missing derivation for NamedElement::/namespace : Namespace

   overriding function Is_Redefinition_Context_Valid
    (Self : not null access constant UML_Transition_Proxy;
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

   overriding procedure Enter_Element
    (Self    : not null access constant UML_Transition_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Leave_Element
    (Self    : not null access constant UML_Transition_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Visit_Element
    (Self     : not null access constant UML_Transition_Proxy;
     Iterator : in out AMF.Visitors.Abstract_Iterator'Class;
     Visitor  : in out AMF.Visitors.Abstract_Visitor'Class;
     Control  : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

end AMF.Internals.UML_Transitions;
