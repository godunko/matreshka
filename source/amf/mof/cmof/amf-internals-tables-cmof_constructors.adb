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
-- Copyright © 2010-2013, Vadim Godunko <vgodunko@gmail.com>                --
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
with AMF.Internals.CMOF_Associations;
with AMF.Internals.CMOF_Classes;
with AMF.Internals.CMOF_Comments;
with AMF.Internals.CMOF_Constraints;
with AMF.Internals.CMOF_Data_Types;
with AMF.Internals.CMOF_Element_Imports;
with AMF.Internals.CMOF_Enumeration_Literals;
with AMF.Internals.CMOF_Enumerations;
with AMF.Internals.CMOF_Expressions;
with AMF.Internals.CMOF_Opaque_Expressions;
with AMF.Internals.CMOF_Operations;
with AMF.Internals.CMOF_Package_Imports;
with AMF.Internals.CMOF_Package_Merges;
with AMF.Internals.CMOF_Packages;
with AMF.Internals.CMOF_Parameters;
with AMF.Internals.CMOF_Primitive_Types;
with AMF.Internals.CMOF_Properties;
with AMF.Internals.CMOF_Tags;
with AMF.Internals.Element_Collections;
with AMF.Internals.Tables.CMOF_Element_Table;
with AMF.Internals.Tables.CMOF_Metamodel;
with AMF.Internals.Tables.CMOF_Types;
with Matreshka.Internals.Strings;

