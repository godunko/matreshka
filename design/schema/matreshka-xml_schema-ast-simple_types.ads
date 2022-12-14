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
with League.Strings;
with League.String_Vectors;

with Matreshka.XML_Schema.AST.Types;
with Matreshka.XML_Schema.Object_Lists;

with XML.Schema;

package Matreshka.XML_Schema.AST.Simple_Types is

   pragma Preelaborate;

   type Simple_Type_Definition_Node is
     new Matreshka.XML_Schema.AST.Types.Type_Definition_Node with record
      --  Properties:
      --

      Annotations : Types.Annotation_Lists.List;
      --  {annotations}
      --  A sequence of Annotation components.

      Name  : League.Strings.Universal_String;
      --  {name}
      --  An xs:NCName value. Optional.

      Target_Namespace  : League.Strings.Universal_String;
      --  {target namespace}
      --  An xs:anyURI value. Optional.

      Context : Matreshka.XML_Schema.AST.Node_Access;
      --  {context}
      --  Required if {name} is ·absent·, otherwise must be ·absent·.
      --
      --  Either an Attribute Declaration, an Element Declaration, a Complex
      --  Type Definition, or a Simple Type Definition.

      Facets : Types.Facet_Sets.List;

      --  {facets}
      --  A set of Constraining Facet components.
      --
      --  {fundamental facets}
      --  A set of Fundamental Facet components.
      --

      Variety : Simple_Type_Variety;
      --  {variety}
      --  One of {atomic, list, union}. Required for all Simple Type
      --  Definitions except ·xs:anySimpleType·, in which it is ·absent·.
      --

      Simple_Type_Definition :
        Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;
      --  {primitive type definition}
      --  A Simple Type Definition component. With one exception, required if
      --  {variety} is atomic, otherwise must be ·absent·. The exception is
      --  ·xs:anyAtomicType·, whose {primitive type definition} is ·absent·.
      --
      --  If non-·absent·, must be a primitive definition.
      --

      Item_Type_Definition :
        Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;
      --  {item type definition}
      --  A Simple Type Definition component. Required if {variety} is list,
      --  otherwise must be ·absent·.
      --
      --  The value of this property must be a primitive or ordinary simple
      --  type definition with {variety} = atomic, or an ordinary simple type
      --  definition with {variety} = union whose basic members are all atomic;
      --  the value must not itself be a list type (have {variety} = list) or
      --  have any basic members which are list types.
      --

      Member_Type_Definitions : Object_Lists.Object_List_Access;
      --  {member type definitions}
      --  A sequence of primitive or ordinary Simple Type Definition
      --  components.
      --
      --  Must be present (but may be empty) if {variety} is union, otherwise
      --  must be ·absent·.
      --
      --  The sequence may contain any primitive or ordinary simple type
      --  definition, but must not contain any special type definitions.

      --  Internal data.

      Restriction_Base : Matreshka.XML_Schema.AST.Qualified_Name;
      --  restriction/@base
      Member_Types     : Matreshka.XML_Schema.AST.Qualified_Name_Vector;
      --  union/@memberTypes
      Item_Type        : Matreshka.XML_Schema.AST.Qualified_Name;
      --  list/@itemType
      Lexical_Enumeration : League.String_Vectors.Universal_String_Vector;
      --  List of enumeration literals
   end record;

   overriding function Get_Type_Category
    (Self : Simple_Type_Definition_Node) return XML.Schema.Type_Category;

   overriding procedure Enter_Node
    (Self    : not null access Simple_Type_Definition_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding function Get_Name
    (Self : not null access Simple_Type_Definition_Node)
      return League.Strings.Universal_String;

   overriding function Get_Target_Namespace
    (Self : not null access Simple_Type_Definition_Node)
     return League.Strings.Universal_String;

   overriding procedure Leave_Node
    (Self    : not null access Simple_Type_Definition_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Visit_Node
    (Self     : not null access Simple_Type_Definition_Node;
     Iterator : in out Matreshka.XML_Schema.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control  : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

end Matreshka.XML_Schema.AST.Simple_Types;
