with Asis.Expressions;

package body Properties.Expressions.Selected_Components is

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
      return Engine.Get_Property (Asis.Expressions.Selector (Element), Name);
   end Call_Convention;

   function Intrinsic_Name
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
     renames Call_Convention;

end Properties.Expressions.Selected_Components;
