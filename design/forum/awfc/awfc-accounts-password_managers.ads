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
--  This package provides management of user's password.
------------------------------------------------------------------------------
private with Interfaces;

--  with League.Strings;
with OPM.Engines;

--  with AWFC.Accounts.Users;

package AWFC.Accounts.Password_Managers is

   pragma Elaborate_Body;

   type Confirmation_Code is private;

--   function To_Universal_String
--    (Item : Confirmation_Code) return League.Strings.Universal_String;
--   --  Converts confirmation code from internal representation into string.
--
--   function From_Universal_String
--    (Image : League.Strings.Universal_String) return Confirmation_Code;
--   --  Converts confirmation code from string into internal representation.

   type Password_Manager (Engine : not null access OPM.Engines.Engine'Class) is
     tagged limited private;

--   function Assign_Confirmation_Code
--  (User : not null AWFC.Accounts.Users.User_Access) return Confirmation_Code;
--   --  Generates random confirmation code for user and assign it. Removes
--   --  previous confirmation code assigned for user.
--
--   function Get_User
--    (Code : Confirmation_Code) return AWFC.Accounts.Users.User_Access;
--   --  Returns user to which specified confirmation code was assigned.
--
--   procedure Set_Password
--    (User     : not null access AWFC.Accounts.Users.User'Class;
--     Password : League.Strings.Universal_String);
--   --  Sets user's password.
--
--   function Password_Match
--    (User     : not null access AWFC.Accounts.Users.User'Class;
--     Password : League.Strings.Universal_String) return Boolean;
--   --  Verify user's password.
--
--   procedure Remove_Confirmation_Code
--    (User : not null access AWFC.Accounts.Users.User'Class);
--   --  Removes user's confirmation code.

private

   type Confirmation_Code is
     array (Natural range 0 .. 1) of Interfaces.Unsigned_64;
   for Confirmation_Code'Size use 128;

   type Password_Manager (Engine : not null access OPM.Engines.Engine'Class) is
     tagged limited null record;

end AWFC.Accounts.Password_Managers;
