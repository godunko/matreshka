with Asis.Clauses;
with Asis.Compilation_Units;
with Asis.Declarations;
with Asis.Definitions;
with Asis.Elements;
with Asis.Expressions;

package body Properties.Tools is

   ------------------------
   -- Corresponding_Type --
   ------------------------

   function Corresponding_Type
     (Declaration : Asis.Declaration) return Asis.Declaration
   is
      List : constant Asis.Declaration_List :=
        Asis.Declarations.Parameter_Profile (Declaration);
      View : constant Asis.Element :=
        Asis.Declarations.Object_Declaration_View (List (List'First));
--      Mark : constant Asis.Subtype_Mark :=
--        Asis.Definitions.Subtype_Mark (View);
      Decl : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Declaration (View);
   begin
      return Decl;
   end Corresponding_Type;

   -----------------------------------
   -- Corresponding_Type_Components --
   -----------------------------------

   function Corresponding_Type_Components
     (Definition : Asis.Definition) return Asis.Declaration_List
   is
      Def_Kind : constant Asis.Definition_Kinds :=
        Asis.Elements.Definition_Kind (Definition);
      Type_Kind : constant Asis.Type_Kinds :=
        Asis.Elements.Type_Kind (Definition);
   begin
      case Def_Kind is
         when Asis.A_Null_Record_Definition =>

            return Asis.Nil_Element_List;

         when Asis.A_Record_Definition =>

            return Asis.Definitions.Record_Components (Definition);

         when Asis.A_Type_Definition =>

            case Type_Kind is
               when Asis.A_Derived_Record_Extension_Definition |
                    Asis.A_Record_Type_Definition |
                    Asis.A_Tagged_Record_Type_Definition =>

                  return Corresponding_Type_Components
                    (Asis.Definitions.Record_Definition (Definition));

               when others =>

                  raise Program_Error;
            end case;

         when others =>

            raise Program_Error;
      end case;
   end Corresponding_Type_Components;

   ------------------------------------
   -- Corresponding_Type_Subprograms --
   ------------------------------------

   function Corresponding_Type_Subprograms
     (Definition : Asis.Definition) return Asis.Declaration_List
   is
      use type Asis.Declaration_Kinds;
      Decl : constant Asis.Declaration :=
        Asis.Elements.Enclosing_Element (Definition);
      Pkg  : constant Asis.Element := Asis.Elements.Enclosing_Element (Decl);
   begin
      if Asis.Elements.Declaration_Kind (Pkg) = Asis.A_Package_Declaration then
         declare
            use type Asis.Element_List;

            List : Asis.Element_List :=
              Asis.Declarations.Visible_Part_Declarative_Items (Pkg) &
              Asis.Declarations.Private_Part_Declarative_Items (Pkg);
            Last : Natural := 0;
         begin
            for J in List'Range loop
               if Asis.Elements.Declaration_Kind (List (J)) in
                    Asis.A_Procedure_Declaration | Asis.A_Function_Declaration
                 and then Is_Primitive_Subprogram (Definition, List (J))
               then
                  Last := Last + 1;
                  List (Last) := List (J);
               end if;
            end loop;

            return List (1 .. Last);
         end;
      else
         return Asis.Nil_Element_List;
      end if;
   end Corresponding_Type_Subprograms;

   ----------------
   -- Get_Aspect --
   ----------------

   function Get_Aspect
     (Element : Asis.Declaration;
      Name    : Wide_String)
      return Wide_String
   is
      Mark : Asis.Expression;
      List : constant Asis.Declaration_List :=
        Asis.Declarations.Aspect_Specifications (Element);
   begin
      for J in List'Range loop
         Mark := Asis.Definitions.Aspect_Mark (List (J));
         if Asis.Expressions.Name_Image (Mark) = Name then
            declare
               Exp : constant Asis.Expression :=
                 Asis.Definitions.Aspect_Definition (List (J));
            begin
               case Asis.Elements.Expression_Kind (Exp) is
                  when Asis.An_Integer_Literal |
                       Asis.A_Real_Literal =>
                     return Asis.Expressions.Value_Image (Exp);
                  when Asis.A_String_Literal =>
                     declare
                        Result : constant Wide_String :=
                          Asis.Expressions.Value_Image (Exp);
                     begin
                        return Result (2 .. Result'Last - 1);
                     end;
                  when others =>
                     return Asis.Expressions.Name_Image (Exp);
               end case;
            end;
         end if;
      end loop;

      return "";
   end Get_Aspect;

   -------------------
   -- Is_Equal_Type --
   -------------------

   function Is_Equal_Type
     (Left  : Asis.Declaration;
      Right : Asis.Declaration) return Boolean
   is
      function Up (X : Asis.Declaration) return Asis.Declaration;

      --------
      -- Up --
      --------

      function Up (X : Asis.Declaration) return Asis.Declaration is
      begin
         case Asis.Elements.Declaration_Kind (X) is
            when Asis.An_Ordinary_Type_Declaration |
                 Asis.A_Task_Type_Declaration |
                 Asis.A_Protected_Type_Declaration =>
               declare
                  CT : constant Asis.Declaration :=
                    Asis.Declarations.Corresponding_Type_Declaration (X);
               begin
                  case Asis.Elements.Declaration_Kind (CT) is
                     when Asis.An_Incomplete_Type_Declaration |
                          Asis.A_Tagged_Incomplete_Type_Declaration =>
                        return X;
                     when Asis.A_Private_Type_Declaration |
                          Asis.A_Private_Extension_Declaration =>
                        return CT;
                     when others =>
                        return X;
                  end case;
               end;

            when Asis.An_Incomplete_Type_Declaration
               | Asis.A_Tagged_Incomplete_Type_Declaration =>

               declare
                  CT : constant Asis.Declaration :=
                    Asis.Declarations.Corresponding_Type_Declaration (X);
               begin
                  case Asis.Elements.Declaration_Kind (CT) is
                     when Asis.A_Private_Type_Declaration |
                          Asis.A_Private_Extension_Declaration =>
                        return CT;
                     when others =>
                        return Up (CT);
                  end case;
               end;

            when others =>
               return X;
         end case;
      end Up;

      Left_Up : constant Asis.Declaration := Up (Left);
      Right_Up : constant Asis.Declaration := Up (Right);
   begin
      return Asis.Elements.Is_Equal (Left_Up, Right_Up);
   end Is_Equal_Type;

   -----------------------------
   -- Is_Primitive_Subprogram --
   -----------------------------

   function Is_Primitive_Subprogram
     (Definition : Asis.Definition;
      Subprogram : Asis.Declaration) return Boolean
   is
      List : constant Asis.Declaration_List :=
        Asis.Declarations.Parameter_Profile (Subprogram);
   begin
      if List'Length >= 1 then
         declare
            use type Asis.Expression_Kinds;

            Decl  : Asis.Declaration;
            First : constant Asis.Element :=
              Asis.Declarations.Object_Declaration_View (List (List'First));
         begin
            if Asis.Elements.Expression_Kind (First) = Asis.An_Identifier then
               Decl := Asis.Expressions.Corresponding_Name_Declaration (First);

               return Is_Equal_Type
                 (Asis.Elements.Enclosing_Element (Definition), Decl);
            end if;
         end;
      end if;

      return False;
   end Is_Primitive_Subprogram;

   --------------------------
   -- Library_Level_Header --
   --------------------------

   function Library_Level_Header
     (Unit : Asis.Compilation_Unit) return League.Strings.Universal_String
   is
      procedure Append (Name : Asis.Name);

      Text : League.Strings.Universal_String;

      procedure Append (Name : Asis.Name) is
         Image : League.Strings.Universal_String;
      begin
         case Asis.Elements.Expression_Kind (Name) is
            when Asis.An_Identifier =>
               Image := League.Strings.From_UTF_16_Wide_String
                 (Asis.Expressions.Name_Image (Name));
               Text.Append (Image.To_Lowercase);
            when Asis.A_Selected_Component =>
               Append (Asis.Expressions.Prefix (Name));
               Text.Append ('.');
               Append (Asis.Expressions.Selector (Name));
            when others =>
               raise Program_Error;
         end case;
      end Append;

      Parent : constant Asis.Compilation_Unit :=
        Asis.Compilation_Units.Corresponding_Parent_Declaration (Unit);

      Grand_Parent : constant Asis.Compilation_Unit :=
        Asis.Compilation_Units.Corresponding_Parent_Declaration (Parent);

      Full_Name : constant League.Strings.Universal_String :=
        League.Strings.From_UTF_16_Wide_String
          (Asis.Compilation_Units.Unit_Full_Name (Unit)).To_Lowercase;

      Parent_Name : constant League.Strings.Universal_String :=
        League.Strings.From_UTF_16_Wide_String
          (Asis.Compilation_Units.Unit_Full_Name (Parent)).To_Lowercase;

      List : constant Asis.Context_Clause_List :=
        Asis.Elements.Context_Clause_Elements (Unit);

   begin
      Text.Append ("define('standard.");
      Text.Append (Full_Name);
      Text.Append ("', ['standard");

      if not Asis.Compilation_Units.Is_Nil (Grand_Parent) then
         --  if Parent is not standard
         Text.Append (".");
         Text.Append (Parent_Name);
      end if;

      for Clause of List loop
         case Asis.Elements.Clause_Kind (Clause) is
            when Asis.A_With_Clause =>
               declare
                  Names : constant Asis.Name_List :=
                    Asis.Clauses.Clause_Names (Clause);
               begin
                  for Name of Names loop
                     Text.Append ("', 'standard.");
                     Append (Name);
                  end loop;
               end;
            when others =>
               null;
         end case;
      end loop;

      Text.Append ("'], function(_ec) {");

      return Text;
   end Library_Level_Header;

end Properties.Tools;
