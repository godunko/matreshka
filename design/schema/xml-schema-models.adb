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
with Matreshka.XML_Schema.AST.Models;
with Matreshka.XML_Schema.AST.Namespaces;
with Matreshka.XML_Schema.AST.Types;
with Matreshka.XML_Schema.Named_Maps;

with XML.Schema.Named_Maps.Internals;
with XML.Schema.Element_Declarations.Internals;
with XML.Schema.Objects.Type_Definitions.Internals;
with Matreshka.XML_Schema.AST.Element_Declarations;

package body XML.Schema.Models is

   use type Matreshka.XML_Schema.AST.Model_Access;

   procedure Common_Get_Components
     (Item        : Matreshka.XML_Schema.AST.Namespace_Access;
      Result      : in out Matreshka.XML_Schema.Named_Maps.Named_Map_Access;
      Object_Type : Extended_XML_Schema_Component_Type);

   function Get_Namespace
    (Self      : XS_Model'Class;
     Namespace : League.Strings.Universal_String)
      return Matreshka.XML_Schema.AST.Namespace_Access;

   ---------------------------
   -- Common_Get_Components --
   ---------------------------

   procedure Common_Get_Components
     (Item        : Matreshka.XML_Schema.AST.Namespace_Access;
      Result      : in out Matreshka.XML_Schema.Named_Maps.Named_Map_Access;
      Object_Type : Extended_XML_Schema_Component_Type) is
   begin
      case Object_Type is
         when Type_Category | Type_Definition =>
            declare
               package M renames
                 Matreshka.XML_Schema.AST.Types.Type_Definition_Maps;
               Type_Definitions : M.Map renames Item.Type_Definitions;
               Pos              : M.Cursor := Type_Definitions.First;
            begin
               while M.Has_Element (Pos) loop
                  if Object_Type = Type_Definition
                    or else M.Element (Pos).Get_Type_Category = Object_Type
                  then
                     Result.Append
                       (Matreshka.XML_Schema.AST.Object_Access
                          (M.Element (Pos)));
                  end if;

                  M.Next (Pos);
               end loop;
            end;

         when Element_Declaration =>
            declare
               package M renames
                 Matreshka.XML_Schema.AST.Types.Element_Declaration_Maps;
               Element_Declarations : M.Map renames Item.Element_Declarations;
               Pos                  : M.Cursor := Element_Declarations.First;
            begin
               while M.Has_Element (Pos) loop
                  Result.Append
                    (Matreshka.XML_Schema.AST.Object_Access (M.Element (Pos)));
                  M.Next (Pos);
               end loop;
            end;

         when others =>
            raise Program_Error;
      end case;
   end Common_Get_Components;

   ---------------------
   -- Get_Annotations --
   ---------------------

   function Get_Annotations
    (Self : XS_Model'Class) return XML.Schema.Object_Lists.XS_Object_List is
   begin
      raise Program_Error;
      return X : XML.Schema.Object_Lists.XS_Object_List;
   end Get_Annotations;

   -------------------------------
   -- Get_Attribute_Declaration --
   -------------------------------

   function Get_Attribute_Declaration
    (Self      : XS_Model'Class;
     Name      : League.Strings.Universal_String;
     Namespace : League.Strings.Universal_String)
       return XML.Schema.Attribute_Declarations.XS_Attribute_Declaration is
   begin
      raise Program_Error;
      return X : XML.Schema.Attribute_Declarations.XS_Attribute_Declaration;
   end Get_Attribute_Declaration;

   -------------------------
   -- Get_Attribute_Group --
   -------------------------

   function Get_Attribute_Group
    (Self      : XS_Model'Class;
     Name      : League.Strings.Universal_String;
     Namespace : League.Strings.Universal_String)
       return
         XML.Schema.Attribute_Group_Definitions.XS_Attribute_Group_Definition
   is
   begin
      raise Program_Error;
      return
        X :
          XML.Schema.Attribute_Group_Definitions.XS_Attribute_Group_Definition;
   end Get_Attribute_Group;

   --------------------
   -- Get_Components --
   --------------------

   function Get_Components
    (Self        : XS_Model'Class;
     Object_Type : Extended_XML_Schema_Component_Type)
       return XML.Schema.Named_Maps.XS_Named_Map
   is
      Result : Matreshka.XML_Schema.Named_Maps.Named_Map_Access;
   begin
      if Self.Node /= null then
         Result := new Matreshka.XML_Schema.Named_Maps.Named_Map;

         for Item of Self.Node.Namespaces loop
            Common_Get_Components (Item, Result, Object_Type);
         end loop;
      end if;

      return XML.Schema.Named_Maps.Internals.Create (Result);
   end Get_Components;

   ---------------------------------
   -- Get_Components_By_Namespace --
   ---------------------------------

   function Get_Components_By_Namespace
    (Self        : XS_Model'Class;
     Object_Type : Extended_XML_Schema_Component_Type;
     Namespace   : League.Strings.Universal_String)
       return XML.Schema.Named_Maps.XS_Named_Map
   is
      use type Matreshka.XML_Schema.AST.Namespace_Access;

      --  Lookup for namespace.
      Item   : constant Matreshka.XML_Schema.AST.Namespace_Access
        := Get_Namespace (Self, Namespace);
      Result : Matreshka.XML_Schema.Named_Maps.Named_Map_Access;

   begin
      if Item /= null then
         --  Lookup for components.
         Result := new Matreshka.XML_Schema.Named_Maps.Named_Map;
         Common_Get_Components (Item, Result, Object_Type);
      end if;

      return XML.Schema.Named_Maps.Internals.Create (Result);
   end Get_Components_By_Namespace;

   -----------------------------
   -- Get_Element_Declaration --
   -----------------------------

   function Get_Element_Declaration
    (Self      : XS_Model'Class;
     Name      : League.Strings.Universal_String;
     Namespace : League.Strings.Universal_String)
       return XML.Schema.Element_Declarations.XS_Element_Declaration
   is
      use type Matreshka.XML_Schema.AST.Namespace_Access;

      --  Lookup for namespace.
      Item : constant Matreshka.XML_Schema.AST.Namespace_Access
        := Get_Namespace (Self, Namespace);
   begin
      if Item /= null then
         --  Lookup for element declaration.

         return
           XML.Schema.Element_Declarations.Internals.Create
             (Item.Get_Element_Declaration (Name));
      end if;

      return XML.Schema.Element_Declarations.Null_XS_Element_Declaration;
   end Get_Element_Declaration;

   --------------------------------
   -- Get_Model_Group_Definition --
   --------------------------------

   function Get_Model_Group_Definition
    (Self      : XS_Model'Class;
     Name      : League.Strings.Universal_String;
     Namespace : League.Strings.Universal_String)
       return XML.Schema.Model_Group_Definitions.XS_Model_Group_Definition is
   begin
      raise Program_Error;
      return X : XML.Schema.Model_Group_Definitions.XS_Model_Group_Definition;
   end Get_Model_Group_Definition;

   -------------------
   -- Get_Namespace --
   -------------------

   function Get_Namespace
     (Self      : XS_Model'Class;
     Namespace : League.Strings.Universal_String)
      return Matreshka.XML_Schema.AST.Namespace_Access is
   begin
      if Self.Node /= null then
         return Self.Node.Get_Namespace (Namespace);
      else
         return null;
      end if;
   end Get_Namespace;

   -------------------------
   -- Get_Namespace_Items --
   -------------------------

   function Get_Namespace_Items
    (Self : XS_Model'Class)
       return XML.Schema.Namespace_Item_Lists.XS_Namespace_Item_List is
   begin
      raise Program_Error;
      return X : XML.Schema.Namespace_Item_Lists.XS_Namespace_Item_List;
   end Get_Namespace_Items;

   --------------------
   -- Get_Namespaces --
   --------------------

   function Get_Namespaces
    (Self : XS_Model'Class)
       return League.String_Vectors.Universal_String_Vector is
   begin
      if Self.Node = null then
         return League.String_Vectors.Empty_Universal_String_Vector;
      end if;

      return Result : League.String_Vectors.Universal_String_Vector do
         for Item of Self.Node.Namespaces loop
            Result.Append (Item.Namespace_URI);
         end loop;
      end return;
   end Get_Namespaces;

   ------------------------------
   -- Get_Notation_Declaration --
   ------------------------------

   function Get_Notation_Declaration
    (Self      : XS_Model'Class;
     Name      : League.Strings.Universal_String;
     Namespace : League.Strings.Universal_String)
       return XML.Schema.Notation_Declarations.XS_Notation_Declaration is
   begin
      raise Program_Error;
      return X : XML.Schema.Notation_Declarations.XS_Notation_Declaration;
   end Get_Notation_Declaration;

   -------------------------
   -- Get_Type_Definition --
   -------------------------

   function Get_Type_Definition
    (Self      : XS_Model'Class;
     Name      : League.Strings.Universal_String;
     Namespace : League.Strings.Universal_String)
       return XML.Schema.Type_Definitions.XS_Type_Definition
   is
      use type Matreshka.XML_Schema.AST.Namespace_Access;

      Item : constant Matreshka.XML_Schema.AST.Namespace_Access
        := Get_Namespace (Self, Namespace);
   begin
      if Item /= null then
         return
           XML.Schema.Objects.Type_Definitions.Internals.Create
             (Item.Get_Type_Definition (Name));
      end if;

      return XML.Schema.Objects.Type_Definitions.Null_XS_Type_Definition;
   end Get_Type_Definition;

   -------------
   -- Is_Null --
   -------------

   function Is_Null (Self : XS_Model) return Boolean is
   begin
      return Self.Node = null;
   end Is_Null;

end XML.Schema.Models;
