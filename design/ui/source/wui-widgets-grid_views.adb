------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2016-2017, Vadim Godunko <vgodunko@gmail.com>                --
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
with League.Calendars;

package body WUI.Widgets.Grid_Views is

   package Renderers is

      type Cell_Visiter is new WUI.Grid_Models.Cell_Visiter with record
         Value : League.Strings.Universal_String;
      end record;

      overriding procedure String_Cell
        (Self  : not null access Cell_Visiter;
         Value : League.Strings.Universal_String);

      overriding procedure Integer_Cell
        (Self  : not null access Cell_Visiter;
         Value : Integer);

      overriding procedure Date_Time_Cell
        (Self  : not null access Cell_Visiter;
         Value : League.Calendars.Date_Time);

   end Renderers;

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
        (Self    : in out Grid_View'Class;
         Parent  : not null access WUI.Widgets.Abstract_Widget'Class)
      is
         Document : constant WebAPI.DOM.Documents.Document_Access :=
           Parent.Element.Get_Owner_Document;
         Grid     : constant not null WebAPI.DOM.Elements.Element_Access :=
           Document.Create_Element (+"div");
         Head     : constant not null WebAPI.DOM.Elements.Element_Access :=
           Document.Create_Element (+"div");
         Table_H  : constant not null WebAPI.DOM.Elements.Element_Access :=
           Document.Create_Element (+"table");
         Data     : constant not null WebAPI.DOM.Elements.Element_Access :=
           Document.Create_Element (+"div");
         Table_D  : constant not null WebAPI.DOM.Elements.Element_Access :=
           Document.Create_Element (+"table");
      begin
         WUI.Widgets.Constructors.Initialize
           (Self, WebAPI.HTML.Elements.HTML_Element_Access (Grid));

         Self.Document := Document;
         Self.Header := Table_H;
         Self.Data := Table_D;

         Grid.Set_Class_Name (+"grid row scroll-x");
         Head.Set_Class_Name (+"grid-head row");
         Head.Append_Child (Table_H);
         Grid.Append_Child (Head);
         Data.Set_Class_Name (+"grid-data row scroll-y");
         Data.Append_Child (Table_D);
         Grid.Append_Child (Data);
         Parent.Element.Append_Child (Grid);
      end Initialize;

   end Constructors;

   ---------------
   -- Renderers --
   ---------------

   package body Renderers is

      -----------------
      -- String_Cell --
      -----------------

      overriding procedure String_Cell
        (Self  : not null access Cell_Visiter;
         Value : League.Strings.Universal_String) is
      begin
         Self.Value := Value;
      end String_Cell;

      ------------------
      -- Integer_Cell --
      ------------------

      overriding procedure Integer_Cell
        (Self  : not null access Cell_Visiter;
         Value : Integer) is
      begin
         Self.Value := +Integer'Wide_Wide_Image (Value);
      end Integer_Cell;

      --------------------
      -- Date_Time_Cell --
      --------------------

      overriding procedure Date_Time_Cell
        (Self  : not null access Cell_Visiter;
         Value : League.Calendars.Date_Time) is
      begin
         Self.Value := +"date rendering is not implemented";
      end Date_Time_Cell;

   end Renderers;

   ---------------
   -- Set_Model --
   ---------------

   not overriding procedure Set_Model
     (Self   : in out Grid_View;
      Header : not null WUI.Widgets.Grid_Views.Grid_Header_Access;
      Model  : not null WUI.Grid_Models.Grid_Model_Access)
   is
      Rows     : constant Natural := Model.Row_Count;
      Columns  : constant Natural := Model.Column_Count;
      Renderer : aliased Renderers.Cell_Visiter;
      TR       : WebAPI.DOM.Elements.Element_Access :=
        Self.Document.Create_Element (+"tr");
   begin
      for J in 1 .. Columns loop
         declare
            Width    : constant Natural := Header.Width (Column => J);
            Column_H : constant WebAPI.DOM.Elements.Element_Access :=
              Self.Document.Create_Element (+"col");
            Column_D : constant WebAPI.DOM.Elements.Element_Access :=
              Self.Document.Create_Element (+"col");
            TH       : constant WebAPI.DOM.Elements.Element_Access :=
              Self.Document.Create_Element (+"th");
         begin
            Column_H.Set_Attribute
              (+"width", +Natural'Wide_Wide_Image (Width));
            Column_D.Set_Attribute
              (+"width", +Natural'Wide_Wide_Image (Width));
            Self.Header.Append_Child (Column_H);
            Self.Data.Append_Child (Column_D);
            TH.Set_Text_Content (Text (Header, J));
            TR.Append_Child (TH);
         end;
      end loop;

      Self.Header.Append_Child (TR);

      for R in 1 .. Rows loop
         declare
            Row : constant WUI.Grid_Models.Row_Access := Model.Row (R);
         begin
            TR := Self.Document.Create_Element (+"tr");

            for J in 1 .. Columns loop
               declare
                  TD : constant WebAPI.DOM.Elements.Element_Access :=
                    Self.Document.Create_Element (+"td");
               begin
                  Model.Visit_Cell (Row, J, Renderer'Unchecked_Access);
                  TD.Set_Text_Content (Renderer.Value);
                  TR.Append_Child (TD);
               end;
            end loop;

            TR.Set_Attribute (+"tabindex", +"1");
            Self.Data.Append_Child (TR);
         end;
      end loop;
   end Set_Model;

end WUI.Widgets.Grid_Views;
