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
with ODF.Constants;
with ODF.DOM.Attributes.FO.Background_Color;
with ODF.DOM.Attributes.FO.Font_Size;
with ODF.DOM.Attributes.FO.Font_Style;
with ODF.DOM.Attributes.FO.Font_Weight;
with ODF.DOM.Attributes.FO.Margin;
with ODF.DOM.Attributes.FO.Margin_Bottom;
with ODF.DOM.Attributes.FO.Margin_Left;
with ODF.DOM.Attributes.FO.Margin_Right;
with ODF.DOM.Attributes.FO.Margin_Top;
with ODF.DOM.Attributes.FO.Padding;
--with ODF.DOM.Attributes.FO.Padding_Bottom;
--with ODF.DOM.Attributes.FO.Padding_Left;
--with ODF.DOM.Attributes.FO.Padding_Right;
--with ODF.DOM.Attributes.FO.Padding_Top;
with ODF.DOM.Attributes.FO.Text_Align;
with ODF.DOM.Attributes.Style.Column_Width;
with ODF.DOM.Attributes.Style.Family;
with ODF.DOM.Attributes.Style.Name;
with ODF.DOM.Attributes.Style.Parent_Style_Name;
with ODF.DOM.Attributes.Style.Text_Underline_Style;
with ODF.DOM.Attributes.Table.Number_Columns_Spanned;
with ODF.DOM.Attributes.Table.Style_Name;
with ODF.DOM.Attributes.Text.Style_Name;

package body ODF.Web.Builder is

