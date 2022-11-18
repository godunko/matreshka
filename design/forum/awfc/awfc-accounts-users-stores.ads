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

private with League.Strings.Hash;

with OPM.Stores;

with AWFC.Accounts.Users.Factories;

package AWFC.Accounts.Users.Stores is

   type User_Store is limited new OPM.Stores.Abstract_Store
     and AWFC.Accounts.Users.Factories.User_Factory with private;

   type User_Store_Access is access all User_Store'Class;

   function Create
    (Self  : not null access User_Store'Class;
     Email : League.Strings.Universal_String)
       return not null AWFC.Accounts.Users.User_Access;

   function Incarnate
    (Self       : not null access User_Store'Class;
     Identifier : AWFC.Accounts.Users.User_Identifier)
       return AWFC.Accounts.Users.User_Access;

   function Incarnate
    (Self  : not null access User_Store'Class;
     Email : League.Strings.Universal_String)
       return AWFC.Accounts.Users.User_Access;

   function Get_User_Identifier
    (Self : not null access User_Store'Class)
       return AWFC.Accounts.Users.User_Identifier;

   function Get_Enabled
    (Self : not null access User_Store'Class) return Boolean;

   procedure Update_Enabled
    (Self : not null access User_Store'Class;
     User : not null access constant AWFC.Accounts.Users.User'Class);

   not overriding function Get_Email
    (Self : not null access User_Store) return League.Strings.Universal_String;

   overriding function Get_Anonymous_User
    (Self : in out User_Store) return not null AWFC.Accounts.Users.User_Access;

private

   package Email_Mappings is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           AWFC.Accounts.Users.User_Access,
           League.Strings.Hash,
           League.Strings."=",
           AWFC.Accounts.Users."=");

   package Identifier_Mappings is
     new Ada.Containers.Hashed_Maps
          (AWFC.Accounts.Users.User_Identifier,
           AWFC.Accounts.Users.User_Access,
           AWFC.Accounts.Users.Hash,
           AWFC.Accounts.Users."=",
           AWFC.Accounts.Users."=");

   type User_Store is limited new OPM.Stores.Abstract_Store
     and AWFC.Accounts.Users.Factories.User_Factory with record
      Email_Cache      : Email_Mappings.Map;
      Identifier_Cache : Identifier_Mappings.Map;

      Identifier       : AWFC.Accounts.Users.User_Identifier;
      Enabled          : Boolean;
      Email            : League.Strings.Universal_String;
   end record;

   overriding procedure Initialize (Self : in out User_Store);

end AWFC.Accounts.Users.Stores;
