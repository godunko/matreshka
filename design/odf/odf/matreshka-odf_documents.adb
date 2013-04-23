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
--with Ada.Wide_Wide_Text_IO;

with ODF.Constants;

package body Matreshka.ODF_Documents is

   use ODF.Constants;
   use type League.Strings.Universal_String;

   function Get_Local_Name
    (Qualified_Name : League.Strings.Universal_String)
       return League.Strings.Universal_String;
   --  Returns local name part of the given qualified name.

   ----------------------
   -- Create_Attribute --
   ----------------------

   overriding function Create_Attribute
    (Self           : not null access Document_Node;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return not null Matreshka.XML.DOM_Nodes.Attribute_Access
   is
      Local_Name : constant League.Strings.Universal_String
        := Get_Local_Name (Qualified_Name);

   begin
      if Namespace_URI = Draw_URI then
         if Local_Name = End_Line_Spacing_Horizontal_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Draw_End_Line_Spacing_Horizontal);

         elsif Local_Name = End_Line_Spacing_Vertical_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Draw_End_Line_Spacing_Vertical);

         elsif Local_Name = Fill_Color_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Draw_Fill_Color);

         elsif Local_Name = Shadow_Offset_X_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Draw_Shadow_Offset_X);

         elsif Local_Name = Shadow_Offset_Y_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Draw_Shadow_Offset_Y);

         elsif Local_Name = Start_Line_Spacing_Horizontal_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Draw_Start_Line_Spacing_Horizontal);

         elsif Local_Name = Start_Line_Spacing_Vertical_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Draw_Start_Line_Spacing_Vertical);
         end if;

      elsif Namespace_URI = FO_URI then
         if Local_Name = Background_Color_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_FO_Background_Color);

         elsif Local_Name = Border_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Border);

         elsif Local_Name = Border_Bottom_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Border_Bottom);

         elsif Local_Name = Border_Left_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Border_Left);

         elsif Local_Name = Border_Right_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_FO_Border_Right);

         elsif Local_Name = Border_Top_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Border_Top);

         elsif Local_Name = Country_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Country);

         elsif Local_Name = Font_Size_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Font_Size);

         elsif Local_Name = Font_Style_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Font_Style);

         elsif Local_Name = Font_Weight_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Font_Weight);

         elsif Local_Name = Hyphenate_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Hyphenate);

         elsif Local_Name = Hyphenation_Ladder_Count_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_FO_Hyphenation_Ladder_Count);

         elsif Local_Name = Hyphenation_Push_Char_Count_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_FO_Hyphenation_Push_Char_Count);

         elsif Local_Name = Hyphenation_Remain_Char_Count_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_FO_Hyphenation_Remain_Char_Count);

         elsif Local_Name = Keep_Together_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_FO_Keep_Together);

         elsif Local_Name = Keep_With_Next_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Keep_With_Next);

         elsif Local_Name = Language_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Language);

         elsif Local_Name = Margin_Name then
            return Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Margin);

         elsif Local_Name = Margin_Bottom_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_FO_Margin_Bottom);

         elsif Local_Name = Margin_Left_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Margin_Left);

         elsif Local_Name = Margin_Right_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_FO_Margin_Right);

         elsif Local_Name = Margin_Top_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Margin_Top);

         elsif Local_Name = Padding_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Padding);

         elsif Local_Name = Page_Height_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Page_Height);

         elsif Local_Name = Page_Width_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Page_Width);

         elsif Local_Name = Text_Align_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Text_Align);

         elsif Local_Name = Text_Indent_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Text_Indent);

         elsif Local_Name = Wrap_Option_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_FO_Wrap_Option);
         end if;

      elsif Namespace_URI = Office_URI then
         if Local_Name = Value_Type_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Office_Value_Type);

         elsif Local_Name = Version_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_Office_Version);
         end if;

      elsif Namespace_URI = Style_URI then
         if Local_Name = Adjustment_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Adjustment);

         elsif Local_Name = Class_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_Style_Class);

         elsif Local_Name = Color_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Color);

         elsif Local_Name = Column_Width_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Column_Width);

         elsif Local_Name = Contextual_Spacing_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Contextual_Spacing);

         elsif Local_Name = Country_Asian_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Country_Asian);

         elsif Local_Name = Country_Complex_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Country_Complex);

         elsif Local_Name = Default_Outline_Level_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Default_Outline_Level);

         elsif Local_Name = Display_Name_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Display_Name);

         elsif Local_Name = Distance_After_Sep_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Distance_After_Sep);

         elsif Local_Name = Distance_Before_Sep_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Distance_Before_Sep);

         elsif Local_Name = Family_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_Style_Family);

         elsif Local_Name = Flow_With_Text_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Flow_With_Text);

         elsif Local_Name = Font_Family_Generic_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Font_Family_Generic);

         elsif Local_Name = Font_Independent_Line_Spacing_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Font_Independent_Line_Spacing);

         elsif Local_Name = Font_Name_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Font_Name);

         elsif Local_Name = Font_Name_Asian_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Font_Name_Asian);

         elsif Local_Name = Font_Name_Complex_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Font_Name_Complex);

         elsif Local_Name = Font_Pitch_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Font_Pitch);

         elsif Local_Name = Font_Size_Asian_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Font_Size_Asian);

         elsif Local_Name = Font_Size_Complex_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Font_Size_Complex);

         elsif Local_Name = Font_Style_Asian_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Font_Style_Asian);

         elsif Local_Name = Font_Style_Complex_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Font_Style_Complex);

         elsif Local_Name = Font_Weight_Asian_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Font_Weight_Asian);

         elsif Local_Name = Font_Weight_Complex_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Font_Weight_Complex);

         elsif Local_Name = Footnote_Max_Height_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Footnote_Max_Height);

         elsif Local_Name = Justify_Single_Word_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Justify_Single_Word);

         elsif Local_Name = Language_Asian_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Language_Asian);

         elsif Local_Name = Language_Complex_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Language_Complex);

         elsif Local_Name = Letter_Kerning_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Letter_Kerning);

         elsif Local_Name = Line_Break_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Line_Break);

         elsif Local_Name = Line_Style_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Line_Style);

         elsif Local_Name = Name_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_Style_Name);

         elsif Local_Name = Next_Style_Name_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Next_Style_Name);

         elsif Local_Name = Num_Format_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Num_Format);

         elsif Local_Name = Page_Layout_Name_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Page_Layout_Name);

         elsif Local_Name = Parent_Style_Name_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Parent_Style_Name);

         elsif Local_Name = Print_Orientation_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Print_Orientation);

         elsif Local_Name = Punctuation_Wrap_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Punctuation_Wrap);

         elsif Local_Name = Rel_Column_Width_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Rel_Column_Width);

         elsif Local_Name = Rel_Width_Name then
            return
              Matreshka.XML.DOM_Nodes.Attribute_Access
               (Self.Create_Style_Rel_Width);

--         elsif Local_Name = Tab_Stop_Distance_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Style_Tab_Stop_Distance);
--
--         elsif Local_Name = Text_Autospace_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Style_Text_Autospace);
--
--         elsif Local_Name = Text_Underline_Color_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Style_Text_Underline_Color);
--
--         elsif Local_Name = Text_Underline_Style_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Style_Text_Underline_Style);
--
--         elsif Local_Name = Text_Underline_Width_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Style_Text_Underline_Width);
--
--         elsif Local_Name = Use_Window_Font_Color_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Style_Use_Window_Font_Color);
--
--         elsif Local_Name = Vertical_Align_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Style_Vertical_Align);
--
--         elsif Local_Name = Width_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_Style_Width);
--
--         elsif Local_Name = Writing_Mode_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Style_Writing_Mode);
         end if;

