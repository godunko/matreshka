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
with League.Holders;

with XML.Schema.Annotations;
with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Named_Maps;
with XML.Schema.Type_Definitions;

package XML.Schema.Objects.Terms.Element_Declarations is

   pragma Preelaborate;

   type XS_Element_Declaration is new XS_Term with private;

   Null_XS_Element_Declaration : constant XS_Element_Declaration;

   function Get_Type_Definition
    (Self : XS_Element_Declaration'Class)
       return XML.Schema.Type_Definitions.XS_Type_Definition;
   --  [type definition]: either a simple type definition or a complex type
   --  definition.

   function Get_Scope
    (Self : XS_Element_Declaration'Class) return XML.Schema.Scope;
   --  [scope]. One of SCOPE_GLOBAL, SCOPE_LOCAL, or SCOPE_ABSENT. If the scope
   --  is local, then the enclosingCTDefinition is present.

   function Get_Enclosing_CT_Definition
    (Self : XS_Element_Declaration'Class)
       return XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
   --  The complex type definition for locally scoped declarations (see scope),
   --  otherwise null if no such definition exists.

   function Get_Constraint_Type
    (Self : XS_Element_Declaration'Class) return XML.Schema.Value_Constraint;
   --  [Value constraint]: one of VC_NONE, VC_DEFAULT, VC_FIXED.

   function Get_Constraint_Value
    (Self : XS_Element_Declaration'Class)
       return League.Strings.Universal_String;
   --  [Value constraint]: the constraint value with respect to the [ type
   --  definition], otherwise null.

   function Get_Actual_VC
    (Self : XS_Element_Declaration'Class) return League.Holders.Holder;
   --  Value Constraint: Binding specific actual constraint value or null if
   --  the value is in error or there is no value constraint.
   --
   --  Exceptions
   --
   --    XSException
   --      NOT_SUPPORTED_ERR: Raised if the implementation does not support
   --      this method.

   function Get_Actual_VC_Type
    (Self : XS_Element_Declaration'Class) return XML.Schema.Built_In_Type;
   --  The actual constraint value built-in datatype, e.g. STRING_DT, SHORT_DT.
   --  If the type definition of this value is a list type definition, this
   --  method returns LIST_DT. If the type definition of this value is a list
   --  type definition whose item type is a union type definition, this method
   --  returns LISTOFUNION_DT. To query the actual constraint value of the list
   --  or list of union type definitions use itemValueTypes. If the actualValue
   --  is null, this method returns UNAVAILABLE_DT.
   --
   --  Exceptions
   --
   --    XSException
   --
   --      NOT_SUPPORTED_ERR: Raised if the implementation does not support
   --      this method.

--   function Get_Item_Value_Types
--    (Self : XS_Element_Declaration'Class)
--       return XML.Schema.Built_In_Type_List;
   --  In the case the actual constraint value represents a list, i.e. the
   --  actualValueType is LIST_DT, the returned array consists of one type kind
   --  which represents the itemType. If the actual constraint value represents
   --  a list type definition whose item type is a union type definition, i.e.
   --  LISTOFUNION_DT, for each actual constraint value in the list the array
   --  contains the corresponding memberType kind. For examples, see
   --  ItemPSVI.itemValueTypes.
   --
   --  Exceptions
   --
   --    XSException
   --   
   --
   --      NOT_SUPPORTED_ERR: Raised if the implementation does not support
   --      this method.

   function Get_Nillable (Self : XS_Element_Declaration'Class) return Boolean;
   --  If nillable is true, then an element may also be valid if it carries the
   --  namespace qualified attribute with local name nil from namespace
   --  http://www.w3.org/2001/XMLSchema-instance and value true (xsi:nil) even
   --  if it has no text or element content despite a content type which would
   --  otherwise require content.

   function Get_Identity_Constraints
    (Self : XS_Element_Declaration'Class)
       return XML.Schema.Named_Maps.XS_Named_Map;
   --  identity-constraint definitions: a set of constraint definitions if it
   --  exists, otherwise an empty XSNamedMap.

   function Get_Substitution_Group_Affiliation
    (Self : XS_Element_Declaration'Class) return XS_Element_Declaration;
   --  [substitution group affiliation]: a top-level element definition if it
   --  exists, otherwise null.

--   function Is_Substitution_Group_Exclusion
--    (Self      : XS_Element_Declaration'Class;
--     Exclusion : unsigned short) return Boolean;
   --  Convenience method that checks if exclusion is a substitution group
   --  exclusion for this element declaration.
   --
   --  Parameters
   --
   --    exclusion of type unsigned short
   --
   --      DERIVATION_EXTENSION, DERIVATION_RESTRICTION or DERIVATION_NONE.
   --      Represents final set for the element.
   --
   --  Return Value
   --
   --    True if exclusion is a part of the substitution group exclusion
   --    subset.

   function Get_Substitution_Group_Exclusions
    (Self : XS_Element_Declaration'Class) return XML.Schema.Derivation_Set;
   --  [substitution group exclusions]: the returned value is a bit combination
   --  of the subset of {DERIVATION_EXTENSION, DERIVATION_RESTRICTION} or
   --  DERIVATION_NONE.

--   function Is_Disallowed_Substitution
--    (Self       : XS_Element_Declaration'Class;
--     Disallowed : unsigned short) return Boolean;
   --  Convenience method that checks if disallowed is a disallowed
   --  substitution for this element declaration.
   --
   --  Parameters
   --
   --    disallowed of type unsigned short
   --      {DERIVATION_SUBSTITUTION, DERIVATION_EXTENSION,
   --      DERIVATION_RESTRICTION} or DERIVATION_NONE. Represents a block set
   --      for the element.
   --
   --  Return Value
   --
   --    True if disallowed is a part of the substitution group exclusion
   --    subset. 

   function Get_Disallowed_Substitutions
    (Self : XS_Element_Declaration'Class) return XML.Schema.Derivation_Set;
   --  [disallowed substitutions]: the returned value is a bit combination of
   --  the subset of {DERIVATION_SUBSTITUTION, DERIVATION_EXTENSION,
   --  DERIVATION_RESTRICTION} corresponding to substitutions disallowed by
   --  this XSElementDeclaration or DERIVATION_NONE.

   function Get_Abstract (Self : XS_Element_Declaration'Class) return Boolean;
   --  {abstract} A boolean.

   function Get_Annotation
    (Self : XS_Element_Declaration'Class)
       return XML.Schema.Annotations.XS_Annotation;
   --  An annotation if it exists, otherwise null.

private

   type XS_Element_Declaration is new XS_Term with null record;

   Null_XS_Element_Declaration : constant XS_Element_Declaration
     := (Ada.Finalization.Controlled with Node => null);

end XML.Schema.Objects.Terms.Element_Declarations;
