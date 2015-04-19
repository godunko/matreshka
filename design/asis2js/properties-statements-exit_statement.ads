with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Statements.Exit_Statement is

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

end Properties.Statements.Exit_Statement;
