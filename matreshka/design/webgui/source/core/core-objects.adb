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
with Ada.Unchecked_Deallocation;

package body Core.Objects is

   -------------
   -- Connect --
   -------------

   procedure Connect (Self : not null access Listener_Record'Class) is
   begin
      --  Append to list of listener records of collection.

      if Self.Registry.Head = null then
         Self.Registry.Head     := Listener_Record_Access (Self);
         Self.Registry.Tail     := Listener_Record_Access (Self);
         Self.Registry_Previous := null;
         Self.Registry_Next     := null;

      else
         Self.Registry_Previous           := Self.Registry.Tail;
         Self.Registry_Next               := null;
         Self.Registry.Tail.Registry_Next := Listener_Record_Access (Self);
         Self.Registry.Tail               := Listener_Record_Access (Self);
      end if;

      --  Append to list of listener records of object.

      if Self.Object.Listener_Head = null then
         Self.Object.Listener_Head := Listener_Record_Access (Self);
         Self.Object.Listener_Tail := Listener_Record_Access (Self);
         Self.Object_Previous      := null;
         Self.Object_Next          := null;

      else
         Self.Object_Previous      := Self.Object.Listener_Tail;
         Self.Object_Next          := null;
         Self.Object.Listener_Tail.Object_Next :=
           Listener_Record_Access (Self);
         Self.Object.Listener_Tail := Listener_Record_Access (Self);
      end if;
   end Connect;

   ------------
   -- Delete --
   ------------

   procedure Delete (Item : not null Listener_Record_Access) is

      procedure Free is
        new Ada.Unchecked_Deallocation
             (Listener_Record'Class, Listener_Record_Access);

     Aux : Listener_Record_Access := Item;

   begin
      Aux.Disconnect;
      Free (Aux);
   end Delete;

   ----------------
   -- Disconnect --
   ----------------

   procedure Disconnect (Self : not null access Listener_Record'Class) is
      Previous : Listener_Record_Access;
      Next     : Listener_Record_Access;

   begin
      --  Remove from list of listener records of collection.

      Previous               := Self.Registry_Previous;
      Next                   := Self.Registry_Next;
      Self.Registry_Previous := null;
      Self.Registry_Next     := null;

      if Previous /= null then
         Previous.Registry_Next := Next;
      end if;

      if Next /= null then
         Next.Registry_Previous := Previous;
      end if;

      if Self.Registry.Head = Self then
         Self.Registry.Head := Next;
      end if;

      if Self.Registry.Tail = Self then
         Self.Registry.Tail := Previous;
      end if;

      --  Remove from list of listener records of object.

      Previous             := Self.Object_Previous;
      Next                 := Self.Object_Next;
      Self.Object_Previous := null;
      Self.Object_Next     := null;

      if Previous /= null then
         Previous.Object_Next := Next;
      end if;

      if Next /= null then
         Next.Object_Previous := Previous;
      end if;

      if Self.Object.Listener_Head = Self then
         Self.Object.Listener_Head := Next;
      end if;

      if Self.Object.Listener_Tail = Self then
         Self.Object.Listener_Tail := Previous;
      end if;
   end Disconnect;

   --------------
   -- Finalize --
   --------------

   not overriding procedure Finalize (Self : in out Listener_Registry) is
   begin
      while Self.Head /= null loop
         Delete (Self.Head);
         --  Call of Delete will remove first element from this list, thus Head
         --  will point to next listener record (of any).
      end loop;
   end Finalize;

   --------------
   -- Finalize --
   --------------

   not overriding procedure Finalize (Self : in out Abstract_Object) is
   begin
      while Self.Listener_Head /= null loop
         Delete (Self.Listener_Head);
         --  Call of Delete will remove first element from this list, thus Head
         --  will point to next listener record (of any).
      end loop;
   end Finalize;

end Core.Objects;
