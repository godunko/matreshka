package body Properties.Definitions.Access_To_Object is

   ----------------
   -- Initialize --
   ----------------

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Engine, Element, Name);
   begin
      return League.Strings.To_Universal_String ("null");
   end Initialize;

end Properties.Definitions.Access_To_Object;
