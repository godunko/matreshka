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
--  Base data structure for internal representation of SOAP Message.
------------------------------------------------------------------------------
with Ada.Containers.Hashed_Maps;
with Ada.Tags;

with Web_Services.SOAP.Headers;
with Web_Services.SOAP.Payloads;
with Web_Services.SOAP.Reply_Streams;

package Web_Services.SOAP.Messages is

   function Hash (Item : Ada.Tags.Tag) return Ada.Containers.Hash_Type;

   package Header_Maps is
     new Ada.Containers.Hashed_Maps
          (Ada.Tags.Tag,
           Web_Services.SOAP.Headers.SOAP_Header_Access,
           Hash,
           Ada.Tags."=",
           Web_Services.SOAP.Headers."=");

   type SOAP_Message is limited record
      Output  : Web_Services.SOAP.Reply_Streams.Reply_Stream_Access;
      Headers : Header_Maps.Map;
      Payload : Web_Services.SOAP.Payloads.SOAP_Payload_Access;
   end record;

   type SOAP_Message_Access is access all SOAP_Message;

   procedure Finalize (Self : in out SOAP_Message);

   procedure Free (Message : in out SOAP_Message_Access);

end Web_Services.SOAP.Messages;
