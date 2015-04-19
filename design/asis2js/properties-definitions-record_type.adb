with Asis.Declarations;

with Properties.Tools;

package body Properties.Definitions.Record_Type is

   ----------------
   -- Initialize --
   ----------------

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      List : constant Asis.Declaration_List :=
        Properties.Tools.Corresponding_Type_Components (Element);
      Text : League.Strings.Universal_String;
      Down : League.Strings.Universal_String;
   begin
      Text.Append ("{");

      for J in List'Range loop
         declare
            Id    : League.Strings.Universal_String;
            Names : constant Asis.Defining_Name_List :=
              Asis.Declarations.Names (List (J));
         begin
            Down := Engine.Text.Get_Property (List (J), Name);

            for N in Names'Range loop
               Id := Engine.Text.Get_Property (Names (N), Engines.Code);
               Text.Append (Id);
               Text.Append (":");
               Text.Append (Down);

               if N /= Names'Last then
                  Text.Append (",");
               end if;
            end loop;

            if J /= List'Last then
               Text.Append (",");
            end if;
         end;
      end loop;

      Text.Append ("}");
      return Text;
   end Initialize;

end Properties.Definitions.Record_Type;
