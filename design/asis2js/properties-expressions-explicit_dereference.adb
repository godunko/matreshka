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
      Result : League.Strings.Universal_String :=
        Engine.Text.Get_Property (Prefix, Name);
   begin
      Result.Append (".all");
      return Result;
   end Code;

end Properties.Expressions.Explicit_Dereference;
