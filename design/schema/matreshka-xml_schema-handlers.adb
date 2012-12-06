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
with League.String_Vectors;
with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Simple_Readers;

with Matreshka.XML_Schema.AST.Attribute_Declarations;
with Matreshka.XML_Schema.AST.Attribute_Groups;
with Matreshka.XML_Schema.AST.Attribute_Uses;
with Matreshka.XML_Schema.AST.Complex_Types;
with Matreshka.XML_Schema.AST.Constraining_Facets;
with Matreshka.XML_Schema.AST.Element_Declarations;
with Matreshka.XML_Schema.AST.Identity_Constraints;
with Matreshka.XML_Schema.AST.Model_Groups;
with Matreshka.XML_Schema.AST.Notation_Declarations;
with Matreshka.XML_Schema.AST.Particles;
with Matreshka.XML_Schema.AST.Schemas;
with Matreshka.XML_Schema.AST.Simple_Types;
with Matreshka.XML_Schema.AST.Types;
with Matreshka.XML_Schema.AST.Wildcards;
with Ada.Wide_Wide_Text_IO;


package body Matreshka.XML_Schema.Handlers is

   use type League.Strings.Universal_String;

   XML_Schema_Namespace_URI          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://www.w3.org/2001/XMLSchema");

   Annotation_Element_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("annotation");
   Any_Attribute_Element_Name        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("anyAttribute");
   Any_Element_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("any");
   Attribute_Element_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("attribute");
   Attribute_Group_Element_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("attributeGroup");
   Choice_Element_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("choice");
   Complex_Content_Element_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("complexContent");
   Complex_Type_Element_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("complexType");
   Enumeration_Element_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("enumeration");
   Element_Element_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("element");
   Extension_Element_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extension");
   Field_Element_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("field");
   Group_Element_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("group");
   Import_Element_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("import");
   Key_Element_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("key");
   List_Element_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list");
   Min_Length_Element_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("minLength");
   Notation_Element_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("notation");
   Restriction_Element_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("restriction");
   Schema_Element_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("schema");
   Selector_Element_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("selector");
   Sequence_Element_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sequence");
   Simple_Type_Element_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("simpleType");
   Union_Element_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("union");

   Abstract_Attribute_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("abstract");
   Attribute_Form_Default_Attribute_Name :
     constant League.Strings.Universal_String
       := League.Strings.To_Universal_String ("attributeFormDefault");
   Base_Attribute_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("base");
   Block_Attribute_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("block");
   Block_Default_Attribute_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("blockDefault");
   Default_Attribute_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("default");
   Default_Attributes_Attribute_Name : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("defaultAttributes");
   Element_Form_Default_Attribute_Name :
     constant League.Strings.Universal_String
       := League.Strings.To_Universal_String ("elementFormDefault");
   Final_Attribute_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("final");
   Final_Default_Attribute_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("finalDefault");
   Fixed_Attribute_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fixed");
   Form_Attribute_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("form");
   Id_Attribute_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("id");
   Inheritable_Attribute_Name        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("inheritable");
   Item_Type_Attribute_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("itemType");
   Name_Attribute_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("name");
   Namespace_Attribute_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("namespace");
   Not_Namespace_Attribute_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("notNamespace");
   Not_QName_Attribute_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("notQName");
   Member_Types_Attribute_Name       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("memberTypes");
   Max_Occurs_Attribute_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("maxOccurs");
   Min_Occurs_Attribute_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("minOccurs");
   Nillable_Attribute_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("nillable");
   Process_Contents_Attribute_Name   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("processContents");
   Ref_Attribute_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ref");
   Substitution_Group_Attribute_Name : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("substitutionGroup");
   Schema_Location_Attribute_Name    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("schemaLocation");
   Target_Namespace_Attribute_Name   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("targetNamespace");
   Type_Attribute_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("type");
   Use_Attribute_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use");
   Value_Attribute_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("value");
   Version_Attribute_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("version");
   XPath_Attribute_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xpath");
   Xpath_Default_Namespace_Attribute_Name :
     constant League.Strings.Universal_String
       := League.Strings.To_Universal_String ("xpathDefaultNamespace");

   Any_Literal_Image : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("##any");
   Other_Literal_Image : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("##other");
   Target_Namespace_Literal_Image : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("##targetNamespace");
   Local_Literal_Image : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("##local");
   Defined_Literal_Image : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("##defined");
   Defined_Sibling_Literal_Image : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("##definedSibling");
   Unbounded_Literal_Image : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("unbounded");
   Prohibited_Literal_Image : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("prohibited");
   Required_Literal_Image : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("required");

   function To_Derivation_Set
    (Image : League.Strings.Universal_String)
       return Matreshka.XML_Schema.AST.Derivation_Set;
   --  Converts textual representation of fullDerivationSet datatype into
   --  internal representation. It assumes that textual representation is
   --  normalized according to XML rules.

   procedure Start_Schema_Element
    (Self       : in out XML_Schema_Handler;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean);
   --  Process start of 'schema' element.

   procedure Start_Import_Element
    (Self       : in out XML_Schema_Handler;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean);
   --  Process start of 'import' element.

   procedure Get_Value_Constant
     (Node       : in out AST.Types.Value_Constraint;
      Attributes : XML.SAX.Attributes.SAX_Attributes);

   package Declarations is
      --  This package groups subprograms to handle declarative component.

      procedure Create_Model_Group
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Compositor : AST.Model_Groups.Compositor_Kind;
         Success    : in out Boolean);

      procedure Common_Element_Declaration
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Node       : AST.Types.Element_Declaration_Access;
         Success    : in out Boolean);

      procedure Local_Attribute_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Node       : out Matreshka.XML_Schema.AST.Types.Attribute_Use_Access;
         Success    : in out Boolean);

      procedure Start_Top_Level_Attribute_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean);
      --  Process start of top-level 'attribute' element.

      procedure End_Attribute_Element
        (Self    : in out XML_Schema_Handler;
         Success : in out Boolean) is null;
      --  Process end of 'attribute' element.

      procedure Start_Top_Level_Attribute_Group_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean);
      --  Process start of top-level 'attributeGroup' element.

      procedure End_Attribute_Group_Element
        (Self    : in out XML_Schema_Handler;
         Success : in out Boolean) is null;

      procedure Start_Group_Level_Attribute_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean);
      --  Process start of 'attribute' element nested in 'attributeGroup'

      procedure Start_Top_Level_Model_Definition_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean);
      --  Process start of 'group' element

      procedure End_Model_Definition_Element
        (Self       : in out XML_Schema_Handler;
         Success    : in out Boolean) is null;

      procedure Start_Group_Level_Choice_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean);
      --  Process start of 'choice' element

      procedure End_Choice_Element
        (Self       : in out XML_Schema_Handler;
         Success    : in out Boolean) is null;

      procedure Start_Group_Level_Sequence_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean);
      --  Process start of 'sequence' element inside 'group'

      procedure Start_Top_Level_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean);
      --  Process start of 'element' element

      procedure Start_Constraint_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Category   : AST.Identity_Constraints.Category;
         Success    : in out Boolean);
      --  Process start of 'key', 'keyref' or 'unique' element

      procedure End_Constraint_Element
        (Self       : in out XML_Schema_Handler;
         Success    : in out Boolean) is null;

      procedure Start_Selector_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean);

      procedure End_Selector_Element
        (Self       : in out XML_Schema_Handler;
         Success    : in out Boolean) is null;

      procedure Start_Field_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean);

      procedure End_Field_Element
        (Self       : in out XML_Schema_Handler;
         Success    : in out Boolean) is null;

      procedure Start_Notation_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean);

      procedure End_Notation_Element
        (Self       : in out XML_Schema_Handler;
         Success    : in out Boolean) is null;


   end Declarations;

   package XSD_Attribute is
      --  Tools to easy read/reject XSD defined attributes

      procedure Required
        (Name       : League.Strings.Universal_String;
         Value      : out League.Strings.Universal_String;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Title      : String);
      --  Check if attr with given Name exist, return it's Value.
      --  Raise exception otherwise, pointing element's Title.

      procedure Required
        (Name       : League.Strings.Universal_String;
         Value      : out Integer;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Title      : String);
      --  The same, but with Integer value

      procedure Prohibited
        (Name       : League.Strings.Universal_String;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Title      : String);
      --  Check if attr with given Name absent.
      --  Raise exception otherwise, pointing element's Title.

      function To_Boolean
        (Attributes : XML.SAX.Attributes.SAX_Attributes;
         Name       : League.Strings.Universal_String;
         Default    : Boolean := False)
         return Boolean;
      --  Return value of Boolean attribute with given Name

   end XSD_Attribute;

   package Facets is
      --  This package groups subprograms to handle facets.

      procedure Start_Enumeration_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of 'enumeration' element.

      procedure End_Enumeration_Element
       (Self       : in out XML_Schema_Handler;
        Success    : in out Boolean) is null;

      procedure Start_Min_Length_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of 'minLength' element.

      procedure End_Min_Length_Element
       (Self       : in out XML_Schema_Handler;
        Success    : in out Boolean) is null;

   end Facets;

   package Complex_Types is

      --  This package groups subprograms to handle complex type declaration.

      procedure Create_Particle
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean;
        Node       : out Matreshka.XML_Schema.AST.Types.Particle_Access);
      --  Allocate new Particle and fill it's properties

      procedure Create_Wildcard
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean;
        Node       : out Matreshka.XML_Schema.AST.Types.Wildcard_Access);
      --  Allocate new Wildcard and fill it's properties

      procedure Start_Top_Level_Complex_Type_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of top-level 'complexType' element.

      procedure End_Complex_Type_Element
       (Self    : in out XML_Schema_Handler;
        Success : in out Boolean);
      --  Process end of 'complexType' element.

      procedure Start_Complex_Content_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of 'complexContent' element.

      procedure End_Complex_Content_Element
       (Self    : in out XML_Schema_Handler;
        Success : in out Boolean) is null;
      --  Process end of 'complexContent' element.

      procedure Start_Restriction_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);

      procedure Start_Any_Attribute_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);

      procedure End_Any_Attribute_Element
       (Self       : in out XML_Schema_Handler;
        Success    : in out Boolean) is null;

      procedure Start_Extension_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);

      procedure End_Extension_Element
       (Self       : in out XML_Schema_Handler;
        Success    : in out Boolean) is null;

      procedure Start_Sequence_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);

      procedure End_Sequence_Element
       (Self       : in out XML_Schema_Handler;
        Success    : in out Boolean) is null;

      procedure Start_Attribute_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);

      --        procedure End_Attribute_Element
      --         (Self       : in out XML_Schema_Handler;
      --          Success    : in out Boolean)
      --          renames Declarations.End_Attribute_Element;

      procedure Start_Attribute_Group_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);

      procedure End_Attribute_Group_Element
       (Self       : in out XML_Schema_Handler;
        Success    : in out Boolean) is null;

      procedure Start_Group_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);

      procedure Start_Element_Level_Complex_Type_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of 'complexType' element inside 'element' element.

      procedure Start_Choice_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);

      procedure Start_Type_Level_Sequence_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  'sequence' element inside 'complexType'

      procedure Start_Any_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  'any' element

      procedure End_Any_Element
       (Self       : in out XML_Schema_Handler;
        Success    : in out Boolean) is null;

      procedure Start_Type_Level_Attribute_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  'attribute' element inside 'complexType'

      procedure Start_Type_Level_Any_Attribute_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  'anyAttribute' element inside 'complexType'

   end Complex_Types;

   package Simple_Types is

      --  This package groups subprograms to handle simple type declaration.

      procedure Start_Restriction_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of 'restriction' element.

      procedure End_Restriction_Element
       (Self    : in out XML_Schema_Handler;
        Success : in out Boolean);
      --  Process end of 'restriction' element.

      procedure Start_Local_Simple_Type_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of nested 'simpleType' element.

      procedure Start_Attribute_Level_Simple_Type_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of 'simpleType' element inside 'attribute' element.

      procedure Start_Top_Level_Simple_Type_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of top-level 'simpleType' element.

      procedure Start_Union_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of 'union' element.

      procedure Start_Union_Level_Simple_Type_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of 'simpleType' element inside 'union' element.

      procedure End_Simple_Type_Element
       (Self    : in out XML_Schema_Handler;
        Success : in out Boolean);
      --  Process end of 'simpleType' element.

      procedure End_Union_Element
       (Self    : in out XML_Schema_Handler;
        Success : in out Boolean);
      --  Process end of 'union' element.

      procedure Start_List_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of 'list' element.

      procedure End_List_Element
       (Self    : in out XML_Schema_Handler;
        Success : in out Boolean) is null;
      --  Process end of 'list' element.

      procedure Start_List_Level_Simple_Type_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of 'simpleType' element inside 'list' element.

   end Simple_Types;

   package Particles is
      --  This package groups subprograms to handle particle components.
      procedure Start_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);

      procedure End_Element
       (Self       : in out XML_Schema_Handler;
        Success    : in out Boolean) is null;

      procedure Start_Group_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);

      procedure Start_Group_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Node       : out Matreshka.XML_Schema.AST.Types.Particle_Access;
        Success    : in out Boolean);

      procedure Start_Choice_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);

      procedure Start_Choice_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Node       : out Matreshka.XML_Schema.AST.Types.Particle_Access;
        Success    : in out Boolean);

      procedure Start_Sequence_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);

      procedure Start_Sequence_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Node       : out Matreshka.XML_Schema.AST.Types.Particle_Access;
        Success    : in out Boolean);

      procedure Start_Any_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);

   end Particles;

   package body Complex_Types is

      ---------------------
      -- Create_Particle --
      ---------------------

      procedure Create_Particle
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean;
        Node       : out Matreshka.XML_Schema.AST.Types.Particle_Access)
      is
         Index : Natural;
      begin
         Node := new Matreshka.XML_Schema.AST.Particles.Particle_Node;

         --  @minOccurs
         Index := Attributes.Index (Min_Occurs_Attribute_Name);

         if Index = 0 then
            Node.Min_Occurs := 1;
         else
            Node.Min_Occurs := Natural'Wide_Wide_Value
              (Attributes.Value (Index).To_Wide_Wide_String);
         end if;

         --  @maxOccurs
         Index := Attributes.Index (Max_Occurs_Attribute_Name);

         if Index = 0 then
            Node.Max_Occurs := 1;
         elsif Attributes.Value (Index) = Unbounded_Literal_Image then
            Node.Max_Occurs := Natural'Last;
         else
            Node.Max_Occurs := Natural'Wide_Wide_Value
              (Attributes.Value (Index).To_Wide_Wide_String);
         end if;
      end Create_Particle;

      ---------------------
      -- Create_Wildcard --
      ---------------------

      procedure Create_Wildcard
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean;
        Node       : out Matreshka.XML_Schema.AST.Types.Wildcard_Access)
      is
         use all type Matreshka.XML_Schema.AST.Wildcards
           .Namespace_Constraint_Variety;
         use all type Matreshka.XML_Schema.AST.Wildcards.Process_Content_Kind;

         Has_Not_Namespace : constant Boolean :=
           Attributes.Index (Not_Namespace_Attribute_Name) /= 0;

         URIs  : League.String_Vectors.Universal_String_Vector;
         Index : Natural;
      begin
         Node := new Matreshka.XML_Schema.AST.Wildcards.Wildcard_Node;

         Node.Namespace_Constraint.Namespaces.Has_Absent := False;
         Node.Namespace_Constraint.Disallowed_Names.Has_Defined := False;
         Node.Namespace_Constraint.Disallowed_Names.Has_Sibling := False;

         Index := Attributes.Index (Namespace_Attribute_Name);

         if Index /= 0 then
            if Attributes.Value (Index) = Any_Literal_Image then
               Node.Namespace_Constraint.Variety := Any;
            elsif Attributes.Value (Index) = Other_Literal_Image then
               Node.Namespace_Constraint.Variety := A_Not;
            else
               Node.Namespace_Constraint.Variety := Enumeration;
            end if;
         elsif Has_Not_Namespace then
            Node.Namespace_Constraint.Variety := A_Not;
         else
            Node.Namespace_Constraint.Variety := Any;
         end if;

         if Index /= 0 then  --  @namespace is present
            if Attributes.Value (Index) = Other_Literal_Image then
               Node.Namespace_Constraint.Namespaces.Has_Absent := True;

               if not Self.Schema.Target_Namespace.Is_Empty then
                  URIs.Append (Self.Schema.Target_Namespace);
               end if;
            elsif Attributes.Value (Index) /= Any_Literal_Image then
               URIs := Attributes.Value (Index).Split (' ');
            end if;
         elsif Has_Not_Namespace then  --  @notNamespace is present
            URIs :=
              Attributes.Value (Not_Namespace_Attribute_Name).Split (' ');
         end if;

         --  Handle special ##targetNamespace and ##local
         for J in 1 .. URIs.Length loop
            if URIs (J) = Target_Namespace_Literal_Image then
               if Self.Schema.Target_Namespace.Is_Empty then
                  Node.Namespace_Constraint.Namespaces.Has_Absent := True;
               else
                  Node.Namespace_Constraint.Namespaces.URIs.Append
                    (Self.Schema.Target_Namespace);
               end if;
            elsif URIs (J) = Local_Literal_Image then
               Node.Namespace_Constraint.Namespaces.Has_Absent := True;
            else
               Node.Namespace_Constraint.Namespaces.URIs.Append (URIs (J));
            end if;
         end loop;

         --  Handle @notQName
         Index := Attributes.Index (Not_QName_Attribute_Name);
         if Index /= 0 then
            declare
               List : constant League.String_Vectors.Universal_String_Vector :=
                 Attributes.Value (Index).Split (' ');
            begin
               for J in 1 .. List.Length  loop
                  if List (J) = Defined_Literal_Image then
                     Node.Namespace_Constraint.Disallowed_Names.Has_Defined :=
                       True;
                  elsif List (J) = Defined_Sibling_Literal_Image then
                     Node.Namespace_Constraint.Disallowed_Names.Has_Sibling :=
                       True;
                  else
                     Node.Namespace_Constraint.Disallowed_Names.Names.Append
                       (List (J));
                  end if;
               end loop;
            end;
         end if;

         --  Handle @processContents
         Index := Attributes.Index (Process_Contents_Attribute_Name);

         if Index /= 0 then
            Node.Process_Contents :=
              AST.Wildcards.Process_Content_Kind'Wide_Wide_Value
                (Attributes.Value (Index).To_Wide_Wide_String);
         else
            Node.Process_Contents := Strict;
         end if;

      end Create_Wildcard;

      ------------------------------
      -- End_Complex_Type_Element --
      ------------------------------

      procedure End_Complex_Type_Element
       (Self    : in out XML_Schema_Handler;
        Success : in out Boolean) is
      begin
         null;
      end End_Complex_Type_Element;

      ---------------------------------
      -- Start_Any_Attribute_Element --
      ---------------------------------

      procedure Start_Any_Attribute_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Wildcard_Access;
      begin
         Create_Wildcard (Self, Attributes, Success, Node);

         Self.Top_State.Last_Complex_Type_Definition.Attribute_Wildcard :=
           Node;
      end Start_Any_Attribute_Element;

      -----------------------
      -- Start_Any_Element --
      -----------------------

      procedure Start_Any_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Wildcard_Access;
      begin
         Create_Wildcard (Self, Attributes, Success, Node);

         Self.Top_State.Last_Complex_Type_Definition.Attribute_Wildcard :=
           Node;
      end Start_Any_Element;

      -----------------------------
      -- Start_Attribute_Element --
      -----------------------------

      procedure Start_Attribute_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Attribute_Use_Access;
      begin
         Declarations.Local_Attribute_Element
           (Self, Attributes, Node, Success);

         Self.Top_State.Last_Complex_Type_Definition.Attribute_Uses.Append
           (Node);
      end Start_Attribute_Element;

      -----------------------------------
      -- Start_Attribute_Group_Element --
      -----------------------------------

      procedure Start_Attribute_Group_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  : AST.Types.Attribute_Group_Reference_Access;
      begin
         Node := new AST.Attribute_Groups.Attribute_Group_Reference_Node;

         XSD_Attribute.Required
           (Ref_Attribute_Name,
            Node.Ref,
            Attributes,
            "attribute group reference");

         XSD_Attribute.Prohibited
           (Name_Attribute_Name,
            Attributes,
            "attribute group reference");

         Self.Top_State.Last_Complex_Type_Definition.Attribute_Group_References
           .Append (Node);
      end Start_Attribute_Group_Element;

      --------------------------
      -- Start_Choice_Element --
      --------------------------

      procedure Start_Choice_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Particle_Access;
      begin
         Particles.Start_Choice_Element
           (Self       => Self,
            Attributes => Attributes,
            Success    => Success,
            Node       => Node);

         Self.Top_State.Last_Complex_Type_Definition.Content_Type :=
           (Variety      => AST.Complex_Types.Element_Only,
            Particle     => Node,
            Open_Content => <>);
      end Start_Choice_Element;

      -----------------------------------
      -- Start_Complex_Content_Element --
      -----------------------------------

      procedure Start_Complex_Content_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean) is
      begin
         null;
      end Start_Complex_Content_Element;

      ----------------------------------------------
      -- Start_Element_Level_Complex_Type_Element --
      ----------------------------------------------

      procedure Start_Element_Level_Complex_Type_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Complex_Type_Definition_Access;
      begin
         Node := new Matreshka.XML_Schema.AST.Complex_Types
           .Complex_Type_Definition_Node;

         XSD_Attribute.Prohibited
           (Name_Attribute_Name,
            Attributes,
            "local complex type definition");

         XSD_Attribute.Prohibited
           (Abstract_Attribute_Name,
            Attributes,
            "local complex type definition");

         XSD_Attribute.Prohibited
           (Final_Attribute_Name,
            Attributes,
            "local complex type definition");

         XSD_Attribute.Prohibited
           (Block_Attribute_Name,
            Attributes,
            "local complex type definition");

         Self.States.Last_Element.Last_Element_Declaration
           .Type_Definition := AST.Types.Type_Definition_Access (Node);

         Self.Top_State.Last_Complex_Type_Definition := Node;
      end Start_Element_Level_Complex_Type_Element;

      -----------------------------
      -- Start_Extension_Element --
      -----------------------------

      procedure Start_Extension_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean) is
      begin
         XSD_Attribute.Required
           (Base_Attribute_Name,
            Self.Top_State.Last_Complex_Type_Definition.Extension_Base,
            Attributes,
            "extension");
         Self.Top_State.Last_Complex_Type_Definition.Derivation_Method :=
           AST.Extension;
      end Start_Extension_Element;

      -------------------------
      -- Start_Group_Element --
      -------------------------

      procedure Start_Group_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Particle_Access;
      begin
         Particles.Start_Group_Element
           (Self       => Self,
            Attributes => Attributes,
            Success    => Success,
            Node       => Node);

         Self.Top_State.Last_Complex_Type_Definition.Content_Type :=
           (Variety      => AST.Complex_Types.Element_Only,
            Particle     => Node,
            Open_Content => <>);
      end Start_Group_Element;

      -------------------------------
      -- Start_Restriction_Element --
      -------------------------------

      procedure Start_Restriction_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean) is
      begin
         XSD_Attribute.Required
           (Base_Attribute_Name,
            Self.Top_State.Last_Complex_Type_Definition.Restriction_Base,
            Attributes,
            "restriction element");
         Self.Top_State.Last_Complex_Type_Definition.Derivation_Method :=
           AST.Restriction;
      end Start_Restriction_Element;

      ----------------------------
      -- Start_Sequence_Element --
      ----------------------------

      procedure Start_Sequence_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Particle_Access;
      begin
         Particles.Start_Sequence_Element
           (Self       => Self,
            Attributes => Attributes,
            Success    => Success,
            Node       => Node);

         Self.Top_State.Last_Complex_Type_Definition.Content_Type :=
           (Variety      => AST.Complex_Types.Element_Only,
            Particle     => Node,
            Open_Content => <>);
      end Start_Sequence_Element;

      ------------------------------------------
      -- Start_Top_Level_Complex_Type_Element --
      ------------------------------------------

      procedure Start_Top_Level_Complex_Type_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Complex_Type_Definition_Access;
      begin
         Node := new Matreshka.XML_Schema.AST.Complex_Types
           .Complex_Type_Definition_Node;

         XSD_Attribute.Required
           (Name_Attribute_Name,
            Node.Name,
            Attributes,
            "top-level complex type definition");

         Self.Schema.Type_Definitions.Insert
          (Node.Name,
           Matreshka.XML_Schema.AST.Types.Type_Definition_Access (Node));

         Self.Top_State.Last_Complex_Type_Definition := Node;
      end Start_Top_Level_Complex_Type_Element;

      --------------------------------------------
      -- Start_Type_Level_Any_Attribute_Element --
      --------------------------------------------

      procedure Start_Type_Level_Any_Attribute_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean) is
      begin
         Self.Top_State.Last_Complex_Type_Definition.Derivation_Method :=
           AST.Restriction;

         Self.Top_State.Last_Complex_Type_Definition.Any_Type_Restriction :=
           True;

         Start_Any_Attribute_Element (Self, Attributes, Success);
      end Start_Type_Level_Any_Attribute_Element;

      ----------------------------------------
      -- Start_Type_Level_Attribute_Element --
      ----------------------------------------

      procedure Start_Type_Level_Attribute_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Attribute_Use_Access;
      begin
         Self.Top_State.Last_Complex_Type_Definition.Derivation_Method :=
           AST.Restriction;

         Self.Top_State.Last_Complex_Type_Definition.Any_Type_Restriction :=
           True;

         Declarations.Local_Attribute_Element
           (Self, Attributes, Node, Success);

         Self.Top_State.Last_Complex_Type_Definition.Attribute_Uses.Append
           (Node);
      end Start_Type_Level_Attribute_Element;

      ---------------------------------------
      -- Start_Type_Level_Sequence_Element --
      ---------------------------------------

      procedure Start_Type_Level_Sequence_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Particle_Access;
      begin
         Self.Top_State.Last_Complex_Type_Definition.Derivation_Method :=
           AST.Restriction;

         Self.Top_State.Last_Complex_Type_Definition.Any_Type_Restriction :=
           True;

         Particles.Start_Sequence_Element
           (Self       => Self,
            Attributes => Attributes,
            Success    => Success,
            Node       => Node);

         Self.Top_State.Last_Complex_Type_Definition.Content_Type :=
           (Variety      => AST.Complex_Types.Element_Only,
            Particle     => Node,
            Open_Content => <>);
      end Start_Type_Level_Sequence_Element;

   end Complex_Types;

   -------------
   -- Current --
   -------------

   function Current (Self : XML_Schema_Handler'Class) return States is
   begin
      return Self.Top_State.State;
   end Current;

   ------------------
   -- Declarations --
   ------------------

   package body Declarations is

      procedure Read_XPath
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Node       : in out AST.Types.XPath_Expression;
         Title      : String;
         Success    : in out Boolean);

      --------------------------------
      -- Common_Element_Declaration --
      --------------------------------

      procedure Common_Element_Declaration
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Node       : AST.Types.Element_Declaration_Access;
         Success    : in out Boolean) is
      begin
         Node.Name := Attributes.Value (Name_Attribute_Name);
         Node.Type_Name := Attributes.Value (Type_Attribute_Name);

         Node.Nillable := XSD_Attribute.To_Boolean
           (Attributes, Nillable_Attribute_Name);
         Node.Is_Abstract := XSD_Attribute.To_Boolean
           (Attributes, Abstract_Attribute_Name);

         Get_Value_Constant (Node.Value_Constraint, Attributes);
      end Common_Element_Declaration;

      ------------------------
      -- Create_Model_Group --
      ------------------------

      procedure Create_Model_Group
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Compositor : AST.Model_Groups.Compositor_Kind;
         Success    : in out Boolean)
      is
         Model : Matreshka.XML_Schema.AST.Types.Model_Group_Access;
      begin
         Model := new Matreshka.XML_Schema.AST.Model_Groups.Model_Group_Node;

         Model.Compositor := Compositor;

         Self.Top_State.Last_Model := Model;
      end Create_Model_Group;

      -----------------------------
      -- Local_Attribute_Element --
      -----------------------------

      procedure Local_Attribute_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Node       : out Matreshka.XML_Schema.AST.Types.Attribute_Use_Access;
        Success    : in out Boolean)
      is
         Index     : Natural := Attributes.Index (Ref_Attribute_Name);
         Has_Ref   : constant Boolean := Index /= 0;
         Use_Attr  : constant League.Strings.Universal_String :=
           Attributes.Value (Use_Attribute_Name);
         Decl_Node : Matreshka.XML_Schema.AST.Types
           .Attribute_Declaration_Access;
      begin
         if Attributes.Value (Use_Attribute_Name)
           = Prohibited_Literal_Image
         then
            --  If the <attribute> element information item has
            --  use='prohibited', then it does not map to, or correspond to,
            --  any schema component at all.

            --  Shall we keep them somewhere???
            return;
         end if;

         Node := new Matreshka.XML_Schema.AST.Attribute_Uses
           .Attribute_Use_Node;

         Node.Required := Use_Attr = Required_Literal_Image;
         Get_Value_Constant (Node.Value_Constraint, Attributes);
         Node.Inheritable := XSD_Attribute.To_Boolean
           (Attributes, Inheritable_Attribute_Name);

         if Has_Ref then
            --  Attribute Use
            Node.Ref := Attributes.Value (Index);
         else --  not Has_Ref
            --  maps both to an Attribute Declaration and to an Attribute Use
            Decl_Node := new Matreshka.XML_Schema.AST.Attribute_Declarations
              .Attribute_Declaration_Node;

            XSD_Attribute.Required
              (Name_Attribute_Name,
               Decl_Node.Name,
               Attributes,
               "local attribute declaration");

            Decl_Node.Type_Name := Attributes.Value (Type_Attribute_Name);

            Decl_Node.Scope :=
              (Variety => Matreshka.XML_Schema.AST.Types.Local,
               Parent  => Matreshka.XML_Schema.AST.Types.Abstract_Node_Access
                 (Self.Top_State.Last_Complex_Type_Definition));

            Decl_Node.Inheritable := XSD_Attribute.To_Boolean
              (Attributes, Inheritable_Attribute_Name);

            Node.Attribute_Declaration := Decl_Node;
            Self.Top_State.Last_Attribute_Declaration := Decl_Node;

            --  Fix top state
            Self.Top_State.State := Attribute_Declaration;
         end if;

      end Local_Attribute_Element;

      ----------------
      -- Read_XPath --
      ----------------

      procedure Read_XPath
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Node       : in out AST.Types.XPath_Expression;
         Title      : String;
         Success    : in out Boolean) is
      begin
         XSD_Attribute.Required
           (XPath_Attribute_Name,
            Node.Expression,
            Attributes,
            Title);
      end Read_XPath;

      ------------------------------
      -- Start_Constraint_Element --
      ------------------------------

      procedure Start_Constraint_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Category   : AST.Identity_Constraints.Category;
         Success    : in out Boolean)
      is
         Node : AST.Types.Identity_Constraint_Definition_Access;
      begin
         Node := new Matreshka.XML_Schema.AST.Identity_Constraints.
           Identity_Constraint_Definition_Node;

         Node.Name := Attributes.Value (Name_Attribute_Name);
         Node.Identity_Constraint_Category := Category;

         Self.Top_State.Last_Constraint := Node;

         Self.Top_State.Last_Element_Declaration
           .Identity_Constraint_Definitions.Append (Node);
      end Start_Constraint_Element;

      -------------------------
      -- Start_Field_Element --
      -------------------------

      procedure Start_Field_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean)
      is
         Node : Matreshka.XML_Schema.AST.Types.XPath_Expression;
      begin
         Read_XPath (Self, Attributes, Node, "field element", Success);

         Self.Top_State.Last_Constraint.Fields.Append (Node);
      end Start_Field_Element;

      -----------------------------------------
      -- Start_Group_Level_Attribute_Element --
      -----------------------------------------

      procedure Start_Group_Level_Attribute_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean)
      is
         Node : Matreshka.XML_Schema.AST.Types.Attribute_Use_Access;
      begin
         Declarations.Local_Attribute_Element
           (Self, Attributes, Node, Success);

         Self.Top_State.Last_Attribute_Group_Definition.Attribute_Uses.Append
           (Node);
      end Start_Group_Level_Attribute_Element;

      --------------------------------------
      -- Start_Group_Level_Choice_Element --
      --------------------------------------

      procedure Start_Group_Level_Choice_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean) is
      begin
         Create_Model_Group
           (Self       => Self,
            Attributes => Attributes,
            Success    => Success,
            Compositor => AST.Model_Groups.Choice);

         Self.Top_State.Last_Model_Definition.Model_Group :=
           Self.Top_State.Last_Model;
      end Start_Group_Level_Choice_Element;

      ----------------------------------------
      -- Start_Group_Level_Sequence_Element --
      ----------------------------------------

      procedure Start_Group_Level_Sequence_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean) is
      begin
         Create_Model_Group
           (Self       => Self,
            Attributes => Attributes,
            Success    => Success,
            Compositor => AST.Model_Groups.Sequence);

         Self.Top_State.Last_Model_Definition.Model_Group :=
           Self.Top_State.Last_Model;
      end Start_Group_Level_Sequence_Element;

      ----------------------------
      -- Start_Notation_Element --
      ----------------------------

      ----------------------------
      -- Start_Notation_Element --
      ----------------------------

      procedure Start_Notation_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean)
      is
         Node : AST.Types.Notation_Declaration_Access;
      begin
         Node := new Matreshka.XML_Schema.AST.Notation_Declarations
           .Notation_Declaration_Node;

         XSD_Attribute.Required
           (Name_Attribute_Name,
            Node.Name,
            Attributes,
            "notation declaration");

         Self.Schema.Notation_Declarations.Insert (Node.Name, Node);
      end Start_Notation_Element;

      ----------------------------
      -- Start_Selector_Element --
      ----------------------------

      procedure Start_Selector_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean)
      is
         Node : AST.Types.XPath_Expression renames
           Self.Top_State.Last_Constraint.Selector;
      begin
         Read_XPath (Self, Attributes, Node, "selector element", Success);
      end Start_Selector_Element;

      ---------------------------------------
      -- Start_Top_Level_Attribute_Element --
      ---------------------------------------

      procedure Start_Top_Level_Attribute_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Attribute_Declaration_Access;
      begin
         Node := new Matreshka.XML_Schema.AST.Attribute_Declarations
           .Attribute_Declaration_Node;

         XSD_Attribute.Required
           (Name_Attribute_Name,
            Node.Name,
            Attributes,
            "top-level attribute declaration");

         XSD_Attribute.Prohibited
           (Ref_Attribute_Name, Attributes, "top-level attribute declaration");

         XSD_Attribute.Prohibited
           (Form_Attribute_Name,
            Attributes,
            "top-level attribute declaration");

         XSD_Attribute.Prohibited
           (Use_Attribute_Name, Attributes, "top-level attribute declaration");

         XSD_Attribute.Prohibited
           (Target_Namespace_Attribute_Name,
            Attributes,
            "top-level attribute declaration");

         Node.Type_Name := Attributes.Value (Type_Attribute_Name);

         Self.Schema.Attribute_Declarations.Insert (Node.Name, Node);

         Self.Top_State.Last_Attribute_Declaration := Node;
      end Start_Top_Level_Attribute_Element;

      ---------------------------------------------
      -- Start_Top_Level_Attribute_Group_Element --
      ---------------------------------------------

      procedure Start_Top_Level_Attribute_Group_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean)
      is
         Node  : AST.Types.Attribute_Group_Definition_Access;
      begin
         Node := new Matreshka.XML_Schema.AST.Attribute_Groups
           .Attribute_Group_Definition_Node;

         XSD_Attribute.Required
           (Name_Attribute_Name,
            Node.Name,
            Attributes,
            "top-level attribute group definition");

         XSD_Attribute.Prohibited
           (Ref_Attribute_Name,
            Attributes,
            "top-level attribute group definition");

         Self.Top_State.Last_Attribute_Group_Definition := Node;

         Self.Schema.Attribute_Group_Definitions.Insert (Node.Name, Node);
      end Start_Top_Level_Attribute_Group_Element;

      -----------------------------
      -- Start_Top_Level_Element --
      -----------------------------

      procedure Start_Top_Level_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Element_Declaration_Access;
      begin
         Node := new Matreshka.XML_Schema.AST.Element_Declarations
           .Element_Declaration_Node;

         XSD_Attribute.Required
           (Name_Attribute_Name,
            Node.Name,
            Attributes,
            "top-level element declaration");

         XSD_Attribute.Prohibited
           (Ref_Attribute_Name, Attributes, "top-level element declaration");

         XSD_Attribute.Prohibited
           (Form_Attribute_Name, Attributes, "top-level element declaration");

         XSD_Attribute.Prohibited
           (Target_Namespace_Attribute_Name,
            Attributes,
            "top-level element declaration");

         XSD_Attribute.Prohibited
           (Min_Occurs_Attribute_Name,
            Attributes,
            "top-level element declaration");

         XSD_Attribute.Prohibited
           (Max_Occurs_Attribute_Name,
            Attributes,
            "top-level element declaration");

         Common_Element_Declaration (Self, Attributes, Node, Success);

         Self.Top_State.Last_Element_Declaration := Node;

         Self.Schema.Element_Declarations.Insert (Node.Name, Node);
      end Start_Top_Level_Element;

      ----------------------------------------------
      -- Start_Top_Level_Model_Definition_Element --
      ----------------------------------------------

      procedure Start_Top_Level_Model_Definition_Element
        (Self       : in out XML_Schema_Handler;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Success    : in out Boolean)
      is
         Node  : AST.Types.Model_Group_Definition_Access;
      begin
         Node := new AST.Model_Groups.Model_Group_Definition_Node;

         XSD_Attribute.Required
           (Name_Attribute_Name,
            Node.Name,
            Attributes,
            "top-level group definition element");

         XSD_Attribute.Prohibited
           (Ref_Attribute_Name,
            Attributes,
            "top-level group definition element");

         XSD_Attribute.Prohibited
           (Min_Occurs_Attribute_Name,
            Attributes,
            "top-level group definition element");

         XSD_Attribute.Prohibited
           (Max_Occurs_Attribute_Name,
            Attributes,
            "top-level group definition element");

         Self.Top_State.Last_Model_Definition := Node;

         Self.Schema.Model_Group_Definitions.Insert (Node.Name, Node);
      end Start_Top_Level_Model_Definition_Element;

   end Declarations;


   -----------------
   -- End_Element --
   -----------------

   overriding procedure End_Element
    (Self           : in out XML_Schema_Handler;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean) is
   begin
      if Self.Ignore_Depth /= 0 then
         Self.Ignore_Depth := Self.Ignore_Depth - 1;

      elsif Namespace_URI = XML_Schema_Namespace_URI then
         if Local_Name = Annotation_Element_Name then
            null;

         elsif Local_Name = Any_Attribute_Element_Name then
            Complex_Types.End_Any_Attribute_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Any_Element_Name then
            Complex_Types.End_Any_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Attribute_Element_Name then
            Declarations.End_Attribute_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Attribute_Group_Element_Name then
            Declarations.End_Attribute_Group_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Choice_Element_Name then
            Declarations.End_Choice_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Complex_Content_Element_Name then
            Complex_Types.End_Complex_Content_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Complex_Type_Element_Name then
            Complex_Types.End_Complex_Type_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Element_Element_Name then
            Particles.End_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Enumeration_Element_Name then
            Facets.End_Enumeration_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Extension_Element_Name then
            Complex_Types.End_Extension_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Field_Element_Name then
            Declarations.End_Field_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Group_Element_Name then
            Declarations.End_Model_Definition_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Import_Element_Name then
            Self.Pop;

         elsif Local_Name = Key_Element_Name then
            Declarations.End_Constraint_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = List_Element_Name then
            Simple_Types.End_List_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Min_Length_Element_Name then
            Facets.End_Min_Length_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Notation_Element_Name then
            Declarations.End_Notation_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Restriction_Element_Name then
            if Self.Current = Simple_Type_Restriction then
               Simple_Types.End_Restriction_Element (Self, Success);
               Self.Pop;

            elsif Self.Current = Complex_Type_Restriction then
               Simple_Types.End_Restriction_Element (Self, Success);
               Self.Pop;

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Schema_Element_Name then
--            End_Schema_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Selector_Element_Name then
            Declarations.End_Selector_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Sequence_Element_Name then
            Complex_Types.End_Sequence_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Simple_Type_Element_Name then
            Simple_Types.End_Simple_Type_Element (Self, Success);
            Self.Pop;

         elsif Local_Name = Union_Element_Name then
            Simple_Types.End_Union_Element (Self, Success);
            Self.Pop;

         else
            Ada.Wide_Wide_Text_IO.Put_Line
              ("End_Element:" & Local_Name.To_Wide_Wide_String);
            raise Program_Error;
         end if;
      end if;
   end End_Element;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : XML_Schema_Handler) return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   ------------
   -- Facets --
   ------------

   package body Facets is

      -------------------------------
      -- Start_Enumeration_Element --
      -------------------------------

      procedure Start_Enumeration_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node : Matreshka.XML_Schema.AST.Types.Enumeration_Access;
      begin
         Node := new Matreshka.XML_Schema.AST.Constraining_Facets
           .Enumeration_Node;

         XSD_Attribute.Required
           (Value_Attribute_Name,
            Node.Value,
            Attributes,
            "enumeration element");

         Self.Top_State.Last_Simple_Type_Definition.Facets.Append
           (AST.Types.Abstract_Node_Access (Node));
      end Start_Enumeration_Element;

      ------------------------------
      -- Start_Min_Length_Element --
      ------------------------------

      procedure Start_Min_Length_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node : Matreshka.XML_Schema.AST.Types.Min_Length_Access;
      begin
         Node := new Matreshka.XML_Schema.AST.Constraining_Facets
           .Min_Length_Node;

         XSD_Attribute.Required
           (Value_Attribute_Name,
            Node.Value,
            Attributes,
            "minLength element");

         Self.Top_State.Last_Simple_Type_Definition.Facets.Append
           (AST.Types.Abstract_Node_Access (Node));
      end Start_Min_Length_Element;

   end Facets;

   ----------------
   -- Get_Schema --
   ----------------

   function Get_Schema
    (Self : XML_Schema_Handler)
       return Matreshka.XML_Schema.AST.Types.Schema_Access is
   begin
      return Self.Schema;
   end Get_Schema;

   ---------------
   -- Particles --
   ---------------

   package body Particles is

      -----------------------
      -- Start_Any_Element --
      -----------------------

      procedure Start_Any_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Particle_Access;
         Term  : Matreshka.XML_Schema.AST.Types.Wildcard_Access;
      begin
         Complex_Types.Create_Particle
           (Self       => Self,
            Attributes => Attributes,
            Success    => Success,
            Node       => Node);

         Complex_Types.Create_Wildcard
           (Self       => Self,
            Attributes => Attributes,
            Success    => Success,
            Node       => Term);

         Node.Term := AST.Types.Term_Access (Term);

         Self.Top_State.Last_Model.Particles.Append (Node);
      end Start_Any_Element;

      --------------------------
      -- Start_Choice_Element --
      --------------------------

      procedure Start_Choice_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node : Matreshka.XML_Schema.AST.Types.Particle_Access;
      begin
         Particles.Start_Choice_Element
           (Self       => Self,
            Attributes => Attributes,
            Success    => Success,
            Node       => Node);

         Self.Top_State.Last_Model.Particles.Append (Node);
      end Start_Choice_Element;

      --------------------------
      -- Start_Choice_Element --
      --------------------------

      procedure Start_Choice_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Node       : out Matreshka.XML_Schema.AST.Types.Particle_Access;
        Success    : in out Boolean)
      is
         use type Matreshka.XML_Schema.AST.Types.Model_Group_Access;
      begin
         XSD_Attribute.Prohibited
           (Name_Attribute_Name,
            Attributes,
            "choice element");

         XSD_Attribute.Prohibited
           (Ref_Attribute_Name,
            Attributes,
            "choice element");

         Complex_Types.Create_Particle
           (Self       => Self,
            Attributes => Attributes,
            Success    => Success,
            Node       => Node);

         --  This will rewrite Self.Top_State.Last_Model
         Declarations.Create_Model_Group
           (Self       => Self,
            Attributes => Attributes,
            Compositor => AST.Model_Groups.Choice,
            Success => Success);

         Node.Term := AST.Types.Term_Access (Self.Top_State.Last_Model);
      end Start_Choice_Element;

      -------------------
      -- Start_Element --
      -------------------

      procedure Start_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Particle_Access;
         Term  : Matreshka.XML_Schema.AST.Types.Element_Declaration_Access;
         Index : Natural;
      begin
         Complex_Types.Create_Particle
           (Self       => Self,
            Attributes => Attributes,
            Success    => Success,
            Node       => Node);

         Index := Attributes.Index (Ref_Attribute_Name);

         if Index = 0 then
            --  ... it maps both to a Particle ...,
            --  and also to an Element Declaration
            Term := new AST.Element_Declarations.Element_Declaration_Node;

            XSD_Attribute.Prohibited
              (Substitution_Group_Attribute_Name, Attributes, "local element");

            XSD_Attribute.Prohibited
              (Final_Attribute_Name, Attributes, "local element");

            XSD_Attribute.Prohibited
              (Abstract_Attribute_Name, Attributes, "local element");

            Declarations.Common_Element_Declaration
              (Self, Attributes, Term, Success);

            Term.Scope :=
              (Variety => Matreshka.XML_Schema.AST.Types.Local,
               Parent  => null);  --  Not so easy to get parent here

            Node.Term := AST.Types.Term_Access (Term);
            Self.Top_State.Last_Element_Declaration := Term;

            --  Fix top state
            Self.Top_State.State := Element_Declaration;
         else
            Node.Element_Ref := Attributes.Value (Index);
         end if;

         Self.Top_State.Last_Model.Particles.Append (Node);
      end Start_Element;

      -------------------------
      -- Start_Group_Element --
      -------------------------

      procedure Start_Group_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Particle_Access;
      begin
         Particles.Start_Group_Element
           (Self       => Self,
            Attributes => Attributes,
            Success    => Success,
            Node       => Node);

         Self.Top_State.Last_Model.Particles.Append (Node);
      end Start_Group_Element;

      -------------------------
      -- Start_Group_Element --
      -------------------------

      procedure Start_Group_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Node       : out Matreshka.XML_Schema.AST.Types.Particle_Access;
        Success    : in out Boolean) is
      begin
         Complex_Types.Create_Particle
           (Self       => Self,
            Attributes => Attributes,
            Success    => Success,
            Node       => Node);

         Node.Group_Ref := Attributes.Value (Ref_Attribute_Name);
      end Start_Group_Element;

      ----------------------------
      -- Start_Sequence_Element --
      ----------------------------

      procedure Start_Sequence_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  : Matreshka.XML_Schema.AST.Types.Particle_Access;
      begin
         Particles.Start_Sequence_Element
           (Self       => Self,
            Attributes => Attributes,
            Success    => Success,
            Node       => Node);

         Self.Top_State.Last_Model.Particles.Append (Node);
      end Start_Sequence_Element;

      ----------------------------
      -- Start_Sequence_Element --
      ----------------------------

      procedure Start_Sequence_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Node       : out Matreshka.XML_Schema.AST.Types.Particle_Access;
        Success    : in out Boolean)
      is
         --  Should we share code with Start_Choice_Element???
         use type Matreshka.XML_Schema.AST.Types.Model_Group_Access;
      begin
         XSD_Attribute.Prohibited
           (Name_Attribute_Name,
            Attributes,
            "sequence element");

         XSD_Attribute.Prohibited
           (Ref_Attribute_Name,
            Attributes,
            "sequence element");

         Complex_Types.Create_Particle
           (Self       => Self,
            Attributes => Attributes,
            Success    => Success,
            Node       => Node);

         --  This will rewrite Self.Top_State.Last_Model
         Declarations.Create_Model_Group
           (Self       => Self,
            Attributes => Attributes,
            Compositor => AST.Model_Groups.Sequence,
            Success    => Success);

         Node.Term := AST.Types.Term_Access (Self.Top_State.Last_Model);
      end Start_Sequence_Element;

   end Particles;

   ------------------------
   -- Get_Value_Constant --
   ------------------------

   procedure Get_Value_Constant
     (Node       : in out AST.Types.Value_Constraint;
      Attributes : XML.SAX.Attributes.SAX_Attributes)
   is
      Index : Natural := Attributes.Index (Default_Attribute_Name);
   begin
      if Index /= 0 then
         Node :=
           (Variety      => AST.Types.Default,
            Value        => Attributes.Value (Index),
            Lexical_Form => <>);
      else
         Index := Attributes.Index (Fixed_Attribute_Name);

         if Index /= 0 then
            Node :=
              (Variety      => AST.Types.Fixed,
               Value        => Attributes.Value (Index),
               Lexical_Form => <>);
         end if;
      end if;
   end Get_Value_Constant;

   ---------
   -- Pop --
   ---------

   procedure Pop (Self : in out XML_Schema_Handler'Class) is
   begin
      Self.Top_State := Self.States.Last_Element;
      Self.States.Delete_Last;
   end Pop;

   ----------
   -- Push --
   ----------

   procedure Push (Self : in out XML_Schema_Handler'Class; State : States) is
   begin
      Self.States.Append (Self.Top_State);
      Self.Top_State.State := State;
   end Push;

   --------------------------
   -- Set_Document_Locator --
   --------------------------

   overriding procedure Set_Document_Locator
    (Self    : in out XML_Schema_Handler;
     Locator : XML.SAX.Locators.SAX_Locator) is
   begin
      Self.Locator := Locator;
   end Set_Document_Locator;

   ------------------
   -- Simple_Types --
   ------------------

   package body Simple_Types is

      -----------------------------
      -- End_Restriction_Element --
      -----------------------------

      procedure End_Restriction_Element
       (Self    : in out XML_Schema_Handler;
        Success : in out Boolean) is
      begin
         null;
      end End_Restriction_Element;

      -----------------------------
      -- End_Simple_Type_Element --
      -----------------------------

      procedure End_Simple_Type_Element
       (Self    : in out XML_Schema_Handler;
        Success : in out Boolean) is
      begin
         null;
      end End_Simple_Type_Element;

      -----------------------
      -- End_Union_Element --
      -----------------------

      procedure End_Union_Element
       (Self    : in out XML_Schema_Handler;
        Success : in out Boolean) is
      begin
         null;
      end End_Union_Element;

      -----------------------------------------------
      -- Start_Attribute_Level_Simple_Type_Element --
      -----------------------------------------------

      procedure Start_Attribute_Level_Simple_Type_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean) is
      begin
         Start_Local_Simple_Type_Element (Self, Attributes,Success);

         if Success then
            Self.Top_State.Last_Attribute_Declaration.Type_Definition :=
              Matreshka.XML_Schema.AST.Types.Simple_Type_Definition_Access
                (Self.Top_State.Last_Simple_Type_Definition);
         end if;
      end Start_Attribute_Level_Simple_Type_Element;

      ------------------------
      -- Start_List_Element --
      ------------------------

      procedure Start_List_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean) is
      begin
         Self.Top_State.Last_Simple_Type_Definition.Variety :=
           Matreshka.XML_Schema.AST.List;
         Self.Top_State.Last_Simple_Type_Definition.Item_Type :=
           Attributes.Value (Item_Type_Attribute_Name);
      end Start_List_Element;

      ------------------------------------------
      -- Start_List_Level_Simple_Type_Element --
      ------------------------------------------

      procedure Start_List_Level_Simple_Type_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean) is
      begin
         Start_Local_Simple_Type_Element (Self, Attributes,Success);

         if Success then
            Self.Top_State.Last_Simple_Type_Definition.Item_Type_Definition :=
              Matreshka.XML_Schema.AST.Types.Simple_Type_Definition_Access
                (Self.Top_State.Last_Simple_Type_Definition);
         end if;
      end Start_List_Level_Simple_Type_Element;

      -------------------------------------
      -- Start_Local_Simple_Type_Element --
      -------------------------------------

      procedure Start_Local_Simple_Type_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Node  :
           Matreshka.XML_Schema.AST.Simple_Types.Simple_Type_Definition_Access;

      begin
         Node :=
           new
             Matreshka.XML_Schema.AST.Simple_Types.Simple_Type_Definition_Node;

         XSD_Attribute.Prohibited
           (Final_Attribute_Name,
            Attributes,
            "local simple type definition");

         Node.Final := (others => False);

         XSD_Attribute.Prohibited
           (Name_Attribute_Name,
            Attributes,
            "local simple type definition");

         Self.Top_State.Last_Simple_Type_Definition := Node;
      end Start_Local_Simple_Type_Element;

      -------------------------------
      -- Start_Restriction_Element --
      -------------------------------

      procedure Start_Restriction_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
      begin
         Self.Top_State.Last_Simple_Type_Definition.Restriction_Base :=
           Attributes.Value (XML_Schema_Namespace_URI, Base_Attribute_Name);
      end Start_Restriction_Element;

      -----------------------------------------
      -- Start_Top_Level_Simple_Type_Element --
      -----------------------------------------

      procedure Start_Top_Level_Simple_Type_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean)
      is
         Index : Natural;
         Node  :
           Matreshka.XML_Schema.AST.Simple_Types.Simple_Type_Definition_Access;

      begin
         Node :=
           new
             Matreshka.XML_Schema.AST.Simple_Types.Simple_Type_Definition_Node;

         --  {final}
         --
         --  A subset of {restriction, extension, list, union}, determined as
         --  follows. [Definition:]  Let FS be the ·actual value· of the final
         --  [attribute], if present, otherwise the ·actual value· of the
         --  finalDefault [attribute] of the ancestor schema element, if
         --  present, otherwise the empty string. Then the property value is
         --  the appropriate case among the following:
         --
         --  1 If ·FS· is the empty string, then the empty set;
         --
         --  2 If ·FS· is "#all", then {restriction, extension, list, union};
         --
         --  3 otherwise Consider ·FS· as a space-separated list, and include
         --  restriction if "restriction" is in that list, and similarly for
         --  extension, list and union.
         --
         --  Note: 'final' attribute of 'simpleType' element doesn't have
         --  default value and is prohibited for local types.

         Index := Attributes.Index (Final_Attribute_Name);

         if Index /= 0 then
            Node.Final := To_Derivation_Set (Attributes.Value (Index));

         else
            --  Non-local type definition.

            Node.Final := Self.Schema.Final_Default;

