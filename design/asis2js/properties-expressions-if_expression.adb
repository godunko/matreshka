with Asis.Elements;
with Asis.Expressions;
with Asis.Statements;

package body Properties.Expressions.If_Expression is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      List  : constant Asis.Element_List :=
        Asis.Expressions.Expression_Paths (Element);
      Text  : League.Strings.Universal_String;
      Down  : League.Strings.Universal_String;
   begin
      for J in List'Range loop
         case Asis.Elements.Path_Kind (List (J)) is
            when Asis.An_If_Expression_Path =>
               Text.Append ("(");

               Down := Engine.Text.Get_Property
                 (Asis.Statements.Condition_Expression (List (J)), Name);

               Text.Append (Down);
               Text.Append ("?");
            when Asis.An_Else_Expression_Path =>
               Text.Append (":");
            when others =>
               raise Program_Error;
         end case;

         declare
            Nested : constant Asis.Expression :=
              Asis.Expressions.Dependent_Expression (List (J));
         begin
            Down := Engine.Text.Get_Property (Nested, Name);

            Text.Append (Down);
         end;
      end loop;

      Text.Append (")");

      return Text;
   end Code;

end Properties.Expressions.If_Expression;
