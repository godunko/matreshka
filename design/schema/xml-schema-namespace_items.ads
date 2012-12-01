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
--  The interface represents the namespace schema information information item.
--  Each namespace schema information information item corresponds to an XML
--  Schema with a unique namespace name.
------------------------------------------------------------------------------
private with Ada.Finalization;

with League.String_Vectors;
with League.Strings;

with XML.Schema.Attribute_Declarations;
with XML.Schema.Attribute_Group_Definitions;
with XML.Schema.Element_Declarations;
with XML.Schema.Model_Group_Definitions;
with XML.Schema.Named_Maps;
with XML.Schema.Notation_Declarations;
with XML.Schema.Object_Lists;
with XML.Schema.Type_Definitions;

package XML.Schema.Namespace_Items is

   pragma Preelaborate;

   type XS_Namespace_Item is tagged private;

   function Get_Schema_Namespace
    (Self : XS_Namespace_Item'Class) return League.Strings.Universal_String;
   --  [schema namespace]: A namespace name or null if absent.

   function Get_Components
    (Self        : XS_Namespace_Item'Class;
     Object_Type : Extended_XML_Schema_Component_Type)
       return XML.Schema.Named_Maps.XS_Named_Map;
   --  [schema components]: a list of top-level components, i.e. element
   --  declarations, attribute declarations, etc.
   --
   --  Parameters
   --
   --    objectType of type unsigned short
   --      The type of the declaration, i.e. ELEMENT_DECLARATION. Note that
   --      XSTypeDefinition.SIMPLE_TYPE and XSTypeDefinition.COMPLEX_TYPE can
   --      also be used as the objectType to retrieve only complex types or
   --      simple types, instead of all types.
   --
   --  Return Value
   --
   --    A list of top-level definition of the specified type in objectType or
   --    an empty XSNamedMap if no such definitions exist.

   function Get_Annotations
    (Self : XS_Namespace_Item'Class)
       return XML.Schema.Object_Lists.XS_Object_List;
   --  [annotations]: a set of annotations if it exists, otherwise an empty
   --  XSObjectList.

   function Get_Element_Declaration
    (Self : XS_Namespace_Item'Class;
     Name : League.Strings.Universal_String)
       return XML.Schema.Element_Declarations.XS_Element_Declaration;
   --  Convenience method. Returns a top-level element declaration.
   --
   --  Parameters
   --
   --    name of type GenericString
   --      The name of the declaration.
   --
   --  Return Value
   --
   --    A top-level element declaration or null if such a declaration does not
   --    exist.

   function Get_Attribute_Declaration
    (Self : XS_Namespace_Item'Class;
     Name : League.Strings.Universal_String)
       return XML.Schema.Attribute_Declarations.XS_Attribute_Declaration;
   --  Convenience method. Returns a top-level attribute declaration.
   --
   --  Parameters
   --
   --    name of type GenericString
   --      The name of the declaration.
   --
   --  Return Value
   --
   --    A top-level attribute declaration or null if such a declaration does
   --    not exist.

   function Get_Type_Definition
    (Self : XS_Namespace_Item'Class;
     Name : League.Strings.Universal_String)
       return XML.Schema.Type_Definitions.XS_Type_Definition;
   --  Convenience method. Returns a top-level simple or complex type
   --  definition.
   --
   --  Parameters
   --
   --    name of type GenericString
   --      The name of the definition.
   --
   --  Return Value
   --
   --    An XSTypeDefinition or null if such a definition does not exist.

   function Get_Attribute_Group
    (Self : XS_Namespace_Item'Class;
     Name : League.Strings.Universal_String)
       return
         XML.Schema.Attribute_Group_Definitions.XS_Attribute_Group_Definition;
   --  Convenience method. Returns a top-level attribute group definition.
   --
   --  Parameters
   --
   --    name of type GenericString
   --      The name of the definition.
   --
   --  Return Value
   --
   --    A top-level attribute group definition or null if such a definition
   --    does not exist.

   function Get_Model_Group_Definition
    (Self : XS_Namespace_Item'Class;
     Name : League.Strings.Universal_String)
       return XML.Schema.Model_Group_Definitions.XS_Model_Group_Definition;
   --  Convenience method. Returns a top-level model group definition.
   --
   --  Parameters
   --
   --    name of type GenericString
   --      The name of the definition.
   --
   --  Return Value
   --
   --    A top-level model group definition definition or null if such a
   --    definition does not exist.

   function Get_Notation_Declaration
    (Self : XS_Namespace_Item'Class;
     Name : League.Strings.Universal_String)
       return XML.Schema.Notation_Declarations.XS_Notation_Declaration;
   --  Convenience method. Returns a top-level notation declaration.
   --
   --  Parameters
   --
   --    name of type GenericString
   --      The name of the declaration.
   --
   --  Return Value
   --
   --    A top-level notation declaration or null if such a declaration does
   --    not exist.

   function Document_Locations
    (Self : XS_Namespace_Item'Class)
       return League.String_Vectors.Universal_String_Vector;
   --  [document location] - a list of location URIs for the documents that
   --  contributed to the XSModel.

private

   type XS_Namespace_Item is new Ada.Finalization.Controlled with null record;

end XML.Schema.Namespace_Items;
