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
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
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
private with League.Strings;

with WebAPI.DOM.Elements;
private with WebAPI.DOM.Event_Listeners;
with WebAPI.DOM.Events;
with WebAPI.UI_Events.Keyboard;

with Core.Objects;

package Widgets is

   pragma Preelaborate;

   type Abstract_Widget is
     abstract new Core.Objects.Abstract_Object with private;

   not overriding procedure On_Click
    (Self  : in out Abstract_Widget;
     Event : not null access WebAPI.DOM.Events.Event'Class) is null;

   not overriding procedure On_Key_Press_Event
    (Self  : in out Abstract_Widget;
     Event : in out WebAPI.UI_Events.Keyboard.Keyboard_Event'Class) is null;

   not overriding procedure On_Key_Release_Event
    (Self  : in out Abstract_Widget;
     Event : in out WebAPI.UI_Events.Keyboard.Keyboard_Event'Class) is null;

   package Constructors is

      procedure Initialize
       (Self : in out Abstract_Widget'Class;
        Root : not null WebAPI.DOM.Elements.Element_Access);

   end Constructors;

private

--   package On_Click_Dispatchers is
--     new Generic_Event_Dispatchers (Abstract_Widget, On_Click);
   
   type On_Click_Dispatcher
    (Owner : not null access Abstract_Widget'Class) is
       limited new WebAPI.DOM.Event_Listeners.Event_Listener with null record;

   overriding procedure Handle_Event
    (Self  : not null access On_Click_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class);

   type On_Keydown_Dispatcher
    (Owner : not null access Abstract_Widget'Class) is
       limited new WebAPI.DOM.Event_Listeners.Event_Listener with null record;

   overriding procedure Handle_Event
    (Self  : not null access On_Keydown_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class);

   type On_Keyup_Dispatcher
    (Owner : not null access Abstract_Widget'Class) is
       limited new WebAPI.DOM.Event_Listeners.Event_Listener with null record;

   overriding procedure Handle_Event
    (Self  : not null access On_Keyup_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class);

   type Abstract_Widget is
     abstract new Core.Objects.Abstract_Object with record
      Root             : WebAPI.DOM.Elements.Element_Access;
      Click_Dispatcher : aliased On_Click_Dispatcher (Abstract_Widget'Access);
      Keyup_Dispatcher : aliased On_Keyup_Dispatcher (Abstract_Widget'Access);
      Keydown_Dispatcher :
        aliased On_Keydown_Dispatcher (Abstract_Widget'Access);
   end record;

--   type Event_Dispatcher is
--     limited new WebAPI.DOM.Event_Listeners.Event_Listener with null record;
--
--   overriding procedure handle_event
--    (self  : not null access total_updater;
--     event : access webapi.dom.events.event'class);

end Widgets;
