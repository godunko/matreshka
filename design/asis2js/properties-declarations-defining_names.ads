with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Declarations.Defining_Names is

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

end Properties.Declarations.Defining_Names;
