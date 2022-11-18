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

package body Core.Connectables.Slots_0.Slots_1.Slots_2.Generic_Slots is

   ---------------------
   -- Create_Slot_End --
   ---------------------

   overriding function Create_Slot_End
    (Self : Slot) return not null Slot_End_Access is
   begin
--      return
--        new Slot_End'
--             (Next     => null,
--              Previous => null,
--              Object   => Self.Object.all'Unchecked_Access);
--  XXX A2JS: invalid code generated
      return Result : not null Slot_End_Access
               := new Slot_End (Self.Object.all'Unchecked_Access)
      do
         Result.Next     := null;
         Result.Previous := null;
      end return;
   end Create_Slot_End;

   ------------
   -- Invoke --
   ------------

   overriding procedure Invoke
    (Self        : in out Slot_End;
     Parameter_1 : Parameter_1_Type;
     Parameter_2 : Parameter_2_Type) is
   begin
      Subprogram (Self.Object.all, Parameter_1, Parameter_2);
   end Invoke;

   -----------
   -- Owner --
   -----------

   overriding function Owner
    (Self : Slot_End) return not null Core.Connectables.Object_Access is
   begin
      return
        Core.Connectables.Connectable_Object'Class
         (Self.Object.all)'Unchecked_Access;
   end Owner;

   -------------
   -- To_Slot --
   -------------

   function To_Slot
    (Self : in out Abstract_Object'Class) return Slots_2.Slot'Class is
   begin
--      return Slot'(Object => Self'Unchecked_Access);
--  XXX A2JS: invalid code generated
      return Result : Slot (Self'Unchecked_Access);
   end To_Slot;

end Core.Connectables.Slots_0.Slots_1.Slots_2.Generic_Slots;
