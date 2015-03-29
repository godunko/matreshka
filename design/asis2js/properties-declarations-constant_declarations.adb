with Asis.Declarations;
with Asis.Elements;

package body Properties.Declarations.Constant_Declarations is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      List : constant Asis.Defining_Name_List :=
        Asis.Declarations.Names (Element);

      Inside_Package : constant Boolean := Engine.Boolean.Get_Property
        (Element, Engines.Inside_Package);

      Init_Code : League.Strings.Universal_String;

      Constant_Name : League.Strings.Universal_String;
      Text  : League.Strings.Universal_String;
   begin
      Init_Code := Engine.Text.Get_Property (Element, Engines.Initialize);

      for J in List'Range loop
         if Inside_Package then
            Text.Append ("_ec.");
         else
            Text.Append ("var ");
         end if;

         Constant_Name := Engine.Text.Get_Property (List (J), Name);
         Text.Append (Constant_Name);

         if not Init_Code.Is_Empty then
            Text.Append (" = ");
            Text.Append (Init_Code);
         end if;

         Text.Append (";");
      end loop;

      return Text;
   end Code;

   ----------------
   -- Initialize --
   ----------------

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Is_Simple_Ref : constant Boolean :=
        Engine.Boolean.Get_Property (Element, Engines.Is_Simple_Ref);
      Tipe : constant Asis.Definition :=
        Asis.Declarations.Object_Declaration_View (Element);
      Init : constant Asis.Expression :=
        Asis.Declarations.Initialization_Expression (Element);
      Result : League.Strings.Universal_String;
   begin
      if Is_Simple_Ref then
         Result.Append ("{all: ");
      end if;

      if not Asis.Elements.Is_Nil (Init) then
         Result.Append (Engine.Text.Get_Property (Init, Engines.Code));
      else
         Result.Append (Engine.Text.Get_Property (Tipe, Name));
      end if;

      if Is_Simple_Ref then
         Result.Append ("}");
      end if;

      return Result;
   end Initialize;

   -------------------
   -- Is_Simple_Ref --
   -------------------

   function Is_Simple_Ref
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Boolean_Property) return Boolean
   is
      pragma Unreferenced (Name);
      Tipe : constant Asis.Definition :=
        Asis.Declarations.Object_Declaration_View (Element);
   begin
      return Asis.Elements.Has_Aliased (Element) and then
        Engine.Boolean.Get_Property (Tipe, Engines.Is_Simple_Type);
   end Is_Simple_Ref;

end Properties.Declarations.Constant_Declarations;
