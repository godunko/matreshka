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
private with Ada.Containers.Hashed_Maps;

with Spikedog.HTTP_Session_Managers;

with OPM.Stores;

package AWFC.Accounts.Sessions.Stores is

--   procedure Update_Last_Accessed_Time (Session : not null Session_Access);
   --  Updates last_accessed_time to current time and update corresponding
   --  field in database.

   type Session_Manager is
     new OPM.Stores.Abstract_Store
       and Spikedog.HTTP_Session_Managers.HTTP_Session_Manager
         with private;

   overriding function Is_Session_Identifier_Valid
    (Self       : Session_Manager;
     Identifier : League.Strings.Universal_String) return Boolean;
   --  Returns True when given session identifier is valid (it can be processed
   --  by session manager, but not necessary points to any active session).

   overriding procedure Initialize (Self : in out Session_Manager);

   overriding function Get_Session
    (Self       : in out Session_Manager;
     Identifier : League.Strings.Universal_String)
       return access Servlet.HTTP_Sessions.HTTP_Session'Class;
   --  Returns session this specified identifier, or null when session with
   --  given identifier is not known. When session is found its last access
   --  time attribute is updated to current time.

   overriding function New_Session
    (Self : in out Session_Manager)
       return access Servlet.HTTP_Sessions.HTTP_Session'Class;

   procedure Update_User
    (Self    : in out Session_Manager'Class;
     Session : not null Session_Access);
   --  Update user identifer in database.

   procedure Update_Session_Identifier
    (Self    : in out Session_Manager'Class;
     Session : not null Session_Access;
     Old     : Session_Identifier);
   --  Updates session identifier in database.

private

   function Hash (Item : Session_Identifier) return Ada.Containers.Hash_Type;

   package Session_Maps is
     new Ada.Containers.Hashed_Maps
          (Session_Identifier, Session_Access, Hash, "=");

   type Session_Manager is
     new OPM.Stores.Abstract_Store
       and Spikedog.HTTP_Session_Managers.HTTP_Session_Manager with
   record
      Sessions : Session_Maps.Map;
   end record;

end AWFC.Accounts.Sessions.Stores;
