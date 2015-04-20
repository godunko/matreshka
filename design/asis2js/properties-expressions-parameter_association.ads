with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Expressions.Parameter_Association is

   function Bounds
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Association;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

end Properties.Expressions.Parameter_Association;
