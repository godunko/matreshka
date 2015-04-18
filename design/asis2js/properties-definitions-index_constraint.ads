with Asis;
with Engines.Contexts;
with League.Strings;

package Properties.Definitions.Index_Constraint is

   function Bounds
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

end Properties.Definitions.Index_Constraint;