--   procedure Initialize_Object
--    (Self     : in out JSON_Builder'Class;
--     The_Type : String;
--     Element  : ODF.DOM.Elements.ODF_Element_Access);
--   --  Initialize current JSON object by setting its type and allocating id.
--
--   -----------------------
--   -- Initialize_Object --
--   -----------------------
--
--   procedure Initialize_Object
--    (Self     : in out JSON_Builder'Class;
--     The_Type : String;
--     Element  : ODF.DOM.Elements.ODF_Element_Access);

   -----------------------------------
   -- Enter_Office_Automatic_Styles --
   -----------------------------------

   overriding procedure Enter_Office_Automatic_Styles
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Office.Automatic_Styles.ODF_Office_Automatic_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Inside_Automatic := True;
   end Enter_Office_Automatic_Styles;

   -----------------------------------
   -- Leave_Office_Automatic_Styles --
   -----------------------------------

   overriding procedure Leave_Office_Automatic_Styles
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Office.Automatic_Styles.ODF_Office_Automatic_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Inside_Automatic := False;
   end Leave_Office_Automatic_Styles;

   -----------------------
   -- Enter_Office_Text --
   -----------------------

   overriding procedure Enter_Office_Text
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Office.Text.ODF_Office_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Push ("OdfOfficeText", XML.DOM.Nodes.DOM_Node_Access (Element));
   end Enter_Office_Text;

   -------------------------------
   -- Enter_Style_Default_Style --
   -------------------------------

   overriding procedure Enter_Style_Default_Style
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control)
   is
      Family : constant
        ODF.DOM.Attributes.Style.Family.ODF_Style_Family_Access
          := ODF.DOM.Attributes.Style.Family.ODF_Style_Family_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.Style_URI, ODF.Constants.Family_Name));

   begin
      Self.Push ("OdfStyleStyle", XML.DOM.Nodes.DOM_Node_Access (Element));
      Self.Current.Object.Set_Field ("family", Family.Get_Value.To_UTF_8_String);
      Self.Current.Object.Set_Field ("kind", "default");
   end Enter_Style_Default_Style;

   --------------------------------------
   -- Enter_Style_Paragraph_Properties --
   --------------------------------------

   overriding procedure Enter_Style_Paragraph_Properties
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Style.Paragraph_Properties.ODF_Style_Paragraph_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control)
   is
      use type ODF.DOM.Attributes.FO.Margin.ODF_FO_Margin_Access;
      use type ODF.DOM.Attributes.FO.Margin_Bottom.ODF_FO_Margin_Bottom_Access;
      use type ODF.DOM.Attributes.FO.Margin_Left.ODF_FO_Margin_Left_Access;
      use type ODF.DOM.Attributes.FO.Margin_Right.ODF_FO_Margin_Right_Access;
      use type ODF.DOM.Attributes.FO.Margin_Top.ODF_FO_Margin_Top_Access;
      use type ODF.DOM.Attributes.FO.Text_Align.ODF_FO_Text_Align_Access;

      Margin        : constant
        ODF.DOM.Attributes.FO.Margin.ODF_FO_Margin_Access
          := ODF.DOM.Attributes.FO.Margin.ODF_FO_Margin_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.FO_URI, ODF.Constants.Margin_Name));
      Margin_Bottom : constant
        ODF.DOM.Attributes.FO.Margin_Bottom.ODF_FO_Margin_Bottom_Access
          := ODF.DOM.Attributes.FO.Margin_Bottom.ODF_FO_Margin_Bottom_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.FO_URI, ODF.Constants.Margin_Bottom_Name));
      Margin_Left   : constant
        ODF.DOM.Attributes.FO.Margin_Left.ODF_FO_Margin_Left_Access
          := ODF.DOM.Attributes.FO.Margin_Left.ODF_FO_Margin_Left_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.FO_URI, ODF.Constants.Margin_Left_Name));
      Margin_Right  : constant
        ODF.DOM.Attributes.FO.Margin_Right.ODF_FO_Margin_Right_Access
          := ODF.DOM.Attributes.FO.Margin_Right.ODF_FO_Margin_Right_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.FO_URI, ODF.Constants.Margin_Right_Name));
      Margin_Top    : constant
        ODF.DOM.Attributes.FO.Margin_Top.ODF_FO_Margin_Top_Access
          := ODF.DOM.Attributes.FO.Margin_Top.ODF_FO_Margin_Top_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.FO_URI, ODF.Constants.Margin_Top_Name));
      Text_Align    : constant
        ODF.DOM.Attributes.FO.Text_Align.ODF_FO_Text_Align_Access
          := ODF.DOM.Attributes.FO.Text_Align.ODF_FO_Text_Align_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.FO_URI, ODF.Constants.Text_Align_Name));

   begin
      if Margin_Bottom /= null then
         Self.Current.Object.Set_Field
          ("paragraphMarginBottom", Margin_Bottom.Get_Value.To_UTF_8_String);

      elsif Margin /= null then
         Self.Current.Object.Set_Field
          ("paragraphMarginBottom", Margin.Get_Value.To_UTF_8_String);
      end if;

      if Margin_Left /= null then
         Self.Current.Object.Set_Field
          ("paragraphMarginLeft", Margin_Left.Get_Value.To_UTF_8_String);

      elsif Margin /= null then
         Self.Current.Object.Set_Field
          ("paragraphMarginLeft", Margin.Get_Value.To_UTF_8_String);
      end if;

      if Margin_Right /= null then
         Self.Current.Object.Set_Field
          ("paragraphMarginRight", Margin_Right.Get_Value.To_UTF_8_String);

      elsif Margin /= null then
         Self.Current.Object.Set_Field
          ("paragraphMarginRight", Margin.Get_Value.To_UTF_8_String);
      end if;

      if Margin_Top /= null then
         Self.Current.Object.Set_Field
          ("paragraphMarginTop", Margin_Top.Get_Value.To_UTF_8_String);

      elsif Margin /= null then
         Self.Current.Object.Set_Field
          ("paragraphMarginTop", Margin.Get_Value.To_UTF_8_String);
      end if;

      if Text_Align /= null then
         Self.Current.Object.Set_Field
          ("paragraphTextAlign", Text_Align.Get_Value.To_UTF_8_String);
      end if;
   end Enter_Style_Paragraph_Properties;

   -----------------------
   -- Enter_Style_Style --
   -----------------------

   overriding procedure Enter_Style_Style
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Style.Style.ODF_Style_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control)
   is
      use type ODF.DOM.Attributes.Style.Parent_Style_Name.ODF_Style_Parent_Style_Name_Access;

      Name   : constant
        ODF.DOM.Attributes.Style.Name.ODF_Style_Name_Access
          := ODF.DOM.Attributes.Style.Name.ODF_Style_Name_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.Style_URI, ODF.Constants.Name_Name));
      Family : constant
        ODF.DOM.Attributes.Style.Family.ODF_Style_Family_Access
          := ODF.DOM.Attributes.Style.Family.ODF_Style_Family_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.Style_URI, ODF.Constants.Family_Name));
      Parent : constant
        ODF.DOM.Attributes.Style.Parent_Style_Name.ODF_Style_Parent_Style_Name_Access
          := ODF.DOM.Attributes.Style.Parent_Style_Name.ODF_Style_Parent_Style_Name_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.Style_URI, ODF.Constants.Parent_Style_Name_Name));

   begin
      Self.Push ("OdfStyleStyle", XML.DOM.Nodes.DOM_Node_Access (Element));
      Self.Current.Object.Set_Field ("name", Name.Get_Value.To_UTF_8_String);
      Self.Current.Object.Set_Field ("family", Family.Get_Value.To_UTF_8_String);

      if not Self.Inside_Automatic then
         Self.Current.Object.Set_Field ("kind", "common");
      end if;

      if Parent /= null then
         Self.Current.Object.Set_Field
          ("parentStyleName", Parent.Get_Value.To_UTF_8_String);
      end if;
   end Enter_Style_Style;

   ---------------------------------------
   -- Enter_Style_Table_Cell_Properties --
   ---------------------------------------

   overriding procedure Enter_Style_Table_Cell_Properties
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Style.Table_Cell_Properties.ODF_Style_Table_Cell_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control)
   is
      use type ODF.DOM.Attributes.FO.Background_Color.ODF_FO_Background_Color_Access;
      use type ODF.DOM.Attributes.FO.Padding.ODF_FO_Padding_Access;
