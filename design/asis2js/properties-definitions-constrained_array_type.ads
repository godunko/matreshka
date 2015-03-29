with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Definitions.Constrained_Array_Type is

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

   function Is_Simple_Type
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Boolean_Property) return Boolean;

end Properties.Definitions.Constrained_Array_Type;
