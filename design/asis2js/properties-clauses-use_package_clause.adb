with Asis.Clauses;
with Asis.Elements;

package body Properties.Clauses.Use_Package_Clause is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
      List : constant Asis.Name_List :=
        Asis.Clauses.Clause_Names (Element);

      Parent : constant Asis.Element :=
        Asis.Elements.Enclosing_Element (Element);

      Code  : League.Strings.Universal_String;
      Text  : League.Strings.Universal_String;
   begin
      if Asis.Elements.Is_Nil (Parent) then
         for J in List'Range loop
            Code := League.Holders.Element
              (Engine.Get_Property (List (J), Name));

            if not Code.Starts_With ("webapi") then
               Text.Append ("with (standard.");
               Text.Append (Code);
               Text.Append (")");
            end if;
         end loop;
      end if;

      return League.Holders.To_Holder (Text);
   end Code;

end Properties.Clauses.Use_Package_Clause;
