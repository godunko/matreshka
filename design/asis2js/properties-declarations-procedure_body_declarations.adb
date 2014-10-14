with Asis.Declarations;

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
      Text.Append ("function ");
      Text.Append (Subprogram_Name);
      Text.Append (" (){");

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

      Text.Append ("}");
      Value := League.Holders.To_Holder (Text);

      return Value;
   end Code;

end Properties.Declarations.Procedure_Body_Declarations;
