with Asis.Definitions;

package body Properties.Definitions.Constrained_Array_Type is

   ------------
   -- Bounds --
   ------------

   function Bounds
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);
      List : constant Asis.Definition_List :=
        Asis.Definitions.Discrete_Subtype_Definitions (Element);
      Result : League.Strings.Universal_String;
   begin
      Result.Append (Engine.Text.Get_Property (List (1), Engines.Lower));
      Result.Append (",");
      Result.Append (Engine.Text.Get_Property (List (1), Engines.Upper));

      return Result;
   end Bounds;

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
      return League.Strings.To_Universal_String ("[]");
   end Initialize;

   --------------------
   -- Is_Simple_Type --
   --------------------

   function Is_Simple_Type
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Boolean_Property) return Boolean
   is
      pragma Unreferenced (Engine, Element, Name);
   begin
      return False;
   end Is_Simple_Type;

end Properties.Definitions.Constrained_Array_Type;
