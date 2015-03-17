with Properties.Declarations.Function_Declarations;

package body Properties.Declarations.Procedure_Declaration is

   ---------------------
   -- Call_Convention --
   ---------------------

   function Call_Convention
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Call_Convention_Property)
      return Engines.Call_Convention_Kind
        renames Properties.Declarations.Function_Declarations.Call_Convention;

   --------------------
   -- Intrinsic_Name --
   --------------------

   function Intrinsic_Name
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
        renames Properties.Declarations.Function_Declarations.Intrinsic_Name;

end Properties.Declarations.Procedure_Declaration;
