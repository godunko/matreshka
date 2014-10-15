with Asis;

with Engines;

with League.Holders;
with League.Strings;

package Properties.Statements.For_Loop_Statement is

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String) return League.Holders.Holder;

end Properties.Statements.For_Loop_Statement;
