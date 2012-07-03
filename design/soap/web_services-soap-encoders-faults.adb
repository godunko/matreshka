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
with XML.SAX.Attributes;

with Web_Services.SOAP.Constants;

package body Web_Services.SOAP.Encoders.Faults is

   use Web_Services.SOAP.Constants;

   ------------
   -- Encode --
   ------------

   overriding procedure Encode
    (Self    : Abstract_SOAP_Fault_Encoder;
     Message : Web_Services.SOAP.Messages.Abstract_SOAP_Message'Class;
     Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
      Fault : Web_Services.SOAP.Messages.Faults.Abstract_SOAP_Fault'Class
        renames Web_Services.SOAP.Messages.Faults.Abstract_SOAP_Fault'Class
                 (Message);

   begin
      Writer.Start_Element (SOAP_Envelope_URI, SOAP_Fault_Name);

      --  Serialize mandatory 'Code' element. 'Value' element is mandatory,
      --  while 'Subcode' elements are optional.

      Writer.Start_Element (SOAP_Envelope_URI, SOAP_Code_Name);

      Writer.Start_Element (SOAP_Envelope_URI, SOAP_Value_Name);
      Writer.Characters (Fault.Code_Namespace_URI);
      --  XXX Namespace URI to prefix mapping resolution must to be implemented
      --  here.
      Writer.Characters (League.Strings.To_Universal_String (":"));
--      Writer.Characters (':');
      Writer.Characters (Fault.Code_Local_Name);
      Writer.End_Element (SOAP_Envelope_URI, SOAP_Value_Name);

      Abstract_SOAP_Fault_Encoder'Class (Self).Encode_Code_Subcode
       (Fault, Writer);

      Writer.End_Element (SOAP_Envelope_URI, SOAP_Code_Name);

      --  Serialize mandatory 'Reason' element.

      Writer.Start_Element (SOAP_Envelope_URI, SOAP_Reason_Name);

      declare
         Reason     : Web_Services.SOAP.Messages.Faults.Language_Text_Maps.Map
           := Fault.Reason;
         Position   :
           Web_Services.SOAP.Messages.Faults.Language_Text_Maps.Cursor
             := Reason.First;
         Attributes : XML.SAX.Attributes.SAX_Attributes;

      begin
         while
           Web_Services.SOAP.Messages.Faults.Language_Text_Maps.Has_Element
            (Position)
         loop
            Attributes.Clear;
            Attributes.Set_Value
             (XML_URI,
              XML_Lang_Name,
              Web_Services.SOAP.Messages.Faults.Language_Text_Maps.Key
               (Position));
            Writer.Start_Element
             (SOAP_Envelope_URI, SOAP_Text_Name, Attributes => Attributes);
            Writer.Characters
             (Web_Services.SOAP.Messages.Faults.Language_Text_Maps.Element
               (Position));
            Writer.End_Element (SOAP_Envelope_URI, SOAP_Text_Name);
            Web_Services.SOAP.Messages.Faults.Language_Text_Maps.Next
             (Position);
         end loop;
      end;

      Writer.End_Element (SOAP_Envelope_URI, SOAP_Reason_Name);

      --  Serialize optional 'Node' attribute.

      Abstract_SOAP_Fault_Encoder'Class (Self).Encode_Node (Fault, Writer);

      --  Serialize optional 'Role' attribute.

      Abstract_SOAP_Fault_Encoder'Class (Self).Encode_Role (Fault, Writer);

      --  Serialize optional 'Detail' attribute.

      Abstract_SOAP_Fault_Encoder'Class (Self).Encode_Detail (Fault, Writer);

      Writer.End_Element (SOAP_Envelope_URI, SOAP_Fault_Name);
   end Encode;

end Web_Services.SOAP.Encoders.Faults;
