with Asis;

with Engines;

with League.Holders;
with League.Strings;

package Properties.Clauses.Use_Package_Clause is

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder;

end Properties.Clauses.Use_Package_Clause;
