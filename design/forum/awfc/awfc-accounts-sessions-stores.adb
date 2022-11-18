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
with Ada.Streams;

with League.Base_Codecs;
with League.Holders;
with League.Stream_Element_Vectors;
with League.Strings.Hash;
with SQL.Queries;

with AWFC.Accounts.Users.Stores;
with AWFC.Accounts.Users.User_Identifier_Holders;
with OPM.Engines;

package body AWFC.Accounts.Sessions.Stores is

   use type Ada.Streams.Stream_Element_Offset;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   function To_Session_Identifier
    (Item : League.Strings.Universal_String) return Session_Identifier;
   --  Converts string into session identifier. Raises Constraint_Error when
   --  conversion is impossible for some reason.

   procedure To_Session_Identifier
    (Item       : League.Strings.Universal_String;
     Identifier : out Session_Identifier;
     Success    : out Boolean);
   --  Converts string into session identifier. Sets Success to False when
   --  conversion is impossible for some reason.

   function Get_Session
    (Self       : in out Session_Manager'Class;
     Identifier : Session_Identifier)
       return access Servlet.HTTP_Sessions.HTTP_Session'Class;

   -----------------
   -- Get_Session --
   -----------------

   overriding function Get_Session
    (Self       : in out Session_Manager;
     Identifier : League.Strings.Universal_String)
       return access Servlet.HTTP_Sessions.HTTP_Session'Class
   is
      SID     : Session_Identifier;
      Success : Boolean;

   begin
      To_Session_Identifier (Identifier, SID, Success);

      if not Success then
         return null;
      end if;

      return Self.Get_Session (SID);
   end Get_Session;

   -----------------
   -- Get_Session --
   -----------------

   function Get_Session
    (Self       : in out Session_Manager'Class;
     Identifier : Session_Identifier)
       return access Servlet.HTTP_Sessions.HTTP_Session'Class
   is
      use type Session_Maps.Cursor;

      Position : constant Session_Maps.Cursor
        := Self.Sessions.Find (Identifier);

   begin
      if Position /= Session_Maps.No_Element then
         return Session_Maps.Element (Position);

      else
         declare
            Query  : SQL.Queries.SQL_Query
              := Self.Engine.Get_Database.Query;
            User   : AWFC.Accounts.Users.User_Access;
            Result : Session_Access;

         begin
            Query.Prepare
             (+("SELECT session_identifier, user_identifier, creation_time,"
                  & " last_accessed_time FROM sessions"
                  & " WHERE session_identifier = :session_identifier"));
            Query.Bind_Value
             (+":session_identifier",
              League.Holders.To_Holder (To_Universal_String (Identifier)));
            Query.Execute;

            if not Query.Next then
               return null;
            end if;

            User :=
              AWFC.Accounts.Users.Stores.User_Store'Class
               (Self.Engine.Get_Store
                 (AWFC.Accounts.Users.User'Tag).all).Incarnate
                   (AWFC.Accounts.Users.User_Identifier_Holders.Element
                     (Query.Value (2)));

            Result :=
              new Session'
                   (Store         => Self'Unchecked_Access,
                    Identifier    =>
                      To_Session_Identifier
                       (League.Holders.Element (Query.Value (1))),
                    User          => User,
                    Creation_Time => League.Holders.Element (Query.Value (3)),
                    Last_Accessed_Time =>
                      League.Holders.Element (Query.Value (4)));
            Self.Sessions.Insert (Result.Get_Session_Identifier, Result);

            return Result;
         end;
      end if;
   end Get_Session;

   ----------
   -- Hash --
   ----------

   function Hash (Item : Session_Identifier) return Ada.Containers.Hash_Type is
   begin
      return League.Strings.Hash (To_Universal_String (Item));
   end Hash;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out Session_Manager) is
   begin
      Self.Engine.Register_Store
       (AWFC.Accounts.Sessions.Session'Tag, Self'Unchecked_Access);
   end Initialize;

   ---------------------------------
   -- Is_Session_Identifier_Valid --
   ---------------------------------

   overriding function Is_Session_Identifier_Valid
    (Self       : Session_Manager;
     Identifier : League.Strings.Universal_String) return Boolean
   is
      SID     : Session_Identifier;
      Success : Boolean;

   begin
      To_Session_Identifier (Identifier, SID, Success);

      return Success;
   end Is_Session_Identifier_Valid;

   -----------------
   -- New_Session --
   -----------------

   overriding function New_Session
    (Self : in out Session_Manager)
       return access Servlet.HTTP_Sessions.HTTP_Session'Class
   is
      Query : SQL.Queries.SQL_Query       := Self.Engine.Get_Database.Query;
      SID   : constant Session_Identifier := Generate_Session_Identifier;

   begin
      Query.Prepare
       (+("INSERT INTO sessions (session_identifier, user_identifier,"
            & " creation_time, last_accessed_time)"
            & " VALUES (:session_identifier, :user_identifier, :creation_time,"
            & " :last_accessed_time)"));
      Query.Bind_Value
       (+":session_identifier",
        League.Holders.To_Holder (To_Universal_String (SID)));
      Query.Bind_Value
       (+":user_identifier",
        AWFC.Accounts.Users.User_Identifier_Holders.To_Holder
         (AWFC.Accounts.Users.Anonymous_User_Identifier));
      Query.Bind_Value
       (+":creation_time",
        League.Holders.To_Holder (League.Calendars.Clock));
      Query.Bind_Value
       (+":last_accessed_time",
        League.Holders.To_Holder (League.Calendars.Clock));
      Query.Execute;
      Self.Engine.Get_Database.Commit;

      return Self.Get_Session (SID);
   end New_Session;

   ---------------------------
   -- To_Session_Identifier --
   ---------------------------

   procedure To_Session_Identifier
    (Item       : League.Strings.Universal_String;
     Identifier : out Session_Identifier;
     Success    : out Boolean)
   is
      Raw     : Ada.Streams.Stream_Element_Array
                 (1 .. Session_Identifier'Max_Size_In_Storage_Elements)
                    with Import     => True,
                         Convention => Ada,
                         Address    => Identifier'Address;
      Decoded : League.Stream_Element_Vectors.Stream_Element_Vector;

   begin
      League.Base_Codecs.From_Base_64_URL (Item, Decoded, Success);

      if not Success then
         return;
      end if;

      if Decoded.Length /= Session_Identifier'Max_Size_In_Storage_Elements then
         Success := False;

         return;
      end if;

      Raw := Decoded.To_Stream_Element_Array;
      Success := True;
   end To_Session_Identifier;

   ---------------------------
   -- To_Session_Identifier --
   ---------------------------

   function To_Session_Identifier
    (Item : League.Strings.Universal_String) return Session_Identifier
   is
      Decoded : constant League.Stream_Element_Vectors.Stream_Element_Vector
        := League.Base_Codecs.From_Base_64_URL (Item);

   begin
      if Decoded.Length /= Session_Identifier'Max_Size_In_Storage_Elements then
         raise Constraint_Error with "Mailformed SID";
      end if;

      declare
         Raw    : constant Ada.Streams.Stream_Element_Array
           := Decoded.To_Stream_Element_Array;
         for Raw'Alignment use Interfaces.Unsigned_64'Alignment;
         Result : constant Session_Identifier
           with Import     => True,
                Convention => Ada,
                Address    => Raw'Address;

      begin
         return Result;
      end;
   end To_Session_Identifier;

   -------------------------------
   -- Update_Last_Accessed_Time --
   -------------------------------

--   procedure Update_Last_Accessed_Time (Session : not null Session_Access) is
--      Query : SQL.Queries.SQL_Query := Store.Engine.Get_Database.Query;
--
--   begin
--      Session.Last_Accessed_Time := League.Calendars.Clock;
--
--      Query.Prepare
--       (+("UPDATE sessions SET last_accessed_time = :last_accessed_time"
--            & " WHERE session_identifier = :session_identifier"));
--      Query.Bind_Value
--       (+":session_identifier",
--        League.Holders.To_Holder (To_Universal_String (Session.SID)));
--      Query.Bind_Value
--       (+":last_accessed_time",
--        League.Holders.To_Holder (Session.Last_Accessed_Time));
--      Query.Execute;
--      Store.Engine.Get_Database.Commit;
--   end Update_Last_Accessed_Time;

   -------------------------------
   -- Update_Session_Identifier --
   -------------------------------

   procedure Update_Session_Identifier
    (Self    : in out Session_Manager'Class;
     Session : not null Session_Access;
     Old     : Session_Identifier)
   is
      Query : SQL.Queries.SQL_Query := Self.Engine.Get_Database.Query;

   begin
      Query.Prepare
       (+("UPDATE sessions SET session_identifier = :session_identifier"
            & " WHERE session_identifier = :old_session_identifier"));
      Query.Bind_Value
       (+":session_identifier",
        League.Holders.To_Holder (To_Universal_String (Session.Identifier)));
      Query.Bind_Value
       (+":old_session_identifier",
        League.Holders.To_Holder (To_Universal_String (Old)));
      Query.Execute;
      Self.Engine.Get_Database.Commit;
   end Update_Session_Identifier;

   -----------------
   -- Update_User --
   -----------------

   procedure Update_User
    (Self    : in out Session_Manager'Class;
     Session : not null Session_Access)
   is
      Query : SQL.Queries.SQL_Query := Self.Engine.Get_Database.Query;

   begin
      Query.Prepare
       (+("UPDATE sessions SET user_identifier = :user_identifier"
            & " WHERE session_identifier = :session_identifier"));
      Query.Bind_Value
       (+":user_identifier",
        AWFC.Accounts.Users.User_Identifier_Holders.To_Holder
         (Session.User.Get_User_Identifier));
      Query.Bind_Value
       (+":session_identifier",
        League.Holders.To_Holder (To_Universal_String (Session.Identifier)));
      Query.Execute;
      Self.Engine.Get_Database.Commit;
   end Update_User;

end AWFC.Accounts.Sessions.Stores;