--      elsif Namespace_URI = SVG_URI then
--         if Local_Name = Font_Family_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_SVG_Font_Family);
--
--         elsif Local_Name = Stroke_Color_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_SVG_Stroke_Color);
--         end if;
--
--      elsif Namespace_URI = Table_URI then
--         if Local_Name = Align_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_Table_Align);
--
--         elsif Local_Name = Border_Model_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_Table_Border_Model);
--
--         elsif Local_Name = Name_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_Table_Name);
--
--         elsif Local_Name = Number_Columns_Spanned_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_Table_Number_Columns_Spanned);
--
--         elsif Local_Name = Style_Name_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Table_Style_Name);
--         end if;
--
--      elsif Namespace_URI = Text_URI then
--         if Local_Name = Display_Outline_Level_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_Display_Outline_Level);
--
--         elsif Local_Name = Footnotes_Position_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_Footnotes_Position);
--
--         elsif Local_Name = Increment_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_Increment);
--
--         elsif Local_Name = Label_Followed_By_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_Label_Followed_By);
--
--         elsif Local_Name = Level_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_Text_Level);
--
--         elsif Local_Name = Line_Number_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_Line_Number);
--
--         elsif Local_Name = List_Level_Position_And_Space_Mode_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_List_Level_Position_And_Space_Mode);
--
--         elsif Local_Name = List_Tab_Stop_Position_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_List_Tab_Stop_Position);
--
--         elsif Local_Name = Min_Label_Distance_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_Min_Label_Distance);
--
--         elsif Local_Name = Name_Name then
--            return Matreshka.XML.DOM_Nodes.Attribute_Access (Self.Create_Text_Name);
--
--         elsif Local_Name = Note_Class_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_Note_Class);
--
--         elsif Local_Name = Number_Lines_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_Number_Lines);
--
--         elsif Local_Name = Number_Position_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_Number_Position);
--
--         elsif Local_Name = Offset_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_Offset);
--
--         elsif Local_Name = Outline_Level_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_Outline_Level);
--
--         elsif Local_Name = Start_Numbering_At_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_Start_Numbering_At);
--
--         elsif Local_Name = Start_Value_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_Start_Value);
--
--         elsif Local_Name = Style_Name_Name then
--            return
--              Matreshka.XML.DOM_Nodes.Attribute_Access
--               (Self.Create_Text_Style_Name);
--         end if;
      end if;
--
--      Ada.Wide_Wide_Text_IO.Put_Line
--       (Ada.Wide_Wide_Text_IO.Standard_Error,
--        "  {"
--          & Namespace_URI.To_Wide_Wide_String
--          & '}'
--          & Local_Name.To_Wide_Wide_String
--          & ' '
--          & Qualified_Name.To_Wide_Wide_String);
--
      raise Program_Error;
   end Create_Attribute;

   ---------------------------------------------
   -- Create_Draw_End_Line_Spacing_Horizontal --
   ---------------------------------------------

   function Create_Draw_End_Line_Spacing_Horizontal
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Draw.End_Line_Spacing_Horizontal.Draw_End_Line_Spacing_Horizontal_Access is
   begin
      return new Matreshka.ODF_Attributes.Draw.End_Line_Spacing_Horizontal.Draw_End_Line_Spacing_Horizontal_Node;
   end Create_Draw_End_Line_Spacing_Horizontal;

   -------------------------------------------
   -- Create_Draw_End_Line_Spacing_Vertical --
   -------------------------------------------

   function Create_Draw_End_Line_Spacing_Vertical
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Draw.End_Line_Spacing_Vertical.Draw_End_Line_Spacing_Vertical_Access is
   begin
      return new Matreshka.ODF_Attributes.Draw.End_Line_Spacing_Vertical.Draw_End_Line_Spacing_Vertical_Node;
   end Create_Draw_End_Line_Spacing_Vertical;

   ----------------------------
   -- Create_Draw_Fill_Color --
   ----------------------------

   function Create_Draw_Fill_Color
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Draw.Fill_Color.Draw_Fill_Color_Access is
   begin
      return new Matreshka.ODF_Attributes.Draw.Fill_Color.Draw_Fill_Color_Node;
   end Create_Draw_Fill_Color;

   ---------------------------------
   -- Create_Draw_Shadow_Offset_X --
   ---------------------------------

   function Create_Draw_Shadow_Offset_X
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Draw.Shadow_Offset_X.Draw_Shadow_Offset_X_Access is
   begin
      return new Matreshka.ODF_Attributes.Draw.Shadow_Offset_X.Draw_Shadow_Offset_X_Node;
   end Create_Draw_Shadow_Offset_X;

   ---------------------------------
   -- Create_Draw_Shadow_Offset_Y --
   ---------------------------------

   function Create_Draw_Shadow_Offset_Y
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Draw.Shadow_Offset_Y.Draw_Shadow_Offset_Y_Access is
   begin
      return new Matreshka.ODF_Attributes.Draw.Shadow_Offset_Y.Draw_Shadow_Offset_Y_Node;
   end Create_Draw_Shadow_Offset_Y;

   -----------------------------------------------
   -- Create_Draw_Start_Line_Spacing_Horizontal --
   -----------------------------------------------

   function Create_Draw_Start_Line_Spacing_Horizontal
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Draw.Start_Line_Spacing_Horizontal.Draw_Start_Line_Spacing_Horizontal_Access is
   begin
      return new Matreshka.ODF_Attributes.Draw.Start_Line_Spacing_Horizontal.Draw_Start_Line_Spacing_Horizontal_Node;
   end Create_Draw_Start_Line_Spacing_Horizontal;

   ---------------------------------------------
   -- Create_Draw_Start_Line_Spacing_Vertical --
   ---------------------------------------------

   function Create_Draw_Start_Line_Spacing_Vertical
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Draw.Start_Line_Spacing_Vertical.Draw_Start_Line_Spacing_Vertical_Access is
   begin
      return new Matreshka.ODF_Attributes.Draw.Start_Line_Spacing_Vertical.Draw_Start_Line_Spacing_Vertical_Node;
   end Create_Draw_Start_Line_Spacing_Vertical;

