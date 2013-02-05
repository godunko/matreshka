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
with Ada.Containers.Vectors;
with Ada.Text_IO; use Ada.Text_IO;

with GNATCOLL.JSON;

with XML.DOM.Nodes.Character_Datas.Texts;
with XML.DOM.Visitors;

--    with ODF.DOM.Elements.Office.Automatic_Styles;
with ODF.DOM.Elements.Office.Bodies;
with ODF.DOM.Elements.Office.Document_Content;
--    with ODF.DOM.Elements.Office.Document_Styles;
--    with ODF.DOM.Elements.Office.Font_Face_Decls;
--    with ODF.DOM.Elements.Office.Master_Styles;
--    with ODF.DOM.Elements.Office.Scripts;
--    with ODF.DOM.Elements.Office.Styles;
with ODF.DOM.Elements.Office.Text;
--    with ODF.DOM.Elements.Style.Background_Image;
--    with ODF.DOM.Elements.Style.Default_Style;
--    with ODF.DOM.Elements.Style.Font_Face;
--    with ODF.DOM.Elements.Style.Footer_Style;
--    with ODF.DOM.Elements.Style.Footnote_Sep;
--    with ODF.DOM.Elements.Style.Graphic_Properties;
--    with ODF.DOM.Elements.Style.Header_Style;
--    with ODF.DOM.Elements.Style.List_Level_Properties;
--    with ODF.DOM.Elements.Style.Master_Page;
--    with ODF.DOM.Elements.Style.Page_Layout;
--    with ODF.DOM.Elements.Style.Page_Layout_Properties;
--    with ODF.DOM.Elements.Style.Paragraph_Properties;
--    with ODF.DOM.Elements.Style.Style;
--    with ODF.DOM.Elements.Style.Tab_Stops;
--    with ODF.DOM.Elements.Style.Table_Cell_Properties;
--    with ODF.DOM.Elements.Style.Table_Column_Properties;
--    with ODF.DOM.Elements.Style.Table_Properties;
--    with ODF.DOM.Elements.Style.Table_Row_Properties;
--    with ODF.DOM.Elements.Style.Text_Properties;
--    with ODF.DOM.Elements.Table.Covered_Table_Cell;
with ODF.DOM.Elements.Table.Table;
with ODF.DOM.Elements.Table.Table_Cell;
--    with ODF.DOM.Elements.Table.Table_Column;
with ODF.DOM.Elements.Table.Table_Row;
--    with ODF.DOM.Elements.Text.Linenumbering_Configuration;
--    with ODF.DOM.Elements.Text.Notes_Configuration;
--    with ODF.DOM.Elements.Text.Outline_Level_Style;
--    with ODF.DOM.Elements.Text.Outline_Style;
with ODF.DOM.Elements.Text.P;
--    with ODF.DOM.Elements.Text.Sequence_Decl;
with ODF.DOM.Elements.Text.Sequence_Decls;
with ODF.DOM.Elements.Text.Span;
with ODF.DOM.Iterators;
with ODF.DOM.Visitors;

