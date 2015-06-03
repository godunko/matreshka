with Ada.Wide_Wide_Text_IO;

with League.Strings;
with SQL.Databases;
with SQL.Options;

with Matreshka.Internals.SQL_Drivers.PostgreSQL.Factory;

with Forum.Forums.References;
with Forum.Forums.Objects.Stores;
with Forum.Topics.References;
with Forum.Topics.Objects.Stores;

procedure Tst is
   O : SQL.Options.SQL_Options;
   S : aliased Forum.Forums.Objects.Stores.Forum_Store;
   F : Forum.Forums.References.Forum_Reference;
   ST : aliased Forum.Topics.Objects.Stores.Topic_Store;
   T  : Forum.Topics.References.Topic_Reference;

begin
   O.Set
      (League.Strings.To_Universal_String ("dbname"),
       League.Strings.To_Universal_String ("forum"));

   declare
      D : aliased SQL.Databases.SQL_Database
        := SQL.Databases.Create
            (League.Strings.To_Universal_String ("POSTGRESQL"), O);

   begin
      D.Open;
      S.Initialize (D'Unchecked_Access);
      F.Initialize (S'Unchecked_Access, 1);
      ST.Initialize (D'Unchecked_Access);
      T.Initialize (St'Unchecked_Access, 1);

      Ada.Wide_Wide_Text_IO.Put_Line (F.Object.Get_Title.To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Put_Line
       (F.Object.Get_Description.To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Put_Line (T.Object.Get_Title.To_Wide_Wide_String);

      D.Close;
   end;
end Tst;
