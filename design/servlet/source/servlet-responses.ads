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
--  Defines an object to assist a servlet in sending a response to the client.
--  The servlet container creates a ServletResponse object and passes it as an
--  argument to the servlet's service method.
--
--  To send binary data in a MIME body response, use the ServletOutputStream
--  returned by getOutputStream().
--
--  The charset for the MIME body response can be specified explicitly using
--  the setCharacterEncoding(java.lang.String) and
--  setContentType(java.lang.String) methods, or implicitly using the
--  setLocale(java.util.Locale) method. Explicit specifications take precedence
--  over implicit specifications. If no charset is specified, ISO-8859-1 will
--  be used. The setCharacterEncoding, setContentType, or setLocale method must
--  be called before getWriter and before committing the response for the
--  character encoding to be used.
--
--  See the Internet RFCs such as RFC 2045 for more information on MIME.
--  Protocols such as SMTP and HTTP define profiles of MIME, and those
--  standards are still evolving.
------------------------------------------------------------------------------
with Servlet.Output_Streams;

package Servlet.Responses is

   pragma Preelaborate;

   type Servlet_Response is limited interface;

   type Servlet_Response_Access is access all Servlet_Response'Class;

   not overriding function Get_Output_Stream
    (Self : Servlet_Response)
       return
         not null access Servlet.Output_Streams.Servlet_Output_Stream'Class
           is abstract;
   --  Returns a ServletOutputStream suitable for writing binary data in the
   --  response. The servlet container does not encode the binary data.
   --
   --  Calling flush() on the ServletOutputStream commits the response.

end Servlet.Responses;
