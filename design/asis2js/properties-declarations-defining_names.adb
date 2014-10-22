with Asis.Declarations;
with Asis.Elements;

with Properties.Tools;

package body Properties.Declarations.Defining_Names is

   function Link_Name
     (Element : Asis.Defining_Name)
      return League.Strings.Universal_String;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
      pragma Unreferenced (Engine, Name);
      L_Name : constant League.Strings.Universal_String := Link_Name (Element);
      Image : constant Wide_String :=
        Asis.Declarations.Defining_Name_Image (Element);
      Text : constant League.Strings.Universal_String :=
        League.Strings.From_UTF_16_Wide_String (Image);
      Value : League.Holders.Holder;
   begin
      if L_Name.Is_Empty then
         Value := League.Holders.To_Holder (Text.To_Lowercase);
      else
         Value := League.Holders.To_Holder (L_Name);
      end if;

      return Value;
   end Code;

   ---------------
   -- Link_Name --
   ---------------

   function Link_Name
     (Element : Asis.Defining_Name)
      return League.Strings.Universal_String
   is
      Value : constant Wide_String :=
        Properties.Tools.Get_Aspect
          (Asis.Elements.Enclosing_Element (Element), "Link_Name");
   begin
      return League.Strings.From_UTF_16_Wide_String (Value);
   end Link_Name;

end Properties.Declarations.Defining_Names;
