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
with AMF.Elements;
with AMF.Internals.Element_Collections;
with AMF.Internals.Helpers;
with AMF.Internals.Tables.UML_Attributes;
with AMF.Visitors.UML_Iterators;
with AMF.Visitors.UML_Visitors;
with League.Strings.Internals;
with Matreshka.Internals.Strings;

package body AMF.Internals.UML_Activity_Partitions is

   -------------------
   -- Enter_Element --
   -------------------

   overriding procedure Enter_Element
    (Self    : not null access constant UML_Activity_Partition_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      if Visitor in AMF.Visitors.UML_Visitors.UML_Visitor'Class then
         AMF.Visitors.UML_Visitors.UML_Visitor'Class
          (Visitor).Enter_Activity_Partition
            (AMF.UML.Activity_Partitions.UML_Activity_Partition_Access (Self),
           Control);
      end if;
   end Enter_Element;

   -------------------
   -- Leave_Element --
   -------------------

   overriding procedure Leave_Element
    (Self    : not null access constant UML_Activity_Partition_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      if Visitor in AMF.Visitors.UML_Visitors.UML_Visitor'Class then
         AMF.Visitors.UML_Visitors.UML_Visitor'Class
          (Visitor).Leave_Activity_Partition
            (AMF.UML.Activity_Partitions.UML_Activity_Partition_Access (Self),
           Control);
      end if;
   end Leave_Element;

   -------------------
   -- Visit_Element --
   -------------------

   overriding procedure Visit_Element
    (Self     : not null access constant UML_Activity_Partition_Proxy;
     Iterator : in out AMF.Visitors.Abstract_Iterator'Class;
     Visitor  : in out AMF.Visitors.Abstract_Visitor'Class;
     Control  : in out AMF.Visitors.Traverse_Control) is
   begin
      if Iterator in AMF.Visitors.UML_Iterators.UML_Iterator'Class then
         AMF.Visitors.UML_Iterators.UML_Iterator'Class
          (Iterator).Visit_Activity_Partition
            (Visitor,
             AMF.UML.Activity_Partitions.UML_Activity_Partition_Access (Self),
             Control);
      end if;
   end Visit_Element;

   --------------
   -- Get_Edge --
   --------------

   overriding function Get_Edge
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Edges.Collections.Set_Of_UML_Activity_Edge is
   begin
      return
        AMF.UML.Activity_Edges.Collections.Wrap
         (AMF.Internals.Element_Collections.Wrap
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Edge
             (Self.Element)));
   end Get_Edge;

   ----------------------
   -- Get_Is_Dimension --
   ----------------------

   overriding function Get_Is_Dimension
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return Boolean is
   begin
      return
        AMF.Internals.Tables.UML_Attributes.Internal_Get_Is_Dimension
         (Self.Element);
   end Get_Is_Dimension;

   ----------------------
   -- Set_Is_Dimension --
   ----------------------

   overriding procedure Set_Is_Dimension
    (Self : not null access UML_Activity_Partition_Proxy;
     To   : Boolean) is
   begin
      AMF.Internals.Tables.UML_Attributes.Internal_Set_Is_Dimension
       (Self.Element, To);
   end Set_Is_Dimension;

   ---------------------
   -- Get_Is_External --
   ---------------------

   overriding function Get_Is_External
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return Boolean is
   begin
      return
        AMF.Internals.Tables.UML_Attributes.Internal_Get_Is_External
         (Self.Element);
   end Get_Is_External;

   ---------------------
   -- Set_Is_External --
   ---------------------

   overriding procedure Set_Is_External
    (Self : not null access UML_Activity_Partition_Proxy;
     To   : Boolean) is
   begin
      AMF.Internals.Tables.UML_Attributes.Internal_Set_Is_External
       (Self.Element, To);
   end Set_Is_External;

   --------------
   -- Get_Node --
   --------------

   overriding function Get_Node
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Nodes.Collections.Set_Of_UML_Activity_Node is
   begin
      return
        AMF.UML.Activity_Nodes.Collections.Wrap
         (AMF.Internals.Element_Collections.Wrap
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Node
             (Self.Element)));
   end Get_Node;

   --------------------
   -- Get_Represents --
   --------------------

   overriding function Get_Represents
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Elements.UML_Element_Access is
   begin
      return
        AMF.UML.Elements.UML_Element_Access
         (AMF.Internals.Helpers.To_Element
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Represents
             (Self.Element)));
   end Get_Represents;

   --------------------
   -- Set_Represents --
   --------------------

   overriding procedure Set_Represents
    (Self : not null access UML_Activity_Partition_Proxy;
     To   : AMF.UML.Elements.UML_Element_Access) is
   begin
      AMF.Internals.Tables.UML_Attributes.Internal_Set_Represents
       (Self.Element,
        AMF.Internals.Helpers.To_Element
         (AMF.Elements.Element_Access (To)));
   end Set_Represents;

   ----------------------
   -- Get_Subpartition --
   ----------------------

   overriding function Get_Subpartition
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Partitions.Collections.Set_Of_UML_Activity_Partition is
   begin
      return
        AMF.UML.Activity_Partitions.Collections.Wrap
         (AMF.Internals.Element_Collections.Wrap
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Subpartition
             (Self.Element)));
   end Get_Subpartition;

   -------------------------
   -- Get_Super_Partition --
   -------------------------

   overriding function Get_Super_Partition
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Partitions.UML_Activity_Partition_Access is
   begin
      return
        AMF.UML.Activity_Partitions.UML_Activity_Partition_Access
         (AMF.Internals.Helpers.To_Element
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Super_Partition
             (Self.Element)));
   end Get_Super_Partition;

   -------------------------
   -- Set_Super_Partition --
   -------------------------

   overriding procedure Set_Super_Partition
    (Self : not null access UML_Activity_Partition_Proxy;
     To   : AMF.UML.Activity_Partitions.UML_Activity_Partition_Access) is
   begin
      AMF.Internals.Tables.UML_Attributes.Internal_Set_Super_Partition
       (Self.Element,
        AMF.Internals.Helpers.To_Element
         (AMF.Elements.Element_Access (To)));
   end Set_Super_Partition;

   ------------------------
   -- Get_Contained_Edge --
   ------------------------

   overriding function Get_Contained_Edge
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Edges.Collections.Set_Of_UML_Activity_Edge is
   begin
      return
        AMF.UML.Activity_Edges.Collections.Wrap
         (AMF.Internals.Element_Collections.Wrap
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Contained_Edge
             (Self.Element)));
   end Get_Contained_Edge;

   ------------------------
   -- Get_Contained_Node --
   ------------------------

   overriding function Get_Contained_Node
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Nodes.Collections.Set_Of_UML_Activity_Node is
   begin
      return
        AMF.UML.Activity_Nodes.Collections.Wrap
         (AMF.Internals.Element_Collections.Wrap
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Contained_Node
             (Self.Element)));
   end Get_Contained_Node;

   ---------------------
   -- Get_In_Activity --
   ---------------------

   overriding function Get_In_Activity
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activities.UML_Activity_Access is
   begin
      return
        AMF.UML.Activities.UML_Activity_Access
         (AMF.Internals.Helpers.To_Element
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_In_Activity
             (Self.Element)));
   end Get_In_Activity;

   ---------------------
   -- Set_In_Activity --
   ---------------------

   overriding procedure Set_In_Activity
    (Self : not null access UML_Activity_Partition_Proxy;
     To   : AMF.UML.Activities.UML_Activity_Access) is
   begin
      AMF.Internals.Tables.UML_Attributes.Internal_Set_In_Activity
       (Self.Element,
        AMF.Internals.Helpers.To_Element
         (AMF.Elements.Element_Access (To)));
   end Set_In_Activity;

   ------------------
   -- Get_Subgroup --
   ------------------

   overriding function Get_Subgroup
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Groups.Collections.Set_Of_UML_Activity_Group is
   begin
      return
        AMF.UML.Activity_Groups.Collections.Wrap
         (AMF.Internals.Element_Collections.Wrap
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Subgroup
             (Self.Element)));
   end Get_Subgroup;

   ---------------------
   -- Get_Super_Group --
   ---------------------

   overriding function Get_Super_Group
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Groups.UML_Activity_Group_Access is
   begin
      return
        AMF.UML.Activity_Groups.UML_Activity_Group_Access
         (AMF.Internals.Helpers.To_Element
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Super_Group
             (Self.Element)));
   end Get_Super_Group;

   ---------------------------
   -- Get_Client_Dependency --
   ---------------------------

   overriding function Get_Client_Dependency
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Dependencies.Collections.Set_Of_UML_Dependency is
   begin
      return
        AMF.UML.Dependencies.Collections.Wrap
         (AMF.Internals.Element_Collections.Wrap
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Client_Dependency
             (Self.Element)));
   end Get_Client_Dependency;

   -------------------------
   -- Get_Name_Expression --
   -------------------------

   overriding function Get_Name_Expression
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.String_Expressions.UML_String_Expression_Access is
   begin
      return
        AMF.UML.String_Expressions.UML_String_Expression_Access
         (AMF.Internals.Helpers.To_Element
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Name_Expression
             (Self.Element)));
   end Get_Name_Expression;

   -------------------------
   -- Set_Name_Expression --
   -------------------------

   overriding procedure Set_Name_Expression
    (Self : not null access UML_Activity_Partition_Proxy;
     To   : AMF.UML.String_Expressions.UML_String_Expression_Access) is
   begin
      AMF.Internals.Tables.UML_Attributes.Internal_Set_Name_Expression
       (Self.Element,
        AMF.Internals.Helpers.To_Element
         (AMF.Elements.Element_Access (To)));
   end Set_Name_Expression;

   -------------------
   -- Get_Namespace --
   -------------------

   overriding function Get_Namespace
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Namespaces.UML_Namespace_Access is
   begin
      return
        AMF.UML.Namespaces.UML_Namespace_Access
         (AMF.Internals.Helpers.To_Element
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Namespace
             (Self.Element)));
   end Get_Namespace;

   ------------------------
   -- Get_Qualified_Name --
   ------------------------

   overriding function Get_Qualified_Name
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.Optional_String is
   begin
      declare
         use type Matreshka.Internals.Strings.Shared_String_Access;

         Aux : constant Matreshka.Internals.Strings.Shared_String_Access
           := AMF.Internals.Tables.UML_Attributes.Internal_Get_Qualified_Name (Self.Element);

      begin
         if Aux = null then
            return (Is_Empty => True);

         else
            return (False, League.Strings.Internals.Create (Aux));
         end if;
      end;
   end Get_Qualified_Name;

   -------------------------
   -- All_Owning_Packages --
   -------------------------

   overriding function All_Owning_Packages
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Packages.Collections.Set_Of_UML_Package is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "All_Owning_Packages unimplemented");
      raise Program_Error with "Unimplemented procedure UML_Activity_Partition_Proxy.All_Owning_Packages";
      return All_Owning_Packages (Self);
   end All_Owning_Packages;

   -----------------------------
   -- Is_Distinguishable_From --
   -----------------------------

   overriding function Is_Distinguishable_From
    (Self : not null access constant UML_Activity_Partition_Proxy;
     N : AMF.UML.Named_Elements.UML_Named_Element_Access;
     Ns : AMF.UML.Namespaces.UML_Namespace_Access)
       return Boolean is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Is_Distinguishable_From unimplemented");
      raise Program_Error with "Unimplemented procedure UML_Activity_Partition_Proxy.Is_Distinguishable_From";
      return Is_Distinguishable_From (Self, N, Ns);
   end Is_Distinguishable_From;

   ---------------
   -- Namespace --
   ---------------

   overriding function Namespace
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Namespaces.UML_Namespace_Access is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Namespace unimplemented");
      raise Program_Error with "Unimplemented procedure UML_Activity_Partition_Proxy.Namespace";
      return Namespace (Self);
   end Namespace;

end AMF.Internals.UML_Activity_Partitions;