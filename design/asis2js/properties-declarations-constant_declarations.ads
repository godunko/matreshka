with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Declarations.Constant_Declarations is

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

end Properties.Declarations.Constant_Declarations;
