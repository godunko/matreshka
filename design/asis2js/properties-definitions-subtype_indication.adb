with Asis.Definitions;

package body Properties.Definitions.Subtype_Indication is

   ----------------
   -- Initialize --
   ----------------

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Mark : constant Asis.Definition :=
        Asis.Definitions.Subtype_Mark (Element);
   begin
      return Engine.Text.Get_Property (Mark, Name);
   end Initialize;

end Properties.Definitions.Subtype_Indication;
