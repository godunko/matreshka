with Asis.Declarations;
with League.Holders;

package body Properties.Declarations.Defining_Names is

   ----------
   -- Code --
   ----------

   procedure Code
     (Engine  : in out Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String)
   is
      Image : constant Wide_String :=
        Asis.Declarations.Defining_Name_Image (Element);
      Text : constant League.Strings.Universal_String :=
        League.Strings.From_UTF_16_Wide_String (Image);
      Value : constant League.Holders.Holder :=
        League.Holders.To_Holder (Text.To_Lowercase);
   begin
      Engine.Set_Property (Element, Name, Value);
   end Code;

end Properties.Declarations.Defining_Names;
