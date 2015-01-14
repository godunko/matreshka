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
-- Copyright © 2014-2015, Vadim Godunko <vgodunko@gmail.com>                --
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
with Ada.Strings.Unbounded;

with AWS.Headers.Values;
with AWS.Messages;
with AWS.Parameters;
with AWS.URL;

with League.IRIs;
with League.Strings;

with Servlet.HTTP_Cookies;

package body Matreshka.Servlet_AWS_Requests is

   --------------
   -- Finalize --
   --------------

   procedure Finalize (Self : in out AWS_Servlet_Request'Class) is
   begin
      null;
   end Finalize;

   ----------------
   -- Get_Cookie --
   ----------------

   overriding function Get_Cookie
    (Self : AWS_Servlet_Request)
       return Servlet.HTTP_Cookie_Sets.Cookie_Set is
   begin
      if Self.Data.Cookies_Computed then
         --  Reuse cookies when they was computed.

         return Self.Data.Cookies;
      end if;

      --  Compute cookies.

      declare
         Headers : constant AWS.Headers.List
           := AWS.Status.Header (Self.Request);
         Cookies : constant String
           := AWS.Headers.Get_Values (Headers, AWS.Messages.Cookie_Token);
         Set     : constant AWS.Headers.Values.Set
           := AWS.Headers.Values.Split (Cookies);
         Cookie  : Servlet.HTTP_Cookies.Cookie;

      begin
         Self.Data.Cookies_Computed := True;

         for J in Set'Range loop
            Servlet.HTTP_Cookies.Initialize
             (Cookie,
              League.Strings.From_UTF_8_String
               (Ada.Strings.Unbounded.To_String (Set (J).Name)),
              League.Strings.From_UTF_8_String
               (AWS.URL.Decode
                 (Ada.Strings.Unbounded.To_String (Set (J).Value))));
            --  AWS.URL.Decode is used here for compatibility with AWS.Cookies.

            Self.Data.Cookies.Append (Cookie);
         end loop;

         return Self.Data.Cookies;
      end;
   end Get_Cookie;

   ----------------
   -- Get_Method --
   ----------------

   overriding function Get_Method
    (Self : AWS_Servlet_Request) return Servlet.HTTP_Requests.HTTP_Method is
   begin
      case AWS.Status.Method (Self.Request) is
         when AWS.Status.OPTIONS =>
            return Servlet.HTTP_Requests.Options;

         when AWS.Status.GET =>
            return Servlet.HTTP_Requests.Get;

         when AWS.Status.HEAD =>
            return Servlet.HTTP_Requests.Head;

         when AWS.Status.POST =>
            return Servlet.HTTP_Requests.Post;

         when AWS.Status.PUT =>
            return Servlet.HTTP_Requests.Put;

         when AWS.Status.DELETE =>
            return Servlet.HTTP_Requests.Delete;

         when AWS.Status.TRACE =>
            return Servlet.HTTP_Requests.Trace;

         when AWS.Status.CONNECT =>
            return Servlet.HTTP_Requests.Connect;

         when AWS.Status.EXTENSION_METHOD =>
            raise Program_Error;
      end case;
   end Get_Method;

   --------------------------
   -- Get_Parameter_Values --
   --------------------------

   overriding function Get_Parameter_Values
    (Self : AWS_Servlet_Request;
     Name : League.Strings.Universal_String)
       return League.String_Vectors.Universal_String_Vector
   is
      Values : constant AWS.Parameters.VString_Array
        := AWS.Parameters.Get_Values
            (AWS.Status.Parameters (Self.Request), Name.To_UTF_8_String);
      Result : League.String_Vectors.Universal_String_Vector;

   begin
      for Value of Values loop
         Result.Append
          (League.Strings.From_UTF_8_String
            (Ada.Strings.Unbounded.To_String (Value)));
      end loop;

      return Result;
   end Get_Parameter_Values;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self : in out AWS_Servlet_Request'Class;
     Data : AWS.Status.Data)
   is
      Path : constant League.String_Vectors.Universal_String_Vector
        := League.Strings.From_UTF_8_String
            (AWS.Status.URI (Data)).Split ('/', League.Strings.Skip_Empty);
      --  XXX HTTP protocol uses some protocol specific escaping sequnces, they
      --  should be handled here.
      --  XXX Use of UTF-9 to encode URI by AWS should be checked.
      Port : constant String := AWS.URL.Port (AWS.Status.URI (Data));

      URL  : League.IRIs.IRI;

   begin
      --  Reconstruct request's URL.

      URL.Set_Scheme
       (League.Strings.From_UTF_8_String
         (AWS.URL.Protocol_Name (AWS.Status.URI (Data))));
      URL.Set_Host
       (League.Strings.From_UTF_8_String
         (AWS.URL.Host (AWS.Status.URI (Data))));
      URL.Set_Port (AWS.URL.Port (AWS.Status.URI (Data)));
      URL.Set_Absolute_Path (Path);

      --  Initialize object.

      Matreshka.Servlet_HTTP_Requests.Initialize (Self, URL);
      Self.Request := Data;
      Self.Data    := Self.Data_Storage'Unchecked_Access;
   end Initialize;

   ------------------------
   -- Is_Async_Supported --
   ------------------------

   overriding function Is_Async_Supported
    (Self : not null access AWS_Servlet_Request) return Boolean
   is
      pragma Unreferenced (Self);

   begin
      --  AWS doesn't support asynchronous processing of requests.

      return False;
   end Is_Async_Supported;

end Matreshka.Servlet_AWS_Requests;
