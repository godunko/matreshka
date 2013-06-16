with Ada.Containers.Vectors;
with League.Strings;

with Zip.IO;

package Zip.Metadata is

   type File_Record is record
      File_Name : League.Strings.Universal_String;
   end record;

   package File_Record_Vectors is
     new Ada.Containers.Vectors (Positive, File_Record);

   type Central_Directory is record
      Files : File_Record_Vectors.Vector;
   end record;

   function Read (File : Zip.IO.File_Type) return Central_Directory;

end Zip.Metadata;
