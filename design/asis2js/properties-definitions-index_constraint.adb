with Asis.Definitions;

package body Properties.Definitions.Index_Constraint is

   ------------
   -- Bounds --
   ------------

   function Bounds
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);
      List : constant Asis.Discrete_Range_List :=
        Asis.Definitions.Discrete_Ranges (Element);
      Result : League.Strings.Universal_String;
   begin
      Result.Append (Engine.Text.Get_Property (List (1), Engines.Lower));
      Result.Append (",");
      Result.Append (Engine.Text.Get_Property (List (1), Engines.Upper));
      return Result;
   end Bounds;

end Properties.Definitions.Index_Constraint;
