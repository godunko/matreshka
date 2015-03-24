with Asis.Elements;
with Asis.Expressions;

package body Properties.Expressions.Array_Component_Association is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Association;
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
      Kind   : Asis.Definition_Kinds;
   begin
      for J in List'Range loop
         Kind := Asis.Elements.Definition_Kind (List (J));

         case Kind is
            when Asis.An_Others_Choice =>
               --  FIXME: Only Boolean supported for 'others' choice
               Result.Append ("false:");
               Result.Append (Down);
               Result.Append (", true:");
               Result.Append (Down);
            when others =>
               Result.Append (Engine.Text.Get_Property (List (J), Name));
               Result.Append (":");
               Result.Append (Down);
         end case;
      end loop;

      return Result;
   end Code;

end Properties.Expressions.Array_Component_Association;
