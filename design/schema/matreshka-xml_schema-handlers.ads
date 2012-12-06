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
--  This package provides SAX event handler to construct XML Schema
--  representation. It is intended to be used in pair with validating XML
--  reader that can validate schema documents. This allows to simplify code
--  of handler by excluding handling of errors and substitution of default
--  values. This handler can be used as 'subhandler' to process larger XML
--  documents which include XML Schema part, for example WSDL documents.
------------------------------------------------------------------------------
private with Ada.Containers.Vectors;

with League.Strings;
private with Matreshka.XML_Schema.AST.Schemas;
private with Matreshka.XML_Schema.AST.Simple_Types;
with Matreshka.XML_Schema.AST.Types;
with Matreshka.XML_Schema.Loaders;
private with XML.SAX.Attributes;
private with XML.SAX.Locators;
with XML.SAX.Content_Handlers;

package Matreshka.XML_Schema.Handlers is

   type XML_Schema_Handler
         (Loader : not null access
            Matreshka.XML_Schema.Loaders.Model_Loader'Class) is
     limited new XML.SAX.Content_Handlers.SAX_Content_Handler with private;

   function Get_Schema
    (Self : XML_Schema_Handler)
       return Matreshka.XML_Schema.AST.Types.Schema_Access;
   --  Returns constructed schema.

private

   type States is
    (Any,
     Any_Attribute,
     Attribute_Declaration,
     Attribute_Group_Declaration,
     Attribute_Group_Reference,
     Choice,
     Complex_Content,
     Complex_Type,
     Complex_Type_Extension,
     Complex_Type_Restriction,
     Document,
     Element_Declaration,
     Enumeration,
     Field,
     Group,
     Import,
     Key,
     Min_Length,
     Model_Group_Definition,
     Notation,
     Schema,
     Selector,
     Sequence,
     Sequence_Element,
     Simple_Type,
     Simple_Type_List,
     Simple_Type_Restriction,
     Union);

   type State_Value is record
      State                       : States;
      Last_Simple_Type_Definition :
        Matreshka.XML_Schema.AST.Simple_Types.Simple_Type_Definition_Access;
      Last_Attribute_Declaration  :
        Matreshka.XML_Schema.AST.Types.Attribute_Declaration_Access;
      Last_Attribute_Group_Definition :
        Matreshka.XML_Schema.AST.Types.Attribute_Group_Definition_Access;
      Last_Complex_Type_Definition :
        Matreshka.XML_Schema.AST.Types.Complex_Type_Definition_Access;
      Last_Element_Declaration  :
        Matreshka.XML_Schema.AST.Types.Element_Declaration_Access;
      Last_Model : Matreshka.XML_Schema.AST.Types.Model_Group_Access;
      Last_Model_Definition :
        Matreshka.XML_Schema.AST.Types.Model_Group_Definition_Access;
      Last_Constraint :
        Matreshka.XML_Schema.AST.Types.Identity_Constraint_Definition_Access;
   end record;

   package State_Vectors is
     new Ada.Containers.Vectors (Positive, State_Value);

   type XML_Schema_Handler
         (Loader : not null access
            Matreshka.XML_Schema.Loaders.Model_Loader'Class) is
     limited new XML.SAX.Content_Handlers.SAX_Content_Handler with record
      Locator      : XML.SAX.Locators.SAX_Locator;
      Schema       : Matreshka.XML_Schema.AST.Types.Schema_Access;
      Ignore_Depth : Natural := 0;
      States       : State_Vectors.Vector;  --  Stack of states except top

      Top_State    : State_Value;  --  Separate top item of stack
   end record;

   procedure Push (Self : in out XML_Schema_Handler'Class; State : States);
   --  Push the given state into the state stack.

   procedure Pop (Self : in out XML_Schema_Handler'Class);
   --  Pop state from the state stack.

   function Current (Self : XML_Schema_Handler'Class) return States;
   --  Returns current state.

   overriding procedure End_Element
    (Self           : in out XML_Schema_Handler;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean);

   overriding function Error_String
    (Self : XML_Schema_Handler) return League.Strings.Universal_String;

   overriding procedure Start_Document
    (Self    : in out XML_Schema_Handler;
     Success : in out Boolean);

   overriding procedure Set_Document_Locator
    (Self    : in out XML_Schema_Handler;
     Locator : XML.SAX.Locators.SAX_Locator);

   overriding procedure Start_Element
    (Self           : in out XML_Schema_Handler;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean);

--   overriding procedure Start_Prefix_Mapping
--    (Self          : in out XML_Schema_Handler;
--     Prefix        : League.Strings.Universal_String;
--     Namespace_URI : League.Strings.Universal_String;
--     Success       : in out Boolean);

end Matreshka.XML_Schema.Handlers;
