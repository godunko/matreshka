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
with Ada.Wide_Wide_Text_IO;

with League.Application;
with League.Base_64;
with League.Stream_Element_Vectors;
with League.Strings;

with Web_Services.SOAP.Security.Password_Digest_Utilities;

procedure WSSEUTPD is
   Password : constant League.Strings.Universal_String
     := League.Application.Arguments.Element (1);
   Nonce    : constant League.Stream_Element_Vectors.Stream_Element_Vector
     := Web_Services.SOAP.Security.Password_Digest_Utilities.Generate_Nonce;
   Created  : constant League.Strings.Universal_String
     := Web_Services.SOAP.Security.Password_Digest_Utilities.Generate_Created;
   Digest   : constant League.Stream_Element_Vectors.Stream_Element_Vector
     := Web_Services.SOAP.Security.Password_Digest_Utilities.Compute_Digest
         (Password, Nonce, Created);

begin
   Ada.Wide_Wide_Text_IO.Put_Line
    ("Nonce    : "
       & League.Base_64.To_Base_64 (Nonce).To_Wide_Wide_String);
   Ada.Wide_Wide_Text_IO.Put_Line
    ("Created  : " & Created.To_Wide_Wide_String);
   Ada.Wide_Wide_Text_IO.Put_Line
    ("Password : "
       & League.Base_64.To_Base_64 (Digest).To_Wide_Wide_String);
end WSSEUTPD;
