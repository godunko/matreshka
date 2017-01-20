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
-- Copyright © 2017, Vadim Godunko <vgodunko@gmail.com>                     --
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

package body Core.Connectables.Slots_0.Slots_1.Signals is

   -------------
   -- Connect --
   -------------

   overriding procedure Connect
    (Self : in out Signal;
     Slot : Slots_0.Slot'Class)
   is
      Slot_End   : Slot_End_Access := Slot.Create_Slot_End;
      Signal_End : Signal_End_Access
        := new Signals.Signal_End (Self'Unchecked_Access);

   begin
      Slot_End.Attach;
      Signal_End.Attach;
      Signal_End.Slot_End := Slot_End;
   end Connect;

   -------------
   -- Connect --
   -------------

   overriding procedure Connect
    (Self : in out Signal;
     Slot : Slots_1.Slot'Class)
   is
      Slot_End   : Slot_End_Access := Slot.Create_Slot_End;
      Signal_End : Signal_End_Access
        := new Signals.Signal_End (Self'Unchecked_Access);

   begin
      Slot_End.Attach;
      Signal_End.Attach;
      Signal_End.Slot_End := Slot_End;
   end Connect;

   ----------
   -- Emit --
   ----------

   procedure Emit
    (Self        : in out Signal;
     Parameter_1 : Parameter_1_Type)
   is
      Current : Signal_End_Access := Self.Head;

   begin
      while Current /= null loop
         begin
            Signal_End'Class (Current.all).Invoke (Parameter_1);

         exception
            when others =>
               null;
         end;

         Current := Current.Next;
      end loop;
   end Emit;

   ------------
   -- Invoke --
   ------------

   procedure Invoke
    (Self        : in out Signal_End'Class;
     Parameter_1 : Parameter_1_Type) is
   begin
      if Self.Slot_End.all in Slot_End_1'Class then
         Slot_End_1'Class (Self.Slot_End.all).Invoke (Parameter_1);

      elsif Self.Slot_End.all in Slot_End_0'Class then
         Slot_End_0'Class (Self.Slot_End.all).Invoke;
      end if;
   end Invoke;

end Core.Connectables.Slots_0.Slots_1.Signals;
