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
with Ada.Containers.Hashed_Maps;
with Ada.Tags.Generic_Dispatching_Constructor;
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with League.Strings.Hash;

package body Web_Services.SOAP.Decoder_Registry is

   function Create is
     new Ada.Tags.Generic_Dispatching_Constructor
          (Web_Services.SOAP.Decoders.SOAP_Decoder,
           League.Strings.Universal_String,
           Web_Services.SOAP.Decoders.Create);

   package String_Tag_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           Ada.Tags.Tag,
           League.Strings.Hash,
           League.Strings."=",
           Ada.Tags."=");

   Registry : String_Tag_Maps.Map;

   --------------
   -- Register --
   --------------

   procedure Register
    (URI : League.Strings.Universal_String;
     Tag : Ada.Tags.Tag) is
   begin
      Put_Line ("Decoder is registered for '" & URI.To_Wide_Wide_String & ''');
      Registry.Insert (URI, Tag);
   end Register;

   -------------
   -- Resolve --
   -------------

   function Resolve
    (URI : League.Strings.Universal_String)
       return not null Web_Services.SOAP.Decoders.SOAP_Decoder_Access
   is
      Aux : aliased League.Strings.Universal_String := URI;

   begin
      Put_Line ("Lookup for decoder of '" & URI.To_Wide_Wide_String & ''');
      return
        new Web_Services.SOAP.Decoders.SOAP_Decoder'Class'
             (Create (Registry.Element (URI), Aux'Access));
   end Resolve;

end Web_Services.SOAP.Decoder_Registry;
