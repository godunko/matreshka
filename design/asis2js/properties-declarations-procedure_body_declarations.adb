with Asis.Declarations;
with Asis.Elements;

with Properties.Tools;

package body Properties.Declarations.Procedure_Body_Declarations is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is

      Spec : constant Asis.Declaration :=
        Asis.Declarations.Corresponding_Declaration (Element);

      Is_Library_Level : constant Boolean := Asis.Elements.Is_Nil
        (Asis.Elements.Enclosing_Element (Element));

      Inside_Package : constant Boolean := Engine.Boolean.Get_Property
        (Element, Engines.Inside_Package);

      Is_Dispatching : constant Boolean := Engine.Boolean.Get_Property
        (Element, Engines.Is_Dispatching);

      Subprogram_Name : constant League.Strings.Universal_String :=
        Engine.Text.Get_Property
          (Element => Asis.Declarations.Names (Element) (1),
           Name    => Name);

      Text : League.Strings.Universal_String;
   begin
      if Is_Library_Level then
         Text.Append
           (Properties.Tools.Library_Level_Header
              (Asis.Elements.Enclosing_Compilation_Unit (Element)));
         Text.Append ("return _ec.");
         Text.Append (Subprogram_Name);
         Text.Append ("=");
      elsif Is_Dispatching then
         declare
            Tipe     : constant Asis.Declaration :=
              Tools.Corresponding_Type (Spec);
            Type_Name : constant Asis.Defining_Name :=
              Asis.Declarations.Names (Tipe) (1);
            Image : constant League.Strings.Universal_String :=
              Engine.Text.Get_Property (Type_Name, Name);
         begin
            if Inside_Package then
               Text.Append ("_ec.");
            end if;

            Text.Append (Image);
            Text.Append (".prototype.");
            Text.Append (Subprogram_Name);
            Text.Append (" = ");
         end;
      elsif Inside_Package then
         Text.Append ("_ec.");
         Text.Append (Subprogram_Name);
         Text.Append ("=");
      end if;

      Text.Append ("function ");
      Text.Append (Subprogram_Name);
      Text.Append (" (");

      declare
         List : constant Asis.Declaration_List :=
           Asis.Declarations.Parameter_Profile (Element);
      begin
         for J in List'Range loop
            declare
               Arg_Code : constant League.Strings.Universal_String :=
                 Engine.Text.Get_Property
                   (Asis.Declarations.Names (List (J)) (1), Name);
            begin
               if not Is_Dispatching or J /= List'First then
                  Text.Append (Arg_Code);

                  if J /= List'Last then
                     Text.Append (",");
                  end if;
               end if;
            end;
         end loop;
      end;

      Text.Append ("){");

      declare
         List : constant Asis.Element_List :=
           Asis.Declarations.Body_Declarative_Items (Element);
      begin
         for J in List'Range loop
            declare
               Var_Code : constant League.Strings.Universal_String :=
                 Engine.Text.Get_Property (List (J), Name);
            begin
               Text.Append (Var_Code);
            end;
         end loop;
      end;

      declare
         List : constant Asis.Element_List :=
           Asis.Declarations.Body_Statements (Element);
      begin
         for J in List'Range loop
            declare
               Stmt_Code : constant League.Strings.Universal_String :=
                 Engine.Text.Get_Property (List (J), Name);
            begin
               Text.Append (Stmt_Code);
            end;
         end loop;
      end;

      Text.Append ("};");

      if Is_Library_Level then
         Text.Append ("});");
      end if;

      return Text;
   end Code;

   ------------
   -- Export --
   ------------

   function Export
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Boolean_Property) return Boolean
   is
      Spec   : constant Asis.Declaration :=
        Asis.Declarations.Corresponding_Declaration (Element);

      Result : constant Wide_String :=
        Properties.Tools.Get_Aspect (Element, "Export");
   begin
      if Result = "True" then
         return True;
      elsif Asis.Elements.Is_Nil (Spec) then
         return False;
      else
         return Engine.Boolean.Get_Property (Spec, Name);
      end if;
   end Export;

   --------------------
   -- Is_Dispatching --
   --------------------

   function Is_Dispatching
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Boolean_Property) return Boolean
   is
      Spec : constant Asis.Declaration :=
        Asis.Declarations.Corresponding_Declaration (Element);
   begin
      if Asis.Elements.Is_Nil (Spec) then
         return False;
      else
         return Engine.Boolean.Get_Property (Spec, Name);
      end if;
   end Is_Dispatching;

end Properties.Declarations.Procedure_Body_Declarations;
