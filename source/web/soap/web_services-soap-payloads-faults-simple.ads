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
with League.Strings;

package Web_Services.SOAP.Payloads.Faults.Simple is

   type Simple_Must_Understand_Fault is new Must_Understand_Fault with private;

   type Simple_Version_Mismatch_Fault is
     new Version_Mismatch_Fault with private;

   type Simple_Sender_Fault is new Sender_Fault with private;

   function Create_Must_Understand_Fault
    (Reason_Language : League.Strings.Universal_String;
     Reason_Text     : League.Strings.Universal_String;
     Detail          : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String)
       return Web_Services.SOAP.Payloads.SOAP_Payload_Access;

   function Create_Sender_Fault
    (Reason_Language : League.Strings.Universal_String;
     Reason_Text     : League.Strings.Universal_String;
     Detail          : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String)
       return Web_Services.SOAP.Payloads.SOAP_Payload_Access;
   --  Creates evn:Sender fault with specified Reason and Detail.

   function Create_Sender_Fault
    (Subcode_Namespace_URI : League.Strings.Universal_String;
     Subcode_Local_Name    : League.Strings.Universal_String;
     Subcode_Prexif        : League.Strings.Universal_String;
     Reason_Language       : League.Strings.Universal_String;
     Reason_Text           : League.Strings.Universal_String;
     Detail                : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String)
       return Web_Services.SOAP.Payloads.SOAP_Payload_Access;
   --  Creates evn:Sender fault with specified Subcode, Reason and Detail.

   function Create_Version_Mismatch_Fault
    (Reason_Language : League.Strings.Universal_String;
     Reason_Text     : League.Strings.Universal_String;
     Detail          : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String)
       return Web_Services.SOAP.Payloads.SOAP_Payload_Access;

private

   type Simple_Must_Understand_Fault is new Must_Understand_Fault with record
      Detail : League.Strings.Universal_String;
   end record;

   overriding function Has_Detail
    (Self : Simple_Must_Understand_Fault) return Boolean;

   type Simple_Version_Mismatch_Fault is new Version_Mismatch_Fault with record
      Detail : League.Strings.Universal_String;
   end record;

   overriding function Has_Detail
    (Self : Simple_Version_Mismatch_Fault) return Boolean;

   type Simple_Sender_Fault is new Sender_Fault with record
      Detail : League.Strings.Universal_String;
   end record;

   overriding function Has_Detail
    (Self : Simple_Sender_Fault) return Boolean;

end Web_Services.SOAP.Payloads.Faults.Simple;
