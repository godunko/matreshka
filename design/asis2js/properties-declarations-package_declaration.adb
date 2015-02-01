with Asis.Declarations;
with Asis.Elements;

--  with League.String_Vectors;

with Engines.Property_Names;
with Properties.Tools;

package body Properties.Declarations.Package_Declaration is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
      use type Asis.Element_List;

      function Body_Declarative_Items
        (Element : Asis.Declaration) return Asis.Element_List;

      ----------------------------
      -- Body_Declarative_Items --
      ----------------------------

      function Body_Declarative_Items
        (Element : Asis.Declaration) return Asis.Element_List
      is
         Impl : constant Asis.Declaration :=
           Asis.Declarations.Corresponding_Body (Element);
      begin
         if Asis.Elements.Is_Nil (Impl) then
            return Asis.Nil_Element_List;
         else
            return Asis.Declarations.Body_Declarative_Items (Impl);
         end if;
      end Body_Declarative_Items;

      Is_Library_Level : constant Boolean := Asis.Elements.Is_Nil
        (Asis.Elements.Enclosing_Element (Element));

      Down : League.Strings.Universal_String;
      Text : League.Strings.Universal_String;
      List : constant Asis.Element_List :=
        Asis.Declarations.Visible_Part_Declarative_Items (Element) &
        Asis.Declarations.Private_Part_Declarative_Items (Element) &
        Body_Declarative_Items (Element);
   begin
      Down := League.Holders.Element
        (Engine.Get_Property (Asis.Declarations.Names (Element) (1), Name));

      if Is_Library_Level then
         Text.Append
           (Properties.Tools.Library_Level_Header
              (Asis.Elements.Enclosing_Compilation_Unit (Element)));
      end if;

      Text.Append ("function (_parent){");
      Text.Append ("var _ec = new _parent._nested();");

      if Is_Library_Level then
         Text.Append ("_parent.");
         Text.Append (Down);
         Text.Append (" = _ec;");
      end if;

      Text.Append ("_ec._nested = function (){};");
      Text.Append ("_ec._nested.prototype = _ec;");

      for J in List'Range loop
         Down := League.Holders.Element (Engine.Get_Property (List (J), Name));
         Text.Append (Down);
      end loop;

      Text.Append ("return _ec;");
      Text.Append ("}");

      if Is_Library_Level then
         Text.Append (");");
      end if;

      return League.Holders.To_Holder (Text);
   end Code;

   ------------------------
   -- Declaration_Prefix --
   ------------------------

   function Declaration_Prefix
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
      pragma Unreferenced (Name);
      Text : League.Strings.Universal_String;
   begin
      Text := League.Holders.Element
        (Engine.Get_Property
           (Asis.Declarations.Names (Element) (1),
            Engines.Property_Names.Code));
      Text.Append (".");

      return League.Holders.To_Holder (Text);
   end Declaration_Prefix;

end Properties.Declarations.Package_Declaration;
