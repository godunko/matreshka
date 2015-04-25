with Asis.Definitions;

package body Properties.Definitions.Component_Definition is

   ----------------
   -- Initialize --
   ----------------

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Subtipe : constant Asis.Definition :=
        Asis.Definitions.Component_Definition_View (Element);
   begin
      return Engine.Text.Get_Property (Subtipe, Name);
   end Initialize;

end Properties.Definitions.Component_Definition;
