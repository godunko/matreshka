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
-- Copyright © 2014, Vadim Godunko <vgodunko@gmail.com>                     --
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

package body ESAPI.Users.Non_Anonymous is

   -------------
   -- Disable --
   -------------

   overriding procedure Disable (Self : not null access Non_Anonymous_User) is
   begin
      if Self.Enabled then
         Self.Enabled := False;
         Self.Store.Update_Enabled (Self);
      end if;
   end Disable;

   ------------
   -- Enable --
   ------------

   overriding procedure Enable (Self : not null access Non_Anonymous_User) is
   begin
      if not Self.Enabled then
         Self.Enabled := True;
         Self.Store.Update_Enabled (Self);
      end if;
   end Enable;

   -------------------------
   -- Get_User_Identifier --
   -------------------------

   overriding function Get_User_Identifier
    (Self : not null access constant Non_Anonymous_User)
       return User_Identifier is
   begin
      return Self.Identifier;
   end Get_User_Identifier;

   ----------------
   -- Initialize --
   ----------------

   not overriding function Initialize
    (Store : not null access ESAPI.Users.Stores.User_Store'Class)
       return Non_Anonymous_User is
   begin
      return
       (Store      => Store,
        Identifier => Store.Get_User_Identifier,
        Enabled    => Store.Get_Enabled);
   end Initialize;

   ------------------
   -- Is_Anonymous --
   ------------------

   overriding function Is_Anonymous
    (Self : not null access constant Non_Anonymous_User) return Boolean is
   begin
      return False;
   end Is_Anonymous;

   ----------------
   -- Is_Enabled --
   ----------------

   overriding function Is_Enabled
    (Self : not null access constant Non_Anonymous_User) return Boolean is
   begin
      return Self.Enabled;
   end Is_Enabled;

end ESAPI.Users.Non_Anonymous;
