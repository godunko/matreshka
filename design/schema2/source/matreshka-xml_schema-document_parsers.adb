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
with Matreshka.XML_Schema.AST.Schemas;

package body Matreshka.XML_Schema.Document_Parsers is

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
   Group_Tag           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("group");
   Import_Tag          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("import");
   Include_Tag         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("include");
   Notation_Tag        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("notation");
   Redefine_Tag        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("redefine");
   Simple_Type_Tag     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("simpleType");
   Schema_Tag          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("schema");

   procedure Push_Ignore (Self : in out Document_Parser'Class);
   procedure Push_Schema (Self : in out Document_Parser'Class);
   --  Push state of parser.

   procedure Pop (Self : in out Document_Parser'Class);
   --  Pop state of parser.

   procedure Start_Schema_Element
    (Self       : in out Document_Parser'Class;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean);
   --  Parses start of root 'schema' element.

   procedure Fatal_Error
    (Self    : in out Document_Parser'Class;
     Text    : Wide_Wide_String;
     Success : in out Boolean);
   --  Reports fatal error. Sets Success to False.

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

   -----------------
   -- Push_Schema --
   -----------------

   procedure Push_Schema (Self : in out Document_Parser'Class) is
   begin
      Self.Stack.Append (Self.Current);
      Self.Current := (State => Schema);
   end Push_Schema;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out Document_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean)
   is
      use type League.Strings.Universal_String;

   begin
      if Self.Current.State = Ignore then
         Self.Current.Depth := Self.Current.Depth + 1;

      elsif Namespace_URI = XML_Schema_URI then
         case Self.Current.State is
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
                  raise Program_Error;

               elsif Local_Name = Notation_Tag then
                  raise Program_Error;

               elsif Local_Name = Redefine_Tag then
                  raise Program_Error;

               elsif Local_Name = Simple_Type_Tag then
                  raise Program_Error;

               else
                  Self.Fatal_Error ("unexpected XML element", Success);
               end if;

            when Ignore =>
               pragma Assert (False);
               --  Must never be happen.

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
     Success    : in out Boolean) is
   begin
      Self.Schema := new Matreshka.XML_Schema.AST.Schemas.Schema_Node;
      Self.Push_Schema;
   end Start_Schema_Element;

end Matreshka.XML_Schema.Document_Parsers;
