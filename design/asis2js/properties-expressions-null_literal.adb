package body Properties.Expressions.Null_Literal is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      pragma Unreferenced (Engine, Name, Element);
      Result : constant League.Strings.Universal_String :=
        League.Strings.To_Universal_String ("null");
   begin
      return League.Holders.To_Holder (Result);
   end Code;

end Properties.Expressions.Null_Literal;
