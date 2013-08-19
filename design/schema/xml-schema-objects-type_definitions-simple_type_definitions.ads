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

with League.String_Vectors;

with XML.Schema.Annotations;
with XML.Schema.Object_Lists;

package XML.Schema.Objects.Type_Definitions.Simple_Type_Definitions is

   pragma Preelaborate;

   type Variety is
     (Variety_Absent,
      --  The variety is absent for the anySimpleType definition.
      Variety_Atomic,  --  Atomic type.
      Variety_List,    --  List type.
      Variety_Union);  --  Union type.

   --  The names of constraining facets
   type Facet_Kind is
     (Facet_Length,
      Facet_Min_Length,
      Facet_Max_Length,
      Facet_Pattern,
      Facet_Whitespace,
      Facet_Max_Inclusive,
      Facet_Max_Exclusive,
      Facet_Min_Inclusive,
      Facet_Min_Exclusive,
      Facet_Total_Digits,
      Facet_Fraction_Digits,
      Facet_Enumeration);

   type Ordered_Kind is
     (False,    --  not ordered
      Partial,  --  partially ordered
      Total);   --  total ordered
   --  A constants defined for the 'ordered' fundamental facet.

   type Facets is array (Facet_Kind) of Boolean with Pack;

   type XS_Simple_Type_Definition is new XS_Type_Definition with private;

   function Get_Variety
    (Self : XS_Simple_Type_Definition'Class) return Variety;
   --  [variety]: one of {atomic, list, union} or absent.

   function Get_Primitive_Type
    (Self : XS_Simple_Type_Definition'Class)
       return XS_Simple_Type_Definition'Class;
   --  If variety is atomic the primitive type definition (a built-in primitive
   --  datatype definition or the simple ur-type definition) is available,
   --  otherwise null.

   function Built_In_Kind
    (Self : XS_Simple_Type_Definition'Class) return Built_In_Type;
   --  Returns the closest built-in type category this type represents or
   --  derived from. For example, if this simple type is a built-in derived
   --  type integer the INTEGER_DT is returned.

   function Get_Item_Type
    (Self : XS_Simple_Type_Definition'Class)
       return XS_Simple_Type_Definition'Class;
   --  If variety is list the item type definition (an atomic or union simple
   --  type definition) is available, otherwise null

   function Member_Types
    (Self : XS_Simple_Type_Definition'Class)
       return XML.Schema.Object_Lists.XS_Object_List;
   --  If variety is union the list of member type definitions (a non-empty
   --  sequence of simple type definitions) is available, otherwise an empty
   --  XSObjectList.

   function Get_Defined_Facets
    (Self : XS_Simple_Type_Definition'Class) return Facets;
   --  [facets]: all facets defined on this type. The value is a bit
   --  combination of Facet_Kind constants of all defined facets.

   function Is_Defined_Facet
     (Self  : XS_Simple_Type_Definition'Class;
      Facet : Facet_Kind) return Boolean;
   --  Convenience method. [Facets]: check whether a facet is defined on
   --  this type.
   --
   --   Parameters
   --
   --  Facet of type Facet_Kind
   --      The name of the facet.
   --
   --  Return Value
   --
   --      boolean -  True if the facet is defined, false otherwise.

   function Get_Fixed_Facets
    (Self : XS_Simple_Type_Definition'Class) return Facets;
   --  [facets]: all defined facets for this type which are fixed.

   function Is_Fixed_Facet
     (Self  : XS_Simple_Type_Definition'Class;
      Facet : Facet_Kind) return Boolean;
   --  Convenience method. [Facets]: check whether a facet is defined and fixed
   --  on this type.
   --
   --   Parameters
   --
   --  Facet of type Facet_Kind
   --      The name of the facet.
   --
   --  Return Value
   --
   --      boolean -  True if the facet is fixed, false otherwise.

   function Get_Lexical_Facet_Value
     (Self  : XS_Simple_Type_Definition'Class;
      Facet : Facet_Kind) return League.Strings.Universal_String;
   --  Convenience method. Returns a value of a single constraining facet for
   --  this simple type definition. This method must not be used to retrieve
   --  values for enumeration and pattern facets.

   function Get_Lexical_Enumeration
    (Self : XS_Simple_Type_Definition'Class)
      return League.String_Vectors.Universal_String_Vector;
   --  A list of enumeration values if it exists, otherwise an empty StringList

   function Get_Lexical_Pattern
    (Self : XS_Simple_Type_Definition'Class)
      return League.String_Vectors.Universal_String_Vector;
   --  A list of pattern values if it exists, otherwise an empty StringList.

   function Get_Ordered
    (Self : XS_Simple_Type_Definition'Class) return Ordered_Kind;
   --  Fundamental Facet: ordered.

   function Get_Finite
    (Self : XS_Simple_Type_Definition'Class) return Boolean;
   --  Fundamental Facet: cardinality.

   function Get_Bounded
    (Self : XS_Simple_Type_Definition'Class) return Boolean;
   --  Fundamental Facet: bounded.

   function Get_Numeric
    (Self : XS_Simple_Type_Definition'Class) return Boolean;
   --  Fundamental Facet: numeric.

   function Get_Facets
    (Self : XS_Simple_Type_Definition'Class)
       return XML.Schema.Object_Lists.XS_Object_List;
   --  A list of constraining facets if it exists, otherwise an empty
   --  XSObjectList. Note: This method must not be used to retrieve values for
   --  enumeration and pattern facets.

   function Get_Multi_Value_Facets
    (Self : XS_Simple_Type_Definition'Class)
       return XML.Schema.Object_Lists.XS_Object_List;
   --  A list of enumeration and pattern constraining facets if it exists,
   --  otherwise an empty XSObjectList.

   function Get_Annotation
    (Self : XS_Simple_Type_Definition'Class)
       return XML.Schema.Annotations.XS_Annotation;
   --  An annotation if it exists, otherwise null.

   Null_XS_Simple_Type_Definition : constant XS_Simple_Type_Definition;

private

   type XS_Simple_Type_Definition is
     new XS_Type_Definition with null record;

   Null_XS_Simple_Type_Definition : constant XS_Simple_Type_Definition
     := (Ada.Finalization.Controlled with Node => null);

end XML.Schema.Objects.Type_Definitions.Simple_Type_Definitions;
