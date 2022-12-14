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
with XML.DOM.Documents;

with ODF.DOM.Attributes.Draw.End_Line_Spacing_Horizontal;
with ODF.DOM.Attributes.Draw.End_Line_Spacing_Vertical;
with ODF.DOM.Attributes.Draw.Fill_Color;
with ODF.DOM.Attributes.Draw.Shadow_Offset_X;
with ODF.DOM.Attributes.Draw.Shadow_Offset_Y;
with ODF.DOM.Attributes.Draw.Start_Line_Spacing_Horizontal;
with ODF.DOM.Attributes.Draw.Start_Line_Spacing_Vertical;
with ODF.DOM.Attributes.FO.Background_Color;
with ODF.DOM.Attributes.FO.Border;
with ODF.DOM.Attributes.FO.Border_Bottom;
with ODF.DOM.Attributes.FO.Border_Left;
with ODF.DOM.Attributes.FO.Border_Right;
with ODF.DOM.Attributes.FO.Border_Top;
with ODF.DOM.Attributes.FO.Country;
with ODF.DOM.Attributes.FO.Font_Size;
with ODF.DOM.Attributes.FO.Font_Style;
with ODF.DOM.Attributes.FO.Font_Weight;
with ODF.DOM.Attributes.FO.Hyphenate;
with ODF.DOM.Attributes.FO.Hyphenation_Ladder_Count;
with ODF.DOM.Attributes.FO.Hyphenation_Push_Char_Count;
with ODF.DOM.Attributes.FO.Hyphenation_Remain_Char_Count;
with ODF.DOM.Attributes.FO.Keep_Together;
with ODF.DOM.Attributes.FO.Keep_With_Next;
with ODF.DOM.Attributes.FO.Language;
with ODF.DOM.Attributes.FO.Margin;
with ODF.DOM.Attributes.FO.Margin_Bottom;
with ODF.DOM.Attributes.FO.Margin_Left;
with ODF.DOM.Attributes.FO.Margin_Right;
with ODF.DOM.Attributes.FO.Margin_Top;
with ODF.DOM.Attributes.FO.Padding;
with ODF.DOM.Attributes.FO.Page_Height;
with ODF.DOM.Attributes.FO.Page_Width;
with ODF.DOM.Attributes.FO.Text_Align;
with ODF.DOM.Attributes.FO.Text_Indent;
with ODF.DOM.Attributes.FO.Wrap_Option;
with ODF.DOM.Attributes.Office.Value_Type;
with ODF.DOM.Attributes.Office.Version;
with ODF.DOM.Attributes.Style.Adjustment;
with ODF.DOM.Attributes.Style.Class;
with ODF.DOM.Attributes.Style.Color;
with ODF.DOM.Attributes.Style.Column_Width;
with ODF.DOM.Attributes.Style.Contextual_Spacing;
with ODF.DOM.Attributes.Style.Country_Asian;
with ODF.DOM.Attributes.Style.Country_Complex;
with ODF.DOM.Attributes.Style.Default_Outline_Level;
with ODF.DOM.Attributes.Style.Display_Name;
with ODF.DOM.Attributes.Style.Distance_After_Sep;
with ODF.DOM.Attributes.Style.Distance_Before_Sep;
with ODF.DOM.Attributes.Style.Family;
with ODF.DOM.Attributes.Style.Flow_With_Text;
with ODF.DOM.Attributes.Style.Font_Family_Generic;
with ODF.DOM.Attributes.Style.Font_Independent_Line_Spacing;
with ODF.DOM.Attributes.Style.Font_Name;
with ODF.DOM.Attributes.Style.Font_Name_Asian;
with ODF.DOM.Attributes.Style.Font_Name_Complex;
with ODF.DOM.Attributes.Style.Font_Pitch;
with ODF.DOM.Attributes.Style.Font_Size_Asian;
with ODF.DOM.Attributes.Style.Font_Size_Complex;
with ODF.DOM.Attributes.Style.Font_Style_Asian;
with ODF.DOM.Attributes.Style.Font_Style_Complex;
with ODF.DOM.Attributes.Style.Font_Weight_Asian;
with ODF.DOM.Attributes.Style.Font_Weight_Complex;
with ODF.DOM.Attributes.Style.Footnote_Max_Height;
with ODF.DOM.Attributes.Style.Justify_Single_Word;
with ODF.DOM.Attributes.Style.Language_Asian;
with ODF.DOM.Attributes.Style.Language_Complex;
with ODF.DOM.Attributes.Style.Letter_Kerning;
with ODF.DOM.Attributes.Style.Line_Break;
with ODF.DOM.Attributes.Style.Line_Style;
with ODF.DOM.Attributes.Style.Name;
with ODF.DOM.Attributes.Style.Next_Style_Name;
with ODF.DOM.Attributes.Style.Num_Format;
with ODF.DOM.Attributes.Style.Page_Layout_Name;
with ODF.DOM.Attributes.Style.Parent_Style_Name;
with ODF.DOM.Attributes.Style.Print_Orientation;
with ODF.DOM.Attributes.Style.Punctuation_Wrap;
with ODF.DOM.Attributes.Style.Rel_Column_Width;
with ODF.DOM.Attributes.Style.Rel_Width;
with ODF.DOM.Attributes.Style.Tab_Stop_Distance;
with ODF.DOM.Attributes.Style.Text_Autospace;
with ODF.DOM.Attributes.Style.Text_Underline_Color;
with ODF.DOM.Attributes.Style.Text_Underline_Style;
with ODF.DOM.Attributes.Style.Text_Underline_Width;
with ODF.DOM.Attributes.Style.Use_Window_Font_Color;
with ODF.DOM.Attributes.Style.Vertical_Align;
with ODF.DOM.Attributes.Style.Width;
with ODF.DOM.Attributes.Style.Writing_Mode;
with ODF.DOM.Attributes.SVG.Font_Family;
with ODF.DOM.Attributes.SVG.Stroke_Color;
with ODF.DOM.Attributes.Table.Align;
with ODF.DOM.Attributes.Table.Border_Model;
with ODF.DOM.Attributes.Table.Name;
with ODF.DOM.Attributes.Table.Number_Columns_Spanned;
with ODF.DOM.Attributes.Table.Style_Name;
with ODF.DOM.Attributes.Text.Display_Outline_Level;
with ODF.DOM.Attributes.Text.Footnotes_Position;
with ODF.DOM.Attributes.Text.Increment;
with ODF.DOM.Attributes.Text.Label_Followed_By;
with ODF.DOM.Attributes.Text.Level;
with ODF.DOM.Attributes.Text.Line_Number;
with ODF.DOM.Attributes.Text.List_Level_Position_And_Space_Mode;
with ODF.DOM.Attributes.Text.List_Tab_Stop_Position;
with ODF.DOM.Attributes.Text.Min_Label_Distance;
with ODF.DOM.Attributes.Text.Name;
with ODF.DOM.Attributes.Text.Note_Class;
with ODF.DOM.Attributes.Text.Number_Lines;
with ODF.DOM.Attributes.Text.Number_Position;
with ODF.DOM.Attributes.Text.Offset;
with ODF.DOM.Attributes.Text.Outline_Level;
with ODF.DOM.Attributes.Text.Start_Numbering_At;
with ODF.DOM.Attributes.Text.Start_Value;
with ODF.DOM.Attributes.Text.Style_Name;
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
with ODF.DOM.Elements.Style.List_Level_Label_Alignment;
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
with ODF.DOM.Elements.Text.H;
with ODF.DOM.Elements.Text.Linenumbering_Configuration;
with ODF.DOM.Elements.Text.Notes_Configuration;
with ODF.DOM.Elements.Text.Outline_Level_Style;
with ODF.DOM.Elements.Text.Outline_Style;
with ODF.DOM.Elements.Text.P;
with ODF.DOM.Elements.Text.Sequence_Decl;
with ODF.DOM.Elements.Text.Sequence_Decls;
with ODF.DOM.Elements.Text.Span;

