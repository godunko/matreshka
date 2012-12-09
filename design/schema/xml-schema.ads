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

package XML.Schema is

   pragma Pure;

   type Extended_XML_Schema_Component_Type is
    (None,
     Attribute_Declaration,
     Element_Declaration,
     Type_Definition,
     Attribute_Use,
     Attribute_Group,
     Model_Group_Definition,
     Model_Group,
     Particle,
     Wildcard,
     Identity_Constraint,
     Notation_Declaration,
     Annotation,
     Facet,
     Multivalue_Facet,
     Complex_Type,
     Simple_Type);

   subtype Component_Type is Extended_XML_Schema_Component_Type
     range None .. Multivalue_Facet;
   --  This type is not part of official specification and introduced to follow
   --  Ada best practice. None is a special value to be used when where is no
   --  component present.

   -----------
   -- Scope --
   -----------

   type Scope is
    (Scope_Absent,
     --  The scope of a declaration within named model groups or attribute
     --  groups is absent. The scope of such a declaration is determined when
     --  it is used in the construction of complex type definitions.

     Scope_Global,
     --  A scope of global identifies top-level declarations.

     Scope_Local);
     --  Locally scoped declarations are available for use only within the
     --  complex type.

   ----------------------
   -- Value Constraint --
   ----------------------

   type Value_Constraint is
    (VC_None,
     --  Indicates that the component does not have any value constraint.

     VC_Default,
     --  Indicates that there is a default value constraint.

     VC_Fixed);
     --  Indicates that there is a fixed value constraint for this attribute.

   ------------------------
   -- Derivation Control --
   ------------------------

   type Type_Derivation_Control is
     (Derivation_Extension,
      Derivation_Restriction,
      Derivation_Substitution,
      Derivation_Union,
      Derivation_List);

   type Derivation_Set is array (Type_Derivation_Control) of Boolean;
   pragma Pack (Derivation_Set);

   Derivation_None : constant Derivation_Set := (others => False);

   -------------------------------------------
   -- Built-in types: primitive and derived --
   -------------------------------------------

   type Built_In_Type is
    (Any_Simple_Type_DT,       --  anySimpleType
     String_DT,                --  string
     Boolean_DT,               --  boolean
     Decimal_DT,               --  decimal
     Float_DT,                 --  float
     Double_DT,                --  double
     Duration_DT,              --  duration
     Date_Time_DT,             --  dateTime
     Time_DT,                  --  time
     Date_DT,                  --  date
     G_Year_Month_DT,          --  gYearMonth
     G_Year_DT,                --  gYear
     G_Month_Day_DT,           --  gMonthDay
     G_Day_DT,                 --  gDay
     G_Month_DT,               --  gMonth
     Hex_Binary_DT,            --  hexBinary
     Base64_Binary_DT,         --  base64Binary
     Any_URI_DT,               --  anyURI
     Q_Name_DT,                --  QName
     Notation_DT,              --  NOTATION
     Normalized_String_DT,     --  normalizedString
     Token_DT,                 --  token
     Language_DT,              --  language
     NMToken_DT,               --  NMTOKEN
     Name_DT,                  --  Name
     NC_Name_DT,               --  NCName
     Id_DT,                    --  ID
     Id_Ref_DT,                --  IDREF
     Entity_DT,                --  ENTITY
     Integer_DT,               --  integer
     Non_Positive_Integer_DT,  --  nonPositiveInteger
     Negative_Integer_DT,      --  negativeInteger
     Long_DT,                  --  long
     Int_DT,                   --  int
     Short_DT,                 --  short
     Byte_DT,                  --  byte
     Non_Negative_Integer_DT,  --  nonNegativeInteger
     Unsigned_Long_DT,         --  unsignedLong
     Unsigned_Int_DT,          --  unsignedInt
     Unsigned_Short_DT,        --  unsignedShort
     Unsigned_Byte_DT,         --  unsignedByte
     Positive_Integer_DT,      --  positiveInteger
     List_Of_Union_DT,         --  The type represents a list type definition
                               --  whose item type (itemType) is a union type
                               --  definition
     List_DT,                  --  The type represents a list type definition.
     Unavailable_DT);          --  The built-in type category is not available.

end XML.Schema;
