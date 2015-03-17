with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Declarations.Procedure_Body_Declarations is

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

   function Declaration_Prefix
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

   function Export
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Boolean_Property) return Boolean;

end Properties.Declarations.Procedure_Body_Declarations;
