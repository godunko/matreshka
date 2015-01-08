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
with AWS.Response;

with Matreshka.Servlet_HTTP_Responses;
private with Servlet.HTTP_Cookies;
with Servlet.HTTP_Responses;

package Matreshka.Servlet_AWS_Responses is

   type AWS_Servlet_Response is
     new Matreshka.Servlet_HTTP_Responses.Abstract_HTTP_Servlet_Response
       with private;

   procedure Initialize (Self : in out AWS_Servlet_Response'Class);

   function Build (Self : AWS_Servlet_Response'Class) return AWS.Response.Data;
   --  Build AWS response data.

private

   type AWS_Servlet_Response is
     new Matreshka.Servlet_HTTP_Responses.Abstract_HTTP_Servlet_Response with
   record
      Data : AWS.Response.Data;
   end  record;

   overriding procedure Add_Cookie
    (Self   : in out AWS_Servlet_Response;
     Cookie : Servlet.HTTP_Cookies.Cookie);
   --  Adds the specified cookie to the response. This method can be called
   --  multiple times to set more than one cookie.

   overriding procedure Set_Status
    (Self   : in out AWS_Servlet_Response;
     Status : Servlet.HTTP_Responses.Status_Code);
   --  Sets the status code for this response.

end Matreshka.Servlet_AWS_Responses;
