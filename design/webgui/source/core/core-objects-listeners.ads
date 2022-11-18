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

generic
   type Listener is limited interface;
   type Listener_Access is access all Listener'Class;

package Core.Objects.Listeners is

   pragma Preelaborate;

   type Listener_Registry
    (Owner : not null access Core.Objects.Abstract_Object'Class) is
       tagged limited private;

   procedure Add
    (Self     : in out Listener_Registry'Class;
     Listener : not null Listener_Access);

   procedure Remove
    (Self     : in out Listener_Registry'Class;
     Listener : not null Listener_Access);

   generic
      with procedure Notify (Self : in out Listener) is abstract;

   procedure Generic_Notify (Self : Listener_Registry);

   generic
      type Parameter_Type is limited private;

      with procedure Notify
       (Self : in out Listener; Parameter : Parameter_Type) is abstract;

   procedure Generic_Notify_1
    (Self : Listener_Registry; Parameter : Parameter_Type);

private

   type Listener_Registry
    (Owner : not null access Core.Objects.Abstract_Object'Class) is
       new Core.Objects.Listener_Registry (Owner) with null record;

   type Listener_Record
    (Collection : not null access Listener_Registry'Class;
     Object     : not null access Abstract_Object'Class;
     Listener   : not null access Core.Objects.Listeners.Listener'Class) is
       new Core.Objects.Listener_Record (Collection, Object) with null record;

   type Listener_Record_Access is access all Listener_Record'Class;

end Core.Objects.Listeners;
