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
limited with Matreshka.XML_Schema.AST.Annotations;
limited with Matreshka.XML_Schema.AST.Assertions;
limited with Matreshka.XML_Schema.AST.Attribute_Declarations;
limited with Matreshka.XML_Schema.AST.Attribute_Groups;
limited with Matreshka.XML_Schema.AST.Attribute_Uses;
limited with Matreshka.XML_Schema.AST.Complex_Types;
limited with Matreshka.XML_Schema.AST.Constraining_Facets;
limited with Matreshka.XML_Schema.AST.Element_Declarations;
limited with Matreshka.XML_Schema.AST.Identity_Constraints;
limited with Matreshka.XML_Schema.AST.Models;
limited with Matreshka.XML_Schema.AST.Model_Groups;
limited with Matreshka.XML_Schema.AST.Namespaces;
limited with Matreshka.XML_Schema.AST.Notation_Declarations;
limited with Matreshka.XML_Schema.AST.Particles;
limited with Matreshka.XML_Schema.AST.Schemas;
limited with Matreshka.XML_Schema.AST.Simple_Types;
limited with Matreshka.XML_Schema.AST.Type_Alternatives;
limited with Matreshka.XML_Schema.AST.Wildcards;
limited with Matreshka.XML_Schema.Visitors;

package Matreshka.XML_Schema.AST is

   pragma Preelaborate;

   type Type_Derivation_Control is
     (Extension, Restriction, List, Union, Substitution);

   type Derivation_Set is array (Type_Derivation_Control) of Boolean;
   pragma Pack (Derivation_Set);

   type Simple_Type_Variety is (Absent, Atomic, List, Union);

   -------------------
   -- Abstract_Node --
   -------------------

   type Abstract_Node is abstract tagged limited null record;

   not overriding procedure Enter_Node
    (Self    : not null access Abstract_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
       is abstract;
   --  Dispatch call to corresponding subprogram of visitor interface.

   not overriding procedure Leave_Node
    (Self    : not null access Abstract_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
       is abstract;
   --  Dispatch call to corresponding subprogram of visitor interface.

   not overriding procedure Visit_Node
    (Self     : not null access Abstract_Node;
     Iterator : in out Matreshka.XML_Schema.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control  : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
       is abstract;
   --  Dispatch call to corresponding subprogram of iterator interface.

   -----------------------------------
   -- Access types for nodes of AST --
   -----------------------------------

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
   type Model_Access is access all Models.Model_Node'Class;
   type Model_Group_Access is access all Model_Groups.Model_Group_Node'Class;
   type Model_Group_Definition_Access is
     access all Model_Groups.Model_Group_Definition_Node'Class;
   type Namespace_Access is access all Namespaces.Namespace_Node'Class;
   type Notation_Declaration_Access is
     access all Notation_Declarations.Notation_Declaration_Node'Class;
   type Node_Access is access all Abstract_Node'Class;
   type Particle_Access is access all Particles.Particle_Node'Class;
   type Schema_Access is access all Schemas.Schema_Node'Class;
   type Simple_Type_Definition_Access is
     access all Simple_Types.Simple_Type_Definition_Node'Class;
   type Type_Alternative_Access is
     access all Type_Alternatives.Type_Alternative_Node'Class;
   type Wildcard_Access is access all Wildcards.Wildcard_Node'Class;

end Matreshka.XML_Schema.AST;
