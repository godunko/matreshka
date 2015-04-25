with Asis.Elements;
with Asis.Definitions;
with Asis.Declarations;

package body Properties.Definitions.Derived_Type is

   ------------
   -- Bounds --
   ------------

   function Bounds
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      Parent : constant Asis.Subtype_Indication :=
        Asis.Definitions.Parent_Subtype_Indication (Element);
   begin
      return Engine.Text.Get_Property (Parent, Name);
   end Bounds;

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      Decl : constant Asis.Declaration :=
        Asis.Elements.Enclosing_Element (Element);
      Is_Simple : constant Boolean := Engine.Boolean.Get_Property
        (Element, Engines.Is_Simple_Type);
      Parent : constant Asis.Subtype_Indication :=
        Asis.Definitions.Parent_Subtype_Indication (Element);
      Result : League.Strings.Universal_String;
      Name_Image : League.Strings.Universal_String;
   begin
      if Is_Simple then
         return League.Strings.Empty_Universal_String;
      end if;

      Name_Image := Engine.Text.Get_Property
        (Asis.Declarations.Names (Decl) (1), Name);

      Result.Append ("_ec.");
      Result.Append (Name_Image);
      Result.Append (" = ");
      Result.Append (Engine.Text.Get_Property (Parent, Name));
      Result.Append (";");

      return Result;
   end Code;

   function Is_Simple_Type
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Boolean_Property) return Boolean
   is
      Parent : constant Asis.Subtype_Indication :=
        Asis.Definitions.Parent_Subtype_Indication (Element);
   begin
      return Engine.Boolean.Get_Property (Parent, Name);
   end Is_Simple_Type;

end Properties.Definitions.Derived_Type;
