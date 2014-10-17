with Asis.Declarations;

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

      First : Boolean := True;

      Down : League.Strings.Universal_String;
      Text : League.Strings.Universal_String;
      List : constant Asis.Element_List :=
        Asis.Declarations.Visible_Part_Declarative_Items (Element) &
        Asis.Declarations.Private_Part_Declarative_Items (Element);
   begin
      Text := League.Holders.Element
        (Engine.Get_Property (Asis.Declarations.Names (Element) (1), Name));
      Text.Append (" = {");

      for J in List'Range loop
         Down := League.Holders.Element
           (Engine.Get_Property (List (J), Name));

         if not Down.Is_Empty then
            if not First then
               Text.Append (", ");
            end if;

            Text.Append (Down);
            First := False;
         end if;
      end loop;

      Text.Append ("}");

      return League.Holders.To_Holder (Text);
   end Code;

end Properties.Declarations.Package_Declaration;
