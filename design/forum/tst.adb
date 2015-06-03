with Ada.Wide_Wide_Text_IO;

with League.Strings;
with SQL.Databases;
with SQL.Options;

with Matreshka.Internals.SQL_Drivers.PostgreSQL.Factory;

with Forum.Categories.References;
with Forum.Categories.Objects.Stores;
with Forum.Topics.References;
with Forum.Topics.Objects.Stores;

procedure Tst is
   O  : SQL.Options.SQL_Options;
   SC : aliased Forum.Categories.Objects.Stores.Category_Store;
   C  : Forum.Categories.References.Category;
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
      SC.Initialize (D'Unchecked_Access);
      C.Initialize (SC'Unchecked_Access, 1);
      ST.Initialize (D'Unchecked_Access);
      T.Initialize (ST'Unchecked_Access, 1);

      Ada.Wide_Wide_Text_IO.Put_Line (C.Object.Get_Title.To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Put_Line
       (C.Object.Get_Description.To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Put_Line (T.Object.Get_Title.To_Wide_Wide_String);

      D.Close;
   end;
end Tst;
