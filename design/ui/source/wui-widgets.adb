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
with WebAPI.DOM.Event_Targets;
with WebAPI.UI_Events.Mouse;
with WebAPI.UI_Events.Wheel;

with WUI.Applications.Internals;

package body WUI.Widgets is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self    : in out Abstract_Widget'Class;
        Element : not null WebAPI.HTML.Elements.HTML_Element_Access) is
      begin
         Self.Element := Element;

         --  Connect event dispatchers.

         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Element, +"blur", Self.Blur'Access, False);
         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Element, +"change", Self.Change'Access, False);
         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Element, +"click", Self.Click'Access, False);
         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Element, +"focus", Self.Focus'Access, False);
         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Element, +"input", Self.Input'Access, False);
         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Element, +"mousemove", Self.Mouse_Move'Access, False);
         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Element, +"mousedown", Self.Mouse_Down'Access, False);
         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Element, +"mouseup", Self.Mouse_Up'Access, False);
         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Element, +"wheel", Self.Wheel'Access, False);
      end Initialize;

   end Constructors;

   procedure Log (Item : League.Strings.Universal_String)
     with Import     => True,
          Convention => JavaScript_Function,
          Link_Name  => "console.log";

   --------------------
   -- Focus_In_Event --
   --------------------

   not overriding procedure Focus_In_Event (Self : in out Abstract_Widget) is
   begin
      WUI.Applications.Internals.Focus_In (Self'Unchecked_Access);
   end Focus_In_Event;

   ---------------------
   -- Focus_Out_Event --
   ---------------------

   not overriding procedure Focus_Out_Event (Self : in out Abstract_Widget) is
   begin
      WUI.Applications.Internals.Focus_Out (Self'Unchecked_Access);
   end Focus_Out_Event;

   ------------------
   -- Handle_Event --
   ------------------

   overriding procedure Handle_Event
    (Self  : not null access Blur_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class) is
   begin
      Self.Owner.Focus_Out_Event;
   end Handle_Event;

   ------------------
   -- Handle_Event --
   ------------------

   overriding procedure Handle_Event
    (Self  : not null access Change_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class) is
   begin
      Self.Owner.Change_Event;
   end Handle_Event;

   ------------------
   -- Handle_Event --
   ------------------

   overriding procedure Handle_Event
    (Self  : not null access Focus_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class) is
   begin
      Self.Owner.Focus_In_Event;
   end Handle_Event;

   ------------------
   -- Handle_Event --
   ------------------

   overriding procedure Handle_Event
    (Self  : not null access Input_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class) is
   begin
      Self.Owner.Input_Event;
   end Handle_Event;

   ------------------
   -- Handle_Event --
   ------------------

   overriding procedure Handle_Event
    (Self  : not null access Mouse_Click_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class)
   is
      E : WUI.Events.Mouse.Click.Click_Event;

   begin
      WUI.Events.Mouse.Click.Constructors.Initialize
       (E,
        WebAPI.UI_Events.Mouse.Mouse_Event'Class (Event.all)'Unchecked_Access);
      Self.Owner.Click_Event (E);
   end Handle_Event;

   ------------------
   -- Handle_Event --
   ------------------

   overriding procedure Handle_Event
    (Self  : not null access Mouse_Move_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class)
   is
      E : WUI.Events.Mouse.Move.Mouse_Move_Event;

   begin
      WUI.Events.Mouse.Move.Constructors.Initialize
       (E,
        WebAPI.UI_Events.Mouse.Mouse_Event'Class (Event.all)'Unchecked_Access);
      Self.Owner.Mouse_Move_Event (E);
   end Handle_Event;

   ------------------
   -- Handle_Event --
   ------------------

   overriding procedure Handle_Event
    (Self  : not null access Mouse_Down_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class)
   is
      E : WUI.Events.Mouse.Button.Mouse_Button_Event;

   begin
      WUI.Events.Mouse.Button.Constructors.Initialize
       (E,
        WebAPI.UI_Events.Mouse.Mouse_Event'Class (Event.all)'Unchecked_Access);
      Self.Owner.Mouse_Press_Event (E);
   end Handle_Event;

   ------------------
   -- Handle_Event --
   ------------------

   overriding procedure Handle_Event
    (Self  : not null access Mouse_Up_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class)
   is
      E : WUI.Events.Mouse.Button.Mouse_Button_Event;

   begin
      WUI.Events.Mouse.Button.Constructors.Initialize
       (E,
        WebAPI.UI_Events.Mouse.Mouse_Event'Class (Event.all)'Unchecked_Access);
      Self.Owner.Mouse_Release_Event (E);
   end Handle_Event;

   ------------------
   -- Handle_Event --
   ------------------

   overriding procedure Handle_Event
    (Self  : not null access Wheel_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class)
   is
      E : WUI.Events.Mouse.Wheel.Mouse_Wheel_Event;

   begin
      WUI.Events.Mouse.Wheel.Constructors.Initialize
       (E,
        WebAPI.UI_Events.Wheel.Wheel_Event'Class (Event.all)'Unchecked_Access);
      Self.Owner.Mouse_Wheel_Event (E);
   end Handle_Event;

   -----------------
   -- Set_Visible --
   -----------------

   not overriding procedure Set_Visible
    (Self : in out Abstract_Widget;
     To   : Boolean) is
   begin
      Self.Element.Set_Hidden (not To);
   end Set_Visible;

end WUI.Widgets;
