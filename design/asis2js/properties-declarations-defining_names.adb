with Ada.Containers.Hashed_Sets;

with Asis.Declarations;
with Asis.Elements;

with League.Strings.Hash;

with Properties.Tools;

package body Properties.Declarations.Defining_Names is

   function Link_Name
     (Element : Asis.Defining_Name)
      return League.Strings.Universal_String;

   package String_Maps is new Ada.Containers.Hashed_Sets
     (Element_Type        => League.Strings.Universal_String,
      Hash                => League.Strings.Hash,
      Equivalent_Elements => League.Strings."=",
      "="                 => League.Strings."=");

   Reserved : String_Maps.Set;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Engine, Name);
      L_Name : constant League.Strings.Universal_String := Link_Name (Element);
      Image : constant Wide_String :=
        Asis.Declarations.Defining_Name_Image (Element);
      Text : League.Strings.Universal_String :=
        League.Strings.From_UTF_16_Wide_String (Image).To_Lowercase;
   begin
      if L_Name.Is_Empty then
         if Reserved.Contains (Text) then
            Text.Prepend ("_");
         end if;
      else
         Text := L_Name;
      end if;

      return Text;
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

begin
   Reserved.Insert (League.Strings.To_Universal_String ("self"));
end Properties.Declarations.Defining_Names;
