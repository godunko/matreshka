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
private with League.Strings;
private with XML.DOM.Nodes.Attrs;
with XML.DOM.Nodes.Documents;
private with XML.DOM.Nodes.Elements;

with ODF.DOM.Attributes.FO.Background_Color;
with ODF.DOM.Attributes.FO.Border;
with ODF.DOM.Attributes.FO.Border_Bottom;
with ODF.DOM.Attributes.FO.Border_Left;
with ODF.DOM.Attributes.FO.Border_Right;
with ODF.DOM.Attributes.FO.Border_Top;
with ODF.DOM.Attributes.FO.Country;
with ODF.DOM.Attributes.FO.Font_Weight;
with ODF.DOM.Attributes.FO.Language;
with ODF.DOM.Attributes.FO.Padding;
with ODF.DOM.Attributes.FO.Text_Align;
with ODF.DOM.Attributes.Office.Version;
with ODF.DOM.Attributes.Style.Column_Width;
with ODF.DOM.Attributes.Style.Family;
with ODF.DOM.Attributes.Style.Font_Family_Generic;
with ODF.DOM.Attributes.Style.Font_Pitch;
with ODF.DOM.Attributes.Style.Font_Weight_Asian;
with ODF.DOM.Attributes.Style.Font_Weight_Complex;
with ODF.DOM.Attributes.Style.Justify_Single_Word;
with ODF.DOM.Attributes.Style.Name;
with ODF.DOM.Attributes.Style.Parent_Style_Name;
with ODF.DOM.Attributes.Style.Rel_Column_Width;
with ODF.DOM.Attributes.Style.Vertical_Align;
with ODF.DOM.Attributes.Style.Width;
with ODF.DOM.Attributes.SVG.Font_Family;
with ODF.DOM.Attributes.Table.Align;
with ODF.DOM.Elements.Office.Automatic_Styles;
with ODF.DOM.Elements.Office.Bodies;
with ODF.DOM.Elements.Office.Document_Content;
with ODF.DOM.Elements.Office.Document_Styles;
with ODF.DOM.Elements.Office.Font_Face_Decls;
with ODF.DOM.Elements.Office.Master_Styles;
with ODF.DOM.Elements.Office.Scripts;
with ODF.DOM.Elements.Office.Styles;
with ODF.DOM.Elements.Office.Text;
with ODF.DOM.Elements.Style.Background_Image;
with ODF.DOM.Elements.Style.Default_Style;
with ODF.DOM.Elements.Style.Font_Face;
with ODF.DOM.Elements.Style.Footer_Style;
with ODF.DOM.Elements.Style.Footnote_Sep;
with ODF.DOM.Elements.Style.Graphic_Properties;
with ODF.DOM.Elements.Style.Header_Style;
with ODF.DOM.Elements.Style.List_Level_Properties;
with ODF.DOM.Elements.Style.Master_Page;
with ODF.DOM.Elements.Style.Page_Layout;
with ODF.DOM.Elements.Style.Page_Layout_Properties;
with ODF.DOM.Elements.Style.Paragraph_Properties;
with ODF.DOM.Elements.Style.Style;
with ODF.DOM.Elements.Style.Tab_Stops;
with ODF.DOM.Elements.Style.Table_Cell_Properties;
with ODF.DOM.Elements.Style.Table_Column_Properties;
with ODF.DOM.Elements.Style.Table_Properties;
with ODF.DOM.Elements.Style.Table_Row_Properties;
with ODF.DOM.Elements.Style.Text_Properties;
with ODF.DOM.Elements.Table.Covered_Table_Cell;
with ODF.DOM.Elements.Table.Table;
with ODF.DOM.Elements.Table.Table_Cell;
with ODF.DOM.Elements.Table.Table_Column;
with ODF.DOM.Elements.Table.Table_Row;
with ODF.DOM.Elements.Text.Linenumbering_Configuration;
with ODF.DOM.Elements.Text.Notes_Configuration;
with ODF.DOM.Elements.Text.Outline_Level_Style;
with ODF.DOM.Elements.Text.Outline_Style;
with ODF.DOM.Elements.Text.P;
with ODF.DOM.Elements.Text.Sequence_Decl;
with ODF.DOM.Elements.Text.Sequence_Decls;
with ODF.DOM.Elements.Text.Span;

