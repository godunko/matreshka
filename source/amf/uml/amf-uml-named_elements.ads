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
--  A named element supports using a string expression to specify its name. 
--  This allows names of model elements to involve template parameters. The 
--  actual name is evaluated from the string expression only when it is 
--  sensible to do so (e.g., when a template is bound).
--  
--  A named element is an element in a model that may have a name.
------------------------------------------------------------------------------
limited with AMF.UML.Dependencies.Collections;
with AMF.UML.Elements;
limited with AMF.UML.Namespaces.Collections;
limited with AMF.UML.Packages.Collections;
limited with AMF.UML.String_Expressions;
with League.Strings;

package AMF.UML.Named_Elements is

   pragma Preelaborate;

   type UML_Named_Element is limited interface
     and AMF.UML.Elements.UML_Element;

   type UML_Named_Element_Access is
     access all UML_Named_Element'Class;
   for UML_Named_Element_Access'Storage_Size use 0;

   not overriding function Get_Client_Dependency
    (Self : not null access constant UML_Named_Element)
       return AMF.UML.Dependencies.Collections.Set_Of_UML_Dependency is abstract;
   --  Getter of NamedElement::clientDependency.
   --
   --  Indicates the dependencies that reference the client.

   not overriding function Get_Name
    (Self : not null access constant UML_Named_Element)
       return AMF.Optional_String is abstract;
   --  Getter of NamedElement::name.
   --
   --  The name of the NamedElement.

   not overriding procedure Set_Name
    (Self : not null access UML_Named_Element;
     To   : AMF.Optional_String) is abstract;
   --  Setter of NamedElement::name.
   --
   --  The name of the NamedElement.

   not overriding function Get_Name_Expression
    (Self : not null access constant UML_Named_Element)
       return AMF.UML.String_Expressions.UML_String_Expression_Access is abstract;
   --  Getter of NamedElement::nameExpression.
   --
   --  The string expression used to define the name of this named element.

   not overriding procedure Set_Name_Expression
    (Self : not null access UML_Named_Element;
     To   : AMF.UML.String_Expressions.UML_String_Expression_Access) is abstract;
   --  Setter of NamedElement::nameExpression.
   --
   --  The string expression used to define the name of this named element.

   not overriding function Get_Namespace
    (Self : not null access constant UML_Named_Element)
       return AMF.UML.Namespaces.UML_Namespace_Access is abstract;
   --  Getter of NamedElement::namespace.
   --
   --  Specifies the namespace that owns the NamedElement.

   not overriding function Get_Qualified_Name
    (Self : not null access constant UML_Named_Element)
       return AMF.Optional_String is abstract;
   --  Getter of NamedElement::qualifiedName.
   --
   --  A name which allows the NamedElement to be identified within a 
   --  hierarchy of nested Namespaces. It is constructed from the names of the 
   --  containing namespaces starting at the root of the hierarchy and ending 
   --  with the name of the NamedElement itself.

   not overriding function Get_Visibility
    (Self : not null access constant UML_Named_Element)
       return AMF.UML.Optional_UML_Visibility_Kind is abstract;
   --  Getter of NamedElement::visibility.
   --
   --  Determines where the NamedElement appears within different Namespaces 
   --  within the overall model, and its accessibility.

   not overriding procedure Set_Visibility
    (Self : not null access UML_Named_Element;
     To   : AMF.UML.Optional_UML_Visibility_Kind) is abstract;
   --  Setter of NamedElement::visibility.
   --
   --  Determines where the NamedElement appears within different Namespaces 
   --  within the overall model, and its accessibility.

   not overriding function All_Namespaces
    (Self : not null access constant UML_Named_Element)
       return AMF.UML.Namespaces.Collections.Ordered_Set_Of_UML_Namespace is abstract;
   --  Operation NamedElement::allNamespaces.
   --
   --  The query allNamespaces() gives the sequence of namespaces in which the 
   --  NamedElement is nested, working outwards.

   not overriding function All_Owning_Packages
    (Self : not null access constant UML_Named_Element)
       return AMF.UML.Packages.Collections.Set_Of_UML_Package is abstract;
   --  Operation NamedElement::allOwningPackages.
   --
   --  The query allOwningPackages() returns all the directly or indirectly 
   --  owning packages.

   not overriding function Is_Distinguishable_From
    (Self : not null access constant UML_Named_Element;
     N : AMF.UML.Named_Elements.UML_Named_Element_Access;
     Ns : AMF.UML.Namespaces.UML_Namespace_Access)
       return Boolean is abstract;
   --  Operation NamedElement::isDistinguishableFrom.
   --
   --  The query isDistinguishableFrom() determines whether two NamedElements 
   --  may logically co-exist within a Namespace. By default, two named 
   --  elements are distinguishable if (a) they have unrelated types or (b) 
   --  they have related types but different names.

   not overriding function Namespace
    (Self : not null access constant UML_Named_Element)
       return AMF.UML.Namespaces.UML_Namespace_Access is abstract;
   --  Operation NamedElement::namespace.
   --
   --  Missing derivation for NamedElement::/namespace : Namespace

   not overriding function Qualified_Name
    (Self : not null access constant UML_Named_Element)
       return League.Strings.Universal_String is abstract;
   --  Operation NamedElement::qualifiedName.
   --
   --  When there is a name, and all of the containing namespaces have a name, 
   --  the qualified name is constructed from the names of the containing 
   --  namespaces.

   not overriding function Separator
    (Self : not null access constant UML_Named_Element)
       return League.Strings.Universal_String is abstract;
   --  Operation NamedElement::separator.
   --
   --  The query separator() gives the string that is used to separate names 
   --  when constructing a qualified name.

end AMF.UML.Named_Elements;
