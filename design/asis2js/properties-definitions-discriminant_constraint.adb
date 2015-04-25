with Asis.Definitions;
with Asis.Expressions;

package body Properties.Definitions.Discriminant_Constraint is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      List : constant Asis.Discriminant_Association_List :=
        Asis.Definitions.Discriminant_Associations (Element, True);
      Text : League.Strings.Universal_String;
      Expr : Asis.Expression;
   begin
      for J in List'Range loop
         Expr := Asis.Expressions.Discriminant_Expression (List (J));
         Text.Append (Engine.Text.Get_Property (Expr, Name));

         if J /= List'Last then
            Text.Append (",");
         end if;
      end loop;

      return Text;
   end Code;

end Properties.Definitions.Discriminant_Constraint;
