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
-- Copyright © 2016, Vadim Godunko <vgodunko@gmail.com>                     --
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

package Core.Connectables.Slots.Signals is

   pragma Preelaborate;

   type Signal (Owner : not null access Connectables.Connectable_Object'Class) is
     limited new Connectables.Slots.Connection_Manager with private;

   procedure Emit (Self : in out Signal);

private

   type Signal_End_Base is tagged;
   type Signal_End_Access is access all Signal_End_Base'Class;

   type Signal_End_Base (Signal : not null access Connectables.Slots.Signals.Signal'Class) is
     abstract tagged limited
   record
      Slot_End : Slot_End_Access;
      Next     : Signal_End_Access;
      Previous : Signal_End_Access;
   end record;

   not overriding procedure Invoke (Self : in out Signal_End_Base) is abstract;

   procedure Attach (Self : in out Signal_End_Base'Class);

   type Signal_End is new Signal_End_Base with null record;

   overriding procedure Invoke (Self : in out Signal_End);

   type Signal (Owner : not null access Connectables.Connectable_Object'Class) is
     limited new Connectables.Slots.Connection_Manager with
   record
      Head : Signal_End_Access;
      Tail : Signal_End_Access;
   end record;

   overriding procedure Connect
    (Self : in out Signal;
     Slot : Connectables.Slots.Slot'Class);

end Core.Connectables.Slots.Signals;