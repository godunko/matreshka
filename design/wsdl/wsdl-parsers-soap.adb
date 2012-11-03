------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                              Tools Component                             --
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
with WSDL.Constants;

package body WSDL.Parsers.SOAP is

   use WSDL.Constants;

   ---------------------------
   -- Start_Binding_Element --
   ---------------------------

   procedure Start_Binding_Element
    (Attributes : XML.SAX.Attributes.SAX_Attributes;
     Node       : not null WSDL.AST.Bindings.Binding_Access;
     Success    : in out Boolean) is
   begin
      --  SOAPBinding-2069: "Every SOAP binding MUST indicate what version of
      --  SOAP is in use for the operations of the interface that this binding
      --  applies to."
      --
      --  "{soap version} The actual value of the wsoap:version attribute
      --  information item, if present; otherwise "1.2"."
      --
      --  Thus, we don't need to check and issue error for SOAPBinding-2069,
      --  but we need to set default value.

      if Attributes.Is_Specified (SOAP_Namespace_URI, Version_Attribute) then
         Node.SOAP.Version :=
           Attributes.Value (SOAP_Namespace_URI, Version_Attribute);

      else
         Node.SOAP.Version := SOAP_Version_12_Literal;
      end if;

      --  SOAPBinding-2070: "Every SOAP binding MUST indicate what underlying
      --  protocol is in use."
      --
      --  There is no default value for this property, thus report error when
      --  this attribute is absent.

      if not Attributes.Is_Specified
              (SOAP_Namespace_URI, Protocol_Attribute)
      then
         raise Program_Error;
      end if;

      Node.SOAP.Underlying_Protocol :=
        Attributes.Value (SOAP_Namespace_URI, Protocol_Attribute);
   end Start_Binding_Element;

end WSDL.Parsers.SOAP;
