------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2014, Vadim Godunko <vgodunko@gmail.com>                     --
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
--  This package provides schema document parser. It receives SAX events from
--  XML reader and constructs AST of schema document.
------------------------------------------------------------------------------
private with Ada.Containers.Vectors;

private with League.Strings;
private with XML.SAX.Attributes;
with XML.SAX.Content_Handlers;
private with XML.SAX.Locators;

with Matreshka.XML_Schema.AST;

package Matreshka.XML_Schema.Document_Parsers is

   type Document_Parser
         (Model : not null Matreshka.XML_Schema.AST.Model_Access) is
     limited new XML.SAX.Content_Handlers.SAX_Content_Handler with private;

   function Get_Schema
    (Self : Document_Parser'Class)
       return Matreshka.XML_Schema.AST.Schema_Access;

private

   type State_Kinds is
    (Initial,
     Schema,
     Ignore,
     Include,
     Simple_Type);

   type State_Information (State : State_Kinds := Initial) is record
      case State is
         when Initial =>
            null;

         when Ignore =>
            Depth : Natural := 1;

         when Include =>
            null;

         when Schema =>
            null;

         when Simple_Type =>
            Simple_Type_Definition :
              Matreshka.XML_Schema.AST.Simple_Type_Access;
      end case;
   end record;

   package State_Vectors is
     new Ada.Containers.Vectors (Positive, State_Information);

   type Document_Parser
         (Model : not null Matreshka.XML_Schema.AST.Model_Access) is
     limited new XML.SAX.Content_Handlers.SAX_Content_Handler with
   record
      Locator   : XML.SAX.Locators.SAX_Locator;
      Diagnosis : League.Strings.Universal_String;
      Schema    : Matreshka.XML_Schema.AST.Schema_Access;
      Current   : State_Information;
      Stack     : State_Vectors.Vector;
   end record;

   overriding procedure Characters
    (Self    : in out Document_Parser;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) is null;

   overriding procedure End_Element
    (Self           : in out Document_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean);

   overriding procedure End_Prefix_Mapping
    (Self    : in out Document_Parser;
     Prefix  : League.Strings.Universal_String;
     Success : in out Boolean) is null;

   overriding function Error_String
    (Self : Document_Parser) return League.Strings.Universal_String;

   overriding procedure Ignorable_Whitespace
    (Self    : in out Document_Parser;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) renames Characters;

   overriding procedure Set_Document_Locator
    (Self    : in out Document_Parser;
     Locator : XML.SAX.Locators.SAX_Locator);

   overriding procedure Start_Element
    (Self           : in out Document_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean);

   overriding procedure Start_Prefix_Mapping
    (Self          : in out Document_Parser;
     Prefix        : League.Strings.Universal_String;
     Namespace_URI : League.Strings.Universal_String;
     Success       : in out Boolean) is null;

end Matreshka.XML_Schema.Document_Parsers;
