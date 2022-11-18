with Ada.Containers.Vectors;
with Ada.Streams;
with GNAT.CRC32;
with League.Calendars;
with League.Strings;

with Zip.IO;

package Zip.Metadata is

   type File_Record is record
      File_Name           : League.Strings.Universal_String;
      Method              : Compression_Method;
      Last_Modified       : League.Calendars.Date_Time;
      CRC32               : GNAT.CRC32.CRC32;
      Compressed_Size     : Ada.Streams.Stream_Element_Offset;
      Uncompressed_Size   : Ada.Streams.Stream_Element_Offset;
      Has_Data_Descriptor : Boolean;
      Local_Header_Offset : Ada.Streams.Stream_Element_Offset;
   end record;

   package File_Record_Vectors is
     new Ada.Containers.Vectors (Positive, File_Record);

   type Central_Directory is record
      Files : File_Record_Vectors.Vector;
   end record;

   function Read (File : access Zip.IO.File_Type) return Central_Directory;

   procedure Write
     (Stream    : access Ada.Streams.Root_Stream_Type'Class;
      Offset    : Zip.Zip_File_Offset;
      Directory : Central_Directory);

   procedure Read_Local_File_Header
     (Stream : access Zip.IO.File_Type;
      Header : out File_Record);

   procedure Write_Local_File_Header
     (Stream : access Ada.Streams.Root_Stream_Type'Class;
      Header : File_Record);

end Zip.Metadata;
