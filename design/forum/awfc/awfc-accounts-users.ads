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
with League.Strings;

private with ESAPI.Users.Anonymous;
private with ESAPI.Users.Non_Anonymous;
private with ESAPI.Users.Stores;
with ESAPI.Users;

package AWFC.Accounts.Users is

   type User is limited interface and ESAPI.Users.User;

   type User_Access is access all User'Class;

   Anonymous_User : constant User_Access;

   not overriding function Get_Email
    (Self : not null access constant User)
       return League.Strings.Universal_String is abstract;
   --  Returns user's email address.

private

   -------------------------
   -- Anonymous_User_Type --
   -------------------------

   type Anonymous_User_Type is
     new ESAPI.Users.Anonymous.Anonymous_User
       and AWFC.Accounts.Users.User with null record;

   overriding function Get_Email
    (Self : not null access constant Anonymous_User_Type)
       return League.Strings.Universal_String;

   Anonymous_User_Object : aliased Anonymous_User_Type;

   Anonymous_User : constant User_Access := Anonymous_User_Object'Access;

   -----------------------------
   -- Non_Anonymous_User_Type --
   -----------------------------

   type Non_Anonymous_User_Type is
     new ESAPI.Users.Non_Anonymous.Non_Anonymous_User
       and AWFC.Accounts.Users.User with
   record
      Email : League.Strings.Universal_String;
   end record;

   overriding function Get_Email
    (Self : not null access constant Non_Anonymous_User_Type)
       return League.Strings.Universal_String;

   overriding function Initialize
    (Store : not null access ESAPI.Users.Stores.User_Store'Class)
       return Non_Anonymous_User_Type;

end AWFC.Accounts.Users;