--      use type ODF.DOM.Attributes.FO.Padding_Bottom.ODF_FO_Padding_Bottom_Access;
--      use type ODF.DOM.Attributes.FO.Padding_Left.ODF_FO_Padding_Left_Access;
--      use type ODF.DOM.Attributes.FO.Padding_Right.ODF_FO_Padding_Right_Access;
--      use type ODF.DOM.Attributes.FO.Padding_Top.ODF_FO_Padding_Top_Access;

      Background_Color : constant
        ODF.DOM.Attributes.FO.Background_Color.ODF_FO_Background_Color_Access
          := ODF.DOM.Attributes.FO.Background_Color.ODF_FO_Background_Color_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.FO_URI, ODF.Constants.Background_Color_Name));
      Padding          : constant
        ODF.DOM.Attributes.FO.Padding.ODF_FO_Padding_Access
          := ODF.DOM.Attributes.FO.Padding.ODF_FO_Padding_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.FO_URI, ODF.Constants.Padding_Name));
--      Padding_Bottom : constant
--        ODF.DOM.Attributes.FO.Padding_Bottom.ODF_FO_Padding_Bottom_Access
--          := ODF.DOM.Attributes.FO.Padding_Bottom.ODF_FO_Padding_Bottom_Access
--              (Element.Get_Attribute_Node_NS
--                (ODF.Constants.FO_URI, ODF.Constants.Padding_Bottom_Name));
--      Padding_Left   : constant
--        ODF.DOM.Attributes.FO.Padding_Left.ODF_FO_Padding_Left_Access
--          := ODF.DOM.Attributes.FO.Padding_Left.ODF_FO_Padding_Left_Access
--              (Element.Get_Attribute_Node_NS
--                (ODF.Constants.FO_URI, ODF.Constants.Padding_Left_Name));
--      Padding_Right  : constant
--        ODF.DOM.Attributes.FO.Padding_Right.ODF_FO_Padding_Right_Access
--          := ODF.DOM.Attributes.FO.Padding_Right.ODF_FO_Padding_Right_Access
--              (Element.Get_Attribute_Node_NS
--                (ODF.Constants.FO_URI, ODF.Constants.Padding_Right_Name));
--      Padding_Top    : constant
--        ODF.DOM.Attributes.FO.Padding_Top.ODF_FO_Padding_Top_Access
--          := ODF.DOM.Attributes.FO.Padding_Top.ODF_FO_Padding_Top_Access
--              (Element.Get_Attribute_Node_NS
--                (ODF.Constants.FO_URI, ODF.Constants.Padding_Top_Name));

   begin
      if Background_Color /= null then
         Self.Current.Object.Set_Field
          ("cellBackgroundColor", Background_Color.Get_Value.To_UTF_8_String);
      end if;

