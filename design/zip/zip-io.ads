private with Ada.Direct_IO;
with Ada.Streams;

package Zip.IO is

   type File_Type is limited private;

   procedure Open (File : out File_Type; Name : String);

   procedure Close (File : in out File_Type);

   procedure Read (File : File_Type; Data : out Ada.Streams.Stream_Element_Array);

   function Get_Size (File : File_Type) return Zip_File_Offset;

   function Get_Position (File : File_Type) return Zip_File_Offset;

   procedure Set_Position (File : File_Type; Position : Zip_File_Offset);

private

   package Stream_Element_IO is new Ada.Direct_IO (Ada.Streams.Stream_Element);

   type File_Type is new Stream_Element_IO.File_Type;

end Zip.IO;
