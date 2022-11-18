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
--  Abstract_Object is base class for almost all classes of library. Its
--  primary resposibility is to simplify management of listeners.

package Core.Objects is

   pragma Preelaborate;

   type Abstract_Object is abstract tagged limited private;

   not overriding procedure Finalize (Self : in out Abstract_Object);

private

   type Listener_Registry is tagged;

   type Listener_Record is tagged;
   type Listener_Record_Access is access all Listener_Record'Class;

   ---------------------
   -- Listener_Record --
   ---------------------

   type Listener_Record
    (Registry : not null access Listener_Registry'Class;
     Object   : not null access Abstract_Object'Class)
       is tagged limited record
      Registry_Previous : Listener_Record_Access;
      Registry_Next     : Listener_Record_Access;
      --  Doubly linked list of elements of registry of listeners.

      Object_Previous   : Listener_Record_Access;
      Object_Next       : Listener_Record_Access;
      --  Doubly linked list of elements of listened objects.
   end record;

   procedure Disconnect (Self : not null access Listener_Record'Class);

   procedure Connect (Self : not null access Listener_Record'Class);

   procedure Delete (Item : not null Listener_Record_Access);

   -----------------------
   -- Listener_Registry --
   -----------------------

   type Listener_Registry
    (Owner : not null access Abstract_Object'Class) is abstract tagged limited
   record
      Head : Listener_Record_Access;
      Tail : Listener_Record_Access;
   end record;

   not overriding procedure Finalize (Self : in out Listener_Registry);
   --  Disconnect all listeners.

   ---------------------
   -- Abstract_Object --
   ---------------------

   type Abstract_Object is abstract tagged limited record
      Listener_Head : Listener_Record_Access;
      Listener_Tail : Listener_Record_Access;
      --  Doubly linked list of listener records that object is listening for.
   end record;

end Core.Objects;
