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
-- Copyright © 2010-2012, Vadim Godunko <vgodunko@gmail.com>                --
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
--  This file is generated, don't edit it.
------------------------------------------------------------------------------
with AMF.CMOF;
with AMF.Elements;
with Matreshka.Internals.Strings;

package AMF.Internals.Tables.CMOF_Types is

   pragma Preelaborate;

   type Element_Kinds is
    (E_None,
     E_CMOF_Association,
     E_CMOF_Class,
     E_CMOF_Comment,
     E_CMOF_Constraint,
     E_CMOF_Data_Type,
     E_CMOF_Element_Import,
     E_CMOF_Enumeration,
     E_CMOF_Enumeration_Literal,
     E_CMOF_Expression,
     E_CMOF_Opaque_Expression,
     E_CMOF_Operation,
     E_CMOF_Package,
     E_CMOF_Package_Import,
     E_CMOF_Package_Merge,
     E_CMOF_Parameter,
     E_CMOF_Primitive_Type,
     E_CMOF_Property,
     E_CMOF_Tag);

   type Member_Kinds is
    (M_None,
     M_Boolean,
     M_Collection_Of_Element,
     M_Collection_Of_String,
     M_Element,
     M_Holder_Of_Integer,
     M_Holder_Of_Unlimited_Natural,
     M_Holder_Of_Visibility_Kind,
     M_Parameter_Direction_Kind,
     M_String,
     M_Visibility_Kind);

   type Member_Record (Kind : Member_Kinds := M_None) is record
      case Kind is
         when M_None =>
            null;

         when M_Boolean =>
            Boolean_Value : Boolean;

         when M_Collection_Of_Element =>
            Collection : AMF.Internals.AMF_Collection_Of_Element;

         when M_Collection_Of_String =>
            String_Collection : AMF.Internals.AMF_Collection_Of_String;

         when M_Element =>
            Link : AMF.Internals.AMF_Link;

         when M_Holder_Of_Integer =>
            Integer_Holder : AMF.Optional_Integer;

         when M_Holder_Of_Unlimited_Natural =>
            Unlimited_Natural_Holder : AMF.Optional_Unlimited_Natural;

         when M_Holder_Of_Visibility_Kind =>
            Visibility_Kind_Holder : AMF.CMOF.Optional_CMOF_Visibility_Kind;

         when M_Parameter_Direction_Kind =>
            Parameter_Direction_Kind_Value : AMF.CMOF.CMOF_Parameter_Direction_Kind;

         when M_String =>
            String_Value : Matreshka.Internals.Strings.Shared_String_Access;

         when M_Visibility_Kind =>
            Visibility_Kind_Value : AMF.CMOF.CMOF_Visibility_Kind;
      end case;
   end record;

   type Member_Array is array (Natural range 0 .. 21) of Member_Record;

   type Element_Record is record
      Kind   : Element_Kinds := E_None;
      Extent : AMF.Internals.AMF_Extent;
      Proxy  : AMF.Elements.Element_Access;
      Member : Member_Array;
   end record;

end AMF.Internals.Tables.CMOF_Types;
