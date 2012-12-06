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
--  This interface represents an XML Schema.
------------------------------------------------------------------------------
private with Ada.Finalization;

with League.String_Vectors;
with League.Strings;

private with Matreshka.XML_Schema.AST;
with XML.Schema.Attribute_Declarations;
with XML.Schema.Attribute_Group_Definitions;
with XML.Schema.Element_Declarations;
with XML.Schema.Model_Group_Definitions;
with XML.Schema.Named_Maps;
with XML.Schema.Namespace_Item_Lists;
with XML.Schema.Notation_Declarations;
with XML.Schema.Object_Lists;
with XML.Schema.Type_Definitions;

package XML.Schema.Models is

   pragma Preelaborate;

   type XS_Model is tagged private;

   Null_Model : constant XS_Model;

   function Is_Null (Self : XS_Model) return Boolean;

   function Get_Namespaces
    (Self : XS_Model'Class)
       return League.String_Vectors.Universal_String_Vector;
   --  Convenience method. Returns a list of all namespaces that belong to this
   --  schema. The value null is not a valid namespace name, but if there are
   --  components that do not have a target namespace, null is included in this
   --  list.

   function Get_Namespace_Items
    (Self : XS_Model'Class)
       return XML.Schema.Namespace_Item_Lists.XS_Namespace_Item_List;
   --  A set of namespace schema information information items (of type
   --  XSNamespaceItem), one for each namespace name which appears as the
   --  target namespace of any schema component in the schema used for that
   --  assessment, and one for absent if any schema component in the schema had
   --  no target namespace. For more information see schema information.

   function Get_Components
    (Self        : XS_Model'Class;
     Object_Type : Extended_XML_Schema_Component_Type)
       return XML.Schema.Named_Maps.XS_Named_Map;
   --  Returns a list of top-level components, i.e. element declarations,
   --  attribute declarations, etc.
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
   --    A list of top-level definitions of the specified type in objectType or
   --    an empty XSNamedMap if no such definitions exist.

   function Get_Components_By_Namespace
    (Self        : XS_Model'Class;
     Object_Type : Extended_XML_Schema_Component_Type;
     Namespace   : League.Strings.Universal_String)
       return XML.Schema.Named_Maps.XS_Named_Map;
   --  Convenience method. Returns a list of top-level component declarations
   --  that are defined within the specified namespace, i.e. element
   --  declarations, attribute declarations, etc.
   --
   --  Parameters
   --
   --    objectType of type unsigned short
   --      The type of the declaration, i.e. ELEMENT_DECLARATION.
   --
   --    namespace of type GenericString
   --      The namespace to which the declaration belongs or null (for
   --      components with no target namespace).
   --
   --  Return Value
   --
   --    A list of top-level definitions of the specified type in objectType
   --    and defined in the specified namespace or an empty XSNamedMap.

   function Get_Annotations
    (Self : XS_Model'Class) return XML.Schema.Object_Lists.XS_Object_List;
   --  [annotations]: a set of annotations if it exists, otherwise an empty
   --  XSObjectList.

   function Get_Element_Declaration
    (Self      : XS_Model'Class;
     Name      : League.Strings.Universal_String;
     Namespace : League.Strings.Universal_String)
       return XML.Schema.Element_Declarations.XS_Element_Declaration;
   --  Convenience method. Returns a top-level element declaration.
   --
   --  Parameters
   --
   --    name of type GenericString
   --      The name of the declaration.
   --
   --    namespace of type GenericString
   --      The namespace of the declaration, otherwise null.
   --
   --  Return Value
   --
   --    A top-level element declaration or null if such a declaration does not
   --    exist. 

   function Get_Attribute_Declaration
    (Self      : XS_Model'Class;
     Name      : League.Strings.Universal_String;
     Namespace : League.Strings.Universal_String)
       return XML.Schema.Attribute_Declarations.XS_Attribute_Declaration;
   --  Convenience method. Returns a top-level attribute declaration.
   --
   --  Parameters
   --
   --    name of type GenericString
   --      The name of the declaration.
   --
   --    namespace of type GenericString
   --      The namespace of the declaration, otherwise null.
   --
   --  Return Value
   --
   --    A top-level attribute declaration or null if such a declaration does
   --    not exist.

   function Get_Type_Definition
    (Self      : XS_Model'Class;
     Name      : League.Strings.Universal_String;
     Namespace : League.Strings.Universal_String)
       return XML.Schema.Type_Definitions.XS_Type_Definition;
   --  Convenience method. Returns a top-level simple or complex type
   --  definition.
   --
   --  Parameters
   --
   --    name of type GenericString
   --      The name of the definition.
   --
   --    namespace of type GenericString
   --      The namespace of the declaration, otherwise null.
   --
   --  Return Value
   --
   --    An XSTypeDefinition or null if such a definition does not exist. 

   function Get_Attribute_Group
    (Self      : XS_Model'Class;
     Name      : League.Strings.Universal_String;
     Namespace : League.Strings.Universal_String)
       return
         XML.Schema.Attribute_Group_Definitions.XS_Attribute_Group_Definition;
   --  Convenience method. Returns a top-level attribute group definition.
   --
   --  Parameters
   --
   --    name of type GenericString
   --      The name of the definition.
   --
   --    namespace of type GenericString
   --      The namespace of the definition, otherwise null.
   --
   --  Return Value
   --
   --    A top-level attribute group definition or null if such a definition
   --    does not exist.

   function Get_Model_Group_Definition
    (Self      : XS_Model'Class;
     Name      : League.Strings.Universal_String;
     Namespace : League.Strings.Universal_String)
       return XML.Schema.Model_Group_Definitions.XS_Model_Group_Definition;
   --  Convenience method. Returns a top-level model group definition.
   --
   --  Parameters
   --
   --    name of type GenericString
   --      The name of the definition.
   --
   --    namespace of type GenericString
   --      The namespace of the definition, otherwise null.
   --
   --  Return Value
   --
   --    A top-level model group definition or null if such a definition does
   --    not exist.

   function Get_Notation_Declaration
    (Self      : XS_Model'Class;
     Name      : League.Strings.Universal_String;
     Namespace : League.Strings.Universal_String)
       return XML.Schema.Notation_Declarations.XS_Notation_Declaration;
   --  Convenience method. Returns a top-level notation declaration.
   --
   --  Parameters
   --
   --    name of type GenericString
   --      The name of the declaration.
   --
   --    namespace of type GenericString
   --      The namespace of the declaration, otherwise null.
   --
   --  Return Value
   --
   --    A top-level notation declaration or null if such a declaration does
   --    not exist. 

private

   type XS_Model is new Ada.Finalization.Controlled with record
      Node : Matreshka.XML_Schema.AST.Model_Access;
   end record;

   Null_Model : constant XS_Model
     := (Ada.Finalization.Controlled with Node => null);

end XML.Schema.Models;
