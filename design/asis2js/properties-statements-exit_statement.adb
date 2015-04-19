with Asis.Statements;
with Asis.Elements;

package body Properties.Statements.Exit_Statement is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      Cond : constant Asis.Expression :=
        Asis.Statements.Exit_Condition (Element);
      Text  : League.Strings.Universal_String;
      Down  : League.Strings.Universal_String;
   begin
      if not Asis.Elements.Is_Nil (Cond) then
         Text.Append ("if (");
         Down := Engine.Text.Get_Property (Cond, Name);
         Text.Append (Down);
         Text.Append (")");
      end if;

      Text.Append ("break;");

      return Text;
   end Code;

end Properties.Statements.Exit_Statement;
