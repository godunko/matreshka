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

package body Core.Objects.Listeners is

   ---------
   -- Add --
   ---------

   procedure Add
    (Self     : in out Listener_Registry'Class;
     Listener : not null Listener_Access) is
   begin
      if Listener.all not in Abstract_Object'Class then
         raise Constraint_Error
           with "Listener must be derived from Abstract_Object";

      else
         declare
            Aux : Listener_Record_Access
              := new Listener_Record
                      (Self'Unchecked_Access,
                       Abstract_Object'Class (Listener.all)'Unchecked_Access,
                       Listener);

         begin
            Aux.Connect;
         end;
      end if;
   end Add;

   --------------------
   -- Generic_Notify --
   --------------------

   procedure Generic_Notify (Self : Listener_Registry) is
      Current : Listener_Record_Access := Listener_Record_Access (Self.Head);

   begin
      while Current /= null loop
         begin
            Notify (Current.Listener.all);

         exception
            when others =>
               --  XXX For debug purposes it can be useful to report exception
               --  in some way.

               null;
         end;

         Current := Listener_Record_Access (Current.Registry_Next);
      end loop;
   end Generic_Notify;

   ----------------------
   -- Generic_Notify_1 --
   ----------------------

   procedure Generic_Notify_1
    (Self : Listener_Registry; Parameter : Parameter_Type)
   is
      Current : Listener_Record_Access := Listener_Record_Access (Self.Head);

   begin
      while Current /= null loop
         begin
            Notify (Current.Listener.all, Parameter);

         exception
            when others =>
               --  XXX For debug purposes it can be useful to report exception
               --  in some way.

               null;
         end;

         Current := Listener_Record_Access (Current.Registry_Next);
      end loop;
   end Generic_Notify_1;

   ------------
   -- Remove --
   ------------

   procedure Remove
    (Self     : in out Listener_Registry'Class;
     Listener : not null Listener_Access)
   is
      Current : Listener_Record_Access := Listener_Record_Access (Self.Head);

   begin
      while Current /= null loop
         exit when Current.Listener = Listener;

         Current := Listener_Record_Access (Current.Registry_Next);
      end loop;

      if Current /= null then
         Delete (Core.Objects.Listener_Record_Access (Current));
      end if;
   end Remove;

end Core.Objects.Listeners;
