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

with Ada.Containers.Doubly_Linked_Lists;
with Ada.Containers.Hashed_Maps;
with Ada.Containers.Hashed_Sets;

with League.Strings;
with League.Strings.Hash;

limited with Matreshka.XML_Schema.AST.Annotations;
limited with Matreshka.XML_Schema.AST.Assertions;
limited with Matreshka.XML_Schema.AST.Attribute_Declarations;
limited with Matreshka.XML_Schema.AST.Attribute_Groups;
limited with Matreshka.XML_Schema.AST.Attribute_Uses;
limited with Matreshka.XML_Schema.AST.Complex_Types;
limited with Matreshka.XML_Schema.AST.Constraining_Facets;
limited with Matreshka.XML_Schema.AST.Element_Declarations;
limited with Matreshka.XML_Schema.AST.Identity_Constraints;
limited with Matreshka.XML_Schema.AST.Model_Groups;
limited with Matreshka.XML_Schema.AST.Notation_Declarations;
limited with Matreshka.XML_Schema.AST.Particles;
limited with Matreshka.XML_Schema.AST.Schemas;
limited with Matreshka.XML_Schema.AST.Simple_Types;
limited with Matreshka.XML_Schema.AST.Type_Alternatives;
limited with Matreshka.XML_Schema.AST.Wildcards;

