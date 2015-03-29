with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Expressions.Record_Component_Association is

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Association;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

end Properties.Expressions.Record_Component_Association;
