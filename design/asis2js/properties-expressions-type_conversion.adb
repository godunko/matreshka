with Asis.Expressions;

package body Properties.Expressions.Type_Conversion is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
   begin
      return Engine.Get_Property
        (Asis.Expressions.Converted_Or_Qualified_Expression (Element), Name);
   end Code;

end Properties.Expressions.Type_Conversion;
