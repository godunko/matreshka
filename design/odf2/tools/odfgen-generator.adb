------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Open Document Toolkit                           --
--                                                                          --
--                              Tools Component                             --
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
with Ada.Containers.Hashed_Maps;
with Ada.Wide_Wide_Text_IO;

with League.RegExps;
with League.String_Vectors;
with League.Strings.Hash;

package body ODFGen.Generator is

   use type League.Strings.Universal_String;

   procedure Generate_Element_API
    (Template : League.String_Vectors.Universal_String_Vector;
     Element  : Element_Information);

   procedure Generate_Element_Impl_Spec
    (Template : League.String_Vectors.Universal_String_Vector;
     Element  : Element_Information);

   procedure Generate_Element_Impl_Body
    (Template : League.String_Vectors.Universal_String_Vector;
     Element  : Element_Information);

   procedure Generate_Attribute_API
    (Template  : League.String_Vectors.Universal_String_Vector;
     Attribute : Attribute_Information) renames Generate_Element_API;

   procedure Generate_Attribute_Impl_Spec
    (Template  : League.String_Vectors.Universal_String_Vector;
     Attribute : Attribute_Information) renames Generate_Element_Impl_Spec;

   procedure Generate_Attribute_Impl_Body
    (Template  : League.String_Vectors.Universal_String_Vector;
     Attribute : Attribute_Information) renames Generate_Element_Impl_Body;

   procedure Generate_String_Constants
    (Header   : League.String_Vectors.Universal_String_Vector;
     Template : League.String_Vectors.Universal_String_Vector;
     Footer   : League.String_Vectors.Universal_String_Vector);

   procedure Generate_Visitor
    (Header  : League.String_Vectors.Universal_String_Vector;
     Context : League.String_Vectors.Universal_String_Vector;
     Decls   : League.String_Vectors.Universal_String_Vector;
     Item    : League.String_Vectors.Universal_String_Vector;
     Footer  : League.String_Vectors.Universal_String_Vector);

   procedure Generate_Iterator
    (Header  : League.String_Vectors.Universal_String_Vector;
     Context : League.String_Vectors.Universal_String_Vector;
     Decls   : League.String_Vectors.Universal_String_Vector;
     Item    : League.String_Vectors.Universal_String_Vector;
     Footer  : League.String_Vectors.Universal_String_Vector)
       renames Generate_Visitor;

   procedure Generate_Document_API
    (Header  : League.String_Vectors.Universal_String_Vector;
     Context : League.String_Vectors.Universal_String_Vector;
     Decls   : League.String_Vectors.Universal_String_Vector;
     Item    : League.String_Vectors.Universal_String_Vector;
     Footer  : League.String_Vectors.Universal_String_Vector)
       renames Generate_Visitor;

   procedure Generate_Document_Impl_Spec
    (Header  : League.String_Vectors.Universal_String_Vector;
     Context : League.String_Vectors.Universal_String_Vector;
     Decls   : League.String_Vectors.Universal_String_Vector;
     Item    : League.String_Vectors.Universal_String_Vector;
     Footer  : League.String_Vectors.Universal_String_Vector)
       renames Generate_Visitor;

   procedure Generate_Document_Impl_Body
    (Header  : League.String_Vectors.Universal_String_Vector;
     Context : League.String_Vectors.Universal_String_Vector;
     Decls   : League.String_Vectors.Universal_String_Vector;
     Item    : League.String_Vectors.Universal_String_Vector;
     Footer  : League.String_Vectors.Universal_String_Vector)
       renames Generate_Visitor;

   procedure Generate_Containment_Iterator_Spec
    (Header  : League.String_Vectors.Universal_String_Vector;
     Item    : League.String_Vectors.Universal_String_Vector;
     Footer  : League.String_Vectors.Universal_String_Vector);

   procedure Generate_Containment_Iterator_Body
    (Header  : League.String_Vectors.Universal_String_Vector;
     Item    : League.String_Vectors.Universal_String_Vector;
     Footer  : League.String_Vectors.Universal_String_Vector)
       renames Generate_Containment_Iterator_Spec;

   procedure Generate_Skip_Children_Visitor_Spec
    (Header  : League.String_Vectors.Universal_String_Vector;
     Item    : League.String_Vectors.Universal_String_Vector;
     Footer  : League.String_Vectors.Universal_String_Vector)
       renames Generate_Containment_Iterator_Spec;

   procedure Generate_Skip_Children_Visitor_Body
    (Header  : League.String_Vectors.Universal_String_Vector;
     Item    : League.String_Vectors.Universal_String_Vector;
     Footer  : League.String_Vectors.Universal_String_Vector)
       renames Generate_Containment_Iterator_Spec;

   function Load_Template
    (File_Name : String) return League.String_Vectors.Universal_String_Vector;

   package Universal_String_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           League.Strings.Universal_String,
           League.Strings.Hash,
           League.Strings."=");

   procedure Apply
    (Template   : League.String_Vectors.Universal_String_Vector;
     Parameters : Universal_String_Maps.Map);

   -----------
   -- Apply --
   -----------

   procedure Apply
    (Template   : League.String_Vectors.Universal_String_Vector;
     Parameters : Universal_String_Maps.Map)
   is
      Parameter_Rexexp : constant League.Regexps.Regexp_Pattern
        := League.Regexps.Compile
            (League.Strings.To_Universal_String ("\@([A-Za-z0-9_]+)\@"));
      Match            : League.Regexps.Regexp_Match;
      Line             : League.Strings.Universal_String;

   begin
      for J in 1 .. Template.Length loop
         Line := Template (J);

         loop
            Match := Parameter_Rexexp.Find_Match (Line);

            exit when not Match.Is_Matched;

            if Parameters.Contains (Match.Capture (1)) then
               Line :=
                 Line.Slice (1, Match.First_Index - 1)
                   & Parameters (Match.Capture (1))
                   & Line.Slice (Match.Last_Index + 1, Line.Length);

            else
               Ada.Wide_Wide_Text_IO.Put_Line
                (Ada.Wide_Wide_Text_IO.Standard_Error,
                 Line.To_Wide_Wide_String);

               raise Program_Error;
            end if;
         end loop;

         Ada.Wide_Wide_Text_IO.Put_Line (Line.To_Wide_Wide_String);
      end loop;
   end Apply;

   --------------
   -- Generate --
   --------------

   procedure Generate is
      Strings_Header_Template   : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/strings-header.ads.tmpl");
      Strings_Item_Template     : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/strings-item.ads.tmpl");
      Strings_Footer_Template   : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/strings-footer.ads.tmpl");
      Visitor_Header_Template   : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/visitor-header.ads.tmpl");
      Visitor_Context_Template  : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/visitor-context.ads.tmpl");
      Visitor_Decls_Template    : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/visitor-decls.ads.tmpl");
      Visitor_Item_Template     : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/visitor-item.ads.tmpl");
      Visitor_Footer_Template   : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/visitor-footer.ads.tmpl");
      Iterator_Header_Template  : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/iterator-header.ads.tmpl");
      Iterator_Context_Template : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/iterator-context.ads.tmpl");
      Iterator_Decls_Template   : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/iterator-decls.ads.tmpl");
      Iterator_Item_Template    : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/iterator-item.ads.tmpl");
      Iterator_Footer_Template  : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/iterator-footer.ads.tmpl");
      Skip_Children_Spec_Header_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/skip_children-header.ads.tmpl");
      Skip_Children_Spec_Item_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/skip_children-item.ads.tmpl");
      Skip_Children_Spec_Footer_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/skip_children-footer.ads.tmpl");
      Skip_Children_Body_Header_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/skip_children-header.adb.tmpl");
      Skip_Children_Body_Item_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/skip_children-item.adb.tmpl");
      Skip_Children_Body_Footer_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/skip_children-footer.adb.tmpl");
      Containment_Spec_Header_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/containment-header.ads.tmpl");
      Containment_Spec_Item_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/containment-item.ads.tmpl");
      Containment_Spec_Footer_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/containment-footer.ads.tmpl");
      Containment_Body_Header_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/containment-header.adb.tmpl");
      Containment_Body_Item_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/containment-item.adb.tmpl");
      Containment_Body_Footer_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/containment-footer.adb.tmpl");
      Document_API_Header_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/document_api-header.ads.tmpl");
      Document_API_Context_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/document_api-context.ads.tmpl");
      Document_API_Decls_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/document_api-decls.ads.tmpl");
      Document_API_Item_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/document_api-item.ads.tmpl");
      Document_API_Footer_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/document_api-footer.ads.tmpl");
      Document_Impl_Spec_Header_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/document_impl-header.ads.tmpl");
      Document_Impl_Spec_Context_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/document_impl-context.ads.tmpl");
      Document_Impl_Spec_Decls_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/document_impl-decls.ads.tmpl");
      Document_Impl_Spec_Element_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/document_impl-element.ads.tmpl");
      Document_Impl_Spec_Footer_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/document_impl-footer.ads.tmpl");
      Document_Impl_Body_Header_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/document_impl-header.adb.tmpl");
      Document_Impl_Body_Context_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/document_impl-context.adb.tmpl");
      Document_Impl_Body_Decls_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/document_impl-decls.adb.tmpl");
      Document_Impl_Body_Element_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/document_impl-element.adb.tmpl");
      Document_Impl_Body_Footer_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/document_impl-footer.adb.tmpl");
      Attribute_API_Template    : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/attribute_api.ads.tmpl");
      Attribute_Impl_Spec_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/attribute_impl.ads.tmpl");
      Attribute_Impl_Body_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/attribute_impl.adb.tmpl");
      Element_API_Template      : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/element_api.ads.tmpl");
      Element_Impl_Spec_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/element_impl.ads.tmpl");
      Element_Impl_Body_Template :
        League.String_Vectors.Universal_String_Vector
          := Load_Template ("tools/templates/element_impl.adb.tmpl");

   begin
      Generate_Visitor
       (Visitor_Header_Template,
        Visitor_Context_Template,
        Visitor_Decls_Template,
        Visitor_Item_Template,
        Visitor_Footer_Template);
      Generate_Skip_Children_Visitor_Spec
       (Skip_Children_Spec_Header_Template,
        Skip_Children_Spec_Item_Template,
        Skip_Children_Spec_Footer_Template);
      Generate_Skip_Children_Visitor_Spec
       (Skip_Children_Body_Header_Template,
        Skip_Children_Body_Item_Template,
        Skip_Children_Body_Footer_Template);
      Generate_Iterator
       (Iterator_Header_Template,
        Iterator_Context_Template,
        Iterator_Decls_Template,
        Iterator_Item_Template,
        Iterator_Footer_Template);
      Generate_Containment_Iterator_Spec
       (Containment_Spec_Header_Template,
        Containment_Spec_Item_Template,
        Containment_Spec_Footer_Template);
      Generate_Containment_Iterator_Body
       (Containment_Body_Header_Template,
        Containment_Body_Item_Template,
        Containment_Body_Footer_Template);
      Generate_Document_API
       (Document_API_Header_Template,
        Document_API_Context_Template,
        Document_API_Decls_Template,
        Document_API_Item_Template,
        Document_API_Footer_Template);
      Generate_Document_Impl_Spec
       (Document_Impl_Spec_Header_Template,
        Document_Impl_Spec_Context_Template,
        Document_Impl_Spec_Decls_Template,
        Document_Impl_Spec_Element_Template,
        Document_Impl_Spec_Footer_Template);
      Generate_Document_Impl_Body
       (Document_Impl_Body_Header_Template,
        Document_Impl_Body_Context_Template,
        Document_Impl_Body_Decls_Template,
        Document_Impl_Body_Element_Template,
        Document_Impl_Body_Footer_Template);
      Generate_String_Constants
       (Strings_Header_Template,
        Strings_Item_Template,
        Strings_Footer_Template);

      for Attribute of Attributes loop
         Generate_Attribute_API (Attribute_API_Template, Attribute);
         Generate_Attribute_Impl_Spec (Attribute_Impl_Spec_Template, Attribute);
         Generate_Attribute_Impl_Body (Attribute_Impl_Body_Template, Attribute);
      end loop;

      for Element of Elements loop
         Generate_Element_API (Element_API_Template, Element);
         Generate_Element_Impl_Spec (Element_Impl_Spec_Template, Element);
         Generate_Element_Impl_Body (Element_Impl_Body_Template, Element);
      end loop;
   end Generate;

   ----------------------------------------
   -- Generate_Containment_Iterator_Spec --
   ----------------------------------------

   procedure Generate_Containment_Iterator_Spec
    (Header  : League.String_Vectors.Universal_String_Vector;
     Item    : League.String_Vectors.Universal_String_Vector;
     Footer  : League.String_Vectors.Universal_String_Vector)
   is
      Parameters : Universal_String_Maps.Map;

   begin
      Apply (Header, Universal_String_Maps.Empty_Map);

      for Element of Elements loop
         Parameters.Clear;
         Parameters.Insert
          (League.Strings.To_Universal_String ("GROUP"),
           Element.Group_Ada_Name);
         Parameters.Insert
          (League.Strings.To_Universal_String ("ELEMENT"),
           Element.Element_Ada_Name);
         Apply (Item, Parameters);
      end loop;

      Apply (Footer, Universal_String_Maps.Empty_Map);
   end Generate_Containment_Iterator_Spec;

   --------------------------
   -- Generate_Element_API --
   --------------------------

   procedure Generate_Element_API
    (Template : League.String_Vectors.Universal_String_Vector;
     Element  : Element_Information)
   is
      Parameters : Universal_String_Maps.Map;

   begin
      Parameters.Insert
       (League.Strings.To_Universal_String ("GROUP"),
        Element.Group_Ada_Name);
      Parameters.Insert
       (League.Strings.To_Universal_String ("ELEMENT"),
        Element.Element_Ada_Name);
      Apply (Template, Parameters);
   end Generate_Element_API;

   --------------------------------
   -- Generate_Element_Impl_Body --
   --------------------------------

   procedure Generate_Element_Impl_Body
    (Template : League.String_Vectors.Universal_String_Vector;
     Element  : Element_Information)
   is
      Parameters : Universal_String_Maps.Map;

   begin
      Parameters.Insert
       (League.Strings.To_Universal_String ("GROUP"),
        Element.Group_Ada_Name);
      Parameters.Insert
       (League.Strings.To_Universal_String ("ELEMENT"),
        Element.Element_Ada_Name);
      Apply (Template, Parameters);
   end Generate_Element_Impl_Body;

   --------------------------------
   -- Generate_Element_Impl_Spec --
   --------------------------------

   procedure Generate_Element_Impl_Spec
    (Template : League.String_Vectors.Universal_String_Vector;
     Element  : Element_Information)
   is
      Parameters : Universal_String_Maps.Map;

   begin
      Parameters.Insert
       (League.Strings.To_Universal_String ("GROUP"),
        Element.Group_Ada_Name);
      Parameters.Insert
       (League.Strings.To_Universal_String ("ELEMENT"),
        Element.Element_Ada_Name);
      Apply (Template, Parameters);
   end Generate_Element_Impl_Spec;

   -------------------------------
   -- Generate_String_Constants --
   -------------------------------

   procedure Generate_String_Constants
    (Header   : League.String_Vectors.Universal_String_Vector;
     Template : League.String_Vectors.Universal_String_Vector;
     Footer   : League.String_Vectors.Universal_String_Vector)
   is
      Parameters : Universal_String_Maps.Map;
      Current    : ODFGen.Universal_String_Maps.Cursor
        := Strings.First;

   begin
      Apply (Header, Universal_String_Maps.Empty_Map);

      for Namespace of Namespaces loop
         Parameters.Clear;
         Parameters.Insert
          (League.Strings.To_Universal_String ("NAME"),
           Namespace.URI_Ada_Name);
         Parameters.Insert
          (League.Strings.To_Universal_String ("IMAGE"),
           Namespace.Namespace_URI);
         Apply (Template, Parameters);
      end loop;

      for Namespace of Namespaces loop
         Parameters.Clear;
         Parameters.Insert
          (League.Strings.To_Universal_String ("NAME"),
           Namespace.Prefix_Ada_Name);
         Parameters.Insert
          (League.Strings.To_Universal_String ("IMAGE"),
           Namespace.Prefix);
         Apply (Template, Parameters);
      end loop;

      while ODFGen.Universal_String_Maps.Has_Element (Current) loop
         Parameters.Clear;
         Parameters.Insert
          (League.Strings.To_Universal_String ("NAME"),
           ODFGen.Universal_String_Maps.Key (Current));
         Parameters.Insert
          (League.Strings.To_Universal_String ("IMAGE"),
           ODFGen.Universal_String_Maps.Element (Current));
         Apply (Template, Parameters);
         ODFGen.Universal_String_Maps.Next (Current);
      end loop;

      Apply (Footer, Universal_String_Maps.Empty_Map);
   end Generate_String_Constants;

   ----------------------
   -- Generate_Visitor --
   ----------------------

   procedure Generate_Visitor
    (Header  : League.String_Vectors.Universal_String_Vector;
     Context : League.String_Vectors.Universal_String_Vector;
     Decls   : League.String_Vectors.Universal_String_Vector;
     Item    : League.String_Vectors.Universal_String_Vector;
     Footer  : League.String_Vectors.Universal_String_Vector)
   is
      Parameters : Universal_String_Maps.Map;

   begin
      Apply (Header, Universal_String_Maps.Empty_Map);

      for Element of Elements loop
         Parameters.Clear;
         Parameters.Insert
          (League.Strings.To_Universal_String ("GROUP"),
           Element.Group_Ada_Name);
         Parameters.Insert
          (League.Strings.To_Universal_String ("ELEMENT"),
           Element.Element_Ada_Name);
         Apply (Context, Parameters);
      end loop;

      Apply (Decls, Universal_String_Maps.Empty_Map);

      for Element of Elements loop
         Parameters.Clear;
         Parameters.Insert
          (League.Strings.To_Universal_String ("GROUP"),
           Element.Group_Ada_Name);
         Parameters.Insert
          (League.Strings.To_Universal_String ("ELEMENT"),
           Element.Element_Ada_Name);
         Apply (Item, Parameters);
      end loop;

      Apply (Footer, Universal_String_Maps.Empty_Map);
   end Generate_Visitor;

   -------------------
   -- Load_Template --
   -------------------

   function Load_Template
    (File_Name : String) return League.String_Vectors.Universal_String_Vector
   is
      File     : Ada.Wide_Wide_Text_IO.File_Type;
      Buffer   : Wide_Wide_String (1 .. 128);
      Last     : Natural;
      Template : League.String_Vectors.Universal_String_Vector;

   begin
      Ada.Wide_Wide_Text_IO.Open
       (File,
        Ada.Wide_Wide_Text_IO.In_File,
        File_Name);

      while not Ada.Wide_Wide_Text_IO.End_Of_File (File) loop
         Ada.Wide_Wide_Text_IO.Get_Line (File, Buffer, Last);
         Template.Append
          (League.Strings.To_Universal_String (Buffer (1 .. Last)));
      end loop;

      Ada.Wide_Wide_Text_IO.Close (File);

      return Template;
   end Load_Template;

end ODFGen.Generator;