--   -----------------------
--   -- Create_Element_NS --
--   -----------------------
--
--   overriding function Create_Element_NS
--    (Self           : not null access Document_Node;
--     Namespace_URI  : League.Strings.Universal_String;
--     Qualified_Name : League.Strings.Universal_String)
--       return XML.DOM.Nodes.Elements.DOM_Element_Access
--   is
--      Local_Name : constant League.Strings.Universal_String
--        := Get_Local_Name (Qualified_Name);
--
--   begin
--      if Namespace_URI = Office_URI then
--         if Local_Name = Body_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Office_Body);
--
--         elsif Local_Name = Automatic_Styles_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Office_Automatic_Styles);
--
--         elsif Local_Name = Document_Content_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Office_Document_Content);
--
--         elsif Local_Name = Document_Styles_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Office_Document_Styles);
--
--         elsif Local_Name = Font_Face_Decls_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Office_Font_Face_Decls);
--
--         elsif Local_Name = Master_Styles_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Office_Master_Styles);
--
--         elsif Local_Name = Scripts_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Office_Scripts);
--
--         elsif Local_Name = Styles_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Office_Styles);
--
--         elsif Local_Name = Text_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Office_Text);
--
--         else
--            raise Program_Error;
--         end if;
--
--      elsif Namespace_URI = Style_URI then
--         if Local_Name = Background_Image_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Background_Image);
--
--         elsif Local_Name = Default_Style_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Default_Style);
--
--         elsif Local_Name = Font_Face_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Font_Face);
--
--         elsif Local_Name = Footer_Style_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Footer_Style);
--
--         elsif Local_Name = Footnote_Sep_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Footnote_Sep);
--
--         elsif Local_Name = Graphic_Properties_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Graphic_Properties);
--
--         elsif Local_Name = Header_Style_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Header_Style);
--
--         elsif Local_Name = List_Level_Label_Alignment_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_List_Level_Label_Alignment);
--
--         elsif Local_Name = List_Level_Properties_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_List_Level_Properties);
--
--         elsif Local_Name = Master_Page_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Master_Page);
--
--         elsif Local_Name = Page_Layout_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Page_Layout);
--
--         elsif Local_Name = Page_Layout_Properties_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Page_Layout_Properties);
--
--         elsif Local_Name = Paragraph_Properties_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Paragraph_Properties);
--
--         elsif Local_Name = Style_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Style);
--
--         elsif Local_Name = Tab_Stops_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Tab_Stops);
--
--         elsif Local_Name = Table_Cell_Properties_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Table_Cell_Properties);
--
--         elsif Local_Name = Table_Column_Properties_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Table_Column_Properties);
--
--         elsif Local_Name = Table_Properties_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Table_Properties);
--
--         elsif Local_Name = Table_Row_Properties_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Table_Row_Properties);
--
--         elsif Local_Name = Text_Properties_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Style_Text_Properties);
--
--         else
--            raise Program_Error;
--         end if;
--
--      elsif Namespace_URI = Table_URI then
--         if Local_Name = Covered_Table_Cell_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Table_Covered_Table_Cell);
--
--         elsif Local_Name = Table_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Table_Table);
--
--         elsif Local_Name = Table_Cell_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Table_Table_Cell);
--
--         elsif Local_Name = Table_Column_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Table_Table_Column);
--
--         elsif Local_Name = Table_Row_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Table_Table_Row);
--
--         else
--            raise Program_Error;
--         end if;
--
--      elsif Namespace_URI = Text_URI then
--         if Local_Name = H_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access (Self.Create_Text_H);
--
--         elsif Local_Name = Linenumbering_Configuration_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Text_Linenumbering_Configuration);
--
--         elsif Local_Name = Notes_Configuration_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Text_Notes_Configuration);
--
--         elsif Local_Name = Outline_Level_Style_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Text_Outline_Level_Style);
--
--         elsif Local_Name = Outline_Style_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Text_Outline_Style);
--
--         elsif Local_Name = P_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Text_P);
--
--         elsif Local_Name = Sequence_Decl_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Text_Sequence_Decl);
--
--         elsif Local_Name = Sequence_Decls_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Text_Sequence_Decls);
--
--         elsif Local_Name = Span_Name then
--            return
--              XML.DOM.Nodes.Elements.DOM_Element_Access
--               (Self.Create_Text_Span);
--
--         else
--            raise Program_Error;
--         end if;
--
--      else
--         raise Program_Error;
--      end if;
--   end Create_Element_NS;

   --------------------------------
   -- Create_FO_Background_Color --
   --------------------------------

   function Create_FO_Background_Color
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Background_Color.FO_Background_Color_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Background_Color.FO_Background_Color_Node;
   end Create_FO_Background_Color;

   ----------------------
   -- Create_FO_Border --
   ----------------------

   function Create_FO_Border
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Border.FO_Border_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Border.FO_Border_Node;
   end Create_FO_Border;

   -----------------------------
   -- Create_FO_Border_Bottom --
   -----------------------------

   function Create_FO_Border_Bottom
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Border_Bottom.FO_Border_Bottom_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Border_Bottom.FO_Border_Bottom_Node;
   end Create_FO_Border_Bottom;

   ---------------------------
   -- Create_FO_Border_Left --
   ---------------------------

   function Create_FO_Border_Left
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Border_Left.FO_Border_Left_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Border_Left.FO_Border_Left_Node;
   end Create_FO_Border_Left;

   ----------------------------
   -- Create_FO_Border_Right --
   ----------------------------

   function Create_FO_Border_Right
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Border_Right.FO_Border_Right_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Border_Right.FO_Border_Right_Node;
   end Create_FO_Border_Right;

   --------------------------
   -- Create_FO_Border_Top --
   --------------------------

   function Create_FO_Border_Top
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Border_Top.FO_Border_Top_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Border_Top.FO_Border_Top_Node;
   end Create_FO_Border_Top;

   -----------------------
   -- Create_FO_Country --
   -----------------------

   function Create_FO_Country
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Country.FO_Country_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Country.FO_Country_Node;
   end Create_FO_Country;

   -------------------------
   -- Create_FO_Font_Size --
   -------------------------

   function Create_FO_Font_Size
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Font_Size.FO_Font_Size_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Font_Size.FO_Font_Size_Node;
   end Create_FO_Font_Size;

   --------------------------
   -- Create_FO_Font_Style --
   --------------------------

   function Create_FO_Font_Style
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Font_Style.FO_Font_Style_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Font_Style.FO_Font_Style_Node;
   end Create_FO_Font_Style;

   ---------------------------
   -- Create_FO_Font_Weight --
   ---------------------------

   function Create_FO_Font_Weight
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Font_Weight.FO_Font_Weight_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Font_Weight.FO_Font_Weight_Node;
   end Create_FO_Font_Weight;

   -------------------------
   -- Create_FO_Hyphenate --
   -------------------------

   function Create_FO_Hyphenate
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Hyphenate.FO_Hyphenate_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Hyphenate.FO_Hyphenate_Node;
   end Create_FO_Hyphenate;

   ----------------------------------------
   -- Create_FO_Hyphenation_Ladder_Count --
   ----------------------------------------

   function Create_FO_Hyphenation_Ladder_Count
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Hyphenation_Ladder_Count.FO_Hyphenation_Ladder_Count_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Hyphenation_Ladder_Count.FO_Hyphenation_Ladder_Count_Node;
   end Create_FO_Hyphenation_Ladder_Count;

   -------------------------------------------
   -- Create_FO_Hyphenation_Push_Char_Count --
   -------------------------------------------

   function Create_FO_Hyphenation_Push_Char_Count
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Hyphenation_Push_Char_Count.FO_Hyphenation_Push_Char_Count_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Hyphenation_Push_Char_Count.FO_Hyphenation_Push_Char_Count_Node;
   end Create_FO_Hyphenation_Push_Char_Count;

   ---------------------------------------------
   -- Create_FO_Hyphenation_Remain_Char_Count --
   ---------------------------------------------

   function Create_FO_Hyphenation_Remain_Char_Count
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Hyphenation_Remain_Char_Count.FO_Hyphenation_Remain_Char_Count_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Hyphenation_Remain_Char_Count.FO_Hyphenation_Remain_Char_Count_Node;
   end Create_FO_Hyphenation_Remain_Char_Count;

   -----------------------------
   -- Create_FO_Keep_Together --
   -----------------------------

   function Create_FO_Keep_Together
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Keep_Together.FO_Keep_Together_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Keep_Together.FO_Keep_Together_Node;
   end Create_FO_Keep_Together;

   ------------------------------
   -- Create_FO_Keep_With_Next --
   ------------------------------

   function Create_FO_Keep_With_Next
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Keep_With_Next.FO_Keep_With_Next_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Keep_With_Next.FO_Keep_With_Next_Node;
   end Create_FO_Keep_With_Next;

   ------------------------
   -- Create_FO_Language --
   ------------------------

   function Create_FO_Language
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Language.FO_Language_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Language.FO_Language_Node;
   end Create_FO_Language;

   ----------------------
   -- Create_FO_Margin --
   ----------------------

   function Create_FO_Margin
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Margin.FO_Margin_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Margin.FO_Margin_Node;
   end Create_FO_Margin;

   -----------------------------
   -- Create_FO_Margin_Bottom --
   -----------------------------

   function Create_FO_Margin_Bottom
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Margin_Bottom.FO_Margin_Bottom_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Margin_Bottom.FO_Margin_Bottom_Node;
   end Create_FO_Margin_Bottom;

   ---------------------------
   -- Create_FO_Margin_Left --
   ---------------------------

   function Create_FO_Margin_Left
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Margin_Left.FO_Margin_Left_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Margin_Left.FO_Margin_Left_Node;
   end Create_FO_Margin_Left;

   ----------------------------
   -- Create_FO_Margin_Right --
   ----------------------------

   function Create_FO_Margin_Right
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Margin_Right.FO_Margin_Right_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Margin_Right.FO_Margin_Right_Node;
   end Create_FO_Margin_Right;

   --------------------------
   -- Create_FO_Margin_Top --
   --------------------------

   function Create_FO_Margin_Top
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Margin_Top.FO_Margin_Top_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Margin_Top.FO_Margin_Top_Node;
   end Create_FO_Margin_Top;

   -----------------------
   -- Create_FO_Padding --
   -----------------------

   function Create_FO_Padding
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Padding.FO_Padding_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Padding.FO_Padding_Node;
   end Create_FO_Padding;

   ---------------------------
   -- Create_FO_Page_Height --
   ---------------------------

   function Create_FO_Page_Height
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Page_Height.FO_Page_Height_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Page_Height.FO_Page_Height_Node;
   end Create_FO_Page_Height;

   --------------------------
   -- Create_FO_Page_Width --
   --------------------------

   function Create_FO_Page_Width
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Page_Width.FO_Page_Width_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Page_Width.FO_Page_Width_Node;
   end Create_FO_Page_Width;

   --------------------------
   -- Create_FO_Text_Align --
   --------------------------

   function Create_FO_Text_Align
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Text_Align.FO_Text_Align_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Text_Align.FO_Text_Align_Node;
   end Create_FO_Text_Align;

   ---------------------------
   -- Create_FO_Text_Indent --
   ---------------------------

   function Create_FO_Text_Indent
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Text_Indent.FO_Text_Indent_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Text_Indent.FO_Text_Indent_Node;
   end Create_FO_Text_Indent;

   ---------------------------
   -- Create_FO_Wrap_Option --
   ---------------------------

   function Create_FO_Wrap_Option
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.FO.Wrap_Option.FO_Wrap_Option_Access is
   begin
      return new Matreshka.ODF_Attributes.FO.Wrap_Option.FO_Wrap_Option_Node;
   end Create_FO_Wrap_Option;

