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
with XML.DOM.Visitors;

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

package ODF.DOM.Visitors is

   type ODF_Visitor is limited interface and XML.DOM.Visitors.Abstract_Visitor;

   not overriding procedure Enter_Office_Automatic_Styles
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Automatic_Styles.ODF_Office_Automatic_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Automatic_Styles
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Automatic_Styles.ODF_Office_Automatic_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Body
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Bodies.ODF_Office_Body_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Body
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Bodies.ODF_Office_Body_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Document_Content
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Document_Content.ODF_Office_Document_Content_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Document_Content
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Document_Content.ODF_Office_Document_Content_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Document_Styles
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Document_Styles.ODF_Office_Document_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Document_Styles
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Document_Styles.ODF_Office_Document_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Font_Face_Decls
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Font_Face_Decls.ODF_Office_Font_Face_Decls_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Font_Face_Decls
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Font_Face_Decls.ODF_Office_Font_Face_Decls_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Master_Styles
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Master_Styles.ODF_Office_Master_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Master_Styles
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Master_Styles.ODF_Office_Master_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Scripts
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Scripts.ODF_Office_Scripts_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Scripts
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Scripts.ODF_Office_Scripts_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Styles
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Styles.ODF_Office_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Styles
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Styles.ODF_Office_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Text
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Text.ODF_Office_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Text
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Office.Text.ODF_Office_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Background_Image
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Background_Image.ODF_Style_Background_Image_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Background_Image
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Background_Image.ODF_Style_Background_Image_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Default_Style
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Default_Style
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Font_Face
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Font_Face.ODF_Style_Font_Face_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Font_Face
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Font_Face.ODF_Style_Font_Face_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Footer_Style
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Footer_Style.ODF_Style_Footer_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Footer_Style
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Footer_Style.ODF_Style_Footer_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Footnote_Sep
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Footnote_Sep.ODF_Style_Footnote_Sep_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Footnote_Sep
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Footnote_Sep.ODF_Style_Footnote_Sep_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Graphic_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Graphic_Properties.ODF_Style_Graphic_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Graphic_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Graphic_Properties.ODF_Style_Graphic_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Header_Style
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Header_Style.ODF_Style_Header_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Header_Style
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Header_Style.ODF_Style_Header_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_List_Level_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.List_Level_Properties.ODF_Style_List_Level_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_List_Level_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.List_Level_Properties.ODF_Style_List_Level_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Master_Page
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Master_Page.ODF_Style_Master_Page_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Master_Page
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Master_Page.ODF_Style_Master_Page_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Page_Layout
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Page_Layout.ODF_Style_Page_Layout_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Page_Layout
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Page_Layout.ODF_Style_Page_Layout_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Page_Layout_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Page_Layout_Properties.ODF_Style_Page_Layout_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Page_Layout_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Page_Layout_Properties.ODF_Style_Page_Layout_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Paragraph_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Paragraph_Properties.ODF_Style_Paragraph_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Paragraph_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Paragraph_Properties.ODF_Style_Paragraph_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Style
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Style.ODF_Style_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Style
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Style.ODF_Style_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Tab_Stops
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Tab_Stops.ODF_Style_Tab_Stops_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Tab_Stops
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Tab_Stops.ODF_Style_Tab_Stops_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Table_Cell_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Table_Cell_Properties.ODF_Style_Table_Cell_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Table_Cell_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Table_Cell_Properties.ODF_Style_Table_Cell_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Table_Column_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Table_Column_Properties.ODF_Style_Table_Column_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Table_Column_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Table_Column_Properties.ODF_Style_Table_Column_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Table_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Table_Properties.ODF_Style_Table_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Table_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Table_Properties.ODF_Style_Table_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Table_Row_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Table_Row_Properties.ODF_Style_Table_Row_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Table_Row_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Table_Row_Properties.ODF_Style_Table_Row_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Text_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Text_Properties.ODF_Style_Text_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Text_Properties
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Style.Text_Properties.ODF_Style_Text_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Covered_Table_Cell
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Table.Covered_Table_Cell.ODF_Table_Covered_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Covered_Table_Cell
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Table.Covered_Table_Cell.ODF_Table_Covered_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Table.Table.ODF_Table_Table_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Table.Table.ODF_Table_Table_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table_Cell
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table_Cell
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table_Column
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Table.Table_Column.ODF_Table_Table_Column_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table_Column
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Table.Table_Column.ODF_Table_Table_Column_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table_Row
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table_Row
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Linenumbering_Configuration
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.Linenumbering_Configuration.ODF_Text_Linenumbering_Configuration_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Linenumbering_Configuration
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.Linenumbering_Configuration.ODF_Text_Linenumbering_Configuration_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Notes_Configuration
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.Notes_Configuration.ODF_Text_Notes_Configuration_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Notes_Configuration
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.Notes_Configuration.ODF_Text_Notes_Configuration_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Outline_Level_Style
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.Outline_Level_Style.ODF_Text_Outline_Level_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Outline_Level_Style
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.Outline_Level_Style.ODF_Text_Outline_Level_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Outline_Style
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.Outline_Style.ODF_Text_Outline_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Outline_Style
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.Outline_Style.ODF_Text_Outline_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_P
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.P.ODF_Text_P_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_P
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.P.ODF_Text_P_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sequence_Decl
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.Sequence_Decl.ODF_Text_Sequence_Decl_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sequence_Decl
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.Sequence_Decl.ODF_Text_Sequence_Decl_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sequence_Decls
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.Sequence_Decls.ODF_Text_Sequence_Decls_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sequence_Decls
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.Sequence_Decls.ODF_Text_Sequence_Decls_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Span
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.Span.ODF_Text_Span_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Span
    (Self    : in out ODF_Visitor;
     Element : not null ODF.DOM.Elements.Text.Span.ODF_Text_Span_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

end ODF.DOM.Visitors;
