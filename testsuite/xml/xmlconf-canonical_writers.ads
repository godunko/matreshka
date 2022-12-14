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
-- Copyright © 2010, Vadim Godunko <vgodunko@gmail.com>                     --
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
--  This package provides XML writer to transform SAX events into XML text
--  in canonical form.
------------------------------------------------------------------------------
with Ada.Containers.Ordered_Maps;

with League.Strings;
with XML.SAX.Attributes;
with XML.SAX.Content_Handlers;
with XML.SAX.DTD_Handlers;
with XML.SAX.Lexical_Handlers;
with XML.SAX.Locators;

package XMLConf.Canonical_Writers is

   type Notation_Information is record
      Name      : League.Strings.Universal_String;
      Public_Id : League.Strings.Universal_String;
      System_Id : League.Strings.Universal_String;
   end record;

   package Notation_Maps is
     new Ada.Containers.Ordered_Maps
          (League.Strings.Universal_String,
           Notation_Information,
           League.Strings."<");

   type XML_Version is (Unspecified, XML_1_0, XML_1_1);

   type Canonical_Writer is
     limited new XML.SAX.Content_Handlers.SAX_Content_Handler
       and XML.SAX.DTD_Handlers.SAX_DTD_Handler
       and XML.SAX.Lexical_Handlers.SAX_Lexical_Handler with
   record
      Result    : League.Strings.Universal_String;
      Name      : League.Strings.Universal_String;
      Notations : Notation_Maps.Map;
      Locator   : XML.SAX.Locators.SAX_Locator;
      Version   : XML_Version := Unspecified;
   end record;

--  GNAT GPL 2010: type cann't be declared private becuase of bug in the
--  compiler.
--
--   type Canonical_Writer is
--     limited new XML.SAX.Content_Handlers.SAX_Content_Handler
--       and XML.SAX.DTD_Handlers.SAX_DTD_Handler
--       and XML.SAX.Lexical_Handlers.SAX_Lexical_Handler with private;

   function Text
    (Self : Canonical_Writer) return League.Strings.Universal_String;
   --  Returns text of XML document in canonical form.

   overriding procedure Characters
    (Self    : in out Canonical_Writer;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean);

   overriding procedure End_DTD
    (Self    : in out Canonical_Writer;
     Success : in out Boolean);

   overriding procedure End_Element
    (Self           : in out Canonical_Writer;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean);

   overriding function Error_String
    (Self : Canonical_Writer) return League.Strings.Universal_String;

   overriding procedure Ignorable_Whitespace
    (Self    : in out Canonical_Writer;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean);

   overriding procedure Notation_Declaration
    (Self      : in out Canonical_Writer;
     Name      : League.Strings.Universal_String;
     Public_Id : League.Strings.Universal_String;
     System_Id : League.Strings.Universal_String;
     Success   : in out Boolean);

   overriding procedure Processing_Instruction
    (Self    : in out Canonical_Writer;
     Target  : League.Strings.Universal_String;
     Data    : League.Strings.Universal_String;
     Success : in out Boolean);

   overriding procedure Set_Document_Locator
    (Self    : in out Canonical_Writer;
     Locator : XML.SAX.Locators.SAX_Locator);

   overriding procedure Start_DTD
    (Self      : in out Canonical_Writer;
     Name      : League.Strings.Universal_String;
     Public_Id : League.Strings.Universal_String;
     System_Id : League.Strings.Universal_String;
     Success   : in out Boolean);

   overriding procedure Start_Element
    (Self           : in out Canonical_Writer;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean);

--private
--
--   type Notation_Information is record
--      Name      : League.Strings.Universal_String;
--      Public_Id : League.Strings.Universal_String;
--      System_Id : League.Strings.Universal_String;
--   end record;
--
--   package Notation_Maps is
--     new Ada.Containers.Ordered_Maps
--          (League.Strings.Universal_String,
--           Notation_Information,
--           League.Strings."<");
--
--   type Canonical_Writer is
--     limited new XML.SAX.Content_Handlers.SAX_Content_Handler
--       and XML.SAX.DTD_Handlers.SAX_DTD_Handler
--       and XML.SAX.Lexical_Handlers.SAX_Lexical_Handler with
--   record
--      Result    : League.Strings.Universal_String;
--      Name      : League.Strings.Universal_String;
--      Notations : Notation_Maps.Map;
--   end record;

end XMLConf.Canonical_Writers;
