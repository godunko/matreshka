with Asis.Expressions;

package body Properties.Expressions.Parenthesized is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      Text : League.Strings.Universal_String;
   begin
      Text.Append ("(");
      Text.Append
        (Engine.Text.Get_Property
           (Asis.Expressions.Expression_Parenthesized (Element), Name));
      Text.Append (")");
      return Text;
   end Code;

end Properties.Expressions.Parenthesized;
