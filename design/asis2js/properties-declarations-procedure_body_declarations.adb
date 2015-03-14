with Asis.Declarations;
with Asis.Elements;

with League.Holders.Booleans;

with Engines.Property_Names;
with Properties.Tools;

package body Properties.Declarations.Procedure_Body_Declarations is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is

      Spec : constant Asis.Declaration :=
        Asis.Declarations.Corresponding_Declaration (Element);

      Is_Library_Level : constant Boolean := Asis.Elements.Is_Nil
        (Asis.Elements.Enclosing_Element (Element));

      Subprogram_Name : constant League.Strings.Universal_String :=
        League.Holders.Element
          (Engine.Get_Property
             (Element => Asis.Declarations.Names (Element) (1),
              Name    => Name));

      Text : League.Strings.Universal_String;
   begin
      if Is_Library_Level then
         Text.Append
           (Properties.Tools.Library_Level_Header
              (Asis.Elements.Enclosing_Compilation_Unit (Element)));
         Text.Append ("function(_ec){return ");
      elsif Asis.Declarations.Is_Dispatching_Operation (Spec) then
         declare
            Tipe     : constant Asis.Declaration :=
              Tools.Corresponding_Type (Spec);
            Type_Name : constant Asis.Defining_Name :=
              Asis.Declarations.Names (Tipe) (1);
            Image : constant League.Strings.Universal_String :=
              League.Holders.Element
                (Engine.Get_Property (Type_Name, Name));
         begin
            Text.Append ("_ec.");
            Text.Append (Image);
            Text.Append (".prototype.");
            Text.Append (Subprogram_Name);
            Text.Append (" = ");
         end;
      else
         declare
            Prefix : constant League.Strings.Universal_String :=
                 League.Holders.Element
                   (Engine.Get_Property
                      (Asis.Elements.Enclosing_Element (Element),
                       Engines.Property_Names.Declaration_Prefix));
         begin
            Text.Append (Prefix);
            Text.Append (Subprogram_Name);
            Text.Append (" = ");
         end;
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
                 League.Holders.Element
                   (Engine.Get_Property
                      (Asis.Declarations.Names (List (J)) (1), Name));
            begin
               Text.Append (Arg_Code);

               if J /= List'Last then
                  Text.Append (",");
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
                 League.Holders.Element
                   (Engine.Get_Property (List (J), Name));
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
                 League.Holders.Element
                   (Engine.Get_Property (List (J), Name));
            begin
               Text.Append (Stmt_Code);
            end;
         end loop;
      end;

      Text.Append ("};");

      if Is_Library_Level then
         Text.Append ("});");
      end if;

      return League.Holders.To_Holder (Text);
   end Code;

   ------------------------
   -- Declaration_Prefix --
   ------------------------

   function Declaration_Prefix
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
      pragma Unreferenced (Name, Engine, Element);
      Text : constant League.Strings.Universal_String :=
        League.Strings.To_Universal_String ("var ");
   begin
      return League.Holders.To_Holder (Text);
   end Declaration_Prefix;

   ------------
   -- Export --
   ------------

   function Export
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
      Spec   : constant Asis.Declaration :=
        Asis.Declarations.Corresponding_Declaration (Element);

      Result : constant Wide_String :=
        Properties.Tools.Get_Aspect (Element, "Export");
   begin
      if Result = "True" then
         return League.Holders.Booleans.To_Holder (True);
      elsif Asis.Elements.Is_Nil (Spec) then
         return League.Holders.Booleans.To_Holder (False);
      else
         return Engine.Get_Property (Spec, Name);
      end if;
   end Export;

end Properties.Declarations.Procedure_Body_Declarations;
