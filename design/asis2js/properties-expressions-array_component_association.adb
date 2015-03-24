with Asis.Expressions;

package body Properties.Expressions.Array_Component_Association is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      Result : League.Strings.Universal_String;
      List   : constant Asis.Element_List :=
        Asis.Expressions.Array_Component_Choices (Element);
      Value  : constant Asis.Expression :=
        Asis.Expressions.Component_Expression (Element);
      Down   : constant League.Strings.Universal_String :=
        Engine.Text.Get_Property (Value, Name);
   begin
      for J in List'Range loop
         Result.Append (Engine.Text.Get_Property (List (J), Name));
         Result.Append (":");
         Result.Append (Down);
      end loop;

      return Result;
   end Code;

end Properties.Expressions.Array_Component_Association;
