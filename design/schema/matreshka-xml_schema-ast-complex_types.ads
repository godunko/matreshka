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

package Matreshka.XML_Schema.AST.Complex_Types is

   pragma Preelaborate;

   type Open_Content_Mode is (Interleave, Suffix);

   type Open_Content is record
      Mode : Open_Content_Mode;
      --  {mode}
      --  One of {interleave, suffix}. Required.

      Wildcard : Types.Wildcard_Access;
      --  {wildcard}
      --  A Wildcard component. Required.
   end record;

   type Content_Type_Variety is (Empty, Simple, Element_Only, Mixed);

   type Content_Type (Variety : Content_Type_Variety := Empty) is record
      --  {variety}
      --  One of {empty, simple, element-only, mixed}. Required.

      case Variety is
         when Element_Only | Mixed =>
            Particle : Types.Particle_Access;
            --  {particle}
            --  A Particle component. Required if {variety} is element-only or
            --  mixed, otherwise must be ·absent·.

            Open_Content : Complex_Types.Open_Content;
            --  {open content}
            --  An Open Content property record. Optional if {variety} is
            --  element-only or mixed, otherwise must be ·absent·.

         when Simple =>
            Simple_Type_Definition : Types.Simple_Type_Definition_Access;
            --  {simple type definition}
            --  A Simple Type Definition component. Required if {variety} is
            --  simple, otherwise must be ·absent·.
         when Empty =>
            null;
      end case;
   end record;

   type Complex_Type_Definition_Node is
     new Matreshka.XML_Schema.AST.Types.Type_Definition_Node with record
      --  Properties:
      --

      Annotations : Types.Annotation_Lists.List;
      --  {annotations}
      --  A sequence of Annotation components.
      --  {name}

      Name  : League.Strings.Universal_String;
      --  An xs:NCName value. Optional.

      Target_Namespace  : League.Strings.Universal_String;
      --  {target namespace}
      --  An xs:anyURI value. Optional.

      Base_Type_Definition : Types.Type_Definition_Access;
      --  {base type definition}
      --  A type definition component. Required.

      Final : Derivation_Set;
      --  {final}
      --  A subset of {extension, restriction}.

      Context : Types.Abstract_Node_Access;
      --  {context}
      --  Required if {name} is ·absent·, otherwise must be ·absent·.
      --  Either an Element Declaration or a Complex Type Definition.

      Derivation_Method : Type_Derivation_Control;
      --  {derivation method}
      --  One of {extension, restriction}. Required.

      Is_Abstract : Boolean;
      --  {abstract}
      --  An xs:boolean value. Required.

      Attribute_Uses : Types.Attribute_Use_Sets.List;
      --  {attribute uses}
      --  A set of Attribute Use components.

      Attribute_Wildcard : Types.Wildcard_Access;
      --  {attribute wildcard}
      --  A Wildcard component. Optional.

      Content_Type : Complex_Types.Content_Type;
      --  {content type}
      --  A Content Type property record. Required.

      Prohibited_Substitutions : Derivation_Set;
      --  {prohibited substitutions}
      --  A subset of {extension, restriction}.

      Assertions : Types.Assertion_Lists.List;
      --  {assertions}
      --  A sequence of Assertion components.

      --  Internal data.

      Restriction_Base : League.Strings.Universal_String;
      --  restriction/@base
      Extension_Base : League.Strings.Universal_String;
      --  extension/@base
      Attribute_Group_References : Types.Attribute_Group_Reference_Lists.List;
      --  list of attributeGroup
      Any_Type_Restriction : Boolean := False;
      --  Marker for implicit restriction of xs:anyType
   end record;

end Matreshka.XML_Schema.AST.Complex_Types;
