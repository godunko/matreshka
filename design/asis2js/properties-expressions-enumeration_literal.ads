with Asis;

with Engines;

with League.Holders;
with League.Strings;

package Properties.Expressions.Enumeration_Literal is

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String) return League.Holders.Holder;

end Properties.Expressions.Enumeration_Literal;
