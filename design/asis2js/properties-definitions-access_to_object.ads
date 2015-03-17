with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Definitions.Access_To_Object is

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

end Properties.Definitions.Access_To_Object;
