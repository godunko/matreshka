with Asis.Expressions;

package body Properties.Expressions.String_Literal is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Engine, Name);
      Image : constant Wide_String := Asis.Expressions.Value_Image (Element);
      Result : constant League.Strings.Universal_String :=
        League.Strings.From_UTF_16_Wide_String (Image);
   begin
      return Result;
   end Code;

end Properties.Expressions.String_Literal;
