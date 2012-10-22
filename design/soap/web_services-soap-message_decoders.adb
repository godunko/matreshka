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
with Web_Services.SOAP.Header_Decoders.Registry;
with Web_Services.SOAP.Payloads.Decoders.Registry;
with Web_Services.SOAP.Payloads.Faults.Simple;

package body Web_Services.SOAP.Message_Decoders is

   use Web_Services.SOAP.Constants;
   use type League.Strings.Universal_String;

   procedure Free is
     new Ada.Unchecked_Deallocation
          (Web_Services.SOAP.Payloads.Decoders.SOAP_Payload_Decoder'Class,
           Web_Services.SOAP.Payloads.Decoders.SOAP_Payload_Decoder_Access);

   procedure Free is
     new Ada.Unchecked_Deallocation
          (Web_Services.SOAP.Messages.SOAP_Message'Class,
           Web_Services.SOAP.Messages.SOAP_Message_Access);

   procedure Set_Sender_Fault
    (Self   : in out SOAP_Message_Decoder'Class;
     Text   : League.Strings.Universal_String;
     Detail : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String);
   --  Sets error state with specified diagnosis and creates env:Sender fault
   --  message.

   procedure Set_Must_Understand_Error
    (Self      : in out SOAP_Message_Decoder'Class;
     Diagnosis : League.Strings.Universal_String);
   --  Sets error state with specified diagnosis and creates env:MustUnderstand
   --  fault message.

   procedure Set_Version_Mismatch_Fault
    (Self      : in out SOAP_Message_Decoder'Class;
     Diagnosis : League.Strings.Universal_String);
   --  Sets error state with specified diagnosis and creates
   --  env:VersionMismatch fault message.

   procedure Check_No_SOAP_Encoding_Style_Attribute
    (Self       : in out SOAP_Message_Decoder'Class;
     Local_Name : League.Strings.Universal_String;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean);
   --  Checks that encodingStyle attribute is not present in the given set of
   --  attributes.

   ----------------
   -- Characters --
   ----------------

   overriding procedure Characters
    (Self    : in out SOAP_Message_Decoder;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      if Self.State = SOAP_Header_Element
        and then Self.Header_Depth /= 0
      then
         Self.Header_Decoder.Characters (Text, Success);

      elsif Self.State = SOAP_Body_Element
        and then Self.Body_Depth /= 0
      then
         Self.Payload_Decoder.Characters (Text, Success);

         if not Success then
            Self.Set_Sender_Fault
             (League.Strings.To_Universal_String
               ("Message body decoder reports error"));

            return;
         end if;
      end if;
   end Characters;

   --------------------------------------------
   -- Check_No_SOAP_Encoding_Style_Attribute --
   --------------------------------------------

   procedure Check_No_SOAP_Encoding_Style_Attribute
    (Self       : in out SOAP_Message_Decoder'Class;
     Local_Name : League.Strings.Universal_String;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean) is
   begin
      for J in 1 .. Attributes.Length loop
         if Attributes.Namespace_URI (J) = SOAP_Envelope_URI
           and Attributes.Local_Name (J) = SOAP_Encoding_Style_Name
         then
            Self.Set_Sender_Fault
             (League.Strings.To_Universal_String
               ("Incorrect SOAP Body element serialization"),
              "SOAP "
                & Local_Name
                & " must not have encodingStyle attribute information item.");
            Success := False;

            return;
         end if;
      end loop;
   end Check_No_SOAP_Encoding_Style_Attribute;

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
         if Local_Name = SOAP_Header_Name then
            Self.State := Initial;

         elsif Local_Name = SOAP_Header_Name then
            Self.State := Initial;

         elsif Local_Name = SOAP_Body_Name then
            Self.State := Initial;
         end if;

      elsif Self.State = SOAP_Header_Element then
         --  Decrement depth of nesting XML elements in Header element.

         Self.Header_Depth := Self.Header_Depth - 1;

         --  Redirect processing to decoder.

         Self.Header_Decoder.End_Element (Namespace_URI, Local_Name, Success);

         --  Obtain decoded data.

         if Self.Header_Depth = 0 then
            null;
         end if;

      elsif Self.State = SOAP_Body_Element then
         --  Decrement depth of nesting XML elements in Body element.

         Self.Body_Depth := Self.Body_Depth - 1;

         --  Redirect processing to decoder.

         Self.Payload_Decoder.End_Element (Namespace_URI, Local_Name, Success);

         if not Success then
            Self.Set_Sender_Fault
             (League.Strings.To_Universal_String
               ("Message body decoder reports error"));

            return;
         end if;

         --  Obtain decoded data.

         if Self.Body_Depth = 0 then
            Self.Message :=
              new Web_Services.SOAP.Messages.SOAP_Message'
                   (Payload => Self.Payload_Decoder.Payload);
            Free (Self.Payload_Decoder);
         end if;
      end if;
   end End_Element;

   -----------
   -- Error --
   -----------

   overriding procedure Error
    (Self       : in out SOAP_Message_Decoder;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
     Success    : in out Boolean) is
   begin
      Self.Fatal_Error (Occurrence);
      Success := False;
   end Error;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : SOAP_Message_Decoder) return League.Strings.Universal_String is
   begin
      return
        League.Strings.To_Universal_String
         ("Unknown error in SOAP message decoder");
   end Error_String;

   -----------------
   -- Fatal_Error --
   -----------------

   overriding procedure Fatal_Error
    (Self       : in out SOAP_Message_Decoder;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception) is
   begin
      --  Set error message only when there is no previous error message was
      --  set.

      if Self.Success then
         Self.Set_Sender_Fault ("XML error: " & Occurrence.Message);
      end if;
   end Fatal_Error;

   -------------
   -- Message --
   -------------

   function Message
    (Self : SOAP_Message_Decoder'Class)
       return Web_Services.SOAP.Messages.SOAP_Message_Access is
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

      if Self.Mode = Strict then
         --  This assertion is checked in strict mode only; otherwise Test:T26
         --  testcase of SOAP Conformance Testsuite is failed.

         Self.Set_Sender_Fault
          (League.Strings.To_Universal_String
            ("SOAP message must not contain processing instruction"));
         Success := False;
      end if;
   end Processing_Instruction;

   -------------------------------
   -- Set_Must_Understand_Error --
   -------------------------------

   procedure Set_Must_Understand_Error
    (Self      : in out SOAP_Message_Decoder'Class;
     Diagnosis : League.Strings.Universal_String) is
   begin
      --  Deallocate decoded SOAP message if any.

      Free (Self.Message);

      --  Set error state.

      Self.Success := False;

      --  Create env:MustUnderstand fault reply.

      Self.Message :=
        new Web_Services.SOAP.Messages.SOAP_Message'
             (Payload =>
                Web_Services.SOAP.Payloads.Faults.Simple.Create_SOAP_Fault
                 (League.Strings.To_Universal_String ("MustUnderstand"),
                  League.Strings.To_Universal_String ("en-US"),
                  Diagnosis));
   end Set_Must_Understand_Error;

   ----------------------
   -- Set_Sender_Fault --
   ----------------------

   procedure Set_Sender_Fault
    (Self   : in out SOAP_Message_Decoder'Class;
     Text   : League.Strings.Universal_String;
     Detail : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String) is
   begin
      --  Deallocate decoded SOAP message if any.

      Free (Self.Message);

      --  Set error state and diagnosis.

      Self.Success := False;

      --  Create env:Sender fault reply.

      Self.Message :=
        new Web_Services.SOAP.Messages.SOAP_Message'
             (Payload =>
                Web_Services.SOAP.Payloads.Faults.Simple.Create_SOAP_Fault
                 (League.Strings.To_Universal_String ("Sender"),
                  League.Strings.To_Universal_String ("en-US"),
                  Text,
                  Detail));
   end Set_Sender_Fault;

   --------------------------------
   -- Set_Version_Mismatch_Fault --
   --------------------------------

   procedure Set_Version_Mismatch_Fault
    (Self      : in out SOAP_Message_Decoder'Class;
     Diagnosis : League.Strings.Universal_String) is
   begin
      --  Deallocate decoded SOAP message if any.

      Free (Self.Message);

      --  Set error state and diagnosis.

      Self.Success := False;

      --  Create env:VersionMismatch fault reply.

      Self.Message :=
        new Web_Services.SOAP.Messages.SOAP_Message'
             (Payload =>
                Web_Services.SOAP.Payloads.Faults.Simple.Create_SOAP_Fault
                 (League.Strings.To_Universal_String ("VersionMismatch"),
                  League.Strings.To_Universal_String ("en-US"),
                  Diagnosis));
   end Set_Version_Mismatch_Fault;

   ---------------
   -- Start_DTD --
   ---------------

   overriding procedure Start_DTD
    (Self      : in out SOAP_Message_Decoder;
     Name      : League.Strings.Universal_String;
     Public_Id : League.Strings.Universal_String;
     System_Id : League.Strings.Universal_String;
     Success   : in out Boolean) is
   begin
      --  [SOAP12P1] 5. SOAP Message Construct
      --
      --  "The XML infoset of a SOAP message MUST NOT contain a document type
      --  declaration information item."

      Self.Set_Sender_Fault
       (League.Strings.To_Universal_String
         ("DTD are not supported by SOAP 1.2"));
      Success := False;
   end Start_DTD;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out SOAP_Message_Decoder;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean)
   is
      use type Web_Services.SOAP.Payloads.Decoders.SOAP_Payload_Decoder_Access;
      use type Web_Services.SOAP.Header_Decoders.SOAP_Header_Decoder_Access;

   begin
      if Self.Ignore_Element /= 0 then
         --  Each children element of unknown element increments element ignore
         --  counter to proper handling of arbitrary depth of elements.

         Self.Ignore_Element := Self.Ignore_Element + 1;

      else
         case Self.State is
            when Initial =>
               if Namespace_URI = SOAP_Envelope_URI then
                  if Local_Name = SOAP_Envelope_Name then
                     --  The encodingStyle attribute MUST NOT appear in SOAP
                     --  Envelope element.

                     Self.Check_No_SOAP_Encoding_Style_Attribute
                      (Local_Name, Attributes, Success);

                     if not Success then
                        return;
                     end if;
                  end if;

               elsif Local_Name = SOAP_Envelope_Name then
                  --  Root element has correct name, but unknown namespace;
                  --  report env:VersionMismatch fault.

                  Self.Set_Version_Mismatch_Fault
                   (League.Strings.To_Universal_String ("Wrong Version"));
                  Success := False;

                  return;
               end if;

               Self.State := SOAP_Envelope;

            when SOAP_Envelope =>
               if Namespace_URI = SOAP_Envelope_URI then
                  if Local_Name = SOAP_Header_Name then
                     --  "Header" element is processed now.

                     Self.State := SOAP_Header;

                  elsif Local_Name = SOAP_Body_Name then
                     --  The encodingStyle attribute MUST NOT appear in SOAP
                     --  Body element.

                     Self.Check_No_SOAP_Encoding_Style_Attribute
                      (Local_Name, Attributes, Success);

                     if not Success then
                        return;
                     end if;

                     --  Switch state to process content of SOAP Body element.

                     Self.State := SOAP_Body;

                  else
                     Put_Line
                      ("Unknown element '"
                         & Local_Name.To_Wide_Wide_String
                         & ''');
                  end if;

               else
                  Put_Line
                   ("Unknown element '"
                      & Local_Name.To_Wide_Wide_String
                      & ''');
               end if;

            when SOAP_Header =>
               --  SOAP Header element has been processed, currect element is
               --  its child. Appropriate decoder must be created to continue
               --  processing.

               Self.Header_Decoder :=
                 Web_Services.SOAP.Header_Decoders.Registry.Resolve
                  (Namespace_URI);

               --  [SOAP1.2] 5.2.3 SOAP mustUnderstand Attribute
               --
               --  "Omitting this attribute information item is defined as
               --  being semantically equivalent to including it with a value
               --  of "false".
               --
               --  SOAP senders SHOULD NOT generate, but SOAP receivers MUST
               --  accept, the SOAP mustUnderstand attribute information item
               --  with a value of "false" or "0".
               --
               --  If generating a SOAP mustUnderstand attribute information
               --  item, a SOAP sender SHOULD use the canonical representation
               --  "true" of the attribute value (see XML Schema [XML Schema
               --  Part 2]).  A SOAP receiver MUST accept any valid lexical
               --  representation of the attribute value.
               --
               --  If relaying the message, a SOAP intermediary MAY substitute
               --  "true" for the value "1", or "false" for "0". In addition, a
               --  SOAP intermediary MAY omit a SOAP mustUnderstand attribute
               --  information item if its value is "false" (see 2.7 Relaying
               --  SOAP Messages).
               --
               --  A SOAP sender generating a SOAP message SHOULD use the
               --  mustUnderstand attribute information item only on SOAP
               --  header blocks. A SOAP receiver MUST ignore this attribute
               --  information item if it appears on descendants of a SOAP
               --  header block or on a SOAP body child element information
               --  item (or its descendents)."

               --  XXX Correct processing of literal value of
               --  env:mustUnderstand attribute must be implemented.

               if Self.Header_Decoder = null
                 and then Attributes.Is_Specified
                           (SOAP_Envelope_URI, SOAP_Must_Understand_Name)
                 and then Attributes.Value
                           (SOAP_Envelope_URI, SOAP_Must_Understand_Name)
                              = SOAP_True_Literal
               then
                  --  [SOAP1.2] 5.4.8 SOAP mustUnderstand Faults
                  --
                  --  "When a SOAP node generates a fault with a Value of Code
                  --  set to "env:MustUnderstand", it SHOULD provide
                  --  NotUnderstood SOAP header blocks in the generated fault
                  --  message. The NotUnderstood SOAP header blocks, as
                  --  described below, detail the XML qualified names (per XML
                  --  Schema [XML Schema Part 2]) of the particular SOAP header
                  --  block(s) which were not understood."

                  --  XXX Generation of NotUnderstood SOAP header blocks is not
                  --  implemented yet.

                  Self.Set_Must_Understand_Error
                   (League.Strings.To_Universal_String
                     ("One or more mandatory SOAP header blocks not"
                        & " understood"));
                  Success := False;

               elsif Self.Header_Decoder /= null then
                  --  Decoder has been found, use it to decode header.

                  Self.State := SOAP_Header_Element;
                  Self.Header_Depth := 1;

                  --  Redirect handling of current XML element to decoder.

                  Self.Header_Decoder.Start_Element
                   (Namespace_URI, Local_Name, Attributes, Success);

               else
                  Self.Ignore_Element := 1;
               end if;

            when SOAP_Header_Element =>
               --  Redirect handling of current XML element to decoder.

               Self.Header_Decoder.Start_Element
                (Namespace_URI, Local_Name, Attributes, Success);

               --  Increment depth of nested XML elements in Body element.

               Self.Header_Depth := Self.Header_Depth + 1;

            when SOAP_Body =>
               --  SOAP Body element has been processed, current element is its
               --  child. Appropriate decoder must be created to continue
               --  processing.

               Self.Payload_Decoder :=
                 Web_Services.SOAP.Payloads.Decoders.Registry.Resolve
                  (Namespace_URI);

               if Self.Payload_Decoder = null then
                  Self.Set_Sender_Fault
                   ("Unknown namespace URI '"
                      & Namespace_URI
                      & "' of the child element of SOAP:Body");
                  Success := False;

                  return;
               end if;

               --  [SOAP1.2P1] 5.1.1 SOAP encodingStyle Attribute
               --
               --  "The encodingStyle attribute information item MAY appear on
               --  the following:"
               --
               --  ...
               --
               --  "A child element information item of the SOAP Body element
               --  information item (see 5.3.1 SOAP Body child Element) if that
               --  child is not a SOAP Fault element information item (see 5.4
               --  SOAP Fault)."

               --  XXX This check is not implemented yet.

