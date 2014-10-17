with Asis.Declarations;

package body Properties.Declarations.Ordinary_Type is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
   begin
      return Engine.Get_Property
        (Asis.Declarations.Type_Declaration_View (Element), Name);
   end Code;

end Properties.Declarations.Ordinary_Type;
