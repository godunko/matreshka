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
with Ada.Wide_Wide_Text_IO;

with Matreshka.XML_Schema.AST.Attribute_Declarations;
with Matreshka.XML_Schema.AST.Attribute_Uses;
with Matreshka.XML_Schema.AST.Element_Declarations;
with Matreshka.XML_Schema.AST.Complex_Types;
with Matreshka.XML_Schema.AST.Constraining_Facets;
with Matreshka.XML_Schema.AST.Models;
with Matreshka.XML_Schema.AST.Namespaces;
with Matreshka.XML_Schema.AST.Particles;
with Matreshka.XML_Schema.AST.Simple_Types;
with Matreshka.XML_Schema.AST.Types;

package body Matreshka.XML_Schema.Name_Resolvers is

   ---------------------------------
   -- Enter_Attribute_Declaration --
   ---------------------------------

   overriding procedure Enter_Attribute_Declaration
    (Self    : in out Name_Resolver;
     Node    : not null Matreshka.XML_Schema.AST.Attribute_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
   is
      use type Matreshka.XML_Schema.AST.Types.Scope_Variety;
      use type Matreshka.XML_Schema.AST.Type_Definition_Access;
      use type Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;

      Type_Definition : Matreshka.XML_Schema.AST.Type_Definition_Access;
   begin
      if AST.Is_Empty (Node.Type_Name) then
         if Node.Type_Definition = null then
            --  XXX  default ·xs:anySimpleType· not implemented yet
            Ada.Wide_Wide_Text_IO.Put_Line
              ("Name_Resolver Attribute_Declaration no type for attr for '"
               & Node.Name.To_Wide_Wide_String & "' !!!");
--            raise Program_Error;
         end if;
      else
         -- XXX should we check Node.Type_Definition = null here?

         Type_Definition := Self.Resolve_Type (Node.Type_Name);

         Node.Type_Definition := Self.Resolve_Simple_Type (Node.Type_Name);
      end if;
   end Enter_Attribute_Declaration;

   -------------------------
   -- Enter_Attribute_Use --
   -------------------------

   overriding procedure Enter_Attribute_Use
    (Self    : in out Name_Resolver;
     Node    : not null Matreshka.XML_Schema.AST.Attribute_Use_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      if not AST.Is_Empty (Node.Ref) then
         -- XXX should we check Node.Attribute_Declaration = null here?
         Node.Attribute_Declaration := Self.Resolve_Attribute (Node.Ref);
      end if;
   end Enter_Attribute_Use;

   -----------------------------------
   -- Enter_Complex_Type_Definition --
   -----------------------------------

   overriding procedure Enter_Complex_Type_Definition
    (Self    : in out Name_Resolver;
     Node    :
       not null Matreshka.XML_Schema.AST.Complex_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      if not AST.Is_Empty (Node.Restriction_Base) then
         -- XXX should we check Node.Base_Type_Definition = null here?
         Node.Base_Type_Definition :=
           Self.Resolve_Type (Node.Restriction_Base);
      elsif not AST.Is_Empty (Node.Extension_Base) then
         -- XXX should we check Node.Base_Type_Definition = null here?
         Node.Base_Type_Definition :=
           Self.Resolve_Type (Node.Extension_Base);
      end if;
   end Enter_Complex_Type_Definition;

   -------------------------------
   -- Enter_Element_Declaration --
   -------------------------------

   overriding procedure Enter_Element_Declaration
    (Self    : in out Name_Resolver;
     Node    : not null Matreshka.XML_Schema.AST.Element_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
   is
      use type Matreshka.XML_Schema.AST.Types.Scope_Variety;
      use type Matreshka.XML_Schema.AST.Type_Definition_Access;

   begin
      if Node.Type_Definition = null
        and then not (Node.Type_Name.Namespace_URI.Is_Empty
                      and Node.Type_Name.Local_Name.Is_Empty)
      then
         --  Type of element declaration is not defined inside
         --  element declaration itself and need to be resolved when 'type'
         --  attribute is present.
         --
         --  XXX Check for namespaceURI is added to process 'facet' element
         --  decalration only. Can non-abstract element declarations be used
         --  without type declaration?

         Ada.Wide_Wide_Text_IO.Put_Line (Node.Name.To_Wide_Wide_String);

         Node.Type_Definition := Self.Resolve_Type (Node.Type_Name);
      end if;
   end Enter_Element_Declaration;

   -----------------------
   -- Enter_Enumeration --
   -----------------------

   overriding procedure Enter_Enumeration
    (Self    : in out Name_Resolver;
     Node    : not null Matreshka.XML_Schema.AST.Enumeration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      Self.STD.Lexical_Enumeration.Append (Node.Value);
   end Enter_Enumeration;

   -----------------
   -- Enter_Model --
   -----------------

   overriding procedure Enter_Model
    (Self    : in out Name_Resolver;
     Node    : not null Matreshka.XML_Schema.AST.Model_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      Self.Model := Node;
   end Enter_Model;

   --------------------
   -- Enter_Particle --
   --------------------

   overriding procedure Enter_Particle
    (Self    : in out Name_Resolver;
     Node    : not null Matreshka.XML_Schema.AST.Particle_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
   is
      Element : Matreshka.XML_Schema.AST.Element_Declaration_Access;
   begin
      if not AST.Is_Empty (Node.Element_Ref) then
         -- XXX should we check Node.Term = null here?

         Element := Self.Resolve_Element (Node.Element_Ref);
         Node.Term := AST.Types.Term_Access (Element);
      end if;
   end Enter_Particle;

   ----------------------------------
   -- Enter_Simple_Type_Definition --
   ----------------------------------

   overriding procedure Enter_Simple_Type_Definition
    (Self    : in out Name_Resolver;
     Node    : not null Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
   is
      Type_Definition : Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;
   begin
      if not AST.Is_Empty (Node.Restriction_Base) then
         -- XXX should we check Node.Base_Type_Definition = null here?
         Node.Base_Type_Definition :=
           Self.Resolve_Type (Node.Restriction_Base);
      end if;

      for Item of Node.Member_Types loop
         Type_Definition := Self.Resolve_Simple_Type (Item);
         Node.Member_Type_Definitions.Append
           (Matreshka.XML_Schema.AST.Object_Access (Type_Definition));
      end loop;

      if not AST.Is_Empty (Node.Item_Type) then
         Node.Item_Type_Definition :=
           Self.Resolve_Simple_Type (Node.Item_Type);
      end if;

      Self.STD := Node;
   end Enter_Simple_Type_Definition;

   -----------------------
   -- Resolve_Attribute --
   -----------------------

   not overriding function Resolve_Attribute
    (Self    : in out Name_Resolver;
     Name    : Matreshka.XML_Schema.AST.Qualified_Name)
     return Matreshka.XML_Schema.AST.Attribute_Declaration_Access
   is
      use type Matreshka.XML_Schema.AST.Namespace_Access;
      use type Matreshka.XML_Schema.AST.Attribute_Declaration_Access;

      Result    : Matreshka.XML_Schema.AST.Attribute_Declaration_Access;
      Namespace : constant Matreshka.XML_Schema.AST.Namespace_Access :=
        Self.Model.Get_Namespace (Name.Namespace_URI);
   begin
      Ada.Wide_Wide_Text_IO.Put_Line
        ('('
         & Name.Namespace_URI.To_Wide_Wide_String
         & ')'
         & Name.Local_Name.To_Wide_Wide_String);

      if Namespace = null then
         raise Program_Error;
      end if;

      Result := Namespace.Get_Attribute_Declaration (Name.Local_Name);

      if Result = null then
         raise Program_Error;
      end if;

      return Result;
   end Resolve_Attribute;

   ---------------------
   -- Resolve_Element --
   ---------------------

   not overriding function Resolve_Element
    (Self    : in out Name_Resolver;
     Name    : Matreshka.XML_Schema.AST.Qualified_Name)
     return Matreshka.XML_Schema.AST.Element_Declaration_Access
   is
      use type Matreshka.XML_Schema.AST.Namespace_Access;
      use type Matreshka.XML_Schema.AST.Element_Declaration_Access;

      Result    : Matreshka.XML_Schema.AST.Element_Declaration_Access;
      Namespace : constant Matreshka.XML_Schema.AST.Namespace_Access :=
        Self.Model.Get_Namespace (Name.Namespace_URI);
   begin
      Ada.Wide_Wide_Text_IO.Put_Line
        ('<'
         & Name.Namespace_URI.To_Wide_Wide_String
         & '>'
         & Name.Local_Name.To_Wide_Wide_String);

      if Namespace = null then
         raise Program_Error;
      end if;

      Result := Namespace.Get_Element_Declaration (Name.Local_Name);

      if Result = null then
         raise Program_Error;
      end if;

      return Result;
   end Resolve_Element;

   -------------------------
   -- Resolve_Simple_Type --
   -------------------------

   not overriding function Resolve_Simple_Type
    (Self    : in out Name_Resolver;
     Name    : Matreshka.XML_Schema.AST.Qualified_Name)
     return Matreshka.XML_Schema.AST.Simple_Type_Definition_Access
   is
      Result : Matreshka.XML_Schema.AST.Type_Definition_Access
        := Self.Resolve_Type (Name);

   begin
      if Result.all
           in Matreshka.XML_Schema.AST.Simple_Types
                .Simple_Type_Definition_Node'Class
      then
         return
           Matreshka.XML_Schema.AST.Simple_Type_Definition_Access
             (Result);

      else
         raise Constraint_Error
           with "Unable to resolve type to simple type";
      end if;
   end Resolve_Simple_Type;

   ------------------
   -- Resolve_Type --
   ------------------

   not overriding function Resolve_Type
    (Self    : in out Name_Resolver;
     Name    : Matreshka.XML_Schema.AST.Qualified_Name)
     return Matreshka.XML_Schema.AST.Type_Definition_Access
   is
      use type Matreshka.XML_Schema.AST.Namespace_Access;
      use type Matreshka.XML_Schema.AST.Type_Definition_Access;

      Result    : Matreshka.XML_Schema.AST.Type_Definition_Access;
      Namespace : constant Matreshka.XML_Schema.AST.Namespace_Access :=
        Self.Model.Get_Namespace (Name.Namespace_URI);
   begin
      Ada.Wide_Wide_Text_IO.Put_Line
        ('{'
         & Name.Namespace_URI.To_Wide_Wide_String
         & '}'
         & Name.Local_Name.To_Wide_Wide_String);

      if Namespace = null then
         raise Program_Error;
      end if;

      Result := Namespace.Get_Type_Definition (Name.Local_Name);

      if Result = null then
         raise Program_Error;
      end if;

      return Result;
   end Resolve_Type;

end Matreshka.XML_Schema.Name_Resolvers;
