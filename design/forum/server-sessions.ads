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
private with Interfaces;

with League.Calendars;
with League.Strings;
with Servlet.HTTP_Sessions;

with Security.Users;

package Server.Sessions is

   type Session_Identifier is private;

   type Session is limited new Servlet.HTTP_Sessions.HTTP_Session with private;

   type Session_Access is access all Session'Class;

   function Get_Session_Identifier
    (Self : not null access constant Session'Class) return Session_Identifier;
   --  Returns session identifier of specified session.

   function Get_User
    (Self : not null access constant Session'Class)
       return Security.Users.User_Access;
   --  Returns user.

   procedure Set_User
    (Self : not null access Session'Class;
     User : not null Security.Users.User_Access);
   --  Sets session's user. New session identifier is generated for session.

private

   type Session_Identifier is
     array (Positive range 1 .. 2) of Interfaces.Unsigned_64
       with Size => 128;

   type Session is limited new Servlet.HTTP_Sessions.HTTP_Session with record
      SID                : Session_Identifier;
      User               : Security.Users.User_Access;
      Creation_Time      : League.Calendars.Date_Time;
      Last_Accessed_Time : League.Calendars.Date_Time;
   end record;

   overriding function Get_Id
    (Self : Session) return League.Strings.Universal_String;
   --  Returns a string containing the unique identifier assigned to this
   --  session. The identifier is assigned by the servlet container and is
   --  implementation dependent.

   function Generate_Session_Identifier return Session_Identifier;
   --  Generates session identifer.

   function To_Universal_String
    (Item : Session_Identifier) return League.Strings.Universal_String;
   --  Converts session identifier from internal representation into textual
   --  representation.

end Server.Sessions;
