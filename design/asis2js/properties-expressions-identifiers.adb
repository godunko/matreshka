with Asis.Declarations;
with Asis.Elements;
with Asis.Expressions;

package body Properties.Expressions.Identifiers is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
      Decl : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Declaration (Element);
      Image : constant Wide_String :=
        Asis.Expressions.Name_Image (Element);
      Text : constant League.Strings.Universal_String :=
        League.Strings.From_UTF_16_Wide_String (Image);
      Value : constant League.Holders.Holder :=
        League.Holders.To_Holder (Text.To_Lowercase);
   begin
      if Asis.Elements.Is_Nil (Decl) then
         return Value;
      else
         return Engine.Get_Property
           (Asis.Declarations.Names (Decl) (1), Name);
      end if;
   end Code;

end Properties.Expressions.Identifiers;
