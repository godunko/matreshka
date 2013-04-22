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
with League.Strings;
with Matreshka.XML.DOM_Nodes.Documents;

with Matreshka.ODF_Attributes.Draw.End_Line_Spacing_Horizontal;
with Matreshka.ODF_Attributes.Draw.End_Line_Spacing_Vertical;
with Matreshka.ODF_Attributes.Draw.Fill_Color;
with Matreshka.ODF_Attributes.Draw.Shadow_Offset_X;
with Matreshka.ODF_Attributes.Draw.Shadow_Offset_Y;
with Matreshka.ODF_Attributes.Draw.Start_Line_Spacing_Horizontal;
with Matreshka.ODF_Attributes.Draw.Start_Line_Spacing_Vertical;
with Matreshka.ODF_Attributes.FO.Background_Color;
with Matreshka.ODF_Attributes.FO.Border;
with Matreshka.ODF_Attributes.FO.Border_Bottom;
with Matreshka.ODF_Attributes.FO.Border_Left;
with Matreshka.ODF_Attributes.FO.Border_Right;
with Matreshka.ODF_Attributes.FO.Border_Top;
with Matreshka.ODF_Attributes.FO.Country;
with Matreshka.ODF_Attributes.FO.Font_Size;
with Matreshka.ODF_Attributes.FO.Font_Style;
with Matreshka.ODF_Attributes.FO.Font_Weight;
with Matreshka.ODF_Attributes.FO.Hyphenate;
with Matreshka.ODF_Attributes.FO.Hyphenation_Ladder_Count;
with Matreshka.ODF_Attributes.FO.Hyphenation_Push_Char_Count;
with Matreshka.ODF_Attributes.FO.Hyphenation_Remain_Char_Count;
with Matreshka.ODF_Attributes.FO.Keep_Together;
with Matreshka.ODF_Attributes.FO.Keep_With_Next;
with Matreshka.ODF_Attributes.FO.Language;
with Matreshka.ODF_Attributes.FO.Margin;
with Matreshka.ODF_Attributes.FO.Margin_Bottom;
with Matreshka.ODF_Attributes.FO.Margin_Left;
with Matreshka.ODF_Attributes.FO.Margin_Right;
with Matreshka.ODF_Attributes.FO.Margin_Top;
with Matreshka.ODF_Attributes.FO.Padding;
with Matreshka.ODF_Attributes.FO.Page_Height;
with Matreshka.ODF_Attributes.FO.Page_Width;
with Matreshka.ODF_Attributes.FO.Text_Align;
with Matreshka.ODF_Attributes.FO.Text_Indent;
with Matreshka.ODF_Attributes.FO.Wrap_Option;
with Matreshka.ODF_Attributes.Office.Value_Type;
with Matreshka.ODF_Attributes.Office.Version;
with Matreshka.ODF_Attributes.Style.Adjustment;
with Matreshka.ODF_Attributes.Style.Class;
with Matreshka.ODF_Attributes.Style.Color;
with Matreshka.ODF_Attributes.Style.Column_Width;
with Matreshka.ODF_Attributes.Style.Contextual_Spacing;
with Matreshka.ODF_Attributes.Style.Country_Asian;
with Matreshka.ODF_Attributes.Style.Country_Complex;
--with Matreshka.ODF_Attributes.Style.Default_Outline_Level;
--with Matreshka.ODF_Attributes.Style.Display_Name;
--with Matreshka.ODF_Attributes.Style.Distance_After_Sep;
--with Matreshka.ODF_Attributes.Style.Distance_Before_Sep;
--with Matreshka.ODF_Attributes.Style.Family;
--with Matreshka.ODF_Attributes.Style.Flow_With_Text;
--with Matreshka.ODF_Attributes.Style.Font_Family_Generic;
--with Matreshka.ODF_Attributes.Style.Font_Independent_Line_Spacing;
--with Matreshka.ODF_Attributes.Style.Font_Name;
--with Matreshka.ODF_Attributes.Style.Font_Name_Asian;
--with Matreshka.ODF_Attributes.Style.Font_Name_Complex;
--with Matreshka.ODF_Attributes.Style.Font_Pitch;
--with Matreshka.ODF_Attributes.Style.Font_Size_Asian;
--with Matreshka.ODF_Attributes.Style.Font_Size_Complex;
--with Matreshka.ODF_Attributes.Style.Font_Style_Asian;
--with Matreshka.ODF_Attributes.Style.Font_Style_Complex;
--with Matreshka.ODF_Attributes.Style.Font_Weight_Asian;
--with Matreshka.ODF_Attributes.Style.Font_Weight_Complex;
--with Matreshka.ODF_Attributes.Style.Footnote_Max_Height;
--with Matreshka.ODF_Attributes.Style.Justify_Single_Word;
--with Matreshka.ODF_Attributes.Style.Language_Asian;
--with Matreshka.ODF_Attributes.Style.Language_Complex;
--with Matreshka.ODF_Attributes.Style.Letter_Kerning;
--with Matreshka.ODF_Attributes.Style.Line_Break;
--with Matreshka.ODF_Attributes.Style.Line_Style;
--with Matreshka.ODF_Attributes.Style.Name;
--with Matreshka.ODF_Attributes.Style.Next_Style_Name;
--with Matreshka.ODF_Attributes.Style.Num_Format;
--with Matreshka.ODF_Attributes.Style.Page_Layout_Name;
--with Matreshka.ODF_Attributes.Style.Parent_Style_Name;
--with Matreshka.ODF_Attributes.Style.Print_Orientation;
--with Matreshka.ODF_Attributes.Style.Punctuation_Wrap;
--with Matreshka.ODF_Attributes.Style.Rel_Column_Width;
--with Matreshka.ODF_Attributes.Style.Rel_Width;
--with Matreshka.ODF_Attributes.Style.Tab_Stop_Distance;
--with Matreshka.ODF_Attributes.Style.Text_Autospace;
--with Matreshka.ODF_Attributes.Style.Text_Underline_Color;
--with Matreshka.ODF_Attributes.Style.Text_Underline_Style;
--with Matreshka.ODF_Attributes.Style.Text_Underline_Width;
--with Matreshka.ODF_Attributes.Style.Use_Window_Font_Color;
--with Matreshka.ODF_Attributes.Style.Vertical_Align;
--with Matreshka.ODF_Attributes.Style.Width;
--with Matreshka.ODF_Attributes.Style.Writing_Mode;
--with Matreshka.ODF_Attributes.SVG.Font_Family;
--with Matreshka.ODF_Attributes.SVG.Stroke_Color;
--with Matreshka.ODF_Attributes.Table.Align;
--with Matreshka.ODF_Attributes.Table.Border_Model;
--with Matreshka.ODF_Attributes.Table.Name;
--with Matreshka.ODF_Attributes.Table.Number_Columns_Spanned;
--with Matreshka.ODF_Attributes.Table.Style_Name;
--with Matreshka.ODF_Attributes.Text.Display_Outline_Level;
--with Matreshka.ODF_Attributes.Text.Footnotes_Position;
--with Matreshka.ODF_Attributes.Text.Increment;
--with Matreshka.ODF_Attributes.Text.Label_Followed_By;
--with Matreshka.ODF_Attributes.Text.Level;
--with Matreshka.ODF_Attributes.Text.Line_Number;
--with Matreshka.ODF_Attributes.Text.List_Level_Position_And_Space_Mode;
--with Matreshka.ODF_Attributes.Text.List_Tab_Stop_Position;
--with Matreshka.ODF_Attributes.Text.Min_Label_Distance;
--with Matreshka.ODF_Attributes.Text.Name;
--with Matreshka.ODF_Attributes.Text.Note_Class;
--with Matreshka.ODF_Attributes.Text.Number_Lines;
--with Matreshka.ODF_Attributes.Text.Number_Position;
--with Matreshka.ODF_Attributes.Text.Offset;
--with Matreshka.ODF_Attributes.Text.Outline_Level;
--with Matreshka.ODF_Attributes.Text.Start_Numbering_At;
--with Matreshka.ODF_Attributes.Text.Start_Value;
--with Matreshka.ODF_Attributes.Text.Style_Name;
--with ODF.DOM.Elements.Office.Automatic_Styles;
--with ODF.DOM.Elements.Office.Bodies;
--with ODF.DOM.Elements.Office.Document_Content;
--with ODF.DOM.Elements.Office.Document_Styles;
--with ODF.DOM.Elements.Office.Font_Face_Decls;
--with ODF.DOM.Elements.Office.Master_Styles;
--with ODF.DOM.Elements.Office.Scripts;
--with ODF.DOM.Elements.Office.Styles;
--with ODF.DOM.Elements.Office.Text;
--with ODF.DOM.Elements.Style.Background_Image;
--with ODF.DOM.Elements.Style.Default_Style;
--with ODF.DOM.Elements.Style.Font_Face;
--with ODF.DOM.Elements.Style.Footer_Style;
--with ODF.DOM.Elements.Style.Footnote_Sep;
--with ODF.DOM.Elements.Style.Graphic_Properties;
--with ODF.DOM.Elements.Style.Header_Style;
--with ODF.DOM.Elements.Style.List_Level_Label_Alignment;
--with ODF.DOM.Elements.Style.List_Level_Properties;
--with ODF.DOM.Elements.Style.Master_Page;
--with ODF.DOM.Elements.Style.Page_Layout;
--with ODF.DOM.Elements.Style.Page_Layout_Properties;
--with ODF.DOM.Elements.Style.Paragraph_Properties;
--with ODF.DOM.Elements.Style.Style;
--with ODF.DOM.Elements.Style.Tab_Stops;
--with ODF.DOM.Elements.Style.Table_Cell_Properties;
--with ODF.DOM.Elements.Style.Table_Column_Properties;
--with ODF.DOM.Elements.Style.Table_Properties;
--with ODF.DOM.Elements.Style.Table_Row_Properties;
--with ODF.DOM.Elements.Style.Text_Properties;
--with ODF.DOM.Elements.Table.Covered_Table_Cell;
--with ODF.DOM.Elements.Table.Table;
--with ODF.DOM.Elements.Table.Table_Cell;
--with ODF.DOM.Elements.Table.Table_Column;
--with ODF.DOM.Elements.Table.Table_Row;
--with ODF.DOM.Elements.Text.H;
--with ODF.DOM.Elements.Text.Linenumbering_Configuration;
--with ODF.DOM.Elements.Text.Notes_Configuration;
--with ODF.DOM.Elements.Text.Outline_Level_Style;
--with ODF.DOM.Elements.Text.Outline_Style;
--with ODF.DOM.Elements.Text.P;
--with ODF.DOM.Elements.Text.Sequence_Decl;
--with ODF.DOM.Elements.Text.Sequence_Decls;
--with ODF.DOM.Elements.Text.Span;

