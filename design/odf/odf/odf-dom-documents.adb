------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Open Document Toolkit                           --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2013, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Ada.Wide_Wide_Text_IO;

with ODF.Constants;

package body ODF.DOM.Documents is

   use ODF.Constants;
   use type League.Strings.Universal_String;

   function Get_Local_Name
    (Qualified_Name : League.Strings.Universal_String)
       return League.Strings.Universal_String;
   --  Returns local name part of the given qualified name.

   -------------------------
   -- Create_Attribute_NS --
   -------------------------

   overriding function Create_Attribute_NS
    (Self           : not null access ODF_Document;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return XML.DOM.Nodes.Attrs.DOM_Attr_Access
   is
      Local_Name : constant League.Strings.Universal_String
        := Get_Local_Name (Qualified_Name);

   begin
      if Namespace_URI = FO_URI then
         if Local_Name = Background_Color_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access
               (Self.Create_FO_Background_Color);

         elsif Local_Name = Border_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access (Self.Create_FO_Border);

         elsif Local_Name = Border_Bottom_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access (Self.Create_FO_Border_Bottom);

         elsif Local_Name = Border_Left_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access (Self.Create_FO_Border_Left);

         elsif Local_Name = Border_Right_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access
               (Self.Create_FO_Border_Right);

         elsif Local_Name = Border_Top_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access (Self.Create_FO_Border_Top);

         elsif Local_Name = Country_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access (Self.Create_FO_Country);

         elsif Local_Name = Font_Weight_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access (Self.Create_FO_Font_Weight);

         elsif Local_Name = Language_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access (Self.Create_FO_Language);

         elsif Local_Name = Padding_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access (Self.Create_FO_Padding);

         elsif Local_Name = Text_Align_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access (Self.Create_FO_Text_Align);
         end if;

      elsif Namespace_URI = Office_URI then
         if Local_Name = Version_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access
               (Self.Create_Office_Version);
         end if;

      elsif Namespace_URI = Style_URI then
         if Local_Name = Column_Width_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access
               (Self.Create_Style_Column_Width);

         elsif Local_Name = Name_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access (Self.Create_Style_Name);

         elsif Local_Name = Family_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access (Self.Create_Style_Family);

         elsif Local_Name = Font_Family_Generic_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access
               (Self.Create_Style_Font_Family_Generic);

         elsif Local_Name = Font_Pitch_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access
               (Self.Create_Style_Font_Pitch);

         elsif Local_Name = Font_Weight_Asian_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access
               (Self.Create_Style_Font_Weight_Asian);

         elsif Local_Name = Font_Weight_Complex_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access
               (Self.Create_Style_Font_Weight_Complex);

         elsif Local_Name = Justify_Single_Word_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access (Self.Create_Style_Justify_Single_Word);

         elsif Local_Name = Parent_Style_Name_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access
               (Self.Create_Style_Parent_Style_Name);

         elsif Local_Name = Rel_Column_Width_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access
               (Self.Create_Style_Rel_Column_Width);

         elsif Local_Name = Vertical_Align_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access
               (Self.Create_Style_Vertical_Align);

         elsif Local_Name = Width_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access (Self.Create_Style_Width);
         end if;

      elsif Namespace_URI = SVG_URI then
         if Local_Name = Font_Family_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access
               (Self.Create_SVG_Font_Family);
         end if;

      elsif Namespace_URI = Table_URI then
         if Local_Name = Align_Name then
            return
              XML.DOM.Nodes.Attrs.DOM_Attr_Access (Self.Create_Table_Align);
         end if;
      end if;

      Ada.Wide_Wide_Text_IO.Put_Line
       (Ada.Wide_Wide_Text_IO.Standard_Error,
        "  {"
          & Namespace_URI.To_Wide_Wide_String
          & '}'
          & Local_Name.To_Wide_Wide_String
          & ' '
          & Qualified_Name.To_Wide_Wide_String);

      raise Program_Error;
   end Create_Attribute_NS;

   -----------------------
   -- Create_Element_NS --
   -----------------------

   overriding function Create_Element_NS
    (Self           : not null access ODF_Document;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return XML.DOM.Nodes.Elements.DOM_Element_Access
   is
      Local_Name : constant League.Strings.Universal_String
        := Get_Local_Name (Qualified_Name);

   begin
      if Namespace_URI = Office_URI then
         if Local_Name = Body_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Office_Body);

         elsif Local_Name = Automatic_Styles_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Office_Automatic_Styles);

         elsif Local_Name = Document_Content_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Office_Document_Content);

         elsif Local_Name = Document_Styles_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Office_Document_Styles);

         elsif Local_Name = Font_Face_Decls_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Office_Font_Face_Decls);

         elsif Local_Name = Master_Styles_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Office_Master_Styles);

         elsif Local_Name = Scripts_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Office_Scripts);

         elsif Local_Name = Styles_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Office_Styles);

         elsif Local_Name = Text_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Office_Text);

         else
            raise Program_Error;
         end if;

      elsif Namespace_URI = Style_URI then
         if Local_Name = Background_Image_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Background_Image);

         elsif Local_Name = Default_Style_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Default_Style);

         elsif Local_Name = Font_Face_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Font_Face);

         elsif Local_Name = Footer_Style_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Footer_Style);

         elsif Local_Name = Footnote_Sep_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Footnote_Sep);

         elsif Local_Name = Graphic_Properties_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Graphic_Properties);

         elsif Local_Name = Header_Style_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Header_Style);

         elsif Local_Name = List_Level_Properties_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_List_Level_Properties);

         elsif Local_Name = Master_Page_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Master_Page);

         elsif Local_Name = Page_Layout_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Page_Layout);

         elsif Local_Name = Page_Layout_Properties_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Page_Layout_Properties);

         elsif Local_Name = Paragraph_Properties_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Paragraph_Properties);

         elsif Local_Name = Style_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Style);

         elsif Local_Name = Tab_Stops_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Tab_Stops);

         elsif Local_Name = Table_Cell_Properties_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Table_Cell_Properties);

         elsif Local_Name = Table_Column_Properties_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Table_Column_Properties);

         elsif Local_Name = Table_Properties_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Table_Properties);

         elsif Local_Name = Table_Row_Properties_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Table_Row_Properties);

         elsif Local_Name = Text_Properties_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Text_Properties);

         else
            raise Program_Error;
         end if;

      elsif Namespace_URI = Table_URI then
         if Local_Name = Covered_Table_Cell_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Table_Covered_Table_Cell);

         elsif Local_Name = Table_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Table_Table);

         elsif Local_Name = Table_Cell_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Table_Table_Cell);

         elsif Local_Name = Table_Column_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Table_Table_Column);

         elsif Local_Name = Table_Row_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Table_Table_Row);

         else
            raise Program_Error;
         end if;

      elsif Namespace_URI = Text_URI then
         if Local_Name = Linenumbering_Configuration_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Text_Linenumbering_Configuration);

         elsif Local_Name = Notes_Configuration_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Text_Notes_Configuration);

         elsif Local_Name = Outline_Level_Style_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Text_Outline_Level_Style);

         elsif Local_Name = Outline_Style_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Text_Outline_Style);

         elsif Local_Name = P_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Text_P);

         elsif Local_Name = Sequence_Decl_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Text_Sequence_Decl);

         elsif Local_Name = Sequence_Decls_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Text_Sequence_Decls);

         elsif Local_Name = Span_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Text_Span);

         else
            raise Program_Error;
         end if;

      else
         raise Program_Error;
      end if;
   end Create_Element_NS;

   --------------------------------
   -- Create_FO_Background_Color --
   --------------------------------

   function Create_FO_Background_Color
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Background_Color.ODF_FO_Background_Color_Access is
   begin
      return new ODF.DOM.Attributes.FO.Background_Color.ODF_FO_Background_Color;
   end Create_FO_Background_Color;

   ----------------------
   -- Create_FO_Border --
   ----------------------

   function Create_FO_Border
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border.ODF_FO_Border_Access is
   begin
      return new ODF.DOM.Attributes.FO.Border.ODF_FO_Border;
   end Create_FO_Border;

   -----------------------------
   -- Create_FO_Border_Bottom --
   -----------------------------

   function Create_FO_Border_Bottom
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Bottom.ODF_FO_Border_Bottom_Access is
   begin
      return new ODF.DOM.Attributes.FO.Border_Bottom.ODF_FO_Border_Bottom;
   end Create_FO_Border_Bottom;

   ---------------------------
   -- Create_FO_Border_Left --
   ---------------------------

   function Create_FO_Border_Left
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Left.ODF_FO_Border_Left_Access is
   begin
      return new ODF.DOM.Attributes.FO.Border_Left.ODF_FO_Border_Left;
   end Create_FO_Border_Left;

   ----------------------------
   -- Create_FO_Border_Right --
   ----------------------------

   function Create_FO_Border_Right
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Right.ODF_FO_Border_Right_Access is
   begin
      return new ODF.DOM.Attributes.FO.Border_Right.ODF_FO_Border_Right;
   end Create_FO_Border_Right;

   --------------------------
   -- Create_FO_Border_Top --
   --------------------------

   function Create_FO_Border_Top
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Top.ODF_FO_Border_Top_Access is
   begin
      return new ODF.DOM.Attributes.FO.Border_Top.ODF_FO_Border_Top;
   end Create_FO_Border_Top;

   -----------------------
   -- Create_FO_Country --
   -----------------------

   function Create_FO_Country
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Country.ODF_FO_Country_Access is
   begin
      return new ODF.DOM.Attributes.FO.Country.ODF_FO_Country;
   end Create_FO_Country;

   ---------------------------
   -- Create_FO_Font_Weight --
   ---------------------------

   function Create_FO_Font_Weight
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Font_Weight.ODF_FO_Font_Weight_Access is
   begin
      return new ODF.DOM.Attributes.FO.Font_Weight.ODF_FO_Font_Weight;
   end Create_FO_Font_Weight;

   ------------------------
   -- Create_FO_Language --
   ------------------------

   function Create_FO_Language
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Language.ODF_FO_Language_Access is
   begin
      return new ODF.DOM.Attributes.FO.Language.ODF_FO_Language;
   end Create_FO_Language;

   -----------------------
   -- Create_FO_Padding --
   -----------------------

   function Create_FO_Padding
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Padding.ODF_FO_Padding_Access is
   begin
      return new ODF.DOM.Attributes.FO.Padding.ODF_FO_Padding;
   end Create_FO_Padding;

   --------------------------
   -- Create_FO_Text_Align --
   --------------------------

   function Create_FO_Text_Align
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Text_Align.ODF_FO_Text_Align_Access is
   begin
      return new ODF.DOM.Attributes.FO.Text_Align.ODF_FO_Text_Align;
   end Create_FO_Text_Align;

   ------------------------------------
   -- Create_Office_Automatic_Styles --
   ------------------------------------

   function Create_Office_Automatic_Styles
    (Self : not null access ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Automatic_Styles.ODF_Office_Automatic_Styles_Access is
   begin
      return
        new ODF.DOM.Elements.Office.Automatic_Styles.ODF_Office_Automatic_Styles;
   end Create_Office_Automatic_Styles;

   ------------------------
   -- Create_Office_Body --
   ------------------------

   function Create_Office_Body
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Office.Bodies.ODF_Office_Body_Access is
   begin
      return new ODF.DOM.Elements.Office.Bodies.ODF_Office_Body;
   end Create_Office_Body;

   ------------------------------------
   -- Create_Office_Document_Content --
   ------------------------------------

   function Create_Office_Document_Content
    (Self : not null access ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Document_Content.ODF_Office_Document_Content_Access is
   begin
      return
        new ODF.DOM.Elements.Office.Document_Content.ODF_Office_Document_Content;
   end Create_Office_Document_Content;

   -----------------------------------
   -- Create_Office_Document_Styles --
   -----------------------------------

   function Create_Office_Document_Styles
    (Self : not null access ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Document_Styles.ODF_Office_Document_Styles_Access is
   begin
      return
        new ODF.DOM.Elements.Office.Document_Styles.ODF_Office_Document_Styles;
   end Create_Office_Document_Styles;

   -----------------------------------
   -- Create_Office_Font_Face_Decls --
   -----------------------------------

   function Create_Office_Font_Face_Decls
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Office.Font_Face_Decls.ODF_Office_Font_Face_Decls_Access is
   begin
      return
        new ODF.DOM.Elements.Office.Font_Face_Decls.ODF_Office_Font_Face_Decls;
   end Create_Office_Font_Face_Decls;

   ---------------------------------
   -- Create_Office_Master_Styles --
   ---------------------------------

   function Create_Office_Master_Styles
    (Self : not null access ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Master_Styles.ODF_Office_Master_Styles_Access is
   begin
      return
        new ODF.DOM.Elements.Office.Master_Styles.ODF_Office_Master_Styles;
   end Create_Office_Master_Styles;

   ---------------------------
   -- Create_Office_Scripts --
   ---------------------------

   function Create_Office_Scripts
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Office.Scripts.ODF_Office_Scripts_Access is
   begin
      return new ODF.DOM.Elements.Office.Scripts.ODF_Office_Scripts;
   end Create_Office_Scripts;

   --------------------------
   -- Create_Office_Styles --
   --------------------------

   function Create_Office_Styles
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Office.Styles.ODF_Office_Styles_Access is
   begin
      return new ODF.DOM.Elements.Office.Styles.ODF_Office_Styles;
   end Create_Office_Styles;

   ------------------------
   -- Create_Office_Text --
   ------------------------

   function Create_Office_Text
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Office.Text.ODF_Office_Text_Access is
   begin
      return new ODF.DOM.Elements.Office.Text.ODF_Office_Text;
   end Create_Office_Text;

   ---------------------------
   -- Create_Office_Version --
   ---------------------------

   function Create_Office_Version
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Office.Version.ODF_Office_Version_Access is
   begin
      return new ODF.DOM.Attributes.Office.Version.ODF_Office_Version;
   end Create_Office_Version;

   -----------------------------------
   -- Create_Style_Background_Image --
   -----------------------------------

   function Create_Style_Background_Image
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Background_Image.ODF_Style_Background_Image_Access is
   begin
      return new ODF.DOM.Elements.Style.Background_Image.ODF_Style_Background_Image;
   end Create_Style_Background_Image;

   -------------------------------
   -- Create_Style_Column_Width --
   -------------------------------

   function Create_Style_Column_Width
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Column_Width.ODF_Style_Column_Width_Access is
   begin
      return new ODF.DOM.Attributes.Style.Column_Width.ODF_Style_Column_Width;
   end Create_Style_Column_Width;

   --------------------------------
   -- Create_Style_Default_Style --
   --------------------------------

   function Create_Style_Default_Style
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style_Access is
   begin
      return new ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style;
   end Create_Style_Default_Style;

   -------------------------
   -- Create_Style_Family --
   -------------------------

   function Create_Style_Family
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Family.ODF_Style_Family_Access is
   begin
      return new ODF.DOM.Attributes.Style.Family.ODF_Style_Family;
   end Create_Style_Family;

   ----------------------------
   -- Create_Style_Font_Face --
   ----------------------------

   function Create_Style_Font_Face
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Font_Face.ODF_Style_Font_Face_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Font_Face.ODF_Style_Font_Face;
   end Create_Style_Font_Face;

   --------------------------------------
   -- Create_Style_Font_Family_Generic --
   --------------------------------------

   function Create_Style_Font_Family_Generic
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Family_Generic.ODF_Style_Font_Family_Generic_Access is
   begin
      return new ODF.DOM.Attributes.Style.Font_Family_Generic.ODF_Style_Font_Family_Generic;
   end Create_Style_Font_Family_Generic;

   -----------------------------
   -- Create_Style_Font_Pitch --
   -----------------------------

   function Create_Style_Font_Pitch
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Pitch.ODF_Style_Font_Pitch_Access is
   begin
      return new ODF.DOM.Attributes.Style.Font_Pitch.ODF_Style_Font_Pitch;
   end Create_Style_Font_Pitch;

   ------------------------------------
   -- Create_Style_Font_Weight_Asian --
   ------------------------------------

   function Create_Style_Font_Weight_Asian
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Weight_Asian.ODF_Style_Font_Weight_Asian_Access is
   begin
      return new ODF.DOM.Attributes.Style.Font_Weight_Asian.ODF_Style_Font_Weight_Asian;
   end Create_Style_Font_Weight_Asian;

   --------------------------------------
   -- Create_Style_Font_Weight_Complex --
   --------------------------------------

   function Create_Style_Font_Weight_Complex
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Weight_Complex.ODF_Style_Font_Weight_Complex_Access is
   begin
      return new ODF.DOM.Attributes.Style.Font_Weight_Complex.ODF_Style_Font_Weight_Complex;
   end Create_Style_Font_Weight_Complex;

   -------------------------------
   -- Create_Style_Footer_Style --
   -------------------------------

   function Create_Style_Footer_Style
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Footer_Style.ODF_Style_Footer_Style_Access is
   begin
      return new ODF.DOM.Elements.Style.Footer_Style.ODF_Style_Footer_Style;
   end Create_Style_Footer_Style;

   -------------------------------
   -- Create_Style_Footnote_Sep --
   -------------------------------

   function Create_Style_Footnote_Sep
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Footnote_Sep.ODF_Style_Footnote_Sep_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Footnote_Sep.ODF_Style_Footnote_Sep;
   end Create_Style_Footnote_Sep;

   -------------------------------------
   -- Create_Style_Graphic_Properties --
   -------------------------------------

   function Create_Style_Graphic_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Graphic_Properties.ODF_Style_Graphic_Properties_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Graphic_Properties.ODF_Style_Graphic_Properties;
   end Create_Style_Graphic_Properties;

   -------------------------------
   -- Create_Style_Header_Style --
   -------------------------------

   function Create_Style_Header_Style
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Header_Style.ODF_Style_Header_Style_Access is
   begin
      return new ODF.DOM.Elements.Style.Header_Style.ODF_Style_Header_Style;
   end Create_Style_Header_Style;

   --------------------------------------
   -- Create_Style_Justify_Single_Word --
   --------------------------------------

   function Create_Style_Justify_Single_Word
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Justify_Single_Word.ODF_Style_Justify_Single_Word_Access is
   begin
      return new ODF.DOM.Attributes.Style.Justify_Single_Word.ODF_Style_Justify_Single_Word;
   end Create_Style_Justify_Single_Word;

   ----------------------------------------
   -- Create_Style_List_Level_Properties --
   ----------------------------------------

   function Create_Style_List_Level_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.List_Level_Properties.ODF_Style_List_Level_Properties_Access is
   begin
      return
        new ODF.DOM.Elements.Style.List_Level_Properties.ODF_Style_List_Level_Properties;
   end Create_Style_List_Level_Properties;

   ------------------------------
   -- Create_Style_Master_Page --
   ------------------------------

   function Create_Style_Master_Page
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Master_Page.ODF_Style_Master_Page_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Master_Page.ODF_Style_Master_Page;
   end Create_Style_Master_Page;

   -----------------------
   -- Create_Style_Name --
   -----------------------

   function Create_Style_Name
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Name.ODF_Style_Name_Access is
   begin
      return new ODF.DOM.Attributes.Style.Name.ODF_Style_Name;
   end Create_Style_Name;

   ------------------------------
   -- Create_Style_Page_Layout --
   ------------------------------

   function Create_Style_Page_Layout
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Page_Layout.ODF_Style_Page_Layout_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Page_Layout.ODF_Style_Page_Layout;
   end Create_Style_Page_Layout;

   -----------------------------------------
   -- Create_Style_Page_Layout_Properties --
   -----------------------------------------

   function Create_Style_Page_Layout_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Page_Layout_Properties.ODF_Style_Page_Layout_Properties_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Page_Layout_Properties.ODF_Style_Page_Layout_Properties;
   end Create_Style_Page_Layout_Properties;

   ---------------------------------------
   -- Create_Style_Paragraph_Properties --
   ---------------------------------------

   function Create_Style_Paragraph_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Paragraph_Properties.ODF_Style_Paragraph_Properties_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Paragraph_Properties.ODF_Style_Paragraph_Properties;
   end Create_Style_Paragraph_Properties;

   ------------------------------------
   -- Create_Style_Parent_Style_Name --
   ------------------------------------

   function Create_Style_Parent_Style_Name
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Parent_Style_Name.ODF_Style_Parent_Style_Name_Access is
   begin
      return new ODF.DOM.Attributes.Style.Parent_Style_Name.ODF_Style_Parent_Style_Name;
   end Create_Style_Parent_Style_Name;

   -----------------------------------
   -- Create_Style_Rel_Column_Width --
   -----------------------------------

   function Create_Style_Rel_Column_Width
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Rel_Column_Width.ODF_Style_Rel_Column_Width_Access is
   begin
      return new ODF.DOM.Attributes.Style.Rel_Column_Width.ODF_Style_Rel_Column_Width;
   end Create_Style_Rel_Column_Width;

   ------------------------
   -- Create_Style_Style --
   ------------------------

   function Create_Style_Style
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Style.ODF_Style_Style_Access is
   begin
      return new ODF.DOM.Elements.Style.Style.ODF_Style_Style;
   end Create_Style_Style;

   ----------------------------
   -- Create_Style_Tab_Stops --
   ----------------------------

   function Create_Style_Tab_Stops
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Tab_Stops.ODF_Style_Tab_Stops_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Tab_Stops.ODF_Style_Tab_Stops;
   end Create_Style_Tab_Stops;

   ----------------------------------------
   -- Create_Style_Table_Cell_Properties --
   ----------------------------------------

   function Create_Style_Table_Cell_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Cell_Properties.ODF_Style_Table_Cell_Properties_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Table_Cell_Properties.ODF_Style_Table_Cell_Properties;
   end Create_Style_Table_Cell_Properties;

   ------------------------------------------
   -- Create_Style_Table_Column_Properties --
   ------------------------------------------

   function Create_Style_Table_Column_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Column_Properties.ODF_Style_Table_Column_Properties_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Table_Column_Properties.ODF_Style_Table_Column_Properties;
   end Create_Style_Table_Column_Properties;

   -----------------------------------
   -- Create_Style_Table_Properties --
   -----------------------------------

   function Create_Style_Table_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Properties.ODF_Style_Table_Properties_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Table_Properties.ODF_Style_Table_Properties;
   end Create_Style_Table_Properties;

   ---------------------------------------
   -- Create_Style_Table_Row_Properties --
   ---------------------------------------

   function Create_Style_Table_Row_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Row_Properties.ODF_Style_Table_Row_Properties_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Table_Row_Properties.ODF_Style_Table_Row_Properties;
   end Create_Style_Table_Row_Properties;

   ----------------------------------
   -- Create_Style_Text_Properties --
   ----------------------------------

   function Create_Style_Text_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Text_Properties.ODF_Style_Text_Properties_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Text_Properties.ODF_Style_Text_Properties;
   end Create_Style_Text_Properties;

   ---------------------------------
   -- Create_Style_Vertical_Align --
   ---------------------------------

   function Create_Style_Vertical_Align
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Vertical_Align.ODF_Style_Vertical_Align_Access is
   begin
      return new ODF.DOM.Attributes.Style.Vertical_Align.ODF_Style_Vertical_Align;
   end Create_Style_Vertical_Align;

   ------------------------
   -- Create_Style_Width --
   ------------------------

   function Create_Style_Width
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Width.ODF_Style_Width_Access is
   begin
      return new ODF.DOM.Attributes.Style.Width.ODF_Style_Width;
   end Create_Style_Width;

   ------------------------
   -- Create_SVG_Version --
   ------------------------

   function Create_SVG_Font_Family
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.SVG.Font_Family.ODF_SVG_Font_Family_Access is
   begin
      return new ODF.DOM.Attributes.SVG.Font_Family.ODF_SVG_Font_Family;
   end Create_SVG_Font_Family;

   ------------------------
   -- Create_Table_Align --
   ------------------------

   function Create_Table_Align
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Table.Align.ODF_Table_Align_Access is
   begin
      return new ODF.DOM.Attributes.Table.Align.ODF_Table_Align;
   end Create_Table_Align;

   -------------------------------------
   -- Create_Table_Covered_Table_Cell --
   -------------------------------------

   function Create_Table_Covered_Table_Cell
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Table.Covered_Table_Cell.ODF_Table_Covered_Table_Cell_Access is
   begin
      return new ODF.DOM.Elements.Table.Covered_Table_Cell.ODF_Table_Covered_Table_Cell;
   end Create_Table_Covered_Table_Cell;

   ------------------------
   -- Create_Table_Table --
   ------------------------

   function Create_Table_Table
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table.ODF_Table_Table_Access is
   begin
      return new ODF.DOM.Elements.Table.Table.ODF_Table_Table;
   end Create_Table_Table;

   -----------------------------
   -- Create_Table_Table_Cell --
   -----------------------------

   function Create_Table_Table_Cell
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell_Access is
   begin
      return new ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell;
   end Create_Table_Table_Cell;

   -------------------------------
   -- Create_Table_Table_Column --
   -------------------------------

   function Create_Table_Table_Column
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table_Column.ODF_Table_Table_Column_Access is
   begin
      return new ODF.DOM.Elements.Table.Table_Column.ODF_Table_Table_Column;
   end Create_Table_Table_Column;

   ----------------------------
   -- Create_Table_Table_Row --
   ----------------------------

   function Create_Table_Table_Row
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row_Access is
   begin
      return new ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row;
   end Create_Table_Table_Row;

   ---------------------------------------------
   -- Create_Text_Linenumbering_Configuration --
   ---------------------------------------------

   function Create_Text_Linenumbering_Configuration
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.Linenumbering_Configuration.ODF_Text_Linenumbering_Configuration_Access is
   begin
      return
        new ODF.DOM.Elements.Text.Linenumbering_Configuration.ODF_Text_Linenumbering_Configuration;
   end Create_Text_Linenumbering_Configuration;

   -------------------------------------
   -- Create_Text_Notes_Configuration --
   -------------------------------------

   function Create_Text_Notes_Configuration
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.Notes_Configuration.ODF_Text_Notes_Configuration_Access is
   begin
      return
        new ODF.DOM.Elements.Text.Notes_Configuration.ODF_Text_Notes_Configuration;
   end Create_Text_Notes_Configuration;

   -------------------------------------
   -- Create_Text_Outline_Level_Style --
   -------------------------------------

   function Create_Text_Outline_Level_Style
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.Outline_Level_Style.ODF_Text_Outline_Level_Style_Access is
   begin
      return
        new ODF.DOM.Elements.Text.Outline_Level_Style.ODF_Text_Outline_Level_Style;
   end Create_Text_Outline_Level_Style;

   -------------------------------
   -- Create_Text_Outline_Style --
   -------------------------------

   function Create_Text_Outline_Style
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.Outline_Style.ODF_Text_Outline_Style_Access is
   begin
      return
        new ODF.DOM.Elements.Text.Outline_Style.ODF_Text_Outline_Style;
   end Create_Text_Outline_Style;

   -------------------
   -- Create_Text_P --
   -------------------

   function Create_Text_P
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.P.ODF_Text_P_Access is
   begin
      return
        new ODF.DOM.Elements.Text.P.ODF_Text_P;
   end Create_Text_P;

   -------------------------------
   -- Create_Text_Sequence_Decl --
   -------------------------------

   function Create_Text_Sequence_Decl
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.Sequence_Decl.ODF_Text_Sequence_Decl_Access is
   begin
      return
        new ODF.DOM.Elements.Text.Sequence_Decl.ODF_Text_Sequence_Decl;
   end Create_Text_Sequence_Decl;

   --------------------------------
   -- Create_Text_Sequence_Decls --
   --------------------------------

   function Create_Text_Sequence_Decls
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.Sequence_Decls.ODF_Text_Sequence_Decls_Access is
   begin
      return
        new ODF.DOM.Elements.Text.Sequence_Decls.ODF_Text_Sequence_Decls;
   end Create_Text_Sequence_Decls;

   ----------------------
   -- Create_Text_Span --
   ----------------------

   function Create_Text_Span
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.Span.ODF_Text_Span_Access is
   begin
      return
        new ODF.DOM.Elements.Text.Span.ODF_Text_Span;
   end Create_Text_Span;

   --------------------
   -- Get_Local_Name --
   --------------------

   function Get_Local_Name
    (Qualified_Name : League.Strings.Universal_String)
       return League.Strings.Universal_String
   is
      Index : constant Natural := Qualified_Name.Index (':');

   begin
      if Index = 0 then
         return Qualified_Name;

      else
         return Qualified_Name.Slice (Index + 1, Qualified_Name.Length);
      end if;
   end Get_Local_Name;

end ODF.DOM.Documents;
