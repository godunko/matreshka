with Asis.Elements;
with Asis.Expressions;

package body Properties.Expressions.Parameter_Association is

   ------------
   -- Bounds --
   ------------

   function Bounds
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Association;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      Param : constant Asis.Element :=
        Asis.Expressions.Formal_Parameter (Element);
   begin
      return Engine.Text.Get_Property
        (Asis.Elements.Enclosing_Element (Param), Name);
   end Bounds;

end Properties.Expressions.Parameter_Association;
