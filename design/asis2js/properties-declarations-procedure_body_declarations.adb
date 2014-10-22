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
      Subprogram_Name : constant League.Strings.Universal_String :=
        League.Holders.Element
          (Engine.Get_Property
             (Element => Asis.Declarations.Names (Element) (1),
              Name    => Name));

      Text : League.Strings.Universal_String;
      Value : League.Holders.Holder;
   begin
      Text.Append (Subprogram_Name);

      if League.Holders.Booleans.Element
        (Engine.Get_Property (Element, Engines.Property_Names.Export))
      then
         Text.Append ("= this.");
         Text.Append (Subprogram_Name);
      end if;

      Text.Append (" = function ");
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

      Value := League.Holders.To_Holder (Text);

      return Value;
   end Code;

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
