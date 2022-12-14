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
with Ada.Wide_Wide_Text_IO;

with AMF.CMOF.Associations;
with AMF.CMOF.Classes;
with AMF.CMOF.Packageable_Elements.Collections;
with AMF.CMOF.Packages;
with AMF.CMOF.Properties.Collections;
with AMF.CMOF.Types;
with AMF.UML.Packageable_Elements.Collections;
with AMF.UML.Properties.Collections;
with AMF.UML.Types;
with AMF.Visitors.UML_Containment;

package body AMF.Transformations.UML_MOF_To_CMOF is

   procedure Output (Item : Wide_Wide_String);

   CMOF_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://schema.omg.org/spec/MOF/2.0/cmof.xml");

   function To_CMOF_Visibility_Kind
    (Item : AMF.UML.Optional_UML_Visibility_Kind)
       return AMF.CMOF.Optional_CMOF_Visibility_Kind;

   -----------------------
   -- Enter_Association --
   -----------------------

   overriding procedure Enter_Association
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Associations.UML_Association_Access;
     Control : in out AMF.Visitors.Traverse_Control)
   is
      The_Association : constant not null
        AMF.CMOF.Associations.CMOF_Association_Access
          := Self.Transformer.Factory.Create_Association;

   begin
      Self.Register (Element, The_Association);
      The_Association.Set_Name (Element.Get_Name);
      The_Association.Set_Visibility
       (To_CMOF_Visibility_Kind (Element.Get_Visibility));
   end Enter_Association;

   -----------------------
   -- Enter_Association --
   -----------------------

   overriding procedure Enter_Association
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Associations.UML_Association_Access;
     Control : in out AMF.Visitors.Traverse_Control)
   is
      The_Association : constant not null
        AMF.CMOF.Associations.CMOF_Association_Access
          := AMF.CMOF.Associations.CMOF_Association_Access
              (Self.Resolve (Element));

   begin
      --  ownedEnd

      declare
         Source : AMF.UML.Properties.Collections.Ordered_Set_Of_UML_Property
           := Element.Get_Owned_End;
         Target : AMF.CMOF.Properties.Collections.Ordered_Set_Of_CMOF_Property
           := The_Association.Get_Owned_End;

      begin
         for J in 1 .. Source.Length loop
            Target.Add
             (AMF.CMOF.Properties.CMOF_Property_Access
               (Self.Resolve (Source.Element (J))));
         end loop;
      end;

      --  memberEnd

      declare
         Source : AMF.UML.Properties.Collections.Ordered_Set_Of_UML_Property
           := Element.Get_Member_End;
         Target : AMF.CMOF.Properties.Collections.Ordered_Set_Of_CMOF_Property
           := The_Association.Get_Member_End;

      begin
         for J in 1 .. Source.Length loop
            Target.Add
             (AMF.CMOF.Properties.CMOF_Property_Access
               (Self.Resolve (Source.Element (J))));
         end loop;
      end;
   end Enter_Association;

   -----------------
   -- Enter_Class --
   -----------------

   overriding procedure Enter_Class
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Classes.UML_Class_Access;
     Control : in out AMF.Visitors.Traverse_Control)
   is
      The_Class : constant not null AMF.CMOF.Classes.CMOF_Class_Access
        := Self.Transformer.Factory.Create_Class;

   begin
      Self.Register (Element, The_Class);
      The_Class.Set_Is_Abstract (Element.Get_Is_Abstract);
      The_Class.Set_Name (Element.Get_Name);
      The_Class.Set_Visibility
       (To_CMOF_Visibility_Kind (Element.Get_Visibility));
   end Enter_Class;

   -----------------
   -- Enter_Class --
   -----------------

   overriding procedure Enter_Class
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Classes.UML_Class_Access;
     Control : in out AMF.Visitors.Traverse_Control)
   is
      The_Class : constant not null AMF.CMOF.Classes.CMOF_Class_Access
        := AMF.CMOF.Classes.CMOF_Class_Access (Self.Resolve (Element));

   begin
      --  ownedAttribute

      declare
         Source : AMF.UML.Properties.Collections.Ordered_Set_Of_UML_Property
           := Element.Get_Owned_Attribute;
         Target : AMF.CMOF.Properties.Collections.Ordered_Set_Of_CMOF_Property
           := The_Class.Get_Owned_Attribute;

      begin
         for J in 1 .. Source.Length loop
            Target.Add
             (AMF.CMOF.Properties.CMOF_Property_Access
               (Self.Resolve (Source.Element (J))));
         end loop;
      end;
   end Enter_Class;

   -------------------
   -- Enter_Comment --
   -------------------

   overriding procedure Enter_Comment
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Comments.UML_Comment_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Comment;

   -------------------
   -- Enter_Comment --
   -------------------

   overriding procedure Enter_Comment
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Comments.UML_Comment_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Comment;

   ----------------------
   -- Enter_Constraint --
   ----------------------

   overriding procedure Enter_Constraint
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Constraints.UML_Constraint_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Constraint;

   ----------------------
   -- Enter_Constraint --
   ----------------------

   overriding procedure Enter_Constraint
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Constraints.UML_Constraint_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Constraint;

   ---------------------
   -- Enter_Data_Type --
   ---------------------

   overriding procedure Enter_Data_Type
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Data_Types.UML_Data_Type_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Data_Type;

   ---------------------
   -- Enter_Data_Type --
   ---------------------

   overriding procedure Enter_Data_Type
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Data_Types.UML_Data_Type_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Data_Type;

   --------------------------
   -- Enter_Element_Import --
   --------------------------

   overriding procedure Enter_Element_Import
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Element_Imports.UML_Element_Import_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Element_Import;

   --------------------------
   -- Enter_Element_Import --
   --------------------------

   overriding procedure Enter_Element_Import
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Element_Imports.UML_Element_Import_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Element_Import;

   -----------------------
   -- Enter_Enumeration --
   -----------------------

   overriding procedure Enter_Enumeration
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Enumerations.UML_Enumeration_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Enumeration;

   -----------------------
   -- Enter_Enumeration --
   -----------------------

   overriding procedure Enter_Enumeration
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Enumerations.UML_Enumeration_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Enumeration;

   -------------------------------
   -- Enter_Enumeration_Literal --
   -------------------------------

   overriding procedure Enter_Enumeration_Literal
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Enumeration_Literals.UML_Enumeration_Literal_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Enumeration_Literal;

   -------------------------------
   -- Enter_Enumeration_Literal --
   -------------------------------

   overriding procedure Enter_Enumeration_Literal
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Enumeration_Literals.UML_Enumeration_Literal_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Enumeration_Literal;

   --------------------------
   -- Enter_Generalization --
   --------------------------

   overriding procedure Enter_Generalization
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Generalizations.UML_Generalization_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Generalization;

   --------------------------
   -- Enter_Generalization --
   --------------------------

   overriding procedure Enter_Generalization
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Generalizations.UML_Generalization_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Generalization;

   --------------------------
   -- Enter_Instance_Value --
   --------------------------

   overriding procedure Enter_Instance_Value
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Instance_Values.UML_Instance_Value_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Instance_Value;

   --------------------------
   -- Enter_Instance_Value --
   --------------------------

   overriding procedure Enter_Instance_Value
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Instance_Values.UML_Instance_Value_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Instance_Value;

   ---------------------------
   -- Enter_Literal_Boolean --
   ---------------------------

   overriding procedure Enter_Literal_Boolean
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Literal_Booleans.UML_Literal_Boolean_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Literal_Boolean;

   ---------------------------
   -- Enter_Literal_Boolean --
   ---------------------------

   overriding procedure Enter_Literal_Boolean
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Literal_Booleans.UML_Literal_Boolean_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Literal_Boolean;

   ---------------------------
   -- Enter_Literal_Integer --
   ---------------------------

   overriding procedure Enter_Literal_Integer
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Literal_Integers.UML_Literal_Integer_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Literal_Integer;

   ------------------------
   -- Enter_Literal_Null --
   ------------------------

   overriding procedure Enter_Literal_Null
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Literal_Nulls.UML_Literal_Null_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Literal_Null;

   ------------------------
   -- Enter_Literal_Real --
   ------------------------

   overriding procedure Enter_Literal_Real
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Literal_Reals.UML_Literal_Real_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Literal_Real;

   --------------------------
   -- Enter_Literal_String --
   --------------------------

   overriding procedure Enter_Literal_String
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Literal_Strings.UML_Literal_String_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Literal_String;

   -------------------------------------
   -- Enter_Literal_Unlimited_Natural --
   -------------------------------------

   overriding procedure Enter_Literal_Unlimited_Natural
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Literal_Unlimited_Naturals.UML_Literal_Unlimited_Natural_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Literal_Unlimited_Natural;

   -----------------------------
   -- Enter_Opaque_Expression --
   -----------------------------

   overriding procedure Enter_Opaque_Expression
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Opaque_Expressions.UML_Opaque_Expression_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Opaque_Expression;

   ---------------------
   -- Enter_Operation --
   ---------------------

   overriding procedure Enter_Operation
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Operations.UML_Operation_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Operation;

   -------------------
   -- Enter_Package --
   -------------------

   overriding procedure Enter_Package
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Packages.UML_Package_Access;
     Control : in out AMF.Visitors.Traverse_Control)
   is
      The_Package : constant not null AMF.CMOF.Packages.CMOF_Package_Access
        := Self.Transformer.Factory.Create_Package;

   begin
      Self.Register (Element, The_Package);
      The_Package.Set_Name (Element.Get_Name);
      The_Package.Set_URI (Element.Get_URI);
      The_Package.Set_Visibility
       (To_CMOF_Visibility_Kind (Element.Get_Visibility));
   end Enter_Package;

   -------------------
   -- Enter_Package --
   -------------------

   overriding procedure Enter_Package
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Packages.UML_Package_Access;
     Control : in out AMF.Visitors.Traverse_Control)
   is
      The_Package : constant not null AMF.CMOF.Packages.CMOF_Package_Access
        := AMF.CMOF.Packages.CMOF_Package_Access (Self.Resolve (Element));
      Source      :
        AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element
          := Element.Get_Packaged_Element;
      Target      :
        AMF.CMOF.Packageable_Elements.Collections.
          Set_Of_CMOF_Packageable_Element
            := The_Package.Get_Packaged_Element;

   begin
      for J in 1 .. Source.Length loop
         Target.Add
          (AMF.CMOF.Packageable_Elements.CMOF_Packageable_Element_Access
            (Self.Resolve (Source.Element (J))));
      end loop;
   end Enter_Package;

   --------------------------
   -- Enter_Package_Import --
   --------------------------

   overriding procedure Enter_Package_Import
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Package_Imports.UML_Package_Import_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Package_Import;

   -------------------------
   -- Enter_Package_Merge --
   -------------------------

   overriding procedure Enter_Package_Merge
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Package_Merges.UML_Package_Merge_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Package_Merge;

   ---------------------
   -- Enter_Parameter --
   ---------------------

   overriding procedure Enter_Parameter
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Parameters.UML_Parameter_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Parameter;

   --------------------------
   -- Enter_Primitive_Type --
   --------------------------

   overriding procedure Enter_Primitive_Type
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Primitive_Types.UML_Primitive_Type_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Primitive_Type;

   --------------------
   -- Enter_Property --
   --------------------

   overriding procedure Enter_Property
    (Self    : in out First_Pass_Visitor;
     Element : not null AMF.UML.Properties.UML_Property_Access;
     Control : in out AMF.Visitors.Traverse_Control)
   is
      The_Property : constant not null AMF.CMOF.Properties.CMOF_Property_Access
        := Self.Transformer.Factory.Create_Property;

   begin
      Self.Register (Element, The_Property);
      The_Property.Set_Lower (Element.Get_Lower);
      The_Property.Set_Name (Element.Get_Name);
      The_Property.Set_Upper (Element.Get_Upper);
      The_property.Set_Visibility
       (To_CMOF_Visibility_Kind (Element.Get_Visibility));
   end Enter_Property;

   --------------------
   -- Enter_Property --
   --------------------

   overriding procedure Enter_Property
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Properties.UML_Property_Access;
     Control : in out AMF.Visitors.Traverse_Control)
   is
      The_Property : constant not null AMF.CMOF.Properties.CMOF_Property_Access
        := AMF.CMOF.Properties.CMOF_Property_Access (Self.Resolve (Element));
      The_Type     : constant not null AMF.UML.Types.UML_Type_Access
        := Element.Get_Type;

   begin
      begin
         The_Property.Set_Type
          (AMF.CMOF.Types.CMOF_Type_Access (Self.Resolve (The_Type)));
      exception
         when Constraint_Error =>
            Output ("Property: element not in map");
      end;
   end Enter_Property;

   ---------------------------
   -- Enter_Literal_Integer --
   ---------------------------

   overriding procedure Enter_Literal_Integer
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Literal_Integers.UML_Literal_Integer_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Literal_Integer;

   ------------------------
   -- Enter_Literal_Null --
   ------------------------

   overriding procedure Enter_Literal_Null
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Literal_Nulls.UML_Literal_Null_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Literal_Null;

   ------------------------
   -- Enter_Literal_Real --
   ------------------------

   overriding procedure Enter_Literal_Real
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Literal_Reals.UML_Literal_Real_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Literal_Real;

   --------------------------
   -- Enter_Literal_String --
   --------------------------

   overriding procedure Enter_Literal_String
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Literal_Strings.UML_Literal_String_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Literal_String;

   -------------------------------------
   -- Enter_Literal_Unlimited_Natural --
   -------------------------------------

   overriding procedure Enter_Literal_Unlimited_Natural
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Literal_Unlimited_Naturals.UML_Literal_Unlimited_Natural_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Literal_Unlimited_Natural;

   -----------------------------
   -- Enter_Opaque_Expression --
   -----------------------------

   overriding procedure Enter_Opaque_Expression
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Opaque_Expressions.UML_Opaque_Expression_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Opaque_Expression;

   ---------------------
   -- Enter_Operation --
   ---------------------

   overriding procedure Enter_Operation
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Operations.UML_Operation_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Operation;

   --------------------------
   -- Enter_Package_Import --
   --------------------------

   overriding procedure Enter_Package_Import
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Package_Imports.UML_Package_Import_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Package_Import;

   -------------------------
   -- Enter_Package_Merge --
   -------------------------

   overriding procedure Enter_Package_Merge
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Package_Merges.UML_Package_Merge_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Package_Merge;

   ---------------------
   -- Enter_Parameter --
   ---------------------

   overriding procedure Enter_Parameter
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Parameters.UML_Parameter_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Parameter;

   --------------------------
   -- Enter_Primitive_Type --
   --------------------------

   overriding procedure Enter_Primitive_Type
    (Self    : in out Second_Pass_Visitor;
     Element : not null AMF.UML.Primitive_Types.UML_Primitive_Type_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      null;
   end Enter_Primitive_Type;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self   : not null access UML_MOF_To_CMOF_Transformer'Class;
     Target : not null AMF.URI_Stores.URI_Store_Access) is
   begin
      Self.Target := Target;
      Self.Factory :=
        AMF.Factories.CMOF_Factories.CMOF_Factory_Access
         (Self.Target.Get_Factory (CMOF_URI));
   end Initialize;

   ------------
   -- Output --
   ------------

   procedure Output (Item : Wide_Wide_String) is
   begin
      Ada.Wide_Wide_Text_IO.Put_Line
       (Ada.Wide_Wide_Text_IO.Standard_Error, Item);
   end Output;

   --------------
   -- Register --
   --------------

   procedure Register
    (Self         : in out First_Pass_Visitor'Class;
     UML_Element  : not null access AMF.UML.Elements.UML_Element'Class;
     CMOF_Element : not null access AMF.CMOF.Elements.CMOF_Element'Class) is
   begin
      Self.Transformer.CMOF_Element.Insert
       (AMF.Elements.Element_Access (UML_Element),
        AMF.CMOF.Elements.CMOF_Element_Access (CMOF_Element));
   end Register;

   -------------
   -- Resolve --
   -------------

   function Resolve
    (Self        : in out Second_Pass_Visitor'Class;
     UML_Element : not null access AMF.UML.Elements.UML_Element'Class)
       return not null AMF.CMOF.Elements.CMOF_Element_Access is
   begin
      return
        Self.Transformer.CMOF_Element.Element
         (AMF.Elements.Element_Access (UML_Element));
   end Resolve;

   -----------------------------
   -- To_CMOF_Visibility_Kind --
   -----------------------------

   function To_CMOF_Visibility_Kind
    (Item : AMF.UML.Optional_UML_Visibility_Kind)
       return AMF.CMOF.Optional_CMOF_Visibility_Kind is
   begin
      if Item.Is_Empty then
         return (Is_Empty => True);

      else
         case Item.Value is
            when AMF.UML.Public_Visibility =>
               return (False, AMF.CMOF.Public_Visibility);

            when AMF.UML.Private_Visibility =>
               return (False, AMF.CMOF.Private_Visibility);

            when AMF.UML.Protected_Visibility =>
               return (False, AMF.CMOF.Protected_Visibility);

            when AMF.UML.Package_Visibility =>
               return (False, AMF.CMOF.Package_Visibility);
         end case;
      end if;
   end To_CMOF_Visibility_Kind;

   ---------------
   -- Transform --
   ---------------

   procedure Transform
    (Source : not null AMF.URI_Stores.URI_Store_Access;
     Target : not null AMF.URI_Stores.URI_Store_Access)
   is
      Transformer : aliased UML_MOF_To_CMOF_Transformer;
      Iterator    : AMF.Visitors.UML_Containment.UML_Containment_Iterator;
      First_Pass  : First_Pass_Visitor (Transformer'Access);
      Second_Pass : Second_Pass_Visitor (Transformer'Access);

   begin
      Initialize (Transformer'Access, Target);
      Iterator.Visit (First_Pass, Source);
      Iterator.Visit (Second_Pass, Source);
   end Transform;

end AMF.Transformations.UML_MOF_To_CMOF;
