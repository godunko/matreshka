with Asis.Expressions;

package body Properties.Expressions.Type_Conversion is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Text : League.Strings.Universal_String;
   begin
      Text.Append ("(");
      Text.Append
        (Engine.Text.Get_Property
           (Asis.Expressions.Converted_Or_Qualified_Expression
                (Element), Name));
      Text.Append (")");
      return Text;
   end Code;

end Properties.Expressions.Type_Conversion;
