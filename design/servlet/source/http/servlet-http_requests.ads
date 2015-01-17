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
--  Extends the ServletRequest interface to provide request information for
--  HTTP servlets.
--
--  The servlet container creates an HttpServletRequest object and passes it as
--  an argument to the servlet's service methods (doGet, doPost, etc).
------------------------------------------------------------------------------
with League.String_Vectors;
with League.Strings;

with Servlet.HTTP_Cookie_Sets;
with Servlet.HTTP_Sessions;
with Servlet.HTTP_Upgrade_Handlers;
with Servlet.Requests;

package Servlet.HTTP_Requests is

   pragma Preelaborate;

   type HTTP_Method is
    (Options, Get, Head, Post, Put, Delete, Trace, Connect);

   type HTTP_Servlet_Request is limited interface
     and Servlet.Requests.Servlet_Request;

   not overriding function Get_Context_Path
    (Self : HTTP_Servlet_Request)
       return League.String_Vectors.Universal_String_Vector is abstract;
   function Get_Context_Path
    (Self : HTTP_Servlet_Request'Class) return League.Strings.Universal_String;
   --  Returns the portion of the request URI that indicates the context of the
   --  request. The context path always comes first in a request URI. The path
   --  starts with a "/" character but does not end with a "/" character. For
   --  servlets in the default (root) context, this method returns "". The
   --  container does not decode this string.
   --
   --  It is possible that a servlet container may match a context by more than
   --  one context path. In such cases this method will return the actual
   --  context path used by the request and it may differ from the path
   --  returned by the ServletContext.getContextPath() method. The context path
   --  returned by ServletContext.getContextPath() should be considered as the
   --  prime or preferred context path of the application.

   not overriding function Get_Cookies
    (Self : HTTP_Servlet_Request)
       return Servlet.HTTP_Cookie_Sets.Cookie_Set is abstract;
   --  Returns an array containing all of the Cookie objects the client sent
   --  with this request. This method returns null if no cookies were sent.

   not overriding function Get_Method
    (Self : HTTP_Servlet_Request) return HTTP_Method is abstract;
   --  Returns the name of the HTTP method with which this request was made,
   --  for example, GET, POST, or PUT. Same as the value of the CGI variable
   --  REQUEST_METHOD.

   not overriding function Get_Path_Info
    (Self : HTTP_Servlet_Request)
       return League.String_Vectors.Universal_String_Vector is abstract;
   function Get_Path_Info
    (Self : HTTP_Servlet_Request'Class) return League.Strings.Universal_String;
   --  Returns any extra path information associated with the URL the client
   --  sent when it made this request. The extra path information follows the
   --  servlet path but precedes the query string and will start with a "/"
   --  character.
   --
   --  This method returns null if there was no extra path information.
   --
   --  Same as the value of the CGI variable PATH_INFO.

   not overriding function Get_Requested_Session_Id
    (Self : HTTP_Servlet_Request)
       return League.Strings.Universal_String is abstract;
   --  Returns the session ID specified by the client. This may not be the same
   --  as the ID of the current valid session for this request. If the client
   --  did not specify a session ID, this method returns null.

   not overriding function Get_Servlet_Path
    (Self : HTTP_Servlet_Request)
       return League.String_Vectors.Universal_String_Vector is abstract;
   function Get_Servlet_Path
    (Self : HTTP_Servlet_Request'Class) return League.Strings.Universal_String;
   --  Returns the part of this request's URL that calls the servlet. This path
   --  starts with a "/" character and includes either the servlet name or a
   --  path to the servlet, but does not include any extra path information or
   --  a query string. Same as the value of the CGI variable SCRIPT_NAME.
   --
   --  This method will return an empty string ("") if the servlet used to
   --  process this request was matched using the "/*" pattern.

   not overriding function Get_Session
    (Self   : HTTP_Servlet_Request;
     Create : Boolean := True)
       return access Servlet.HTTP_Sessions.HTTP_Session'Class is abstract;
   --  Returns the current HttpSession associated with this request or, if
   --  there is no current session and create is true, returns a new session.
   --
   --  If create is false and the request has no valid HttpSession, this method
   --  returns null.
   --
   --  To make sure the session is properly maintained, you must call this
   --  method before the response is committed. If the container is using
   --  cookies to maintain session integrity and is asked to create a new
   --  session when the response is committed, an IllegalStateException is
   --  thrown.

   not overriding function Is_Requested_Session_Id_Valid
    (Self : HTTP_Servlet_Request) return Boolean is abstract;
   --  Checks whether the requested session ID is still valid.
   --
   --  If the client did not specify any session ID, this method returns false.

   not overriding procedure Upgrade
    (Self    : HTTP_Servlet_Request;
     Handler :
       not null Servlet.HTTP_Upgrade_Handlers.HTTP_Upgrade_Handler_Access)
         is abstract;
   --  Uses given upgrade handler for the http protocol upgrade processing.

end Servlet.HTTP_Requests;
