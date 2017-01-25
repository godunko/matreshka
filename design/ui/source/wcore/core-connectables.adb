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
with Ada.Unchecked_Deallocation;

package body Core.Connectables is

   procedure Disconnect
    (Signal : Signal_End_Access;
     Slot   : Slot_End_Access);

   ------------
   -- Attach --
   ------------

   procedure Attach (Self : in out Signal_End_Base'Class) is
   begin
      if Self.Emitter.Head = null then
         Self.Emitter.Head := Self'Unchecked_Access;
         Self.Emitter.Tail := Self'Unchecked_Access;

      else
         Self.Previous := Self.Emitter.Tail;
         Self.Emitter.Tail.Next := Self'Unchecked_Access;
         Self.Emitter.Tail := Self'Unchecked_Access;
      end if;
   end Attach;

   ------------
   -- Attach --
   ------------

   procedure Attach (Self : in out Slot_End_Base'Class) is
      Owner : constant not null Object_Access := Self.Owner;

   begin
      if Owner.Head = null then
         Owner.Head := Self'Unchecked_Access;
         Owner.Tail := Self'Unchecked_Access;

      else
         Self.Previous := Owner.Tail;
         Owner.Tail.Next := Self'Unchecked_Access;
         Owner.Tail := Self'Unchecked_Access;
      end if;
   end Attach;

   ------------
   -- Detach --
   ------------

   procedure Detach (Self : in out Signal_End_Base'Class) is
   begin
      if Self.Emitter.Head = Self'Unchecked_Access then
         Self.Emitter.Head := Self.Next;
      end if;

      if Self.Emitter.Tail = Self'Unchecked_Access then
         Self.Emitter.Tail := Self.Previous;
      end if;

      if Self.Next /= null then
         Self.Next.Previous := Self.Previous;
      end if;

      if Self.Previous /= null then
         Self.Previous.Next := Self.Next;
      end if;
   end Detach;

   ------------
   -- Detach --
   ------------

   procedure Detach (Self : in out Slot_End_Base'Class) is
      Owner : constant not null Object_Access := Self.Owner;

   begin
      if Owner.Head = Self'Unchecked_Access then
         Owner.Head := Self.Next;
      end if;

      if Owner.Tail = Self'Unchecked_Access then
         Owner.Tail := Self.Previous;
      end if;

      if Self.Next /= null then
         Self.Next.Previous := Self.Previous;
      end if;

      if Self.Previous /= null then
         Self.Previous.Next := Self.Next;
      end if;
   end Detach;

   ----------------
   -- Disconnect --
   ----------------

   procedure Disconnect
    (Signal : Signal_End_Access;
     Slot   : Slot_End_Access)
   is
      procedure Free is
        new Ada.Unchecked_Deallocation
             (Signal_End_Base'Class, Signal_End_Access);

      procedure Free is
        new Ada.Unchecked_Deallocation (Slot_End_Base'Class, Slot_End_Access);

     Aux_Signal : Signal_End_Access := Signal;
     Aux_Slot   : Slot_End_Access   := Slot;

   begin
      Aux_Signal.Detach;
      Aux_Slot.Detach;
      Free (Aux_Signal);
      Free (Aux_Slot);
   end Disconnect;

   --------------
   -- Finalize --
   --------------

   not overriding procedure Finalize (Self : in out Connectable_Object) is
   begin
      while Self.Head /= null loop
         Disconnect (Self.Head.Signal_End, Self.Head);
      end loop;
   end Finalize;

end Core.Connectables;
