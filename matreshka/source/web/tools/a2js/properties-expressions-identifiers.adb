------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Asis.Compilation_Units;
with Asis.Declarations;
with Asis.Elements;
with Asis.Expressions;

with League.String_Vectors;

with Properties.Tools;

package body Properties.Expressions.Identifiers is

   function Is_Current_Instance_Of_Type
     (Id   : Asis.Identifier;
      Decl : Asis.Declaration) return Boolean;

   -------------
   -- Address --
   -------------

   function Address
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);

      Text : League.Strings.Universal_String;
      Decl : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Declaration (Element);
      Is_Simple_Ref : Boolean;
   begin
      if Asis.Elements.Is_Nil (Decl) then
         return Engine.Text.Get_Property (Element, Engines.Code);
      end if;

      Is_Simple_Ref :=
        Engine.Boolean.Get_Property (Decl, Engines.Is_Simple_Ref);

      if Is_Simple_Ref then
         Text := Name_Prefix (Engine, Element, Decl);

         Text.Append
           (Engine.Text.Get_Property
              (Asis.Declarations.Names (Decl) (1), Engines.Code));

         return Text;
      else
         return Engine.Text.Get_Property (Element, Engines.Code);
      end if;
   end Address;

   ------------
   -- Bounds --
   ------------

   function Bounds
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      --  Expecting identifier as subtype name of subtype_mark
      Decl : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Declaration (Element);
   begin
      return Engine.Text.Get_Property (Decl, Name);
   end Bounds;

   ---------------------
   -- Call_Convention --
   ---------------------

   function Call_Convention
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Call_Convention_Property)
      return Engines.Call_Convention_Kind
   is
      use type Asis.Expression_Kinds;

      Def : Asis.Defining_Name :=
        Asis.Expressions.Corresponding_Name_Definition (Element);
   begin
      if Asis.Elements.Is_Nil (Def) then
         if Asis.Elements.Expression_Kind (Element) =
           Asis.An_Operator_Symbol
         then
            return Engines.Intrinsic;
         end if;

         return Engines.Unspecified;
      elsif Asis.Elements.Is_Part_Of_Instance (Def) then
         Def := Asis.Declarations.Corresponding_Generic_Element (Def);
      end if;

      return Engine.Call_Convention.Get_Property
        (Asis.Elements.Enclosing_Element (Def), Name);
   end Call_Convention;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      use type League.Strings.Universal_String;

      Decl : Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Declaration (Element);
      Image : constant Wide_String :=
        Asis.Expressions.Name_Image (Element);
      Text : League.Strings.Universal_String;

      Is_Simple_Ref : Boolean;
   begin
      if Asis.Elements.Is_Nil (Decl) then
         Text := League.Strings.From_UTF_16_Wide_String (Image);

         return Text.To_Lowercase;
      elsif Is_Current_Instance_Of_Type (Element, Decl) then
         return League.Strings.To_Universal_String ("this");
      end if;

      while Asis.Elements.Is_Part_Of_Inherited (Decl)
        and then Asis.Elements.Declaration_Kind (Decl) in
            Asis.A_Function_Declaration | Asis.A_Procedure_Declaration
      loop
         Decl := Asis.Declarations.Corresponding_Subprogram_Derivation (Decl);
      end loop;

      Is_Simple_Ref :=
        Engine.Boolean.Get_Property (Decl, Engines.Is_Simple_Ref);

      if Asis.Elements.Declaration_Kind (Decl) in
           Asis.A_Procedure_Declaration |
           Asis.A_Null_Procedure_Declaration |
           Asis.A_Function_Declaration |
           Asis.A_Procedure_Body_Declaration |
           Asis.A_Function_Body_Declaration
        and then Engine.Boolean.Get_Property (Decl, Engines.Is_Dispatching)
      then
         --  Dispatching operation has no prefix
         return Engine.Text.Get_Property
           (Asis.Declarations.Names (Decl) (1), Name);
      else
         Text := Name_Prefix (Engine, Element, Decl);

         Text.Append
           (Engine.Text.Get_Property
              (Asis.Declarations.Names (Decl) (1), Name));

         if Is_Simple_Ref then
            Text.Append (".all");
         end if;

         return Text;
      end if;
   end Code;

   ----------------
   -- Initialize --
   ----------------

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Decl : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Declaration (Element);
   begin
      if Asis.Elements.Is_Nil (Decl) then
         return League.Strings.To_Universal_String ("undefined");
      else
         return Engine.Text.Get_Property (Decl, Name);
      end if;
   end Initialize;

   --------------------
   -- Intrinsic_Name --
   --------------------

   function Intrinsic_Name
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      use type Asis.Expression_Kinds;

      Def : Asis.Defining_Name :=
        Asis.Expressions.Corresponding_Name_Definition (Element);
   begin
      if Asis.Elements.Is_Nil (Def) then
         if Asis.Elements.Expression_Kind (Element) =
           Asis.An_Operator_Symbol
         then
            declare
               Text : constant League.Strings.Universal_String :=
                 League.Strings.From_UTF_16_Wide_String
                   (Asis.Expressions.Name_Image (Element));
            begin
               return Text;
            end;
         end if;

         return League.Strings.Empty_Universal_String;
      elsif Asis.Elements.Is_Part_Of_Instance (Def) then
         Def := Asis.Declarations.Corresponding_Generic_Element (Def);
      end if;

      return Engine.Text.Get_Property
        (Asis.Elements.Enclosing_Element (Def), Name);
   end Intrinsic_Name;

   ---------------------------------
   -- Is_Current_Instance_Of_Type --
   ---------------------------------

   function Is_Current_Instance_Of_Type
     (Id   : Asis.Identifier;
      Decl : Asis.Declaration) return Boolean
   is
      Node : Asis.Declaration := Properties.Tools.Enclosing_Declaration (Id);
   begin
      while not Asis.Elements.Is_Nil (Node) loop
         if Properties.Tools.Is_Equal_Type (Decl, Node) then
            return True;
         end if;

         Node := Properties.Tools.Enclosing_Declaration (Node);
      end loop;

      return False;
   end Is_Current_Instance_Of_Type;

   --------------------
   -- Is_Dispatching --
   --------------------

   function Is_Dispatching
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Boolean_Property) return Boolean
   is
      Decl : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Declaration (Element);
   begin
      if Asis.Elements.Is_Nil (Decl) then
         return False;
      else
         return Engine.Boolean.Get_Property (Decl, Name);
      end if;
   end Is_Dispatching;

   -----------------
   -- Name_Prefix --
   -----------------

   function Name_Prefix
     (Engine : access Engines.Contexts.Context;
      Name   : Asis.Identifier;
      Decl   : Asis.Declaration) return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);

      procedure Add_Parent_Name
        (Result : in out League.Strings.Universal_String);

      function Is_Imported (Item : Asis.Declaration) return Boolean;

      ----------------
      -- Add_Prefix --
      ----------------

      procedure Add_Parent_Name
        (Result : in out League.Strings.Universal_String)
      is

         Unit : constant Asis.Compilation_Unit :=
           Asis.Elements.Enclosing_Compilation_Unit (Decl);

         Parent : constant Asis.Compilation_Unit :=
           Asis.Compilation_Units.Corresponding_Parent_Declaration (Unit);

         Parent_Name : constant League.Strings.Universal_String :=
           League.Strings.From_UTF_16_Wide_String
             (Asis.Compilation_Units.Unit_Full_Name (Parent)).To_Lowercase;

      begin
         Result.Prepend (".");
         Result.Prepend (Parent_Name);
         Result.Prepend ("_ec.");
      end Add_Parent_Name;

      -----------------
      -- Is_Imported --
      -----------------

      function Is_Imported (Item : Asis.Declaration) return Boolean is
         Import : constant Wide_String :=
           Properties.Tools.Get_Aspect (Item, "Import");
      begin
         return Import = "True";
      end Is_Imported;

      Top_Item   : Boolean := True;
      Is_Package : Boolean := False;
      Item       : Asis.Element := Decl;
      Decl_List  : League.String_Vectors.Universal_String_Vector;
      Result     : League.Strings.Universal_String;
      Kind       : Asis.Declaration_Kinds;
   begin
      while not Asis.Elements.Is_Nil (Item) loop
         Kind := Asis.Elements.Declaration_Kind (Item);

         case Kind is
            when Asis.A_Package_Instantiation =>
               null;

            when Asis.An_Ordinary_Type_Declaration |
                 Asis.A_Private_Type_Declaration |
                 Asis.A_Private_Extension_Declaration =>
               null;

            when Asis.A_Discriminant_Specification |
                 Asis.A_Component_Declaration |
                 Asis.A_Loop_Parameter_Specification |
                 Asis.An_Element_Iterator_Specification |
                 Asis.A_Parameter_Specification =>

               exit;

            when Asis.A_Deferred_Constant_Declaration |
                 Asis.A_Constant_Declaration |
                 Asis.A_Variable_Declaration =>

               exit when Is_Imported (Item);

            when Asis.A_Procedure_Declaration |
                 Asis.A_Null_Procedure_Declaration |
                 Asis.A_Function_Declaration |
                 Asis.A_Procedure_Body_Declaration |
                 Asis.A_Function_Body_Declaration =>

               if not Top_Item then
                  --  Some declaration inside subprogram
                  Is_Package := False;
                  exit;
               elsif Is_Imported (Item) then
                  --  Imported operation has no prefix
                  exit;
               end if;

            when Asis.A_Package_Declaration |
                 Asis.A_Package_Body_Declaration =>

               declare
                  Tmp   : League.String_Vectors.Universal_String_Vector;
                  Names : constant Asis.Defining_Name_List :=
                    Asis.Declarations.Names (Item);
               begin
                  if not Top_Item then
                     Tmp.Append
                       (Engine.Text.Get_Property (Names (1), Engines.Code));

                     Decl_List.Prepend (Tmp);
                     Is_Package := True;

                  end if;
               end;

            when Asis.A_Procedure_Instantiation =>
               null;  --  Skip instantiation element

            when Asis.Not_A_Declaration =>
               null;

            when others =>
               raise Program_Error;
         end case;

         Item := Asis.Elements.Enclosing_Element (Item);
         Top_Item := False;
      end loop;

      if Decl_List.Is_Empty then
         return League.Strings.Empty_Universal_String;
      end if;

      Result := Decl_List.Join ('.');

      if Is_Package then
         Add_Parent_Name (Result);
      end if;

      Result.Append (".");

      return Result;
   end Name_Prefix;

end Properties.Expressions.Identifiers;
