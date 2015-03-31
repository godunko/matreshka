with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Definitions.Simple_Expression_Range is

   function Lower
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

   function Upper
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

end Properties.Definitions.Simple_Expression_Range;
