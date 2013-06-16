with Ada.Wide_Wide_Text_IO;

with League.Application;
with League.Directories;
with League.String_Vectors;
with League.Files;
with Matreshka.Zip_File_System_Engines;

procedure Main is
   D : League.Directories.Directory_Information
     := League.Directories.To_Directory_Information
         (League.Application.Arguments.Element (1));
   V : League.String_Vectors.Universal_String_Vector := D.Entry_List;
   F : League.Files.File_Information;

begin
   Ada.Wide_Wide_Text_IO.Put_Line ("list of entries in archive's root directory");

   for J in 1 .. V.Length loop
      Ada.Wide_Wide_Text_IO.Put_Line ("  " & V (J).To_Wide_Wide_String);
      F := League.Files.To_File_Information (D, V (J));
   end loop;
end Main;
