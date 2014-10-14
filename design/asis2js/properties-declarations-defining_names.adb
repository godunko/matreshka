with Asis.Declarations;

package body Properties.Declarations.Defining_Names is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
      pragma Unreferenced (Engine, Name);
      Image : constant Wide_String :=
        Asis.Declarations.Defining_Name_Image (Element);
      Text : constant League.Strings.Universal_String :=
        League.Strings.From_UTF_16_Wide_String (Image);
      Value : constant League.Holders.Holder :=
        League.Holders.To_Holder (Text.To_Lowercase);
   begin
      return Value;
   end Code;

end Properties.Declarations.Defining_Names;