package body AMF.Internals.Tables.CMOF_Constructors is

   use AMF.Internals.Tables;
   use type AMF.Internals.AMF_Collection_Of_Element;

   -----------------------------
   -- Create_CMOF_Association --
   -----------------------------

   function Create_CMOF_Association return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Association,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Associations.CMOF_Association_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          13     => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isDerived
          7      => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isFinalSpecialization
          2      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  name
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  namespace
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          6      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  package
          5      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  qualifiedName
          3      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Visibility_Kind, (Is_Empty => True)),
                       --  visibility
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  attribute

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Attribute_A_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 9);

      --  elementImport

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Element_Import_Element_Import_Importing_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 4);

      --  endType

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Association_End_Type_A_Association,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 15);

      --  feature

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Feature_Feature_Featuring_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 10);

      --  general

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_General_A_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 11);

      --  importedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Imported_Member_A_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 3);

      --  inheritedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Inherited_Member_A_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 12);

      --  member

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 7);

      --  memberEnd

      AMF.Internals.Element_Collections.Initialize_Ordered_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Association_Member_End_Property_Association,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 16);

      --  navigableOwnedEnd

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Association_Navigable_Owned_End_A_Association,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 17);

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      --  ownedEnd

      AMF.Internals.Element_Collections.Initialize_Ordered_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Association_Owned_End_Property_Owning_Association,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 14);

      --  ownedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 6);

      --  ownedRule

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Rule_Constraint_Context,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 8);

      --  packageImport

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Package_Import_Package_Import_Importing_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 5);

      --  relatedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Relationship_Related_Element_A_Relationship,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 13);

      return Self;
   end Create_CMOF_Association;

   -----------------------
   -- Create_CMOF_Class --
   -----------------------

   function Create_CMOF_Class return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Class,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Classes.CMOF_Class_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          8      => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isAbstract
          7      => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isFinalSpecialization
          2      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  name
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  namespace
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          6      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  package
          5      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  qualifiedName
          3      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Visibility_Kind, (Is_Empty => True)),
                       --  visibility
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  attribute

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Attribute_A_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 9);

      --  elementImport

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Element_Import_Element_Import_Importing_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 4);

      --  feature

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Feature_Feature_Featuring_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 10);

      --  general

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_General_A_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 11);

      --  importedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Imported_Member_A_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 3);

      --  inheritedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Inherited_Member_A_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 12);

      --  member

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 7);

      --  ownedAttribute

      AMF.Internals.Element_Collections.Initialize_Ordered_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Class_Owned_Attribute_Property_Class,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 13);

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      --  ownedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 6);

      --  ownedOperation

      AMF.Internals.Element_Collections.Initialize_Ordered_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Class_Owned_Operation_Operation_Class,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 14);

      --  ownedRule

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Rule_Constraint_Context,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 8);

      --  packageImport

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Package_Import_Package_Import_Importing_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 5);

      --  superClass

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Class_Super_Class_A_Class,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 15);

      return Self;
   end Create_CMOF_Class;

   -------------------------
   -- Create_CMOF_Comment --
   -------------------------

   function Create_CMOF_Comment return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Comment,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Comments.CMOF_Comment_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          2      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  body
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  annotatedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Comment_Annotated_Element_A_Comment,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 3);

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      return Self;
   end Create_CMOF_Comment;

   ----------------------------
   -- Create_CMOF_Constraint --
   ----------------------------

   function Create_CMOF_Constraint return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Constraint,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Constraints.CMOF_Constraint_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          7      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  context
          2      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  name
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  namespace
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          5      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  qualifiedName
          6      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  specification
          3      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Visibility_Kind, (Is_Empty => True)),
                       --  visibility
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  constrainedElement

      AMF.Internals.Element_Collections.Initialize_Ordered_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Constraint_Constrained_Element_A_Constraint,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 3);

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      return Self;
   end Create_CMOF_Constraint;

   ---------------------------
   -- Create_CMOF_Data_Type --
   ---------------------------

   function Create_CMOF_Data_Type return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Data_Type,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Data_Types.CMOF_Data_Type_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          7      => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isFinalSpecialization
          2      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  name
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  namespace
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          6      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  package
          5      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  qualifiedName
          3      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Visibility_Kind, (Is_Empty => True)),
                       --  visibility
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  attribute

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Attribute_A_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 9);

      --  elementImport

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Element_Import_Element_Import_Importing_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 4);

      --  feature

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Feature_Feature_Featuring_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 10);

      --  general

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_General_A_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 11);

      --  importedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Imported_Member_A_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 3);

      --  inheritedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Inherited_Member_A_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 12);

      --  member

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 7);

      --  ownedAttribute

      AMF.Internals.Element_Collections.Initialize_Ordered_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Data_Type_Owned_Attribute_Property_Datatype,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 13);

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      --  ownedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 6);

      --  ownedOperation

      AMF.Internals.Element_Collections.Initialize_Ordered_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Data_Type_Owned_Operation_Operation_Datatype,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 14);

      --  ownedRule

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Rule_Constraint_Context,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 8);

      --  packageImport

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Package_Import_Package_Import_Importing_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 5);

      return Self;
   end Create_CMOF_Data_Type;

   --------------------------------
   -- Create_CMOF_Element_Import --
   --------------------------------

   function Create_CMOF_Element_Import return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Element_Import,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Element_Imports.CMOF_Element_Import_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          3      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  alias
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  importedElement
          5      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  importingNamespace
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          2      => (AMF.Internals.Tables.CMOF_Types.M_Visibility_Kind, AMF.CMOF.Public_Visibility),
                       --  visibility
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      --  relatedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Relationship_Related_Element_A_Relationship,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 13);

      --  source

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Directed_Relationship_Source_A_Directed_Relationship,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 3);

      --  target

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Directed_Relationship_Target_A_Directed_Relationship,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 4);

      return Self;
   end Create_CMOF_Element_Import;

   -----------------------------
   -- Create_CMOF_Enumeration --
   -----------------------------

   function Create_CMOF_Enumeration return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Enumeration,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Enumerations.CMOF_Enumeration_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          7      => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isFinalSpecialization
          2      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  name
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  namespace
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          6      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  package
          5      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  qualifiedName
          3      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Visibility_Kind, (Is_Empty => True)),
                       --  visibility
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  attribute

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Attribute_A_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 9);

      --  elementImport

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Element_Import_Element_Import_Importing_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 4);

      --  feature

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Feature_Feature_Featuring_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 10);

      --  general

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_General_A_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 11);

      --  importedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Imported_Member_A_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 3);

      --  inheritedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Inherited_Member_A_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 12);

      --  member

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 7);

      --  ownedAttribute

      AMF.Internals.Element_Collections.Initialize_Ordered_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Data_Type_Owned_Attribute_Property_Datatype,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 13);

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      --  ownedLiteral

      AMF.Internals.Element_Collections.Initialize_Ordered_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Enumeration_Owned_Literal_Enumeration_Literal_Enumeration,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 15);

      --  ownedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 6);

      --  ownedOperation

      AMF.Internals.Element_Collections.Initialize_Ordered_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Data_Type_Owned_Operation_Operation_Datatype,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 14);

      --  ownedRule

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Rule_Constraint_Context,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 8);

      --  packageImport

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Package_Import_Package_Import_Importing_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 5);

      return Self;
   end Create_CMOF_Enumeration;

   -------------------------------------
   -- Create_CMOF_Enumeration_Literal --
   -------------------------------------

   function Create_CMOF_Enumeration_Literal return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Enumeration_Literal,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Enumeration_Literals.CMOF_Enumeration_Literal_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          6      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  enumeration
          2      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  name
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  namespace
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          5      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  qualifiedName
          3      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Visibility_Kind, (Is_Empty => True)),
                       --  visibility
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      return Self;
   end Create_CMOF_Enumeration_Literal;

   ----------------------------
   -- Create_CMOF_Expression --
   ----------------------------

   function Create_CMOF_Expression return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Expression,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Expressions.CMOF_Expression_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          2      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  name
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  namespace
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          5      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  qualifiedName
          6      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  type
          3      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Visibility_Kind, (Is_Empty => True)),
                       --  visibility
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  operand

      AMF.Internals.Element_Collections.Initialize_Ordered_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Expression_Operand_A_Expression,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 3);

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      return Self;
   end Create_CMOF_Expression;

   -----------------------------------
   -- Create_CMOF_Opaque_Expression --
   -----------------------------------

   function Create_CMOF_Opaque_Expression return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Opaque_Expression,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Opaque_Expressions.CMOF_Opaque_Expression_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          7      => (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_String, 0),
                       --  body
          8      => (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_String, 0),
                       --  language
          2      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  name
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  namespace
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          5      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  qualifiedName
          6      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  type
          3      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Visibility_Kind, (Is_Empty => True)),
                       --  visibility
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      return Self;
   end Create_CMOF_Opaque_Expression;

   ---------------------------
   -- Create_CMOF_Operation --
   ---------------------------

   function Create_CMOF_Operation return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Operation,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Operations.CMOF_Operation_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          15     => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  bodyCondition
          12     => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  class
          13     => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  datatype
          11     => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isLeaf
          7      => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isOrdered
          6      => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isQuery
          8      => (AMF.Internals.Tables.CMOF_Types.M_Boolean, True),
                       --  isUnique
          9      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Integer, (False, 1)),
                       --  lower
          2      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  name
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  namespace
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          5      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  qualifiedName
          14     => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  type
          10     => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Unlimited_Natural, (False, (False, 1))),
                       --  upper
          3      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Visibility_Kind, (Is_Empty => True)),
                       --  visibility
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  elementImport

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Element_Import_Element_Import_Importing_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 4);

      --  featuringClassifier

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Feature_Featuring_Classifier_Classifier_Feature,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 11);

      --  importedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Imported_Member_A_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 3);

      --  member

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 7);

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      --  ownedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 6);

      --  ownedParameter

      AMF.Internals.Element_Collections.Initialize_Ordered_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Operation_Owned_Parameter_Parameter_Operation,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 16);

      --  ownedParameter

      AMF.Internals.Element_Collections.Initialize_Ordered_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Behavioral_Feature_Owned_Parameter_A_Owner_Formal_Param,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 12);

      --  ownedRule

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Rule_Constraint_Context,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 8);

      --  packageImport

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Package_Import_Package_Import_Importing_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 5);

      --  postcondition

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Operation_Postcondition_A_Post_Context,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 18);

      --  precondition

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Operation_Precondition_A_Pre_Context,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 17);

      --  raisedException

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Operation_Raised_Exception_A_Operation,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 14);

      --  raisedException

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Behavioral_Feature_Raised_Exception_A_Behavioral_Feature,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 13);

      --  redefinedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Redefinable_Element_Redefined_Element_A_Redefinable_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 10);

      --  redefinedOperation

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Operation_Redefined_Operation_A_Operation,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 15);

      --  redefinitionContext

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Redefinable_Element_Redefinition_Context_A_Redefinable_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 9);

      return Self;
   end Create_CMOF_Operation;

   -------------------------
   -- Create_CMOF_Package --
   -------------------------

   function Create_CMOF_Package return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Package,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Packages.CMOF_Package_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          2      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  name
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  namespace
          6      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  nestingPackage
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          5      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  qualifiedName
          7      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  uri
          3      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Visibility_Kind, (Is_Empty => True)),
                       --  visibility
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  elementImport

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Element_Import_Element_Import_Importing_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 4);

      --  importedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Imported_Member_A_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 3);

      --  member

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 7);

      --  nestedPackage

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Package_Nested_Package_Package_Nesting_Package,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 11);

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      --  ownedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 6);

      --  ownedRule

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Rule_Constraint_Context,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 8);

      --  ownedType

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Package_Owned_Type_Type_Package,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 10);

      --  packageImport

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Package_Import_Package_Import_Importing_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 5);

      --  packageMerge

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Package_Package_Merge_Package_Merge_Receiving_Package,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 12);

      --  packagedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Package_Packaged_Element_A_Owning_Package,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 9);

      return Self;
   end Create_CMOF_Package;

   --------------------------------
   -- Create_CMOF_Package_Import --
   --------------------------------

   function Create_CMOF_Package_Import return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Package_Import,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Package_Imports.CMOF_Package_Import_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          3      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  importedPackage
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  importingNamespace
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          2      => (AMF.Internals.Tables.CMOF_Types.M_Visibility_Kind, AMF.CMOF.Public_Visibility),
                       --  visibility
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      --  relatedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Relationship_Related_Element_A_Relationship,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 13);

      --  source

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Directed_Relationship_Source_A_Directed_Relationship,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 3);

      --  target

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Directed_Relationship_Target_A_Directed_Relationship,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 4);

      return Self;
   end Create_CMOF_Package_Import;

   -------------------------------
   -- Create_CMOF_Package_Merge --
   -------------------------------

   function Create_CMOF_Package_Merge return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Package_Merge,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Package_Merges.CMOF_Package_Merge_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          3      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  mergedPackage
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          2      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  receivingPackage
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      --  relatedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Relationship_Related_Element_A_Relationship,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 13);

      --  source

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Directed_Relationship_Source_A_Directed_Relationship,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 3);

      --  target

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Directed_Relationship_Target_A_Directed_Relationship,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 4);

      return Self;
   end Create_CMOF_Package_Merge;

   ---------------------------
   -- Create_CMOF_Parameter --
   ---------------------------

   function Create_CMOF_Parameter return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Parameter,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Parameters.CMOF_Parameter_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          12     => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  default
          11     => (AMF.Internals.Tables.CMOF_Types.M_Parameter_Direction_Kind, AMF.CMOF.In_Parameter),
                       --  direction
          7      => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isOrdered
          8      => (AMF.Internals.Tables.CMOF_Types.M_Boolean, True),
                       --  isUnique
          9      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Integer, (False, 1)),
                       --  lower
          2      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  name
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  namespace
          13     => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  operation
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          5      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  qualifiedName
          6      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  type
          10     => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Unlimited_Natural, (False, (False, 1))),
                       --  upper
          3      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Visibility_Kind, (Is_Empty => True)),
                       --  visibility
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      return Self;
   end Create_CMOF_Parameter;

   --------------------------------
   -- Create_CMOF_Primitive_Type --
   --------------------------------

   function Create_CMOF_Primitive_Type return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Primitive_Type,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Primitive_Types.CMOF_Primitive_Type_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          7      => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isFinalSpecialization
          2      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  name
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  namespace
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          6      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  package
          5      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  qualifiedName
          3      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Visibility_Kind, (Is_Empty => True)),
                       --  visibility
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  attribute

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Attribute_A_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 9);

      --  elementImport

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Element_Import_Element_Import_Importing_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 4);

      --  feature

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Feature_Feature_Featuring_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 10);

      --  general

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_General_A_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 11);

      --  importedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Imported_Member_A_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 3);

      --  inheritedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Classifier_Inherited_Member_A_Classifier,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 12);

      --  member

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Member_A_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 7);

      --  ownedAttribute

      AMF.Internals.Element_Collections.Initialize_Ordered_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Data_Type_Owned_Attribute_Property_Datatype,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 13);

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      --  ownedMember

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Member_Named_Element_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 6);

      --  ownedOperation

      AMF.Internals.Element_Collections.Initialize_Ordered_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Data_Type_Owned_Operation_Operation_Datatype,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 14);

      --  ownedRule

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Owned_Rule_Constraint_Context,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 8);

      --  packageImport

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Namespace_Package_Import_Package_Import_Importing_Namespace,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 5);

      return Self;
   end Create_CMOF_Primitive_Type;

   --------------------------
   -- Create_CMOF_Property --
   --------------------------

   function Create_CMOF_Property return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Property,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Properties.CMOF_Property_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          21     => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  association
          17     => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  class
          20     => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  datatype
          12     => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  default
          15     => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isComposite
          13     => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isDerived
          16     => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isDerivedUnion
          11     => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isLeaf
          7      => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isOrdered
          14     => (AMF.Internals.Tables.CMOF_Types.M_Boolean, False),
                       --  isReadOnly
          8      => (AMF.Internals.Tables.CMOF_Types.M_Boolean, True),
                       --  isUnique
          9      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Integer, (False, 1)),
                       --  lower
          2      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  name
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  namespace
          19     => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  opposite
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          18     => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owningAssociation
          5      => (AMF.Internals.Tables.CMOF_Types.M_String, null),
                       --  qualifiedName
          6      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  type
          10     => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Unlimited_Natural, (False, (False, 1))),
                       --  upper
          3      => (AMF.Internals.Tables.CMOF_Types.M_Holder_Of_Visibility_Kind, (Is_Empty => True)),
                       --  visibility
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  featuringClassifier

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Feature_Featuring_Classifier_Classifier_Feature,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 11);

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      --  redefinedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Redefinable_Element_Redefined_Element_A_Redefinable_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 10);

      --  redefinedProperty

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Property_Redefined_Property_A_Property,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 3);

      --  redefinitionContext

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Redefinable_Element_Redefinition_Context_A_Redefinable_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 9);

      --  subsettedProperty

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Property_Subsetted_Property_A_Property,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 4);

      return Self;
   end Create_CMOF_Property;

   ---------------------
   -- Create_CMOF_Tag --
   ---------------------

   function Create_CMOF_Tag return AMF.Internals.AMF_Element is
      Self : AMF.Internals.AMF_Element;

   begin
      CMOF_Element_Table.Increment_Last;
      Self := CMOF_Element_Table.Last;

      CMOF_Element_Table.Table (Self).all :=
       (Kind     => AMF.Internals.Tables.CMOF_Types.E_CMOF_Tag,
        Extent   => 0,
        Proxy    =>
          new AMF.Internals.CMOF_Tags.CMOF_Tag_Proxy'(Element => Self),
        Member   =>
         (0      => (Kind => AMF.Internals.Tables.CMOF_Types.M_None),
          2      => (AMF.Internals.Tables.CMOF_Types.M_String, Matreshka.Internals.Strings.Shared_Empty'Access),
                       --  name
          1      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  owner
          4      => (AMF.Internals.Tables.CMOF_Types.M_Element, No_AMF_Link),
                       --  tagOwner
          3      => (AMF.Internals.Tables.CMOF_Types.M_String, Matreshka.Internals.Strings.Shared_Empty'Access),
                       --  value
          others => (Kind => AMF.Internals.Tables.CMOF_Types.M_None)));
      CMOF_Element_Table.Table (Self).Member (0) :=
       (AMF.Internals.Tables.CMOF_Types.M_Collection_Of_Element,
        AMF.Internals.Element_Collections.Allocate_Collections (45));

      --  element

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Tag_Element_A_Tag,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 3);

      --  ownedComment

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Comment_A_Owning_Element,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 2);

      --  ownedElement

      AMF.Internals.Element_Collections.Initialize_Set_Collection
       (Self,
        AMF.Internals.Tables.CMOF_Metamodel.MP_CMOF_Element_Owned_Element_Element_Owner,
        CMOF_Element_Table.Table (Self).Member (0).Collection + 1);

      return Self;
   end Create_CMOF_Tag;

end AMF.Internals.Tables.CMOF_Constructors;
