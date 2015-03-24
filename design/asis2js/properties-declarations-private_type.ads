with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Declarations.Private_Type is

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

end Properties.Declarations.Private_Type;
