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
private with Interfaces;

with League.Calendars;
with League.Strings;
with Servlet.HTTP_Sessions;

limited private with AWFC.Accounts.Sessions.Stores;
with AWFC.Accounts.Users;

package AWFC.Accounts.Sessions is

   type Session_Identifier is private;

   type Session is limited new Servlet.HTTP_Sessions.HTTP_Session with private;

   type Session_Access is access all Session'Class;

   function Get_Session_Identifier
    (Self : not null access constant Session'Class) return Session_Identifier;
   --  Returns session identifier of specified session.

   function Get_User
    (Self : not null access constant Session'Class)
       return AWFC.Accounts.Users.User_Access;
   --  Returns user.

   procedure Set_User
    (Self : not null access Session'Class;
     User : not null AWFC.Accounts.Users.User_Access);
   --  Sets session's user. New session identifier is generated for session.

private

   type Session_Identifier is
     array (Positive range 1 .. 2) of Interfaces.Unsigned_64
       with Size => 128;

   type Session is limited new Servlet.HTTP_Sessions.HTTP_Session with record
      Store              :
        access AWFC.Accounts.Sessions.Stores.Session_Manager'Class;
      Identifier         : Session_Identifier;
      User               : AWFC.Accounts.Users.User_Access;
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

end AWFC.Accounts.Sessions;
