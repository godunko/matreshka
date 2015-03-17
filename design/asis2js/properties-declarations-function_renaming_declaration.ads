with Asis;

with Engines.Contexts;

with League.Strings;

package Properties.Declarations.Function_Renaming_Declaration is

   function Call_Convention
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Call_Convention_Property)
      return Engines.Call_Convention_Kind;

   function Intrinsic_Name
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

end Properties.Declarations.Function_Renaming_Declaration;