package body ODF.Web is

   type State_Record is record
      Object   : GNATCOLL.JSON.JSON_Value;
      Children : GNATCOLL.JSON.JSON_Array;
   end record;

   package State_Vectors is
     new Ada.Containers.Vectors (Positive, State_Record);
   
   type JSON_Builder is limited new ODF.DOM.Visitors.ODF_Visitor with record
      Current  : State_Record;
      Previous : State_Record;
      Stack    : State_Vectors.Vector;
   end record;

   procedure Push (Self : in out JSON_Builder'Class);

   procedure Pop (Self : in out JSON_Builder'Class);

   procedure Done (Self : in out JSON_Builder'Class);

   procedure Initialize (Self : in out JSON_Builder'Class);

--       overriding procedure Enter_Office_Automatic_Styles
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Automatic_Styles.ODF_Office_Automatic_Styles_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Office_Automatic_Styles
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Automatic_Styles.ODF_Office_Automatic_Styles_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Office_Body
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Bodies.ODF_Office_Body_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Office_Body
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Bodies.ODF_Office_Body_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Office_Document_Content
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Document_Content.ODF_Office_Document_Content_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Office_Document_Content
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Document_Content.ODF_Office_Document_Content_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Office_Document_Styles
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Document_Styles.ODF_Office_Document_Styles_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Office_Document_Styles
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Document_Styles.ODF_Office_Document_Styles_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Office_Font_Face_Decls
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Font_Face_Decls.ODF_Office_Font_Face_Decls_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Office_Font_Face_Decls
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Font_Face_Decls.ODF_Office_Font_Face_Decls_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Office_Master_Styles
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Master_Styles.ODF_Office_Master_Styles_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Office_Master_Styles
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Master_Styles.ODF_Office_Master_Styles_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Office_Scripts
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Scripts.ODF_Office_Scripts_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Office_Scripts
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Scripts.ODF_Office_Scripts_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Office_Styles
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Styles.ODF_Office_Styles_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Office_Styles
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Office.Styles.ODF_Office_Styles_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Office_Text
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Office.Text.ODF_Office_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Office_Text
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Office.Text.ODF_Office_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

--       overriding procedure Enter_Style_Background_Image
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Background_Image.ODF_Style_Background_Image_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Background_Image
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Background_Image.ODF_Style_Background_Image_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Default_Style
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Default_Style
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Font_Face
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Font_Face.ODF_Style_Font_Face_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Font_Face
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Font_Face.ODF_Style_Font_Face_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Footer_Style
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Footer_Style.ODF_Style_Footer_Style_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Footer_Style
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Footer_Style.ODF_Style_Footer_Style_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Footnote_Sep
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Footnote_Sep.ODF_Style_Footnote_Sep_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Footnote_Sep
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Footnote_Sep.ODF_Style_Footnote_Sep_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Graphic_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Graphic_Properties.ODF_Style_Graphic_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Graphic_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Graphic_Properties.ODF_Style_Graphic_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Header_Style
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Header_Style.ODF_Style_Header_Style_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Header_Style
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Header_Style.ODF_Style_Header_Style_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_List_Level_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.List_Level_Properties.ODF_Style_List_Level_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_List_Level_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.List_Level_Properties.ODF_Style_List_Level_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Master_Page
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Master_Page.ODF_Style_Master_Page_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Master_Page
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Master_Page.ODF_Style_Master_Page_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Page_Layout
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Page_Layout.ODF_Style_Page_Layout_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Page_Layout
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Page_Layout.ODF_Style_Page_Layout_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Page_Layout_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Page_Layout_Properties.ODF_Style_Page_Layout_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Page_Layout_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Page_Layout_Properties.ODF_Style_Page_Layout_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Paragraph_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Paragraph_Properties.ODF_Style_Paragraph_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Paragraph_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Paragraph_Properties.ODF_Style_Paragraph_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Style
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Style.ODF_Style_Style_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Style
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Style.ODF_Style_Style_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Tab_Stops
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Tab_Stops.ODF_Style_Tab_Stops_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Tab_Stops
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Tab_Stops.ODF_Style_Tab_Stops_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Table_Cell_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Table_Cell_Properties.ODF_Style_Table_Cell_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Table_Cell_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Table_Cell_Properties.ODF_Style_Table_Cell_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Table_Column_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Table_Column_Properties.ODF_Style_Table_Column_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Table_Column_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Table_Column_Properties.ODF_Style_Table_Column_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Table_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Table_Properties.ODF_Style_Table_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Table_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Table_Properties.ODF_Style_Table_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Table_Row_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Table_Row_Properties.ODF_Style_Table_Row_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Table_Row_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Table_Row_Properties.ODF_Style_Table_Row_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Style_Text_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Text_Properties.ODF_Style_Text_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Style_Text_Properties
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Style.Text_Properties.ODF_Style_Text_Properties_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Table_Covered_Table_Cell
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Table.Covered_Table_Cell.ODF_Table_Covered_Table_Cell_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Table_Covered_Table_Cell
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Table.Covered_Table_Cell.ODF_Table_Covered_Table_Cell_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Table_Table
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table.ODF_Table_Table_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Table_Table
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table.ODF_Table_Table_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Table_Table_Cell
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Table_Table_Cell
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

--       overriding procedure Enter_Table_Table_Column
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Table.Table_Column.ODF_Table_Table_Column_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Table_Table_Column
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Table.Table_Column.ODF_Table_Table_Column_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Table_Table_Row
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Table_Table_Row
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

--       overriding procedure Enter_Text_Linenumbering_Configuration
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Text.Linenumbering_Configuration.ODF_Text_Linenumbering_Configuration_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Text_Linenumbering_Configuration
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Text.Linenumbering_Configuration.ODF_Text_Linenumbering_Configuration_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Text_Notes_Configuration
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Text.Notes_Configuration.ODF_Text_Notes_Configuration_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Text_Notes_Configuration
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Text.Notes_Configuration.ODF_Text_Notes_Configuration_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Text_Outline_Level_Style
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Text.Outline_Level_Style.ODF_Text_Outline_Level_Style_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Text_Outline_Level_Style
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Text.Outline_Level_Style.ODF_Text_Outline_Level_Style_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Enter_Text_Outline_Style
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Text.Outline_Style.ODF_Text_Outline_Style_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Text_Outline_Style
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Text.Outline_Style.ODF_Text_Outline_Style_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Text_P
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Text.P.ODF_Text_P_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Text_P
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Text.P.ODF_Text_P_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

--       overriding procedure Enter_Text_Sequence_Decl
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Text.Sequence_Decl.ODF_Text_Sequence_Decl_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);
--    
--       overriding procedure Leave_Text_Sequence_Decl
--        (Self    : in out JSON_Builder;
--         Element : not null ODF.DOM.Elements.Text.Sequence_Decl.ODF_Text_Sequence_Decl_Access;
--         Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Text_Sequence_Decls
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Text.Sequence_Decls.ODF_Text_Sequence_Decls_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   overriding procedure Leave_Text_Sequence_Decls
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Text.Sequence_Decls.ODF_Text_Sequence_Decls_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   overriding procedure Enter_Text_Span
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Text.Span.ODF_Text_Span_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Text_Span
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Text.Span.ODF_Text_Span_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Text
    (Self    : in out JSON_Builder;
     Element : not null XML.DOM.Nodes.Character_Datas.Texts.DOM_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Text
    (Self    : in out JSON_Builder;
     Element : not null XML.DOM.Nodes.Character_Datas.Texts.DOM_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   use type XML.DOM.Nodes.DOM_Node_Access;

   Json_Mime_Type : constant String := "application/json";

   --------------
   -- Callback --
   --------------

   function Callback (Request : AWS.Status.Data) return AWS.Response.Data is
   begin
      return
        AWS.Response.Build
         (JSON_Mime_Type, To_JSON (Document.Styles, Document.Content));
   end Callback;

   ----------
   -- Done --
   ----------

   procedure Done (Self : in out JSON_Builder'Class) is
   begin
      Self.Current.Object.Set_Field ("children", Self.Current.Children);
   end Done;

   -----------------------
   -- Enter_Office_Text --
   -----------------------

   overriding procedure Enter_Office_Text
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Office.Text.ODF_Office_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Push;
      Self.Current.Object.Set_Field ("__type", "OdfOfficeText");
   end Enter_Office_Text;

   -----------------------
   -- Enter_Table_Table --
   -----------------------

   overriding procedure Enter_Table_Table
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table.ODF_Table_Table_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Push;
      Self.Current.Object.Set_Field ("__type", "OdfTableTable");
   end Enter_Table_Table;

   ----------------------------
   -- Enter_Table_Table_Cell --
   ----------------------------

   overriding procedure Enter_Table_Table_Cell
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Push;
      Self.Current.Object.Set_Field ("__type", "OdfTableTableCell");
   end Enter_Table_Table_Cell;

   ---------------------------
   -- Enter_Table_Table_Row --
   ---------------------------

   overriding procedure Enter_Table_Table_Row
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Push;
      Self.Current.Object.Set_Field ("__type", "OdfTableTableRow");
   end Enter_Table_Table_Row;

   ----------------
   -- Enter_Text --
   ----------------

   overriding procedure Enter_Text
    (Self    : in out JSON_Builder;
     Element : not null XML.DOM.Nodes.Character_Datas.Texts.DOM_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Push;
      Self.Current.Object :=
        GNATCOLL.JSON.Create (Element.Get_Data.To_UTF_8_String);
   end Enter_Text;

   ------------------
   -- Enter_Text_P --
   ------------------

   overriding procedure Enter_Text_P
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Text.P.ODF_Text_P_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Push;
      Self.Current.Object.Set_Field ("__type", "OdfTextP");
   end Enter_Text_P;

   ---------------------
   -- Enter_Text_Span --
   ---------------------

   overriding procedure Enter_Text_Span
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Text.Span.ODF_Text_Span_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Push;
      Self.Current.Object.Set_Field ("__type", "OdfTextSpan");
   end Enter_Text_Span;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out JSON_Builder'Class) is
   begin
      Self.Current :=
       (GNATCOLL.JSON.Create_Object,
        GNATCOLL.JSON.Empty_Array);
      Self.Current.Object.Set_Field ("__type", "OdfDocument");
   end Initialize;

   -----------------------
   -- Leave_Office_Text --
   -----------------------

   overriding procedure Leave_Office_Text
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Elements.Office.Text.ODF_Office_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Current.Object.Set_Field ("children", Self.Current.Children);
      GNATCOLL.JSON.Append (Self.Previous.Children, Self.Current.Object);
      Self.Pop;
   end Leave_Office_Text;

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
         Self.Previous :=
          (GNATCOLL.JSON.JSON_Null,
           GNATCOLL.JSON.Empty_Array);
      end if;
   end Pop;

   ----------
   -- Push --
   ----------

   procedure Push (Self : in out JSON_Builder'Class) is
   begin
      Self.Stack.Append (Self.Previous);
      Self.Previous := Self.Current;
      Self.Current :=
       (GNATCOLL.JSON.Create_Object,
        GNATCOLL.JSON.Empty_Array);
   end Push;

   -------------
   -- To_JSON --
   -------------

   function To_JSON
    (Styles  : not null ODF.DOM.Documents.ODF_Document_Access;
     Content : not null ODF.DOM.Documents.ODF_Document_Access)
       return String
   is
      Builder  : JSON_Builder;
      Iterator : ODF.DOM.Iterators.ODF_Iterator;
      Control  : XML.DOM.Visitors.Traverse_Control
        := XML.DOM.Visitors.Continue;

   begin
      Builder.Initialize;
      Iterator.Visit (Builder, Styles.Get_First_Child, Control);
      Iterator.Visit (Builder, Content.Get_First_Child, Control);
      Builder.Done;
      --  XXX It is better to use 'element' instead of 'firstChild'.

      return GNATCOLL.JSON.Write (Builder.Current.Object);
   end To_JSON;

end ODF.Web;
