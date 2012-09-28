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

with Matreshka.XML_Schema.AST.Simple_Types;
with Matreshka.XML_Schema.AST.Types;

package body Matreshka.XML_Schema.Handlers is

   use type League.Strings.Universal_String;

   XML_Schema_Namespace_URI          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://www.w3.org/2001/XMLSchema");

   Annotation_Element_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("annotation");
   Restriction_Element_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("restriction");
   Schema_Element_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("schema");
   Simple_Type_Element_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("simpleType");

   Attribute_Form_Default_Attribute_Name :
     constant League.Strings.Universal_String
       := League.Strings.To_Universal_String ("attributeFormDefault");
   Block_Default_Attribute_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("blockDefault");
   Default_Attributes_Attribute_Name : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("defaultAttributes");
   Element_Form_Default_Attribute_Name :
     constant League.Strings.Universal_String
       := League.Strings.To_Universal_String ("elementFormDefault");
   Final_Attribute_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("final");
   Final_Default_Attribute_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("finalDefault");
   Id_Attribute_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("id");
   Name_Attribute_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("name");
   Target_Namespace_Attribute_Name   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("targetNamespace");
   Version_Attribute_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("version");
   Xpath_Default_Namespace_Attribute_Name :
     constant League.Strings.Universal_String
       := League.Strings.To_Universal_String ("xpathDefaultNamespace");

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

   procedure Start_Simple_Type_Element
    (Self       : in out XML_Schema_Handler;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean);
   --  Process start of 'simpleType' element.

   -------------
   -- Current --
   -------------

   function Current (Self : XML_Schema_Handler'Class) return States is
   begin
      return Self.States.Last_Element;
   end Current;

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

         elsif Local_Name = Restriction_Element_Name then
            null;
--            End_Restriction_Element (Self, Success);

         elsif Local_Name = Schema_Element_Name then
            Self.Pop;
--            End_Schema_Element (Self, Success);

         elsif Local_Name = Simple_Type_Element_Name then
            Self.Pop;
--            End_Simple_Type_Element (Self, Success);

         else
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

   ---------
   -- Pop --
   ---------

   procedure Pop (Self : in out XML_Schema_Handler'Class) is
   begin
      Self.States.Delete_Last;
   end Pop;

   ----------
   -- Push --
   ----------

   procedure Push (Self : in out XML_Schema_Handler'Class; State : States) is
   begin
      Self.States.Append (State);
   end Push;

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
      if Self.Ignore_Depth /= 0 then
         Self.Ignore_Depth := Self.Ignore_Depth + 1;

      elsif Namespace_URI = XML_Schema_Namespace_URI then
         if Local_Name = Annotation_Element_Name then
            --  'annotation' elements and their children are ignored.

            Self.Ignore_Depth := 1;

         elsif Local_Name = Restriction_Element_Name then
            null;
--            Start_Restriction_Element (Self, Attributes, Success);

         elsif Local_Name = Schema_Element_Name then
            Start_Schema_Element (Self, Attributes, Success);

         elsif Local_Name = Simple_Type_Element_Name then
            Start_Simple_Type_Element (Self, Attributes, Success);

         else
            raise Program_Error;
         end if;

      else
         raise Program_Error;
      end if;
   end Start_Element;

   --------------------------
   -- Start_Schema_Element --
   --------------------------

   procedure Start_Schema_Element
    (Self       : in out XML_Schema_Handler;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean)
   is
      Index : Natural;

   begin
      if Self.Current /= Document then
         raise Program_Error;
      end if;

      Self.Push (Schema);

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

   end Start_Schema_Element;

   -------------------------------
   -- Start_Simple_Type_Element --
   -------------------------------

   procedure Start_Simple_Type_Element
    (Self       : in out XML_Schema_Handler;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean)
   is
      Index : Natural;
      Node  :
        Matreshka.XML_Schema.AST.Simple_Types.Simple_Type_Definition_Access;

   begin
      if Self.Current /= Schema then
         --  XXX Only global type declarations are handled now.

         raise Program_Error;
      end if;

      Self.Push (Simple_Type);

      Node :=
         new Matreshka.XML_Schema.AST.Simple_Types.Simple_Type_Definition_Node;

      --  {final}
      --
      --  A subset of {restriction, extension, list, union}, determined as
      --  follows. [Definition:]  Let FS be the ·actual value· of the final
      --  [attribute], if present, otherwise the ·actual value· of the
      --  finalDefault [attribute] of the ancestor schema element, if present,
      --  otherwise the empty string. Then the property value is the
      --  appropriate case among the following:
      --
      --  1 If ·FS· is the empty string, then the empty set;
      --
      --  2 If ·FS· is "#all", then {restriction, extension, list, union};
      --
      --  3 otherwise Consider ·FS· as a space-separated list, and include
      --  restriction if "restriction" is in that list, and similarly for
      --  extension, list and union.
      --
      --  Note: 'final' attribute of 'simpleType' element doesn't have default
      --  value and is prohibited for local types.

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

      --  XXX This is valid for 'global' definitions only.

      Index := Attributes.Index (Name_Attribute_Name);

      if Index /= 0 then
         Node.Name := Attributes.Value (Index);
      end if;

      Self.Schema.Type_Definitions.Insert
       (Node.Name,
        Matreshka.XML_Schema.AST.Types.Type_Definition_Access (Node));
   end Start_Simple_Type_Element;

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

end Matreshka.XML_Schema.Handlers;
