------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Ada Modeling Framework                          --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2011-2012, Vadim Godunko <vgodunko@gmail.com>                --
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
with AMF.Internals.UML_Elements;
with AMF.UML.Multiplicity_Elements;
with AMF.UML.Value_Specifications;

generic
   type Element_Proxy is
     abstract new AMF.Internals.UML_Elements.UML_Element_Proxy with private;

package AMF.Internals.UML_Multiplicity_Elements is

   type UML_Multiplicity_Element_Proxy is
     abstract limited new Element_Proxy
       and AMF.UML.Multiplicity_Elements.UML_Multiplicity_Element
         with null record;

   overriding function Get_Is_Ordered
    (Self : not null access constant UML_Multiplicity_Element_Proxy)
       return Boolean;
   --  Getter of MultiplicityElement::isOrdered.
   --
   --  For a multivalued multiplicity, this attribute specifies whether the
   --  values in an instantiation of this element are sequentially ordered.

   overriding function Get_Is_Unique
    (Self : not null access constant UML_Multiplicity_Element_Proxy)
       return Boolean;
   --  Getter of MultiplicityElement::isUnique.
   --
   --  For a multivalued multiplicity, this attributes specifies whether the
   --  values in an instantiation of this element are unique.

   overriding function Get_Lower
    (Self : not null access constant UML_Multiplicity_Element_Proxy)
       return AMF.Optional_Integer;
   --  Getter of MultiplicityElement::lower.
   --
   --  Specifies the lower bound of the multiplicity interval.

   overriding function Get_Lower_Value
    (Self : not null access constant UML_Multiplicity_Element_Proxy)
       return AMF.UML.Value_Specifications.UML_Value_Specification_Access;
   --  Getter of MultiplicityElement::lowerValue.
   --
   --  The specification of the lower bound for this multiplicity.

   overriding function Get_Upper
    (Self : not null access constant UML_Multiplicity_Element_Proxy)
       return AMF.Optional_Unlimited_Natural;
   --  Getter of MultiplicityElement::upper.
   --
   --  Specifies the upper bound of the multiplicity interval.

   overriding function Get_Upper_Value
    (Self : not null access constant UML_Multiplicity_Element_Proxy)
       return AMF.UML.Value_Specifications.UML_Value_Specification_Access;
   --  Getter of MultiplicityElement::upperValue.
   --
   --  The specification of the upper bound for this multiplicity.

   overriding function Is_Multivalued
    (Self : not null access constant UML_Multiplicity_Element_Proxy)
       return Boolean;
   --  Operation MultiplicityElement::isMultivalued.
   --
   --  The query isMultivalued() checks whether this multiplicity has an upper 
   --  bound greater than one.

   overriding function Lower
    (Self : not null access constant UML_Multiplicity_Element_Proxy)
       return AMF.Optional_Integer renames Get_Lower;
   --  Operation MultiplicityElement::lower.
   --
   --  The derived lower attribute must equal the lowerBound.

   overriding function Lower_Bound
    (Self : not null access constant UML_Multiplicity_Element_Proxy)
       return AMF.Optional_Integer;
   --  Operation MultiplicityElement::lowerBound.
   --
   --  The query lowerBound() returns the lower bound of the multiplicity as 
   --  an integer.

   overriding procedure Set_Is_Ordered
    (Self : not null access UML_Multiplicity_Element_Proxy;
     To   : Boolean);
   --  Setter of MultiplicityElement::isOrdered.
   --
   --  For a multivalued multiplicity, this attribute specifies whether the 
   --  values in an instantiation of this element are sequentially ordered.

   overriding procedure Set_Is_Unique
    (Self : not null access UML_Multiplicity_Element_Proxy;
     To   : Boolean);
   --  Setter of MultiplicityElement::isUnique.
   --
   --  For a multivalued multiplicity, this attributes specifies whether the 
   --  values in an instantiation of this element are unique.

   overriding procedure Set_Lower
    (Self : not null access UML_Multiplicity_Element_Proxy;
     To   : AMF.Optional_Integer);
   --  Setter of MultiplicityElement::lower.
   --
   --  Specifies the lower bound of the multiplicity interval.

   overriding procedure Set_Lower_Value
    (Self : not null access UML_Multiplicity_Element_Proxy;
     To   : AMF.UML.Value_Specifications.UML_Value_Specification_Access);
   --  Setter of MultiplicityElement::lowerValue.
   --
   --  The specification of the lower bound for this multiplicity.

   overriding procedure Set_Upper
    (Self : not null access UML_Multiplicity_Element_Proxy;
     To   : AMF.Optional_Unlimited_Natural);
   --  Setter of MultiplicityElement::upper.
   --
   --  Specifies the upper bound of the multiplicity interval.

   overriding procedure Set_Upper_Value
    (Self : not null access UML_Multiplicity_Element_Proxy;
     To   : AMF.UML.Value_Specifications.UML_Value_Specification_Access);
   --  Setter of MultiplicityElement::upperValue.
   --
   --  The specification of the upper bound for this multiplicity.

   overriding function Upper
    (Self : not null access constant UML_Multiplicity_Element_Proxy)
       return AMF.Optional_Unlimited_Natural renames Get_Upper;
   --  Operation MultiplicityElement::upper.
   --
   --  The derived upper attribute must equal the upperBound.

   overriding function Upper_Bound
    (Self : not null access constant UML_Multiplicity_Element_Proxy)
       return AMF.Optional_Unlimited_Natural;
   --  Operation MultiplicityElement::upperBound.
   --
   --  The query upperBound() returns the upper bound of the multiplicity for 
   --  a bounded multiplicity as an unlimited natural.

end AMF.Internals.UML_Multiplicity_Elements;