--      if Padding_Bottom /= null then
--         Self.Current.Object.Set_Field
--          ("cellPaddingBottom", Padding_Bottom.Get_Value.To_UTF_8_String);
--
--      elsif Padding /= null then
      if Padding /= null then
         Self.Current.Object.Set_Field
          ("cellPaddingBottom", Padding.Get_Value.To_UTF_8_String);
      end if;

--      if Padding_Left /= null then
--         Self.Current.Object.Set_Field
--          ("cellPaddingLeft", Padding_Left.Get_Value.To_UTF_8_String);
--
--      elsif Padding /= null then
      if Padding /= null then
         Self.Current.Object.Set_Field
          ("cellPaddingLeft", Padding.Get_Value.To_UTF_8_String);
      end if;

--      if Padding_Right /= null then
--         Self.Current.Object.Set_Field
--          ("cellPaddingRight", Padding_Right.Get_Value.To_UTF_8_String);
--
--      elsif Padding /= null then
      if Padding /= null then
         Self.Current.Object.Set_Field
          ("cellPaddingRight", Padding.Get_Value.To_UTF_8_String);
      end if;

--      if Padding_Top /= null then
--         Self.Current.Object.Set_Field
--          ("cellPaddingTop", Padding_Top.Get_Value.To_UTF_8_String);
--
--      elsif Padding /= null then
      if Padding /= null then
         Self.Current.Object.Set_Field
          ("cellPaddingTop", Padding.Get_Value.To_UTF_8_String);
      end if;
   end Enter_Style_Table_Cell_Properties;

   -----------------------------------------
   -- Enter_Style_Table_Column_Properties --
   -----------------------------------------

   overriding procedure Enter_Style_Table_Column_Properties
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Style.Table_Column_Properties.ODF_Style_Table_Column_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control)
   is
      Width : constant
        ODF.DOM.Attributes.Style.Column_Width.ODF_Style_Column_Width_Access
          := ODF.DOM.Attributes.Style.Column_Width.ODF_Style_Column_Width_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.Style_URI, ODF.Constants.Column_Width_Name));

   begin
      Self.Current.Object.Set_Field
       ("columnWidth", Width.Get_Value.To_UTF_8_String);
   end Enter_Style_Table_Column_Properties;

   ---------------------------------
   -- Enter_Style_Text_Properties --
   ---------------------------------

   overriding procedure Enter_Style_Text_Properties
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Style.Text_Properties.ODF_Style_Text_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control)
   is
      use type ODF.DOM.Attributes.FO.Font_Size.ODF_FO_Font_Size_Access;
      use type ODF.DOM.Attributes.FO.Font_Style.ODF_FO_Font_Style_Access;
      use type ODF.DOM.Attributes.FO.Font_Weight.ODF_FO_Font_Weight_Access;
      use type ODF.DOM.Attributes.Style.Text_Underline_Style.ODF_Style_Text_Underline_Style_Access;

      Font_Size            : constant
        ODF.DOM.Attributes.FO.Font_Size.ODF_FO_Font_Size_Access
          := ODF.DOM.Attributes.FO.Font_Size.ODF_FO_Font_Size_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.FO_URI, ODF.Constants.Font_Size_Name));
      Font_Style           : constant
        ODF.DOM.Attributes.FO.Font_Style.ODF_FO_Font_Style_Access
          := ODF.DOM.Attributes.FO.Font_Style.ODF_FO_Font_Style_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.FO_URI, ODF.Constants.Font_Style_Name));
      Font_Weight          : constant
        ODF.DOM.Attributes.FO.Font_Weight.ODF_FO_Font_Weight_Access
          := ODF.DOM.Attributes.FO.Font_Weight.ODF_FO_Font_Weight_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.FO_URI, ODF.Constants.Font_Weight_Name));
      Text_Underline_Style : constant
        ODF.DOM.Attributes.Style.Text_Underline_Style.ODF_Style_Text_Underline_Style_Access
          := ODF.DOM.Attributes.Style.Text_Underline_Style.ODF_Style_Text_Underline_Style_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.Style_URI, ODF.Constants.Text_Underline_Style_Name));

   begin
      if Font_Size /= null then
         Self.Current.Object.Set_Field
          ("textFontSize", Font_Size.Get_Value.To_UTF_8_String);
      end if;

      if Font_Style /= null then
         Self.Current.Object.Set_Field
          ("textFontStyle", Font_Style.Get_Value.To_UTF_8_String);
      end if;

      if Font_Weight /= null then
         Self.Current.Object.Set_Field
          ("textFontWeight", Font_Weight.Get_Value.To_UTF_8_String);
      end if;

      if Text_Underline_Style /= null then
         Self.Current.Object.Set_Field
          ("textUnderlineStyle", Text_Underline_Style.Get_Value.To_UTF_8_String);
      end if;
   end Enter_Style_Text_Properties;

   -----------------------
   -- Enter_Table_Table --
   -----------------------

   overriding procedure Enter_Table_Table
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table.ODF_Table_Table_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Push ("OdfTableTable", XML.DOM.Nodes.DOM_Node_Access (Element));
   end Enter_Table_Table;

   ----------------------------
   -- Enter_Table_Table_Cell --
   ----------------------------

   overriding procedure Enter_Table_Table_Cell
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control)
   is
      use type ODF.DOM.Attributes.Table.Number_Columns_Spanned.ODF_Table_Number_Columns_Spanned_Access;

      Style_Name      : constant
        ODF.DOM.Attributes.Table.Style_Name.ODF_Table_Style_Name_Access
          := ODF.DOM.Attributes.Table.Style_Name.ODF_Table_Style_Name_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.Table_URI, ODF.Constants.Style_Name_Name));
      Columns_Spanned : constant
        ODF.DOM.Attributes.Table.Number_Columns_Spanned.ODF_Table_Number_Columns_Spanned_Access
          := ODF.DOM.Attributes.Table.Number_Columns_Spanned.ODF_Table_Number_Columns_Spanned_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.Table_URI, ODF.Constants.Number_Columns_Spanned_Name));

   begin
      Self.Push ("OdfTableTableCell", XML.DOM.Nodes.DOM_Node_Access (Element));
      Self.Current.Object.Set_Field
       ("styleName", Style_Name.Get_Value.To_UTF_8_String);

      if Columns_Spanned /= null then
         Self.Current.Object.Set_Field
          ("columnsSpanned", Columns_Spanned.Get_Value.To_UTF_8_String);
      end if;
   end Enter_Table_Table_Cell;

   ------------------------------
   -- Enter_Table_Table_Column --
   ------------------------------

   overriding procedure Enter_Table_Table_Column
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table_Column.ODF_Table_Table_Column_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control)
   is
      Style_Name : constant
        ODF.DOM.Attributes.Table.Style_Name.ODF_Table_Style_Name_Access
          := ODF.DOM.Attributes.Table.Style_Name.ODF_Table_Style_Name_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.Table_URI, ODF.Constants.Style_Name_Name));

   begin
      Self.Push ("OdfTableTableColumn", XML.DOM.Nodes.DOM_Node_Access (Element));
      Self.Current.Object.Set_Field
       ("styleName", Style_Name.Get_Value.To_UTF_8_String);
   end Enter_Table_Table_Column;

   ---------------------------
   -- Enter_Table_Table_Row --
   ---------------------------

   overriding procedure Enter_Table_Table_Row
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Push ("OdfTableTableRow", XML.DOM.Nodes.DOM_Node_Access (Element));
   end Enter_Table_Table_Row;

   ----------------
   -- Enter_Text --
   ----------------

   overriding procedure Enter_Text
    (Self    : in out JSON_Builder;
     Element : not null XML.DOM.Nodes.Character_Datas.Texts.DOM_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Push ("OdfDomText", XML.DOM.Nodes.DOM_Node_Access (Element));
      Self.Current.Object.Set_Field
        ("characters", Element.Get_Data.To_UTF_8_String);
   end Enter_Text;

   ------------------
   -- Enter_Text_H --
   ------------------

   overriding procedure Enter_Text_H
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Text.H.ODF_Text_H_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control)
   is
      Style_Name : constant
        ODF.DOM.Attributes.Text.Style_Name.ODF_Text_Style_Name_Access
          := ODF.DOM.Attributes.Text.Style_Name.ODF_Text_Style_Name_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.Text_URI, ODF.Constants.Style_Name_Name));

   begin
      Self.Push ("OdfTextH", XML.DOM.Nodes.DOM_Node_Access (Element));
      Self.Current.Object.Set_Field
       ("styleName", Style_Name.Get_Value.To_UTF_8_String);
   end Enter_Text_H;

   ------------------
   -- Enter_Text_P --
   ------------------

   overriding procedure Enter_Text_P
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Text.P.ODF_Text_P_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control)
   is
      Style_Name : constant
        ODF.DOM.Attributes.Text.Style_Name.ODF_Text_Style_Name_Access
          := ODF.DOM.Attributes.Text.Style_Name.ODF_Text_Style_Name_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.Text_URI, ODF.Constants.Style_Name_Name));

   begin
      Self.Push ("OdfTextP", XML.DOM.Nodes.DOM_Node_Access (Element));
      Self.Current.Object.Set_Field
       ("styleName", Style_Name.Get_Value.To_UTF_8_String);
   end Enter_Text_P;

   ---------------------
   -- Enter_Text_Span --
   ---------------------

   overriding procedure Enter_Text_Span
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Text.Span.ODF_Text_Span_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control)
   is
      Style_Name : constant
        ODF.DOM.Attributes.Text.Style_Name.ODF_Text_Style_Name_Access
          := ODF.DOM.Attributes.Text.Style_Name.ODF_Text_Style_Name_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.Text_URI, ODF.Constants.Style_Name_Name));

   begin
      Self.Push ("OdfTextSpan", XML.DOM.Nodes.DOM_Node_Access (Element));
      Self.Current.Object.Set_Field ("__type", "OdfTextSpan");
      Self.Current.Object.Set_Field
       ("styleName", Style_Name.Get_Value.To_UTF_8_String);
   end Enter_Text_Span;

   ------------------
   -- Get_Document --
   ------------------

   function Get_Document
    (Self : in out JSON_Builder) return GNATCOLL.JSON.JSON_Value is
   begin
      return Document : GNATCOLL.JSON.JSON_Value
               := GNATCOLL.JSON.Create_Object
      do
         Document.Set_Field ("__type", "OdfDocument");
         Document.Set_Field ("styles", Self.Styles);
         Document.Set_Field ("content", Self.Content);
      end return;
   end Get_Document;

   -----------------------
   -- Leave_Office_Text --
   -----------------------

   overriding procedure Leave_Office_Text
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Office.Text.ODF_Office_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Current.Object.Set_Field ("children", Self.Current.Children);

      Self.Content := Self.Current.Object;
      --  office:text is 'root' element of document content.

      Self.Pop;
   end Leave_Office_Text;

   -------------------------------
   -- Leave_Style_Default_Style --
   -------------------------------

   overriding procedure Leave_Style_Default_Style
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      GNATCOLL.JSON.Append (Self.Styles, Self.Current.Object);
      Self.Pop;
   end Leave_Style_Default_Style;

   -----------------------
   -- Leave_Style_Style --
   -----------------------

   overriding procedure Leave_Style_Style
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Style.Style.ODF_Style_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      GNATCOLL.JSON.Append (Self.Styles, Self.Current.Object);
      Self.Pop;
   end Leave_Style_Style;

   -----------------------
   -- Leave_Table_Table --
   -----------------------

   overriding procedure Leave_Table_Table
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table.ODF_Table_Table_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Current.Object.Set_Field ("children", Self.Current.Children);
      GNATCOLL.JSON.Append (Self.Previous.Children, Self.Current.Object);
      Self.Pop;
   end Leave_Table_Table;

   ----------------------------
   -- Leave_Table_Table_Cell --
   ----------------------------

   overriding procedure Leave_Table_Table_Cell
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Current.Object.Set_Field ("children", Self.Current.Children);
      GNATCOLL.JSON.Append (Self.Previous.Children, Self.Current.Object);
      Self.Pop;
   end Leave_Table_Table_Cell;

   ------------------------------
   -- Leave_Table_Table_Column --
   ------------------------------

   overriding procedure Leave_Table_Table_Column
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table_Column.ODF_Table_Table_Column_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Current.Object.Set_Field ("children", Self.Current.Children);
      GNATCOLL.JSON.Append (Self.Previous.Children, Self.Current.Object);
      Self.Pop;
   end Leave_Table_Table_Column;

   ---------------------------
   -- Leave_Table_Table_Row --
   ---------------------------

   overriding procedure Leave_Table_Table_Row
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Current.Object.Set_Field ("children", Self.Current.Children);
      GNATCOLL.JSON.Append (Self.Previous.Children, Self.Current.Object);
      Self.Pop;
   end Leave_Table_Table_Row;

   ----------------
   -- Leave_Text --
   ----------------

   overriding procedure Leave_Text
    (Self    : in out JSON_Builder;
     Element : not null XML.DOM.Nodes.Character_Datas.Texts.DOM_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      GNATCOLL.JSON.Append (Self.Previous.Children, Self.Current.Object);
      Self.Pop;
   end Leave_Text;

   ------------------
   -- Leave_Text_H --
   ------------------

   overriding procedure Leave_Text_H
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Text.H.ODF_Text_H_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Current.Object.Set_Field ("children", Self.Current.Children);
      GNATCOLL.JSON.Append (Self.Previous.Children, Self.Current.Object);
      Self.Pop;
   end Leave_Text_H;

   ------------------
   -- Leave_Text_P --
   ------------------

   overriding procedure Leave_Text_P
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Text.P.ODF_Text_P_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Current.Object.Set_Field ("children", Self.Current.Children);
      GNATCOLL.JSON.Append (Self.Previous.Children, Self.Current.Object);
      Self.Pop;
   end Leave_Text_P;

   ---------------------
   -- Leave_Text_Span --
   ---------------------

   overriding procedure Leave_Text_Span
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Text.Span.ODF_Text_Span_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Current.Object.Set_Field ("children", Self.Current.Children);
      GNATCOLL.JSON.Append (Self.Previous.Children, Self.Current.Object);
      Self.Pop;
   end Leave_Text_Span;

   ---------
   -- Pop --
   ---------

   procedure Pop (Self : in out JSON_Builder'Class) is
   begin
      Self.Current := Self.Previous;

      if not Self.Stack.Is_Empty then
         Self.Previous := Self.Stack.Last_Element;
         Self.Stack.Delete_Last;

      else
         Self.Previous := (Kind => Initial);
      end if;
   end Pop;

   ----------
   -- Push --
   ----------

   procedure Push
    (Self     : in out JSON_Builder'Class;
     The_Type : String;
     Node     : XML.DOM.Nodes.DOM_Node_Access) is
   begin
      Self.Stack.Append (Self.Previous);
      Self.Previous := Self.Current;
      Self.Current :=
       (Element,
        GNATCOLL.JSON.Create_Object,
        GNATCOLL.JSON.Empty_Array);

      Self.Current.Object.Set_Field ("__type", The_Type);

      if To_Identifier.Contains (Node) then
         Self.Current.Object.Set_Field
           ("identifier", To_Identifier.Element (Node));

      else
         Self.Current.Object.Set_Field ("identifier", Unused_Id);
         To_Node.Insert (Unused_Id, Node);
         To_Identifier.Insert (Node, Unused_Id);
         Unused_Id := Unused_Id + 1;
      end if;
   end Push;

end ODF.Web.Builder;