package ODF.DOM.Documents is

   type ODF_Document is new XML.DOM.Nodes.Documents.DOM_Document with private;

   type ODF_Document_Access is access all ODF_Document'Class;

   function Create_FO_Background_Color
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Background_Color.ODF_FO_Background_Color_Access;

   function Create_FO_Border
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border.ODF_FO_Border_Access;

   function Create_FO_Border_Bottom
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Bottom.ODF_FO_Border_Bottom_Access;

   function Create_FO_Border_Left
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Left.ODF_FO_Border_Left_Access;

   function Create_FO_Border_Right
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Right.ODF_FO_Border_Right_Access;

   function Create_FO_Border_Top
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Top.ODF_FO_Border_Top_Access;

   function Create_FO_Country
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Country.ODF_FO_Country_Access;

   function Create_FO_Font_Weight
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Font_Weight.ODF_FO_Font_Weight_Access;

   function Create_FO_Language
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Language.ODF_FO_Language_Access;

   function Create_FO_Padding
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Padding.ODF_FO_Padding_Access;

   function Create_FO_Text_Align
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Text_Align.ODF_FO_Text_Align_Access;

   function Create_Office_Automatic_Styles
    (Self : not null access ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Automatic_Styles.ODF_Office_Automatic_Styles_Access;

   function Create_Office_Body
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Office.Bodies.ODF_Office_Body_Access;

   function Create_Office_Document_Content
    (Self : not null access ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Document_Content.ODF_Office_Document_Content_Access;

   function Create_Office_Document_Styles
    (Self : not null access ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Document_Styles.ODF_Office_Document_Styles_Access;

   function Create_Office_Font_Face_Decls
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Office.Font_Face_Decls.ODF_Office_Font_Face_Decls_Access;

   function Create_Office_Master_Styles
    (Self : not null access ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Master_Styles.ODF_Office_Master_Styles_Access;

   function Create_Office_Scripts
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Office.Scripts.ODF_Office_Scripts_Access;

   function Create_Office_Styles
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Office.Styles.ODF_Office_Styles_Access;

   function Create_Office_Text
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Office.Text.ODF_Office_Text_Access;

   function Create_Office_Version
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Office.Version.ODF_Office_Version_Access;

   function Create_Style_Background_Image
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Background_Image.ODF_Style_Background_Image_Access;

   function Create_Style_Column_Width
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Column_Width.ODF_Style_Column_Width_Access;

   function Create_Style_Default_Style
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style_Access;

   function Create_Style_Family
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Family.ODF_Style_Family_Access;

   function Create_Style_Font_Face
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Font_Face.ODF_Style_Font_Face_Access;

   function Create_Style_Font_Family_Generic
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Family_Generic.ODF_Style_Font_Family_Generic_Access;

   function Create_Style_Font_Pitch
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Pitch.ODF_Style_Font_Pitch_Access;

   function Create_Style_Font_Weight_Asian
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Weight_Asian.ODF_Style_Font_Weight_Asian_Access;

   function Create_Style_Font_Weight_Complex
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Weight_Complex.ODF_Style_Font_Weight_Complex_Access;

   function Create_Style_Footer_Style
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Footer_Style.ODF_Style_Footer_Style_Access;

   function Create_Style_Footnote_Sep
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Footnote_Sep.ODF_Style_Footnote_Sep_Access;

   function Create_Style_Graphic_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Graphic_Properties.ODF_Style_Graphic_Properties_Access;

   function Create_Style_Header_Style
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Header_Style.ODF_Style_Header_Style_Access;

   function Create_Style_Justify_Single_Word
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Justify_Single_Word.ODF_Style_Justify_Single_Word_Access;

   function Create_Style_List_Level_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.List_Level_Properties.ODF_Style_List_Level_Properties_Access;

   function Create_Style_Master_Page
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Master_Page.ODF_Style_Master_Page_Access;

   function Create_Style_Name
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Name.ODF_Style_Name_Access;

   function Create_Style_Page_Layout
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Page_Layout.ODF_Style_Page_Layout_Access;

   function Create_Style_Page_Layout_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Page_Layout_Properties.ODF_Style_Page_Layout_Properties_Access;

   function Create_Style_Paragraph_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Paragraph_Properties.ODF_Style_Paragraph_Properties_Access;

   function Create_Style_Parent_Style_Name
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Parent_Style_Name.ODF_Style_Parent_Style_Name_Access;

   function Create_Style_Rel_Column_Width
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Rel_Column_Width.ODF_Style_Rel_Column_Width_Access;

   function Create_Style_Style
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Style.ODF_Style_Style_Access;

   function Create_Style_Tab_Stops
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Tab_Stops.ODF_Style_Tab_Stops_Access;

   function Create_Style_Table_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Properties.ODF_Style_Table_Properties_Access;

   function Create_Style_Table_Cell_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Cell_Properties.ODF_Style_Table_Cell_Properties_Access;

   function Create_Style_Table_Column_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Column_Properties.ODF_Style_Table_Column_Properties_Access;

   function Create_Style_Table_Row_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Row_Properties.ODF_Style_Table_Row_Properties_Access;

   function Create_Style_Text_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Text_Properties.ODF_Style_Text_Properties_Access;

   function Create_Style_Vertical_Align
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Vertical_Align.ODF_Style_Vertical_Align_Access;

   function Create_Style_Width
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Width.ODF_Style_Width_Access;

   function Create_SVG_Font_Family
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.SVG.Font_Family.ODF_SVG_Font_Family_Access;

   function Create_Table_Align
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Attributes.Table.Align.ODF_Table_Align_Access;

   function Create_Table_Covered_Table_Cell
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Table.Covered_Table_Cell.ODF_Table_Covered_Table_Cell_Access;

   function Create_Table_Table
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table.ODF_Table_Table_Access;

   function Create_Table_Table_Cell
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell_Access;

   function Create_Table_Table_Column
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table_Column.ODF_Table_Table_Column_Access;

   function Create_Table_Table_Row
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row_Access;

   function Create_Text_Linenumbering_Configuration
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.Linenumbering_Configuration.ODF_Text_Linenumbering_Configuration_Access;

   function Create_Text_Notes_Configuration
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.Notes_Configuration.ODF_Text_Notes_Configuration_Access;

   function Create_Text_Outline_Level_Style
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.Outline_Level_Style.ODF_Text_Outline_Level_Style_Access;

   function Create_Text_Outline_Style
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.Outline_Style.ODF_Text_Outline_Style_Access;

   function Create_Text_P
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.P.ODF_Text_P_Access;

   function Create_Text_Sequence_Decl
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.Sequence_Decl.ODF_Text_Sequence_Decl_Access;

   function Create_Text_Sequence_Decls
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.Sequence_Decls.ODF_Text_Sequence_Decls_Access;

   function Create_Text_Span
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Text.Span.ODF_Text_Span_Access;

private

   type ODF_Document is
     new XML.DOM.Nodes.Documents.DOM_Document with null record;

   overriding function Create_Element_NS
    (Self           : not null access ODF_Document;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return XML.DOM.Nodes.Elements.DOM_Element_Access;

   overriding function Create_Attribute_NS
    (Self           : not null access ODF_Document;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return XML.DOM.Nodes.Attrs.DOM_Attr_Access;

end ODF.DOM.Documents;
