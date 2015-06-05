------------------------------------------------------------------------------
--                                                                          --
--                      House Designer's Smart Studio                       --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2014-2015, Vadim Godunko <vgodunko@gmail.com>                --
-- All rights reserved.                                                     --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------
with Spikedog.HTTP_Session_Managers;

with OPM.Stores;

package Server.Sessions.Controller is

   function Create_Session return not null Session_Access;

   function Get_Session (SID : Session_Identifier) return Session_Access;

   procedure Update_Last_Accessed_Time (Session : not null Session_Access);
   --  Updates last_accessed_time to current time and update corresponding
   --  field in database.

   procedure Update_User (Session : not null Session_Access);
   --  Update user identifer in database.

   procedure Update_Session_Identifier
    (Session : not null Session_Access;
     Old     : Session_Identifier);
   --  Updates session identifier in database.

   type Session_Manager is
     new OPM.Stores.Abstract_Store
       and Spikedog.HTTP_Session_Managers.HTTP_Session_Manager
         with null record;

   overriding function Is_Session_Identifier_Valid
    (Self       : Session_Manager;
     Identifier : League.Strings.Universal_String) return Boolean;
   --  Returns True when given session identifier is valid (it can be processed
   --  by session manager, but not necessary points to any active session).

   overriding procedure Initialize (Self : in out Session_Manager);

   overriding function Get_Session
    (Self       : Session_Manager;
     Identifier : League.Strings.Universal_String)
       return access Servlet.HTTP_Sessions.HTTP_Session'Class;
   --  Returns session this specified identifier, or null when session with
   --  given identifier is not known. When session is found its last access
   --  time attribute is updated to current time.

   overriding function New_Session
    (Self : Session_Manager)
       return access Servlet.HTTP_Sessions.HTTP_Session'Class;

end Server.Sessions.Controller;
