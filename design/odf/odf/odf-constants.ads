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

   FO_URI     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0");
   Office_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:office:1.0");
   Style_URI  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:style:1.0");
   SVG_URI    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0");
   Table_URI  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:table:1.0");
   Text_URI   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:text:1.0");

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
   Border_Right_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-right");
   Border_Top_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-top");
   Column_Width_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column-width");
   Country_Name                     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("country");
   Covered_Table_Cell_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("covered-table-cell");
   Default_Style_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("default-style");
   Display_Outline_Level_Name       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-outline-level");
   Document_Content_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("document-content");
   Document_Styles_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("document-styles");
   Family_Name                      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("family");
   Font_Face_Decls_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-face-decls");
   Font_Family_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-family");
   Font_Family_Generic_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-family-generic");
   Font_Name_Name                   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-name");
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
   Footnote_Sep_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footnote-sep");
   Graphic_Properties_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("graphic-properties");
   Header_Style_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("header-style");
   Justify_Single_Word_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("justify-single-word");
   Language_Name                    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("language");
   Linenumbering_Configuration_Name : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("linenumbering-configuration");
   List_Level_Properties_Name       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level-properties");
   Master_Page_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("master-page");
   Master_Styles_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("master-styles");
   Name_Name                        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("name");
   Notes_Configuration_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("notes-configuration");
   Number_Columns_Spanned_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number-columns-spanned");
   Outline_Style_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("outline-style");
   Outline_Level_Style_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("outline-level-style");
   P_Name                           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("p");
   Padding_Name                     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("padding");
   Page_Layout_Properties_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-layout-properties");
   Page_Layout_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-layout");
   Paragraph_Properties_Name        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("paragraph-properties");
   Parent_Style_Name_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("parent-style-name");
   Rel_Column_Width_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rel-column-width");
   Sequence_Decl_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sequence-decl");
   Sequence_Decls_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sequence-decls");
   Scripts_Name                     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scripts");
   Span_Name                        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("span");
   Style_Name                       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("style");
   Style_Name_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("style-name");
   Styles_Name                      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("styles");
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
   Text_Align_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-align");
   Text_Properties_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-properties");
   Value_Type_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("value-type");
   Version_Name                     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("version");
   Vertical_Align_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("vertical-align");
   Width_Name                       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("width");

end ODF.Constants;
