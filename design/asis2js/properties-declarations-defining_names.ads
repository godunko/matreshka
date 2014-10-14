with Asis;

with Engines;

with League.Holders;
with League.Strings;

package Properties.Declarations.Defining_Names is

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder;

end Properties.Declarations.Defining_Names;
