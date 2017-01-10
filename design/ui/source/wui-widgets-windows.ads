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
with League.Strings;

with WebAPI.HTML.Elements;

package WUI.Widgets.Windows is

   type Window is new WUI.Widgets.Abstract_Widget with private;

   type Window_Access is access all Window'Class;
--     with Storage_Size => 0;

   not overriding function Top    (Self : Window) return Integer;
   not overriding function Left   (Self : Window) return Integer;
   not overriding function Height (Self : Window) return Integer;
   not overriding function Width  (Self : Window) return Integer;

   not overriding procedure Set_Position
     (Self : in out Window;
      Top  : Integer;
      Left : Integer);

   not overriding procedure Set_Size
     (Self   : in out Window;
      Height : Integer;
      Width  : Integer);

   package Constructors is

      procedure Initialize
       (Self    : in out Window'Class;
        Element : not null WebAPI.HTML.Elements.HTML_Element_Access);
      --  Initialize top level HTML element as root window

      procedure Initialize
       (Self    : in out Window'Class;
        Parent  : not null access WUI.Widgets.Abstract_Widget'Class;
        Title   : League.Strings.Universal_String);
      --  Initialize nested window with given title

   end Constructors;

private

   package Sliders is

      type Slider (Parent : not null Window_Access) is
        new WUI.Widgets.Abstract_Widget with
      record
         Active : Boolean := False;
         Prev_X : Long_Float;
         Prev_Y : Long_Float;
         Win_X  : Integer;
         Win_Y  : Integer;
      end record;

      overriding procedure Mouse_Move_Event
       (Self  : in out Slider;
        Event : in out WUI.Events.Mouse.Move.Mouse_Move_Event'Class);

      overriding procedure Mouse_Press_Event
       (Self  : in out Slider;
        Event : in out WUI.Events.Mouse.Button.Mouse_Button_Event'Class);

      overriding procedure Mouse_Release_Event
       (Self  : in out Slider;
        Event : in out WUI.Events.Mouse.Button.Mouse_Button_Event'Class);

      type Resizer is new Slider with null record;

      overriding procedure Mouse_Move_Event
       (Self  : in out Resizer;
        Event : in out WUI.Events.Mouse.Move.Mouse_Move_Event'Class);

      overriding procedure Mouse_Press_Event
       (Self  : in out Resizer;
        Event : in out WUI.Events.Mouse.Button.Mouse_Button_Event'Class);

   end Sliders;

   type Window is new WUI.Widgets.Abstract_Widget with record
      Enclosing_Div : WebAPI.HTML.Elements.HTML_Element_Access;
      Slider        : Sliders.Slider (Window'Unchecked_Access);
      Resizer       : Sliders.Resizer (Window'Unchecked_Access);
   end record;

   not overriding procedure Set_Style
     (Self   : in out Window;
      Top    : Integer;
      Left   : Integer;
      Height : Integer;
      Width  : Integer);

end WUI.Widgets.Windows;
