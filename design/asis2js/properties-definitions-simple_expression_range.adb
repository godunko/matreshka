with Asis.Definitions;

package body Properties.Definitions.Simple_Expression_Range is

   -----------
   -- Lower --
   -----------

   function Lower
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);
   begin
      return Engine.Text.Get_Property
        (Asis.Definitions.Lower_Bound (Element), Engines.Code);
   end Lower;

   -----------
   -- Upper --
   -----------

   function Upper
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);
   begin
      return Engine.Text.Get_Property
        (Asis.Definitions.Upper_Bound (Element), Engines.Code);
   end Upper;

end Properties.Definitions.Simple_Expression_Range;
