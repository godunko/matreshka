with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Declarations.Private_Type is

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

   function Is_Simple_Type
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Boolean_Property) return Boolean;

end Properties.Declarations.Private_Type;
