with Asis.Declarations;
with Asis.Definitions;
with Asis.Elements;

package body Properties.Definitions.Enumeration_Type is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      pragma Unreferenced (Engine, Name);

      List : constant Asis.Declaration_List :=
        Asis.Definitions.Enumeration_Literal_Declarations (Element);
      Text  : League.Strings.Universal_String;
   begin
      declare
         Image : constant Wide_String :=
           Asis.Declarations.Defining_Name_Image
             (Asis.Declarations.Names
                (Asis.Elements.Enclosing_Element (Element)) (1));
         Name : constant League.Strings.Universal_String :=
           League.Strings.From_UTF_16_Wide_String (Image);
      begin
         Text.Append (Name.To_Lowercase);
      end;

      Text.Append (" = {");

      for J in List'Range loop
         declare
            Image : constant Wide_String :=
              Asis.Declarations.Defining_Name_Image
                (Asis.Declarations.Names (List (J)) (1));
            Name : constant League.Strings.Universal_String :=
              League.Strings.From_UTF_16_Wide_String (Image);
         begin
            Text.Append ("'");
            Text.Append (Name.To_Lowercase);
            Text.Append ("' : '");
            Text.Append (Name.To_Uppercase);
            if J = List'Last then
               Text.Append ("'");
            else
               Text.Append ("', ");
            end if;
         end;
      end loop;

      Text.Append ("};");

      return League.Holders.To_Holder (Text);
   end Code;

end Properties.Definitions.Enumeration_Type;
