with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Definitions.Enumeration_Type is

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

   function Upper
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

   function Lower
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

   function Is_Simple_Type
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Boolean_Property) return Boolean;

end Properties.Definitions.Enumeration_Type;
