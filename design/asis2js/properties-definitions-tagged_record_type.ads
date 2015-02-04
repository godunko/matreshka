with Asis;

with Engines;

with League.Holders;
with League.Strings;

package Properties.Definitions.Tagged_Record_Type is

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Definition;
      Name    : League.Strings.Universal_String) return League.Holders.Holder;

end Properties.Definitions.Tagged_Record_Type;
