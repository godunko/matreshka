with Asis.Expressions;

package body Properties.Expressions.Named_Array_Aggregate is

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
      List : constant Asis.Association_List :=
        Asis.Expressions.Array_Component_Associations (Element);
   begin

      Result.Append ("{");
      for J in List'Range loop
         Result.Append (Engine.Text.Get_Property (List (J), Name));
         if J /= List'Last then
            Result.Append (",");
         end if;
      end loop;

      Result.Append ("}");

      return Result;
   end Code;

end Properties.Expressions.Named_Array_Aggregate;
