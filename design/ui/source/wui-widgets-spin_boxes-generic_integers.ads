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
-- Copyright © 2016-2018, Vadim Godunko <vgodunko@gmail.com>                --
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

with Core.Connectables.Slots_0.Slots_1.Generic_Emitters;

generic
   type Data_Type is range <>;

   with package Integer_Slots is
     new Core.Connectables.Slots_0.Slots_1 (Data_Type);

   with package Integer_Emitters is new Integer_Slots.Generic_Emitters;

package WUI.Widgets.Spin_Boxes.Generic_Integers is

   type Integer_Spin_Box is
     new WUI.Widgets.Spin_Boxes.Abstract_Spin_Box with private;

   type Integer_Spin_Box_Access is access all Integer_Spin_Box'Class
     with Storage_Size => 0;

   not overriding function Value (Self : Integer_Spin_Box) return Data_Type;

   not overriding procedure Set_Value
    (Self : in out Integer_Spin_Box;
     To   : Data_Type);
   --  Available as slot.

   -------------
   -- Signals --
   -------------

   not overriding function Value_Changed_Signal
    (Self : in out Integer_Spin_Box)
       return not null access Integer_Slots.Signal'Class;

   -----------
   -- Slots --
   -----------

   function Set_Value_Slot
    (Self : in out Integer_Spin_Box'Class) return Integer_Slots.Slot'Class;

   package Constructors is

      procedure Initialize
       (Self    : in out Integer_Spin_Box'Class;
        Element :
          not null WebAPI.HTML.Input_Elements.HTML_Input_Element_Access);

      function Create
       (Element :
          not null WebAPI.HTML.Input_Elements.HTML_Input_Element_Access)
            return not null Integer_Spin_Box_Access;

      function Create
       (Id : League.Strings.Universal_String)
          return not null Integer_Spin_Box_Access;

   end Constructors;

private

   type Integer_Spin_Box is
     new WUI.Widgets.Spin_Boxes.Abstract_Spin_Box with record
      Last_Value    : Data_Type;
      --  Last valid value.
      Value_Changed : aliased
        Integer_Emitters.Emitter (Integer_Spin_Box'Unchecked_Access);
   end record;

   overriding procedure Step_Down (Self : in out Integer_Spin_Box);

   overriding procedure Step_Up (Self : in out Integer_Spin_Box);

   overriding procedure Input_Event (Self : in out Integer_Spin_Box);

   overriding procedure Change_Event (Self : in out Integer_Spin_Box);

   -----------
   -- Slots --
   -----------

   package Set_Value_Slots is
     new Integer_Slots.Generic_Slots (Integer_Spin_Box, Set_Value);

   function Set_Value_Slot
    (Self : in out Integer_Spin_Box'Class) return Integer_Slots.Slot'Class
       renames Set_Value_Slots.To_Slot;

end WUI.Widgets.Spin_Boxes.Generic_Integers;
