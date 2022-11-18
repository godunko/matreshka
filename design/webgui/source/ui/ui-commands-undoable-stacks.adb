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

package body UI.Commands.Undoable.Stacks is

   procedure Emit_On_Can_Redo_Changed is
     new Undo_Stack_Listeners.Generic_Notify_1 (Boolean, On_Can_Redo_Changed);
   procedure Emit_On_Can_Undo_Changed is
     new Undo_Stack_Listeners.Generic_Notify_1 (Boolean, On_Can_Redo_Changed);
   procedure Emit_On_Clean_Changed is
     new Undo_Stack_Listeners.Generic_Notify_1 (Boolean, On_Can_Redo_Changed);

   ------------------
   -- Add_Listener --
   ------------------

   procedure Add_Listener
    (Self     : in out Undo_Stack'Class;
     Listener : not null Undo_Stack_Listener_Access) is
   begin
      Self.Listeners.Add (Listener);
   end Add_Listener;

   -----------------
   -- Begin_Macro --
   -----------------

   procedure Begin_Macro (Self : in out Undo_Stack'Class) is
   begin
      null;
   end Begin_Macro;

   --------------
   -- Can_Redo --
   --------------

   function Can_Redo (Self : Undo_Stack'Class) return Boolean is
   begin
      return False;
   end Can_Redo;

   --------------
   -- Can_Undo --
   --------------

   function Can_Undo (Self : Undo_Stack'Class) return Boolean is
   begin
      return False;
   end Can_Undo;

   -----------
   -- Clear --
   -----------

   procedure Clear (Self : in out Undo_Stack'Class) is
   begin
      null;
   end Clear;

   ---------------
   -- End_Macro --
   ---------------

   procedure End_Macro (Self : in out Undo_Stack'Class) is
   begin
      null;
   end End_Macro;

   ---------------
   -- Is_Active --
   ---------------

   function Is_Active (Self : Undo_Stack'Class) return Boolean is
   begin
      return False;
   end Is_Active;

   --------------
   -- Is_Clean --
   --------------

   function Is_Clean (Self : Undo_Stack'Class) return Boolean is
   begin
      return True;
   end Is_Clean;

   ----------
   -- Push --
   ----------

   procedure Push
    (Self    : in out Undo_Stack'Class;
     Command : not null UI.Commands.Undoable.Undoable_Command_Access) is
   begin
      null;
   end Push;

   ----------
   -- Redo --
   ----------

   procedure Redo (Self : in out Undo_Stack'Class) is
   begin
      null;
   end Redo;

   ---------------------
   -- Remove_Listener --
   ---------------------

   procedure Remove_Listener
    (Self     : in out Undo_Stack'Class;
     Listener : not null Undo_Stack_Listener_Access) is
   begin
      Self.Listeners.Remove (Listener);
   end Remove_Listener;

   ----------------
   -- Set_Active --
   ----------------

   procedure Set_Active (Self : in out Undo_Stack'Class) is
   begin
      null;
   end Set_Active;

   ---------------
   -- Set_Clean --
   ---------------

   procedure Set_Clean (Self : in out Undo_Stack'Class) is
   begin
      null;
   end Set_Clean;

   ----------
   -- Undo --
   ----------

   procedure Undo (Self : in out Undo_Stack'Class) is
   begin
      null;
   end Undo;

end UI.Commands.Undoable.Stacks;
