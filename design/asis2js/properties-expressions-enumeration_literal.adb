with Asis.Declarations;
with Asis.Expressions;

package body Properties.Expressions.Enumeration_Literal is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      Tipe   : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Expression_Type (Element);
      Image  : constant Wide_String := Asis.Expressions.Name_Image (Element);
      Result : League.Strings.Universal_String;
   begin
      Result := League.Holders.Element
        (Engine.Get_Property
           (Asis.Declarations.Names (Tipe) (1), Name));
      Result.Append (".");
      Result.Append (League.Strings.From_UTF_16_Wide_String (Image));

      return League.Holders.To_Holder (Result.To_Lowercase);
   end Code;

end Properties.Expressions.Enumeration_Literal;