--      else
--         --  Local type definition.
--         Node.Final := (others => False);
         end if;

         --  XXX id

         --  {name}
         --
         --  The ·actual value· of the name [attribute] if present on the
         --  <simpleType> element, otherwise ·absent·.

         XSD_Attribute.Required
           (Name_Attribute_Name,
            Node.Name,
            Attributes,
            "top-level simple type definition");

         Self.Schema.Type_Definitions.Insert
          (Node.Name,
           Matreshka.XML_Schema.AST.Types.Type_Definition_Access (Node));

         Self.Top_State.Last_Simple_Type_Definition := Node;
      end Start_Top_Level_Simple_Type_Element;

      -------------------------
      -- Start_Union_Element --
      -------------------------

      procedure Start_Union_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean) is
      begin
         Self.Top_State.Last_Simple_Type_Definition.Variety :=
           Matreshka.XML_Schema.AST.Union;
         Self.Top_State.Last_Simple_Type_Definition.Member_Types :=
           Attributes.Value (Member_Types_Attribute_Name);
      end Start_Union_Element;

      -------------------------------------------
      -- Start_Union_Level_Simple_Type_Element --
      -------------------------------------------

      procedure Start_Union_Level_Simple_Type_Element
       (Self       : in out XML_Schema_Handler;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean) is
      begin
         Start_Local_Simple_Type_Element (Self, Attributes, Success);

         if Success then
            Self.States.Last_Element.Last_Simple_Type_Definition
              .Member_Type_Definitions.Append
                (Matreshka.XML_Schema.AST.Types.Simple_Type_Definition_Access
                     (Self.Top_State.Last_Simple_Type_Definition));
         end if;
      end Start_Union_Level_Simple_Type_Element;

   end Simple_Types;

   --------------------
   -- Start_Document --
   --------------------

   overriding procedure Start_Document
    (Self    : in out XML_Schema_Handler;
     Success : in out Boolean) is
   begin
      --  Initialize initial state.

      Self.Push (Document);
   end Start_Document;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out XML_Schema_Handler;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean) is
   begin
      Ada.Wide_Wide_Text_IO.Put_Line
        ("Start_Element:" & Qualified_Name.To_Wide_Wide_String);

      if Self.Ignore_Depth /= 0 then
         Self.Ignore_Depth := Self.Ignore_Depth + 1;

      elsif Namespace_URI = XML_Schema_Namespace_URI then
         if Local_Name = Annotation_Element_Name then
            --  'annotation' elements and their children are ignored.
            --
            --  XXX Check for actual state must be added.

            Self.Ignore_Depth := 1;
         elsif Local_Name = Any_Attribute_Element_Name then
            if Self.Current in
              Complex_Type_Extension | Complex_Type_Restriction
            then
               Self.Push (Any_Attribute);
               Complex_Types.Start_Any_Attribute_Element
                (Self, Attributes, Success);

            elsif Self.Current = Complex_Type then
               Self.Push (Any_Attribute);
               Complex_Types.Start_Type_Level_Any_Attribute_Element
                (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Any_Element_Name then
            if Self.Current in Sequence | Choice then
               Self.Push (Any);
               Particles.Start_Any_Element (Self, Attributes, Success);
            else
               raise Program_Error;
            end if;

         elsif Local_Name = Attribute_Element_Name then
            if Self.Current = Schema then
               Self.Push (Attribute_Declaration);
               Declarations.Start_Top_Level_Attribute_Element
                (Self, Attributes, Success);

            elsif Self.Current = Attribute_Group_Declaration then
               Self.Push (Attribute_Declaration);
               Declarations.Start_Group_Level_Attribute_Element
                (Self, Attributes, Success);

            elsif Self.Current in
              Complex_Type_Extension | Complex_Type_Restriction
            then
               Self.Push (Attribute_Declaration);
               Complex_Types.Start_Attribute_Element
                (Self, Attributes, Success);

            elsif Self.Current = Complex_Type then
               Self.Push (Attribute_Declaration);
               Complex_Types.Start_Type_Level_Attribute_Element
                (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Attribute_Group_Element_Name then
            if Self.Current = Schema then
               Self.Push (Attribute_Group_Declaration);
               Declarations.Start_Top_Level_Attribute_Group_Element
                (Self, Attributes, Success);

            elsif Self.Current = Complex_Type_Extension then
               Self.Push (Attribute_Group_Reference);
               Complex_Types.Start_Attribute_Group_Element
                (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Choice_Element_Name then
            if Self.Current = Model_Group_Definition then
               Self.Push (Choice);
               Declarations.Start_Group_Level_Choice_Element
                (Self, Attributes, Success);

            elsif Self.Current in
              Complex_Type_Extension | Complex_Type_Restriction
            then
               Self.Push (Choice);
               Complex_Types.Start_Choice_Element
                 (Self, Attributes, Success);

            elsif Self.Current = Sequence then
               Self.Push (Choice);
               Particles.Start_Choice_Element
                 (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Complex_Content_Element_Name then
            if Self.Current = Complex_Type then
               Self.Push (Complex_Content);
               Complex_Types.Start_Complex_Content_Element
                (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Complex_Type_Element_Name then
            if Self.Current = Schema then
               Self.Push (Complex_Type);
               Complex_Types.Start_Top_Level_Complex_Type_Element
                (Self, Attributes, Success);

            elsif Self.Current = Element_Declaration then
               Self.Push (Complex_Type);
               Complex_Types.Start_Element_Level_Complex_Type_Element
                (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Enumeration_Element_Name then
            if Self.Current = Simple_Type_Restriction then
               Self.Push (Enumeration);
               Facets.Start_Enumeration_Element
                (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Element_Element_Name then
            if Self.Current = Schema then
               Self.Push (Element_Declaration);
               Declarations.Start_Top_Level_Element
                (Self, Attributes, Success);

            elsif Self.Current in Sequence | Choice then
               Self.Push (Sequence_Element);
               Particles.Start_Element
                 (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Extension_Element_Name then
            if Self.Current = Complex_Content then
               Self.Push (Complex_Type_Extension);
               Complex_Types.Start_Extension_Element
                 (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Field_Element_Name then
            if Self.Current = Key then
               Self.Push (Field);
               Declarations.Start_Field_Element
                 (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Group_Element_Name then
            if Self.Current = Schema then
               Self.Push (Model_Group_Definition);
               Declarations.Start_Top_Level_Model_Definition_Element
                (Self, Attributes, Success);

            elsif Self.Current in
              Complex_Type_Extension | Complex_Type_Restriction
            then
               Self.Push (Group);
               Complex_Types.Start_Group_Element
                 (Self, Attributes, Success);

            elsif Self.Current in Sequence | Choice then
               Self.Push (Group);
               Particles.Start_Group_Element
                 (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Import_Element_Name then
            if Self.Current = Schema then
               Self.Push (Import);
               Start_Import_Element (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

      elsif Local_Name = Key_Element_Name then
            if Self.Current = Element_Declaration then
               Self.Push (Key);
               Declarations.Start_Constraint_Element
                (Self, Attributes, AST.Identity_Constraints.Key, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = List_Element_Name then
            if Self.Current = Simple_Type then
               Self.Push (Simple_Type_List);
               Simple_Types.Start_List_Element
                (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Min_Length_Element_Name then
            if Self.Current = Simple_Type_Restriction then
               Self.Push (Min_Length);
               Facets.Start_Min_Length_Element
                (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Notation_Element_Name then
            if Self.Current = Schema then
               Self.Push (Notation);
               Declarations.Start_Notation_Element
                (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Restriction_Element_Name then
            if Self.Current = Simple_Type then
               Self.Push (Simple_Type_Restriction);
               Simple_Types.Start_Restriction_Element
                (Self, Attributes, Success);

            elsif Self.Current = Complex_Content then
               Self.Push (Complex_Type_Restriction);
               Complex_Types.Start_Restriction_Element
                (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Schema_Element_Name then
            if Self.Current = Document then
               Self.Push (Schema);
               Start_Schema_Element (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Selector_Element_Name then
            if Self.Current = Key then
               Self.Push (Selector);
               Declarations.Start_Selector_Element
                 (Self, Attributes, Success);
            else
               raise Program_Error;
            end if;

         elsif Local_Name = Sequence_Element_Name then
            if Self.Current in
              Complex_Type_Extension | Complex_Type_Restriction
            then
               Self.Push (Sequence);
               Complex_Types.Start_Sequence_Element
                 (Self, Attributes, Success);

            elsif Self.Current = Complex_Type then
               Self.Push (Sequence);
               Complex_Types.Start_Type_Level_Sequence_Element
                 (Self, Attributes, Success);

            elsif Self.Current = Model_Group_Definition then
               Self.Push (Sequence);
               Declarations.Start_Group_Level_Sequence_Element
                 (Self, Attributes, Success);

            elsif Self.Current in Choice | Sequence then
               Self.Push (Sequence);
               Particles.Start_Sequence_Element (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Simple_Type_Element_Name then
            if Self.Current = Schema then
               Self.Push (Simple_Type);
               Simple_Types.Start_Top_Level_Simple_Type_Element
                (Self, Attributes, Success);

            elsif Self.Current = Attribute_Declaration then
               Self.Push (Simple_Type);
               Simple_Types.Start_Attribute_Level_Simple_Type_Element
                (Self, Attributes, Success);

            elsif Self.Current = Union then
               Self.Push (Simple_Type);
               Simple_Types.Start_Union_Level_Simple_Type_Element
                (Self, Attributes, Success);

            elsif Self.Current = Simple_Type_List then
               Self.Push (Simple_Type);
               Simple_Types.Start_List_Level_Simple_Type_Element
                (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Union_Element_Name then
            if Self.Current = Simple_Type then
               Self.Push (Union);
               Simple_Types.Start_Union_Element (Self, Attributes, Success);

            else
               raise Program_Error;
            end if;
         else
            raise Program_Error;
         end if;

      else
         raise Program_Error;
      end if;
   end Start_Element;

   --------------------------
   -- Start_Import_Element --
   --------------------------

   procedure Start_Import_Element
    (Self       : in out XML_Schema_Handler;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean)
   is
      Namespace_Index : constant Natural
        := Attributes.Index (Namespace_Attribute_Name);
      Location        : constant League.Strings.Universal_String
        := Attributes.Value (Schema_Location_Attribute_Name);
      Namespace       :  League.Strings.Universal_String;

   begin
      if Namespace_Index > 0 then
         Namespace := Attributes.Value (Namespace_Index);

         if Namespace = Self.Schema.Target_Namespace then
            raise Program_Error;
         end if;

      elsif not Self.Schema.Target_Namespace_Defined then
         raise Program_Error;
      end if;

      Self.Loader.Enqueue_Document
       (Namespace, Self.Locator.Base_URI, Location);
   end Start_Import_Element;

   --------------------------
   -- Start_Schema_Element --
   --------------------------

   procedure Start_Schema_Element
    (Self       : in out XML_Schema_Handler;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean)
   is
      use type Matreshka.XML_Schema.AST.Models.Model_Node_Access;

      Index : Natural;

   begin
      Self.Schema := new Matreshka.XML_Schema.AST.Schemas.Schema_Node;

      --  XXX  attributeFormDefault
      --  XXX  blockDefault
      --  XXX  defaultAttributes
      --  XXX  elementFormDefault

      --  finalDefault

      Self.Schema.Final_Default :=
        To_Derivation_Set (Attributes.Value (Final_Default_Attribute_Name));

      --  XXX  id

      --  targetNamespace

      Index :=
        Attributes.Index
         (XML_Schema_Namespace_URI, Target_Namespace_Attribute_Name);

      if Index /= 0 then
         Self.Schema.Target_Namespace := Attributes.Value (Index);
         Self.Schema.Target_Namespace_Defined := True;

      else
         Self.Schema.Target_Namespace_Defined := False;
      end if;

      --  XXX  version
      --  XXX  xpathDefaultNamespace

      --  XXX  xml:lang

      if Self.Model = null then
         Self.Model := new Matreshka.XML_Schema.AST.Models.Model_Node;
         Self.Model.Schemas.Insert (Self.Schema.Target_Namespace, Self.Schema);
      else
         Self.Model.Schemas.Include
           (Self.Schema.Target_Namespace, Self.Schema);
      end if;
   end Start_Schema_Element;

   All_Literal_Image         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("#all");
   Restriction_Literal_Image : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("restriction");
   Extension_Literal_Image   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extension");
   List_Literal_Image        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list");
   Union_Literal_Image       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("union");

   -----------------------
   -- To_Derivation_Set --
   -----------------------

   function To_Derivation_Set
    (Image : League.Strings.Universal_String)
       return Matreshka.XML_Schema.AST.Derivation_Set is
   begin
      --  Check for '#all' literal.

      if Image = All_Literal_Image then
         return (others => True);
      end if;

      --  Check for set of 'restriction', 'extension', 'list' and 'union'
      --  literals.

      declare
         Items   : constant League.String_Vectors.Universal_String_Vector
           := Image.Split (' ');
         Result  : Matreshka.XML_Schema.AST.Derivation_Set := (others => False);
         Element : League.Strings.Universal_String;

      begin
         for J in 1 .. Items.Length loop
            Element := Items.Element (J);

            if Element = Restriction_Literal_Image then
               Result (Matreshka.XML_Schema.AST.Restriction) := True;

            elsif Element = Extension_Literal_Image then
               Result (Matreshka.XML_Schema.AST.Extension) := True;

            elsif Element = List_Literal_Image then
               Result (Matreshka.XML_Schema.AST.List) := True;

            elsif Element = Union_Literal_Image then
               Result (Matreshka.XML_Schema.AST.Union) := True;
            end if;
         end loop;

         return Result;
      end;
   end To_Derivation_Set;

   -------------------
   -- XSD_Attribute --
   -------------------

   package body XSD_Attribute is

      ----------------
      -- Prohibited --
      ----------------

      procedure Prohibited
        (Name       : League.Strings.Universal_String;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Title      : String)
      is
         Index : Natural;
      begin
         Index := Attributes.Index (Name);

         if Index /= 0 then
            raise Program_Error
              with "'" & Name.To_UTF_8_String
              & "' attribute is prohibited for "
              & Title;
         end if;
      end Prohibited;

      --------------
      -- Required --
      --------------

      procedure Required
        (Name       : League.Strings.Universal_String;
         Value      : out League.Strings.Universal_String;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Title      : String)
      is
         Index : Natural;
      begin
         Index := Attributes.Index (Name);

         if Index = 0 then
            raise Program_Error
              with "'" & Name.To_UTF_8_String
              & "' attribute is required for "
              & Title;
         end if;

         Value := Attributes.Value (Index);

         Ada.Wide_Wide_Text_IO.Put_Line
           ("Required: " & Name.To_Wide_Wide_String
            & " = " & Value.To_Wide_Wide_String);
      end Required;

      --------------
      -- Required --
      --------------

      procedure Required
        (Name       : League.Strings.Universal_String;
         Value      : out Integer;
         Attributes : XML.SAX.Attributes.SAX_Attributes;
         Title      : String)
      is
         Index : Natural;
      begin
         Index := Attributes.Index (Name);

         if Index = 0 then
            raise Program_Error
              with "'" & Name.To_UTF_8_String
              & "' attribute is required for "
              & Title;
         end if;

         Value := Integer'Wide_Wide_Value
           (Attributes.Value (Index).To_Wide_Wide_String);
      end Required;

      ----------------
      -- To_Boolean --
      ----------------

      function To_Boolean
        (Attributes : XML.SAX.Attributes.SAX_Attributes;
         Name       : League.Strings.Universal_String;
         Default    : Boolean := False)
         return Boolean
      is
         Index : Natural;
      begin
         Index := Attributes.Index (Name);

         if Index = 0 then
            return Default;
         else
            return Boolean'Wide_Wide_Value
              (Attributes.Value (Index).To_Wide_Wide_String);
         end if;
      end To_Boolean;

   end XSD_Attribute;

end Matreshka.XML_Schema.Handlers;
