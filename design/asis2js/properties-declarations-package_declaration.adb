with Asis.Declarations;
with Asis.Elements;

--  with League.String_Vectors;

with Properties.Tools;

package body Properties.Declarations.Package_Declaration is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
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

      Inside_Package : constant Boolean := Engine.Boolean.Get_Property
        (Element, Engines.Inside_Package);

      Named : League.Strings.Universal_String;
      Down  : League.Strings.Universal_String;
      Text  : League.Strings.Universal_String;
      List  : constant Asis.Element_List :=
        Asis.Declarations.Visible_Part_Declarative_Items (Element) &
        Asis.Declarations.Private_Part_Declarative_Items (Element) &
        Body_Declarative_Items (Element);
   begin
      Named := Engine.Text.Get_Property
        (Asis.Declarations.Names (Element) (1), Name);

      if Is_Library_Level then
         Text.Append
           (Properties.Tools.Library_Level_Header
              (Asis.Elements.Enclosing_Compilation_Unit (Element)));
         Text.Append ("return ");
      end if;

      if not Inside_Package then
         Text.Append ("var ");
         Text.Append (Named);
         Text.Append ("=");
      end if;

      Text.Append ("(function (_ec){");
      Text.Append ("_ec._nested = function (){};");
      Text.Append ("_ec._nested.prototype = _ec;");

      for J in List'Range loop
         Down := Engine.Text.Get_Property (List (J), Name);
         Text.Append (Down);
      end loop;

      Text.Append ("return _ec;");
      Text.Append ("})(");

      if Inside_Package then
         Text.Append ("_ec.");
         Text.Append (Named);
         Text.Append ("=");
      end if;

      Text.Append ("new _ec._nested());");

      if Is_Library_Level then
         Text.Append ("});");
      end if;

      return Text;
   end Code;

end Properties.Declarations.Package_Declaration;
