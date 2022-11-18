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
with UI.Commands.Undoable.Stacks;

package UI.Commands.Undoable.Groups is

   pragma Preelaborate;

   type Undo_Group_Listener is limited interface;

   type Undo_Group_Listener_Access is access all Undo_Group_Listener'Class;

   not overriding procedure On_Active_Stack_Changed
    (Self  : Undo_Group_Listener;
     Stack : UI.Commands.Undoable.Stacks.Undo_Stack_Access) is null;

   not overriding procedure On_Can_Redo_Changed
    (Self     : in out Undo_Group_Listener;
     Can_Redo : Boolean) is null;

   not overriding procedure On_Can_Undo_Changed
    (Self     : in out Undo_Group_Listener;
     Can_Undo : Boolean) is null;

   not overriding procedure On_Clean_Changed
    (Self     : in out Undo_Group_Listener;
     Is_Clean : Boolean) is null;

   type Undo_Group is tagged limited private;

   procedure Add_Stack
    (Self  : in out Undo_Group'Class;
     Stack : not null UI.Commands.Undoable.Stacks.Undo_Stack_Access);

   procedure Remove_Stack
    (Self  : in out Undo_Group'Class;
     Stack : not null UI.Commands.Undoable.Stacks.Undo_Stack_Access);

   function Active_Stack
    (Self : Undo_Group'Class)
       return UI.Commands.Undoable.Stacks.Undo_Stack_Access;

   procedure Set_Active_Stack
    (Self  : in out Undo_Group'Class;
     Stack : UI.Commands.Undoable.Stacks.Undo_Stack_Access);

   function Can_Undo (Self : Undo_Group'Class) return Boolean;

   function Can_Redo (Self : Undo_Group'Class) return Boolean;

   procedure Undo (Self : in out Undo_Group'Class);

   procedure Redo (Self : in out Undo_Group'Class);

   procedure Add_Listener
    (Self     : in out Undo_Group'Class;
     Listener : not null Undo_Group_Listener_Access);

   procedure Remove_Listener
    (Self     : in out Undo_Group'Class;
     Listener : not null Undo_Group_Listener_Access);

private

   type Undo_Group is tagged limited null record;

end UI.Commands.Undoable.Groups;
