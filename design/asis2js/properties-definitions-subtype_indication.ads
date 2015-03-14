with Asis;

with Engines;

with League.Holders;
with League.Strings;

package Properties.Definitions.Subtype_Indication is

   function Initialize
     (Engine  : access Engines.Engine;
      Element : Asis.Definition;
      Name    : League.Strings.Universal_String) return League.Holders.Holder;

end Properties.Definitions.Subtype_Indication;