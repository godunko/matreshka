package body Properties.Statements.Null_Statement is

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
   begin
      return League.Holders.To_Holder (League.Strings.Empty_Universal_String);
   end Code;

end Properties.Statements.Null_Statement;
