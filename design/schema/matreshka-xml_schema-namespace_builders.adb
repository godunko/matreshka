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
-- Copyright © 2012-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
with Matreshka.XML_Schema.AST.Complex_Types;
with Matreshka.XML_Schema.AST.Element_Declarations;
with Matreshka.XML_Schema.AST.Model_Groups;
with Matreshka.XML_Schema.AST.Namespaces;
with Matreshka.XML_Schema.AST.Schemas;
with Matreshka.XML_Schema.AST.Simple_Types;
with Matreshka.XML_Schema.AST.Types;

package body Matreshka.XML_Schema.Namespace_Builders is

   ---------------------------------
   -- Enter_Attribute_Declaration --
   ---------------------------------

   overriding procedure Enter_Attribute_Declaration
    (Self    : in out Namespace_Builder;
     Node    : not null Matreshka.XML_Schema.AST.Attribute_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
   is
      use type Matreshka.XML_Schema.AST.Types.Scope_Variety;
   begin
      if Node.Scope.Variety = AST.Types.Global then
         Self.Namespace.Attribute_Declarations.Insert (Node.Name, Node);
      end if;
   end Enter_Attribute_Declaration;

   --------------------------------------
   -- Enter_Attribute_Group_Definition --
   --------------------------------------

   overriding procedure Enter_Attribute_Group_Definition
    (Self    : in out Namespace_Builder;
     Node    :
       not null Matreshka.XML_Schema.AST.Attribute_Group_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      Self.Namespace.Attribute_Group_Definitions.Insert (Node.Name, Node);
   end Enter_Attribute_Group_Definition;

   -----------------------------------
   -- Enter_Complex_Type_Definition --
   -----------------------------------

   overriding procedure Enter_Complex_Type_Definition
    (Self    : in out Namespace_Builder;
     Node    :
       not null Matreshka.XML_Schema.AST.Complex_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      --  XXX Only global type definitions must be processed.

      --  Global type definition has name

      if not Node.Name.Is_Empty then
         Self.Namespace.Type_Definitions.Insert
           (Node.Name, Matreshka.XML_Schema.AST.Type_Definition_Access (Node));
         Node.Namespace := Self.Namespace;
      end if;
   end Enter_Complex_Type_Definition;

   -------------------------------
   -- Enter_Element_Declaration --
   -------------------------------

   overriding procedure Enter_Element_Declaration
    (Self    : in out Namespace_Builder;
     Node    : not null Matreshka.XML_Schema.AST.Element_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
   is
      use type Matreshka.XML_Schema.AST.Types.Scope_Variety;
   begin
      if Node.Scope.Variety = AST.Types.Global then
         Self.Namespace.Element_Declarations.Insert (Node.Name, Node);
      end if;
   end Enter_Element_Declaration;

   ----------------------------------
   -- Enter_Model_Group_Definition --
   ----------------------------------

   overriding procedure Enter_Model_Group_Definition
    (Self    : in out Namespace_Builder;
     Node    : not null Matreshka.XML_Schema.AST.Model_Group_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      Self.Namespace.Model_Group_Definitions.Insert (Node.Name, Node);
   end Enter_Model_Group_Definition;

   ------------------
   -- Enter_Schema --
   ------------------

   overriding procedure Enter_Schema
    (Self    : in out Namespace_Builder;
     Node    : not null Matreshka.XML_Schema.AST.Schema_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      Self.Namespace :=
        new Matreshka.XML_Schema.AST.Namespaces.Namespace_Node'
             (Namespace_URI          => Node.Target_Namespace,
              Type_Definitions       => <>,
              Element_Declarations   => <>,
              Attribute_Declarations => <>,
              Attribute_Group_Definitions => <>,
              Model_Group_Definitions     => <>);
   end Enter_Schema;

   ----------------------------------
   -- Enter_Simple_Type_Definition --
   ----------------------------------

   overriding procedure Enter_Simple_Type_Definition
    (Self    : in out Namespace_Builder;
     Node    : not null Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      --  XXX Only global type definitions must be processed.

      --  Global type definition has name
      if not Node.Name.Is_Empty then
         Self.Namespace.Type_Definitions.Insert
           (Node.Name, Matreshka.XML_Schema.AST.Type_Definition_Access (Node));
      end if;
   end Enter_Simple_Type_Definition;

   -------------------
   -- Get_Namespace --
   -------------------

   function Get_Namespace
    (Self : Namespace_Builder'Class)
       return Matreshka.XML_Schema.AST.Namespace_Access is
   begin
      return Self.Namespace;
   end Get_Namespace;

end Matreshka.XML_Schema.Namespace_Builders;
