with Asis.Definitions;

package body Properties.Definitions.Subtype_Indication is

   ----------------
   -- Initialize --
   ----------------

   function Initialize
     (Engine  : access Engines.Engine;
      Element : Asis.Definition;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      Mark : constant Asis.Definition :=
        Asis.Definitions.Subtype_Mark (Element);
   begin
      return Engine.Get_Property (Mark, Name);
   end Initialize;

end Properties.Definitions.Subtype_Indication;
