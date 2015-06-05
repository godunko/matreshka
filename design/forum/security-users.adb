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
with Security.Users.Stores;

package body Security.Users is

   ---------------
   -- Get_Email --
   ---------------

   overriding function Get_Email
    (Self : not null access constant Anonymous_User_Type)
       return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Get_Email;

   ---------------
   -- Get_Email --
   ---------------

   overriding function Get_Email
    (Self : not null access constant Non_Anonymous_User_Type)
       return League.Strings.Universal_String is
   begin
      return Self.Email;
   end Get_Email;

   ----------------------------
   -- Get_Show_Advertisement --
   ----------------------------

   overriding function Get_Show_Advertisement
    (Self : not null access constant Anonymous_User_Type) return Boolean is
   begin
      return True;
   end Get_Show_Advertisement;

   ----------------------------
   -- Get_Show_Advertisement --
   ----------------------------

   overriding function Get_Show_Advertisement
    (Self : not null access constant Non_Anonymous_User_Type) return Boolean is
   begin
      return Self.Show_Advertisement;
   end Get_Show_Advertisement;

   ----------------
   -- Initialize --
   ----------------

   overriding function Initialize
    (Store : not null access ESAPI.Users.Stores.User_Store'Class)
       return Non_Anonymous_User_Type
   is
      S : Security.Users.Stores.User_Store'Class
        renames Security.Users.Stores.User_Store'Class (Store.all);

   begin
      return
        Non_Anonymous_User_Type'
         (ESAPI.Users.Non_Anonymous.Initialize (Store) with
            Store              => S'Access,
            Email              => S.Get_Email,
            Show_Advertisement => S.Get_Show_Advertisement);
   end Initialize;

end Security.Users;
