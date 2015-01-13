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
private with Ada.Streams;

private with AWS.Resources.Streams.Memory;
with AWS.Response;

private with League.IRIs;
private with League.Strings;
private with League.Text_Codecs;

with Matreshka.Servlet_HTTP_Responses;
with Matreshka.Servlet_HTTP_Requests;
private with Servlet.HTTP_Cookies;
with Servlet.HTTP_Responses;
with Servlet.Output_Streams;
private with Servlet.Write_Listeners;

package Matreshka.Servlet_AWS_Responses is

   type AWS_Servlet_Response is
     new Matreshka.Servlet_HTTP_Responses.Abstract_HTTP_Servlet_Response
       and Servlet.Output_Streams.Servlet_Output_Stream
         with private;

   procedure Initialize
    (Self    : in out AWS_Servlet_Response'Class;
     Request :
       not null Matreshka.Servlet_HTTP_Requests.HTTP_Servlet_Request_Access);

   function Build
    (Self : in out AWS_Servlet_Response'Class) return AWS.Response.Data;
   --  Build AWS response data.

private

   type Stream_Access is
     access all AWS.Resources.Streams.Memory.Stream_Type'Class;

   type Text_Codec_Access is access all League.Text_Codecs.Text_Codec'Class;

   type AWS_Servlet_Response is
     new Matreshka.Servlet_HTTP_Responses.Abstract_HTTP_Servlet_Response
       and Servlet.Output_Streams.Servlet_Output_Stream with
   record
      Data         : AWS.Response.Data;
      Encoding     : League.Strings.Universal_String;
      Content_Type : League.Strings.Universal_String;
      Stream       : Stream_Access;
      Codec        : Text_Codec_Access;
      Output       : access Servlet.Output_Streams.Servlet_Output_Stream'Class;
   end  record;

   overriding procedure Add_Cookie
    (Self   : in out AWS_Servlet_Response;
     Cookie : Servlet.HTTP_Cookies.Cookie);
   --  Adds the specified cookie to the response. This method can be called
   --  multiple times to set more than one cookie.

   overriding procedure Send_Redirect
    (Self     : in out AWS_Servlet_Response;
     Location : League.IRIs.IRI);
   --  Sends a temporary redirect response to the client using the specified
   --  redirect location URL and clears the buffer.

   overriding procedure Set_Character_Encoding
    (Self     : in out AWS_Servlet_Response;
     Encoding : League.Strings.Universal_String);
   --  Sets the character encoding (MIME charset) of the response being sent to
   --  the client, for example, to UTF-8. If the character encoding has already
   --  been set by setContentType(java.lang.String) or
   --  setLocale(java.util.Locale), this method overrides it. Calling
   --  setContentType(java.lang.String) with the String of text/html and
   --  calling this method with the String of UTF-8 is equivalent with calling
   --  setContentType with the String of text/html; charset=UTF-8.

   overriding procedure Set_Content_Type
    (Self : in out AWS_Servlet_Response;
     To   : League.Strings.Universal_String);
   --  Sets the content type of the response being sent to the client, if the
   --  response has not been committed yet. The given content type may include
   --  a character encoding specification, for example,
   --  text/html;charset=UTF-8. The response's character encoding is only set
   --  from the given content type if this method is called before getWriter is
   --  called.

   overriding procedure Set_Status
    (Self   : in out AWS_Servlet_Response;
     Status : Servlet.HTTP_Responses.Status_Code);
   --  Sets the status code for this response.

   overriding function Get_Output_Stream
    (Self : AWS_Servlet_Response)
       return
         not null access Servlet.Output_Streams.Servlet_Output_Stream'Class;
   --  Returns a ServletOutputStream suitable for writing binary data in the
   --  response. The servlet container does not encode the binary data.

   overriding function Is_Ready (Self : AWS_Servlet_Response) return Boolean;
   --  This method can be used to determine if data can be written without
   --  blocking.

   overriding procedure Set_Write_Listener
    (Self     : in out AWS_Servlet_Response;
     Listener : not null access Servlet.Write_Listeners.Write_Listener'Class);
   -- Instructs the ServletOutputStream to invoke the provided WriteListener
   -- when it is possible to write.

   overriding procedure Write
    (Self : in out AWS_Servlet_Response;
     Item : Ada.Streams.Stream_Element_Array);

   overriding procedure Write
    (Self : in out AWS_Servlet_Response;
     Item : League.Strings.Universal_String);

end Matreshka.Servlet_AWS_Responses;
