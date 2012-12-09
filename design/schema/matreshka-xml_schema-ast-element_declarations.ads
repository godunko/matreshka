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
with XML.Schema;

package Matreshka.XML_Schema.AST.Element_Declarations is

   pragma Preelaborate;

   type Type_Table (Is_Null : Boolean := True) is record
      case Is_Null is
         when False =>
            Alternatives : Types.Type_Alternative_Lists.List;
            --  {alternatives}
            --  A sequence of Type Alternative components.

            Default_Type_Definition :
              Matreshka.XML_Schema.AST.Type_Alternative_Access;
            --  {default type definition}
            --  A Type Alternative component. Required.
         when True =>
            null;
      end case;
   end record;

   type Element_Declaration_Node is
     new Matreshka.XML_Schema.AST.Types.Term_Node with record
      --  Properties:
      --

      Annotations : Types.Annotation_Lists.List;
      --  {annotations}
      --  A sequence of Annotation components.

      Name  : League.Strings.Universal_String;
      --  {name}
      --  An xs:NCName value. Required.

      Target_Namespace  : League.Strings.Universal_String;
      --  {target namespace}
      --  An xs:anyURI value. Optional.

      Type_Definition : Types.Type_Definition_Access;
      --  {type definition}
      --  A Type Definition component. Required.

      Type_Table : Element_Declarations.Type_Table;
      --  {type table}
      --  A Type Table property record. Optional.

      Scope : Types.Scope;
      --  {scope}
      --  A Scope property record. Required.

      Value_Constraint : Types.Value_Constraint;
      --  {value constraint}
      --  A Value Constraint property record. Optional.

      Nillable : Boolean;
      --  {nillable}
      --  An xs:boolean value. Required.

      Identity_Constraint_Definitions :
        Types.Identity_Constraint_Definition_Sets.List;
      --  {identity-constraint definitions}
      --  A set of Identity-Constraint Definition components.

      Substitution_Group_Affiliations : Types.Element_Declaration_Maps.Map;
      --  {substitution group affiliations}
      --  A set of Element Declaration components.

      Substitution_Group_Exclusions : XML.Schema.Derivation_Set;
      --  {substitution group exclusions}
      --  A subset of {extension, restriction}.

      Disallowed_Substitutions : XML.Schema.Derivation_Set;
      --  {disallowed substitutions}
      --  A subset of {substitution, extension, restriction}.

      Is_Abstract : Boolean;
      --  {abstract}
      --  An xs:boolean value. Required.

      --  Internal data.

      Type_Name : League.Strings.Universal_String;
      --  @type

   end record;

   overriding function Get_Type
    (Self : not null access Element_Declaration_Node)
       return XML.Schema.Component_Type;

   overriding procedure Enter_Node
    (Self    : not null access Element_Declaration_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Leave_Node
    (Self    : not null access Element_Declaration_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Visit_Node
    (Self     : not null access Element_Declaration_Node;
     Iterator : in out Matreshka.XML_Schema.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control  : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

end Matreshka.XML_Schema.AST.Element_Declarations;
