with Asis.Expressions;

package body Properties.Expressions.Explicit_Dereference is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      Prefix : constant Asis.Expression :=
        Asis.Expressions.Prefix (Element);
      Tipe : constant Asis.Definition :=
        Asis.Expressions.Corresponding_Expression_Type (Element);
      Result : League.Strings.Universal_String :=
        Engine.Text.Get_Property (Prefix, Name);
   begin
      if Engine.Boolean.Get_Property (Tipe, Engines.Is_Simple_Type) then
         Result.Append (".all");
      end if;

      return Result;
   end Code;

end Properties.Expressions.Explicit_Dereference;