package Matreshka.XML_Schema.AST.Types is

   pragma Preelaborate;

   type Abstract_Node_Access is access all Abstract_Node'Class;

   type Term_Node is abstract new Abstract_Node with null record;

   type Term_Access is access all Term_Node'Class;

   type Type_Definition_Node is abstract new Abstract_Node with null record;

   type Type_Definition_Access is access all Type_Definition_Node'Class;

   type Annotation_Access is access all Annotations.Annotation_Node'Class;

   type Assertion_Access is access all Assertions.Assertion_Node'Class;

   type Attribute_Declaration_Access is
     access all Attribute_Declarations.Attribute_Declaration_Node'Class;

   type Attribute_Group_Definition_Access is
     access all Attribute_Groups.Attribute_Group_Definition_Node'Class;

   type Attribute_Group_Reference_Access is
     access all Attribute_Groups.Attribute_Group_Reference_Node'Class;

   type Attribute_Use_Access is
     access all Attribute_Uses.Attribute_Use_Node'Class;

   type Complex_Type_Definition_Access is
     access all Complex_Types.Complex_Type_Definition_Node'Class;

   type Element_Declaration_Access is
     access all Element_Declarations.Element_Declaration_Node'Class;

   type Enumeration_Access is
     access all Constraining_Facets.Enumeration_Node'Class;

   type Identity_Constraint_Definition_Access is
     access all Identity_Constraints.Identity_Constraint_Definition_Node'Class;

   type Min_Length_Access is
     access all Constraining_Facets.Min_Length_Node'Class;

   type Model_Group_Definition_Access is
     access all Model_Groups.Model_Group_Definition_Node'Class;

   type Model_Group_Access is access all Model_Groups.Model_Group_Node'Class;

   type Notation_Declaration_Access is
     access all Notation_Declarations.Notation_Declaration_Node'Class;

   type Particle_Access is access all Particles.Particle_Node'Class;

   type Schema_Access is access all Schemas.Schema_Node'Class;

   type Simple_Type_Definition_Access is
     access all Simple_Types.Simple_Type_Definition_Node'Class;

   type Type_Alternative_Access is
     access all Type_Alternatives.Type_Alternative_Node'Class;

   type Wildcard_Access is access all Wildcards.Wildcard_Node'Class;

   package Annotation_Lists is
     new Ada.Containers.Doubly_Linked_Lists (Annotation_Access);

   package Assertion_Lists is
     new Ada.Containers.Doubly_Linked_Lists (Assertion_Access);

   package Attribute_Declaration_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           Matreshka.XML_Schema.AST.Types.Attribute_Declaration_Access,
           League.Strings.Hash,
           League.Strings."=",
           Matreshka.XML_Schema.AST.Types."=");

   package Attribute_Group_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           Matreshka.XML_Schema.AST.Types.Attribute_Group_Definition_Access,
           League.Strings.Hash,
           League.Strings."=",
           Matreshka.XML_Schema.AST.Types."=");

   package Attribute_Use_Sets is
     new Ada.Containers.Doubly_Linked_Lists (Attribute_Use_Access);

   package Identity_Constraint_Definition_Sets is
     new Ada.Containers.Doubly_Linked_Lists
       (Identity_Constraint_Definition_Access);

   package Model_Group_Definition_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           Model_Group_Definition_Access,
           League.Strings.Hash,
           League.Strings."=",
           Matreshka.XML_Schema.AST.Types."=");

   package Notation_Declaration_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           Notation_Declaration_Access,
           League.Strings.Hash,
           League.Strings."=",
           Matreshka.XML_Schema.AST.Types."=");

   package Particle_Lists is
     new Ada.Containers.Doubly_Linked_Lists (Particle_Access);

   package Simple_Type_Definition_Lists is
     new Ada.Containers.Doubly_Linked_Lists (Simple_Type_Definition_Access);

   package Type_Alternative_Lists is
     new Ada.Containers.Doubly_Linked_Lists
       (Type_Alternative_Access);

   package Type_Definition_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           Matreshka.XML_Schema.AST.Types.Type_Definition_Access,
           League.Strings.Hash,
           League.Strings."=",
           Matreshka.XML_Schema.AST.Types."=");

   package Element_Declaration_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           Matreshka.XML_Schema.AST.Types.Element_Declaration_Access,
           League.Strings.Hash,
           League.Strings."=",
           Matreshka.XML_Schema.AST.Types."=");

   type Scope_Variety is (Global, Local);

   type Scope (Variety : Scope_Variety := Local) is record
   --  {variety}
   --  One of {global, local}. Required.
   --  {parent}
   --  Either a Complex Type Definition or a Attribute Group Definition.
   --  Required if {variety} is local, otherwise must be ·absent·
      case Variety is
         when Local =>
            Parent : Types.Abstract_Node_Access;
         when Global =>
            null;
      end case;
   end record;

   type Value_Constraint_Variety is (Absent, Default, Fixed);

   type Value_Constraint is record
      --  {variety}
      --  One of {default, fixed}. Required.
      --  {value}
      --  An ·actual value·. Required.
      --  {lexical form}
      --  A character string. Required.
      Variety      : Value_Constraint_Variety := Absent;
      Value        : League.Strings.Universal_String;
      Lexical_Form : League.Strings.Universal_String;
   end record;

   type Namespace_Binding is record
      Name  : League.Strings.Universal_String;
      --  {prefix}
      --  An xs:NCName value. Required.
      --  {namespace}
      Namespace  : League.Strings.Universal_String;
      --  An xs:anyURI value. Required.
   end record;

   use type Ada.Containers.Hash_Type;

   function Hash (Self : Namespace_Binding) return Ada.Containers.Hash_Type is
      (League.Strings.Hash (Self.Name) + League.Strings.Hash (Self.Namespace));

   package Namespace_Binding_Sets is
     new Ada.Containers.Hashed_Sets (Namespace_Binding, Hash, "=");

   type XPath_Expression is record
      Namespace_Bindings : Namespace_Binding_Sets.Set;
      --  {namespace bindings}
      --  A set of Namespace Binding property records.

      Default_Namespace : League.Strings.Universal_String;
      --  {default namespace}
      --  An xs:anyURI value. Optional.

      Base_URI : League.Strings.Universal_String;
      --  {base URI}
      --  An xs:anyURI value. Optional.

      Expression : League.Strings.Universal_String;
      --  {expression}
      --  An [XPath 2.0] expression. Required.
   end record;

   package XPath_Expression_Lists is
     new Ada.Containers.Doubly_Linked_Lists
       (XPath_Expression);

   package Facet_Sets is
     new Ada.Containers.Doubly_Linked_Lists (Abstract_Node_Access);

   package Attribute_Group_Reference_Lists is
     new Ada.Containers.Doubly_Linked_Lists (Attribute_Group_Reference_Access);

end Matreshka.XML_Schema.AST.Types;