package Matreshka.ODF_Documents is

   type Document_Node is
     new Matreshka.XML.DOM_Nodes.Documents.Abstract_Document with null record;

--   type ODF_Document_Access is access all ODF_Document'Class;

   function Create_Draw_End_Line_Spacing_Horizontal
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Draw.End_Line_Spacing_Horizontal.Draw_End_Line_Spacing_Horizontal_Access;

   function Create_Draw_End_Line_Spacing_Vertical
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Draw.End_Line_Spacing_Vertical.Draw_End_Line_Spacing_Vertical_Access;

   function Create_Draw_Fill_Color
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Draw.Fill_Color.Draw_Fill_Color_Access;

   function Create_Draw_Shadow_Offset_X
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Draw.Shadow_Offset_X.Draw_Shadow_Offset_X_Access;

   function Create_Draw_Shadow_Offset_Y
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Draw.Shadow_Offset_Y.Draw_Shadow_Offset_Y_Access;

   function Create_Draw_Start_Line_Spacing_Horizontal
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Draw.Start_Line_Spacing_Horizontal.Draw_Start_Line_Spacing_Horizontal_Access;

   function Create_Draw_Start_Line_Spacing_Vertical
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Draw.Start_Line_Spacing_Vertical.Draw_Start_Line_Spacing_Vertical_Access;

   function Create_FO_Background_Color
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Background_Color.FO_Background_Color_Access;

   function Create_FO_Border
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Border.FO_Border_Access;

   function Create_FO_Border_Bottom
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Border_Bottom.FO_Border_Bottom_Access;

   function Create_FO_Border_Left
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Border_Left.FO_Border_Left_Access;

   function Create_FO_Border_Right
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Border_Right.FO_Border_Right_Access;

   function Create_FO_Border_Top
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Border_Top.FO_Border_Top_Access;

   function Create_FO_Country
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Country.FO_Country_Access;

   function Create_FO_Font_Size
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Font_Size.FO_Font_Size_Access;

   function Create_FO_Font_Style
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Font_Style.FO_Font_Style_Access;

   function Create_FO_Font_Weight
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Font_Weight.FO_Font_Weight_Access;

   function Create_FO_Hyphenate
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Hyphenate.FO_Hyphenate_Access;

   function Create_FO_Hyphenation_Ladder_Count
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Hyphenation_Ladder_Count.FO_Hyphenation_Ladder_Count_Access;

   function Create_FO_Hyphenation_Push_Char_Count
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Hyphenation_Push_Char_Count.FO_Hyphenation_Push_Char_Count_Access;

   function Create_FO_Hyphenation_Remain_Char_Count
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Hyphenation_Remain_Char_Count.FO_Hyphenation_Remain_Char_Count_Access;

   function Create_FO_Keep_Together
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Keep_Together.FO_Keep_Together_Access;

   function Create_FO_Keep_With_Next
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Keep_With_Next.FO_Keep_With_Next_Access;

   function Create_FO_Language
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Language.FO_Language_Access;

   function Create_FO_Margin
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Margin.FO_Margin_Access;

   function Create_FO_Margin_Bottom
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Margin_Bottom.FO_Margin_Bottom_Access;

   function Create_FO_Margin_Left
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Margin_Left.FO_Margin_Left_Access;

   function Create_FO_Margin_Right
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Margin_Right.FO_Margin_Right_Access;

   function Create_FO_Margin_Top
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Margin_Top.FO_Margin_Top_Access;

   function Create_FO_Padding
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Padding.FO_Padding_Access;

   function Create_FO_Page_Height
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Page_Height.FO_Page_Height_Access;

   function Create_FO_Page_Width
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Page_Width.FO_Page_Width_Access;

   function Create_FO_Text_Align
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Text_Align.FO_Text_Align_Access;

   function Create_FO_Text_Indent
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Text_Indent.FO_Text_Indent_Access;

   function Create_FO_Wrap_Option
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Wrap_Option.FO_Wrap_Option_Access;

