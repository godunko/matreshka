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
with League.Strings;

private with ESAPI.Users.Anonymous;
private with ESAPI.Users.Non_Anonymous;
private with ESAPI.Users.Stores;
with ESAPI.Users;

limited private with Security.Users.Stores;

package Security.Users is

   type User is limited interface and ESAPI.Users.User;

   type User_Access is access all User'Class;

   Anonymous_User : constant User_Access;

   not overriding function Get_Email
    (Self : not null access constant User)
       return League.Strings.Universal_String is abstract;
   --  Returns user's email address.

   not overriding function Get_Show_Advertisement
    (Self : not null access constant User) return Boolean is abstract;
   --  Returns True when advertisement should be displayed on pages.

private

   -------------------------
   -- Anonymous_User_Type --
   -------------------------

   type Anonymous_User_Type is
     new ESAPI.Users.Anonymous.Anonymous_User
       and Security.Users.User with null record;

   overriding function Get_Email
    (Self : not null access constant Anonymous_User_Type)
       return League.Strings.Universal_String;

   overriding function Get_Show_Advertisement
    (Self : not null access constant Anonymous_User_Type) return Boolean;

   Anonymous_User_Object : aliased Anonymous_User_Type;

   Anonymous_User : constant User_Access := Anonymous_User_Object'Access;

   -----------------------------
   -- Non_Anonymous_User_Type --
   -----------------------------

   type Non_Anonymous_User_Type is
     new ESAPI.Users.Non_Anonymous.Non_Anonymous_User
       and Security.Users.User with
   record
      Store              :
        not null access Security.Users.Stores.User_Store'Class;
      Email              : League.Strings.Universal_String;
      Show_Advertisement : Boolean;
   end record;

   overriding function Get_Email
    (Self : not null access constant Non_Anonymous_User_Type)
       return League.Strings.Universal_String;

   overriding function Get_Show_Advertisement
    (Self : not null access constant Non_Anonymous_User_Type) return Boolean;

   overriding function Initialize
    (Store : not null access ESAPI.Users.Stores.User_Store'Class)
       return Non_Anonymous_User_Type;

end Security.Users;
