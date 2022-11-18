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
with Ada.Containers;

with League.Strings;

private with OPM.Stores;

limited private with AWFC.Accounts.Users.Stores;

package AWFC.Accounts.Users is

   type User_Identifier is private;

   Anonymous_User_Identifier : constant User_Identifier;
   --  XXX It can be reasonable to remove this constant to enforce use of
   --  User_Factory.Get_Anonymous_User subprogram.

   type User is limited interface;

   type User_Access is access all User'Class;

   not overriding function Get_User_Identifier
    (Self : not null access constant User) return User_Identifier is abstract;

   not overriding function Is_Anonymous
    (Self : not null access constant User) return Boolean is abstract;

   not overriding function Is_Enabled
    (Self : not null access constant User) return Boolean is abstract;

   not overriding procedure Enable (Self : not null access User) is abstract;
   --  Enable user's account.

   not overriding procedure Disable (Self : not null access User) is abstract;
   --  Disable user's account.

   not overriding function Get_Email
    (Self : not null access constant User)
       return League.Strings.Universal_String is abstract;
   --  Returns user's email address.

   function Hash (Item : User_Identifier) return Ada.Containers.Hash_Type;

private

   type User_Identifier is range 0 .. 2**63 - 1;

   Anonymous_User_Identifier : constant User_Identifier := 0;

   -------------------------
   -- Anonymous_User_Type --
   -------------------------

   type Anonymous_User_Type is
     limited new AWFC.Accounts.Users.User with null record;

   overriding procedure Disable (Self : not null access Anonymous_User_Type);

   overriding procedure Enable (Self : not null access Anonymous_User_Type);

   overriding function Get_Email
    (Self : not null access constant Anonymous_User_Type)
       return League.Strings.Universal_String;

   overriding function Get_User_Identifier
    (Self : not null access constant Anonymous_User_Type)
       return User_Identifier;

   overriding function Is_Anonymous
    (Self : not null access constant Anonymous_User_Type) return Boolean;

   overriding function Is_Enabled
    (Self : not null access constant Anonymous_User_Type) return Boolean;

   -----------------------------
   -- Non_Anonymous_User_Type --
   -----------------------------

   type Non_Anonymous_User_Type
    (Store : not null access AWFC.Accounts.Users.Stores.User_Store'Class)
       is limited new AWFC.Accounts.Users.User with
   record
      Identifier : User_Identifier;
      Email      : League.Strings.Universal_String;
      Enabled    : Boolean;
   end record;

   overriding procedure Disable
    (Self : not null access Non_Anonymous_User_Type);

   overriding procedure Enable
    (Self : not null access Non_Anonymous_User_Type);

   overriding function Get_Email
    (Self : not null access constant Non_Anonymous_User_Type)
       return League.Strings.Universal_String;

   overriding function Get_User_Identifier
    (Self : not null access constant Non_Anonymous_User_Type)
       return User_Identifier;

   overriding function Is_Anonymous
    (Self : not null access constant Non_Anonymous_User_Type) return Boolean;

   overriding function Is_Enabled
    (Self : not null access constant Non_Anonymous_User_Type) return Boolean;

   not overriding function Initialize
    (Store : not null access AWFC.Accounts.Users.Stores.User_Store'Class)
       return Non_Anonymous_User_Type;

end AWFC.Accounts.Users;
