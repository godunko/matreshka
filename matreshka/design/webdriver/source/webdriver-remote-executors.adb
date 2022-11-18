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

with AWS.Response;
with League.JSON.Documents;

separate (WebDriver.Remote)
package body Executors is

   -------------
   -- Execute --
   -------------

   not overriding function Execute
     (Self    : access HTTP_Command_Executor;
      Command : Remote.Command) return Response
   is
      Reply : AWS.Response.Data;
      JSON  : League.JSON.Documents.JSON_Document;
   begin
      case Command.Method is
         when Get =>
            AWS.Client.Get
              (Self.Server,
               URI    => Command.Path.To_UTF_8_String,
               Result => Reply);
         when Post =>
            declare
               Text : constant League.Strings.Universal_String :=
                 Command.Parameters.To_JSON_Document.To_JSON;
            begin
               AWS.Client.Post
                 (Self.Server,
                  URI    => Command.Path.To_UTF_8_String,
                  Data   => Text.To_UTF_8_String,
                    Content_Type => "application/json; charset=utf-8",
                  Result => Reply);
            end;
      end case;

      JSON := League.JSON.Documents.From_JSON
        (AWS.Response.Message_Body (Reply));

      return
        (Session_Id => League.Strings.Empty_Universal_String,  --  FIXME
         State      => League.Strings.Empty_Universal_String,  --  FIXME
         Status     => 0,  --  FIXME
         Value      => JSON.To_JSON_Object);
   end Execute;

end Executors;
