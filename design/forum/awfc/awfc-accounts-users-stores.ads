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
with OPM.Stores;

with ESAPI.Users.Stores;

package AWFC.Accounts.Users.Stores is

   type User_Store is
     new OPM.Stores.Abstract_Store
       and ESAPI.Users.Stores.User_Store with private;

   type User_Store_Access is access all User_Store'Class;

   function Create
    (Self  : not null access User_Store'Class;
     Email : League.Strings.Universal_String)
       return not null AWFC.Accounts.Users.User_Access;

   function Incarnate
    (Self       : not null access User_Store'Class;
     Identifier : ESAPI.Users.User_Identifier)
       return AWFC.Accounts.Users.User_Access;

   function Incarnate
    (Self  : not null access User_Store'Class;
     Email : League.Strings.Universal_String)
       return AWFC.Accounts.Users.User_Access;

   not overriding function Get_Email
    (Self : not null access User_Store) return League.Strings.Universal_String;

   not overriding function Get_Show_Advertisement
    (Self : not null access User_Store) return Boolean;

private

   type User_Store is
     new OPM.Stores.Abstract_Store
       and ESAPI.Users.Stores.User_Store with
   record
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

end AWFC.Accounts.Users.Stores;
