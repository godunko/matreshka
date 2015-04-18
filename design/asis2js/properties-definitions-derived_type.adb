with Asis.Definitions;

package body Properties.Definitions.Derived_Type is

   ------------
   -- Bounds --
   ------------

   function Bounds
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      Parent : constant Asis.Subtype_Indication :=
        Asis.Definitions.Parent_Subtype_Indication (Element);
   begin
      return Engine.Text.Get_Property (Parent, Name);
   end Bounds;

end Properties.Definitions.Derived_Type;
