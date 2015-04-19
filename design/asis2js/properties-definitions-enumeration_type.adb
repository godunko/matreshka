with Asis.Declarations;
with Asis.Definitions;
with Asis.Elements;

package body Properties.Definitions.Enumeration_Type is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
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

      return Text;
   end Code;

   ----------------
   -- Initialize --
   ----------------

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Engine, Element, Name);
   begin
      return League.Strings.To_Universal_String ("undefined");
   end Initialize;

   --------------------
   -- Is_Simple_Type --
   --------------------

   function Is_Simple_Type
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Boolean_Property) return Boolean is
      pragma Unreferenced (Engine, Element, Name);
   begin
      return True;
   end Is_Simple_Type;

   -----------
   -- Lower --
   -----------

   function Lower
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);
      List : constant Asis.Declaration_List :=
        Asis.Definitions.Enumeration_Literal_Declarations (Element);
   begin
      return Engine.Text.Get_Property
        (Asis.Declarations.Names (List (List'First)) (1), Engines.Code);
   end Lower;

   -----------
   -- Upper --
   -----------

   function Upper
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);
      List : constant Asis.Declaration_List :=
        Asis.Definitions.Enumeration_Literal_Declarations (Element);
   begin
      return Engine.Text.Get_Property
        (Asis.Declarations.Names (List (List'Last)) (1), Engines.Code);
   end Upper;

end Properties.Definitions.Enumeration_Type;
