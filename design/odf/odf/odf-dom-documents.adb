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
with ODF.DOM.Attributes.Draw.End_Line_Spacing_Horizontal.Internals;
with ODF.DOM.Attributes.Draw.End_Line_Spacing_Vertical.Internals;
with ODF.DOM.Attributes.Draw.Fill_Color.Internals;
with ODF.DOM.Attributes.Draw.Shadow_Offset_X.Internals;
with ODF.DOM.Attributes.Draw.Shadow_Offset_Y.Internals;
with ODF.DOM.Attributes.Draw.Start_Line_Spacing_Horizontal.Internals;
with ODF.DOM.Attributes.Draw.Start_Line_Spacing_Vertical.Internals;
with ODF.DOM.Attributes.FO.Background_Color.Internals;
with ODF.DOM.Attributes.FO.Border.Internals;
with ODF.DOM.Attributes.FO.Border_Bottom.Internals;
with ODF.DOM.Attributes.FO.Border_Left.Internals;
with ODF.DOM.Attributes.FO.Border_Right.Internals;
with ODF.DOM.Attributes.FO.Border_Top.Internals;
with ODF.DOM.Attributes.FO.Country.Internals;
with ODF.DOM.Attributes.FO.Font_Size.Internals;
with ODF.DOM.Attributes.FO.Font_Style.Internals;
with ODF.DOM.Attributes.FO.Font_Weight.Internals;
with ODF.DOM.Attributes.FO.Hyphenate.Internals;
with ODF.DOM.Attributes.FO.Hyphenation_Ladder_Count.Internals;
with ODF.DOM.Attributes.FO.Hyphenation_Push_Char_Count.Internals;
with ODF.DOM.Attributes.FO.Hyphenation_Remain_Char_Count.Internals;
with ODF.DOM.Attributes.FO.Keep_Together.Internals;
with ODF.DOM.Attributes.FO.Keep_With_Next.Internals;
with ODF.DOM.Attributes.FO.Language.Internals;
with ODF.DOM.Attributes.FO.Margin.Internals;
with ODF.DOM.Attributes.FO.Margin_Bottom.Internals;
with ODF.DOM.Attributes.FO.Margin_Left.Internals;
with ODF.DOM.Attributes.FO.Margin_Right.Internals;
with ODF.DOM.Attributes.FO.Margin_Top.Internals;
with ODF.DOM.Attributes.FO.Padding.Internals;
with ODF.DOM.Attributes.FO.Page_Height.Internals;
with ODF.DOM.Attributes.FO.Page_Width.Internals;
with ODF.DOM.Attributes.FO.Text_Align.Internals;
with ODF.DOM.Attributes.FO.Text_Indent.Internals;
with ODF.DOM.Attributes.FO.Wrap_Option.Internals;
with ODF.DOM.Attributes.Office.Value_Type.Internals;
with ODF.DOM.Attributes.Office.Version.Internals;
with ODF.DOM.Attributes.Style.Adjustment.Internals;
with ODF.DOM.Attributes.Style.Class.Internals;
with ODF.DOM.Attributes.Style.Color.Internals;
with ODF.DOM.Attributes.Style.Column_Width.Internals;
with ODF.DOM.Attributes.Style.Contextual_Spacing.Internals;
with ODF.DOM.Attributes.Style.Country_Asian.Internals;
with ODF.DOM.Attributes.Style.Country_Complex.Internals;
with ODF.DOM.Attributes.Style.Default_Outline_Level.Internals;
with ODF.DOM.Attributes.Style.Display_Name.Internals;
with ODF.DOM.Attributes.Style.Distance_After_Sep.Internals;
with ODF.DOM.Attributes.Style.Distance_Before_Sep.Internals;
with ODF.DOM.Attributes.Style.Family.Internals;
with ODF.DOM.Attributes.Style.Flow_With_Text.Internals;
with ODF.DOM.Attributes.Style.Font_Family_Generic.Internals;
with ODF.DOM.Attributes.Style.Font_Independent_Line_Spacing.Internals;
with ODF.DOM.Attributes.Style.Font_Name.Internals;
with ODF.DOM.Attributes.Style.Font_Name_Asian.Internals;
with ODF.DOM.Attributes.Style.Font_Name_Complex.Internals;
with ODF.DOM.Attributes.Style.Font_Pitch.Internals;
with ODF.DOM.Attributes.Style.Font_Size_Asian.Internals;
with ODF.DOM.Attributes.Style.Font_Size_Complex.Internals;
with ODF.DOM.Attributes.Style.Font_Style_Asian.Internals;
with ODF.DOM.Attributes.Style.Font_Style_Complex.Internals;
with ODF.DOM.Attributes.Style.Font_Weight_Asian.Internals;
with ODF.DOM.Attributes.Style.Font_Weight_Complex.Internals;
with ODF.DOM.Attributes.Style.Footnote_Max_Height.Internals;
with ODF.DOM.Attributes.Style.Justify_Single_Word.Internals;
with ODF.DOM.Attributes.Style.Language_Asian.Internals;
with ODF.DOM.Attributes.Style.Language_Complex.Internals;
with ODF.DOM.Attributes.Style.Letter_Kerning.Internals;
with ODF.DOM.Attributes.Style.Line_Break.Internals;
with ODF.DOM.Attributes.Style.Line_Style.Internals;
with ODF.DOM.Attributes.Style.Name.Internals;
with ODF.DOM.Attributes.Style.Next_Style_Name.Internals;
with ODF.DOM.Attributes.Style.Num_Format.Internals;
with ODF.DOM.Attributes.Style.Page_Layout_Name.Internals;
with ODF.DOM.Attributes.Style.Parent_Style_Name.Internals;
with ODF.DOM.Attributes.Style.Print_Orientation.Internals;
with ODF.DOM.Attributes.Style.Punctuation_Wrap.Internals;
with ODF.DOM.Attributes.Style.Rel_Column_Width.Internals;
with ODF.DOM.Attributes.Style.Rel_Width.Internals;
with ODF.DOM.Attributes.Style.Tab_Stop_Distance.Internals;
with ODF.DOM.Attributes.Style.Text_Autospace.Internals;
with ODF.DOM.Attributes.Style.Text_Underline_Color.Internals;
with ODF.DOM.Attributes.Style.Text_Underline_Style.Internals;
with ODF.DOM.Attributes.Style.Text_Underline_Width.Internals;
with ODF.DOM.Attributes.Style.Use_Window_Font_Color.Internals;
with ODF.DOM.Attributes.Style.Vertical_Align.Internals;
with ODF.DOM.Attributes.Style.Width.Internals;
with ODF.DOM.Attributes.Style.Writing_Mode.Internals;
with ODF.DOM.Attributes.SVG.Font_Family.Internals;
with ODF.DOM.Attributes.SVG.Stroke_Color.Internals;
with ODF.DOM.Attributes.Table.Align.Internals;
with ODF.DOM.Attributes.Table.Border_Model.Internals;
with ODF.DOM.Attributes.Table.Name.Internals;
with ODF.DOM.Attributes.Table.Number_Columns_Spanned.Internals;
with ODF.DOM.Attributes.Table.Style_Name.Internals;
with ODF.DOM.Attributes.Text.Display_Outline_Level.Internals;
with ODF.DOM.Attributes.Text.Footnotes_Position.Internals;
with ODF.DOM.Attributes.Text.Increment.Internals;
with ODF.DOM.Attributes.Text.Label_Followed_By.Internals;
with ODF.DOM.Attributes.Text.Level.Internals;
with ODF.DOM.Attributes.Text.Line_Number.Internals;
with ODF.DOM.Attributes.Text.List_Level_Position_And_Space_Mode.Internals;
with ODF.DOM.Attributes.Text.List_Tab_Stop_Position.Internals;
with ODF.DOM.Attributes.Text.Min_Label_Distance.Internals;
with ODF.DOM.Attributes.Text.Name.Internals;
with ODF.DOM.Attributes.Text.Note_Class.Internals;
with ODF.DOM.Attributes.Text.Number_Lines.Internals;
with ODF.DOM.Attributes.Text.Number_Position.Internals;
with ODF.DOM.Attributes.Text.Offset.Internals;
with ODF.DOM.Attributes.Text.Outline_Level.Internals;
with ODF.DOM.Attributes.Text.Start_Numbering_At.Internals;
with ODF.DOM.Attributes.Text.Start_Value.Internals;
with ODF.DOM.Attributes.Text.Style_Name.Internals;
with ODF.DOM.Documents.Internals;
with ODF.DOM.Elements.Office.Automatic_Styles.Internals;
with ODF.DOM.Elements.Office.Bodies.Internals;
with ODF.DOM.Elements.Office.Document_Content.Internals;
with ODF.DOM.Elements.Office.Document_Styles.Internals;
with ODF.DOM.Elements.Office.Font_Face_Decls.Internals;
with ODF.DOM.Elements.Office.Master_Styles.Internals;
with ODF.DOM.Elements.Office.Scripts.Internals;
with ODF.DOM.Elements.Office.Styles.Internals;
with ODF.DOM.Elements.Office.Text.Internals;
with ODF.DOM.Elements.Style.Background_Image.Internals;
with ODF.DOM.Elements.Style.Default_Style.Internals;
with ODF.DOM.Elements.Style.Font_Face.Internals;
with ODF.DOM.Elements.Style.Footer_Style.Internals;
with ODF.DOM.Elements.Style.Footnote_Sep.Internals;
with ODF.DOM.Elements.Style.Graphic_Properties.Internals;
with ODF.DOM.Elements.Style.Header_Style.Internals;
with ODF.DOM.Elements.Style.List_Level_Label_Alignment.Internals;
with ODF.DOM.Elements.Style.List_Level_Properties.Internals;
with ODF.DOM.Elements.Style.Master_Page.Internals;
with ODF.DOM.Elements.Style.Page_Layout.Internals;
with ODF.DOM.Elements.Style.Page_Layout_Properties.Internals;
with ODF.DOM.Elements.Style.Paragraph_Properties.Internals;
with ODF.DOM.Elements.Style.Style.Internals;
with ODF.DOM.Elements.Style.Tab_Stops.Internals;
with ODF.DOM.Elements.Style.Table_Cell_Properties.Internals;
with ODF.DOM.Elements.Style.Table_Column_Properties.Internals;
with ODF.DOM.Elements.Style.Table_Properties.Internals;
with ODF.DOM.Elements.Style.Table_Row_Properties.Internals;
with ODF.DOM.Elements.Style.Text_Properties.Internals;
with ODF.DOM.Elements.Table.Covered_Table_Cell.Internals;
with ODF.DOM.Elements.Table.Table.Internals;
with ODF.DOM.Elements.Table.Table_Cell.Internals;
with ODF.DOM.Elements.Table.Table_Column.Internals;
with ODF.DOM.Elements.Table.Table_Row.Internals;
with ODF.DOM.Elements.Text.H.Internals;
with ODF.DOM.Elements.Text.Linenumbering_Configuration.Internals;
with ODF.DOM.Elements.Text.Notes_Configuration.Internals;
with ODF.DOM.Elements.Text.Outline_Level_Style.Internals;
with ODF.DOM.Elements.Text.Outline_Style.Internals;
with ODF.DOM.Elements.Text.P.Internals;
with ODF.DOM.Elements.Text.Sequence_Decl.Internals;
with ODF.DOM.Elements.Text.Sequence_Decls.Internals;
with ODF.DOM.Elements.Text.Span.Internals;

