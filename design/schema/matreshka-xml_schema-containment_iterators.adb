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
with Matreshka.XML_Schema.AST.Attribute_Declarations;
with Matreshka.XML_Schema.AST.Attribute_Groups;
with Matreshka.XML_Schema.AST.Attribute_Uses;
with Matreshka.XML_Schema.AST.Assertions;
with Matreshka.XML_Schema.AST.Complex_Types;
with Matreshka.XML_Schema.AST.Element_Declarations;
with Matreshka.XML_Schema.AST.Identity_Constraints;
with Matreshka.XML_Schema.AST.Model_Groups;
with Matreshka.XML_Schema.AST.Models;
with Matreshka.XML_Schema.AST.Namespaces;
with Matreshka.XML_Schema.AST.Particles;
with Matreshka.XML_Schema.AST.Schemas;
with Matreshka.XML_Schema.AST.Type_Alternatives;
with Matreshka.XML_Schema.AST.Simple_Types;
with Matreshka.XML_Schema.AST.Types;
with Matreshka.XML_Schema.AST.Wildcards;

package body Matreshka.XML_Schema.Containment_Iterators is

   use type Matreshka.XML_Schema.Visitors.Traverse_Control;

   ---------------------------------
   -- Visit_Attribute_Declaration --
   ---------------------------------

   overriding procedure Visit_Attribute_Declaration
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Attribute_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
   is
      use type Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;
   begin
      if AST.Is_Empty (Node.Type_Name) and Node.Type_Definition /= null then
         Matreshka.XML_Schema.Visitors.Visit
           (Self,
            Visitor,
            Matreshka.XML_Schema.AST.Node_Access (Node.Type_Definition),
            Control);
      end if;
   end Visit_Attribute_Declaration;

   --------------------------------------
   -- Visit_Attribute_Group_Definition --
   --------------------------------------

   overriding procedure Visit_Attribute_Group_Definition
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    :
       not null Matreshka.XML_Schema.AST.Attribute_Group_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
   is
      use type Matreshka.XML_Schema.AST.Wildcard_Access;
   begin
      for Item of Node.Attribute_Uses loop
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Item),
           Control);

         exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
      end loop;

      --  Visit attribute wildcard.

      if Node.Attribute_Wildcard /= null then
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Node.Attribute_Wildcard),
           Control);
      end if;
   end Visit_Attribute_Group_Definition;

   -------------------------
   -- Visit_Attribute_Use --
   -------------------------

   overriding procedure Visit_Attribute_Use
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Attribute_Use_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
   is
      use type Matreshka.XML_Schema.AST.Attribute_Declaration_Access;
   begin
      if AST.Is_Empty (Node.Ref) and Node.Attribute_Declaration /= null then
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Node.Attribute_Declaration),
           Control);
      end if;
   end Visit_Attribute_Use;

   -----------------------------------
   -- Visit_Complex_Type_Definition --
   -----------------------------------

   overriding procedure Visit_Complex_Type_Definition
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    :
       not null Matreshka.XML_Schema.AST.Complex_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
   is
      use type Matreshka.XML_Schema.AST.Type_Definition_Access;
      use type Matreshka.XML_Schema.AST.Wildcard_Access;
   begin
      if AST.Is_Empty (Node.Restriction_Base)
        and AST.Is_Empty (Node.Extension_Base)
        and not Node.Any_Type_Restriction
        and Node.Base_Type_Definition /= null
      then
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Node.Base_Type_Definition),
           Control);
      end if;

      --  Visit attribute uses.

      for Item of Node.Attribute_Uses loop
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Item),
           Control);

         exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
      end loop;

      --  Visit attribute wildcard.

      if Node.Attribute_Wildcard /= null then
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Node.Attribute_Wildcard),
           Control);
      end if;

      --  Visit assertions.

      for Item of Node.Assertions loop
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Item),
           Control);

         exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
      end loop;
   end Visit_Complex_Type_Definition;

   -------------------------------
   -- Visit_Element_Declaration --
   -------------------------------

   overriding procedure Visit_Element_Declaration
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Element_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
   is
      use type Matreshka.XML_Schema.AST.Type_Definition_Access;
   begin
      if AST.Is_Empty (Node.Type_Name) and Node.Type_Definition /= null then
         Matreshka.XML_Schema.Visitors.Visit
           (Self,
            Visitor,
            Matreshka.XML_Schema.AST.Node_Access (Node.Type_Definition),
            Control);
      end if;

      if not Node.Type_Table.Is_Null then
         --  Visit sequence of Type Alternative components

         for Item of Node.Type_Table.Alternatives loop
            Matreshka.XML_Schema.Visitors.Visit
              (Self,
               Visitor,
               Matreshka.XML_Schema.AST.Node_Access (Item),
               Control);

            exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
         end loop;

         Matreshka.XML_Schema.Visitors.Visit
           (Self,
            Visitor,
            Matreshka.XML_Schema.AST.Node_Access
              (Node.Type_Table.Default_Type_Definition),
            Control);
      end if;

      --  Visit set of Identity-Constraint Definition components

      for Item of Node.Identity_Constraint_Definitions loop
         Matreshka.XML_Schema.Visitors.Visit
           (Self,
            Visitor,
            Matreshka.XML_Schema.AST.Node_Access (Item),
            Control);

         exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
      end loop;
   end Visit_Element_Declaration;

   -----------------
   -- Visit_Model --
   -----------------

   overriding procedure Visit_Model
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Model_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      --  Visit namespaces.

      for Item of Node.Namespaces loop
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Item),
           Control);

         exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
      end loop;
   end Visit_Model;

   -----------------------
   -- Visit_Model_Group --
   -----------------------

   overriding procedure Visit_Model_Group
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Model_Group_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      --  Visit particles.

      for Item of Node.Particles loop
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Item),
           Control);

         exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
      end loop;
   end Visit_Model_Group;

   ----------------------------------
   -- Visit_Model_Group_Definition --
   ----------------------------------

   overriding procedure Visit_Model_Group_Definition
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Model_Group_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      Matreshka.XML_Schema.Visitors.Visit
        (Self,
         Visitor,
         Matreshka.XML_Schema.AST.Node_Access (Node.Model_Group),
         Control);
   end Visit_Model_Group_Definition;

   ---------------------
   -- Visit_Namespace --
   ---------------------

   overriding procedure Visit_Namespace
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Namespace_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      --  Visit element declarations.

      for Item of Node.Element_Declarations loop
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Item),
           Control);

         exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
      end loop;
   end Visit_Namespace;

   --------------------
   -- Visit_Particle --
   --------------------

   overriding procedure Visit_Particle
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Particle_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
   is
      use type AST.Types.Term_Access;
   begin
      if AST.Is_Empty (Node.Element_Ref)
        and AST.Is_Empty (Node.Group_Ref)
        and Node.Term /= null
      then
         Matreshka.XML_Schema.Visitors.Visit
           (Self,
            Visitor,
            Matreshka.XML_Schema.AST.Node_Access (Node.Term),
            Control);
      end if;
   end Visit_Particle;

   ------------------
   -- Visit_Schema --
   ------------------

   overriding procedure Visit_Schema
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Schema_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      --  Visit type definitions.

      for Item of Node.Type_Definitions loop
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Item),
           Control);

         exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
      end loop;

      --  Visit element declarations.

      for Item of Node.Element_Declarations loop
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Item),
           Control);

         exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
      end loop;
   end Visit_Schema;

   ----------------------------------
   -- Visit_Simple_Type_Definition --
   ----------------------------------

   overriding procedure Visit_Simple_Type_Definition
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
   is
      use type Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;
      use type Matreshka.XML_Schema.AST.Type_Definition_Access;
      use type Matreshka.XML_Schema.AST.Wildcard_Access;
   begin
      if AST.Is_Empty (Node.Restriction_Base)
        and Node.Base_Type_Definition /= null
      then
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Node.Base_Type_Definition),
           Control);
      end if;

      --  Visit facets.

      for Item of Node.Facets loop
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Item),
           Control);

         exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
      end loop;

      --  Visit simple type definition
      if Node.Simple_Type_Definition /= null
      then
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Node.Simple_Type_Definition),
           Control);
      end if;

      --  Visit item type definition
      if AST.Is_Empty (Node.Item_Type)
        and Node.Item_Type_Definition /= null
      then
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Node.Item_Type_Definition),
           Control);
      end if;

      --  Visit member types.
      if Node.Member_Types.Is_Empty then
         for Item of Node.Member_Type_Definitions loop
            Matreshka.XML_Schema.Visitors.Visit
              (Self,
               Visitor,
               Matreshka.XML_Schema.AST.Node_Access (Item),
               Control);

            exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
         end loop;
      end if;
   end Visit_Simple_Type_Definition;

end Matreshka.XML_Schema.Containment_Iterators;
