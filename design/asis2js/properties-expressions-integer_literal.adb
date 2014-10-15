with Asis.Expressions;

package body Properties.Expressions.Integer_Literal is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      pragma Unreferenced (Engine, Name);
      Image : constant Wide_String := Asis.Expressions.Value_Image (Element);
      Result : constant League.Strings.Universal_String :=
        League.Strings.From_UTF_16_Wide_String (Image);
   begin
      return League.Holders.To_Holder (Result);
   end Code;

end Properties.Expressions.Integer_Literal;
