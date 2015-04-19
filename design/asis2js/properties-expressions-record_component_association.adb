with Asis.Elements;
with Asis.Expressions;

package body Properties.Expressions.Record_Component_Association is

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
      List   : constant Asis.Defining_Name_List :=
        Asis.Expressions.Record_Component_Choices (Element);
      Value  : constant Asis.Expression :=
        Asis.Expressions.Component_Expression (Element);
      Down   : League.Strings.Universal_String;
   begin
      if Asis.Elements.Is_Nil (Value) then
         Down := Engine.Text.Get_Property
           (Asis.Elements.Enclosing_Element (List (1)), Engines.Initialize);
      else
         Down := Engine.Text.Get_Property (Value, Name);
      end if;

      for J in List'Range loop
         Result.Append (Engine.Text.Get_Property (List (J), Name));
         Result.Append (":");
         Result.Append (Down);
      end loop;

      return Result;
   end Code;

end Properties.Expressions.Record_Component_Association;
