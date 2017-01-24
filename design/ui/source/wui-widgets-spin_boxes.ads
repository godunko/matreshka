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
with WebAPI.HTML.Input_Elements;

with Core.Slots_0;
private with Core.Slots_0.Generic_Slots;
private with Core.Slots_0.Emitters;

package WUI.Widgets.Spin_Boxes is

   type Abstract_Spin_Box is
     abstract new WUI.Widgets.Abstract_Widget with private;

   not overriding function Editing_Finished_Signal
    (Self : in out Abstract_Spin_Box)
       return not null access Core.Slots_0.Signal'Class;

   not overriding procedure Step_Down
    (Self : in out Abstract_Spin_Box) is abstract;

   function Step_Down_Slot
    (Self : in out Abstract_Spin_Box'Class)
       return Core.Slots_0.Slot'Class;

   not overriding procedure Step_Up
    (Self : in out Abstract_Spin_Box) is abstract;

   function Step_Up_Slot
    (Self : in out Abstract_Spin_Box'Class)
       return Core.Slots_0.Slot'Class;

   not overriding procedure Input_Event
    (Self  : in out Abstract_Spin_Box) is abstract;

   package Constructors is

      procedure Initialize
       (Self    : in out Abstract_Spin_Box'Class;
        Element :
          not null WebAPI.HTML.Input_Elements.HTML_Input_Element_Access);

   end Constructors;

private

   type Input_Dispatcher
    (Owner : not null access Abstract_Spin_Box'Class) is
       limited new WebAPI.DOM.Event_Listeners.Event_Listener with null record;

   overriding procedure Handle_Event
    (Self  : not null access Input_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class);

   type Abstract_Spin_Box is
     abstract new WUI.Widgets.Abstract_Widget with
   record
      Input            : aliased
        Input_Dispatcher (Abstract_Spin_Box'Unchecked_Access);
      Editing_Finished : aliased
        Core.Slots_0.Emitters.Emitter (Abstract_Spin_Box'Unchecked_Access);
   end record;

   package Step_Down_Slots is
     new Core.Slots_0.Generic_Slots (Abstract_Spin_Box, Step_Down);

   function Step_Down_Slot
    (Self : in out Abstract_Spin_Box'Class) return Core.Slots_0.Slot'Class
       renames Step_Down_Slots.To_Slot;

   package Step_Up_Slots is
     new Core.Slots_0.Generic_Slots (Abstract_Spin_Box, Step_Up);

   function Step_Up_Slot
    (Self : in out Abstract_Spin_Box'Class) return Core.Slots_0.Slot'Class
       renames Step_Down_Slots.To_Slot;

end WUI.Widgets.Spin_Boxes;
