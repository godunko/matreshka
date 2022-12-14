------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2012, Vadim Godunko <vgodunko@gmail.com>                     --
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

package body League.Objects.Impl is

   --------------
   -- Children --
   --------------

   overriding function Children
    (Self : not null access constant Object_Impl)
       return League.Objects.Object_Access_Array
   is
      Result  : League.Objects.Object_Access_Array (1 .. Self.Children_Count);
      Last    : Natural := 0;
      Current : Object_Impl_Access := Self.First_Child;

   begin
      while Current /= null loop
         Last := Last + 1;
         Result (Last) := League.Objects.Object_Access (Current);

         Current := Current.Next_Sibling;
      end loop;

      return Result;
   end Children;

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self   : not null access Object_Impl'Class;
        Parent : access League.Objects.Object'Class := null) is
      begin
         --  Set object's parent.

         Self.Set_Parent (Parent);
      end Initialize;

   end Constructors;

   ---------------
   -- Destroyed --
   ---------------

   overriding function Destroyed
    (Self : not null access Object_Impl) return League.Signals.Signal is
   begin
      return Self.Destroyed.Signal;
   end Destroyed;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Object_Impl) is

      procedure Free is
        new Ada.Unchecked_Deallocation
             (Object_Impl'Class, Object_Impl_Access);

      Child : Object_Impl_Access;

   begin
      --  Notify about object destruction.

      Self.Destroyed.Emit;

      --  Disconnect signal-slot connections.

      Matreshka.Internals.Signals.Disconnect (Self.Connections);

      --  Destroy all children. Note, child removes itself from the parent's
      --  list of children byself.

      while Self.First_Child /= null loop
         Child := Self.First_Child;
         Free (Child);
      end loop;

      --  Remove object from parent's list of children.

      if Self.Parent /= null then
         if Self.Previous_Sibling /= null then
            Self.Previous_Sibling.Next_Sibling := Self.Next_Sibling;

         else
            Self.Parent.First_Child := Self.Next_Sibling;
         end if;

         if Self.Next_Sibling /= null then
            Self.Next_Sibling.Previous_Sibling := Self.Previous_Sibling;

         else
            Self.Parent.Last_Child := Self.Previous_Sibling;
         end if;

         Self.Next_Sibling := null;
         Self.Previous_Sibling := null;
      end if;

      --  Call user defined Finalize procedure.

      Finalize (Object_Impl'Class (Self)'Access);
   end Finalize;

   ------------
   -- Parent --
   ------------

   overriding function Parent
    (Self : not null access Object_Impl)
       return League.Objects.Object_Access is
   begin
      return League.Objects.Object_Access (Self.Parent);
   end Parent;

   ----------------
   -- Set_Parent --
   ----------------

   overriding procedure Set_Parent
    (Self   : not null access Object_Impl;
     Parent : access League.Objects.Object'Class)
   is
      P_Self   : constant not null Object_Impl_Access
        := Object_Impl_Access (Self);
      P_Parent : constant Object_Impl_Access := Object_Impl_Access (Parent);

   begin
      if Self.Parent /= null then
         raise Program_Error;
      end if;

      if Parent /= null then
         Self.Parent := P_Parent;

         if P_Parent.First_Child = null then
            P_Parent.First_Child := P_Self;
            P_Parent.Last_Child := P_Self;
            P_Parent.Children_Count := 1;

         else
            P_Self.Previous_Sibling := P_Parent.Last_Child;
            P_Self.Previous_Sibling.Next_Sibling := P_Self;
            P_Parent.Last_Child := P_Self;
            P_Parent.Children_Count := P_Parent.Children_Count + 1;
         end if;
      end if;
   end Set_Parent;

end League.Objects.Impl;
