with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Expressions.Type_Conversion is

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

end Properties.Expressions.Type_Conversion;
