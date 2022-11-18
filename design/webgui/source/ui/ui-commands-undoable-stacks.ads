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
private with Core.Objects.Listeners;

package UI.Commands.Undoable.Stacks is

   pragma Preelaborate;

   type Undo_Stack_Listener is limited interface;

   type Undo_Stack_Listener_Access is access all Undo_Stack_Listener'Class;

   not overriding procedure On_Can_Redo_Changed
    (Self     : in out Undo_Stack_Listener;
     Can_Redo : Boolean) is null;

   not overriding procedure On_Can_Undo_Changed
    (Self     : in out Undo_Stack_Listener;
     Can_Undo : Boolean) is null;

   not overriding procedure On_Clean_Changed
    (Self     : in out Undo_Stack_Listener;
     Is_Clean : Boolean) is null;

   type Undo_Stack is tagged limited private;

   type Undo_Stack_Access is access all Undo_Stack'Class;

   procedure Clear (Self : in out Undo_Stack'Class);

   procedure Push
    (Self    : in out Undo_Stack'Class;
     Command : not null UI.Commands.Undoable.Undoable_Command_Access);

   procedure Begin_Macro (Self : in out Undo_Stack'Class);

   procedure End_Macro (Self : in out Undo_Stack'Class);

   function Can_Undo (Self : Undo_Stack'Class) return Boolean;

   function Can_Redo (Self : Undo_Stack'Class) return Boolean;

   procedure Undo (Self : in out Undo_Stack'Class);

   procedure Redo (Self : in out Undo_Stack'Class);

   procedure Set_Active (Self : in out Undo_Stack'Class);

   function Is_Active (Self : Undo_Stack'Class) return Boolean;

   procedure Set_Clean (Self : in out Undo_Stack'Class);

   function Is_Clean (Self : Undo_Stack'Class) return Boolean;

   procedure Add_Listener
    (Self     : in out Undo_Stack'Class;
     Listener : not null Undo_Stack_Listener_Access);

   procedure Remove_Listener
    (Self     : in out Undo_Stack'Class;
     Listener : not null Undo_Stack_Listener_Access);

private

   package Undo_Stack_Listeners is
     new Core.Objects.Listeners
          (Undo_Stack_Listener, Undo_Stack_Listener_Access);

   type Undo_Stack is new Core.Objects.Abstract_Object with record
      Listeners : Undo_Stack_Listeners.Listener_Registry (Undo_Stack'Access);
   end record;

end UI.Commands.Undoable.Stacks;
