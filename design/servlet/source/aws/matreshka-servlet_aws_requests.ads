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

with Matreshka.Servlet_HTTP_Requests;
private with Servlet.HTTP_Cookie_Sets;
with Servlet.HTTP_Requests;
private with Servlet.HTTP_Sessions;

package Matreshka.Servlet_AWS_Requests is

   type AWS_Servlet_Request is
     new Matreshka.Servlet_HTTP_Requests.Abstract_HTTP_Servlet_Request
       with private;

   procedure Initialize
    (Self : in out AWS_Servlet_Request'Class;
     Data : AWS.Status.Data);
   --  Initialize object to obtain information from given data object of AWS.

   procedure Finalize (Self : in out AWS_Servlet_Request'Class);
   --  Deallocate internal data.

private

   type HTTP_Session_Access is
     access all Servlet.HTTP_Sessions.HTTP_Session'Class;

   type Internal_Cache is record
      Session          : HTTP_Session_Access;
      Cookies          : Servlet.HTTP_Cookie_Sets.Cookie_Set;
      Cookies_Computed : Boolean := False;
   end record;

   type AWS_Servlet_Request is
     new Matreshka.Servlet_HTTP_Requests.Abstract_HTTP_Servlet_Request with
   record
      Request      : AWS.Status.Data;
      Data         : access Internal_Cache;
      Data_Storage : aliased Internal_Cache;
   end record;

   overriding function Get_Cookie
    (Self : AWS_Servlet_Request)
       return Servlet.HTTP_Cookie_Sets.Cookie_Set;
   --  Returns an array containing all of the Cookie objects the client sent
   --  with this request. This method returns null if no cookies were sent.

   overriding function Get_Method
    (Self : AWS_Servlet_Request) return Servlet.HTTP_Requests.HTTP_Method;
   --  Returns the name of the HTTP method with which this request was made,
   --  for example, GET, POST, or PUT. Same as the value of the CGI variable
   --  REQUEST_METHOD.

   overriding function Get_Session
    (Self   : AWS_Servlet_Request;
     Create : Boolean := True)
       return access Servlet.HTTP_Sessions.HTTP_Session'Class;
   --  Returns the current HttpSession associated with this request or, if
   --  there is no current session and create is true, returns a new session.

   overriding function Is_Async_Supported
    (Self : not null access AWS_Servlet_Request) return Boolean;
   --  Checks if this request supports asynchronous operation.

end Matreshka.Servlet_AWS_Requests;
