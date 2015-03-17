with Asis.Statements;

package body Properties.Statements.Assignment_Statement is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Left  : constant Asis.Expression :=
        Asis.Statements.Assignment_Variable_Name (Element);
      Right  : constant Asis.Expression :=
        Asis.Statements.Assignment_Expression (Element);
      Text  : League.Strings.Universal_String;
      Down  : League.Strings.Universal_String;
   begin
      Text := Engine.Text.Get_Property (Left, Name);
      Text.Append (" = ");
      Down := Engine.Text.Get_Property (Right, Name);
      Text.Append (Down);
      Text.Append (";");

      return Text;
   end Code;

end Properties.Statements.Assignment_Statement;
