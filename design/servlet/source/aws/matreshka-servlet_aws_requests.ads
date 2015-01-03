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
with AWS.Status;

with League.String_Vectors;

with Servlet.HTTP_Requests;

package Matreshka.Servlet_AWS_Requests is

   type AWS_Servlet_Request is
     limited new Servlet.HTTP_Requests.HTTP_Servlet_Request with private;

   procedure Initialize
    (Self : in out AWS_Servlet_Request;
     Data : AWS.Status.Data);
   --  Initialize object to obtain information from given data object of AWS.

private

   type AWS_Servlet_Request is
     limited new Servlet.HTTP_Requests.HTTP_Servlet_Request with record
      Data : AWS.Status.Data;
   end record;

   overriding function Get_Context_Path
    (Self : AWS_Servlet_Request)
       return League.String_Vectors.Universal_String_Vector;
   --  Returns the portion of the request URI that indicates the context of the
   --  request. The context path always comes first in a request URI. The path
   --  starts with a "/" character but does not end with a "/" character. For
   --  servlets in the default (root) context, this method returns "". The
   --  container does not decode this string.

   overriding function Get_Method
    (Self : AWS_Servlet_Request) return Servlet.HTTP_Requests.HTTP_Method;
   --  Returns the name of the HTTP method with which this request was made,
   --  for example, GET, POST, or PUT. Same as the value of the CGI variable
   --  REQUEST_METHOD.

   overriding function Get_Path_Info
    (Self : AWS_Servlet_Request)
       return League.String_Vectors.Universal_String_Vector;
   --  Returns any extra path information associated with the URL the client
   --  sent when it made this request. The extra path information follows the
   --  servlet path but precedes the query string and will start with a "/"
   --  character.

   overriding function Get_Servlet_Path
    (Self : AWS_Servlet_Request)
       return League.String_Vectors.Universal_String_Vector;
   --  Returns the part of this request's URL that calls the servlet. This path
   --  starts with a "/" character and includes either the servlet name or a
   --  path to the servlet, but does not include any extra path information or
   --  a query string. Same as the value of the CGI variable SCRIPT_NAME.

   overriding function Is_Async_Supported
    (Self : not null access AWS_Servlet_Request) return Boolean;
   --  Checks if this request supports asynchronous operation.

end Matreshka.Servlet_AWS_Requests;
