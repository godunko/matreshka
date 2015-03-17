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

      Init_Code : League.Strings.Universal_String;
      Prefix    : League.Strings.Universal_String;

      Constant_Name : League.Strings.Universal_String;
      Text  : League.Strings.Universal_String;
   begin
      Init_Code := Engine.Text.Get_Property (Element, Engines.Initialize);

      for J in List'Range loop
         Prefix := Engine.Text.Get_Property
              (Asis.Elements.Enclosing_Element (Element),
               Engines.Declaration_Prefix);

         Text.Append (Prefix);

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
      Tipe : constant Asis.Definition :=
        Asis.Declarations.Object_Declaration_View (Element);
      Init : constant Asis.Expression :=
        Asis.Declarations.Initialization_Expression (Element);
   begin
      if not Asis.Elements.Is_Nil (Init) then
         return Engine.Text.Get_Property (Init, Engines.Code);
      else
         return Engine.Text.Get_Property (Tipe, Name);
      end if;
   end Initialize;

end Properties.Declarations.Constant_Declarations;
