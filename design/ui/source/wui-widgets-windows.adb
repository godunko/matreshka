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
with WebAPI.DOM.Documents;
with WebAPI.DOM.Elements;

package body WUI.Widgets.Windows is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self    : in out Window'Class;
        Element : not null WebAPI.HTML.Elements.HTML_Element_Access) is
      begin
         Self.Enclosing_Div :=
           WebAPI.HTML.Elements.HTML_Element_Access (Element);

         WUI.Widgets.Constructors.Initialize (Self, Element);
      end Initialize;

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self    : in out Window'Class;
        Parent  : not null access WUI.Widgets.Abstract_Widget'Class;
        Title   : League.Strings.Universal_String)
      is
         Document  : constant WebAPI.DOM.Documents.Document_Access
           := Parent.Element.Get_Owner_Document;
         Enclosing : constant not null WebAPI.DOM.Elements.Element_Access
           := Document.Create_Element (+"div");
         Head      : constant not null WebAPI.DOM.Elements.Element_Access
           := Document.Create_Element (+"div");
         Corner    : constant not null WebAPI.DOM.Elements.Element_Access
           := Document.Create_Element (+"div");
         Content   : constant not null WebAPI.DOM.Elements.Element_Access
           := Document.Create_Element (+"div");

      begin
         Self.Enclosing_Div :=
           WebAPI.HTML.Elements.HTML_Element_Access (Enclosing);

         Head.Set_Text_Content (Title);
         Head.Set_Class_Name (+"window-title");
         Enclosing.Set_Class_Name (+"window");
         Enclosing.Append_Child (Head);
         Content.Set_Class_Name (+"window-body");
         Enclosing.Append_Child (Content);
         Corner.Set_Class_Name (+"window-corner");
         Enclosing.Append_Child (Corner);

         WUI.Widgets.Constructors.Initialize
          (Self, WebAPI.HTML.Elements.HTML_Element_Access (Content));
         WUI.Widgets.Constructors.Initialize
          (Self.Slider,
           WebAPI.HTML.Elements.HTML_Element_Access (Head));
         WUI.Widgets.Constructors.Initialize
          (Self.Resizer,
           WebAPI.HTML.Elements.HTML_Element_Access (Corner));

         Parent.Element.Append_Child (Enclosing);
      end Initialize;

   end Constructors;

   -------------
   -- Sliders --
   -------------

   package body Sliders is

      ----------------------
      -- Mouse_Move_Event --
      ----------------------

      overriding procedure Mouse_Move_Event
       (Self  : in out Slider;
        Event : in out WUI.Events.Mouse.Move.Mouse_Move_Event'Class) is
      begin
         if Self.Active then
            Self.Win_X := Self.Win_X + Integer (Event.X - Self.Prev_X);
            Self.Win_Y := Self.Win_Y + Integer (Event.Y - Self.Prev_Y);
            Self.Parent.Set_Position (Self.Win_Y, Self.Win_X);
            Self.Prev_X := Event.X;
            Self.Prev_Y := Event.Y;
         end if;
      end Mouse_Move_Event;

      ----------------------
      -- Mouse_Move_Event --
      ----------------------

      overriding procedure Mouse_Move_Event
       (Self  : in out Resizer;
        Event : in out WUI.Events.Mouse.Move.Mouse_Move_Event'Class) is
      begin
         if Self.Active then
            Self.Win_X := Self.Win_X + Integer (Event.X - Self.Prev_X);
            Self.Win_Y := Self.Win_Y + Integer (Event.Y - Self.Prev_Y);
            Self.Parent.Set_Size (Self.Win_Y, Self.Win_X);
            Self.Prev_X := Event.X;
            Self.Prev_Y := Event.Y;
         end if;
      end Mouse_Move_Event;

      -----------------------
      -- Mouse_Press_Event --
      -----------------------

      overriding procedure Mouse_Press_Event
       (Self  : in out Slider;
        Event : in out WUI.Events.Mouse.Button.Mouse_Button_Event'Class) is
      begin
         Self.Active := True;
         Self.Prev_X := Event.X;
         Self.Prev_Y := Event.Y;
         Self.Win_X := Self.Parent.Left;
         Self.Win_Y := Self.Parent.Top;
      end Mouse_Press_Event;

      -----------------------
      -- Mouse_Press_Event --
      -----------------------

      overriding procedure Mouse_Press_Event
       (Self  : in out Resizer;
        Event : in out WUI.Events.Mouse.Button.Mouse_Button_Event'Class) is
      begin
         Self.Active := True;
         Self.Prev_X := Event.X;
         Self.Prev_Y := Event.Y;
         Self.Win_X := Self.Parent.Width;
         Self.Win_Y := Self.Parent.Height;
      end Mouse_Press_Event;

      -------------------------
      -- Mouse_Release_Event --
      -------------------------

      overriding procedure Mouse_Release_Event
       (Self  : in out Slider;
        Event : in out WUI.Events.Mouse.Button.Mouse_Button_Event'Class) is
      begin
         Self.Active := False;
      end Mouse_Release_Event;

   end Sliders;

   ------------
   -- Height --
   ------------

   not overriding function Height (Self : Window) return Integer is
   begin
      return Integer (Self.Enclosing_Div.Get_Offset_Height);
   end Height;

   ----------
   -- Left --
   ----------

   not overriding function Left (Self : Window) return Integer is
   begin
      return Integer (Self.Enclosing_Div.Get_Offset_Left);
   end Left;

   -----------
   -- Width --
   -----------

   not overriding function Width (Self : Window) return Integer is
   begin
      return Integer (Self.Enclosing_Div.Get_Offset_Width);
   end Width;

   ------------------
   -- Set_Position --
   ------------------

   not overriding procedure Set_Position
    (Self : in out Window;
     Top  : Integer;
     Left : Integer) is
   begin
      Self.Set_Style (Top, Left, Self.Height, Self.Width);
   end Set_Position;

   --------------
   -- Set_Size --
   --------------

   not overriding procedure Set_Size
    (Self   : in out Window;
     Height : Integer;
     Width  : Integer) is
   begin
      Self.Set_Style (Self.Top, Self.Left, Height, Width);
   end Set_Size;

   ---------------
   -- Set_Style --
   ---------------

   not overriding procedure Set_Style
     (Self   : in out Window;
      Top    : Integer;
      Left   : Integer;
      Height : Integer;
      Width  : Integer)
   is
      use type League.Strings.Universal_String;

      Top_Image : constant Wide_Wide_String :=
        Integer'Wide_Wide_Image (Top);
      Left_Image : constant Wide_Wide_String :=
        Integer'Wide_Wide_Image (Left);
      Height_Image : constant Wide_Wide_String :=
        Integer'Wide_Wide_Image (Height);
      Width_Image : constant Wide_Wide_String :=
        Integer'Wide_Wide_Image (Width);
      Style : League.Strings.Universal_String := +"top:";
   begin
      Style := Style & Top_Image & "px; left:" & Left_Image & "px;"
        & "height:" & Height_Image & "px; width:" & Width_Image & "px;";

      Self.Enclosing_Div.Set_Attribute (+"style", Style);
   end Set_Style;

   ---------
   -- Top --
   ---------

   not overriding function Top (Self : Window) return Integer is
   begin
      return Integer (Self.Enclosing_Div.Get_Offset_Top);
   end Top;

end WUI.Widgets.Windows;
