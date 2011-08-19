------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                            Testsuite Component                           --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2011, Vadim Godunko <vgodunko@gmail.com>                     --
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
private with League.Strings;
private with XML.SAX.Attributes;
with XML.SAX.Content_Handlers;
with XML.SAX.Error_Handlers;
private with XML.SAX.Locators;
private with XML.SAX.Parse_Exceptions;

package XMLCatConf.Testsuite_Handlers is

   type Testsuite_Handler is
     limited new XML.SAX.Content_Handlers.SAX_Content_Handler
       and XML.SAX.Error_Handlers.SAX_Error_Handler with private;

private

   type Testsuite_Handler is
     limited new XML.SAX.Content_Handlers.SAX_Content_Handler
       and XML.SAX.Error_Handlers.SAX_Error_Handler with
   record
      Locator : XML.SAX.Locators.SAX_Locator;
   end record;

   overriding procedure Error
    (Self       : in out Testsuite_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
     Success    : in out Boolean);

   overriding function Error_String
    (Self : Testsuite_Handler) return League.Strings.Universal_String;

   overriding procedure Fatal_Error
    (Self       : in out Testsuite_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
     Success    : in out Boolean);

   overriding procedure Set_Document_Locator
    (Self    : in out Testsuite_Handler;
     Locator : XML.SAX.Locators.SAX_Locator);

   overriding procedure Start_Element
    (Self           : in out Testsuite_Handler;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean);

   overriding procedure Warning
    (Self       : in out Testsuite_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
     Success    : in out Boolean);

end XMLCatConf.Testsuite_Handlers;
