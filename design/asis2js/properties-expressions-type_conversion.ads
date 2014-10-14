with Asis;

with Engines;

with League.Holders;
with League.Strings;

package Properties.Expressions.Type_Conversion is

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String) return League.Holders.Holder;

end Properties.Expressions.Type_Conversion;
