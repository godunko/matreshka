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
with AMF.Internals.UML_Named_Elements;
with AMF.UML.Activities;
with AMF.UML.Activity_Edges.Collections;
with AMF.UML.Activity_Groups.Collections;
with AMF.UML.Activity_Nodes.Collections;
with AMF.UML.Activity_Partitions.Collections;
with AMF.UML.Dependencies.Collections;
with AMF.UML.Elements;
with AMF.UML.Named_Elements;
with AMF.UML.Namespaces;
with AMF.UML.Packages.Collections;
with AMF.UML.String_Expressions;
with AMF.Visitors;

package AMF.Internals.UML_Activity_Partitions is

   type UML_Activity_Partition_Proxy is
     limited new AMF.Internals.UML_Named_Elements.UML_Named_Element_Proxy
       and AMF.UML.Activity_Partitions.UML_Activity_Partition with null record;

   overriding function Get_Edge
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Edges.Collections.Set_Of_UML_Activity_Edge;
   --  Getter of ActivityPartition::edge.
   --
   --  Edges immediately contained in the group.

   overriding function Get_Is_Dimension
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return Boolean;
   --  Getter of ActivityPartition::isDimension.
   --
   --  Tells whether the partition groups other partitions along a dimension.

   overriding procedure Set_Is_Dimension
    (Self : not null access UML_Activity_Partition_Proxy;
     To   : Boolean);
   --  Setter of ActivityPartition::isDimension.
   --
   --  Tells whether the partition groups other partitions along a dimension.

   overriding function Get_Is_External
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return Boolean;
   --  Getter of ActivityPartition::isExternal.
   --
   --  Tells whether the partition represents an entity to which the
   --  partitioning structure does not apply.

   overriding procedure Set_Is_External
    (Self : not null access UML_Activity_Partition_Proxy;
     To   : Boolean);
   --  Setter of ActivityPartition::isExternal.
   --
   --  Tells whether the partition represents an entity to which the
   --  partitioning structure does not apply.

   overriding function Get_Node
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Nodes.Collections.Set_Of_UML_Activity_Node;
   --  Getter of ActivityPartition::node.
   --
   --  Nodes immediately contained in the group.

   overriding function Get_Represents
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Elements.UML_Element_Access;
   --  Getter of ActivityPartition::represents.
   --
   --  An element constraining behaviors invoked by nodes in the partition.

   overriding procedure Set_Represents
    (Self : not null access UML_Activity_Partition_Proxy;
     To   : AMF.UML.Elements.UML_Element_Access);
   --  Setter of ActivityPartition::represents.
   --
   --  An element constraining behaviors invoked by nodes in the partition.

   overriding function Get_Subpartition
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Partitions.Collections.Set_Of_UML_Activity_Partition;
   --  Getter of ActivityPartition::subpartition.
   --
   --  Partitions immediately contained in the partition.

   overriding function Get_Super_Partition
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Partitions.UML_Activity_Partition_Access;
   --  Getter of ActivityPartition::superPartition.
   --
   --  Partition immediately containing the partition.

   overriding procedure Set_Super_Partition
    (Self : not null access UML_Activity_Partition_Proxy;
     To   : AMF.UML.Activity_Partitions.UML_Activity_Partition_Access);
   --  Setter of ActivityPartition::superPartition.
   --
   --  Partition immediately containing the partition.

   overriding function Get_Contained_Edge
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Edges.Collections.Set_Of_UML_Activity_Edge;
   --  Getter of ActivityGroup::containedEdge.
   --
   --  Edges immediately contained in the group.

   overriding function Get_Contained_Node
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Nodes.Collections.Set_Of_UML_Activity_Node;
   --  Getter of ActivityGroup::containedNode.
   --
   --  Nodes immediately contained in the group.

   overriding function Get_In_Activity
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activities.UML_Activity_Access;
   --  Getter of ActivityGroup::inActivity.
   --
   --  Activity containing the group.

   overriding procedure Set_In_Activity
    (Self : not null access UML_Activity_Partition_Proxy;
     To   : AMF.UML.Activities.UML_Activity_Access);
   --  Setter of ActivityGroup::inActivity.
   --
   --  Activity containing the group.

   overriding function Get_Subgroup
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Groups.Collections.Set_Of_UML_Activity_Group;
   --  Getter of ActivityGroup::subgroup.
   --
   --  Groups immediately contained in the group.

   overriding function Get_Super_Group
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Activity_Groups.UML_Activity_Group_Access;
   --  Getter of ActivityGroup::superGroup.
   --
   --  Group immediately containing the group.

   overriding function Get_Client_Dependency
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Dependencies.Collections.Set_Of_UML_Dependency;
   --  Getter of NamedElement::clientDependency.
   --
   --  Indicates the dependencies that reference the client.

   overriding function Get_Name_Expression
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.String_Expressions.UML_String_Expression_Access;
   --  Getter of NamedElement::nameExpression.
   --
   --  The string expression used to define the name of this named element.

   overriding procedure Set_Name_Expression
    (Self : not null access UML_Activity_Partition_Proxy;
     To   : AMF.UML.String_Expressions.UML_String_Expression_Access);
   --  Setter of NamedElement::nameExpression.
   --
   --  The string expression used to define the name of this named element.

   overriding function Get_Namespace
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Namespaces.UML_Namespace_Access;
   --  Getter of NamedElement::namespace.
   --
   --  Specifies the namespace that owns the NamedElement.

   overriding function Get_Qualified_Name
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.Optional_String;
   --  Getter of NamedElement::qualifiedName.
   --
   --  A name which allows the NamedElement to be identified within a
   --  hierarchy of nested Namespaces. It is constructed from the names of the
   --  containing namespaces starting at the root of the hierarchy and ending
   --  with the name of the NamedElement itself.

   overriding function All_Owning_Packages
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Packages.Collections.Set_Of_UML_Package;
   --  Operation NamedElement::allOwningPackages.
   --
   --  The query allOwningPackages() returns all the directly or indirectly
   --  owning packages.

   overriding function Is_Distinguishable_From
    (Self : not null access constant UML_Activity_Partition_Proxy;
     N : AMF.UML.Named_Elements.UML_Named_Element_Access;
     Ns : AMF.UML.Namespaces.UML_Namespace_Access)
       return Boolean;
   --  Operation NamedElement::isDistinguishableFrom.
   --
   --  The query isDistinguishableFrom() determines whether two NamedElements
   --  may logically co-exist within a Namespace. By default, two named
   --  elements are distinguishable if (a) they have unrelated types or (b)
   --  they have related types but different names.

   overriding function Namespace
    (Self : not null access constant UML_Activity_Partition_Proxy)
       return AMF.UML.Namespaces.UML_Namespace_Access;
   --  Operation NamedElement::namespace.
   --
   --  Missing derivation for NamedElement::/namespace : Namespace

   overriding procedure Enter_Element
    (Self    : not null access constant UML_Activity_Partition_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Leave_Element
    (Self    : not null access constant UML_Activity_Partition_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Visit_Element
    (Self     : not null access constant UML_Activity_Partition_Proxy;
     Iterator : in out AMF.Visitors.Abstract_Iterator'Class;
     Visitor  : in out AMF.Visitors.Abstract_Visitor'Class;
     Control  : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

end AMF.Internals.UML_Activity_Partitions;
