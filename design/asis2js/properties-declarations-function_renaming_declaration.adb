with Asis.Declarations;

package body Properties.Declarations.Function_Renaming_Declaration is

   ---------------------
   -- Call_Convention --
   ---------------------

   function Call_Convention
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Call_Convention_Property)
      return Engines.Call_Convention_Kind
   is
   begin
      return Engine.Call_Convention.Get_Property
        (Asis.Declarations.Renamed_Entity (Element), Name);
   end Call_Convention;

   --------------------
   -- Intrinsic_Name --
   --------------------

   function Intrinsic_Name
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
   begin
      return Engine.Text.Get_Property
        (Asis.Declarations.Renamed_Entity (Element), Name);
   end Intrinsic_Name;

   --------------------
   -- Is_Dispatching --
   --------------------

   function Is_Dispatching
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Boolean_Property) return Boolean is
   begin
      return Engine.Boolean.Get_Property
        (Asis.Declarations.Renamed_Entity (Element), Name);
   end Is_Dispatching;

end Properties.Declarations.Function_Renaming_Declaration;
