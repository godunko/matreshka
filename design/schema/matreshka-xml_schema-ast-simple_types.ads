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

with Matreshka.XML_Schema.AST.Types;

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

      Final : Matreshka.XML_Schema.AST.Derivation_Set;
      --  {final}
      --  A subset of {extension, restriction, list, union}.

      Context : Types.Abstract_Node_Access;
      --  {context}
      --  Required if {name} is ·absent·, otherwise must be ·absent·.
      --
      --  Either an Attribute Declaration, an Element Declaration, a Complex
      --  Type Definition, or a Simple Type Definition.


      Base_Type_Definition : Types.Type_Definition_Access;
      --  {base type definition}
      --  A Type Definition component. Required.
      --
      --  With one exception, the {base type definition} of any Simple Type
      --  Definition is a Simple Type Definition. The exception is
      --  ·xs:anySimpleType·, which has ·xs:anyType·, a Complex Type
      --  Definition, as its {base type definition}.
      --

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

      Simple_Type_Definition : Types.Simple_Type_Definition_Access;
      --  {primitive type definition}
      --  A Simple Type Definition component. With one exception, required if
      --  {variety} is atomic, otherwise must be ·absent·. The exception is
      --  ·xs:anyAtomicType·, whose {primitive type definition} is ·absent·.
      --
      --  If non-·absent·, must be a primitive definition.
      --

      Item_Type_Definition : Types.Simple_Type_Definition_Access;
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

      Member_Type_Definitions : Types.Simple_Type_Definition_Lists.List;
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

      Restriction_Base : League.Strings.Universal_String;
      --  restriction/@base
      Member_Types     : League.Strings.Universal_String;
      --  union/@memberTypes
      Item_Type     : League.Strings.Universal_String;
      --  list/@itemType
   end record;

   type Simple_Type_Definition_Access is
     access all Simple_Type_Definition_Node'Class;

end Matreshka.XML_Schema.AST.Simple_Types;