--               Self.Check_No_SOAP_Encoding_Style_Attribute
--                (Local_Name, Attributes, Success);
--
--               if not Success then
--                  return;
--               end if;

               Self.State := SOAP_Body_Element;
               Self.Body_Depth := 1;

               --  Redirect handling of current XML element to decoder.

               Self.Payload_Decoder.Start_Element
                (Namespace_URI, Local_Name, Attributes, Success);

               if not Success then
                  Self.Set_Sender_Fault
                   (League.Strings.To_Universal_String
                     ("Message body decoder reports error"));

                  return;
               end if;

            when SOAP_Body_Element =>
               --  Redirect handling of current XML element to decoder.

               Self.Payload_Decoder.Start_Element
                (Namespace_URI, Local_Name, Attributes, Success);

               if not Success then
                  Self.Set_Sender_Fault
                   (League.Strings.To_Universal_String
                     ("Message body decoder reports error"));

                  return;
               end if;

               --  Increment depth of nested XML elements in Body element.

               Self.Body_Depth := Self.Body_Depth + 1;
         end case;
      end if;
   end Start_Element;

   -------------
   -- Success --
   -------------

   function Success (Self : SOAP_Message_Decoder'Class) return Boolean is
   begin
      return Self.Success;
   end Success;

end Web_Services.SOAP.Message_Decoders;
