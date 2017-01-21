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

package Core.Connectables is

   pragma Preelaborate;

   type Connectable_Object is abstract tagged limited private;

   type Object_Access is access all Connectable_Object'Class;

   not overriding procedure Finalize (Self : in out Connectable_Object);
   --  Release all object's connections.

private

   type Slot_End_Base is tagged;
   type Slot_End_Access is access all Slot_End_Base'Class;

   type Signal_End_Base is tagged;
   type Signal_End_Access is access all Signal_End_Base'Class;

   -------------------
   -- Slot_End_Base --
   -------------------

   type Slot_End_Base is abstract tagged limited record
      Signal_End : Signal_End_Access;
      Next       : Slot_End_Access;
      Previous   : Slot_End_Access;
   end record;

   not overriding function Owner
    (Self : Slot_End_Base) return not null Connectables.Object_Access
       is abstract;

   procedure Attach (Self : in out Slot_End_Base'Class);
   --  Attaches slot end object to list of slot ends of referenced object.

   procedure Detach (Self : in out Slot_End_Base'Class);
   --  Detaches slot end from the list of slot ends of the referenced object.

   ------------------
   -- Emitter_Base --
   ------------------

   type Emitter_Base is abstract tagged limited record
      Head : Signal_End_Access;
      Tail : Signal_End_Access;
   end record;

   ---------------------
   -- Signal_End_Base --
   ---------------------

   type Signal_End_Base (Emitter : not null access Emitter_Base'Class) is
     abstract tagged limited
   record
      Slot_End : Slot_End_Access;
      Next     : Signal_End_Access;
      Previous : Signal_End_Access;
   end record;

   procedure Attach (Self : in out Signal_End_Base'Class);

   procedure Detach (Self : in out Signal_End_Base'Class);

   ------------------------
   -- Connectable_Object --
   ------------------------

   type Connectable_Object is abstract tagged limited record
      Head : Slot_End_Access;
      Tail : Slot_End_Access;
   end record;

end Core.Connectables;
