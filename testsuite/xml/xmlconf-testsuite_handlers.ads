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
-- Copyright © 2010-2012, Vadim Godunko <vgodunko@gmail.com>                --
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
with Ada.Containers.Hashed_Sets;

with League.IRIs;
with League.Strings.Hash;
with XML.SAX.Attributes;
with XML.SAX.Content_Handlers;
with XML.SAX.Error_Handlers;
with XML.SAX.Locators;
with XML.SAX.Parse_Exceptions;

package XMLConf.Testsuite_Handlers is

   type Result_Record is record
      Passed     : Natural := 0;
      Failed     : Natural := 0;
      Crash      : Natural := 0;
      Output     : Natural := 0;
      SAX        : Natural := 0;
      Suppressed : Natural := 0;
   end record;

   type Result_Array is array (Test_Kinds) of Result_Record;

   package Universal_String_Sets is
     new Ada.Containers.Hashed_Sets
          (League.Strings.Universal_String,
           League.Strings.Hash,
           League.Strings."=",
           League.Strings."=");

   type Testsuite_Handler is
     limited new XML.SAX.Content_Handlers.SAX_Content_Handler
       and XML.SAX.Error_Handlers.SAX_Error_Handler
   with record
      Locator            : XML.SAX.Locators.SAX_Locator;
      Enabled            : Test_Flags;
      Validating         : Boolean;
      Testsuite_Base_URI : League.IRIs.IRI;
      --  Base URI of the testsuite data.
      Expected_Base_URI  : League.IRIs.IRI;
      --  Base URI of the expected SAX events data.
      Results            : Result_Array;
      Suppressed         : Universal_String_Sets.Set;
   end record;

   procedure Read_Suppressed
    (Self : in out Testsuite_Handler; File_Name : String);
   --  Reads list of suppressed tests.

   overriding function Error_String
    (Self : Testsuite_Handler)
       return League.Strings.Universal_String;

   overriding procedure Set_Document_Locator
    (Self    : in out Testsuite_Handler;
     Locator : XML.SAX.Locators.SAX_Locator);

   overriding procedure Start_Document
    (Self    : in out Testsuite_Handler;
     Success : in out Boolean);

   overriding procedure Start_Element
    (Self           : in out Testsuite_Handler;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean);

   overriding procedure Fatal_Error
    (Self       : in out Testsuite_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception);

end XMLConf.Testsuite_Handlers;
