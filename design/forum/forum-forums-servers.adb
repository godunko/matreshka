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
with OPM.Stores;

with AWFC.Accounts.Sessions.Stores;
with AWFC.Accounts.Users.Stores;

package body Forum.Forums.Servers is

   ------------------------------
   -- Get_HTTP_Session_Manager --
   ------------------------------

   function Get_HTTP_Session_Manager
    (Self : Server_Forum'Class)
       return
         not null Spikedog.HTTP_Session_Managers.HTTP_Session_Manager_Access is
   begin
      return
        Spikedog.HTTP_Session_Managers.HTTP_Session_Manager_Access
         (Self.Engine.Get_Store (AWFC.Accounts.Sessions.Session'Tag));
   end Get_HTTP_Session_Manager;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self    : in out Server_Forum'Class;
     Driver  : League.Strings.Universal_String;
     Options : SQL.Options.SQL_Options)
   is
      Aux : OPM.Stores.Store_Access;

   begin
      Standard.Forum.Forums.Initialize (Self, Driver, Options);

      Self.Password_Manager :=
        new AWFC.Accounts.Password_Managers.Password_Manager
             (Self.Engine'Unchecked_Access);

      Aux :=
        new AWFC.Accounts.Sessions.Stores.Session_Manager
             (Self.Engine'Unchecked_Access);
      Aux.Initialize;

      Aux :=
        new AWFC.Accounts.Users.Stores.User_Store
             (Self.Engine'Unchecked_Access);
      Aux.Initialize;
   end Initialize;

end Forum.Forums.Servers;
