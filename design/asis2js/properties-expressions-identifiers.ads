with Asis;

with Engines;

with League.Holders;
with League.Strings;

package Properties.Expressions.Identifiers is

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder;

end Properties.Expressions.Identifiers;