package ODF.DOM.Documents is

   type ODF_Document is new XML.DOM.Documents.DOM_Document with private;

   function Create_Draw_End_Line_Spacing_Horizontal
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Draw.End_Line_Spacing_Horizontal.ODF_Draw_End_Line_Spacing_Horizontal;

   function Create_Draw_End_Line_Spacing_Vertical
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Draw.End_Line_Spacing_Vertical.ODF_Draw_End_Line_Spacing_Vertical;

   function Create_Draw_Fill_Color
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Draw.Fill_Color.ODF_Draw_Fill_Color;

   function Create_Draw_Shadow_Offset_X
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Draw.Shadow_Offset_X.ODF_Draw_Shadow_Offset_X;

   function Create_Draw_Shadow_Offset_Y
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Draw.Shadow_Offset_Y.ODF_Draw_Shadow_Offset_Y;

   function Create_Draw_Start_Line_Spacing_Horizontal
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Draw.Start_Line_Spacing_Horizontal.ODF_Draw_Start_Line_Spacing_Horizontal;

   function Create_Draw_Start_Line_Spacing_Vertical
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Draw.Start_Line_Spacing_Vertical.ODF_Draw_Start_Line_Spacing_Vertical;

   function Create_FO_Background_Color
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Background_Color.ODF_FO_Background_Color;

   function Create_FO_Border
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border.ODF_FO_Border;

   function Create_FO_Border_Bottom
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Bottom.ODF_FO_Border_Bottom;

   function Create_FO_Border_Left
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Left.ODF_FO_Border_Left;

   function Create_FO_Border_Right
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Right.ODF_FO_Border_Right;

   function Create_FO_Border_Top
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Top.ODF_FO_Border_Top;

   function Create_FO_Country
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Country.ODF_FO_Country;

   function Create_FO_Font_Size
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Font_Size.ODF_FO_Font_Size;

   function Create_FO_Font_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Font_Style.ODF_FO_Font_Style;

   function Create_FO_Font_Weight
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Font_Weight.ODF_FO_Font_Weight;

   function Create_FO_Hyphenate
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Hyphenate.ODF_FO_Hyphenate;

   function Create_FO_Hyphenation_Ladder_Count
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Hyphenation_Ladder_Count.ODF_FO_Hyphenation_Ladder_Count;

   function Create_FO_Hyphenation_Push_Char_Count
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Hyphenation_Push_Char_Count.ODF_FO_Hyphenation_Push_Char_Count;

   function Create_FO_Hyphenation_Remain_Char_Count
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Hyphenation_Remain_Char_Count.ODF_FO_Hyphenation_Remain_Char_Count;

   function Create_FO_Keep_Together
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Keep_Together.ODF_FO_Keep_Together;

   function Create_FO_Keep_With_Next
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Keep_With_Next.ODF_FO_Keep_With_Next;

   function Create_FO_Language
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Language.ODF_FO_Language;

   function Create_FO_Margin
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Margin.ODF_FO_Margin;

   function Create_FO_Margin_Bottom
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Margin_Bottom.ODF_FO_Margin_Bottom;

   function Create_FO_Margin_Left
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Margin_Left.ODF_FO_Margin_Left;

   function Create_FO_Margin_Right
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Margin_Right.ODF_FO_Margin_Right;

   function Create_FO_Margin_Top
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Margin_Top.ODF_FO_Margin_Top;

   function Create_FO_Padding
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Padding.ODF_FO_Padding;

   function Create_FO_Page_Height
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Page_Height.ODF_FO_Page_Height;

   function Create_FO_Page_Width
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Page_Width.ODF_FO_Page_Width;

   function Create_FO_Text_Align
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Text_Align.ODF_FO_Text_Align;

   function Create_FO_Text_Indent
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Text_Indent.ODF_FO_Text_Indent;

   function Create_FO_Wrap_Option
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Wrap_Option.ODF_FO_Wrap_Option;

   function Create_Office_Automatic_Styles
    (Self : ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Automatic_Styles.ODF_Office_Automatic_Styles;

   function Create_Office_Body
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Office.Bodies.ODF_Office_Body;

   function Create_Office_Document_Content
    (Self : ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Document_Content.ODF_Office_Document_Content;

   function Create_Office_Document_Styles
    (Self : ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Document_Styles.ODF_Office_Document_Styles;

   function Create_Office_Font_Face_Decls
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Office.Font_Face_Decls.ODF_Office_Font_Face_Decls;

   function Create_Office_Master_Styles
    (Self : ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Master_Styles.ODF_Office_Master_Styles;

   function Create_Office_Scripts
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Office.Scripts.ODF_Office_Scripts;

   function Create_Office_Styles
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Office.Styles.ODF_Office_Styles;

   function Create_Office_Text
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Office.Text.ODF_Office_Text;

   function Create_Office_Value_Type
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Office.Value_Type.ODF_Office_Value_Type;

   function Create_Office_Version
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Office.Version.ODF_Office_Version;

   function Create_Style_Background_Image
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Background_Image.ODF_Style_Background_Image;

   function Create_Style_Adjustment
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Adjustment.ODF_Style_Adjustment;

   function Create_Style_Class
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Class.ODF_Style_Class;

   function Create_Style_Color
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Color.ODF_Style_Color;

   function Create_Style_Column_Width
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Column_Width.ODF_Style_Column_Width;

   function Create_Style_Contextual_Spacing
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Contextual_Spacing.ODF_Style_Contextual_Spacing;

   function Create_Style_Country_Asian
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Country_Asian.ODF_Style_Country_Asian;

   function Create_Style_Country_Complex
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Country_Complex.ODF_Style_Country_Complex;

   function Create_Style_Default_Outline_Level
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Default_Outline_Level.ODF_Style_Default_Outline_Level;

   function Create_Style_Default_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style;

   function Create_Style_Display_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Display_Name.ODF_Style_Display_Name;

   function Create_Style_Distance_After_Sep
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Distance_After_Sep.ODF_Style_Distance_After_Sep;

   function Create_Style_Distance_Before_Sep
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Distance_Before_Sep.ODF_Style_Distance_Before_Sep;

   function Create_Style_Family
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Family.ODF_Style_Family;

   function Create_Style_Flow_With_Text
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Flow_With_Text.ODF_Style_Flow_With_Text;

   function Create_Style_Font_Face
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Font_Face.ODF_Style_Font_Face;

   function Create_Style_Font_Family_Generic
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Family_Generic.ODF_Style_Font_Family_Generic;

   function Create_Style_Font_Independent_Line_Spacing
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Independent_Line_Spacing.ODF_Style_Font_Independent_Line_Spacing;

   function Create_Style_Font_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Name.ODF_Style_Font_Name;

   function Create_Style_Font_Name_Asian
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Name_Asian.ODF_Style_Font_Name_Asian;

   function Create_Style_Font_Name_Complex
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Name_Complex.ODF_Style_Font_Name_Complex;

   function Create_Style_Font_Pitch
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Pitch.ODF_Style_Font_Pitch;

   function Create_Style_Font_Size_Asian
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Size_Asian.ODF_Style_Font_Size_Asian;

   function Create_Style_Font_Size_Complex
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Size_Complex.ODF_Style_Font_Size_Complex;

   function Create_Style_Font_Style_Asian
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Style_Asian.ODF_Style_Font_Style_Asian;

   function Create_Style_Font_Style_Complex
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Style_Complex.ODF_Style_Font_Style_Complex;

   function Create_Style_Font_Weight_Asian
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Weight_Asian.ODF_Style_Font_Weight_Asian;

   function Create_Style_Font_Weight_Complex
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Weight_Complex.ODF_Style_Font_Weight_Complex;

   function Create_Style_Footer_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Footer_Style.ODF_Style_Footer_Style;

   function Create_Style_Footnote_Max_Height
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Footnote_Max_Height.ODF_Style_Footnote_Max_Height;

   function Create_Style_Footnote_Sep
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Footnote_Sep.ODF_Style_Footnote_Sep;

   function Create_Style_Graphic_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Graphic_Properties.ODF_Style_Graphic_Properties;

   function Create_Style_Header_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Header_Style.ODF_Style_Header_Style;

   function Create_Style_Justify_Single_Word
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Justify_Single_Word.ODF_Style_Justify_Single_Word;

   function Create_Style_Language_Asian
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Language_Asian.ODF_Style_Language_Asian;

   function Create_Style_Language_Complex
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Language_Complex.ODF_Style_Language_Complex;

   function Create_Style_Letter_Kerning
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Letter_Kerning.ODF_Style_Letter_Kerning;

   function Create_Style_Line_Break
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Line_Break.ODF_Style_Line_Break;

   function Create_Style_Line_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Line_Style.ODF_Style_Line_Style;

   function Create_Style_List_Level_Label_Alignment
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.List_Level_Label_Alignment.ODF_Style_List_Level_Label_Alignment;

   function Create_Style_List_Level_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.List_Level_Properties.ODF_Style_List_Level_Properties;

   function Create_Style_Master_Page
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Master_Page.ODF_Style_Master_Page;

   function Create_Style_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Name.ODF_Style_Name;

   function Create_Style_Next_Style_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Next_Style_Name.ODF_Style_Next_Style_Name;

   function Create_Style_Num_Format
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Num_Format.ODF_Style_Num_Format;

   function Create_Style_Page_Layout
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Page_Layout.ODF_Style_Page_Layout;

   function Create_Style_Page_Layout_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Page_Layout_Properties.ODF_Style_Page_Layout_Properties;

   function Create_Style_Paragraph_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Paragraph_Properties.ODF_Style_Paragraph_Properties;

   function Create_Style_Page_Layout_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Page_Layout_Name.ODF_Style_Page_Layout_Name;

   function Create_Style_Parent_Style_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Parent_Style_Name.ODF_Style_Parent_Style_Name;

   function Create_Style_Print_Orientation
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Print_Orientation.ODF_Style_Print_Orientation;

   function Create_Style_Punctuation_Wrap
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Punctuation_Wrap.ODF_Style_Punctuation_Wrap;

   function Create_Style_Rel_Column_Width
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Rel_Column_Width.ODF_Style_Rel_Column_Width;

   function Create_Style_Rel_Width
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Rel_Width.ODF_Style_Rel_Width;

   function Create_Style_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Style.ODF_Style_Style;

   function Create_Style_Tab_Stop_Distance
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Tab_Stop_Distance.ODF_Style_Tab_Stop_Distance;

   function Create_Style_Tab_Stops
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Tab_Stops.ODF_Style_Tab_Stops;

   function Create_Style_Table_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Properties.ODF_Style_Table_Properties;

   function Create_Style_Table_Cell_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Cell_Properties.ODF_Style_Table_Cell_Properties;

   function Create_Style_Table_Column_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Column_Properties.ODF_Style_Table_Column_Properties;

   function Create_Style_Table_Row_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Row_Properties.ODF_Style_Table_Row_Properties;

   function Create_Style_Text_Autospace
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Text_Autospace.ODF_Style_Text_Autospace;

   function Create_Style_Text_Underline_Color
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Text_Underline_Color.ODF_Style_Text_Underline_Color;

   function Create_Style_Text_Underline_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Text_Underline_Style.ODF_Style_Text_Underline_Style;

   function Create_Style_Text_Underline_Width
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Text_Underline_Width.ODF_Style_Text_Underline_Width;

   function Create_Style_Text_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Text_Properties.ODF_Style_Text_Properties;

   function Create_Style_Use_Window_Font_Color
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Use_Window_Font_Color.ODF_Style_Use_Window_Font_Color;

   function Create_Style_Vertical_Align
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Vertical_Align.ODF_Style_Vertical_Align;

   function Create_Style_Width
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Width.ODF_Style_Width;

   function Create_Style_Writing_Mode
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Writing_Mode.ODF_Style_Writing_Mode;

   function Create_SVG_Font_Family
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.SVG.Font_Family.ODF_SVG_Font_Family;

   function Create_SVG_Stroke_Color
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.SVG.Stroke_Color.ODF_SVG_Stroke_Color;

   function Create_Table_Align
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Table.Align.ODF_Table_Align;

   function Create_Table_Border_Model
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Table.Border_Model.ODF_Table_Border_Model;

   function Create_Table_Covered_Table_Cell
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Table.Covered_Table_Cell.ODF_Table_Covered_Table_Cell;

   function Create_Table_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Table.Name.ODF_Table_Name;

   function Create_Table_Number_Columns_Spanned
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Table.Number_Columns_Spanned.ODF_Table_Number_Columns_Spanned;

   function Create_Table_Style_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Table.Style_Name.ODF_Table_Style_Name;

   function Create_Table_Table
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table.ODF_Table_Table;

   function Create_Table_Table_Cell
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell;

   function Create_Table_Table_Column
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table_Column.ODF_Table_Table_Column;

   function Create_Table_Table_Row
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row;

   function Create_Text_Display_Outline_Level
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Display_Outline_Level.ODF_Text_Display_Outline_Level;

   function Create_Text_Footnotes_Position
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Footnotes_Position.ODF_Text_Footnotes_Position;

   function Create_Text_H
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.H.ODF_Text_H;

   function Create_Text_Increment
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Increment.ODF_Text_Increment;

   function Create_Text_Label_Followed_By
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Label_Followed_By.ODF_Text_Label_Followed_By;

   function Create_Text_Level
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Level.ODF_Text_Level;

   function Create_Text_Line_Number
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Line_Number.ODF_Text_Line_Number;

   function Create_Text_Linenumbering_Configuration
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.Linenumbering_Configuration.ODF_Text_Linenumbering_Configuration;

   function Create_Text_List_Level_Position_And_Space_Mode
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.List_Level_Position_And_Space_Mode.ODF_Text_List_Level_Position_And_Space_Mode;

   function Create_Text_List_Tab_Stop_Position
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.List_Tab_Stop_Position.ODF_Text_List_Tab_Stop_Position;

   function Create_Text_Min_Label_Distance
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Min_Label_Distance.ODF_Text_Min_Label_Distance;

   function Create_Text_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Name.ODF_Text_Name;

   function Create_Text_Notes_Configuration
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.Notes_Configuration.ODF_Text_Notes_Configuration;

   function Create_Text_Note_Class
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Note_Class.ODF_Text_Note_Class;

   function Create_Text_Number_Lines
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Number_Lines.ODF_Text_Number_Lines;

   function Create_Text_Number_Position
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Number_Position.ODF_Text_Number_Position;

   function Create_Text_Offset
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Offset.ODF_Text_Offset;

   function Create_Text_Outline_Level
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Outline_Level.ODF_Text_Outline_Level;

   function Create_Text_Outline_Level_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.Outline_Level_Style.ODF_Text_Outline_Level_Style;

   function Create_Text_Outline_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.Outline_Style.ODF_Text_Outline_Style;

   function Create_Text_P
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.P.ODF_Text_P;

   function Create_Text_Sequence_Decl
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.Sequence_Decl.ODF_Text_Sequence_Decl;

   function Create_Text_Sequence_Decls
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.Sequence_Decls.ODF_Text_Sequence_Decls;

   function Create_Text_Span
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.Span.ODF_Text_Span;

   function Create_Text_Start_Numbering_At
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Start_Numbering_At.ODF_Text_Start_Numbering_At;

   function Create_Text_Start_Value
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Start_Value.ODF_Text_Start_Value;

   function Create_Text_Style_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Style_Name.ODF_Text_Style_Name;

private

   type ODF_Document is new XML.DOM.Documents.DOM_Document with null record;

end ODF.DOM.Documents;
