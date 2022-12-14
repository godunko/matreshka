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
-- Copyright © 2012-2013, Vadim Godunko <vgodunko@gmail.com>                --
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
with XML.SAX.Writers;

with Web_Services.SOAP.Payloads.Faults.Encoders.Registry;

package body Web_Services.SOAP.Payloads.Faults.Simple is

   type Simple_Fault_Encoder is
     limited new Web_Services.SOAP.Payloads.Faults.Encoders.SOAP_Fault_Encoder
       with null record;

   overriding function Create
    (Dummy : not null access Boolean) return Simple_Fault_Encoder;

   overriding procedure Encode
    (Self    : Simple_Fault_Encoder;
     Message : Web_Services.SOAP.Payloads.Faults.Abstract_SOAP_Fault'Class;
     Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   ------------
   -- Create --
   ------------

   overriding function Create
    (Dummy : not null access Boolean) return Simple_Fault_Encoder
   is
      pragma Unreferenced (Dummy);

   begin
      return Result : Simple_Fault_Encoder;
   end Create;

   ----------------------------------
   -- Create_Must_Understand_Fault --
   ----------------------------------

   function Create_Must_Understand_Fault
    (Reason_Language    : League.Strings.Universal_String;
     Reason_Text        : League.Strings.Universal_String;
     Detail             : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String)
       return Web_Services.SOAP.Payloads.SOAP_Payload_Access is
   begin
      return Result : constant Web_Services.SOAP.Payloads.SOAP_Payload_Access
               := new Simple_Must_Understand_Fault
      do
         declare
            Self   : Simple_Must_Understand_Fault
              renames Simple_Must_Understand_Fault (Result.all);
            Reason : Web_Services.SOAP.Payloads.Faults.Language_Text_Maps.Map;

         begin
            Reason.Insert (Reason_Language, Reason_Text);
            Web_Services.SOAP.Payloads.Faults.Initialize
             (Self,
              Web_Services.SOAP.Payloads.Faults.Code_Vectors.Empty_Vector,
              Reason);
            Self.Detail := Detail;
         end;
      end return;
   end Create_Must_Understand_Fault;

   -------------------------
   -- Create_Sender_Fault --
   -------------------------

   function Create_Sender_Fault
    (Subcode_Namespace_URI : League.Strings.Universal_String;
     Subcode_Local_Name    : League.Strings.Universal_String;
     Subcode_Prexif        : League.Strings.Universal_String;
     Reason_Language       : League.Strings.Universal_String;
     Reason_Text           : League.Strings.Universal_String;
     Detail                : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String)
       return Web_Services.SOAP.Payloads.SOAP_Payload_Access is
   begin
      return Result : constant Web_Services.SOAP.Payloads.SOAP_Payload_Access
               := new Simple_Sender_Fault
      do
         declare
            Self   : Simple_Sender_Fault
              renames Simple_Sender_Fault (Result.all);
            Codes  : Web_Services.SOAP.Payloads.Faults.Code_Vectors.Vector;
            Reason : Web_Services.SOAP.Payloads.Faults.Language_Text_Maps.Map;

         begin
            Codes.Append
             ((Subcode_Namespace_URI, Subcode_Local_Name, Subcode_Prexif));
            Reason.Insert (Reason_Language, Reason_Text);
            Web_Services.SOAP.Payloads.Faults.Initialize (Self, Codes, Reason);
            Self.Detail := Detail;
         end;
      end return;
   end Create_Sender_Fault;

   -------------------------
   -- Create_Sender_Fault --
   -------------------------

   function Create_Sender_Fault
    (Reason_Language    : League.Strings.Universal_String;
     Reason_Text        : League.Strings.Universal_String;
     Detail             : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String)
       return Web_Services.SOAP.Payloads.SOAP_Payload_Access is
   begin
      return Result : constant Web_Services.SOAP.Payloads.SOAP_Payload_Access
               := new Simple_Sender_Fault
      do
         declare
            Self   : Simple_Sender_Fault
              renames Simple_Sender_Fault (Result.all);
            Reason : Web_Services.SOAP.Payloads.Faults.Language_Text_Maps.Map;

         begin
            Reason.Insert (Reason_Language, Reason_Text);
            Web_Services.SOAP.Payloads.Faults.Initialize
             (Self,
              Web_Services.SOAP.Payloads.Faults.Code_Vectors.Empty_Vector,
              Reason);
            Self.Detail := Detail;
         end;
      end return;
   end Create_Sender_Fault;

   -----------------------------------
   -- Create_Version_Mismatch_Fault --
   -----------------------------------

   function Create_Version_Mismatch_Fault
    (Reason_Language    : League.Strings.Universal_String;
     Reason_Text        : League.Strings.Universal_String;
     Detail             : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String)
       return Web_Services.SOAP.Payloads.SOAP_Payload_Access is
   begin
      return Result : constant Web_Services.SOAP.Payloads.SOAP_Payload_Access
               := new Simple_Version_Mismatch_Fault
      do
         declare
            Self   : Simple_Version_Mismatch_Fault
              renames Simple_Version_Mismatch_Fault (Result.all);
            Reason : Web_Services.SOAP.Payloads.Faults.Language_Text_Maps.Map;

         begin
            Reason.Insert (Reason_Language, Reason_Text);
            Web_Services.SOAP.Payloads.Faults.Initialize
             (Self,
              Web_Services.SOAP.Payloads.Faults.Code_Vectors.Empty_Vector,
              Reason);
            Self.Detail := Detail;
         end;
      end return;
   end Create_Version_Mismatch_Fault;

   ------------
   -- Encode --
   ------------

   overriding procedure Encode
    (Self    : Simple_Fault_Encoder;
     Message : Web_Services.SOAP.Payloads.Faults.Abstract_SOAP_Fault'Class;
     Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
      pragma Unreferenced (Self);

      Detail : League.Strings.Universal_String;

   begin
      if Message in Simple_Must_Understand_Fault'Class then
         Detail := Simple_Must_Understand_Fault (Message).Detail;

      elsif Message in Simple_Version_Mismatch_Fault'Class then
         Detail := Simple_Version_Mismatch_Fault (Message).Detail;

      elsif Message in Simple_Sender_Fault'Class then
         Detail := Simple_Sender_Fault (Message).Detail;

      else
         raise Program_Error;
         --  Must never be happen.
      end if;

      if not Detail.Is_Empty then
         Writer.Characters (Detail);
      end if;
   end Encode;

   ----------------
   -- Has_Detail --
   ----------------

   overriding function Has_Detail
    (Self : Simple_Must_Understand_Fault) return Boolean is
   begin
      return not Self.Detail.Is_Empty;
   end Has_Detail;

   ----------------
   -- Has_Detail --
   ----------------

   overriding function Has_Detail
    (Self : Simple_Version_Mismatch_Fault) return Boolean is
   begin
      return not Self.Detail.Is_Empty;
   end Has_Detail;

   ----------------
   -- Has_Detail --
   ----------------

   overriding function Has_Detail
    (Self : Simple_Sender_Fault) return Boolean is
   begin
      return not Self.Detail.Is_Empty;
   end Has_Detail;

begin
   Web_Services.SOAP.Payloads.Faults.Encoders.Registry.Register
    (Simple_Must_Understand_Fault'Tag, Simple_Fault_Encoder'Tag);
   Web_Services.SOAP.Payloads.Faults.Encoders.Registry.Register
    (Simple_Version_Mismatch_Fault'Tag, Simple_Fault_Encoder'Tag);
   Web_Services.SOAP.Payloads.Faults.Encoders.Registry.Register
    (Simple_Sender_Fault'Tag, Simple_Fault_Encoder'Tag);
end Web_Services.SOAP.Payloads.Faults.Simple;
