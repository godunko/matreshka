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

package body Matreshka.Servlet_HTTP_Requests is

   ----------------------
   -- Get_Context_Path --
   ----------------------

   overriding function Get_Context_Path
    (Self : Abstract_HTTP_Servlet_Request)
       return League.String_Vectors.Universal_String_Vector is
   begin
      return Self.Path.Slice (1, Self.Context_Last);
   end Get_Context_Path;

   --------------
   -- Get_Path --
   --------------

   function Get_Path
    (Self : Abstract_HTTP_Servlet_Request'Class)
       return League.String_Vectors.Universal_String_Vector is
   begin
      return Self.Path;
   end Get_Path;

   -------------------
   -- Get_Path_Info --
   -------------------

   overriding function Get_Path_Info
    (Self : Abstract_HTTP_Servlet_Request)
       return League.String_Vectors.Universal_String_Vector is
   begin
      return Self.Path.Slice (Self.Servlet_Last + 1, Self.Path.Length);
   end Get_Path_Info;

   ----------------------
   -- Get_Servlet_Path --
   ----------------------

   overriding function Get_Servlet_Path
    (Self : Abstract_HTTP_Servlet_Request)
       return League.String_Vectors.Universal_String_Vector is
   begin
      return Self.Path.Slice (Self.Context_Last + 1, Self.Servlet_Last);
   end Get_Servlet_Path;

   -----------------
   -- Get_Session --
   -----------------

   overriding function Get_Session
    (Self   : Abstract_HTTP_Servlet_Request;
     Create : Boolean := True)
       return access Servlet.HTTP_Sessions.HTTP_Session'Class is
   begin
      if Self.Session /= null then
         return Self.Session;
      end if;
--      --  XXX Most of this code is generic and Web Server API independ, thus it
--      --  can be refactored to be reused by both AWS and FastCGI APIs.
--
--      if AWS.Cookie.Exists (Request, SID_Cookie_Name) then
--         --  Decode session identifier specified in request. Detect and report
--         --  security event if this conversion fails.
--
--         begin
--            SID :=
--              Server.Sessions.From_Universal_String
--               (League.Strings.From_UTF_8_String
--                 (AWS.Cookie.Get (Request, SID_Cookie_Name)));
--            SID_Decoded := True;
--
--         exception
--            when Constraint_Error =>
--               --  XXX Security event must be reported!!!
--
--               Ada.Text_IO.Put_Line
--                (Ada.Text_IO.Standard_Error, "Security: mailformed SID");
--         end;
--
--         --  Lookup for session when session identifier was decoded
--         --  successfully. Otherwise, new session will be allocated later.
--
--         if SID_Decoded then
--            Session := Server.Sessions.Controller.Get_Session (SID);
--
--            if Session = null then
--               --  XXX Security event must be reported!
--
--               SID_Decoded := False;
--               --  Reset SID_Decoded flag to force sent of new session
--               --  identifier to client after request.
--
--               Ada.Text_IO.Put_Line
--                (Ada.Text_IO.Standard_Error,
--                 "Security: unavailable session ("
--                   & AWS.Cookie.Get (Request, SID_Cookie_Name)
--                   & ')');
--            end if;
--         end if;
--      end if;
--
--      --  Allocate new session when it was not specified or resolved; otherwise
--      --  update last accessed time of the session.
--
--      if Session = null then
--         Session := Server.Sessions.Controller.Create_Session;
--
--      else
--         Server.Sessions.Controller.Update_Last_Accessed_Time (Session);
--      end if;
--
--      return Result : AWS.Response.Data
--        := Dispatch_Request (Request, Session)
--      do
--         if not SID_Decoded or Session.Get_Session_Identifier /= SID then
--            --  Send session identifer when it was changed.
--
--            AWS.Cookie.Set
--             (Result,
--              SID_Cookie_Name,
--              Server.Sessions.To_Universal_String
--               (Session.Get_Session_Identifier).To_UTF_8_String);
--         end if;
--      end return;
   end Get_Session;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self     : in out Abstract_HTTP_Servlet_Request'Class;
     Path     : League.String_Vectors.Universal_String_Vector;
     Response :
       not null Matreshka.Servlet_HTTP_Responses.HTTP_Servlet_Response_Access)
   is
   begin
      Self.Path     := Path;
      Self.Response := Response;
   end Initialize;

   ------------------------------
   -- Set_Context_Last_Segment --
   ------------------------------

   procedure Set_Context_Last_Segment
    (Self : in out Abstract_HTTP_Servlet_Request'Class;
     Last : Natural) is
   begin
      Self.Context_Last := Last;
   end Set_Context_Last_Segment;

   ------------------------------
   -- Set_Servlet_Last_Segment --
   ------------------------------

   procedure Set_Servlet_Last_Segment
    (Self : in out Abstract_HTTP_Servlet_Request'Class;
     Last : Natural) is
   begin
      Self.Servlet_Last := Last;
   end Set_Servlet_Last_Segment;

end Matreshka.Servlet_HTTP_Requests;
