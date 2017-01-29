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

   not overriding procedure Set_Disabled
    (Self     : in out Abstract_Spin_Box;
     Disabled : Boolean);
   --  Available as slot.

   not overriding procedure Set_Enabled
    (Self    : in out Abstract_Spin_Box;
     Enabled : Boolean);
   --  Available as slot.

   not overriding procedure Step_Down
    (Self : in out Abstract_Spin_Box) is abstract;
   --  Available as slot.

   not overriding procedure Step_Up
    (Self : in out Abstract_Spin_Box) is abstract;
   --  Available as slot.

   -----------
   -- Slots --
   -----------

   function Set_Disabled_Slot
    (Self : in out Abstract_Spin_Box'Class)
       return WUI.Boolean_Slots.Slot'Class;

   function Set_Enabled_Slot
    (Self : in out Abstract_Spin_Box'Class)
       return WUI.Boolean_Slots.Slot'Class;

   function Step_Down_Slot
    (Self : in out Abstract_Spin_Box'Class)
       return Core.Slots_0.Slot'Class;

   function Step_Up_Slot
    (Self : in out Abstract_Spin_Box'Class)
       return Core.Slots_0.Slot'Class;

   package Constructors is

      procedure Initialize
       (Self    : in out Abstract_Spin_Box'Class;
        Element :
          not null WebAPI.HTML.Input_Elements.HTML_Input_Element_Access);

   end Constructors;

private

   type Abstract_Spin_Box is
     abstract new WUI.Widgets.Abstract_Widget with
   record
      Editing_Finished : aliased
        Core.Slots_0.Emitters.Emitter (Abstract_Spin_Box'Unchecked_Access);
   end record;

   -----------
   -- Slots --
   -----------

   package Set_Disabled_Slots is
     new WUI.Boolean_Slots.Generic_Slots (Abstract_Spin_Box, Set_Disabled);

   function Set_Disabled_Slot
    (Self : in out Abstract_Spin_Box'Class)
       return WUI.Boolean_Slots.Slot'Class
         renames Set_Disabled_Slots.To_Slot;

   package Set_Enabled_Slots is
     new WUI.Boolean_Slots.Generic_Slots (Abstract_Spin_Box, Set_Enabled);

   function Set_Enabled_Slot
    (Self : in out Abstract_Spin_Box'Class)
       return WUI.Boolean_Slots.Slot'Class
         renames Set_Enabled_Slots.To_Slot;

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
