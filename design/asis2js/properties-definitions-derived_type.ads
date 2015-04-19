with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Definitions.Derived_Type is

   function Bounds
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
        renames Bounds;

end Properties.Definitions.Derived_Type;
