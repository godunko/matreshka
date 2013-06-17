with Ada.Wide_Wide_Text_IO;

with League.Application;
with League.Directories;
with League.String_Vectors;
with League.Files;
with Matreshka.Zip_File_System_Engines;

procedure Main is

   procedure List
    (Directory : League.Directories.Directory_Information;
     Depth     : Natural)
   is
      Entries : League.String_Vectors.Universal_String_Vector
        := Directory.Entry_List;
      File    : League.Files.File_Information;

   begin
      for J in 1 .. Entries.Length loop
         File := League.Files.To_File_Information (Directory, Entries (J));

         if File.Is_Directory then
            Ada.Wide_Wide_Text_IO.Put (" (Dir) ");

         else
            Ada.Wide_Wide_Text_IO.Put ("       ");
         end if;

         for J in 1 .. Depth loop
            if J /= Depth then
               Ada.Wide_Wide_Text_IO.Put ("   ");

            else
               Ada.Wide_Wide_Text_IO.Put (" - ");
            end if;
         end loop;

         Ada.Wide_Wide_Text_IO.Put_Line (Entries (J).To_Wide_Wide_String);

         if File.Is_Directory then
            List (File.To_Directory_Information, Depth + 1);
         end if;
      end loop;
   end List;

   D : League.Directories.Directory_Information
     := League.Directories.To_Directory_Information
         (League.Application.Arguments.Element (1));
   V : League.String_Vectors.Universal_String_Vector := D.Entry_List;
   F : League.Files.File_Information;

begin
   Ada.Wide_Wide_Text_IO.Put_Line ("tree of archive");
   List (D, 0);
end Main;
