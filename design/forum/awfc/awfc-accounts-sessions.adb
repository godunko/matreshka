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
with Ada.Numerics.Discrete_Random;
with Ada.Streams;

with League.Base_Codecs;
with League.Stream_Element_Vectors;

with AWFC.Accounts.Sessions.Stores;

package body AWFC.Accounts.Sessions is

   package Unsigned_64_Random is
     new Ada.Numerics.Discrete_Random (Interfaces.Unsigned_64);

   Generator : Unsigned_64_Random.Generator;

   ---------------------------------
   -- Generate_Session_Identifier --
   ---------------------------------

   function Generate_Session_Identifier return Session_Identifier is
   begin
      return Result : Session_Identifier do
         for J in Result'Range loop
            Result (J) := Unsigned_64_Random.Random (Generator);
         end loop;
      end return;
   end Generate_Session_Identifier;

   ------------
   -- Get_Id --
   ------------

   overriding function Get_Id
    (Self : Session) return League.Strings.Universal_String is
   begin
      return To_Universal_String (Self.Identifier);
   end Get_Id;

   ----------------------------
   -- Get_Session_Identifier --
   ----------------------------

   function Get_Session_Identifier
    (Self : not null access constant Session'Class)
       return Session_Identifier is
   begin
      return Self.Identifier;
   end Get_Session_Identifier;

   --------------
   -- Get_User --
   --------------

   function Get_User
    (Self : not null access constant Session'Class)
       return AWFC.Accounts.Users.User_Access is
   begin
      return Self.User;
   end Get_User;

   --------------
   -- Set_User --
   --------------

   procedure Set_User
    (Self : not null access Session'Class;
     User : not null AWFC.Accounts.Users.User_Access)
   is
      Old_SID : constant Session_Identifier := Self.Identifier;

   begin
      Self.User := User;
      Self.Identifier := Generate_Session_Identifier;
      Self.Store.Update_Session_Identifier (Self, Old_SID);
      Self.Store.Update_User (Self);
   end Set_User;

   -------------------------
   -- To_Universal_String --
   -------------------------

   function To_Universal_String
    (Item : Session_Identifier) return League.Strings.Universal_String
   is
      Aux : constant Ada.Streams.Stream_Element_Array
                      (1 .. Session_Identifier'Max_Size_In_Storage_Elements)
        with Import     => True,
             Convention => Ada,
             Address    => Item'Address;

   begin
      return
        League.Base_Codecs.To_Base_64_URL
         (League.Stream_Element_Vectors.To_Stream_Element_Vector (Aux));
   end To_Universal_String;

begin
   Unsigned_64_Random.Reset (Generator);
end AWFC.Accounts.Sessions;
