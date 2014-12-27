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

package body Matreshka.Servlet_AWS_Requests is

   ----------------
   -- Get_Method --
   ----------------

   overriding function Get_Method
    (Self : AWS_Servlet_Request) return Servlet.HTTP_Requests.HTTP_Method is
   begin
      case AWS.Status.Method (Self.Data) is
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

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self : in out AWS_Servlet_Request;
     Data : AWS.Status.Data) is
   begin
      Self.Data := Data;
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
