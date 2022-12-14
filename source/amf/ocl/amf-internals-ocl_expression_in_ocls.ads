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
--  This file is generated, don't edit it.
------------------------------------------------------------------------------
with AMF.Internals.OCL_Elements;
with AMF.OCL.Expression_In_Ocls;
with AMF.OCL.Ocl_Expressions;
with AMF.OCL.Variables.Collections;
with AMF.String_Collections;
with AMF.UML.Behaviors;
with AMF.UML.Classifiers;
with AMF.UML.Comments.Collections;
with AMF.UML.Dependencies.Collections;
with AMF.UML.Elements.Collections;
with AMF.UML.Named_Elements;
with AMF.UML.Namespaces.Collections;
with AMF.UML.Packages.Collections;
with AMF.UML.Parameterable_Elements;
with AMF.UML.Parameters;
with AMF.UML.String_Expressions;
with AMF.UML.Template_Parameters;
with AMF.UML.Types;
with AMF.Visitors;

package AMF.Internals.OCL_Expression_In_Ocls is

   type OCL_Expression_In_Ocl_Proxy is
     limited new AMF.Internals.OCL_Elements.OCL_Element_Proxy
       and AMF.OCL.Expression_In_Ocls.OCL_Expression_In_Ocl with null record;

   overriding function Get_Body_Expression
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.OCL.Ocl_Expressions.OCL_Ocl_Expression_Access;
   --  Getter of ExpressionInOcl::bodyExpression.
   --

   overriding procedure Set_Body_Expression
    (Self : not null access OCL_Expression_In_Ocl_Proxy;
     To   : AMF.OCL.Ocl_Expressions.OCL_Ocl_Expression_Access);
   --  Setter of ExpressionInOcl::bodyExpression.
   --

   overriding function Get_Context_Variable
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.OCL.Variables.OCL_Variable_Access;
   --  Getter of ExpressionInOcl::contextVariable.
   --

   overriding procedure Set_Context_Variable
    (Self : not null access OCL_Expression_In_Ocl_Proxy;
     To   : AMF.OCL.Variables.OCL_Variable_Access);
   --  Setter of ExpressionInOcl::contextVariable.
   --

   overriding function Get_Result_Variable
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.OCL.Variables.OCL_Variable_Access;
   --  Getter of ExpressionInOcl::resultVariable.
   --

   overriding procedure Set_Result_Variable
    (Self : not null access OCL_Expression_In_Ocl_Proxy;
     To   : AMF.OCL.Variables.OCL_Variable_Access);
   --  Setter of ExpressionInOcl::resultVariable.
   --

   overriding function Get_Parameter_Variable
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.OCL.Variables.Collections.Ordered_Set_Of_OCL_Variable;
   --  Getter of ExpressionInOcl::parameterVariable.
   --

   overriding function Get_Generated_Type
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Classifiers.UML_Classifier_Access;
   --  Getter of ExpressionInOcl::generatedType.
   --

   overriding procedure Set_Generated_Type
    (Self : not null access OCL_Expression_In_Ocl_Proxy;
     To   : AMF.UML.Classifiers.UML_Classifier_Access);
   --  Setter of ExpressionInOcl::generatedType.
   --

   overriding function Get_Behavior
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Behaviors.UML_Behavior_Access;
   --  Getter of OpaqueExpression::behavior.
   --
   --  Specifies the behavior of the opaque expression.

   overriding procedure Set_Behavior
    (Self : not null access OCL_Expression_In_Ocl_Proxy;
     To   : AMF.UML.Behaviors.UML_Behavior_Access);
   --  Setter of OpaqueExpression::behavior.
   --
   --  Specifies the behavior of the opaque expression.

   overriding function Get_Body
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.String_Collections.Sequence_Of_String;
   --  Getter of OpaqueExpression::body.
   --
   --  The text of the expression, possibly in multiple languages.

   overriding function Get_Language
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.String_Collections.Ordered_Set_Of_String;
   --  Getter of OpaqueExpression::language.
   --
   --  Specifies the languages in which the expression is stated. The 
   --  interpretation of the expression body depends on the languages. If the 
   --  languages are unspecified, they might be implicit from the expression 
   --  body or the context. Languages are matched to body strings by order.

   overriding function Get_Result
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Parameters.UML_Parameter_Access;
   --  Getter of OpaqueExpression::result.
   --
   --  Restricts an opaque expression to return exactly one return result. 
   --  When the invocation of the opaque expression completes, a single set of 
   --  values is returned to its owner. This association is derived from the 
   --  single return result parameter of the associated behavior.

   overriding function Get_Type
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Types.UML_Type_Access;
   --  Getter of TypedElement::type.
   --
   --  The type of the TypedElement.
   --  This information is derived from the return result for this Operation.

   overriding procedure Set_Type
    (Self : not null access OCL_Expression_In_Ocl_Proxy;
     To   : AMF.UML.Types.UML_Type_Access);
   --  Setter of TypedElement::type.
   --
   --  The type of the TypedElement.
   --  This information is derived from the return result for this Operation.

   overriding function Get_Client_Dependency
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Dependencies.Collections.Set_Of_UML_Dependency;
   --  Getter of NamedElement::clientDependency.
   --
   --  Indicates the dependencies that reference the client.

   overriding function Get_Name
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.Optional_String;
   --  Getter of NamedElement::name.
   --
   --  The name of the NamedElement.

   overriding procedure Set_Name
    (Self : not null access OCL_Expression_In_Ocl_Proxy;
     To   : AMF.Optional_String);
   --  Setter of NamedElement::name.
   --
   --  The name of the NamedElement.

   overriding function Get_Name_Expression
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.String_Expressions.UML_String_Expression_Access;
   --  Getter of NamedElement::nameExpression.
   --
   --  The string expression used to define the name of this named element.

   overriding procedure Set_Name_Expression
    (Self : not null access OCL_Expression_In_Ocl_Proxy;
     To   : AMF.UML.String_Expressions.UML_String_Expression_Access);
   --  Setter of NamedElement::nameExpression.
   --
   --  The string expression used to define the name of this named element.

   overriding function Get_Namespace
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Namespaces.UML_Namespace_Access;
   --  Getter of NamedElement::namespace.
   --
   --  Specifies the namespace that owns the NamedElement.

   overriding function Get_Qualified_Name
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.Optional_String;
   --  Getter of NamedElement::qualifiedName.
   --
   --  A name which allows the NamedElement to be identified within a 
   --  hierarchy of nested Namespaces. It is constructed from the names of the 
   --  containing namespaces starting at the root of the hierarchy and ending 
   --  with the name of the NamedElement itself.

   overriding function Get_Visibility
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Optional_UML_Visibility_Kind;
   --  Getter of NamedElement::visibility.
   --
   --  Determines where the NamedElement appears within different Namespaces 
   --  within the overall model, and its accessibility.

   overriding procedure Set_Visibility
    (Self : not null access OCL_Expression_In_Ocl_Proxy;
     To   : AMF.UML.Optional_UML_Visibility_Kind);
   --  Setter of NamedElement::visibility.
   --
   --  Determines where the NamedElement appears within different Namespaces 
   --  within the overall model, and its accessibility.

   overriding function Get_Owned_Comment
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Comments.Collections.Set_Of_UML_Comment;
   --  Getter of Element::ownedComment.
   --
   --  The Comments owned by this element.

   overriding function Get_Owned_Element
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Elements.Collections.Set_Of_UML_Element;
   --  Getter of Element::ownedElement.
   --
   --  The Elements owned by this element.

   overriding function Get_Owner
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Elements.UML_Element_Access;
   --  Getter of Element::owner.
   --
   --  The Element that owns this element.

   overriding function Get_Visibility
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.UML_Visibility_Kind;
   --  Getter of PackageableElement::visibility.
   --
   --  Indicates that packageable elements must always have a visibility, 
   --  i.e., visibility is not optional.

   overriding procedure Set_Visibility
    (Self : not null access OCL_Expression_In_Ocl_Proxy;
     To   : AMF.UML.UML_Visibility_Kind);
   --  Setter of PackageableElement::visibility.
   --
   --  Indicates that packageable elements must always have a visibility, 
   --  i.e., visibility is not optional.

   overriding function Get_Owning_Template_Parameter
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Template_Parameters.UML_Template_Parameter_Access;
   --  Getter of ParameterableElement::owningTemplateParameter.
   --
   --  The formal template parameter that owns this element.

   overriding procedure Set_Owning_Template_Parameter
    (Self : not null access OCL_Expression_In_Ocl_Proxy;
     To   : AMF.UML.Template_Parameters.UML_Template_Parameter_Access);
   --  Setter of ParameterableElement::owningTemplateParameter.
   --
   --  The formal template parameter that owns this element.

   overriding function Get_Template_Parameter
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Template_Parameters.UML_Template_Parameter_Access;
   --  Getter of ParameterableElement::templateParameter.
   --
   --  The template parameter that exposes this element as a formal parameter.

   overriding procedure Set_Template_Parameter
    (Self : not null access OCL_Expression_In_Ocl_Proxy;
     To   : AMF.UML.Template_Parameters.UML_Template_Parameter_Access);
   --  Setter of ParameterableElement::templateParameter.
   --
   --  The template parameter that exposes this element as a formal parameter.

   overriding function Is_Integral
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return Boolean;
   --  Operation OpaqueExpression::isIntegral.
   --
   --  The query isIntegral() tells whether an expression is intended to 
   --  produce an integer.

   overriding function Is_Non_Negative
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return Boolean;
   --  Operation OpaqueExpression::isNonNegative.
   --
   --  The query isNonNegative() tells whether an integer expression has a 
   --  non-negative value.

   overriding function Is_Positive
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return Boolean;
   --  Operation OpaqueExpression::isPositive.
   --
   --  The query isPositive() tells whether an integer expression has a 
   --  positive value.

   overriding function Result
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Parameters.UML_Parameter_Access;
   --  Operation OpaqueExpression::result.
   --
   --  Missing derivation for OpaqueExpression::/result : Parameter

   overriding function Value
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return Integer;
   --  Operation OpaqueExpression::value.
   --
   --  The query value() gives an integer value for an expression intended to 
   --  produce one.

   overriding function Boolean_Value
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.Optional_Boolean;
   --  Operation ValueSpecification::booleanValue.
   --
   --  The query booleanValue() gives a single Boolean value when one can be 
   --  computed.

   overriding function Integer_Value
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.Optional_Integer;
   --  Operation ValueSpecification::integerValue.
   --
   --  The query integerValue() gives a single Integer value when one can be 
   --  computed.

   overriding function Is_Compatible_With
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy;
     P : AMF.UML.Parameterable_Elements.UML_Parameterable_Element_Access)
       return Boolean;
   --  Operation ValueSpecification::isCompatibleWith.
   --
   --  The query isCompatibleWith() determines if this parameterable element 
   --  is compatible with the specified parameterable element. By default 
   --  parameterable element P is compatible with parameterable element Q if 
   --  the kind of P is the same or a subtype as the kind of Q. In addition, 
   --  for ValueSpecification, the type must be conformant with the type of 
   --  the specified parameterable element.

   overriding function Is_Computable
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return Boolean;
   --  Operation ValueSpecification::isComputable.
   --
   --  The query isComputable() determines whether a value specification can 
   --  be computed in a model. This operation cannot be fully defined in OCL. 
   --  A conforming implementation is expected to deliver true for this 
   --  operation for all value specifications that it can compute, and to 
   --  compute all of those for which the operation is true. A conforming 
   --  implementation is expected to be able to compute the value of all 
   --  literals.

   overriding function Is_Null
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return Boolean;
   --  Operation ValueSpecification::isNull.
   --
   --  The query isNull() returns true when it can be computed that the value 
   --  is null.

   overriding function Real_Value
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.Optional_Real;
   --  Operation ValueSpecification::realValue.
   --
   --  The query realValue() gives a single Real value when one can be 
   --  computed.

   overriding function String_Value
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.Optional_String;
   --  Operation ValueSpecification::stringValue.
   --
   --  The query stringValue() gives a single String value when one can be 
   --  computed.

   overriding function Unlimited_Value
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.Optional_Unlimited_Natural;
   --  Operation ValueSpecification::unlimitedValue.
   --
   --  The query unlimitedValue() gives a single UnlimitedNatural value when 
   --  one can be computed.

   overriding function All_Namespaces
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Namespaces.Collections.Ordered_Set_Of_UML_Namespace;
   --  Operation NamedElement::allNamespaces.
   --
   --  The query allNamespaces() gives the sequence of namespaces in which the 
   --  NamedElement is nested, working outwards.

   overriding function All_Owning_Packages
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Packages.Collections.Set_Of_UML_Package;
   --  Operation NamedElement::allOwningPackages.
   --
   --  The query allOwningPackages() returns all the directly or indirectly 
   --  owning packages.

   overriding function Is_Distinguishable_From
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy;
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
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Namespaces.UML_Namespace_Access;
   --  Operation NamedElement::namespace.
   --
   --  Missing derivation for NamedElement::/namespace : Namespace

   overriding function Qualified_Name
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return League.Strings.Universal_String;
   --  Operation NamedElement::qualifiedName.
   --
   --  When there is a name, and all of the containing namespaces have a name, 
   --  the qualified name is constructed from the names of the containing 
   --  namespaces.

   overriding function Separator
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return League.Strings.Universal_String;
   --  Operation NamedElement::separator.
   --
   --  The query separator() gives the string that is used to separate names 
   --  when constructing a qualified name.

   overriding function All_Owned_Elements
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return AMF.UML.Elements.Collections.Set_Of_UML_Element;
   --  Operation Element::allOwnedElements.
   --
   --  The query allOwnedElements() gives all of the direct and indirect owned 
   --  elements of an element.

   overriding function Must_Be_Owned
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return Boolean;
   --  Operation Element::mustBeOwned.
   --
   --  The query mustBeOwned() indicates whether elements of this type must 
   --  have an owner. Subclasses of Element that do not require an owner must 
   --  override this operation.

   overriding function Is_Template_Parameter
    (Self : not null access constant OCL_Expression_In_Ocl_Proxy)
       return Boolean;
   --  Operation ParameterableElement::isTemplateParameter.
   --
   --  The query isTemplateParameter() determines if this parameterable 
   --  element is exposed as a formal template parameter.

   overriding procedure Enter_Element
    (Self    : not null access constant OCL_Expression_In_Ocl_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Leave_Element
    (Self    : not null access constant OCL_Expression_In_Ocl_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Visit_Element
    (Self     : not null access constant OCL_Expression_In_Ocl_Proxy;
     Iterator : in out AMF.Visitors.Abstract_Iterator'Class;
     Visitor  : in out AMF.Visitors.Abstract_Visitor'Class;
     Control  : in out AMF.Visitors.Traverse_Control);

end AMF.Internals.OCL_Expression_In_Ocls;
