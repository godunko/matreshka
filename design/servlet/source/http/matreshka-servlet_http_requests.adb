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

with Servlet.HTTP_Cookies;

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
      if Self.Data.Session /= null
        or else Self.Data.Session_Computed
      then
         --  Session was created or not needed to be created.

         return Self.Data.Session;
      end if;

      --  Check whether session identifier was passed in HTTP cookie and
      --  reconstruct session.

      declare
         Cookie      : Servlet.HTTP_Cookies.Cookie
           := Abstract_HTTP_Servlet_Request'Class (Self).Get_Cookie.Element
               (League.Strings.To_Universal_String ("MSID"));
         Identifier  : Matreshka.Servlet_Sessions.Session_Identifier;
         SID_Decoded : Boolean := False;

      begin
         if not Cookie.Is_Empty then
            --  Decode session identifier specified in request. Detect and
            --  report security event if this conversion fails.

            Matreshka.Servlet_Sessions.To_Session_Identifier
             (Cookie.Get_Value, Identifier, SID_Decoded);

            if SID_Decoded then
               Self.Data.Session :=
                 Self.Session_Manager.Get_Session (Identifier);
               Self.Data.Session_Computed := True;

               if Self.Data.Session = null then
                  --  XXX Security event should be reported: SID unknown.

                  null;
               end if;

            else
               --  XXX Suspicuous behavior should be reported: SID has wrong
               --  format.

               null;
            end if;
         end if;
      end;

      --  Allocate new session when it was not specified in HTTP cookie or
      --  resolved.

      if Self.Data.Session = null and Create then
         declare
            Cookie : Servlet.HTTP_Cookies.Cookie;

         begin
            Self.Data.Session := Self.Session_Manager.New_Session;

            --  Create cookie with session identifier and add it to response.

            Cookie.Initialize
             (League.Strings.To_Universal_String ("MSID"),
              Self.Data.Session.Get_Id);
            Cookie.Set_Http_Only (True);
            Cookie.Set_Path (Self.Get_Context_Path);
            Self.Response.Add_Cookie (Cookie);
         end;
      end if;

      return Self.Data.Session;
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
      Self.Data     := Self.Storage'Unchecked_Access;
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

   -------------------------
   -- Set_Session_Manager --
   -------------------------

   procedure Set_Session_Manager
    (Self    : in out Abstract_HTTP_Servlet_Request'Class;
     Manager : Matreshka.Servlet_Sessions.Session_Manager_Access) is
   begin
      Self.Session_Manager := Manager;
   end Set_Session_Manager;

end Matreshka.Servlet_HTTP_Requests;
