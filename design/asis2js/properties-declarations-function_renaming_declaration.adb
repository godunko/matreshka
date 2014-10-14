with Asis.Declarations;

package body Properties.Declarations.Function_Renaming_Declaration is

   ---------------------
   -- Call_Convention --
   ---------------------

   function Call_Convention
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
   begin
      return Engine.Get_Property
        (Asis.Declarations.Renamed_Entity (Element), Name);
   end Call_Convention;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
      pragma Unreferenced (Engine, Element, Name);
   begin
      return League.Holders.To_Holder (League.Strings.Empty_Universal_String);
   end Code;

   --------------------
   -- Intrinsic_Name --
   --------------------

   function Intrinsic_Name
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
        renames Call_Convention;

end Properties.Declarations.Function_Renaming_Declaration;
