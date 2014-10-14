with Asis;

with Engines;

with League.Holders;
with League.Strings;

package Properties.Declarations.Procedure_Declaration is

   function Call_Convention
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder;

   function Intrinsic_Name
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder;

end Properties.Declarations.Procedure_Declaration;
