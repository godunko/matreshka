with Asis.Definitions;

package body Properties.Definitions.Component_Definition is

   ----------------
   -- Initialize --
   ----------------

   function Initialize
     (Engine  : access Engines.Engine;
      Element : Asis.Definition;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      Subtipe : constant Asis.Definition :=
        Asis.Definitions.Component_Subtype_Indication (Element);
   begin
      return Engine.Get_Property (Subtipe, Name);
   end Initialize;

end Properties.Definitions.Component_Definition;
