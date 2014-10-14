with Asis.Declarations;
with Asis.Definitions;
with Asis.Elements;
with Asis.Expressions;

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
      Mark : Asis.Expression;
      Decl : constant Asis.Declaration :=
        Asis.Elements.Enclosing_Element (Element);
      List : constant Asis.Declaration_List :=
        Asis.Declarations.Aspect_Specifications (Decl);
   begin
      for J in List'Range loop
         Mark := Asis.Definitions.Aspect_Mark (List (J));
         if Asis.Expressions.Name_Image (Mark) = "Link_Name" then
            declare
               Result : constant Wide_String := Asis.Expressions.Value_Image
                 (Asis.Definitions.Aspect_Definition (List (J)));
            begin
               return League.Strings.From_UTF_16_Wide_String
                 (Result (2 .. Result'Last - 1));
            end;
         end if;
      end loop;

      return League.Strings.Empty_Universal_String;
   end Link_Name;

end Properties.Declarations.Defining_Names;