--   function Create_Office_Automatic_Styles
--    (Self : not null access Document_Node'Class)
--       return
--         ODF.DOM.Elements.Office.Automatic_Styles.Office_Automatic_Styles_Access;
--
--   function Create_Office_Body
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Office.Bodies.Office_Body_Access;
--
--   function Create_Office_Document_Content
--    (Self : not null access Document_Node'Class)
--       return
--         ODF.DOM.Elements.Office.Document_Content.Office_Document_Content_Access;
--
--   function Create_Office_Document_Styles
--    (Self : not null access Document_Node'Class)
--       return
--         ODF.DOM.Elements.Office.Document_Styles.Office_Document_Styles_Access;
--
--   function Create_Office_Font_Face_Decls
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Office.Font_Face_Decls.Office_Font_Face_Decls_Access;
--
--   function Create_Office_Master_Styles
--    (Self : not null access Document_Node'Class)
--       return
--         ODF.DOM.Elements.Office.Master_Styles.Office_Master_Styles_Access;
--
--   function Create_Office_Scripts
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Office.Scripts.Office_Scripts_Access;
--
--   function Create_Office_Styles
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Office.Styles.Office_Styles_Access;
--
--   function Create_Office_Text
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Office.Text.Office_Text_Access;

   function Create_Office_Value_Type
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Office.Value_Type.Office_Value_Type_Access;

   function Create_Office_Version
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Office.Version.Office_Version_Access;

--   function Create_Style_Background_Image
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Background_Image.ODF_Style_Background_Image_Access;

--   function Create_Style_Adjustment
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Adjustment.ODF_Style_Adjustment_Access;
--
--   function Create_Style_Class
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Class.ODF_Style_Class_Access;
--
--   function Create_Style_Color
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Color.ODF_Style_Color_Access;
--
--   function Create_Style_Column_Width
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Column_Width.ODF_Style_Column_Width_Access;
--
--   function Create_Style_Contextual_Spacing
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Contextual_Spacing.ODF_Style_Contextual_Spacing_Access;
--
--   function Create_Style_Country_Asian
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Country_Asian.ODF_Style_Country_Asian_Access;
--
--   function Create_Style_Country_Complex
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Country_Complex.ODF_Style_Country_Complex_Access;
--
--   function Create_Style_Default_Outline_Level
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Default_Outline_Level.ODF_Style_Default_Outline_Level_Access;
--
--   function Create_Style_Default_Style
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style_Access;
--
--   function Create_Style_Display_Name
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Display_Name.ODF_Style_Display_Name_Access;
--
--   function Create_Style_Distance_After_Sep
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Distance_After_Sep.ODF_Style_Distance_After_Sep_Access;
--
--   function Create_Style_Distance_Before_Sep
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Distance_Before_Sep.ODF_Style_Distance_Before_Sep_Access;
--
--   function Create_Style_Family
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Family.ODF_Style_Family_Access;
--
--   function Create_Style_Flow_With_Text
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Flow_With_Text.ODF_Style_Flow_With_Text_Access;
--
--   function Create_Style_Font_Face
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Font_Face.ODF_Style_Font_Face_Access;
--
--   function Create_Style_Font_Family_Generic
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Font_Family_Generic.ODF_Style_Font_Family_Generic_Access;
--
--   function Create_Style_Font_Independent_Line_Spacing
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Font_Independent_Line_Spacing.ODF_Style_Font_Independent_Line_Spacing_Access;
--
--   function Create_Style_Font_Name
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Font_Name.ODF_Style_Font_Name_Access;
--
--   function Create_Style_Font_Name_Asian
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Font_Name_Asian.ODF_Style_Font_Name_Asian_Access;
--
--   function Create_Style_Font_Name_Complex
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Font_Name_Complex.ODF_Style_Font_Name_Complex_Access;
--
--   function Create_Style_Font_Pitch
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Font_Pitch.ODF_Style_Font_Pitch_Access;
--
--   function Create_Style_Font_Size_Asian
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Font_Size_Asian.ODF_Style_Font_Size_Asian_Access;
--
--   function Create_Style_Font_Size_Complex
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Font_Size_Complex.ODF_Style_Font_Size_Complex_Access;
--
--   function Create_Style_Font_Style_Asian
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Font_Style_Asian.ODF_Style_Font_Style_Asian_Access;
--
--   function Create_Style_Font_Style_Complex
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Font_Style_Complex.ODF_Style_Font_Style_Complex_Access;
--
--   function Create_Style_Font_Weight_Asian
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Font_Weight_Asian.ODF_Style_Font_Weight_Asian_Access;
--
--   function Create_Style_Font_Weight_Complex
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Font_Weight_Complex.ODF_Style_Font_Weight_Complex_Access;
--
--   function Create_Style_Footer_Style
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Footer_Style.ODF_Style_Footer_Style_Access;
--
--   function Create_Style_Footnote_Max_Height
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Footnote_Max_Height.ODF_Style_Footnote_Max_Height_Access;
--
--   function Create_Style_Footnote_Sep
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Footnote_Sep.ODF_Style_Footnote_Sep_Access;
--
--   function Create_Style_Graphic_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Graphic_Properties.ODF_Style_Graphic_Properties_Access;
--
--   function Create_Style_Header_Style
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Header_Style.ODF_Style_Header_Style_Access;
--
--   function Create_Style_Justify_Single_Word
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Justify_Single_Word.ODF_Style_Justify_Single_Word_Access;
--
--   function Create_Style_Language_Asian
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Language_Asian.ODF_Style_Language_Asian_Access;
--
--   function Create_Style_Language_Complex
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Language_Complex.ODF_Style_Language_Complex_Access;
--
--   function Create_Style_Letter_Kerning
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Letter_Kerning.ODF_Style_Letter_Kerning_Access;
--
--   function Create_Style_Line_Break
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Line_Break.ODF_Style_Line_Break_Access;
--
--   function Create_Style_Line_Style
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Line_Style.ODF_Style_Line_Style_Access;
--
--   function Create_Style_List_Level_Label_Alignment
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.List_Level_Label_Alignment.ODF_Style_List_Level_Label_Alignment_Access;
--
--   function Create_Style_List_Level_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.List_Level_Properties.ODF_Style_List_Level_Properties_Access;
--
--   function Create_Style_Master_Page
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Master_Page.ODF_Style_Master_Page_Access;
--
--   function Create_Style_Name
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Name.ODF_Style_Name_Access;
--
--   function Create_Style_Next_Style_Name
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Next_Style_Name.ODF_Style_Next_Style_Name_Access;
--
--   function Create_Style_Num_Format
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Num_Format.ODF_Style_Num_Format_Access;
--
--   function Create_Style_Page_Layout
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Page_Layout.ODF_Style_Page_Layout_Access;
--
--   function Create_Style_Page_Layout_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Page_Layout_Properties.ODF_Style_Page_Layout_Properties_Access;
--
--   function Create_Style_Paragraph_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Paragraph_Properties.ODF_Style_Paragraph_Properties_Access;
--
--   function Create_Style_Page_Layout_Name
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Page_Layout_Name.ODF_Style_Page_Layout_Name_Access;
--
--   function Create_Style_Parent_Style_Name
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Parent_Style_Name.ODF_Style_Parent_Style_Name_Access;
--
--   function Create_Style_Print_Orientation
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Print_Orientation.ODF_Style_Print_Orientation_Access;
--
--   function Create_Style_Punctuation_Wrap
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Punctuation_Wrap.ODF_Style_Punctuation_Wrap_Access;
--
--   function Create_Style_Rel_Column_Width
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Rel_Column_Width.ODF_Style_Rel_Column_Width_Access;
--
--   function Create_Style_Rel_Width
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Rel_Width.ODF_Style_Rel_Width_Access;
--
--   function Create_Style_Style
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Style.ODF_Style_Style_Access;
--
--   function Create_Style_Tab_Stop_Distance
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Tab_Stop_Distance.ODF_Style_Tab_Stop_Distance_Access;
--
--   function Create_Style_Tab_Stops
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Tab_Stops.ODF_Style_Tab_Stops_Access;
--
--   function Create_Style_Table_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Table_Properties.ODF_Style_Table_Properties_Access;
--
--   function Create_Style_Table_Cell_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Table_Cell_Properties.ODF_Style_Table_Cell_Properties_Access;
--
--   function Create_Style_Table_Column_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Table_Column_Properties.ODF_Style_Table_Column_Properties_Access;
--
--   function Create_Style_Table_Row_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Table_Row_Properties.ODF_Style_Table_Row_Properties_Access;
--
--   function Create_Style_Text_Autospace
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Text_Autospace.ODF_Style_Text_Autospace_Access;
--
--   function Create_Style_Text_Underline_Color
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Text_Underline_Color.ODF_Style_Text_Underline_Color_Access;
--
--   function Create_Style_Text_Underline_Style
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Text_Underline_Style.ODF_Style_Text_Underline_Style_Access;
--
--   function Create_Style_Text_Underline_Width
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Text_Underline_Width.ODF_Style_Text_Underline_Width_Access;
--
--   function Create_Style_Text_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Text_Properties.ODF_Style_Text_Properties_Access;
--
--   function Create_Style_Use_Window_Font_Color
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Use_Window_Font_Color.ODF_Style_Use_Window_Font_Color_Access;
--
--   function Create_Style_Vertical_Align
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Vertical_Align.ODF_Style_Vertical_Align_Access;
--
--   function Create_Style_Width
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Width.ODF_Style_Width_Access;
--
--   function Create_Style_Writing_Mode
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Writing_Mode.ODF_Style_Writing_Mode_Access;
--
--   function Create_SVG_Font_Family
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.SVG.Font_Family.ODF_SVG_Font_Family_Access;
--
--   function Create_SVG_Stroke_Color
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.SVG.Stroke_Color.ODF_SVG_Stroke_Color_Access;
--
--   function Create_Table_Align
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Table.Align.ODF_Table_Align_Access;
--
--   function Create_Table_Border_Model
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Table.Border_Model.ODF_Table_Border_Model_Access;
--
--   function Create_Table_Covered_Table_Cell
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Table.Covered_Table_Cell.ODF_Table_Covered_Table_Cell_Access;
--
--   function Create_Table_Name
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Table.Name.ODF_Table_Name_Access;
--
--   function Create_Table_Number_Columns_Spanned
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Table.Number_Columns_Spanned.ODF_Table_Number_Columns_Spanned_Access;
--
--   function Create_Table_Style_Name
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Table.Style_Name.ODF_Table_Style_Name_Access;
--
--   function Create_Table_Table
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Table.Table.ODF_Table_Table_Access;
--
--   function Create_Table_Table_Cell
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell_Access;
--
--   function Create_Table_Table_Column
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Table.Table_Column.ODF_Table_Table_Column_Access;
--
--   function Create_Table_Table_Row
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row_Access;
--
--   function Create_Text_Display_Outline_Level
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Display_Outline_Level.ODF_Text_Display_Outline_Level_Access;
--
--   function Create_Text_Footnotes_Position
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Footnotes_Position.ODF_Text_Footnotes_Position_Access;
--
--   function Create_Text_H
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.H.ODF_Text_H_Access;
--
--   function Create_Text_Increment
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Increment.ODF_Text_Increment_Access;
--
--   function Create_Text_Label_Followed_By
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Label_Followed_By.ODF_Text_Label_Followed_By_Access;
--
--   function Create_Text_Level
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Level.ODF_Text_Level_Access;
--
--   function Create_Text_Line_Number
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Line_Number.ODF_Text_Line_Number_Access;
--
--   function Create_Text_Linenumbering_Configuration
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.Linenumbering_Configuration.ODF_Text_Linenumbering_Configuration_Access;
--
--   function Create_Text_List_Level_Position_And_Space_Mode
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.List_Level_Position_And_Space_Mode.ODF_Text_List_Level_Position_And_Space_Mode_Access;
--
--   function Create_Text_List_Tab_Stop_Position
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.List_Tab_Stop_Position.ODF_Text_List_Tab_Stop_Position_Access;
--
--   function Create_Text_Min_Label_Distance
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Min_Label_Distance.ODF_Text_Min_Label_Distance_Access;
--
--   function Create_Text_Name
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Name.ODF_Text_Name_Access;
--
--   function Create_Text_Notes_Configuration
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.Notes_Configuration.ODF_Text_Notes_Configuration_Access;
--
--   function Create_Text_Note_Class
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Note_Class.ODF_Text_Note_Class_Access;
--
--   function Create_Text_Number_Lines
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Number_Lines.ODF_Text_Number_Lines_Access;
--
--   function Create_Text_Number_Position
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Number_Position.ODF_Text_Number_Position_Access;
--
--   function Create_Text_Offset
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Offset.ODF_Text_Offset_Access;
--
--   function Create_Text_Outline_Level
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Outline_Level.ODF_Text_Outline_Level_Access;
--
--   function Create_Text_Outline_Level_Style
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.Outline_Level_Style.ODF_Text_Outline_Level_Style_Access;
--
--   function Create_Text_Outline_Style
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.Outline_Style.ODF_Text_Outline_Style_Access;
--
--   function Create_Text_P
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.P.ODF_Text_P_Access;
--
--   function Create_Text_Sequence_Decl
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.Sequence_Decl.ODF_Text_Sequence_Decl_Access;
--
--   function Create_Text_Sequence_Decls
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.Sequence_Decls.ODF_Text_Sequence_Decls_Access;
--
--   function Create_Text_Span
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.Span.ODF_Text_Span_Access;
--
--   function Create_Text_Start_Numbering_At
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Start_Numbering_At.ODF_Text_Start_Numbering_At_Access;
--
--   function Create_Text_Start_Value
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Start_Value.ODF_Text_Start_Value_Access;
--
--   function Create_Text_Style_Name
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Style_Name.ODF_Text_Style_Name_Access;
--
--private
--
--   type Document_Node is
--     new XML.DOM.Nodes.Documents.DOM_Document with null record;

--   overriding function Create_Element_NS
--    (Self           : not null access Document_Node;
--     Namespace_URI  : League.Strings.Universal_String;
--     Qualified_Name : League.Strings.Universal_String)
--       return XML.DOM.Nodes.Elements.DOM_Element_Access;

   overriding function Create_Attribute
    (Self           : not null access Document_Node;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return not null Matreshka.XML.DOM_Nodes.Attribute_Access;

end Matreshka.ODF_Documents;
