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
with AMF.Internals.Tables.CMOF_Attributes;
with AMF.Internals.Element_Collections;
with AMF.Visitors.CMOF_Iterators;
with AMF.Visitors.CMOF_Visitors;

package body AMF.Internals.CMOF_Data_Types is

   use AMF.Internals.Tables.CMOF_Attributes;

   -------------------
   -- Enter_Element --
   -------------------

   overriding procedure Enter_Element
    (Self    : not null access constant CMOF_Data_Type_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      if Visitor in AMF.Visitors.CMOF_Visitors.CMOF_Visitor'Class then
         AMF.Visitors.CMOF_Visitors.CMOF_Visitor'Class
          (Visitor).Enter_Data_Type
            (AMF.CMOF.Data_Types.CMOF_Data_Type_Access (Self),
           Control);
      end if;
   end Enter_Element;

   -------------------------
   -- Get_Owned_Attribute --
   -------------------------

   overriding function Get_Owned_Attribute
    (Self : not null access constant CMOF_Data_Type_Proxy)
       return AMF.CMOF.Properties.Collections.Ordered_Set_Of_CMOF_Property is
   begin
      return
        AMF.CMOF.Properties.Collections.Wrap
         (AMF.Internals.Element_Collections.Wrap
           (Internal_Get_Owned_Attribute (Self.Element)));
   end Get_Owned_Attribute;

   -------------------------
   -- Get_Owned_Operation --
   -------------------------

   overriding function Get_Owned_Operation
    (Self : not null access constant CMOF_Data_Type_Proxy)
       return AMF.CMOF.Operations.Collections.Ordered_Set_Of_CMOF_Operation is
   begin
      return
        AMF.CMOF.Operations.Collections.Wrap
         (AMF.Internals.Element_Collections.Wrap
           (Internal_Get_Owned_Operation (Self.Element)));
   end Get_Owned_Operation;

   -------------------
   -- Leave_Element --
   -------------------

   overriding procedure Leave_Element
    (Self    : not null access constant CMOF_Data_Type_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      if Visitor in AMF.Visitors.CMOF_Visitors.CMOF_Visitor'Class then
         AMF.Visitors.CMOF_Visitors.CMOF_Visitor'Class
          (Visitor).Leave_Data_Type
            (AMF.CMOF.Data_Types.CMOF_Data_Type_Access (Self),
           Control);
      end if;
   end Leave_Element;

   -------------------
   -- Visit_Element --
   -------------------

   overriding procedure Visit_Element
    (Self     : not null access constant CMOF_Data_Type_Proxy;
     Iterator : in out AMF.Visitors.Abstract_Iterator'Class;
     Visitor  : in out AMF.Visitors.Abstract_Visitor'Class;
     Control  : in out AMF.Visitors.Traverse_Control) is
   begin
      if Iterator in AMF.Visitors.CMOF_Iterators.CMOF_Iterator'Class then
         AMF.Visitors.CMOF_Iterators.CMOF_Iterator'Class
          (Iterator).Visit_Data_Type
            (Visitor,
             AMF.CMOF.Data_Types.CMOF_Data_Type_Access (Self),
             Control);
      end if;
   end Visit_Element;

   ------------------------
   -- All_Owned_Elements --
   ------------------------

   overriding function All_Owned_Elements
     (Self : not null access constant CMOF_Data_Type_Proxy)
      return AMF.CMOF.Elements.Collections.Set_Of_CMOF_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "All_Owned_Elements unimplemented");
      raise Program_Error;
      return All_Owned_Elements (Self);
   end All_Owned_Elements;

   ------------------------
   -- Get_Qualified_Name --
   ------------------------

   overriding function Get_Qualified_Name
     (Self : not null access constant CMOF_Data_Type_Proxy)
      return Optional_String
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Qualified_Name unimplemented");
      raise Program_Error;
      return Get_Qualified_Name (Self);
   end Get_Qualified_Name;

   -----------------------------
   -- Is_Distinguishable_From --
   -----------------------------

   overriding function Is_Distinguishable_From
     (Self : not null access constant CMOF_Data_Type_Proxy;
      N : AMF.CMOF.Named_Elements.CMOF_Named_Element_Access;
      Ns : AMF.CMOF.Namespaces.CMOF_Namespace_Access)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Is_Distinguishable_From unimplemented");
      raise Program_Error;
      return Is_Distinguishable_From (Self, N, Ns);
   end Is_Distinguishable_From;

   -----------------
   -- Set_Package --
   -----------------

   overriding procedure Set_Package
     (Self : not null access CMOF_Data_Type_Proxy;
      To   : AMF.CMOF.Packages.CMOF_Package_Access)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Package unimplemented");
      raise Program_Error;
   end Set_Package;

   ---------------------
   -- Imported_Member --
   ---------------------

   overriding function Imported_Member
     (Self : not null access constant CMOF_Data_Type_Proxy)
      return AMF.CMOF.Packageable_Elements.Collections.Set_Of_CMOF_Packageable_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Imported_Member unimplemented");
      raise Program_Error;
      return Imported_Member (Self);
   end Imported_Member;

   -------------------------
   -- Get_Names_Of_Member --
   -------------------------

   overriding function Get_Names_Of_Member
    (Self : not null access constant CMOF_Data_Type_Proxy;
     Element : AMF.CMOF.Named_Elements.CMOF_Named_Element_Access)
       return AMF.String_Collections.Set_Of_String is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Names_Of_Member unimplemented");
      raise Program_Error;
      return Get_Names_Of_Member (Self, Element);
   end Get_Names_Of_Member;

   --------------------
   -- Import_Members --
   --------------------

   overriding function Import_Members
     (Self : not null access constant CMOF_Data_Type_Proxy;
      Imps : AMF.CMOF.Packageable_Elements.Collections.Set_Of_CMOF_Packageable_Element)
      return AMF.CMOF.Packageable_Elements.Collections.Set_Of_CMOF_Packageable_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Import_Members unimplemented");
      raise Program_Error;
      return Import_Members (Self, Imps);
   end Import_Members;

   ------------------------
   -- Exclude_Collisions --
   ------------------------

   overriding function Exclude_Collisions
     (Self : not null access constant CMOF_Data_Type_Proxy;
      Imps : AMF.CMOF.Packageable_Elements.Collections.Set_Of_CMOF_Packageable_Element)
      return AMF.CMOF.Packageable_Elements.Collections.Set_Of_CMOF_Packageable_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Exclude_Collisions unimplemented");
      raise Program_Error;
      return Exclude_Collisions (Self, Imps);
   end Exclude_Collisions;

   ---------------------------------
   -- Members_Are_Distinguishable --
   ---------------------------------

   overriding function Members_Are_Distinguishable
     (Self : not null access constant CMOF_Data_Type_Proxy)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Members_Are_Distinguishable unimplemented");
      raise Program_Error;
      return Members_Are_Distinguishable (Self);
   end Members_Are_Distinguishable;

   ---------------------------------
   -- Set_Is_Final_Specialization --
   ---------------------------------

   overriding procedure Set_Is_Final_Specialization
     (Self : not null access CMOF_Data_Type_Proxy;
      To   : Boolean)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Is_Final_Specialization unimplemented");
      raise Program_Error;
   end Set_Is_Final_Specialization;

   -----------------
   -- Conforms_To --
   -----------------

   overriding function Conforms_To
     (Self : not null access constant CMOF_Data_Type_Proxy;
      Other : AMF.CMOF.Classifiers.CMOF_Classifier_Access)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Conforms_To unimplemented");
      raise Program_Error;
      return Conforms_To (Self, Other);
   end Conforms_To;

   ------------------
   -- All_Features --
   ------------------

   overriding function All_Features
     (Self : not null access constant CMOF_Data_Type_Proxy)
      return AMF.CMOF.Features.Collections.Set_Of_CMOF_Feature
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "All_Features unimplemented");
      raise Program_Error;
      return All_Features (Self);
   end All_Features;

   -------------
   -- General --
   -------------

   overriding function General
     (Self : not null access constant CMOF_Data_Type_Proxy)
      return AMF.CMOF.Classifiers.Collections.Set_Of_CMOF_Classifier
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "General unimplemented");
      raise Program_Error;
      return General (Self);
   end General;

   -------------
   -- Parents --
   -------------

   overriding function Parents
     (Self : not null access constant CMOF_Data_Type_Proxy)
      return AMF.CMOF.Classifiers.Collections.Set_Of_CMOF_Classifier
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Parents unimplemented");
      raise Program_Error;
      return Parents (Self);
   end Parents;

   ----------------------
   -- Inherited_Member --
   ----------------------

   overriding function Inherited_Member
     (Self : not null access constant CMOF_Data_Type_Proxy)
      return AMF.CMOF.Named_Elements.Collections.Set_Of_CMOF_Named_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Inherited_Member unimplemented");
      raise Program_Error;
      return Inherited_Member (Self);
   end Inherited_Member;

   -----------------
   -- All_Parents --
   -----------------

   overriding function All_Parents
     (Self : not null access constant CMOF_Data_Type_Proxy)
      return AMF.CMOF.Classifiers.Collections.Set_Of_CMOF_Classifier
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "All_Parents unimplemented");
      raise Program_Error;
      return All_Parents (Self);
   end All_Parents;

   -------------------------
   -- Inheritable_Members --
   -------------------------

   overriding function Inheritable_Members
     (Self : not null access constant CMOF_Data_Type_Proxy;
      C : AMF.CMOF.Classifiers.CMOF_Classifier_Access)
      return AMF.CMOF.Named_Elements.Collections.Set_Of_CMOF_Named_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Inheritable_Members unimplemented");
      raise Program_Error;
      return Inheritable_Members (Self, C);
   end Inheritable_Members;

   -----------------------
   -- Has_Visibility_Of --
   -----------------------

   overriding function Has_Visibility_Of
     (Self : not null access constant CMOF_Data_Type_Proxy;
      N : AMF.CMOF.Named_Elements.CMOF_Named_Element_Access)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Has_Visibility_Of unimplemented");
      raise Program_Error;
      return Has_Visibility_Of (Self, N);
   end Has_Visibility_Of;

   -------------
   -- Inherit --
   -------------

   overriding function Inherit
     (Self : not null access constant CMOF_Data_Type_Proxy;
      Inhs : AMF.CMOF.Named_Elements.Collections.Set_Of_CMOF_Named_Element)
      return AMF.CMOF.Named_Elements.Collections.Set_Of_CMOF_Named_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Inherit unimplemented");
      raise Program_Error;
      return Inherit (Self, Inhs);
   end Inherit;

   -------------------------
   -- May_Specialize_Type --
   -------------------------

   overriding function May_Specialize_Type
     (Self : not null access constant CMOF_Data_Type_Proxy;
      C : AMF.CMOF.Classifiers.CMOF_Classifier_Access)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "May_Specialize_Type unimplemented");
      raise Program_Error;
      return May_Specialize_Type (Self, C);
   end May_Specialize_Type;

end AMF.Internals.CMOF_Data_Types;
