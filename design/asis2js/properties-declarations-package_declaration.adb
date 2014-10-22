with Asis.Declarations;
with Asis.Elements;

with League.String_Vectors;

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

      Full_Name : League.Strings.Universal_String;

      Parents : League.Strings.Universal_String;
      Down : League.Strings.Universal_String;
      Text : League.Strings.Universal_String;
      List : constant Asis.Element_List :=
        Asis.Declarations.Visible_Part_Declarative_Items (Element) &
        Asis.Declarations.Private_Part_Declarative_Items (Element) &
        Body_Declarative_Items (Element);
   begin
      Down := League.Holders.Element
        (Engine.Get_Property (Asis.Declarations.Names (Element) (1), Name));
      Down.Prepend ("standard.");

      declare
         Names  : constant League.String_Vectors.Universal_String_Vector :=
          Down.Split ('.');
      begin
         for J in 1 .. Names.Length loop
            if J /= 1 then
               Full_Name.Append (".");
            end if;

            Full_Name.Append (Names.Element (J));

            --  Make each parent package visible by 'with(obj)' statement
            Parents.Append ("with (");
            Parents.Append (Full_Name);
            Parents.Append (")");
         end loop;
      end;

      Text.Append (Full_Name);
      Text.Append ("={};");
      Text.Append (Parents);
      Text.Append ("{");

      for J in List'Range loop
         Down := League.Holders.Element (Engine.Get_Property (List (J), Name));

         if not Down.Is_Empty then
            Text.Append (Full_Name);
            Text.Append (".");
            Text.Append (Down);
         end if;
      end loop;

      Text.Append ("};");

      return League.Holders.To_Holder (Text);
   end Code;

end Properties.Declarations.Package_Declaration;
