package body Properties.Statements.Return_Statement is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      pragma Unreferenced (Engine, Element, Name);
      Result : League.Strings.Universal_String;
   begin
      Result.Append ("return");
      Result.Append (";");
      return League.Holders.To_Holder (Result);
   end Code;

end Properties.Statements.Return_Statement;
