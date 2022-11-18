with Ada.Streams;
with Interfaces;

with League.Stream_Element_Vectors;
with League.Strings;

private package Zip.Metadata.Local_File_Headers is

   Local_File_Header_Signature :
     constant Ada.Streams.Stream_Element_Array (0 .. 3)
       := (16#50#, 16#4B#, 16#03#, 16#04#);

   type Local_File_Header_Type is record
      Position        : Zip_File_Offset;
      Compressed_Size : Zip_File_Offset;
      File_Name       : League.Strings.Universal_String;
      Extra_Field     : League.Stream_Element_Vectors.Stream_Element_Vector;
   end record;

   procedure Read
    (File   : Zip.IO.File_Type;
     Header : out Local_File_Header_Type);

end Zip.Metadata.Local_File_Headers;
