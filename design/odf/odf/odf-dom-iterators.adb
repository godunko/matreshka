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

package body ODF.DOM.Iterators is

   -------------------
   -- Visit_Element --
   -------------------

   overriding procedure Visit_Element
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null XML.DOM.Nodes.Elements.DOM_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control)
   is
      use type XML.DOM.Nodes.DOM_Node_Access;

      Node : XML.DOM.Nodes.DOM_Node_Access := Element.Get_First_Child;

   begin
      while Node /= null loop
         Self.Visit (Visitor, Node, Control);
         Node := Node.Get_Next_Sibling;
      end loop;
   end Visit_Element;

   -----------------------------------
   -- Visit_Office_Automatic_Styles --
   -----------------------------------

   not overriding procedure Visit_Office_Automatic_Styles
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Office.Automatic_Styles.ODF_Office_Automatic_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Office_Automatic_Styles;

   -----------------------
   -- Visit_Office_Body --
   -----------------------

   not overriding procedure Visit_Office_Body
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Office.Bodies.ODF_Office_Body_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Office_Body;

   -----------------------------------
   -- Visit_Office_Document_Content --
   -----------------------------------

   not overriding procedure Visit_Office_Document_Content
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Office.Document_Content.ODF_Office_Document_Content_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Office_Document_Content;

   ----------------------------------
   -- Visit_Office_Document_Styles --
   ----------------------------------

   not overriding procedure Visit_Office_Document_Styles
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Office.Document_Styles.ODF_Office_Document_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Office_Document_Styles;

   ----------------------------------
   -- Visit_Office_Font_Face_Decls --
   ----------------------------------

   not overriding procedure Visit_Office_Font_Face_Decls
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Office.Font_Face_Decls.ODF_Office_Font_Face_Decls_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Office_Font_Face_Decls;

   --------------------------------
   -- Visit_Office_Master_Styles --
   --------------------------------

   not overriding procedure Visit_Office_Master_Styles
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Office.Master_Styles.ODF_Office_Master_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Office_Master_Styles;

   --------------------------
   -- Visit_Office_Scripts --
   --------------------------

   not overriding procedure Visit_Office_Scripts
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Office.Scripts.ODF_Office_Scripts_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Office_Scripts;

   -------------------------
   -- Visit_Office_Styles --
   -------------------------

   not overriding procedure Visit_Office_Styles
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Office.Styles.ODF_Office_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Office_Styles;

   -----------------------
   -- Visit_Office_Text --
   -----------------------

   not overriding procedure Visit_Office_Text
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Office.Text.ODF_Office_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Office_Text;

   ----------------------------------
   -- Visit_Style_Background_Image --
   ----------------------------------

   not overriding procedure Visit_Style_Background_Image
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Background_Image.ODF_Style_Background_Image_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Background_Image;

   -------------------------------
   -- Visit_Style_Default_Style --
   -------------------------------

   not overriding procedure Visit_Style_Default_Style
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Default_Style;

   ---------------------------
   -- Visit_Style_Font_Face --
   ---------------------------

   not overriding procedure Visit_Style_Font_Face
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Font_Face.ODF_Style_Font_Face_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Font_Face;

   ------------------------------
   -- Visit_Style_Footer_Style --
   ------------------------------

   not overriding procedure Visit_Style_Footer_Style
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Footer_Style.ODF_Style_Footer_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Footer_Style;

   ------------------------------
   -- Visit_Style_Footnote_Sep --
   ------------------------------

   not overriding procedure Visit_Style_Footnote_Sep
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Footnote_Sep.ODF_Style_Footnote_Sep_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Footnote_Sep;

   ------------------------------------
   -- Visit_Style_Graphic_Properties --
   ------------------------------------

   not overriding procedure Visit_Style_Graphic_Properties
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Graphic_Properties.ODF_Style_Graphic_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Graphic_Properties;

   ------------------------------
   -- Visit_Style_Header_Style --
   ------------------------------

   not overriding procedure Visit_Style_Header_Style
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Header_Style.ODF_Style_Header_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Header_Style;

   ---------------------------------------
   -- Visit_Style_List_Level_Properties --
   ---------------------------------------

   not overriding procedure Visit_Style_List_Level_Properties
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.List_Level_Properties.ODF_Style_List_Level_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_List_Level_Properties;

   -----------------------------
   -- Visit_Style_Master_Page --
   -----------------------------

   not overriding procedure Visit_Style_Master_Page
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Master_Page.ODF_Style_Master_Page_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Master_Page;

   -----------------------------
   -- Visit_Style_Page_Layout --
   -----------------------------

   not overriding procedure Visit_Style_Page_Layout
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Page_Layout.ODF_Style_Page_Layout_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Page_Layout;

   ----------------------------------------
   -- Visit_Style_Page_Layout_Properties --
   ----------------------------------------

   not overriding procedure Visit_Style_Page_Layout_Properties
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Page_Layout_Properties.ODF_Style_Page_Layout_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Page_Layout_Properties;

   --------------------------------------
   -- Visit_Style_Paragraph_Properties --
   --------------------------------------

   not overriding procedure Visit_Style_Paragraph_Properties
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Paragraph_Properties.ODF_Style_Paragraph_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Paragraph_Properties;

   -----------------------
   -- Visit_Style_Style --
   -----------------------

   not overriding procedure Visit_Style_Style
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Style.ODF_Style_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Style;

   ---------------------------
   -- Visit_Style_Tab_Stops --
   ---------------------------

   not overriding procedure Visit_Style_Tab_Stops
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Tab_Stops.ODF_Style_Tab_Stops_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Tab_Stops;

   ---------------------------------------
   -- Visit_Style_Table_Cell_Properties --
   ---------------------------------------

   not overriding procedure Visit_Style_Table_Cell_Properties
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Table_Cell_Properties.ODF_Style_Table_Cell_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Table_Cell_Properties;

   -----------------------------------------
   -- Visit_Style_Table_Column_Properties --
   -----------------------------------------

   not overriding procedure Visit_Style_Table_Column_Properties
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Table_Column_Properties.ODF_Style_Table_Column_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Table_Column_Properties;

   ----------------------------------
   -- Visit_Style_Table_Properties --
   ----------------------------------

   not overriding procedure Visit_Style_Table_Properties
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Table_Properties.ODF_Style_Table_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Table_Properties;

   --------------------------------------
   -- Visit_Style_Table_Row_Properties --
   --------------------------------------

   not overriding procedure Visit_Style_Table_Row_Properties
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Table_Row_Properties.ODF_Style_Table_Row_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Table_Row_Properties;

   ---------------------------------
   -- Visit_Style_Text_Properties --
   ---------------------------------

   not overriding procedure Visit_Style_Text_Properties
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Style.Text_Properties.ODF_Style_Text_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Style_Text_Properties;

   ------------------------------------
   -- Visit_Table_Covered_Table_Cell --
   ------------------------------------

   not overriding procedure Visit_Table_Covered_Table_Cell
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Table.Covered_Table_Cell.ODF_Table_Covered_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Table_Covered_Table_Cell;

   -----------------------
   -- Visit_Table_Table --
   -----------------------

   not overriding procedure Visit_Table_Table
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Table.Table.ODF_Table_Table_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Table_Table;

   ----------------------------
   -- Visit_Table_Table_Cell --
   ----------------------------

   not overriding procedure Visit_Table_Table_Cell
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Table.Table_Cell.ODF_Table_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Table_Table_Cell;

   ------------------------------
   -- Visit_Table_Table_Column --
   ------------------------------

   not overriding procedure Visit_Table_Table_Column
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Table.Table_Column.ODF_Table_Table_Column_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Table_Table_Column;

   ---------------------------
   -- Visit_Table_Table_Row --
   ---------------------------

   not overriding procedure Visit_Table_Table_Row
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Table.Table_Row.ODF_Table_Table_Row_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Table_Table_Row;

   --------------------------------------------
   -- Visit_Text_Linenumbering_Configuration --
   --------------------------------------------

   not overriding procedure Visit_Text_Linenumbering_Configuration
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Text.Linenumbering_Configuration.ODF_Text_Linenumbering_Configuration_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Text_Linenumbering_Configuration;

   ------------------------------------
   -- Visit_Text_Notes_Configuration --
   ------------------------------------

   not overriding procedure Visit_Text_Notes_Configuration
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Text.Notes_Configuration.ODF_Text_Notes_Configuration_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Text_Notes_Configuration;

   ------------------------------------
   -- Visit_Text_Outline_Level_Style --
   ------------------------------------

   not overriding procedure Visit_Text_Outline_Level_Style
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Text.Outline_Level_Style.ODF_Text_Outline_Level_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Text_Outline_Level_Style;

   ------------------------------
   -- Visit_Text_Outline_Style --
   ------------------------------

   not overriding procedure Visit_Text_Outline_Style
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Text.Outline_Style.ODF_Text_Outline_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Text_Outline_Style;

   ------------------
   -- Visit_Text_P --
   ------------------

   not overriding procedure Visit_Text_P
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Text.P.ODF_Text_P_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Text_P;

   ------------------------------
   -- Visit_Text_Sequence_Decl --
   ------------------------------

   not overriding procedure Visit_Text_Sequence_Decl
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Text.Sequence_Decl.ODF_Text_Sequence_Decl_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Text_Sequence_Decl;

   -------------------------------
   -- Visit_Text_Sequence_Decls --
   -------------------------------

   not overriding procedure Visit_Text_Sequence_Decls
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Text.Sequence_Decls.ODF_Text_Sequence_Decls_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Text_Sequence_Decls;

   ---------------------
   -- Visit_Text_Span --
   ---------------------

   not overriding procedure Visit_Text_Span
    (Self    : in out ODF_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null ODF.DOM.Elements.Text.Span.ODF_Text_Span_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Self.Visit_Element
       (Visitor, XML.DOM.Nodes.Elements.DOM_Element_Access (Element), Control);
   end Visit_Text_Span;

end ODF.DOM.Iterators;
