with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Statements.If_Statement is

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

end Properties.Statements.If_Statement;
