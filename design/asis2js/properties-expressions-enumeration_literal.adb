with Asis.Compilation_Units;
with Asis.Declarations;
with Asis.Elements;
with Asis.Expressions;

package body Properties.Expressions.Enumeration_Literal is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Tipe   : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Expression_Type (Element);
      Unit   : constant Asis.Compilation_Unit :=
        Asis.Elements.Enclosing_Compilation_Unit (Tipe);
      Image  : constant Wide_String := Asis.Expressions.Name_Image (Element);
      Result : League.Strings.Universal_String;
   begin
      if not Asis.Compilation_Units.Is_Nil
        (Asis.Compilation_Units.Corresponding_Parent_Declaration (Unit))
      then
         --  if not in Standard
         Result := Engine.Text.Get_Property
           (Asis.Declarations.Names (Tipe) (1), Name);
         Result.Append (".");

      end if;

      Result.Append (League.Strings.From_UTF_16_Wide_String (Image));

      return Result.To_Lowercase;
   end Code;

end Properties.Expressions.Enumeration_Literal;