--   ------------------------------------
--   -- Create_Office_Automatic_Styles --
--   ------------------------------------
--
--   function Create_Office_Automatic_Styles
--    (Self : not null access Document_Node'Class)
--       return
--         ODF.DOM.Elements.Office.Automatic_Styles.Office_Automatic_Styles_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Office.Automatic_Styles.Office_Automatic_Styles;
--   end Create_Office_Automatic_Styles;
--
--   ------------------------
--   -- Create_Office_Body --
--   ------------------------
--
--   function Create_Office_Body
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Office.Bodies.Office_Body_Access is
--   begin
--      return new ODF.DOM.Elements.Office.Bodies.Office_Body;
--   end Create_Office_Body;
--
--   ------------------------------------
--   -- Create_Office_Document_Content --
--   ------------------------------------
--
--   function Create_Office_Document_Content
--    (Self : not null access Document_Node'Class)
--       return
--         ODF.DOM.Elements.Office.Document_Content.Office_Document_Content_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Office.Document_Content.Office_Document_Content;
--   end Create_Office_Document_Content;
--
--   -----------------------------------
--   -- Create_Office_Document_Styles --
--   -----------------------------------
--
--   function Create_Office_Document_Styles
--    (Self : not null access Document_Node'Class)
--       return
--         ODF.DOM.Elements.Office.Document_Styles.Office_Document_Styles_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Office.Document_Styles.Office_Document_Styles;
--   end Create_Office_Document_Styles;
--
--   -----------------------------------
--   -- Create_Office_Font_Face_Decls --
--   -----------------------------------
--
--   function Create_Office_Font_Face_Decls
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Office.Font_Face_Decls.Office_Font_Face_Decls_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Office.Font_Face_Decls.Office_Font_Face_Decls;
--   end Create_Office_Font_Face_Decls;
--
--   ---------------------------------
--   -- Create_Office_Master_Styles --
--   ---------------------------------
--
--   function Create_Office_Master_Styles
--    (Self : not null access Document_Node'Class)
--       return
--         ODF.DOM.Elements.Office.Master_Styles.Office_Master_Styles_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Office.Master_Styles.Office_Master_Styles;
--   end Create_Office_Master_Styles;
--
--   ---------------------------
--   -- Create_Office_Scripts --
--   ---------------------------
--
--   function Create_Office_Scripts
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Office.Scripts.Office_Scripts_Access is
--   begin
--      return new ODF.DOM.Elements.Office.Scripts.Office_Scripts;
--   end Create_Office_Scripts;
--
--   --------------------------
--   -- Create_Office_Styles --
--   --------------------------
--
--   function Create_Office_Styles
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Office.Styles.Office_Styles_Access is
--   begin
--      return new ODF.DOM.Elements.Office.Styles.Office_Styles;
--   end Create_Office_Styles;
--
--   ------------------------
--   -- Create_Office_Text --
--   ------------------------
--
--   function Create_Office_Text
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Office.Text.Office_Text_Access is
--   begin
--      return new ODF.DOM.Elements.Office.Text.Office_Text;
--   end Create_Office_Text;

   ------------------------------
   -- Create_Office_Value_Type --
   ------------------------------

   function Create_Office_Value_Type
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Office.Value_Type.Office_Value_Type_Access is
   begin
      return new Matreshka.ODF_Attributes.Office.Value_Type.Office_Value_Type_Node;
   end Create_Office_Value_Type;

   ---------------------------
   -- Create_Office_Version --
   ---------------------------

   function Create_Office_Version
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Office.Version.Office_Version_Access is
   begin
      return new Matreshka.ODF_Attributes.Office.Version.Office_Version_Node;
   end Create_Office_Version;

   -----------------------------
   -- Create_Style_Adjustment --
   -----------------------------

   function Create_Style_Adjustment
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Adjustment.Style_Adjustment_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Adjustment.Style_Adjustment_Node;
   end Create_Style_Adjustment;

--   -----------------------------------
--   -- Create_Style_Background_Image --
--   -----------------------------------
--
--   function Create_Style_Background_Image
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Background_Image.Style_Background_Image_Access is
--   begin
--      return new ODF.DOM.Elements.Style.Background_Image.Style_Background_Image;
--   end Create_Style_Background_Image;

   ------------------------
   -- Create_Style_Class --
   ------------------------

   function Create_Style_Class
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Class.Style_Class_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Class.Style_Class_Node;
   end Create_Style_Class;

   ------------------------
   -- Create_Style_Color --
   ------------------------

   function Create_Style_Color
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Color.Style_Color_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Color.Style_Color_Node;
   end Create_Style_Color;

   -------------------------------
   -- Create_Style_Column_Width --
   -------------------------------

   function Create_Style_Column_Width
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Column_Width.Style_Column_Width_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Column_Width.Style_Column_Width_Node;
   end Create_Style_Column_Width;

   -------------------------------------
   -- Create_Style_Contextual_Spacing --
   -------------------------------------

   function Create_Style_Contextual_Spacing
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Contextual_Spacing.Style_Contextual_Spacing_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Contextual_Spacing.Style_Contextual_Spacing_Node;
   end Create_Style_Contextual_Spacing;

   --------------------------------
   -- Create_Style_Country_Asian --
   --------------------------------

   function Create_Style_Country_Asian
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Country_Asian.Style_Country_Asian_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Country_Asian.Style_Country_Asian_Node;
   end Create_Style_Country_Asian;

   ----------------------------------
   -- Create_Style_Country_Complex --
   ----------------------------------

   function Create_Style_Country_Complex
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Country_Complex.Style_Country_Complex_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Country_Complex.Style_Country_Complex_Node;
   end Create_Style_Country_Complex;

   ----------------------------------------
   -- Create_Style_Default_Outline_Level --
   ----------------------------------------

   function Create_Style_Default_Outline_Level
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Default_Outline_Level.Style_Default_Outline_Level_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Default_Outline_Level.Style_Default_Outline_Level_Node;
   end Create_Style_Default_Outline_Level;

--   --------------------------------
--   -- Create_Style_Default_Style --
--   --------------------------------
--
--   function Create_Style_Default_Style
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Default_Style.Style_Default_Style_Access is
--   begin
--      return new ODF.DOM.Elements.Style.Default_Style.Style_Default_Style;
--   end Create_Style_Default_Style;

   -------------------------------
   -- Create_Style_Display_Name --
   -------------------------------

   function Create_Style_Display_Name
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Display_Name.Style_Display_Name_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Display_Name.Style_Display_Name_Node;
   end Create_Style_Display_Name;

   -------------------------------------
   -- Create_Style_Distance_After_Sep --
   -------------------------------------

   function Create_Style_Distance_After_Sep
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Distance_After_Sep.Style_Distance_After_Sep_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Distance_After_Sep.Style_Distance_After_Sep_Node;
   end Create_Style_Distance_After_Sep;

   --------------------------------------
   -- Create_Style_Distance_Before_Sep --
   --------------------------------------

   function Create_Style_Distance_Before_Sep
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Distance_Before_Sep.Style_Distance_Before_Sep_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Distance_Before_Sep.Style_Distance_Before_Sep_Node;
   end Create_Style_Distance_Before_Sep;

   -------------------------
   -- Create_Style_Family --
   -------------------------

   function Create_Style_Family
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Family.Style_Family_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Family.Style_Family_Node;
   end Create_Style_Family;

   ---------------------------------
   -- Create_Style_Flow_With_Text --
   ---------------------------------

   function Create_Style_Flow_With_Text
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Flow_With_Text.Style_Flow_With_Text_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Flow_With_Text.Style_Flow_With_Text_Node;
   end Create_Style_Flow_With_Text;

--   ----------------------------
--   -- Create_Style_Font_Face --
--   ----------------------------
--
--   function Create_Style_Font_Face
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Font_Face.Style_Font_Face_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Style.Font_Face.Style_Font_Face;
--   end Create_Style_Font_Face;

   --------------------------------------
   -- Create_Style_Font_Family_Generic --
   --------------------------------------

   function Create_Style_Font_Family_Generic
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Font_Family_Generic.Style_Font_Family_Generic_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Font_Family_Generic.Style_Font_Family_Generic_Node;
   end Create_Style_Font_Family_Generic;

   ------------------------------------------------
   -- Create_Style_Font_Independent_Line_Spacing --
   ------------------------------------------------

   function Create_Style_Font_Independent_Line_Spacing
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Font_Independent_Line_Spacing.Style_Font_Independent_Line_Spacing_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Font_Independent_Line_Spacing.Style_Font_Independent_Line_Spacing_Node;
   end Create_Style_Font_Independent_Line_Spacing;

   ----------------------------
   -- Create_Style_Font_Name --
   ----------------------------

   function Create_Style_Font_Name
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Font_Name.Style_Font_Name_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Font_Name.Style_Font_Name_Node;
   end Create_Style_Font_Name;

   ----------------------------------
   -- Create_Style_Font_Name_Asian --
   ----------------------------------

   function Create_Style_Font_Name_Asian
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Font_Name_Asian.Style_Font_Name_Asian_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Font_Name_Asian.Style_Font_Name_Asian_Node;
   end Create_Style_Font_Name_Asian;

   ------------------------------------
   -- Create_Style_Font_Name_Complex --
   ------------------------------------

   function Create_Style_Font_Name_Complex
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Font_Name_Complex.Style_Font_Name_Complex_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Font_Name_Complex.Style_Font_Name_Complex_Node;
   end Create_Style_Font_Name_Complex;

   -----------------------------
   -- Create_Style_Font_Pitch --
   -----------------------------

   function Create_Style_Font_Pitch
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Font_Pitch.Style_Font_Pitch_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Font_Pitch.Style_Font_Pitch_Node;
   end Create_Style_Font_Pitch;

   ----------------------------------
   -- Create_Style_Font_Size_Asian --
   ----------------------------------

   function Create_Style_Font_Size_Asian
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Font_Size_Asian.Style_Font_Size_Asian_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Font_Size_Asian.Style_Font_Size_Asian_Node;
   end Create_Style_Font_Size_Asian;

   ------------------------------------
   -- Create_Style_Font_Size_Complex --
   ------------------------------------

   function Create_Style_Font_Size_Complex
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Font_Size_Complex.Style_Font_Size_Complex_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Font_Size_Complex.Style_Font_Size_Complex_Node;
   end Create_Style_Font_Size_Complex;

   -----------------------------------
   -- Create_Style_Font_Style_Asian --
   -----------------------------------

   function Create_Style_Font_Style_Asian
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Font_Style_Asian.Style_Font_Style_Asian_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Font_Style_Asian.Style_Font_Style_Asian_Node;
   end Create_Style_Font_Style_Asian;

   -------------------------------------
   -- Create_Style_Font_Style_Complex --
   -------------------------------------

   function Create_Style_Font_Style_Complex
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Font_Style_Complex.Style_Font_Style_Complex_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Font_Style_Complex.Style_Font_Style_Complex_Node;
   end Create_Style_Font_Style_Complex;

   ------------------------------------
   -- Create_Style_Font_Weight_Asian --
   ------------------------------------

   function Create_Style_Font_Weight_Asian
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Font_Weight_Asian.Style_Font_Weight_Asian_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Font_Weight_Asian.Style_Font_Weight_Asian_Node;
   end Create_Style_Font_Weight_Asian;

   --------------------------------------
   -- Create_Style_Font_Weight_Complex --
   --------------------------------------

   function Create_Style_Font_Weight_Complex
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Font_Weight_Complex.Style_Font_Weight_Complex_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Font_Weight_Complex.Style_Font_Weight_Complex_Node;
   end Create_Style_Font_Weight_Complex;

--   -------------------------------
--   -- Create_Style_Footer_Style --
--   -------------------------------
--
--   function Create_Style_Footer_Style
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Footer_Style.Style_Footer_Style_Access is
--   begin
--      return new ODF.DOM.Elements.Style.Footer_Style.Style_Footer_Style;
--   end Create_Style_Footer_Style;

   --------------------------------------
   -- Create_Style_Footnote_Max_Height --
   --------------------------------------

   function Create_Style_Footnote_Max_Height
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Footnote_Max_Height.Style_Footnote_Max_Height_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Footnote_Max_Height.Style_Footnote_Max_Height_Node;
   end Create_Style_Footnote_Max_Height;

--   -------------------------------
--   -- Create_Style_Footnote_Sep --
--   -------------------------------
--
--   function Create_Style_Footnote_Sep
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Footnote_Sep.Style_Footnote_Sep_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Style.Footnote_Sep.Style_Footnote_Sep;
--   end Create_Style_Footnote_Sep;
--
--   -------------------------------------
--   -- Create_Style_Graphic_Properties --
--   -------------------------------------
--
--   function Create_Style_Graphic_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Graphic_Properties.Style_Graphic_Properties_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Style.Graphic_Properties.Style_Graphic_Properties;
--   end Create_Style_Graphic_Properties;
--
--   -------------------------------
--   -- Create_Style_Header_Style --
--   -------------------------------
--
--   function Create_Style_Header_Style
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Header_Style.Style_Header_Style_Access is
--   begin
--      return new ODF.DOM.Elements.Style.Header_Style.Style_Header_Style;
--   end Create_Style_Header_Style;

   --------------------------------------
   -- Create_Style_Justify_Single_Word --
   --------------------------------------

   function Create_Style_Justify_Single_Word
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Justify_Single_Word.Style_Justify_Single_Word_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Justify_Single_Word.Style_Justify_Single_Word_Node;
   end Create_Style_Justify_Single_Word;

   ---------------------------------
   -- Create_Style_Language_Asian --
   ---------------------------------

   function Create_Style_Language_Asian
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Language_Asian.Style_Language_Asian_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Language_Asian.Style_Language_Asian_Node;
   end Create_Style_Language_Asian;

   -----------------------------------
   -- Create_Style_Language_Complex --
   -----------------------------------

   function Create_Style_Language_Complex
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Language_Complex.Style_Language_Complex_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Language_Complex.Style_Language_Complex_Node;
   end Create_Style_Language_Complex;

   ---------------------------------
   -- Create_Style_Letter_Kerning --
   ---------------------------------

   function Create_Style_Letter_Kerning
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Letter_Kerning.Style_Letter_Kerning_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Letter_Kerning.Style_Letter_Kerning_Node;
   end Create_Style_Letter_Kerning;

   -----------------------------
   -- Create_Style_Line_Break --
   -----------------------------

   function Create_Style_Line_Break
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Line_Break.Style_Line_Break_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Line_Break.Style_Line_Break_Node;
   end Create_Style_Line_Break;

   -----------------------------
   -- Create_Style_Line_Style --
   -----------------------------

   function Create_Style_Line_Style
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Line_Style.Style_Line_Style_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Line_Style.Style_Line_Style_Node;
   end Create_Style_Line_Style;

--   ---------------------------------------------
--   -- Create_Style_List_Level_Label_Alignment --
--   ---------------------------------------------
--
--   function Create_Style_List_Level_Label_Alignment
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.List_Level_Label_Alignment.Style_List_Level_Label_Alignment_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Style.List_Level_Label_Alignment.Style_List_Level_Label_Alignment;
--   end Create_Style_List_Level_Label_Alignment;
--
--   ----------------------------------------
--   -- Create_Style_List_Level_Properties --
--   ----------------------------------------
--
--   function Create_Style_List_Level_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.List_Level_Properties.Style_List_Level_Properties_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Style.List_Level_Properties.Style_List_Level_Properties;
--   end Create_Style_List_Level_Properties;
--
--   ------------------------------
--   -- Create_Style_Master_Page --
--   ------------------------------
--
--   function Create_Style_Master_Page
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Master_Page.Style_Master_Page_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Style.Master_Page.Style_Master_Page;
--   end Create_Style_Master_Page;

   -----------------------
   -- Create_Style_Name --
   -----------------------

   function Create_Style_Name
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Name.Style_Name_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Name.Style_Name_Node;
   end Create_Style_Name;

   ----------------------------------
   -- Create_Style_Next_Style_Name --
   ----------------------------------

   function Create_Style_Next_Style_Name
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Next_Style_Name.Style_Next_Style_Name_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Next_Style_Name.Style_Next_Style_Name_Node;
   end Create_Style_Next_Style_Name;

   -----------------------------
   -- Create_Style_Num_Format --
   -----------------------------

   function Create_Style_Num_Format
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Num_Format.Style_Num_Format_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Num_Format.Style_Num_Format_Node;
   end Create_Style_Num_Format;

--   ------------------------------
--   -- Create_Style_Page_Layout --
--   ------------------------------
--
--   function Create_Style_Page_Layout
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Page_Layout.Style_Page_Layout_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Style.Page_Layout.Style_Page_Layout;
--   end Create_Style_Page_Layout;
--
--   -----------------------------------------
--   -- Create_Style_Page_Layout_Properties --
--   -----------------------------------------
--
--   function Create_Style_Page_Layout_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Page_Layout_Properties.Style_Page_Layout_Properties_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Style.Page_Layout_Properties.Style_Page_Layout_Properties;
--   end Create_Style_Page_Layout_Properties;
--
--   ---------------------------------------
--   -- Create_Style_Paragraph_Properties --
--   ---------------------------------------
--
--   function Create_Style_Paragraph_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Paragraph_Properties.Style_Paragraph_Properties_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Style.Paragraph_Properties.Style_Paragraph_Properties;
--   end Create_Style_Paragraph_Properties;

   -----------------------------------
   -- Create_Style_Page_Layout_Name --
   -----------------------------------

   function Create_Style_Page_Layout_Name
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Page_Layout_Name.Style_Page_Layout_Name_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Page_Layout_Name.Style_Page_Layout_Name_Node;
   end Create_Style_Page_Layout_Name;

   ------------------------------------
   -- Create_Style_Parent_Style_Name --
   ------------------------------------

   function Create_Style_Parent_Style_Name
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Parent_Style_Name.Style_Parent_Style_Name_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Parent_Style_Name.Style_Parent_Style_Name_Node;
   end Create_Style_Parent_Style_Name;

   ------------------------------------
   -- Create_Style_Print_Orientation --
   ------------------------------------

   function Create_Style_Print_Orientation
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Print_Orientation.Style_Print_Orientation_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Print_Orientation.Style_Print_Orientation_Node;
   end Create_Style_Print_Orientation;

   -----------------------------------
   -- Create_Style_Punctuation_Wrap --
   -----------------------------------

   function Create_Style_Punctuation_Wrap
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Punctuation_Wrap.Style_Punctuation_Wrap_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Punctuation_Wrap.Style_Punctuation_Wrap_Node;
   end Create_Style_Punctuation_Wrap;

   -----------------------------------
   -- Create_Style_Rel_Column_Width --
   -----------------------------------

   function Create_Style_Rel_Column_Width
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Rel_Column_Width.Style_Rel_Column_Width_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Rel_Column_Width.Style_Rel_Column_Width_Node;
   end Create_Style_Rel_Column_Width;

   ----------------------------
   -- Create_Style_Rel_Width --
   ----------------------------

   function Create_Style_Rel_Width
    (Self : not null access Document_Node'Class)
       return Matreshka.ODF_Attributes.Style.Rel_Width.Style_Rel_Width_Access is
   begin
      return new Matreshka.ODF_Attributes.Style.Rel_Width.Style_Rel_Width_Node;
   end Create_Style_Rel_Width;

--   ------------------------
--   -- Create_Style_Style --
--   ------------------------
--
--   function Create_Style_Style
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Style.Style_Style_Access is
--   begin
--      return new ODF.DOM.Elements.Style.Style.Style_Style;
--   end Create_Style_Style;
--
--   ------------------------------------
--   -- Create_Style_Tab_Stop_Distance --
--   ------------------------------------
--
--   function Create_Style_Tab_Stop_Distance
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Tab_Stop_Distance.Style_Tab_Stop_Distance_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Style.Tab_Stop_Distance.Style_Tab_Stop_Distance;
--   end Create_Style_Tab_Stop_Distance;
--
--   ----------------------------
--   -- Create_Style_Tab_Stops --
--   ----------------------------
--
--   function Create_Style_Tab_Stops
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Tab_Stops.Style_Tab_Stops_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Style.Tab_Stops.Style_Tab_Stops;
--   end Create_Style_Tab_Stops;
--
--   ----------------------------------------
--   -- Create_Style_Table_Cell_Properties --
--   ----------------------------------------
--
--   function Create_Style_Table_Cell_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Table_Cell_Properties.Style_Table_Cell_Properties_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Style.Table_Cell_Properties.Style_Table_Cell_Properties;
--   end Create_Style_Table_Cell_Properties;
--
--   ------------------------------------------
--   -- Create_Style_Table_Column_Properties --
--   ------------------------------------------
--
--   function Create_Style_Table_Column_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Table_Column_Properties.Style_Table_Column_Properties_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Style.Table_Column_Properties.Style_Table_Column_Properties;
--   end Create_Style_Table_Column_Properties;
--
--   -----------------------------------
--   -- Create_Style_Table_Properties --
--   -----------------------------------
--
--   function Create_Style_Table_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Table_Properties.Style_Table_Properties_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Style.Table_Properties.Style_Table_Properties;
--   end Create_Style_Table_Properties;
--
--   ---------------------------------------
--   -- Create_Style_Table_Row_Properties --
--   ---------------------------------------
--
--   function Create_Style_Table_Row_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Table_Row_Properties.Style_Table_Row_Properties_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Style.Table_Row_Properties.Style_Table_Row_Properties;
--   end Create_Style_Table_Row_Properties;
--
--   ---------------------------------
--   -- Create_Style_Text_Autospace --
--   ---------------------------------
--
--   function Create_Style_Text_Autospace
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Text_Autospace.Style_Text_Autospace_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Style.Text_Autospace.Style_Text_Autospace;
--   end Create_Style_Text_Autospace;
--
--   ---------------------------------------
--   -- Create_Style_Text_Underline_Color --
--   ---------------------------------------
--
--   function Create_Style_Text_Underline_Color
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Text_Underline_Color.Style_Text_Underline_Color_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Style.Text_Underline_Color.Style_Text_Underline_Color;
--   end Create_Style_Text_Underline_Color;
--
--   ---------------------------------------
--   -- Create_Style_Text_Underline_Style --
--   ---------------------------------------
--
--   function Create_Style_Text_Underline_Style
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Text_Underline_Style.Style_Text_Underline_Style_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Style.Text_Underline_Style.Style_Text_Underline_Style;
--   end Create_Style_Text_Underline_Style;
--
--   ---------------------------------------
--   -- Create_Style_Text_Underline_Width --
--   ---------------------------------------
--
--   function Create_Style_Text_Underline_Width
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Text_Underline_Width.Style_Text_Underline_Width_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Style.Text_Underline_Width.Style_Text_Underline_Width;
--   end Create_Style_Text_Underline_Width;
--
--   ----------------------------------
--   -- Create_Style_Text_Properties --
--   ----------------------------------
--
--   function Create_Style_Text_Properties
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Style.Text_Properties.Style_Text_Properties_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Style.Text_Properties.Style_Text_Properties;
--   end Create_Style_Text_Properties;
--
--   ----------------------------------------
--   -- Create_Style_Use_Window_Font_Color --
--   ----------------------------------------
--
--   function Create_Style_Use_Window_Font_Color
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Use_Window_Font_Color.Style_Use_Window_Font_Color_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Style.Use_Window_Font_Color.Style_Use_Window_Font_Color;
--   end Create_Style_Use_Window_Font_Color;
--
--   ---------------------------------
--   -- Create_Style_Vertical_Align --
--   ---------------------------------
--
--   function Create_Style_Vertical_Align
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Vertical_Align.Style_Vertical_Align_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Style.Vertical_Align.Style_Vertical_Align;
--   end Create_Style_Vertical_Align;
--
--   ------------------------
--   -- Create_Style_Width --
--   ------------------------
--
--   function Create_Style_Width
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Width.Style_Width_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Style.Width.Style_Width;
--   end Create_Style_Width;
--
--   -------------------------------
--   -- Create_Style_Writing_Mode --
--   -------------------------------
--
--   function Create_Style_Writing_Mode
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Style.Writing_Mode.Style_Writing_Mode_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Style.Writing_Mode.Style_Writing_Mode;
--   end Create_Style_Writing_Mode;
--
--   ----------------------------
--   -- Create_SVG_Font_Family --
--   ----------------------------
--
--   function Create_SVG_Font_Family
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.SVG.Font_Family.ODF_SVG_Font_Family_Access is
--   begin
--      return new Matreshka.ODF_Attributes.SVG.Font_Family.ODF_SVG_Font_Family;
--   end Create_SVG_Font_Family;
--
--   -----------------------------
--   -- Create_SVG_Stroke_Color --
--   -----------------------------
--
--   function Create_SVG_Stroke_Color
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.SVG.Stroke_Color.ODF_SVG_Stroke_Color_Access is
--   begin
--      return new Matreshka.ODF_Attributes.SVG.Stroke_Color.ODF_SVG_Stroke_Color;
--   end Create_SVG_Stroke_Color;
--
--   ------------------------
--   -- Create_Table_Align --
--   ------------------------
--
--   function Create_Table_Align
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Table.Align.ODF_Table_Align_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Table.Align.ODF_Table_Align;
--   end Create_Table_Align;
--
--   -------------------------------
--   -- Create_Table_Border_Model --
--   -------------------------------
--
--   function Create_Table_Border_Model
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Table.Border_Model.ODF_Table_Border_Model_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Table.Border_Model.ODF_Table_Border_Model;
--   end Create_Table_Border_Model;
--
--   -------------------------------------
--   -- Create_Table_Covered_Table_Cell --
--   -------------------------------------
--
--   function Create_Table_Covered_Table_Cell
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Table.Covered_Table_Cell.ODF_Table_Covered_Table_Cell_Access is
--   begin
--      return new ODF.DOM.Elements.Table.Covered_Table_Cell.ODF_Table_Covered_Table_Cell;
--   end Create_Table_Covered_Table_Cell;
--
--   -----------------------
--   -- Create_Table_Name --
--   -----------------------
--
--   function Create_Table_Name
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Table.Name.ODF_Table_Name_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Table.Name.ODF_Table_Name;
--   end Create_Table_Name;
--
--   -----------------------------------------
--   -- Create_Table_Number_Columns_Spanned --
--   -----------------------------------------
--
--   function Create_Table_Number_Columns_Spanned
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Table.Number_Columns_Spanned.ODF_Table_Number_Columns_Spanned_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Table.Number_Columns_Spanned.ODF_Table_Number_Columns_Spanned;
--   end Create_Table_Number_Columns_Spanned;
--
--   -----------------------------
--   -- Create_Table_Style_Name --
--   -----------------------------
--
--   function Create_Table_Style_Name
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Table.Style_Name.ODF_Table_Style_Name_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Table.Style_Name.ODF_Table_Style_Name;
--   end Create_Table_Style_Name;
--
--   ------------------------
--   -- Create_Table_Table --
--   ------------------------
--
--   function Create_Table_Table
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Table.Table.ODF_Table_Table_Access is
--   begin
--      return new ODF.DOM.Elements.Table.Table.ODF_Table_Table;
--   end Create_Table_Table;
--
--   -----------------------------
--   -- Create_Table_Table_Cell --
--   -----------------------------
--
--   function Create_Table_Table_Cell
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell_Access is
--   begin
--      return new ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell;
--   end Create_Table_Table_Cell;
--
--   -------------------------------
--   -- Create_Table_Table_Column --
--   -------------------------------
--
--   function Create_Table_Table_Column
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Table.Table_Column.ODF_Table_Table_Column_Access is
--   begin
--      return new ODF.DOM.Elements.Table.Table_Column.ODF_Table_Table_Column;
--   end Create_Table_Table_Column;
--
--   ----------------------------
--   -- Create_Table_Table_Row --
--   ----------------------------
--
--   function Create_Table_Table_Row
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row_Access is
--   begin
--      return new ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row;
--   end Create_Table_Table_Row;
--
--   ---------------------------------------
--   -- Create_Text_Display_Outline_Level --
--   ---------------------------------------
--
--   function Create_Text_Display_Outline_Level
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Display_Outline_Level.ODF_Text_Display_Outline_Level_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Text.Display_Outline_Level.ODF_Text_Display_Outline_Level;
--   end Create_Text_Display_Outline_Level;
--
--   ------------------------------------
--   -- Create_Text_Footnotes_Position --
--   ------------------------------------
--
--   function Create_Text_Footnotes_Position
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Footnotes_Position.ODF_Text_Footnotes_Position_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Text.Footnotes_Position.ODF_Text_Footnotes_Position;
--   end Create_Text_Footnotes_Position;
--
--   -------------------
--   -- Create_Text_H --
--   -------------------
--
--   function Create_Text_H
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.H.ODF_Text_H_Access is
--   begin
--      return new ODF.DOM.Elements.Text.H.ODF_Text_H;
--   end Create_Text_H;
--
--   ---------------------------
--   -- Create_Text_Increment --
--   ---------------------------
--
--   function Create_Text_Increment
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Increment.ODF_Text_Increment_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Text.Increment.ODF_Text_Increment;
--   end Create_Text_Increment;
--
--   -----------------------------------
--   -- Create_Text_Label_Followed_By --
--   -----------------------------------
--
--   function Create_Text_Label_Followed_By
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Label_Followed_By.ODF_Text_Label_Followed_By_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Text.Label_Followed_By.ODF_Text_Label_Followed_By;
--   end Create_Text_Label_Followed_By;
--
--   -----------------------
--   -- Create_Text_Level --
--   -----------------------
--
--   function Create_Text_Level
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Level.ODF_Text_Level_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Text.Level.ODF_Text_Level;
--   end Create_Text_Level;
--
--   -----------------------------
--   -- Create_Text_Line_Number --
--   -----------------------------
--
--   function Create_Text_Line_Number
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Line_Number.ODF_Text_Line_Number_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Text.Line_Number.ODF_Text_Line_Number;
--   end Create_Text_Line_Number;
--
--   ---------------------------------------------
--   -- Create_Text_Linenumbering_Configuration --
--   ---------------------------------------------
--
--   function Create_Text_Linenumbering_Configuration
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.Linenumbering_Configuration.ODF_Text_Linenumbering_Configuration_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Text.Linenumbering_Configuration.ODF_Text_Linenumbering_Configuration;
--   end Create_Text_Linenumbering_Configuration;
--
--   ----------------------------------------------------
--   -- Create_Text_List_Level_Position_And_Space_Mode --
--   ----------------------------------------------------
--
--   function Create_Text_List_Level_Position_And_Space_Mode
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.List_Level_Position_And_Space_Mode.ODF_Text_List_Level_Position_And_Space_Mode_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Text.List_Level_Position_And_Space_Mode.ODF_Text_List_Level_Position_And_Space_Mode;
--   end Create_Text_List_Level_Position_And_Space_Mode;
--
--   ----------------------------------------
--   -- Create_Text_List_Tab_Stop_Position --
--   ----------------------------------------
--
--   function Create_Text_List_Tab_Stop_Position
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.List_Tab_Stop_Position.ODF_Text_List_Tab_Stop_Position_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Text.List_Tab_Stop_Position.ODF_Text_List_Tab_Stop_Position;
--   end Create_Text_List_Tab_Stop_Position;
--
--   ------------------------------------
--   -- Create_Text_Min_Label_Distance --
--   ------------------------------------
--
--   function Create_Text_Min_Label_Distance
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Min_Label_Distance.ODF_Text_Min_Label_Distance_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Text.Min_Label_Distance.ODF_Text_Min_Label_Distance;
--   end Create_Text_Min_Label_Distance;
--
--   ----------------------
--   -- Create_Text_Name --
--   ----------------------
--
--   function Create_Text_Name
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Name.ODF_Text_Name_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Text.Name.ODF_Text_Name;
--   end Create_Text_Name;
--
--   -------------------------------------
--   -- Create_Text_Notes_Configuration --
--   -------------------------------------
-- 
--   function Create_Text_Notes_Configuration
--     (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.Notes_Configuration.ODF_Text_Notes_Configuration_Access is
--    begin
--       return
--        new ODF.DOM.Elements.Text.Notes_Configuration.ODF_Text_Notes_Configuration;
--   end Create_Text_Notes_Configuration;
-- 
--   ----------------------------
--   -- Create_Text_Note_Class --
--   ----------------------------
--
--   function Create_Text_Note_Class
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Note_Class.ODF_Text_Note_Class_Access is
--   begin
--      return
--        new Matreshka.ODF_Attributes.Text.Note_Class.ODF_Text_Note_Class;
--   end Create_Text_Note_Class;
--
--   ------------------------------
--   -- Create_Text_Number_Lines --
--   ------------------------------
--
--   function Create_Text_Number_Lines
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Number_Lines.ODF_Text_Number_Lines_Access is
--   begin
--      return
--        new Matreshka.ODF_Attributes.Text.Number_Lines.ODF_Text_Number_Lines;
--   end Create_Text_Number_Lines;
--
--   ---------------------------------
--   -- Create_Text_Number_Position --
--   ---------------------------------
--
--   function Create_Text_Number_Position
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Number_Position.ODF_Text_Number_Position_Access is
--   begin
--      return
--        new Matreshka.ODF_Attributes.Text.Number_Position.ODF_Text_Number_Position;
--   end Create_Text_Number_Position;
--
--   ------------------------
--   -- Create_Text_Offset --
--   ------------------------
--
--   function Create_Text_Offset
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Offset.ODF_Text_Offset_Access is
--   begin
--      return
--        new Matreshka.ODF_Attributes.Text.Offset.ODF_Text_Offset;
--   end Create_Text_Offset;
--
--   -------------------------------
--   -- Create_Text_Outline_Level --
--   -------------------------------
--
--   function Create_Text_Outline_Level
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Outline_Level.ODF_Text_Outline_Level_Access is
--   begin
--      return
--        new Matreshka.ODF_Attributes.Text.Outline_Level.ODF_Text_Outline_Level;
--   end Create_Text_Outline_Level;
--
--   -------------------------------------
--   -- Create_Text_Outline_Level_Style --
--   -------------------------------------
--
--   function Create_Text_Outline_Level_Style
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.Outline_Level_Style.ODF_Text_Outline_Level_Style_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Text.Outline_Level_Style.ODF_Text_Outline_Level_Style;
--   end Create_Text_Outline_Level_Style;
--
--   -------------------------------
--   -- Create_Text_Outline_Style --
--   -------------------------------
--
--   function Create_Text_Outline_Style
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.Outline_Style.ODF_Text_Outline_Style_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Text.Outline_Style.ODF_Text_Outline_Style;
--   end Create_Text_Outline_Style;
--
--   -------------------
--   -- Create_Text_P --
--   -------------------
--
--   function Create_Text_P
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.P.ODF_Text_P_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Text.P.ODF_Text_P;
--   end Create_Text_P;
--
--   -------------------------------
--   -- Create_Text_Sequence_Decl --
--   -------------------------------
--
--   function Create_Text_Sequence_Decl
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.Sequence_Decl.ODF_Text_Sequence_Decl_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Text.Sequence_Decl.ODF_Text_Sequence_Decl;
--   end Create_Text_Sequence_Decl;
--
--   --------------------------------
--   -- Create_Text_Sequence_Decls --
--   --------------------------------
--
--   function Create_Text_Sequence_Decls
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.Sequence_Decls.ODF_Text_Sequence_Decls_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Text.Sequence_Decls.ODF_Text_Sequence_Decls;
--   end Create_Text_Sequence_Decls;
--
--   ----------------------
--   -- Create_Text_Span --
--   ----------------------
--
--   function Create_Text_Span
--    (Self : not null access Document_Node'Class)
--       return ODF.DOM.Elements.Text.Span.ODF_Text_Span_Access is
--   begin
--      return
--        new ODF.DOM.Elements.Text.Span.ODF_Text_Span;
--   end Create_Text_Span;
--
--   ------------------------------------
--   -- Create_Text_Start_Numbering_At --
--   ------------------------------------
--
--   function Create_Text_Start_Numbering_At
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Start_Numbering_At.ODF_Text_Start_Numbering_At_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Text.Start_Numbering_At.ODF_Text_Start_Numbering_At;
--   end Create_Text_Start_Numbering_At;
--
--   -----------------------------
--   -- Create_Text_Start_Value --
--   -----------------------------
--
--   function Create_Text_Start_Value
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Start_Value.ODF_Text_Start_Value_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Text.Start_Value.ODF_Text_Start_Value;
--   end Create_Text_Start_Value;
--
--   ----------------------------
--   -- Create_Text_Style_Name --
--   ----------------------------
--
--   function Create_Text_Style_Name
--    (Self : not null access Document_Node'Class)
--       return Matreshka.ODF_Attributes.Text.Style_Name.ODF_Text_Style_Name_Access is
--   begin
--      return new Matreshka.ODF_Attributes.Text.Style_Name.ODF_Text_Style_Name;
--   end Create_Text_Style_Name;

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

end Matreshka.ODF_Documents;
