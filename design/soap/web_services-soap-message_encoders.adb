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
with League.Strings;
with League.Text_Codecs;
with XML.SAX.Pretty_Writers;

with Web_Services.SOAP.Constants;
with Web_Services.SOAP.Encoder_Registry;

package body Web_Services.SOAP.Message_Encoders is

   use Web_Services.SOAP.Constants;

   ------------
   -- Encode --
   ------------

   function Encode
    (Self    : in out SOAP_Message_Encoder'Class;
     Message : Web_Services.SOAP.Messages.Abstract_SOAP_Message'Class)
       return League.Stream_Element_Vectors.Stream_Element_Vector
   is
      Codec  : League.Text_Codecs.Text_Codec
        := League.Text_Codecs.Codec
            (League.Strings.To_Universal_String ("utf-8"));
      Writer : XML.SAX.Pretty_Writers.SAX_Pretty_Writer;

   begin
      Writer.Start_Document;
      Writer.Start_Prefix_Mapping (SOAP_Envelope_Prefix, SOAP_Envelope_URI);

      --  Start env:Envelope element.

      Writer.Start_Element (SOAP_Envelope_URI, SOAP_Envelope_Name);

      --  Start env:Body element.

      Writer.Start_Element (SOAP_Envelope_URI, SOAP_Body_Name);

      --  Lookup for SOAP Body encoder.

      Web_Services.SOAP.Encoder_Registry.Resolve
       (Message'Tag).Encode (Message, Writer);

      --  End env:Body and env:Envelope elements.

      Writer.End_Element (SOAP_Envelope_URI, SOAP_Body_Name);
      Writer.End_Element (SOAP_Envelope_URI, SOAP_Envelope_Name);

      return Codec.Encode (Writer.Text);
   end Encode;

end Web_Services.SOAP.Message_Encoders;