package body ODF.DOM.Documents is

   ---------------------------------------------
   -- Create_Draw_End_Line_Spacing_Horizontal --
   ---------------------------------------------

   function Create_Draw_End_Line_Spacing_Horizontal
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Draw.End_Line_Spacing_Horizontal.ODF_Draw_End_Line_Spacing_Horizontal is
   begin
      return
        ODF.DOM.Attributes.Draw.End_Line_Spacing_Horizontal.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Draw_End_Line_Spacing_Horizontal);
   end Create_Draw_End_Line_Spacing_Horizontal;

   -------------------------------------------
   -- Create_Draw_End_Line_Spacing_Vertical --
   -------------------------------------------

   function Create_Draw_End_Line_Spacing_Vertical
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Draw.End_Line_Spacing_Vertical.ODF_Draw_End_Line_Spacing_Vertical is
   begin
      return
        ODF.DOM.Attributes.Draw.End_Line_Spacing_Vertical.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Draw_End_Line_Spacing_Vertical);
   end Create_Draw_End_Line_Spacing_Vertical;

   ----------------------------
   -- Create_Draw_Fill_Color --
   ----------------------------

   function Create_Draw_Fill_Color
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Draw.Fill_Color.ODF_Draw_Fill_Color is
   begin
      return
        ODF.DOM.Attributes.Draw.Fill_Color.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Draw_Fill_Color);
   end Create_Draw_Fill_Color;

   ---------------------------------
   -- Create_Draw_Shadow_Offset_X --
   ---------------------------------

   function Create_Draw_Shadow_Offset_X
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Draw.Shadow_Offset_X.ODF_Draw_Shadow_Offset_X is
   begin
      return
        ODF.DOM.Attributes.Draw.Shadow_Offset_X.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Draw_Shadow_Offset_X);
   end Create_Draw_Shadow_Offset_X;

   ---------------------------------
   -- Create_Draw_Shadow_Offset_Y --
   ---------------------------------

   function Create_Draw_Shadow_Offset_Y
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Draw.Shadow_Offset_Y.ODF_Draw_Shadow_Offset_Y is
   begin
      return
        ODF.DOM.Attributes.Draw.Shadow_Offset_Y.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Draw_Shadow_Offset_Y);
   end Create_Draw_Shadow_Offset_Y;

   -----------------------------------------------
   -- Create_Draw_Start_Line_Spacing_Horizontal --
   -----------------------------------------------

   function Create_Draw_Start_Line_Spacing_Horizontal
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Draw.Start_Line_Spacing_Horizontal.ODF_Draw_Start_Line_Spacing_Horizontal is
   begin
      return
        ODF.DOM.Attributes.Draw.Start_Line_Spacing_Horizontal.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Draw_Start_Line_Spacing_Horizontal);
   end Create_Draw_Start_Line_Spacing_Horizontal;

   ---------------------------------------------
   -- Create_Draw_Start_Line_Spacing_Vertical --
   ---------------------------------------------

   function Create_Draw_Start_Line_Spacing_Vertical
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Draw.Start_Line_Spacing_Vertical.ODF_Draw_Start_Line_Spacing_Vertical is
   begin
      return
        ODF.DOM.Attributes.Draw.Start_Line_Spacing_Vertical.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Draw_Start_Line_Spacing_Vertical);
   end Create_Draw_Start_Line_Spacing_Vertical;

   --------------------------------
   -- Create_FO_Background_Color --
   --------------------------------

   function Create_FO_Background_Color
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Background_Color.ODF_FO_Background_Color is
   begin
      return
        ODF.DOM.Attributes.FO.Background_Color.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Background_Color);
   end Create_FO_Background_Color;

   ----------------------
   -- Create_FO_Border --
   ----------------------

   function Create_FO_Border
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border.ODF_FO_Border is
   begin
      return
        ODF.DOM.Attributes.FO.Border.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Border);
   end Create_FO_Border;

   -----------------------------
   -- Create_FO_Border_Bottom --
   -----------------------------

   function Create_FO_Border_Bottom
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Bottom.ODF_FO_Border_Bottom is
   begin
      return
        ODF.DOM.Attributes.FO.Border_Bottom.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Border_Bottom);
   end Create_FO_Border_Bottom;

   ---------------------------
   -- Create_FO_Border_Left --
   ---------------------------

   function Create_FO_Border_Left
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Left.ODF_FO_Border_Left is
   begin
      return
        ODF.DOM.Attributes.FO.Border_Left.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Border_Left);
   end Create_FO_Border_Left;

   ----------------------------
   -- Create_FO_Border_Right --
   ----------------------------

   function Create_FO_Border_Right
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Right.ODF_FO_Border_Right is
   begin
      return
        ODF.DOM.Attributes.FO.Border_Right.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Border_Right);
   end Create_FO_Border_Right;

   --------------------------
   -- Create_FO_Border_Top --
   --------------------------

   function Create_FO_Border_Top
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Border_Top.ODF_FO_Border_Top is
   begin
      return
        ODF.DOM.Attributes.FO.Border_Top.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Border_Top);
   end Create_FO_Border_Top;

   -----------------------
   -- Create_FO_Country --
   -----------------------

   function Create_FO_Country
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Country.ODF_FO_Country is
   begin
      return
        ODF.DOM.Attributes.FO.Country.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Country);
   end Create_FO_Country;

   -------------------------
   -- Create_FO_Font_Size --
   -------------------------

   function Create_FO_Font_Size
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Font_Size.ODF_FO_Font_Size is
   begin
      return
        ODF.DOM.Attributes.FO.Font_Size.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Font_Size);
   end Create_FO_Font_Size;

   --------------------------
   -- Create_FO_Font_Style --
   --------------------------

   function Create_FO_Font_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Font_Style.ODF_FO_Font_Style is
   begin
      return
        ODF.DOM.Attributes.FO.Font_Style.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Font_Style);
   end Create_FO_Font_Style;

   ---------------------------
   -- Create_FO_Font_Weight --
   ---------------------------

   function Create_FO_Font_Weight
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Font_Weight.ODF_FO_Font_Weight is
   begin
      return
        ODF.DOM.Attributes.FO.Font_Weight.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Font_Weight);
   end Create_FO_Font_Weight;

   -------------------------
   -- Create_FO_Hyphenate --
   -------------------------

   function Create_FO_Hyphenate
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Hyphenate.ODF_FO_Hyphenate is
   begin
      return
        ODF.DOM.Attributes.FO.Hyphenate.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Hyphenate);
   end Create_FO_Hyphenate;

   ----------------------------------------
   -- Create_FO_Hyphenation_Ladder_Count --
   ----------------------------------------

   function Create_FO_Hyphenation_Ladder_Count
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Hyphenation_Ladder_Count.ODF_FO_Hyphenation_Ladder_Count is
   begin
      return
        ODF.DOM.Attributes.FO.Hyphenation_Ladder_Count.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Hyphenation_Ladder_Count);
   end Create_FO_Hyphenation_Ladder_Count;

   -------------------------------------------
   -- Create_FO_Hyphenation_Push_Char_Count --
   -------------------------------------------

   function Create_FO_Hyphenation_Push_Char_Count
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Hyphenation_Push_Char_Count.ODF_FO_Hyphenation_Push_Char_Count is
   begin
      return
        ODF.DOM.Attributes.FO.Hyphenation_Push_Char_Count.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Hyphenation_Push_Char_Count);
   end Create_FO_Hyphenation_Push_Char_Count;

   ---------------------------------------------
   -- Create_FO_Hyphenation_Remain_Char_Count --
   ---------------------------------------------

   function Create_FO_Hyphenation_Remain_Char_Count
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Hyphenation_Remain_Char_Count.ODF_FO_Hyphenation_Remain_Char_Count is
   begin
      return
        ODF.DOM.Attributes.FO.Hyphenation_Remain_Char_Count.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Hyphenation_Remain_Char_Count);
   end Create_FO_Hyphenation_Remain_Char_Count;

   -----------------------------
   -- Create_FO_Keep_Together --
   -----------------------------

   function Create_FO_Keep_Together
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Keep_Together.ODF_FO_Keep_Together is
   begin
      return
        ODF.DOM.Attributes.FO.Keep_Together.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Keep_Together);
   end Create_FO_Keep_Together;

   ------------------------------
   -- Create_FO_Keep_With_Next --
   ------------------------------

   function Create_FO_Keep_With_Next
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Keep_With_Next.ODF_FO_Keep_With_Next is
   begin
      return
        ODF.DOM.Attributes.FO.Keep_With_Next.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Keep_With_Next);
   end Create_FO_Keep_With_Next;

   ------------------------
   -- Create_FO_Language --
   ------------------------

   function Create_FO_Language
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Language.ODF_FO_Language is
   begin
      return
        ODF.DOM.Attributes.FO.Language.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Language);
   end Create_FO_Language;

   ----------------------
   -- Create_FO_Margin --
   ----------------------

   function Create_FO_Margin
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Margin.ODF_FO_Margin is
   begin
      return
        ODF.DOM.Attributes.FO.Margin.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Margin);
   end Create_FO_Margin;

   -----------------------------
   -- Create_FO_Margin_Bottom --
   -----------------------------

   function Create_FO_Margin_Bottom
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Margin_Bottom.ODF_FO_Margin_Bottom is
   begin
      return
        ODF.DOM.Attributes.FO.Margin_Bottom.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Margin_Bottom);
   end Create_FO_Margin_Bottom;

   ---------------------------
   -- Create_FO_Margin_Left --
   ---------------------------

   function Create_FO_Margin_Left
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Margin_Left.ODF_FO_Margin_Left is
   begin
      return
        ODF.DOM.Attributes.FO.Margin_Left.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Margin_Left);
   end Create_FO_Margin_Left;

   ----------------------------
   -- Create_FO_Margin_Right --
   ----------------------------

   function Create_FO_Margin_Right
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Margin_Right.ODF_FO_Margin_Right is
   begin
      return
        ODF.DOM.Attributes.FO.Margin_Right.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Margin_Right);
   end Create_FO_Margin_Right;

   --------------------------
   -- Create_FO_Margin_Top --
   --------------------------

   function Create_FO_Margin_Top
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Margin_Top.ODF_FO_Margin_Top is
   begin
      return
        ODF.DOM.Attributes.FO.Margin_Top.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Margin_Top);
   end Create_FO_Margin_Top;

   -----------------------
   -- Create_FO_Padding --
   -----------------------

   function Create_FO_Padding
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Padding.ODF_FO_Padding is
   begin
      return
        ODF.DOM.Attributes.FO.Padding.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Padding);
   end Create_FO_Padding;

   ---------------------------
   -- Create_FO_Page_Height --
   ---------------------------

   function Create_FO_Page_Height
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Page_Height.ODF_FO_Page_Height is
   begin
      return
        ODF.DOM.Attributes.FO.Page_Height.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Page_Height);
   end Create_FO_Page_Height;

   --------------------------
   -- Create_FO_Page_Width --
   --------------------------

   function Create_FO_Page_Width
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Page_Width.ODF_FO_Page_Width is
   begin
      return
        ODF.DOM.Attributes.FO.Page_Width.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Page_Width);
   end Create_FO_Page_Width;

   --------------------------
   -- Create_FO_Text_Align --
   --------------------------

   function Create_FO_Text_Align
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Text_Align.ODF_FO_Text_Align is
   begin
      return
        ODF.DOM.Attributes.FO.Text_Align.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Text_Align);
   end Create_FO_Text_Align;

   ---------------------------
   -- Create_FO_Text_Indent --
   ---------------------------

   function Create_FO_Text_Indent
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Text_Indent.ODF_FO_Text_Indent is
   begin
      return
        ODF.DOM.Attributes.FO.Text_Indent.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Text_Indent);
   end Create_FO_Text_Indent;

   ---------------------------
   -- Create_FO_Wrap_Option --
   ---------------------------

   function Create_FO_Wrap_Option
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.FO.Wrap_Option.ODF_FO_Wrap_Option is
   begin
      return
        ODF.DOM.Attributes.FO.Wrap_Option.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_FO_Wrap_Option);
   end Create_FO_Wrap_Option;

   ------------------------------------
   -- Create_Office_Automatic_Styles --
   ------------------------------------

   function Create_Office_Automatic_Styles
    (Self : ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Automatic_Styles.ODF_Office_Automatic_Styles is
   begin
      return
        ODF.DOM.Elements.Office.Automatic_Styles.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Office_Automatic_Styles);
   end Create_Office_Automatic_Styles;

   ------------------------
   -- Create_Office_Body --
   ------------------------

   function Create_Office_Body
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Office.Bodies.ODF_Office_Body is
   begin
      return
        ODF.DOM.Elements.Office.Bodies.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Office_Body);
   end Create_Office_Body;

   ------------------------------------
   -- Create_Office_Document_Content --
   ------------------------------------

   function Create_Office_Document_Content
    (Self : ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Document_Content.ODF_Office_Document_Content is
   begin
      return
        ODF.DOM.Elements.Office.Document_Content.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Office_Document_Content);
   end Create_Office_Document_Content;

   -----------------------------------
   -- Create_Office_Document_Styles --
   -----------------------------------

   function Create_Office_Document_Styles
    (Self : ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Document_Styles.ODF_Office_Document_Styles is
   begin
      return
        ODF.DOM.Elements.Office.Document_Styles.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Office_Document_Styles);
   end Create_Office_Document_Styles;

   -----------------------------------
   -- Create_Office_Font_Face_Decls --
   -----------------------------------

   function Create_Office_Font_Face_Decls
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Office.Font_Face_Decls.ODF_Office_Font_Face_Decls is
   begin
      return
        ODF.DOM.Elements.Office.Font_Face_Decls.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Office_Font_Face_Decls);
   end Create_Office_Font_Face_Decls;

   ---------------------------------
   -- Create_Office_Master_Styles --
   ---------------------------------

   function Create_Office_Master_Styles
    (Self : ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Master_Styles.ODF_Office_Master_Styles is
   begin
      return
        ODF.DOM.Elements.Office.Master_Styles.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Office_Master_Styles);
   end Create_Office_Master_Styles;

   ---------------------------
   -- Create_Office_Scripts --
   ---------------------------

   function Create_Office_Scripts
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Office.Scripts.ODF_Office_Scripts is
   begin
      return
        ODF.DOM.Elements.Office.Scripts.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Office_Scripts);
   end Create_Office_Scripts;

   --------------------------
   -- Create_Office_Styles --
   --------------------------

   function Create_Office_Styles
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Office.Styles.ODF_Office_Styles is
   begin
      return
        ODF.DOM.Elements.Office.Styles.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Office_Styles);
   end Create_Office_Styles;

   ------------------------
   -- Create_Office_Text --
   ------------------------

   function Create_Office_Text
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Office.Text.ODF_Office_Text is
   begin
      return
        ODF.DOM.Elements.Office.Text.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Office_Text);
   end Create_Office_Text;

   ------------------------------
   -- Create_Office_Value_Type --
   ------------------------------

   function Create_Office_Value_Type
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Office.Value_Type.ODF_Office_Value_Type is
   begin
      return
        ODF.DOM.Attributes.Office.Value_Type.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Office_Value_Type);
   end Create_Office_Value_Type;

   ---------------------------
   -- Create_Office_Version --
   ---------------------------

   function Create_Office_Version
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Office.Version.ODF_Office_Version is
   begin
      return
        ODF.DOM.Attributes.Office.Version.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Office_Version);
   end Create_Office_Version;

   -----------------------------
   -- Create_Style_Adjustment --
   -----------------------------

   function Create_Style_Adjustment
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Adjustment.ODF_Style_Adjustment is
   begin
      return
        ODF.DOM.Attributes.Style.Adjustment.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Adjustment);
   end Create_Style_Adjustment;

   -----------------------------------
   -- Create_Style_Background_Image --
   -----------------------------------

   function Create_Style_Background_Image
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Background_Image.ODF_Style_Background_Image is
   begin
      return
        ODF.DOM.Elements.Style.Background_Image.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Background_Image);
   end Create_Style_Background_Image;

   ------------------------
   -- Create_Style_Class --
   ------------------------

   function Create_Style_Class
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Class.ODF_Style_Class is
   begin
      return
        ODF.DOM.Attributes.Style.Class.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Class);
   end Create_Style_Class;

   ------------------------
   -- Create_Style_Color --
   ------------------------

   function Create_Style_Color
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Color.ODF_Style_Color is
   begin
      return
        ODF.DOM.Attributes.Style.Color.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Color);
   end Create_Style_Color;

   -------------------------------
   -- Create_Style_Column_Width --
   -------------------------------

   function Create_Style_Column_Width
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Column_Width.ODF_Style_Column_Width is
   begin
      return
        ODF.DOM.Attributes.Style.Column_Width.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Column_Width);
   end Create_Style_Column_Width;

   -------------------------------------
   -- Create_Style_Contextual_Spacing --
   -------------------------------------

   function Create_Style_Contextual_Spacing
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Contextual_Spacing.ODF_Style_Contextual_Spacing is
   begin
      return
        ODF.DOM.Attributes.Style.Contextual_Spacing.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Contextual_Spacing);
   end Create_Style_Contextual_Spacing;

   --------------------------------
   -- Create_Style_Country_Asian --
   --------------------------------

   function Create_Style_Country_Asian
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Country_Asian.ODF_Style_Country_Asian is
   begin
      return
        ODF.DOM.Attributes.Style.Country_Asian.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Country_Asian);
   end Create_Style_Country_Asian;

   ----------------------------------
   -- Create_Style_Country_Complex --
   ----------------------------------

   function Create_Style_Country_Complex
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Country_Complex.ODF_Style_Country_Complex is
   begin
      return
        ODF.DOM.Attributes.Style.Country_Complex.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Country_Complex);
   end Create_Style_Country_Complex;

   ----------------------------------------
   -- Create_Style_Default_Outline_Level --
   ----------------------------------------

   function Create_Style_Default_Outline_Level
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Default_Outline_Level.ODF_Style_Default_Outline_Level is
   begin
      return
        ODF.DOM.Attributes.Style.Default_Outline_Level.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Default_Outline_Level);
   end Create_Style_Default_Outline_Level;

   --------------------------------
   -- Create_Style_Default_Style --
   --------------------------------

   function Create_Style_Default_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style is
   begin
      return
        ODF.DOM.Elements.Style.Default_Style.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Default_Style);
   end Create_Style_Default_Style;

   -------------------------------
   -- Create_Style_Display_Name --
   -------------------------------

   function Create_Style_Display_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Display_Name.ODF_Style_Display_Name is
   begin
      return
        ODF.DOM.Attributes.Style.Display_Name.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Display_Name);
   end Create_Style_Display_Name;

   -------------------------------------
   -- Create_Style_Distance_After_Sep --
   -------------------------------------

   function Create_Style_Distance_After_Sep
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Distance_After_Sep.ODF_Style_Distance_After_Sep is
   begin
      return
        ODF.DOM.Attributes.Style.Distance_After_Sep.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Distance_After_Sep);
   end Create_Style_Distance_After_Sep;

   --------------------------------------
   -- Create_Style_Distance_Before_Sep --
   --------------------------------------

   function Create_Style_Distance_Before_Sep
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Distance_Before_Sep.ODF_Style_Distance_Before_Sep is
   begin
      return
        ODF.DOM.Attributes.Style.Distance_Before_Sep.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Distance_Before_Sep);
   end Create_Style_Distance_Before_Sep;

   -------------------------
   -- Create_Style_Family --
   -------------------------

   function Create_Style_Family
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Family.ODF_Style_Family is
   begin
      return
        ODF.DOM.Attributes.Style.Family.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Family);
   end Create_Style_Family;

   ---------------------------------
   -- Create_Style_Flow_With_Text --
   ---------------------------------

   function Create_Style_Flow_With_Text
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Flow_With_Text.ODF_Style_Flow_With_Text is
   begin
      return
        ODF.DOM.Attributes.Style.Flow_With_Text.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Flow_With_Text);
   end Create_Style_Flow_With_Text;

   ----------------------------
   -- Create_Style_Font_Face --
   ----------------------------

   function Create_Style_Font_Face
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Font_Face.ODF_Style_Font_Face is
   begin
      return
        ODF.DOM.Elements.Style.Font_Face.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Font_Face);
   end Create_Style_Font_Face;

   --------------------------------------
   -- Create_Style_Font_Family_Generic --
   --------------------------------------

   function Create_Style_Font_Family_Generic
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Family_Generic.ODF_Style_Font_Family_Generic is
   begin
      return
        ODF.DOM.Attributes.Style.Font_Family_Generic.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Font_Family_Generic);
   end Create_Style_Font_Family_Generic;

   ------------------------------------------------
   -- Create_Style_Font_Independent_Line_Spacing --
   ------------------------------------------------

   function Create_Style_Font_Independent_Line_Spacing
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Independent_Line_Spacing.ODF_Style_Font_Independent_Line_Spacing is
   begin
      return
        ODF.DOM.Attributes.Style.Font_Independent_Line_Spacing.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Font_Independent_Line_Spacing);
   end Create_Style_Font_Independent_Line_Spacing;

   ----------------------------
   -- Create_Style_Font_Name --
   ----------------------------

   function Create_Style_Font_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Name.ODF_Style_Font_Name is
   begin
      return
        ODF.DOM.Attributes.Style.Font_Name.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Font_Name);
   end Create_Style_Font_Name;

   ----------------------------------
   -- Create_Style_Font_Name_Asian --
   ----------------------------------

   function Create_Style_Font_Name_Asian
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Name_Asian.ODF_Style_Font_Name_Asian is
   begin
      return
        ODF.DOM.Attributes.Style.Font_Name_Asian.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Font_Name_Asian);
   end Create_Style_Font_Name_Asian;

   ------------------------------------
   -- Create_Style_Font_Name_Complex --
   ------------------------------------

   function Create_Style_Font_Name_Complex
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Name_Complex.ODF_Style_Font_Name_Complex is
   begin
      return
        ODF.DOM.Attributes.Style.Font_Name_Complex.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Font_Name_Complex);
   end Create_Style_Font_Name_Complex;

   -----------------------------
   -- Create_Style_Font_Pitch --
   -----------------------------

   function Create_Style_Font_Pitch
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Pitch.ODF_Style_Font_Pitch is
   begin
      return
        ODF.DOM.Attributes.Style.Font_Pitch.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Font_Pitch);
   end Create_Style_Font_Pitch;

   ----------------------------------
   -- Create_Style_Font_Size_Asian --
   ----------------------------------

   function Create_Style_Font_Size_Asian
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Size_Asian.ODF_Style_Font_Size_Asian is
   begin
      return
        ODF.DOM.Attributes.Style.Font_Size_Asian.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Font_Size_Asian);
   end Create_Style_Font_Size_Asian;

   ------------------------------------
   -- Create_Style_Font_Size_Complex --
   ------------------------------------

   function Create_Style_Font_Size_Complex
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Size_Complex.ODF_Style_Font_Size_Complex is
   begin
      return
        ODF.DOM.Attributes.Style.Font_Size_Complex.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Font_Size_Complex);
   end Create_Style_Font_Size_Complex;

   -----------------------------------
   -- Create_Style_Font_Style_Asian --
   -----------------------------------

   function Create_Style_Font_Style_Asian
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Style_Asian.ODF_Style_Font_Style_Asian is
   begin
      return
        ODF.DOM.Attributes.Style.Font_Style_Asian.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Font_Style_Asian);
   end Create_Style_Font_Style_Asian;

   -------------------------------------
   -- Create_Style_Font_Style_Complex --
   -------------------------------------

   function Create_Style_Font_Style_Complex
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Style_Complex.ODF_Style_Font_Style_Complex is
   begin
      return
        ODF.DOM.Attributes.Style.Font_Style_Complex.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Font_Style_Complex);
   end Create_Style_Font_Style_Complex;

   ------------------------------------
   -- Create_Style_Font_Weight_Asian --
   ------------------------------------

   function Create_Style_Font_Weight_Asian
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Weight_Asian.ODF_Style_Font_Weight_Asian is
   begin
      return
        ODF.DOM.Attributes.Style.Font_Weight_Asian.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Font_Weight_Asian);
   end Create_Style_Font_Weight_Asian;

   --------------------------------------
   -- Create_Style_Font_Weight_Complex --
   --------------------------------------

   function Create_Style_Font_Weight_Complex
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Font_Weight_Complex.ODF_Style_Font_Weight_Complex is
   begin
      return
        ODF.DOM.Attributes.Style.Font_Weight_Complex.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Font_Weight_Complex);
   end Create_Style_Font_Weight_Complex;

   -------------------------------
   -- Create_Style_Footer_Style --
   -------------------------------

   function Create_Style_Footer_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Footer_Style.ODF_Style_Footer_Style is
   begin
      return
        ODF.DOM.Elements.Style.Footer_Style.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Footer_Style);
   end Create_Style_Footer_Style;

   --------------------------------------
   -- Create_Style_Footnote_Max_Height --
   --------------------------------------

   function Create_Style_Footnote_Max_Height
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Footnote_Max_Height.ODF_Style_Footnote_Max_Height is
   begin
      return
        ODF.DOM.Attributes.Style.Footnote_Max_Height.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Footnote_Max_Height);
   end Create_Style_Footnote_Max_Height;

   -------------------------------
   -- Create_Style_Footnote_Sep --
   -------------------------------

   function Create_Style_Footnote_Sep
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Footnote_Sep.ODF_Style_Footnote_Sep is
   begin
      return
        ODF.DOM.Elements.Style.Footnote_Sep.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Footnote_Sep);
   end Create_Style_Footnote_Sep;

   -------------------------------------
   -- Create_Style_Graphic_Properties --
   -------------------------------------

   function Create_Style_Graphic_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Graphic_Properties.ODF_Style_Graphic_Properties is
   begin
      return
        ODF.DOM.Elements.Style.Graphic_Properties.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Graphic_Properties);
   end Create_Style_Graphic_Properties;

   -------------------------------
   -- Create_Style_Header_Style --
   -------------------------------

   function Create_Style_Header_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Header_Style.ODF_Style_Header_Style is
   begin
      return
        ODF.DOM.Elements.Style.Header_Style.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Header_Style);
   end Create_Style_Header_Style;

   --------------------------------------
   -- Create_Style_Justify_Single_Word --
   --------------------------------------

   function Create_Style_Justify_Single_Word
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Justify_Single_Word.ODF_Style_Justify_Single_Word is
   begin
      return
        ODF.DOM.Attributes.Style.Justify_Single_Word.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Justify_Single_Word);
   end Create_Style_Justify_Single_Word;

   ---------------------------------
   -- Create_Style_Language_Asian --
   ---------------------------------

   function Create_Style_Language_Asian
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Language_Asian.ODF_Style_Language_Asian is
   begin
      return
        ODF.DOM.Attributes.Style.Language_Asian.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Language_Asian);
   end Create_Style_Language_Asian;

   -----------------------------------
   -- Create_Style_Language_Complex --
   -----------------------------------

   function Create_Style_Language_Complex
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Language_Complex.ODF_Style_Language_Complex is
   begin
      return
        ODF.DOM.Attributes.Style.Language_Complex.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Language_Complex);
   end Create_Style_Language_Complex;

   ---------------------------------
   -- Create_Style_Letter_Kerning --
   ---------------------------------

   function Create_Style_Letter_Kerning
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Letter_Kerning.ODF_Style_Letter_Kerning is
   begin
      return
        ODF.DOM.Attributes.Style.Letter_Kerning.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Letter_Kerning);
   end Create_Style_Letter_Kerning;

   -----------------------------
   -- Create_Style_Line_Break --
   -----------------------------

   function Create_Style_Line_Break
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Line_Break.ODF_Style_Line_Break is
   begin
      return
        ODF.DOM.Attributes.Style.Line_Break.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Line_Break);
   end Create_Style_Line_Break;

   -----------------------------
   -- Create_Style_Line_Style --
   -----------------------------

   function Create_Style_Line_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Line_Style.ODF_Style_Line_Style is
   begin
      return
        ODF.DOM.Attributes.Style.Line_Style.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Line_Style);
   end Create_Style_Line_Style;

   ---------------------------------------------
   -- Create_Style_List_Level_Label_Alignment --
   ---------------------------------------------

   function Create_Style_List_Level_Label_Alignment
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.List_Level_Label_Alignment.ODF_Style_List_Level_Label_Alignment is
   begin
      return
        ODF.DOM.Elements.Style.List_Level_Label_Alignment.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_List_Level_Label_Alignment);
   end Create_Style_List_Level_Label_Alignment;

   ----------------------------------------
   -- Create_Style_List_Level_Properties --
   ----------------------------------------

   function Create_Style_List_Level_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.List_Level_Properties.ODF_Style_List_Level_Properties is
   begin
      return
        ODF.DOM.Elements.Style.List_Level_Properties.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_List_Level_Properties);
   end Create_Style_List_Level_Properties;

   ------------------------------
   -- Create_Style_Master_Page --
   ------------------------------

   function Create_Style_Master_Page
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Master_Page.ODF_Style_Master_Page is
   begin
      return
        ODF.DOM.Elements.Style.Master_Page.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Master_Page);
   end Create_Style_Master_Page;

   -----------------------
   -- Create_Style_Name --
   -----------------------

   function Create_Style_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Name.ODF_Style_Name is
   begin
      return
        ODF.DOM.Attributes.Style.Name.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Name);
   end Create_Style_Name;

   ----------------------------------
   -- Create_Style_Next_Style_Name --
   ----------------------------------

   function Create_Style_Next_Style_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Next_Style_Name.ODF_Style_Next_Style_Name is
   begin
      return
        ODF.DOM.Attributes.Style.Next_Style_Name.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Next_Style_Name);
   end Create_Style_Next_Style_Name;

   -----------------------------
   -- Create_Style_Num_Format --
   -----------------------------

   function Create_Style_Num_Format
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Num_Format.ODF_Style_Num_Format is
   begin
      return
        ODF.DOM.Attributes.Style.Num_Format.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Num_Format);
   end Create_Style_Num_Format;

   ------------------------------
   -- Create_Style_Page_Layout --
   ------------------------------

   function Create_Style_Page_Layout
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Page_Layout.ODF_Style_Page_Layout is
   begin
      return
        ODF.DOM.Elements.Style.Page_Layout.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Page_Layout);
   end Create_Style_Page_Layout;

   -----------------------------------
   -- Create_Style_Page_Layout_Name --
   -----------------------------------

   function Create_Style_Page_Layout_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Page_Layout_Name.ODF_Style_Page_Layout_Name is
   begin
      return
        ODF.DOM.Attributes.Style.Page_Layout_Name.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Page_Layout_Name);
   end Create_Style_Page_Layout_Name;

   -----------------------------------------
   -- Create_Style_Page_Layout_Properties --
   -----------------------------------------

   function Create_Style_Page_Layout_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Page_Layout_Properties.ODF_Style_Page_Layout_Properties is
   begin
      return
        ODF.DOM.Elements.Style.Page_Layout_Properties.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Page_Layout_Properties);
   end Create_Style_Page_Layout_Properties;

   ---------------------------------------
   -- Create_Style_Paragraph_Properties --
   ---------------------------------------

   function Create_Style_Paragraph_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Paragraph_Properties.ODF_Style_Paragraph_Properties is
   begin
      return
        ODF.DOM.Elements.Style.Paragraph_Properties.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Paragraph_Properties);
   end Create_Style_Paragraph_Properties;

   ------------------------------------
   -- Create_Style_Parent_Style_Name --
   ------------------------------------

   function Create_Style_Parent_Style_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Parent_Style_Name.ODF_Style_Parent_Style_Name is
   begin
      return
        ODF.DOM.Attributes.Style.Parent_Style_Name.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Parent_Style_Name);
   end Create_Style_Parent_Style_Name;

   ------------------------------------
   -- Create_Style_Print_Orientation --
   ------------------------------------

   function Create_Style_Print_Orientation
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Print_Orientation.ODF_Style_Print_Orientation is
   begin
      return
        ODF.DOM.Attributes.Style.Print_Orientation.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Print_Orientation);
   end Create_Style_Print_Orientation;

   -----------------------------------
   -- Create_Style_Punctuation_Wrap --
   -----------------------------------

   function Create_Style_Punctuation_Wrap
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Punctuation_Wrap.ODF_Style_Punctuation_Wrap is
   begin
      return
        ODF.DOM.Attributes.Style.Punctuation_Wrap.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Punctuation_Wrap);
   end Create_Style_Punctuation_Wrap;

   -----------------------------------
   -- Create_Style_Rel_Column_Width --
   -----------------------------------

   function Create_Style_Rel_Column_Width
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Rel_Column_Width.ODF_Style_Rel_Column_Width is
   begin
      return
        ODF.DOM.Attributes.Style.Rel_Column_Width.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Rel_Column_Width);
   end Create_Style_Rel_Column_Width;

   ----------------------------
   -- Create_Style_Rel_Width --
   ----------------------------

   function Create_Style_Rel_Width
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Rel_Width.ODF_Style_Rel_Width is
   begin
      return
        ODF.DOM.Attributes.Style.Rel_Width.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Rel_Width);
   end Create_Style_Rel_Width;

   ------------------------
   -- Create_Style_Style --
   ------------------------

   function Create_Style_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Style.ODF_Style_Style is
   begin
      return
        ODF.DOM.Elements.Style.Style.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Style);
   end Create_Style_Style;

   ------------------------------------
   -- Create_Style_Tab_Stop_Distance --
   ------------------------------------

   function Create_Style_Tab_Stop_Distance
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Tab_Stop_Distance.ODF_Style_Tab_Stop_Distance is
   begin
      return
        ODF.DOM.Attributes.Style.Tab_Stop_Distance.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Tab_Stop_Distance);
   end Create_Style_Tab_Stop_Distance;

   ----------------------------
   -- Create_Style_Tab_Stops --
   ----------------------------

   function Create_Style_Tab_Stops
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Tab_Stops.ODF_Style_Tab_Stops is
   begin
      return
        ODF.DOM.Elements.Style.Tab_Stops.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Tab_Stops);
   end Create_Style_Tab_Stops;

   ----------------------------------------
   -- Create_Style_Table_Cell_Properties --
   ----------------------------------------

   function Create_Style_Table_Cell_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Cell_Properties.ODF_Style_Table_Cell_Properties is
   begin
      return
        ODF.DOM.Elements.Style.Table_Cell_Properties.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Table_Cell_Properties);
   end Create_Style_Table_Cell_Properties;

   ------------------------------------------
   -- Create_Style_Table_Column_Properties --
   ------------------------------------------

   function Create_Style_Table_Column_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Column_Properties.ODF_Style_Table_Column_Properties is
   begin
      return
        ODF.DOM.Elements.Style.Table_Column_Properties.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Table_Column_Properties);
   end Create_Style_Table_Column_Properties;

   -----------------------------------
   -- Create_Style_Table_Properties --
   -----------------------------------

   function Create_Style_Table_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Properties.ODF_Style_Table_Properties is
   begin
      return
        ODF.DOM.Elements.Style.Table_Properties.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Table_Properties);
   end Create_Style_Table_Properties;

   ---------------------------------------
   -- Create_Style_Table_Row_Properties --
   ---------------------------------------

   function Create_Style_Table_Row_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Table_Row_Properties.ODF_Style_Table_Row_Properties is
   begin
      return
        ODF.DOM.Elements.Style.Table_Row_Properties.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Table_Row_Properties);
   end Create_Style_Table_Row_Properties;

   ---------------------------------
   -- Create_Style_Text_Autospace --
   ---------------------------------

   function Create_Style_Text_Autospace
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Text_Autospace.ODF_Style_Text_Autospace is
   begin
      return
        ODF.DOM.Attributes.Style.Text_Autospace.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Text_Autospace);
   end Create_Style_Text_Autospace;

   ----------------------------------
   -- Create_Style_Text_Properties --
   ----------------------------------

   function Create_Style_Text_Properties
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Style.Text_Properties.ODF_Style_Text_Properties is
   begin
      return
        ODF.DOM.Elements.Style.Text_Properties.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Text_Properties);
   end Create_Style_Text_Properties;

   ---------------------------------------
   -- Create_Style_Text_Underline_Color --
   ---------------------------------------

   function Create_Style_Text_Underline_Color
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Text_Underline_Color.ODF_Style_Text_Underline_Color is
   begin
      return
        ODF.DOM.Attributes.Style.Text_Underline_Color.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Text_Underline_Color);
   end Create_Style_Text_Underline_Color;

   ---------------------------------------
   -- Create_Style_Text_Underline_Style --
   ---------------------------------------

   function Create_Style_Text_Underline_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Text_Underline_Style.ODF_Style_Text_Underline_Style is
   begin
      return
        ODF.DOM.Attributes.Style.Text_Underline_Style.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Text_Underline_Style);
   end Create_Style_Text_Underline_Style;

   ---------------------------------------
   -- Create_Style_Text_Underline_Width --
   ---------------------------------------

   function Create_Style_Text_Underline_Width
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Text_Underline_Width.ODF_Style_Text_Underline_Width is
   begin
      return
        ODF.DOM.Attributes.Style.Text_Underline_Width.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Text_Underline_Width);
   end Create_Style_Text_Underline_Width;

   ----------------------------------------
   -- Create_Style_Use_Window_Font_Color --
   ----------------------------------------

   function Create_Style_Use_Window_Font_Color
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Use_Window_Font_Color.ODF_Style_Use_Window_Font_Color is
   begin
      return
        ODF.DOM.Attributes.Style.Use_Window_Font_Color.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Use_Window_Font_Color);
   end Create_Style_Use_Window_Font_Color;

   ---------------------------------
   -- Create_Style_Vertical_Align --
   ---------------------------------

   function Create_Style_Vertical_Align
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Vertical_Align.ODF_Style_Vertical_Align is
   begin
      return
        ODF.DOM.Attributes.Style.Vertical_Align.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Vertical_Align);
   end Create_Style_Vertical_Align;

   ------------------------
   -- Create_Style_Width --
   ------------------------

   function Create_Style_Width
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Width.ODF_Style_Width is
   begin
      return
        ODF.DOM.Attributes.Style.Width.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Width);
   end Create_Style_Width;

   -------------------------------
   -- Create_Style_Writing_Mode --
   -------------------------------

   function Create_Style_Writing_Mode
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Style.Writing_Mode.ODF_Style_Writing_Mode is
   begin
      return
        ODF.DOM.Attributes.Style.Writing_Mode.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Style_Writing_Mode);
   end Create_Style_Writing_Mode;

   ----------------------------
   -- Create_SVG_Font_Family --
   ----------------------------

   function Create_SVG_Font_Family
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.SVG.Font_Family.ODF_SVG_Font_Family is
   begin
      return
        ODF.DOM.Attributes.SVG.Font_Family.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_SVG_Font_Family);
   end Create_SVG_Font_Family;

   -----------------------------
   -- Create_SVG_Stroke_Color --
   -----------------------------

   function Create_SVG_Stroke_Color
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.SVG.Stroke_Color.ODF_SVG_Stroke_Color is
   begin
      return
        ODF.DOM.Attributes.SVG.Stroke_Color.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_SVG_Stroke_Color);
   end Create_SVG_Stroke_Color;

   ------------------------
   -- Create_Table_Align --
   ------------------------

   function Create_Table_Align
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Table.Align.ODF_Table_Align is
   begin
      return
        ODF.DOM.Attributes.Table.Align.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Table_Align);
   end Create_Table_Align;

   -------------------------------
   -- Create_Table_Border_Model --
   -------------------------------

   function Create_Table_Border_Model
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Table.Border_Model.ODF_Table_Border_Model is
   begin
      return
        ODF.DOM.Attributes.Table.Border_Model.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Table_Border_Model);
   end Create_Table_Border_Model;

   -------------------------------------
   -- Create_Table_Covered_Table_Cell --
   -------------------------------------

   function Create_Table_Covered_Table_Cell
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Table.Covered_Table_Cell.ODF_Table_Covered_Table_Cell is
   begin
      return
        ODF.DOM.Elements.Table.Covered_Table_Cell.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Table_Covered_Table_Cell);
   end Create_Table_Covered_Table_Cell;

   -----------------------
   -- Create_Table_Name --
   -----------------------

   function Create_Table_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Table.Name.ODF_Table_Name is
   begin
      return
        ODF.DOM.Attributes.Table.Name.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Table_Name);
   end Create_Table_Name;

   -----------------------------------------
   -- Create_Table_Number_Columns_Spanned --
   -----------------------------------------

   function Create_Table_Number_Columns_Spanned
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Table.Number_Columns_Spanned.ODF_Table_Number_Columns_Spanned is
   begin
      return
        ODF.DOM.Attributes.Table.Number_Columns_Spanned.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Table_Number_Columns_Spanned);
   end Create_Table_Number_Columns_Spanned;

   -----------------------------
   -- Create_Table_Style_Name --
   -----------------------------

   function Create_Table_Style_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Table.Style_Name.ODF_Table_Style_Name is
   begin
      return
        ODF.DOM.Attributes.Table.Style_Name.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Table_Style_Name);
   end Create_Table_Style_Name;

   ------------------------
   -- Create_Table_Table --
   ------------------------

   function Create_Table_Table
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table.ODF_Table_Table is
   begin
      return
        ODF.DOM.Elements.Table.Table.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Table_Table);
   end Create_Table_Table;

   -----------------------------
   -- Create_Table_Table_Cell --
   -----------------------------

   function Create_Table_Table_Cell
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell is
   begin
      return
        ODF.DOM.Elements.Table.Table_Cell.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Table_Table_Cell);
   end Create_Table_Table_Cell;

   -------------------------------
   -- Create_Table_Table_Column --
   -------------------------------

   function Create_Table_Table_Column
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table_Column.ODF_Table_Table_Column is
   begin
      return
        ODF.DOM.Elements.Table.Table_Column.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Table_Table_Column);
   end Create_Table_Table_Column;

   ----------------------------
   -- Create_Table_Table_Row --
   ----------------------------

   function Create_Table_Table_Row
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row is
   begin
      return
        ODF.DOM.Elements.Table.Table_Row.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Table_Table_Row);
   end Create_Table_Table_Row;

   ---------------------------------------
   -- Create_Text_Display_Outline_Level --
   ---------------------------------------

   function Create_Text_Display_Outline_Level
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Display_Outline_Level.ODF_Text_Display_Outline_Level is
   begin
      return
        ODF.DOM.Attributes.Text.Display_Outline_Level.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Display_Outline_Level);
   end Create_Text_Display_Outline_Level;

   ------------------------------------
   -- Create_Text_Footnotes_Position --
   ------------------------------------

   function Create_Text_Footnotes_Position
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Footnotes_Position.ODF_Text_Footnotes_Position is
   begin
      return
        ODF.DOM.Attributes.Text.Footnotes_Position.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Footnotes_Position);
   end Create_Text_Footnotes_Position;

   -------------------
   -- Create_Text_H --
   -------------------

   function Create_Text_H
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.H.ODF_Text_H is
   begin
      return
        ODF.DOM.Elements.Text.H.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_H);
   end Create_Text_H;

   ---------------------------
   -- Create_Text_Increment --
   ---------------------------

   function Create_Text_Increment
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Increment.ODF_Text_Increment is
   begin
      return
        ODF.DOM.Attributes.Text.Increment.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Increment);
   end Create_Text_Increment;

   -----------------------------------
   -- Create_Text_Label_Followed_By --
   -----------------------------------

   function Create_Text_Label_Followed_By
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Label_Followed_By.ODF_Text_Label_Followed_By is
   begin
      return
        ODF.DOM.Attributes.Text.Label_Followed_By.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Label_Followed_By);
   end Create_Text_Label_Followed_By;

   -----------------------
   -- Create_Text_Level --
   -----------------------

   function Create_Text_Level
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Level.ODF_Text_Level is
   begin
      return
        ODF.DOM.Attributes.Text.Level.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Level);
   end Create_Text_Level;

   -----------------------------
   -- Create_Text_Line_Number --
   -----------------------------

   function Create_Text_Line_Number
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Line_Number.ODF_Text_Line_Number is
   begin
      return
        ODF.DOM.Attributes.Text.Line_Number.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Line_Number);
   end Create_Text_Line_Number;

   ---------------------------------------------
   -- Create_Text_Linenumbering_Configuration --
   ---------------------------------------------

   function Create_Text_Linenumbering_Configuration
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.Linenumbering_Configuration.ODF_Text_Linenumbering_Configuration is
   begin
      return
        ODF.DOM.Elements.Text.Linenumbering_Configuration.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Linenumbering_Configuration);
   end Create_Text_Linenumbering_Configuration;

   ----------------------------------------------------
   -- Create_Text_List_Level_Position_And_Space_Mode --
   ----------------------------------------------------

   function Create_Text_List_Level_Position_And_Space_Mode
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.List_Level_Position_And_Space_Mode.ODF_Text_List_Level_Position_And_Space_Mode is
   begin
      return
        ODF.DOM.Attributes.Text.List_Level_Position_And_Space_Mode.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_List_Level_Position_And_Space_Mode);
   end Create_Text_List_Level_Position_And_Space_Mode;

   ----------------------------------------
   -- Create_Text_List_Tab_Stop_Position --
   ----------------------------------------

   function Create_Text_List_Tab_Stop_Position
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.List_Tab_Stop_Position.ODF_Text_List_Tab_Stop_Position is
   begin
      return
        ODF.DOM.Attributes.Text.List_Tab_Stop_Position.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_List_Tab_Stop_Position);
   end Create_Text_List_Tab_Stop_Position;

   ------------------------------------
   -- Create_Text_Min_Label_Distance --
   ------------------------------------

   function Create_Text_Min_Label_Distance
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Min_Label_Distance.ODF_Text_Min_Label_Distance is
   begin
      return
        ODF.DOM.Attributes.Text.Min_Label_Distance.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Min_Label_Distance);
   end Create_Text_Min_Label_Distance;

   ----------------------
   -- Create_Text_Name --
   ----------------------

   function Create_Text_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Name.ODF_Text_Name is
   begin
      return
        ODF.DOM.Attributes.Text.Name.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Name);
   end Create_Text_Name;

   ----------------------------
   -- Create_Text_Note_Class --
   ----------------------------

   function Create_Text_Note_Class
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Note_Class.ODF_Text_Note_Class is
   begin
      return
        ODF.DOM.Attributes.Text.Note_Class.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Note_Class);
   end Create_Text_Note_Class;

   -------------------------------------
   -- Create_Text_Notes_Configuration --
   -------------------------------------
 
   function Create_Text_Notes_Configuration
     (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.Notes_Configuration.ODF_Text_Notes_Configuration is
   begin
      return
        ODF.DOM.Elements.Text.Notes_Configuration.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Notes_Configuration);
   end Create_Text_Notes_Configuration;
 
   ------------------------------
   -- Create_Text_Number_Lines --
   ------------------------------

   function Create_Text_Number_Lines
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Number_Lines.ODF_Text_Number_Lines is
   begin
      return
        ODF.DOM.Attributes.Text.Number_Lines.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Number_Lines);
   end Create_Text_Number_Lines;

   ---------------------------------
   -- Create_Text_Number_Position --
   ---------------------------------

   function Create_Text_Number_Position
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Number_Position.ODF_Text_Number_Position is
   begin
      return
        ODF.DOM.Attributes.Text.Number_Position.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Number_Position);
   end Create_Text_Number_Position;

   ------------------------
   -- Create_Text_Offset --
   ------------------------

   function Create_Text_Offset
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Offset.ODF_Text_Offset is
   begin
      return
        ODF.DOM.Attributes.Text.Offset.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Offset);
   end Create_Text_Offset;

   -------------------------------
   -- Create_Text_Outline_Level --
   -------------------------------

   function Create_Text_Outline_Level
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Outline_Level.ODF_Text_Outline_Level is
   begin
      return
        ODF.DOM.Attributes.Text.Outline_Level.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Outline_Level);
   end Create_Text_Outline_Level;

   -------------------------------------
   -- Create_Text_Outline_Level_Style --
   -------------------------------------

   function Create_Text_Outline_Level_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.Outline_Level_Style.ODF_Text_Outline_Level_Style is
   begin
      return
        ODF.DOM.Elements.Text.Outline_Level_Style.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Outline_Level_Style);
   end Create_Text_Outline_Level_Style;

   -------------------------------
   -- Create_Text_Outline_Style --
   -------------------------------

   function Create_Text_Outline_Style
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.Outline_Style.ODF_Text_Outline_Style is
   begin
      return
        ODF.DOM.Elements.Text.Outline_Style.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Outline_Style);
   end Create_Text_Outline_Style;

   -------------------
   -- Create_Text_P --
   -------------------

   function Create_Text_P
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.P.ODF_Text_P is
   begin
      return
        ODF.DOM.Elements.Text.P.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_P);
   end Create_Text_P;

   -------------------------------
   -- Create_Text_Sequence_Decl --
   -------------------------------

   function Create_Text_Sequence_Decl
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.Sequence_Decl.ODF_Text_Sequence_Decl is
   begin
      return
        ODF.DOM.Elements.Text.Sequence_Decl.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Sequence_Decl);
   end Create_Text_Sequence_Decl;

   --------------------------------
   -- Create_Text_Sequence_Decls --
   --------------------------------

   function Create_Text_Sequence_Decls
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.Sequence_Decls.ODF_Text_Sequence_Decls is
   begin
      return
        ODF.DOM.Elements.Text.Sequence_Decls.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Sequence_Decls);
   end Create_Text_Sequence_Decls;

   ----------------------
   -- Create_Text_Span --
   ----------------------

   function Create_Text_Span
    (Self : ODF_Document'Class)
       return ODF.DOM.Elements.Text.Span.ODF_Text_Span is
   begin
      return
        ODF.DOM.Elements.Text.Span.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Span);
   end Create_Text_Span;

   ------------------------------------
   -- Create_Text_Start_Numbering_At --
   ------------------------------------

   function Create_Text_Start_Numbering_At
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Start_Numbering_At.ODF_Text_Start_Numbering_At is
   begin
      return
        ODF.DOM.Attributes.Text.Start_Numbering_At.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Start_Numbering_At);
   end Create_Text_Start_Numbering_At;

   -----------------------------
   -- Create_Text_Start_Value --
   -----------------------------

   function Create_Text_Start_Value
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Start_Value.ODF_Text_Start_Value is
   begin
      return
        ODF.DOM.Attributes.Text.Start_Value.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Start_Value);
   end Create_Text_Start_Value;

   ----------------------------
   -- Create_Text_Style_Name --
   ----------------------------

   function Create_Text_Style_Name
    (Self : ODF_Document'Class)
       return ODF.DOM.Attributes.Text.Style_Name.ODF_Text_Style_Name is
   begin
      return
        ODF.DOM.Attributes.Text.Style_Name.Internals.Wrap
         (ODF.DOM.Documents.Internals.Internal (Self).Create_Text_Style_Name);
   end Create_Text_Style_Name;

end ODF.DOM.Documents;
