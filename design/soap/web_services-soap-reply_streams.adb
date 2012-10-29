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
-- Copyright © 2012, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Web_Services.SOAP.Constants;
with Web_Services.SOAP.Message_Encoders;
with Web_Services.SOAP.Messages;

package body Web_Services.SOAP.Reply_Streams is

   ------------------
   -- Send_Message --
   ------------------

   procedure Send_Message
    (Self    : in out Abstract_Reply_Stream'Class;
     Status  : Status_Type;
     Message : in out Web_Services.SOAP.Messages.SOAP_Message_Access)
   is
      use League.Stream_Element_Vectors;
      use type Web_Services.SOAP.Messages.SOAP_Message_Access;

      Encoder : Web_Services.SOAP.Message_Encoders.SOAP_Message_Encoder;

   begin
      if Message = null then
         Self.Send_Reply
           (Status       => Status,
            Content_Type => Empty_Stream_Element_Vector,
            Output_Data  => Empty_Stream_Element_Vector);

      else
         Self.Send_Reply
           (Status       => Status,
            Content_Type => Constants.MIME_Application_SOAP_XML,
            Output_Data  => Encoder.Encode (Message.all));

         Web_Services.SOAP.Messages.Free (Message);
      end if;
   end Send_Message;

   -----------------------
   -- Send_Next_Message --
   -----------------------

   procedure Send_Next_Message
    (Self    : in out Abstract_Reply_Stream'Class;
     Message : in out Web_Services.SOAP.Messages.SOAP_Message_Access) is
   begin
      --  Status doesn't matter in next messages, let it be S_200

      Self.Send_Message (S_200, Message);
   end Send_Next_Message;

end Web_Services.SOAP.Reply_Streams;
