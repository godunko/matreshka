package body Properties.Statements.Raise_Statement is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      pragma Unreferenced (Engine, Element, Name);
      Text : League.Strings.Universal_String;
   begin
      Text.Append ("_ec._raise();");

      return Text;
   end Code;

end Properties.Statements.Raise_Statement;
