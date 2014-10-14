with Properties.Declarations.Function_Declarations;

package body Properties.Declarations.Procedure_Declaration is

   ---------------------
   -- Call_Convention --
   ---------------------

   function Call_Convention
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
        renames Properties.Declarations.Function_Declarations.Call_Convention;

   --------------------
   -- Intrinsic_Name --
   --------------------

   function Intrinsic_Name
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
        renames Properties.Declarations.Function_Declarations.Intrinsic_Name;

end Properties.Declarations.Procedure_Declaration;
