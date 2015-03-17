package body Properties.Expressions.Null_Literal is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Engine, Name, Element);
      Result : constant League.Strings.Universal_String :=
        League.Strings.To_Universal_String ("null");
   begin
      return Result;
   end Code;

end Properties.Expressions.Null_Literal;
