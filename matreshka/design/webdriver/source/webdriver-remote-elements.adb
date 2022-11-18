------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2017, Vadim Godunko <vgodunko@gmail.com>                     --
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

with League.JSON.Arrays;
with League.JSON.Values;

separate (WebDriver.Remote)
package body Elements is

   function "+"
     (Text : Wide_Wide_String) return League.Strings.Universal_String
      renames League.Strings.To_Universal_String;

   function To_Path
     (Self : access Element;
      Command : Wide_Wide_String;
      Suffix  : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String)
      return League.Strings.Universal_String;

   -----------
   -- Clear --
   -----------

   overriding procedure Clear (Self : access Element) is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
      pragma Unreferenced (Response);
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/clear");
      Response := Self.Executor.Execute (Command);
   end Clear;

   -----------
   -- Click --
   -----------

   overriding procedure Click (Self : access Element) is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
      pragma Unreferenced (Response);
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/click");
      Response := Self.Executor.Execute (Command);
   end Click;

   -------------------
   -- Get_Attribute --
   -------------------

   overriding function Get_Attribute
     (Self : access Element;
      Name : League.Strings.Universal_String)
         return League.Strings.Universal_String
   is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/attribute", Name);
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_String;
   end Get_Attribute;

   -------------------
   -- Get_CSS_Value --
   -------------------

   overriding function Get_CSS_Value
     (Self : access Element;
      Name : League.Strings.Universal_String)
        return League.Strings.Universal_String
   is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/css", Name);
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_String;
   end Get_CSS_Value;

   ------------------
   -- Get_Property --
   ------------------

   overriding function Get_Property
     (Self : access Element;
      Name : League.Strings.Universal_String)
        return League.Strings.Universal_String
   is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/property", Name);
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_String;
   end Get_Property;

   ------------------
   -- Get_Tag_Name --
   ------------------

   overriding function Get_Tag_Name
     (Self : access Element) return League.Strings.Universal_String
   is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/name");
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_String;
   end Get_Tag_Name;

   --------------
   -- Get_Text --
   --------------

   overriding function Get_Text
     (Self : access Element) return League.Strings.Universal_String
   is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/text");
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_String;
   end Get_Text;

   ----------------
   -- Is_Enabled --
   ----------------

   overriding function Is_Enabled (Self : access Element) return Boolean is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/enabled");
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_Boolean;
   end Is_Enabled;

   -----------------
   -- Is_Selected --
   -----------------

   overriding function Is_Selected (Self : access Element) return Boolean is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/selected");
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_Boolean;
   end Is_Selected;

   ---------------
   -- Send_Keys --
   ---------------

   overriding procedure Send_Keys
     (Self : access Element;
      Text : League.String_Vectors.Universal_String_Vector)
   is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
      List      : League.JSON.Arrays.JSON_Array;
      pragma Unreferenced (Response);
   begin
      Command.Method := Post;
      Command.Path := To_Path (Self, "/value");

      for J in 1 .. Text.Length loop
         List.Append (League.JSON.Values.To_JSON_Value (Text.Element (J)));
      end loop;

      Command.Parameters.Insert (+"value", List.To_JSON_Value);
      Response := Self.Executor.Execute (Command);
   end Send_Keys;

   -------------
   -- To_Path --
   -------------

   function To_Path
     (Self    : access Element;
      Command : Wide_Wide_String;
      Suffix  : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String)
      return League.Strings.Universal_String
   is
      Result : League.Strings.Universal_String;
   begin
      Result.Append ("/session/");
      Result.Append (Self.Session_Id);
      Result.Append ("/element/");
      Result.Append (Self.Element_Id);
      Result.Append (Command);

      if not Suffix.Is_Empty then
         Result.Append ("/");
         Result.Append (Suffix);
      end if;

      return Result;
   end To_Path;

end Elements;
