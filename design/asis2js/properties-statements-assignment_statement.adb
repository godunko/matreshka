with Asis.Statements;

package body Properties.Statements.Assignment_Statement is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      Left  : constant Asis.Expression :=
        Asis.Statements.Assignment_Variable_Name (Element);
      Right  : constant Asis.Expression :=
        Asis.Statements.Assignment_Expression (Element);
      Text  : League.Strings.Universal_String;
      Down  : League.Strings.Universal_String;
   begin
      Text := League.Holders.Element (Engine.Get_Property (Left, Name));
      Text.Append (" = ");
      Down := League.Holders.Element (Engine.Get_Property (Right, Name));
      Text.Append (Down);
      Text.Append (";");

      return League.Holders.To_Holder (Text);
   end Code;

end Properties.Statements.Assignment_Statement;
