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
with WebAPI.DOM.Event_Targets;

package body Widgets is

   function "+" (Item : Wide_Wide_String)
     return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self : in out Abstract_Widget'Class;
        Root : not null WebAPI.DOM.Elements.Element_Access) is
      begin
         Self.Root := Root;
         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Self.Root, +"click", Self.Click_Dispatcher'Access, False);
         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Self.Root, +"keydown", Self.Keydown_Dispatcher'Access, False);
         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Self.Root, +"keyup", Self.Keyup_Dispatcher'Access, False);
      end Initialize;

   end Constructors;

   ------------------
   -- Handle_Event --
   ------------------

   overriding procedure Handle_Event
    (Self  : not null access On_Click_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class) is
   begin
      Self.Owner.On_Click (Event);
   end Handle_Event;

   ------------------
   -- Handle_Event --
   ------------------

   overriding procedure Handle_Event
    (Self  : not null access On_Keydown_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class) is
   begin
      Self.Owner.On_Key_Press_Event
       (WebAPI.UI_Events.Keyboard.Keyboard_Event'Class (Event.all));
   end Handle_Event;

   ------------------
   -- Handle_Event --
   ------------------

   overriding procedure Handle_Event
    (Self  : not null access On_Keyup_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class) is
   begin
      Self.Owner.On_Key_Release_Event
       (WebAPI.UI_Events.Keyboard.Keyboard_Event'Class (Event.all));
   end Handle_Event;

end Widgets;
