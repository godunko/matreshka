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
--  This file is generated, don't edit it.
------------------------------------------------------------------------------
with AMF.Internals.Links;
with AMF.Internals.Tables.CMOF_Metamodel;
with AMF.Internals.Tables.Primitive_Types_Metamodel;
with AMF.Internals.Tables.UML_Metamodel;

package body AMF.Internals.Tables.MOF_Metamodel.Links is

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is
   begin
      Initialize_1;
      Initialize_2;
      Initialize_3;
      Initialize_4;
      Initialize_5;
      Initialize_6;
      Initialize_7;
      Initialize_8;
      Initialize_9;
      Initialize_10;
      Initialize_11;
   end Initialize;

   ------------------
   -- Initialize_1 --
   ------------------

   procedure Initialize_1 is
   begin
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Classifier_Attribute_Classifier,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Attribute_A_Classifier,
        Base + 3,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Classifier_Classifier_Attribute);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Classifier_Attribute_Classifier,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Attribute_A_Classifier,
        Base + 5,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Classifier_Classifier_Attribute);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Classifier_Attribute_Classifier,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Attribute_A_Classifier,
        Base + 2,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Classifier_Classifier_Attribute);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Classifier_Attribute_Classifier,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Attribute_A_Classifier,
        Base + 4,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Classifier_Classifier_Attribute);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Classifier_Feature_Featuring_Classifier,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Feature_Feature_Featuring_Classifier,
        Base + 3,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Feature_Featuring_Classifier_Classifier_Feature);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Classifier_Feature_Featuring_Classifier,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Feature_Feature_Featuring_Classifier,
        Base + 5,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Feature_Featuring_Classifier_Classifier_Feature);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Classifier_Feature_Featuring_Classifier,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Feature_Feature_Featuring_Classifier,
        Base + 2,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Feature_Featuring_Classifier_Classifier_Feature);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Classifier_Feature_Featuring_Classifier,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Feature_Feature_Featuring_Classifier,
        Base + 4,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Feature_Featuring_Classifier_Classifier_Feature);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Classifier_General_Classifier,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_General_A_Classifier,
        AMF.Internals.Tables.UML_Metamodel.MC_UML_Element,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Classifier_Classifier_General);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Member_Namespace,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        Base + 3,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Namespace_Namespace_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Member_Namespace,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        Base + 5,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Namespace_Namespace_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Member_Namespace,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        Base + 2,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Namespace_Namespace_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Member_Namespace,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        Base + 4,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Namespace_Namespace_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Class_Owned_Attribute_Class,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Class_Owned_Attribute_Property_Class,
        Base + 3,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Property_Class_Class_Owned_Attribute);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Class_Owned_Attribute_Class,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Class_Owned_Attribute_Property_Class,
        Base + 5,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Property_Class_Class_Owned_Attribute);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Class_Owned_Attribute_Class,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Class_Owned_Attribute_Property_Class,
        Base + 2,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Property_Class_Class_Owned_Attribute);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Class_Owned_Attribute_Class,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Class_Owned_Attribute_Property_Class,
        Base + 4,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Property_Class_Class_Owned_Attribute);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Element_Owned_Element_Owner,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        Base + 3,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owner_Element_Owned_Element);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Element_Owned_Element_Owner,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        Base + 5,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owner_Element_Owned_Element);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Element_Owned_Element_Owner,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        Base + 2,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owner_Element_Owned_Element);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Element_Owned_Element_Owner,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        Base + 4,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owner_Element_Owned_Element);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Owned_Member_Namespace,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        Base + 3,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Named_Element_Namespace_Namespace_Owned_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Owned_Member_Namespace,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        Base + 5,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Named_Element_Namespace_Namespace_Owned_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Owned_Member_Namespace,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        Base + 2,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Named_Element_Namespace_Namespace_Owned_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Owned_Member_Namespace,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        Base + 4,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Named_Element_Namespace_Namespace_Owned_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Class_Super_Class_Class,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Class_Super_Class_A_Class,
        AMF.Internals.Tables.UML_Metamodel.MC_UML_Element,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Class_Class_Super_Class);
   end Initialize_1;

   ------------------
   -- Initialize_2 --
   ------------------

   procedure Initialize_2 is
   begin
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Typed_Element_Type_Typed_Element,
        Base + 2,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Typed_Element_Type_A_Typed_Element,
        AMF.Internals.Tables.UML_Metamodel.MC_UML_Element,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Typed_Element_Typed_Element_Type);
   end Initialize_2;

   ------------------
   -- Initialize_3 --
   ------------------

   procedure Initialize_3 is
   begin
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Typed_Element_Type_Typed_Element,
        Base + 3,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Typed_Element_Type_A_Typed_Element,
        AMF.Internals.Tables.Primitive_Types_Metamodel.MC_Primitive_Types_String,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Typed_Element_Typed_Element_Type);
   end Initialize_3;

   ------------------
   -- Initialize_4 --
   ------------------

   procedure Initialize_4 is
   begin
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Property_Subsetted_Property_Property,
        Base + 4,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Property_Subsetted_Property_A_Property,
        AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owner_Element_Owned_Element,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Property_Property_Subsetted_Property);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Typed_Element_Type_Typed_Element,
        Base + 4,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Typed_Element_Type_A_Typed_Element,
        AMF.Internals.Tables.UML_Metamodel.MC_UML_Element,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Typed_Element_Typed_Element_Type);
   end Initialize_4;

   ------------------
   -- Initialize_5 --
   ------------------

   procedure Initialize_5 is
   begin
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Typed_Element_Type_Typed_Element,
        Base + 5,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Typed_Element_Type_A_Typed_Element,
        AMF.Internals.Tables.Primitive_Types_Metamodel.MC_Primitive_Types_String,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Typed_Element_Typed_Element_Type);
   end Initialize_5;

   ------------------
   -- Initialize_6 --
   ------------------

   procedure Initialize_6 is
   begin
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Classifier_Feature_Featuring_Classifier,
        Base + 6,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Feature_Feature_Featuring_Classifier,
        Base + 9,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Feature_Featuring_Classifier_Classifier_Feature);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Member_Namespace,
        Base + 6,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        Base + 9,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Namespace_Namespace_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Member_Namespace,
        Base + 6,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        Base + 2,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Namespace_Namespace_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Member_Namespace,
        Base + 6,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        Base + 9,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Namespace_Namespace_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Association_Member_End_Association,
        Base + 6,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Association_Member_End_Property_Association,
        Base + 2,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Property_Association_Association_Member_End);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Association_Member_End_Association,
        Base + 6,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Association_Member_End_Property_Association,
        Base + 9,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Property_Association_Association_Member_End);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Element_Owned_Element_Owner,
        Base + 6,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        Base + 9,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owner_Element_Owned_Element);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Association_Owned_End_Owning_Association,
        Base + 6,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Association_Owned_End_Property_Owning_Association,
        Base + 9,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Property_Owning_Association_Association_Owned_End);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Owned_Member_Namespace,
        Base + 6,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        Base + 9,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Named_Element_Namespace_Namespace_Owned_Member);
   end Initialize_6;

   ------------------
   -- Initialize_7 --
   ------------------

   procedure Initialize_7 is
   begin
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Classifier_Feature_Featuring_Classifier,
        Base + 7,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Feature_Feature_Featuring_Classifier,
        Base + 10,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Feature_Featuring_Classifier_Classifier_Feature);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Member_Namespace,
        Base + 7,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        Base + 4,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Namespace_Namespace_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Member_Namespace,
        Base + 7,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        Base + 10,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Namespace_Namespace_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Member_Namespace,
        Base + 7,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        Base + 10,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Namespace_Namespace_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Association_Member_End_Association,
        Base + 7,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Association_Member_End_Property_Association,
        Base + 4,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Property_Association_Association_Member_End);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Association_Member_End_Association,
        Base + 7,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Association_Member_End_Property_Association,
        Base + 10,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Property_Association_Association_Member_End);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Element_Owned_Element_Owner,
        Base + 7,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        Base + 10,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owner_Element_Owned_Element);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Association_Owned_End_Owning_Association,
        Base + 7,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Association_Owned_End_Property_Owning_Association,
        Base + 10,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Property_Owning_Association_Association_Owned_End);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Owned_Member_Namespace,
        Base + 7,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        Base + 10,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Named_Element_Namespace_Namespace_Owned_Member);
   end Initialize_7;

   ------------------
   -- Initialize_8 --
   ------------------

   procedure Initialize_8 is
   begin
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Member_Namespace,
        Base + 8,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        Base + 6,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Namespace_Namespace_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Member_Namespace,
        Base + 8,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Namespace_Namespace_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Member_Namespace,
        Base + 8,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        Base + 7,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Namespace_Namespace_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Element_Owned_Element_Owner,
        Base + 8,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        Base + 6,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owner_Element_Owned_Element);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Element_Owned_Element_Owner,
        Base + 8,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owner_Element_Owned_Element);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Element_Owned_Element_Owner,
        Base + 8,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        Base + 7,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owner_Element_Owned_Element);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Owned_Member_Namespace,
        Base + 8,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        Base + 6,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Named_Element_Namespace_Namespace_Owned_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Owned_Member_Namespace,
        Base + 8,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Named_Element_Namespace_Namespace_Owned_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Namespace_Owned_Member_Namespace,
        Base + 8,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        Base + 7,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Named_Element_Namespace_Namespace_Owned_Member);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Package_Owned_Type_Package,
        Base + 8,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Package_Owned_Type_Type_Package,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Type_Package_Package_Owned_Type);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Package_Packaged_Element_Owning_Package,
        Base + 8,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Package_Packaged_Element_A_Owning_Package,
        Base + 6,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Owning_Package_Package_Packaged_Element);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Package_Packaged_Element_Owning_Package,
        Base + 8,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Package_Packaged_Element_A_Owning_Package,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Owning_Package_Package_Packaged_Element);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Package_Packaged_Element_Owning_Package,
        Base + 8,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Package_Packaged_Element_A_Owning_Package,
        Base + 7,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Owning_Package_Package_Packaged_Element);
   end Initialize_8;

   ------------------
   -- Initialize_9 --
   ------------------

   procedure Initialize_9 is
   begin
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Typed_Element_Type_Typed_Element,
        Base + 9,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Typed_Element_Type_A_Typed_Element,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Typed_Element_Typed_Element_Type);
   end Initialize_9;

   -------------------
   -- Initialize_10 --
   -------------------

   procedure Initialize_10 is
   begin
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Property_Subsetted_Property_Property,
        Base + 10,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Property_Subsetted_Property_A_Property,
        AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Element_Element_Owner,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Property_Property_Subsetted_Property);
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Typed_Element_Type_Typed_Element,
        Base + 10,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Typed_Element_Type_A_Typed_Element,
        Base + 1,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Typed_Element_Typed_Element_Type);
   end Initialize_10;

   -------------------
   -- Initialize_11 --
   -------------------

   procedure Initialize_11 is
   begin
      AMF.Internals.Links.Internal_Create_Link
       (AMF.Internals.Tables.CMOF_Metamodel.MA_CMOF_Tag_Element_Tag,
        Base + 11,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Tag_Element_A_Tag,
        Base + 8,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_A_Tag_Tag_Element);
   end Initialize_11;

end AMF.Internals.Tables.MOF_Metamodel.Links;
