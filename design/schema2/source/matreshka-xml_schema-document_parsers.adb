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
with League.IRIs;
with League.String_Vectors;

with Matreshka.XML_Schema.AST.Models;
with Matreshka.XML_Schema.AST.Namespaces;
with Matreshka.XML_Schema.AST.Schemas;
with Matreshka.XML_Schema.AST.Simple;

package body Matreshka.XML_Schema.Document_Parsers is

   use type League.Strings.Universal_String;

   XML_Schema_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://www.w3.org/2001/XMLSchema");

   Annotation_Tag      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("annotation");
   Attribute_Tag       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("attribute");
   Attribute_Group_Tag : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("attributeGroup");
   Complex_Type_Tag    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("complexType");
   Element_Tag         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("element");
   Enumeration_Tag     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("enumeration");
   Fraction_Digits_Tag : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fractionDigits");
   Group_Tag           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("group");
   Import_Tag          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("import");
   Include_Tag         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("include");
   Length_Tag          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("length");
   List_Tag            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list");
   Max_Exclusive_Tag   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("maxExclusive");
   Max_Inclusive_Tag   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("maxInclusive");
   Max_Length_Tag      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("maxLength");
   Min_Exclusive_Tag   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("minExclusive");
   Min_Inclusive_Tag   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("minInclusive");
   Min_Length_Tag      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("minLength");
   Notation_Tag        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("notation");
   Pattern_Tag         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("pattern");
   Redefine_Tag        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("redefine");
   Restriction_Tag     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("restriction");
   Simple_Type_Tag     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("simpleType");
   Schema_Tag          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("schema");
   Total_Digits_Tag    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("totalDigits");
   Union_Tag           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("union");
   White_Space_Tag     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("whiteSpace");

   Attribute_Form_Default_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("attributeFormDefault");
   Block_Default_Attribute          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("blockDefault");
   Element_Form_Default_Attribute   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("elementFormDefault");
   Final_Default_Attribute          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("finalDefault");
   Schema_Location_Attribute        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("schemaLocation");
   Target_Namespace_Attribute       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("targetNamespace");

   All_Image          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("#all");
   Extension_Image    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extension");
   List_Image         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list");
   Qualified_Image    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("qualified");
   Restriction_Image  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("restriction");
   Substitution_Image : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("substitution");
   Union_Image        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("union");
   Unqualified_Image  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("unqualified");

   procedure Push_Ignore (Self : in out Document_Parser'Class);
   procedure Push_Include (Self : in out Document_Parser'Class);
   procedure Push_Schema (Self : in out Document_Parser'Class);
   procedure Push_Simple_Type (Self : in out Document_Parser'Class);
   --  Push state of parser.

   procedure Pop (Self : in out Document_Parser'Class);
   --  Pop state of parser.

   procedure Start_Include_Element
    (Self       : in out Document_Parser'Class;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean);
   --  Parses start of 'include' element.

   procedure Start_Schema_Element
    (Self       : in out Document_Parser'Class;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean);
   --  Parses start of root 'schema' element.

   procedure Start_Simple_Type_Element
    (Self       : in out Document_Parser'Class;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean);
   --  Parses start of 'simpleType' element.

   procedure Fatal_Error
    (Self    : in out Document_Parser'Class;
     Text    : Wide_Wide_String;
     Success : in out Boolean);
   --  Reports fatal error. Sets Success to False.

   procedure Register_Schema_Document
    (Model    : not null Matreshka.XML_Schema.AST.Model_Access;
     Location : League.Strings.Universal_String;
     Schema   : not null Matreshka.XML_Schema.AST.Schema_Access);
   --  Register schema document in the set of processed schema documents.

   procedure Register_Schema_Document
    (Model    : not null Matreshka.XML_Schema.AST.Model_Access;
     Location : League.Strings.Universal_String);
   --  Register schema document in the set of processed schema documents.

   -----------------
   -- End_Element --
   -----------------

   overriding procedure End_Element
    (Self           : in out Document_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean) is
   begin
      if Self.Current.State = Ignore then
         Self.Current.Depth := Self.Current.Depth - 1;

         if Self.Current.Depth = 0 then
            Self.Pop;
         end if;

      else
         Self.Pop;
      end if;
   end End_Element;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : Document_Parser) return League.Strings.Universal_String is
   begin
      return Self.Diagnosis;
   end Error_String;

   -----------------
   -- Fatal_Error --
   -----------------

   procedure Fatal_Error
    (Self    : in out Document_Parser'Class;
     Text    : Wide_Wide_String;
     Success : in out Boolean) is
   begin
      Self.Diagnosis := League.Strings.To_Universal_String (Text);
      Success := False;
   end Fatal_Error;

   ----------------
   -- Get_Schema --
   ----------------

   function Get_Schema
    (Self : Document_Parser'Class)
       return Matreshka.XML_Schema.AST.Schema_Access is
   begin
      return Self.Schema;
   end Get_Schema;

   ---------
   -- Pop --
   ---------

   procedure Pop (Self : in out Document_Parser'Class) is
   begin
      Self.Current := Self.Stack.Last_Element;
      Self.Stack.Delete_Last;
   end Pop;

   -----------------
   -- Push_Ignore --
   -----------------

   procedure Push_Ignore (Self : in out Document_Parser'Class) is
   begin
      Self.Stack.Append (Self.Current);
      Self.Current := (State => Ignore, Depth => 1);
   end Push_Ignore;

   ------------------
   -- Push_Include --
   ------------------

   procedure Push_Include (Self : in out Document_Parser'Class) is
   begin
      Self.Stack.Append (Self.Current);
      Self.Current := (State => Include);
   end Push_Include;

   -----------------
   -- Push_Schema --
   -----------------

   procedure Push_Schema (Self : in out Document_Parser'Class) is
   begin
      Self.Stack.Append (Self.Current);
      Self.Current := (State => Schema);
   end Push_Schema;

   ----------------------
   -- Push_Simple_Type --
   ----------------------

   procedure Push_Simple_Type (Self : in out Document_Parser'Class) is
   begin
      Self.Stack.Append (Self.Current);
      Self.Current := (State => Simple_Type);
   end Push_Simple_Type;

   ------------------------------
   -- Register_Schema_Document --
   ------------------------------

   procedure Register_Schema_Document
    (Model    : not null Matreshka.XML_Schema.AST.Model_Access;
     Location : League.Strings.Universal_String) is
   begin
      for Item of Model.Schema_Documents loop
         if Item.Location = Location then
            return;
         end if;
      end loop;

      Model.Schema_Documents.Append
       (new Matreshka.XML_Schema.AST.Models.Schema_Document_Info'
             (Location    => Location,
              Schema      => null,
              Is_Loaded   => False,
              Is_Resolved => False));
   end Register_Schema_Document;

   ------------------------------
   -- Register_Schema_Document --
   ------------------------------

   procedure Register_Schema_Document
    (Model    : not null Matreshka.XML_Schema.AST.Model_Access;
     Location : League.Strings.Universal_String;
     Schema   : not null Matreshka.XML_Schema.AST.Schema_Access) is
   begin
      for Item of Model.Schema_Documents loop
         if Item.Location = Location then
            Item.Schema := Schema;

            return;
         end if;
      end loop;

      Model.Schema_Documents.Append
       (new Matreshka.XML_Schema.AST.Models.Schema_Document_Info'
             (Location    => Location,
              Schema      => Schema,
              Is_Loaded   => True,
              Is_Resolved => True));
   end Register_Schema_Document;

   --------------------------
   -- Set_Document_Locator --
   --------------------------

   overriding procedure Set_Document_Locator
    (Self    : in out Document_Parser;
     Locator : XML.SAX.Locators.SAX_Locator) is
   begin
      Self.Locator := Locator;
   end Set_Document_Locator;

   ---------------------------
   -- Start_Include_Element --
   ---------------------------

   procedure Start_Include_Element
    (Self       : in out Document_Parser'Class;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean)
   is
      Location : constant League.Strings.Universal_String
        := Self.Locator.Base_URI.Resolve
            (League.IRIs.From_Universal_String
              (Attributes.Value
                (Schema_Location_Attribute))).To_Universal_String;

   begin
      Self.Push_Include;
      Self.Schema.Includes.Append ((Location, null));
      Register_Schema_Document (Self.Model, Location);
   end Start_Include_Element;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out Document_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean) is
   begin
      if Self.Current.State = Ignore then
         Self.Current.Depth := Self.Current.Depth + 1;

      elsif Namespace_URI = XML_Schema_URI then
         case Self.Current.State is
            when Include =>
               if Local_Name = Annotation_Tag then
                  Self.Push_Ignore;

               else
                  Self.Fatal_Error ("unexpected XML element", Success);
               end if;

            when Ignore =>
               pragma Assert (False);
               --  Must never be happen.

            when Initial =>
               if Local_Name = Schema_Tag then
                  Start_Schema_Element (Self, Attributes, Success);

               else
                  Self.Fatal_Error ("unexpected XML element", Success);
               end if;

            when Schema =>
               if Local_Name = Annotation_Tag then
                  Self.Push_Ignore;

               elsif Local_Name = Attribute_Tag then
                  raise Program_Error;

               elsif Local_Name = Attribute_Group_Tag then
                  raise Program_Error;

               elsif Local_Name = Complex_Type_Tag then
                  raise Program_Error;

               elsif Local_Name = Element_Tag then
                  raise Program_Error;

               elsif Local_Name = Group_Tag then
                  raise Program_Error;

               elsif Local_Name = Import_Tag then
                  raise Program_Error;

               elsif Local_Name = Include_Tag then
                  Start_Include_Element (Self, Attributes, Success);

               elsif Local_Name = Notation_Tag then
                  raise Program_Error;

               elsif Local_Name = Redefine_Tag then
                  raise Program_Error;

               elsif Local_Name = Simple_Type_Tag then
                  Start_Simple_Type_Element (Self, Attributes, Success);

               else
                  Self.Fatal_Error ("unexpected XML element", Success);
               end if;

            when Simple_Type =>
               if Local_Name = Annotation_Tag then
                  Self.Push_Ignore;

               elsif Local_Name = Enumeration_Tag then
                  raise Program_Error;

               elsif Local_Name = Fraction_Digits_Tag then
                  raise Program_Error;

               elsif Local_Name = Length_Tag then
                  raise Program_Error;

               elsif Local_Name = List_Tag then
                  raise Program_Error;

               elsif Local_Name = Max_Exclusive_Tag then
                  raise Program_Error;

               elsif Local_Name = Max_Inclusive_Tag then
                  raise Program_Error;

               elsif Local_Name = Max_Length_Tag then
                  raise Program_Error;

               elsif Local_Name = Min_Exclusive_Tag then
                  raise Program_Error;

               elsif Local_Name = Min_Length_Tag then
                  raise Program_Error;

               elsif Local_Name = Min_Inclusive_Tag then
                  raise Program_Error;

               elsif Local_Name = Pattern_Tag then
                  raise Program_Error;

               elsif Local_Name = Restriction_Tag then
                  raise Program_Error;

               elsif Local_Name = Simple_Type_Tag then
                  raise Program_Error;

               elsif Local_Name = Total_Digits_Tag then
                  raise Program_Error;

               elsif Local_Name = Union_Tag then
                  raise Program_Error;

               elsif Local_Name = White_Space_Tag then
                  raise Program_Error;

               else
                  Self.Fatal_Error ("unexpected XML element", Success);
               end if;
         end case;

      else
         Self.Fatal_Error ("unknown XML element", Success);
      end if;
   end Start_Element;

   --------------------------
   -- Start_Schema_Element --
   --------------------------

   procedure Start_Schema_Element
    (Self       : in out Document_Parser'Class;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean)
   is
      use all type Matreshka.XML_Schema.AST.Schemas.Block_Kinds;
      use all type Matreshka.XML_Schema.AST.Schemas.Final_Kinds;
      use all type Matreshka.XML_Schema.AST.Schemas.Form_Kinds;

      Image : League.Strings.Universal_String;
      Items : League.String_Vectors.Universal_String_Vector;
      Found : Boolean;

   begin
      Self.Push_Schema;
      Self.Schema :=
        Matreshka.XML_Schema.AST.Schemas.Constructors.Create (Self.Locator);

      --  Process 'attributeFormDefault' attribute.

      if Attributes.Is_Specified (Attribute_Form_Default_Attribute) then
         Image := Attributes.Value (Attribute_Form_Default_Attribute);

         if Image = Qualified_Image then
            Self.Schema.Attribute_Form_Default := Qualified;

         elsif Image = Unqualified_Image then
            Self.Schema.Attribute_Form_Default := Unqualified;

         else
            raise Constraint_Error;
         end if;
      end if;

      --  Process 'blockDefault' attribute.

      if Attributes.Is_Specified (Block_Default_Attribute) then
         Image := Attributes.Value (Block_Default_Attribute);

         if Image = All_Image then
            Self.Schema.Block_Default := (others => True);

         else
            Items := Image.Split (' ');

            for J in 1 .. Items.Length loop
               Image := Items.Element (J);

               if Image = Extension_Image then
                  Self.Schema.Block_Default (Extension) := True;

               elsif Image = Restriction_Image then
                  Self.Schema.Block_Default (Restriction) := True;

               elsif Image = Substitution_Image then
                  Self.Schema.Block_Default (substitution) := True;

               else
                  raise Constraint_Error;
               end if;
            end loop;
         end if;
      end if;

      --  Process 'elementFormDefault' attribute.

      if Attributes.Is_Specified (Element_Form_Default_Attribute) then
         Image := Attributes.Value (Element_Form_Default_Attribute);

         if Image = Qualified_Image then
            Self.Schema.Element_Form_Default := Qualified;

         elsif Image = Unqualified_Image then
            Self.Schema.Element_Form_Default := Unqualified;

         else
            raise Constraint_Error;
         end if;
      end if;

      --  Process 'finalDefault' attribute.

      if Attributes.Is_Specified (Final_Default_Attribute) then
         Image := Attributes.Value (Final_Default_Attribute);

         if Image = All_Image then
            Self.Schema.Final_Default := (others => True);

         else
            Items := Image.Split (' ');

            for J in 1 .. Items.Length loop
               Image := Items.Element (J);

               if Image = Extension_Image then
                  Self.Schema.Final_Default (Extension) := True;

               elsif Image = Restriction_Image then
                  Self.Schema.Final_Default (Restriction) := True;

               elsif Image = List_Image then
                  Self.Schema.Final_Default (List) := True;

               elsif Image = Union_Image then
                  Self.Schema.Final_Default (Union) := True;

               else
                  raise Constraint_Error;
               end if;
            end loop;
         end if;
      end if;

      --  Process 'targetNamespace' attribute.

      if Attributes.Is_Specified (Target_Namespace_Attribute) then
         Self.Schema.Target_Namespace_Defined := True;
         Self.Schema.Target_Namespace :=
           Attributes.Value (Target_Namespace_Attribute);
      end if;

      --  Register schema document as loaded document.

      Register_Schema_Document
       (Self.Model, Self.Locator.System_Id, Self.Schema);

      --  Register new namespace if targetNamespace is defined and
      --  there is no namespace node created for target namespace URI.

      if Self.Schema.Target_Namespace_Defined then
         Found := False;

         for Namespace of Self.Model.Namespaces loop
            if Namespace.Namespace.Schema_Namespace
                 = Self.Schema.Target_Namespace
            then
               Found := True;

               exit;
            end if;
         end loop;

         if not Found then
            Self.Model.Namespaces.Append
             ((Matreshka.XML_Schema.AST.Namespaces.Constructors.Create
                (Self.Model, Self.Schema.Target_Namespace),
               Self.Schema));
         end if;
      end if;
   end Start_Schema_Element;

   -------------------------------
   -- Start_Simple_Type_Element --
   -------------------------------

   procedure Start_Simple_Type_Element
    (Self       : in out Document_Parser'Class;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean) is
   begin
      Self.Push_Simple_Type;
   end Start_Simple_Type_Element;

end Matreshka.XML_Schema.Document_Parsers;
