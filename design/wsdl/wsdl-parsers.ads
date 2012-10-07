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
private with Ada.Containers.Hashed_Maps;
private with Ada.Containers.Vectors;

private with League.Strings.Hash;
private with XML.SAX.Attributes;
with XML.SAX.Content_Handlers;

with WSDL.AST.Descriptions;
private with WSDL.AST.Interfaces;
private with WSDL.AST.Operations;

package WSDL.Parsers is

   type WSDL_Parser is
     limited new XML.SAX.Content_Handlers.SAX_Content_Handler with private;

   function Get_Description
    (Self : WSDL_Parser'Class) return WSDL.AST.Descriptions.Description_Access;

private

   package Namespace_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           League.Strings.Universal_String,
           League.Strings.Hash,
           League.Strings."=",
           League.Strings."=");

   type Description_Child_Kind is
    (None,
     Documentation,
     Include_Import,
     Types,
     Interface_Binding_Service);

   type Parser_State_Kind is
    (None,
     Document,
     WSDL_Binding,
     WSDL_Description,
     WSDL_Input,
     WSDL_Interface,
     WSDL_Interface_Operation,
     WSDL_Output,
     WSDL_Types);

   type Parser_State (Kind : Parser_State_Kind := None) is record
      case Kind is
         when WSDL_Description =>
            Last_Child_Kind : Description_Child_Kind := None;
            --  Kind of last processed child of 'description' element. This
            --  member is used to track order of children elements of
            --  'description' element.

         when others =>
            null;
      end case;
   end record;

   package State_Vectors is
     new Ada.Containers.Vectors (Positive, Parser_State);

   type WSDL_Parser is
     limited new XML.SAX.Content_Handlers.SAX_Content_Handler with
   record
      Description       : WSDL.AST.Descriptions.Description_Access;
      --  Root element of AST for the processed file.

      Current_State     : Parser_State;
      --  Current state of the parser.

      Previous_State    : Parser_State;
      --  Previous state of the parser.

      State_Stack       : State_Vectors.Vector;
      --  Stack of parser's state.

      Ignore_Depth      : Natural := 0;
      --  Counter of the depth of ignored elements.

      Namespaces        : Namespace_Maps.Map;
      --  Mapping from prefix to namespace URI.

      Current_Interface : WSDL.AST.Interfaces.Interface_Access;
      --  Currently processed interface component.

      Current_Operation : WSDL.AST.Operations.Interface_Operation_Access;
      --  Currently processed operation component.
   end record;

   overriding function Error_String
    (Self : WSDL_Parser) return League.Strings.Universal_String;

   overriding procedure Start_Document
    (Self    : in out WSDL_Parser;
     Success : in out Boolean);

   overriding procedure Start_Prefix_Mapping
    (Self          : in out WSDL_Parser;
     Prefix        : League.Strings.Universal_String;
     Namespace_URI : League.Strings.Universal_String;
     Success       : in out Boolean);

   overriding procedure Start_Element
    (Self           : in out WSDL_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean);

   overriding procedure End_Element
    (Self           : in out WSDL_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean);

end WSDL.Parsers;
