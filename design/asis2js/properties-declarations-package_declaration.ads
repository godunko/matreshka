with Asis;

with Engines;

with League.Holders;
with League.Strings;

package Properties.Declarations.Package_Declaration is

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder;

   function Declaration_Prefix
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder;

end Properties.Declarations.Package_Declaration;