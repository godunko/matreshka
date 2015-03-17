with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Definitions.Tagged_Record_Type is

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

end Properties.Definitions.Tagged_Record_Type;
