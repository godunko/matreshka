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

generic

package Core.Connectables.Slots_0.Slots_1.Slots_2.Generic_Emitters is

   pragma Preelaborate;

   type Emitter (Owner : not null access Connectable_Object'Class) is
     limited new Slots_2.Signal with private;

   procedure Emit
    (Self        : in out Emitter'Class;
     Parameter_1 : Parameter_1_Type;
     Parameter_2 : Parameter_2_Type);

private

   type Signal_End is abstract new Signal_End_Base with null record;

   not overriding procedure Invoke
    (Self        : in out Signal_End;
     Parameter_1 : Parameter_1_Type;
     Parameter_2 : Parameter_2_Type) is abstract;

   type Signal_End_0 is new Signal_End with null record;

   overriding procedure Invoke
    (Self        : in out Signal_End_0;
     Parameter_1 : Parameter_1_Type;
     Parameter_2 : Parameter_2_Type);

   type Signal_End_1 is new Signal_End with null record;

   overriding procedure Invoke
    (Self        : in out Signal_End_1;
     Parameter_1 : Parameter_1_Type;
     Parameter_2 : Parameter_2_Type);

   type Signal_End_2 is new Signal_End with null record;

   overriding procedure Invoke
    (Self        : in out Signal_End_2;
     Parameter_1 : Parameter_1_Type;
     Parameter_2 : Parameter_2_Type);

   -------------
   -- Emitter --
   -------------

   type Emitter (Owner : not null access Connectable_Object'Class) is
     limited new Emitter_Base and Slots_2.Signal with null record;

   overriding procedure Connect
    (Self : in out Emitter;
     Slot : Slots_0.Slot'Class);

   overriding procedure Connect
    (Self : in out Emitter;
     Slot : Slots_1.Slot'Class);

   overriding procedure Connect
    (Self : in out Emitter;
     Slot : Slots_2.Slot'Class);

end Core.Connectables.Slots_0.Slots_1.Slots_2.Generic_Emitters;
