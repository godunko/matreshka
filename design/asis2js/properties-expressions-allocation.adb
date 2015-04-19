with Asis.Expressions;

package body Properties.Expressions.Allocation is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      Item : constant Asis.Expression :=
        Asis.Expressions.Allocator_Qualified_Expression (Element);
   begin
      return Engine.Text.Get_Property (Item, Name);
   end Code;

end Properties.Expressions.Allocation;
