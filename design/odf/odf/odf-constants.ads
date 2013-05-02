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

package ODF.Constants is

   Anim_URI         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:animation:1.0");
   Chart_URI        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:chart:1.0");
   Config_URI       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:config:1.0");
   DB_URI           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:database:1.0");
   DR3D_URI         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0");
   Draw_URI         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:drawing:1.0");
   FO_URI           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0");
   Form_URI         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:form:1.0");
   Manifest_URI     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:manifest:1.0");
   Meta_URI         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:meta:1.0");
   Number_URI       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0");
   Odf_URI          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://docs.oasis-open.org/ns/office/1.2/meta/odf#");
   OF_URI           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:of:1.2");
   Office_URI       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:office:1.0");
   Pkg_URI          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://docs.oasis-open.org/ns/office/1.2/meta/pkg#");
   Presentation_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:presentation:1.0");
   Script_URI       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:script:1.0");
   Smil_URI         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:smil-compatible:1.0");
   SVG_URI          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0");
   Style_URI        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:style:1.0");
   Table_URI        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:table:1.0");
   Text_URI         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:text:1.0");

   Adjustment_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("adjustment");
   Align_Name                       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("align");
   Automatic_Styles_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("automatic-styles");
   Background_Color_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("background-color");
   Background_Image_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("background-image");
   Body_Name                        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("body");
   Border_Name                      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border");
   Border_Bottom_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-bottom");
   Border_Left_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-left");
   Border_Model_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-model");
   Border_Right_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-right");
   Border_Top_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-top");
   Class_Name                       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("class");
   Color_Name                       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("color");
   Column_Width_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column-width");
   Contextual_Spacing_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("contextual-spacing");
   Country_Name                     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("country");
   Country_Asian_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("country-asian");
   Country_Complex_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("country-complex");
   Covered_Table_Cell_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("covered-table-cell");
   Default_Outline_Level_Name       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("default-outline-level");
   Default_Style_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("default-style");
   Display_Name_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-name");
   Display_Outline_Level_Name       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-outline-level");
   Distance_After_Sep_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("distance-after-sep");
   Distance_Before_Sep_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("distance-before-sep");
   Document_Content_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("document-content");
   Document_Styles_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("document-styles");
   End_Line_Spacing_Horizontal_Name : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-line-spacing-horizontal");
   End_Line_Spacing_Vertical_Name   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-line-spacing-vertical");
   Family_Name                      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("family");
   Fill_Color_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fill-color");
   Flow_With_Text_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("flow-with-text");
   Font_Face_Decls_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-face-decls");
   Font_Family_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-family");
   Font_Family_Generic_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-family-generic");
   Font_Independent_Line_Spacing_Name :
     constant League.Strings.Universal_String
       := League.Strings.To_Universal_String ("font-independent-line-spacing");
   Font_Name_Name                   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-name");
   Font_Name_Asian_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-name-asian");
   Font_Name_Complex_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-name-complex");
   Font_Pitch_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-pitch");
   Font_Size_Name                   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-size");
   Font_Size_Asian_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-size-asian");
   Font_Size_Complex_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-size-complex");
   Font_Style_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-style");
   Font_Style_Asian_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-style-asian");
   Font_Style_Complex_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-style-complex");
   Font_Weight_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-weight");
   Font_Weight_Asian_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-weight-asian");
   Font_Weight_Complex_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-weight-complex");
   Footer_Style_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footer-style");
   Font_Face_Name                   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-face");
   Footnote_Max_Height_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footnote-max-height");
   Footnote_Sep_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footnote-sep");
   Footnotes_Position_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footnotes-position");
   Graphic_Properties_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("graphic-properties");
   H_Name                           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("h");
   Header_Style_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("header-style");
   Hyphenate_Name                   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hyphenate");
   Hyphenation_Ladder_Count_Name    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hyphenation-ladder-count");
   Hyphenation_Push_Char_Count_Name : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hyphenation-push-char-count");
   Hyphenation_Remain_Char_Count_Name :
     constant League.Strings.Universal_String
       := League.Strings.To_Universal_String ("hyphenation-remain-char-count");
   Increment_Name                   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("increment");
   Justify_Single_Word_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("justify-single-word");
   Keep_Together_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("keep-together");
   Keep_With_Next_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("keep-with-next");
   Label_Followed_By_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("label-followed-by");
   Language_Name                    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("language");
   Language_Asian_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("language-asian");
   Language_Complex_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("language-complex");
   Letter_Kerning_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("letter-kerning");
   Level_Name                       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("level");
   Line_Break_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("line-break");
   Line_Number_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("line-number");
   Line_Style_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("line-style");
   Linenumbering_Configuration_Name : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("linenumbering-configuration");
   List_Level_Label_Alignment_Name  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level-label-alignment");
   List_Level_Position_And_Space_Mode_Name :
     constant League.Strings.Universal_String
       := League.Strings.To_Universal_String
           ("list-level-position-and-space-mode");
   List_Level_Properties_Name       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level-properties");
   List_Tab_Stop_Position_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-tab-stop-position");
   Margin_Name                      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("margin");
   Margin_Bottom_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("margin-bottom");
   Margin_Left_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("margin-left");
   Margin_Right_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("margin-right");
   Margin_Top_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("margin-top");
   Master_Page_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("master-page");
   Master_Styles_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("master-styles");
   Min_Label_Distance_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("min-label-distance");
   Name_Name                        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("name");
   Next_Style_Name_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("next-style-name");
   Note_Class_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("note-class");
   Notes_Configuration_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("notes-configuration");
   Num_Format_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("num-format");
   Number_Columns_Spanned_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number-columns-spanned");
   Number_Lines_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number-lines");
   Number_Position_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number-position");
   Offset_Name                      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("offset");
   Outline_Level_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("outline-level");
   Outline_Level_Style_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("outline-level-style");
   Outline_Style_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("outline-style");
   P_Name                           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("p");
   Padding_Name                     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("padding");
   Page_Height_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-height");
   Page_Layout_Name_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-layout-name");
   Page_Layout_Properties_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-layout-properties");
   Page_Layout_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-layout");
   Page_Width_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-width");
   Paragraph_Properties_Name        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("paragraph-properties");
   Parent_Style_Name_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("parent-style-name");
   Print_Orientation_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("print-orientation");
   Punctuation_Wrap_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("punctuation-wrap");
   Rel_Column_Width_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rel-column-width");
   Rel_Width_Name                   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rel-width");
   Sequence_Decl_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sequence-decl");
   Sequence_Decls_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sequence-decls");
   Scripts_Name                     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scripts");
   Shadow_Offset_X_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("shadow-offset-x");
   Shadow_Offset_Y_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("shadow-offset-y");
   Span_Name                        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("span");
   Start_Line_Spacing_Horizontal_Name :
     constant League.Strings.Universal_String
       := League.Strings.To_Universal_String ("start-line-spacing-horizontal");
   Start_Line_Spacing_Vertical_Name : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-line-spacing-vertical");
   Start_Numbering_At_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-numbering-at");
   Start_Value_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-value");
   Stroke_Color_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stroke-color");
   Style_Name                       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("style");
   Style_Name_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("style-name");
   Styles_Name                      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("styles");
   Tab_Stop_Distance_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tab-stop-distance");
   Tab_Stops_Name                   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tab-stops");
   Table_Name                       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table");
   Table_Cell_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-cell");
   Table_Cell_Properties_Name       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-cell-properties");
   Table_Column_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-column");
   Table_Column_Properties_Name     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-column-properties");
   Table_Properties_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-properties");
   Table_Row_Name                   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-row");
   Table_Row_Properties_Name        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-row-properties");
   Text_Name                        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text");
   Text_Indent_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-indent");
   Text_Align_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-align");
   Text_Autospace_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-autospace");
   Text_Properties_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-properties");
   Text_Underline_Color_Name        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-underline-color");
   Text_Underline_Style_Name        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-underline-style");
   Text_Underline_Width_Name        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-underline-width");
   Use_Window_Font_Color_Name       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-window-font-color");
   Value_Type_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("value-type");
   Version_Name                     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("version");
   Vertical_Align_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("vertical-align");
   Width_Name                       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("width");
   Wrap_Option_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("wrap-option");
   Writing_Mode_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("writing-mode");

end ODF.Constants;
