with Ada.Wide_Wide_Text_IO;

with League.Strings;
with SQL.Databases;
with SQL.Options;

with Matreshka.Internals.SQL_Drivers.PostgreSQL.Factory;

with Forum.Categories.References;
with Forum.Categories.Objects.Stores;
with Forum.Forums;
with Forum.Topics.References;
with Forum.Topics.Objects.Stores;
with Forum.Posts.References;

procedure Tst is
   O  : SQL.Options.SQL_Options;
   F  : Forum.Forums.Forum;

begin
   O.Set
      (League.Strings.To_Universal_String ("dbname"),
       League.Strings.To_Universal_String ("forum"));
   F.Initialize (League.Strings.To_Universal_String ("POSTGRESQL"), O);

   declare
      C : Forum.Categories.References.Category
        := F.Create_Category
            (League.Strings.To_Universal_String ("категория"),
             League.Strings.To_Universal_String
               ("пробная категория для тестирования"));

      T : Forum.Topics.References.Topic
        := F.Create_Topic
            (C,
             League.Strings.To_Universal_String ("тема 1"),
             League.Strings.To_Universal_String
               ("пробная тема для тестирования"));

      P : Forum.Posts.References.Post
        := F.Create_Post
            (T,
             League.Strings.To_Universal_String
               ("ТекСт В пробной теме тестированИя 1"));
   begin
      null;
   end;

   for C of F.Get_Categories loop
      Ada.Wide_Wide_Text_IO.Put_Line (C.Object.Get_Title.To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Put_Line
       (C.Object.Get_Description.To_Wide_Wide_String);
   end loop;

--      ST.Initialize (D'Unchecked_Access);
--      T.Initialize (ST'Unchecked_Access, 1);
--
--      Ada.Wide_Wide_Text_IO.Put_Line (T.Object.Get_Title.To_Wide_Wide_String);
end Tst;
