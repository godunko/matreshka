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
with Ada.Containers.Hashed_Maps;

with League.Holders.Generic_Integers;
with League.Strings.Hash;
with SQL.Queries;

with OPM.Engines;

with ESAPI.Users.User_Identifier_Holders;

package body AWFC.Accounts.Users.Stores is

   type Pool_User_Access is access all User'Class;
   --  Internal type to allocate and deallocate instances of User object.

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   type Boolean_Integer is range 0 .. 1;

   package Boolean_Integer_Holders is
     new League.Holders.Generic_Integers (Boolean_Integer);

   function To_Boolean_Integer_Holder
    (Value : Boolean) return League.Holders.Holder;

   function From_Boolean_Integer_Holder
    (Value : League.Holders.Holder) return Boolean;

   package Email_Mappings is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           AWFC.Accounts.Users.User_Access,
           League.Strings.Hash,
           League.Strings."=",
           AWFC.Accounts.Users."=");

   package Identifier_Mappings is
     new Ada.Containers.Hashed_Maps
          (ESAPI.Users.User_Identifier,
           AWFC.Accounts.Users.User_Access,
           ESAPI.Users.Hash,
           ESAPI.Users."=",
           AWFC.Accounts.Users."=");

   Email_Cache      : Email_Mappings.Map;
   Identifier_Cache : Identifier_Mappings.Map;

   ------------
   -- Create --
   ------------

   function Create
    (Self  : not null access User_Store'Class;
     Email : League.Strings.Universal_String)
       return not null AWFC.Accounts.Users.User_Access
   is
      Insert_Query : SQL.Queries.SQL_Query := Self.Engine.Get_Database.Query;
      Select_Query : SQL.Queries.SQL_Query := Self.Engine.Get_Database.Query;

   begin
      Insert_Query.Prepare
       (+("INSERT INTO users (enabled, email, show_advertisement)"
            & " VALUES (:enabled, :email, :show_advertisement)"));
      Insert_Query.Bind_Value (+":email", League.Holders.To_Holder (Email));
      Insert_Query.Bind_Value (+":enabled", To_Boolean_Integer_Holder (False));
      Insert_Query.Bind_Value
       (+":show_advertisement", To_Boolean_Integer_Holder (True));
      Insert_Query.Execute;

      Select_Query.Prepare
       (+("SELECT user_identifier, email, enabled, show_advertisement"
            & " FROM users"
            & " WHERE email = :email"));
      Select_Query.Bind_Value (+":email", League.Holders.To_Holder (Email));
      Select_Query.Execute;

      if not Select_Query.Next then
         raise Program_Error;
      end if;

      Self.Identifier :=
        ESAPI.Users.User_Identifier_Holders.Element (Select_Query.Value (1));
      Self.Email      := League.Holders.Element (Select_Query.Value (2));
      Self.Enabled    := From_Boolean_Integer_Holder (Select_Query.Value (3));
      Self.Show_Advertisement :=
        From_Boolean_Integer_Holder (Select_Query.Value (4));

      return Result : constant not null AWFC.Accounts.Users.User_Access
        := AWFC.Accounts.Users.User_Access
            (Pool_User_Access'
              (new Non_Anonymous_User_Type'
                    (AWFC.Accounts.Users.Initialize (Self))))
      do
         Email_Cache.Insert (Self.Get_Email, Result);
         Identifier_Cache.Insert (Self.Get_User_Identifier, Result);
      end return;
   end Create;

   ---------------------------------
   -- From_Boolean_Integer_Holder --
   ---------------------------------

   function From_Boolean_Integer_Holder
    (Value : League.Holders.Holder) return Boolean
   is
      --  Why postgresql binding for boolean accepts integer, but return str?
      Image : constant League.Strings.Universal_String :=
        League.Holders.Element (Value);
   begin
      return Image.To_Wide_Wide_String = "t";
   end From_Boolean_Integer_Holder;

   ---------------
   -- Get_Email --
   ---------------

   not overriding function Get_Email
    (Self : not null access User_Store)
       return League.Strings.Universal_String is
   begin
      return Self.Email;
   end Get_Email;

   -----------------
   -- Get_Enabled --
   -----------------

   overriding function Get_Enabled
    (Self : not null access User_Store) return Boolean is
   begin
      return Self.Enabled;
   end Get_Enabled;

   ----------------------------
   -- Get_Show_Advertisement --
   ----------------------------

   not overriding function Get_Show_Advertisement
    (Self : not null access User_Store) return Boolean is
   begin
      return Self.Show_Advertisement;
   end Get_Show_Advertisement;

   -------------------------
   -- Get_User_Identifier --
   -------------------------

   overriding function Get_User_Identifier
    (Self : not null access User_Store) return ESAPI.Users.User_Identifier is
   begin
      return Self.Identifier;
   end Get_User_Identifier;

   ---------------
   -- Incarnate --
   ---------------

   function Incarnate
    (Self  : not null access User_Store'Class;
     Email : League.Strings.Universal_String)
       return AWFC.Accounts.Users.User_Access
   is
      Position : constant Email_Mappings.Cursor := Email_Cache.Find (Email);

   begin
      if Email_Mappings.Has_Element (Position) then
         return Email_Mappings.Element (Position);
      end if;

      declare
         Select_Query : SQL.Queries.SQL_Query
           := Self.Engine.Get_Database.Query;

      begin
         Select_Query.Prepare
          (+("SELECT user_identifier, email, enabled, show_advertisement"
               & " FROM users"
               & " WHERE email = :email"));
         Select_Query.Bind_Value (+":email", League.Holders.To_Holder (Email));
         Select_Query.Execute;

         if not Select_Query.Next then
            return null;
         end if;

         Self.Identifier :=
           ESAPI.Users.User_Identifier_Holders.Element
            (Select_Query.Value (1));
         Self.Email      := League.Holders.Element (Select_Query.Value (2));
         Self.Enabled    :=
           From_Boolean_Integer_Holder (Select_Query.Value (3));
         Self.Show_Advertisement :=
           From_Boolean_Integer_Holder (Select_Query.Value (4));

         return Result : constant AWFC.Accounts.Users.User_Access
           := AWFC.Accounts.Users.User_Access
               (Pool_User_Access'
                 (new Non_Anonymous_User_Type'
                       (AWFC.Accounts.Users.Initialize (Self))))
         do
            Email_Cache.Insert (Self.Get_Email, Result);
            Identifier_Cache.Insert (Self.Get_User_Identifier, Result);
         end return;
      end;
   end Incarnate;

   ---------------
   -- Incarnate --
   ---------------

   function Incarnate
    (Self       : not null access User_Store'Class;
     Identifier : ESAPI.Users.User_Identifier)
       return AWFC.Accounts.Users.User_Access
   is
      Position : constant Identifier_Mappings.Cursor
        := Identifier_Cache.Find (Identifier);

   begin
      if Identifier_Mappings.Has_Element (Position) then
         return Identifier_Mappings.Element (Position);
      end if;

      declare
         Select_Query : SQL.Queries.SQL_Query
           := Self.Engine.Get_Database.Query;

      begin
         Select_Query.Prepare
          (+("SELECT user_identifier, email, enabled, show_advertisement"
               & " FROM users"
               & " WHERE user_identifier = :user_identifier"));
         Select_Query.Bind_Value
          (+":user_identifier",
           ESAPI.Users.User_Identifier_Holders.To_Holder (Identifier));
         Select_Query.Execute;

         if not Select_Query.Next then
            return null;
         end if;

         Self.Identifier :=
           ESAPI.Users.User_Identifier_Holders.Element
            (Select_Query.Value (1));
         Self.Email      := League.Holders.Element (Select_Query.Value (2));
         Self.Enabled    :=
           From_Boolean_Integer_Holder (Select_Query.Value (3));
         Self.Show_Advertisement :=
           From_Boolean_Integer_Holder (Select_Query.Value (4));

         return Result : constant AWFC.Accounts.Users.User_Access
           := AWFC.Accounts.Users.User_Access
               (Pool_User_Access'
                 (new Non_Anonymous_User_Type'
                       (AWFC.Accounts.Users.Initialize (Self))))
         do
            Email_Cache.Insert (Self.Email, Result);
            Identifier_Cache.Insert (Self.Get_User_Identifier, Result);
         end return;
      end;
   end Incarnate;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out User_Store) is
   begin
      Self.Engine.Register_Store
       (AWFC.Accounts.Users.User'Tag, Self'Unchecked_Access);
   end Initialize;

   -------------------------------
   -- To_Boolean_Integer_Holder --
   -------------------------------

   function To_Boolean_Integer_Holder
    (Value : Boolean) return League.Holders.Holder is
   begin
      case Value is
         when False =>
            return Boolean_Integer_Holders.To_Holder (0);

         when True =>
            return Boolean_Integer_Holders.To_Holder (1);
      end case;
   end To_Boolean_Integer_Holder;

   --------------------
   -- Update_Enabled --
   --------------------

   overriding procedure Update_Enabled
    (Self : not null access User_Store;
     User : not null access constant ESAPI.Users.User'Class)
   is
      Query : SQL.Queries.SQL_Query := Self.Engine.Get_Database.Query;

   begin
      Query.Prepare
       (+("UPDATE users SET enabled = :enabled"
            & " WHERE user_identifier = :user_identifier"));
      Query.Bind_Value
       (+":user_identifier",
        ESAPI.Users.User_Identifier_Holders.To_Holder
         (User.Get_User_Identifier));
      Query.Bind_Value
       (+":enabled", To_Boolean_Integer_Holder (User.Is_Enabled));
      Query.Execute;
      Self.Engine.Get_Database.Commit;
   end Update_Enabled;

begin
   Identifier_Cache.Insert
    (ESAPI.Users.Anonymous_User_Identifier,
     AWFC.Accounts.Users.Anonymous_User);
end AWFC.Accounts.Users.Stores;
