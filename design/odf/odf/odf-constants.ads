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

   Office_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:office:1.0");
   Style_URI  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:style:1.0");
   Table_URI  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:table:1.0");
   Text_URI   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:text:1.0");

   Automatic_Styles_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("automatic-styles");
   Background_Image_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("background-image");
   Body_Name                        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("body");
   Covered_Table_Cell_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("covered-table-cell");
   Default_Style_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("default-style");
   Document_Content_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("document-content");
   Document_Styles_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("document-styles");
   Font_Face_Decls_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-face-decls");
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
   Linenumbering_Configuration_Name : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("linenumbering-configuration");
   List_Level_Properties_Name       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level-properties");
   Master_Page_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("master-page");
   Master_Styles_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("master-styles");
   Notes_Configuration_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("notes-configuration");
   Outline_Style_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("outline-style");
   Outline_Level_Style_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("outline-level-style");
   P_Name                           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("p");
   Page_Layout_Properties_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-layout-properties");
   Page_Layout_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-layout");
   Paragraph_Properties_Name        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("paragraph-properties");
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
   Text_Properties_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-properties");

end ODF.Constants;
