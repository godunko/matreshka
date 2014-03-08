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
-- Copyright © 2013-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
--  This unit provides convertor of ODF DOM tree into corresponding tree of
--  JSON objects. Elements of ODF DOM are not converted to JSON objects
--  one-to-one; additional processing is done to simplify JavaScript code.
------------------------------------------------------------------------------
private with Ada.Containers.Vectors;

with League.JSON.Arrays;
with League.JSON.Objects;
with League.JSON.Values;
private with League.Strings;
private with XML.DOM.Texts;
private with XML.DOM.Visitors;

private with ODF.DOM.Office_Automatic_Styles_Elements;
private with ODF.DOM.Office_Text_Elements;
private with ODF.DOM.Style_Default_Style_Elements;
private with ODF.DOM.Style_Paragraph_Properties_Elements;
private with ODF.DOM.Style_Style_Elements;
private with ODF.DOM.Style_Table_Cell_Properties_Elements;
private with ODF.DOM.Style_Table_Column_Properties_Elements;
private with ODF.DOM.Style_Text_Properties_Elements;
private with ODF.DOM.Table_Table_Elements;
private with ODF.DOM.Table_Table_Cell_Elements;
private with ODF.DOM.Table_Table_Column_Elements;
private with ODF.DOM.Table_Table_Row_Elements;
private with ODF.DOM.Text_H_Elements;
private with ODF.DOM.Text_P_Elements;
private with ODF.DOM.Text_Span_Elements;
with ODF.DOM.Visitors;

private package ODF.Web.Builder is

   type JSON_Builder is limited new ODF.DOM.Visitors.Abstract_ODF_Visitor with private;

   function Get_Document (Self : in out JSON_Builder) return League.JSON.Objects.JSON_Object;
   --  Returns constructed document.

private

   type State_Kinds is
    (Initial,
     Element);

   type State_Record (Kind : State_Kinds := Initial) is record
      case Kind is
         when Initial =>
            null;

         when Element =>
            Object   : League.JSON.Objects.JSON_Object;
            Children : League.JSON.Arrays.JSON_Array;
      end case;
   end record;

   package State_Vectors is
     new Ada.Containers.Vectors (Positive, State_Record);
   
   type JSON_Builder is limited new ODF.DOM.Visitors.Abstract_ODF_Visitor with record
      Inside_Automatic : Boolean := False;
      Current          : State_Record;
      Previous         : State_Record;
      Stack            : State_Vectors.Vector;
      Styles           : League.JSON.Arrays.JSON_Array;
      Content          : League.JSON.Values.JSON_Value;
   end record;

   procedure Push
    (Self     : in out JSON_Builder'Class;
     The_Type : League.Strings.Universal_String;
     Node     : not null access XML.DOM.Nodes.DOM_Node'Class);

   procedure Pop (Self : in out JSON_Builder'Class);

   overriding procedure Enter_Office_Automatic_Styles
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Office_Automatic_Styles_Elements.ODF_Office_Automatic_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Office_Automatic_Styles
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Office_Automatic_Styles_Elements.ODF_Office_Automatic_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Office_Text
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Office_Text_Elements.ODF_Office_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Office_Text
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Office_Text_Elements.ODF_Office_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Style_Default_Style
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Style_Default_Style_Elements.ODF_Style_Default_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Style_Default_Style
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Style_Default_Style_Elements.ODF_Style_Default_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Style_Paragraph_Properties
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Style_Paragraph_Properties_Elements.ODF_Style_Paragraph_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

--   overriding procedure Leave_Style_Paragraph_Properties
--    (Self    : in out JSON_Builder;
--     Element : not null ODF.DOM.Style_Paragraph_Properties_Elements.ODF_Style_Paragraph_Properties_Access;
--     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Style_Style
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Style_Style_Elements.ODF_Style_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Style_Style
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Style_Style_Elements.ODF_Style_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Style_Table_Cell_Properties
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Style_Table_Cell_Properties_Elements.ODF_Style_Table_Cell_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

--   overriding procedure Leave_Style_Table_Cell_Properties
--    (Self    : in out JSON_Builder;
--     Element : not null ODF.DOM.Style_Table_Cell_Properties_Elements.ODF_Style_Table_Cell_Properties_Access;
--     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Style_Table_Column_Properties
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Style_Table_Column_Properties_Elements.ODF_Style_Table_Column_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

--   overriding procedure Leave_Style_Table_Column_Properties
--    (Self    : in out JSON_Builder;
--     Element : not null ODF.DOM.Style_Table_Column_Properties_Elements.ODF_Style_Table_Column_Properties_Access;
--     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Style_Text_Properties
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Style_Text_Properties_Elements.ODF_Style_Text_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

--   overriding procedure Leave_Style_Text_Properties
--    (Self    : in out JSON_Builder;
--     Element : not null ODF.DOM.Style_Text_Properties_Elements.ODF_Style_Text_Properties_Access;
--     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Table_Table
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Table_Table_Elements.ODF_Table_Table_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Table_Table
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Table_Table_Elements.ODF_Table_Table_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Table_Table_Cell
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Table_Table_Cell_Elements.ODF_Table_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Table_Table_Cell
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Table_Table_Cell_Elements.ODF_Table_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Table_Table_Column
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Table_Table_Column_Elements.ODF_Table_Table_Column_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Table_Table_Column
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Table_Table_Column_Elements.ODF_Table_Table_Column_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Table_Table_Row
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Table_Table_Row_Elements.ODF_Table_Table_Row_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Table_Table_Row
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Table_Table_Row_Elements.ODF_Table_Table_Row_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Text_H
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Text_H_Elements.ODF_Text_H_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Text_H
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Text_H_Elements.ODF_Text_H_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Text_P
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Text_P_Elements.ODF_Text_P_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Text_P
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Text_P_Elements.ODF_Text_P_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Text_Span
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Text_Span_Elements.ODF_Text_Span_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Text_Span
    (Self    : in out JSON_Builder;
     Element : not null ODF.DOM.Text_Span_Elements.ODF_Text_Span_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Enter_Text
    (Self    : in out JSON_Builder;
     Element : not null XML.DOM.Texts.DOM_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Text
    (Self    : in out JSON_Builder;
     Element : not null XML.DOM.Texts.DOM_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

end ODF.Web.Builder;
