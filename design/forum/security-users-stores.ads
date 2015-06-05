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
with OPM.Stores;

with ESAPI.Users.Stores;

package Security.Users.Stores is

   type User_Store is
     new OPM.Stores.Abstract_Store
       and ESAPI.Users.Stores.User_Store with private;

   type User_Store_Access is access all User_Store'Class;

   function Create
    (Self  : not null access User_Store'Class;
     Email : League.Strings.Universal_String)
       return not null Security.Users.User_Access;

   function Incarnate
    (Self       : not null access User_Store'Class;
     Identifier : ESAPI.Users.User_Identifier)
       return Security.Users.User_Access;

   function Incarnate
    (Self  : not null access User_Store'Class;
     Email : League.Strings.Universal_String)
       return Security.Users.User_Access;

   not overriding function Get_Email
    (Self : not null access User_Store) return League.Strings.Universal_String;

   not overriding function Get_Show_Advertisement
    (Self : not null access User_Store) return Boolean;

private

   type User_Store is
     new OPM.Stores.Abstract_Store
       and ESAPI.Users.Stores.User_Store with record
      Identifier         : ESAPI.Users.User_Identifier;
      Enabled            : Boolean;
      Email              : League.Strings.Universal_String;
      Show_Advertisement : Boolean;
   end record;

   overriding procedure Initialize (Self : in out User_Store);

   overriding function Get_User_Identifier
    (Self : not null access User_Store) return ESAPI.Users.User_Identifier;

   overriding function Get_Enabled
    (Self : not null access User_Store) return Boolean;

   overriding procedure Update_Enabled
    (Self : not null access User_Store;
     User : not null access constant ESAPI.Users.User'Class);

end Security.Users.Stores;
