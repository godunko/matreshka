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
with ODF.DOM.Attributes.Text.Style_Name;

package body ODF.Web.Builder is

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
     Control : in out XML.DOM.Visitors.Traverse_Control)
   is
      Style_Name : constant
        ODF.DOM.Attributes.Text.Style_Name.ODF_Text_Style_Name_Access
          := ODF.DOM.Attributes.Text.Style_Name.ODF_Text_Style_Name_Access
              (Element.Get_Attribute_Node_NS
                (ODF.Constants.Text_URI, ODF.Constants.Style_Name_Name));

   begin
      Self.Push;
      Self.Current.Object.Set_Field ("__type", "OdfTextP");
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
      Self.Push;
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
         Self.Previous := (Kind => Initial);
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
       (Element,
        GNATCOLL.JSON.Create_Object,
        GNATCOLL.JSON.Empty_Array);
   end Push;

end ODF.Web.Builder;
