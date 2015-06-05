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
with Ada.Numerics.Discrete_Random;
with Ada.Streams;

with League.Base_Codecs;
with League.Stream_Element_Vectors;

with Server.Sessions.Controller;

package body Server.Sessions is

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
      return To_Universal_String (Self.SID);
   end Get_Id;

   ----------------------------
   -- Get_Session_Identifier --
   ----------------------------

   function Get_Session_Identifier
    (Self : not null access constant Session'Class)
       return Session_Identifier is
   begin
      return Self.SID;
   end Get_Session_Identifier;

   --------------
   -- Get_User --
   --------------

   function Get_User
    (Self : not null access constant Session'Class)
       return Security.Users.User_Access is
   begin
      return Self.User;
   end Get_User;

   --------------
   -- Set_User --
   --------------

   procedure Set_User
    (Self : not null access Session'Class;
     User : not null Security.Users.User_Access)
   is
      Old_SID : constant Session_Identifier := Self.SID;

   begin
      Self.User := User;
      Self.SID := Generate_Session_Identifier;
      Server.Sessions.Controller.Update_Session_Identifier (Self, Old_SID);
      Server.Sessions.Controller.Update_User (Self);
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
end Server.Sessions;
