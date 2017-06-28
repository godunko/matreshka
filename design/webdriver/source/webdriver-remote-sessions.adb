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

with League.JSON.Values;

separate (WebDriver.Remote)
package body Sessions is

   function "+"
     (Text : Wide_Wide_String) return League.Strings.Universal_String
      renames League.Strings.To_Universal_String;

   ---------------------
   -- Get_Current_URL --
   ---------------------

   overriding function Get_Current_URL
     (Self : access Session) return League.Strings.Universal_String
   is
      Command  : WebDriver.Remote.Command;
      Response : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path.Append ("/session/");
      Command.Path.Append (Self.Session_Id);
      Command.Path.Append ("/url");
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_String;
   end Get_Current_URL;

   --------
   -- Go --
   --------

   overriding procedure Go
     (Self : access Session;
      URL  : League.Strings.Universal_String)
   is
      Command  : WebDriver.Remote.Command;
      Response : WebDriver.Remote.Response;
      Value    : constant League.JSON.Values.JSON_Value :=
        League.JSON.Values.To_JSON_Value (URL);
      pragma Unreferenced (Response);
   begin
      Command.Method := Post;
      Command.Path.Append ("/session/");
      Command.Path.Append (Self.Session_Id);
      Command.Path.Append ("/url");
      Command.Parameters.Insert (+"url", Value);
      Command.Session_Id := Self.Session_Id;
      Response := Self.Executor.Execute (Command);
   end Go;

end Sessions;
