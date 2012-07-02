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
--  SOAP message handler process events from SAX parser.
------------------------------------------------------------------------------
with League.Strings;
with XML.SAX.Attributes;
with XML.SAX.Content_Handlers;
--  with XML.SAX.Error_Handlers;

private with Web_Services.SOAP.Decoders;

package Web_Services.SOAP.Message_Handlers is

   type SOAP_Message_Handler is
     new XML.SAX.Content_Handlers.SAX_Content_Handler with private;

   function Success (Self : SOAP_Message_Handler'Class) return Boolean;

   function Fault
    (Self : SOAP_Message_Handler'Class) return League.Strings.Universal_String;

private

   type States is
    (Initial,             --  Initial state.
     SOAP_Body,           --  SOAP Body element has beed processed.
     SOAP_Body_Element);  --  SOAP Body child element has been processed.

   type SOAP_Message_Handler is
     new XML.SAX.Content_Handlers.SAX_Content_Handler with
   record
      State          : States := Initial;
      Decoder        : Web_Services.SOAP.Decoders.SOAP_Decoder_Access;
      Body_Depth     : Natural := 0;
      Ignore_Element : Natural := 0;
      Fault          : League.Strings.Universal_String;
      Diagnosis      : League.Strings.Universal_String;
   end record;

--   not overriding procedure Error
--    (Self       : in out SAX_Error_Handler;
--     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
--     Success    : in out Boolean) is null;
--
--   not overriding procedure Fatal_Error
--    (Self       : in out SAX_Error_Handler;
--     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
--     Success    : in out Boolean) is null;
--
--   not overriding procedure Warning
--    (Self       : in out SAX_Error_Handler;
--     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
--     Success    : in out Boolean) is null;

   overriding procedure End_Element
    (Self           : in out SOAP_Message_Handler;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean);

   overriding function Error_String
    (Self : SOAP_Message_Handler) return League.Strings.Universal_String;
   --  Returns error information as string.

   overriding procedure Processing_Instruction
    (Self    : in out SOAP_Message_Handler;
     Target  : League.Strings.Universal_String;
     Data    : League.Strings.Universal_String;
     Success : in out Boolean);
   --  Handles processing instructions in XML stream. Processing instructions
   --  are prohibited in SOAP messages, this subprogram always sets Success to
   --  False.

   overriding procedure Start_Element
    (Self           : in out SOAP_Message_Handler;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean);

end Web_Services.SOAP.Message_Handlers;
