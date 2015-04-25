with Asis.Expressions;

package body Properties.Expressions.Allocation_From_Subtype is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);
      Item : constant Asis.Expression :=
        Asis.Expressions.Allocator_Subtype_Indication (Element);
   begin
      return Engine.Text.Get_Property (Item, Engines.Initialize);
   end Code;

end Properties.Expressions.Allocation_From_Subtype;
