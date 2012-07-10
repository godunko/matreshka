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
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Unchecked_Deallocation;

with Web_Services.SOAP.Constants;
with Web_Services.SOAP.Decoder_Registry;

package body Web_Services.SOAP.Message_Decoders is

   use Web_Services.SOAP.Constants;
   use type League.Strings.Universal_String;

   procedure Free is
     new Ada.Unchecked_Deallocation
          (Web_Services.SOAP.Body_Decoders.SOAP_Body_Decoder'Class,
           Web_Services.SOAP.Body_Decoders.SOAP_Body_Decoder_Access);

   ----------------
   -- Characters --
   ----------------

   overriding procedure Characters
    (Self    : in out SOAP_Message_Decoder;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      if Self.State = SOAP_Body_Element
        and then Self.Body_Depth /= 0
      then
         Self.Decoder.Characters (Text, Success);
      end if;
   end Characters;

   -----------------
   -- End_Element --
   -----------------

   overriding procedure End_Element
    (Self           : in out SOAP_Message_Decoder;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean) is
   begin
      if Self.Ignore_Element /= 0 then
         --  Decrement depth of ignore element counter.

         Self.Ignore_Element := Self.Ignore_Element - 1;

      elsif Namespace_URI = SOAP_Envelope_URI then
         if Local_Name = SOAP_Body_Name then
            Self.State := Initial;
         end if;

      elsif Self.State = SOAP_Body_Element then
         --  Decrement depth of nesting XML elements in Body element.

         Self.Body_Depth := Self.Body_Depth - 1;

         --  Redirect processing to decoder.

         Self.Decoder.End_Element (Namespace_URI, Local_Name, Success);

         if Self.Body_Depth = 0 then
            Self.Message := Self.Decoder.Message;

            Free (Self.Decoder);
         end if;
      end if;
   end End_Element;

   -----------
   -- Error --
   -----------

   overriding procedure Error
    (Self       : in out SOAP_Message_Decoder;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
     Success    : in out Boolean)
       renames Fatal_Error;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : SOAP_Message_Decoder) return League.Strings.Universal_String is
   begin
      return Self.Diagnosis;
   end Error_String;

   -----------------
   -- Fatal_Error --
   -----------------

   overriding procedure Fatal_Error
    (Self       : in out SOAP_Message_Decoder;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
     Success    : in out Boolean) is
   begin
      Self.Diagnosis := Occurrence.Message;
      Success := False;
   end Fatal_Error;

   -----------
   -- Fault --
   -----------

   function Fault
    (Self : SOAP_Message_Decoder'Class)
       return League.Strings.Universal_String is
   begin
      return Self.Fault;
   end Fault;

   -------------
   -- Message --
   -------------

   function Message
    (Self : SOAP_Message_Decoder'Class)
       return not null Web_Services.SOAP.Messages.SOAP_Message_Access is
   begin
      return Self.Message;
   end Message;

   ----------------------------
   -- Processing_Instruction --
   ----------------------------

   overriding procedure Processing_Instruction
    (Self    : in out SOAP_Message_Decoder;
     Target  : League.Strings.Universal_String;
     Data    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      --  [SOAP12]  5. SOAP Message Construct
      --
      --  "SOAP messages sent by initial SOAP senders MUST NOT contain
      --  processing instruction information items. SOAP intermediaries MUST
      --  NOT insert processing instruction information items in SOAP messages
      --  they relay. SOAP receivers receiving a SOAP message containing a
      --  processing instruction information item SHOULD generate a SOAP fault
      --  with the Value of Code set to "env:Sender"."

      Self.Diagnosis :=
        League.Strings.To_Universal_String
         ("SOAP message must not contain processing instruction");
      Self.Fault := League.Strings.To_Universal_String ("env:Sender");
      Success := False;
   end Processing_Instruction;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out SOAP_Message_Decoder;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean) is
   begin
      if Self.Ignore_Element /= 0 then
         --  Each children element of unknown element increments element ignore
         --  counter to proper handling of arbitrary depth of elements.

         Self.Ignore_Element := Self.Ignore_Element + 1;

      elsif Namespace_URI = SOAP_Envelope_URI then
         if Local_Name = SOAP_Envelope_Name then
            null;

         elsif Local_Name = SOAP_Header_Name then
            --  "Header" element is not processed now.

            Self.Ignore_Element := 1;

         elsif Local_Name = SOAP_Body_Name then
            --  Switch state to process content of SOAP Body element.

            Self.State := SOAP_Body;

         else
            Put_Line
             ("Unknown element '" & Local_Name.To_Wide_Wide_String & ''');
         end if;

      elsif Self.State = SOAP_Body then
         --  SOAP Body element has been processed, current element is its
         --  child. Appropriate decoder must be created to continue processing.

         Self.Decoder :=
           Web_Services.SOAP.Decoder_Registry.Resolve (Namespace_URI);
         Self.State := SOAP_Body_Element;
         Self.Body_Depth := 1;

         --  Redirect handling of current XML element to decoder.

         Self.Decoder.Start_Element
          (Namespace_URI, Local_Name, Attributes, Success);

      elsif Self.State = SOAP_Body_Element then
         --  Redirect handling of current XML element to decoder.

         Self.Decoder.Start_Element
          (Namespace_URI, Local_Name, Attributes, Success);

         --  Increment depth of nested XML elements in Body element.

         Self.Body_Depth := Self.Body_Depth + 1;

      else
         --  Violation of SOAP envelope format.

         Put_Line
          (Namespace_URI.To_Wide_Wide_String
             & " : "
             & Local_Name.To_Wide_Wide_String);
      end if;
   end Start_Element;

   -------------
   -- Success --
   -------------

   function Success (Self : SOAP_Message_Decoder'Class) return Boolean is
   begin
      return Self.Diagnosis.Is_Empty;
   end Success;

end Web_Services.SOAP.Message_Decoders;
