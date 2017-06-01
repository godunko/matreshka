with Ada.Streams;
with Ada.Text_IO;
with Interfaces;

with League.Calendars;
with League.Stream_Element_Vectors;
with League.Strings;
with League.Text_Codecs;

--  with Zip.Metadata.Local_File_Headers; use Zip.Metadata.Local_File_Headers;
with Zip.IO_Types;

package body Zip.Metadata is

   use type Ada.Streams.Stream_Element_Offset;
--   use type Zip.Stream_Element_IO.Count;

   End_Of_Central_Directory_Signature :
     constant Ada.Streams.Stream_Element_Array (0 .. 3)
       := (16#50#, 16#4B#, 16#05#, 16#06#);

   ZIP64_End_Of_Central_Directory_Locator_Signature :
     constant Ada.Streams.Stream_Element_Array (0 .. 3)
       := (16#50#, 16#4B#, 16#06#, 16#07#);

   Central_Directory_Header_Signature :
     constant Ada.Streams.Stream_Element_Array (0 .. 3)
       := (16#50#, 16#4B#, 16#01#, 16#02#);

   Local_File_Header_Signature :
     constant Ada.Streams.Stream_Element_Array (0 .. 3)
       := (16#50#, 16#4B#, 16#03#, 16#04#);

   type End_Of_Central_Directory_Record is record
      Number_Of_This_Disk,
      Number_Of_The_Disk_With_The_Start_Of_The_Central_Directory,
      Total_Number_Of_Entries_In_The_Central_Directory_On_This_Disk,
      Total_Number_Of_Entries_In_The_Central_Directory :
        Zip.IO_Types.Unsigned_16;
      Size_Of_The_Central_Directory  : Zip.IO_Types.Size;
      Offset_Of_Central_Directory_With_Respect_To_The_Starting_Disk_Number :
        Zip.IO_Types.Size;
      ZIP_File_Comment_Length  : Zip.IO_Types.Length;
   end record;

   type ZIP64_End_Of_Central_Directory_Locator is record
      Number_Of_The_Disk_With_The_Start_Of_The_ZIP64_End_Of_Central_Directory :
        Ada.Streams.Stream_Element_Array (0 .. 3);
      Relative_Offset_Of_The_ZIP64_End_Of_Central_Directory_Record :
        Ada.Streams.Stream_Element_Array (0 .. 7);
      Total_Number_Of_Disks :
        Ada.Streams.Stream_Element_Array (0 .. 3);
   end record;

   type Local_File_Header is record
      Version_Needed_To_Extract       : Zip.IO_Types.Version;
      General_Purpose_Bit_Flag        : Zip.IO_Types.Flags;
      Compression_Method              : Zip.IO_Types.Method;
      Last_Modified                   : Zip.IO_Types.Date_Time;
      CRC32                           : Zip.IO_Types.CRC32;
      Compressed_Size                 : Zip.IO_Types.Size;
      Uncompressed_Size               : Zip.IO_Types.Size;
      File_Name_Length                : Zip.IO_Types.Length;
      Extra_Field_Length              : Zip.IO_Types.Length;
   end record;

   type Central_Directory_File_Header is record
      Version_Made_By                 : Zip.IO_Types.Version;
      Version_Needed_To_Extract       : Zip.IO_Types.Version;
      General_Purpose_Bit_Flag        : Zip.IO_Types.Flags;
      Compression_Method              : Zip.IO_Types.Method;
      Last_Modified                   : Zip.IO_Types.Date_Time;
      CRC32                           : Zip.IO_Types.CRC32;
      Compressed_Size                 : Zip.IO_Types.Size;
      Uncompressed_Size               : Zip.IO_Types.Size;
      File_Name_Length                : Zip.IO_Types.Length;
      Extra_Field_Length              : Zip.IO_Types.Length;
      File_Comment_Length             : Zip.IO_Types.Length;
      Disk_Number_Start               : Zip.IO_Types.Unsigned_16;
      Internal_File_Attributes        : Zip.IO_Types.Unsigned_16;
      External_File_Attributes        : Zip.IO_Types.Unsigned_32;
      Relative_Offset_Of_Local_Header : Zip.IO_Types.Unsigned_32;
   end record;

   Signature_Length  : constant Ada.Streams.Stream_Element_Offset := 4;

   End_Of_Central_Directory_Record_Length  :
     constant Ada.Streams.Stream_Element_Offset := 4 * 2 + 2 * 4 + 2;
   ZIP64_End_Of_Central_Directory_Locator_Length :
     constant Ada.Streams.Stream_Element_Offset := 4 + 8 + 4;
   Central_Directory_File_Header_Length : constant := 42;
   Local_File_Header_Length :
     constant Ada.Streams.Stream_Element_Offset := 26;

   function To_Stream_Element_Offset
    (Item : Ada.Streams.Stream_Element_Array)
     return Ada.Streams.Stream_Element_Offset;

   procedure Read_String
     (File   : Zip.IO.File_Type;
      Length : Ada.Streams.Stream_Element_Offset;
      Value  : out League.Strings.Universal_String);

--   ----------
--   -- Read --
--   ----------
--
--   procedure Read
--    (File : Zip.Stream_Element_IO.File_Type;
--     Item : out Ada.Streams.Stream_Element_Array) is
--   begin
--      for J in Item'Range loop
--         Zip.Stream_Element_IO.Read (File, Item (J));
--      end loop;
--   end Read;
--
   ----------
   -- Read --
   ----------

   function Read (File : access Zip.IO.File_Type) return Central_Directory is
      use type Ada.Streams.Stream_Element;
      use type Ada.Streams.Stream_Element_Array;
      use type Ada.Streams.Stream_Element_Offset;

      Signature : Ada.Streams.Stream_Element_Array (0 .. 3);
--      Header    : Local_File_Header_Type;
      Result    : Central_Directory;
      File_Info : File_Record;

   begin
--      loop
--         Read (File, Signature);
--
--         if Signature /= Local_File_Header_Signature then
--            Ada.Text_IO.Put_Line
--             (Ada.Streams.Stream_Element'Image (Signature (0))
--               & Ada.Streams.Stream_Element'Image (Signature (1))
--               & Ada.Streams.Stream_Element'Image (Signature (2))
--               & Ada.Streams.Stream_Element'Image (Signature (3)));
--            raise Program_Error;
--         end if;
--
--         Read (File, Header);
--
--         Ada.Text_IO.Put_Line (Header.File_Name.To_UTF_8_String);
--
--         Zip.Stream_Element_IO.Set_Index
--          (File, Zip.Stream_Element_IO.Index (File) + Header.Compressed_Size);
--      end loop;
      null;

      --  Lookup for central directory at the end of file.

      declare
         Record_Size                : constant
           Ada.Streams.Stream_Element_Offset
             := End_Of_Central_Directory_Record_Length + Signature_Length;
         Maximum_Lookup_Buffer_Size : constant
           Ada.Streams.Stream_Element_Offset := 2 ** 16 - 1 + Record_Size;
         File_Size                  : constant Zip_File_Offset := File.Get_Size;
         Lookup_Buffer_Size         : constant
           Ada.Streams.Stream_Element_Offset
             := Ada.Streams.Stream_Element_Offset'Min
                 (Maximum_Lookup_Buffer_Size,
                  Ada.Streams.Stream_Element_Offset (File_Size));

         Position           : constant Zip_File_Offset
           := File_Size - Zip_File_Offset (Lookup_Buffer_Size);
         Buffer             : Ada.Streams.Stream_Element_Array
           (1 .. Lookup_Buffer_Size);
         Record_Position    : Zip_File_Offset := 0;
         Directory_Position : Zip_File_Offset;

      begin
         File.Set_Position (Position);
         File.Read (Buffer);

         for J in reverse Buffer'First .. Buffer'Last - Record_Size + 1 loop
            if Buffer (J .. J + Signature_Length - 1)
                 = End_Of_Central_Directory_Signature
            then
               declare
                  Raw_Record      : End_Of_Central_Directory_Record;
               begin
                  --  Exit when total size of end of central directory record
                  --  is confirmed by record's position (it should be placed at
                  --  the end of the archive file).
                  File.Set_Position
                    (Position + Zip_File_Offset (J + Signature_Length - 1));
                  End_Of_Central_Directory_Record'Read (File, Raw_Record);

                  if Ada.Streams.Stream_Element_Offset
                      (Raw_Record.ZIP_File_Comment_Length)
                         = Buffer'Last - (J + Record_Size - 1)
                  then
                     Record_Position := Position + Zip_File_Offset (J) - 1;

                     Directory_Position :=
                       Zip_File_Offset
                         (Raw_Record
       .Offset_Of_Central_Directory_With_Respect_To_The_Starting_Disk_Number);

                     Ada.Text_IO.Put_Line
                       ("offset of central directory record position:" &
                          Zip_File_Offset'Image (Directory_Position));

                     exit;
                  end if;

                  --  Otherwise, continue to lookup for end of central
                  --  directory record signature.
               end;
            end if;
         end loop;

         Ada.Text_IO.Put_Line ("end of central directory record position:" &
                                 Zip_File_Offset'Image (Record_Position));

         File.Set_Position
           (Record_Position
            - Zip_File_Offset (ZIP64_End_Of_Central_Directory_Locator_Length)
            - Zip_File_Offset (Signature_Length));
         File.Read (Signature);

         if Signature = ZIP64_End_Of_Central_Directory_Locator_Signature then
            Ada.Text_IO.Put_Line
             ("end of central directory record position:"
                & Zip_File_Offset'Image
                   (Record_Position - Zip_File_Offset (ZIP64_End_Of_Central_Directory_Locator_Length) - Zip_File_Offset (Signature_Length)));

            raise Program_Error with "ZIP64 is not implemented now";
         end if;

         File.Set_Position (Directory_Position);

         while File.Get_Position < Record_Position loop
            File_Info := (others => <>);

            File.Read (Signature);

            if Signature /= Central_Directory_Header_Signature then
               raise Program_Error;
            end if;

--            Ada.Text_IO.Put_Line ("read CDH");

            declare
               use type Zip.IO_Types.Flags;
               Raw_Header  : Central_Directory_File_Header;
               Name_Length : ZIP_File_Offset_16;

            begin
               Central_Directory_File_Header'Read (File, Raw_Header);
               Name_Length := ZIP_File_Offset_16 (Raw_Header.File_Name_Length);

               File_Info :=
                 (File_Name               => <>,
                  Method                  => Zip.Compression_Method
                    (Raw_Header.Compression_Method),
                  Last_Modified => League.Calendars.Date_Time
                    (Raw_Header.Last_Modified),
                  CRC32                   => GNAT.CRC32.CRC32
                    (Raw_Header.CRC32),
                  Compressed_Size         => Ada.Streams.Stream_Element_Offset
                    (Raw_Header.Compressed_Size),
                  Uncompressed_Size       => Ada.Streams.Stream_Element_Offset
                    (Raw_Header.Uncompressed_Size),
                  Has_Data_Descriptor     =>
                    (Raw_Header.General_Purpose_Bit_Flag and
                         IO_Types.Has_Data_Descriptor) /= 0,
                  Local_Header_Offset     => Ada.Streams.Stream_Element_Offset
                    (Raw_Header.Relative_Offset_Of_Local_Header));
--               Ada.Text_IO.Put_Line ("file name length:" & Zip_File_Offset'Image (Name_Length));

               Read_String
                 (File   => File.all,
                  Length => Ada.Streams.Stream_Element_Offset (Name_Length),
                  Value  => File_Info.File_Name);
            end;

            Result.Files.Append (File_Info);
         end loop;
      end;

      return Result;
   end Read;

   ----------------------------
   -- Read_Local_File_Header --
   ----------------------------

   procedure Read_Local_File_Header
     (Stream : access Zip.IO.File_Type;
      Header : out File_Record)
   is
      use type Ada.Streams.Stream_Element_Array;
      use type Zip.IO_Types.Flags;

      Result    : Local_File_Header;
      Signature : Ada.Streams.Stream_Element_Array (0 .. 3);
      Offset    : Zip.Zip_File_Offset := Stream.Get_Position;
   begin
      Ada.Streams.Stream_Element_Array'Read (Stream, Signature);
      pragma Assert (Signature = Local_File_Header_Signature);
      Local_File_Header'Read (Stream, Result);

      Header :=
        (File_Name           => <>,
         Method              => Zip.Compression_Method
           (Result.Compression_Method),
         CRC32               => GNAT.CRC32.CRC32 (Result.CRC32),
         Last_Modified       => League.Calendars.Date_Time
           (Result.Last_Modified),
         Compressed_Size     => Ada.Streams.Stream_Element_Offset
           (Result.Compressed_Size),
         Uncompressed_Size   => Ada.Streams.Stream_Element_Offset
           (Result.Uncompressed_Size),
         Has_Data_Descriptor => (Result.General_Purpose_Bit_Flag and
                                     IO_Types.Has_Data_Descriptor) /= 0,
         Local_Header_Offset => Ada.Streams.Stream_Element_Offset (Offset));

      Read_String
        (File   => Stream.all,
         Length =>
           Ada.Streams.Stream_Element_Offset (Result.File_Name_Length),
         Value  => Header.File_Name);
   end Read_Local_File_Header;

   -----------------
   -- Read_String --
   -----------------

   procedure Read_String
     (File   : Zip.IO.File_Type;
      Length : Ada.Streams.Stream_Element_Offset;
      Value  : out League.Strings.Universal_String)
   is
      Buffer : Ada.Streams.Stream_Element_Array (1 .. Length);
      Codec  : League.Text_Codecs.Text_Codec := League.Text_Codecs.Codec
        (League.Strings.To_Universal_String ("IBM437"));

   begin
      File.Read (Buffer);
      Value := Codec.Decode (Buffer);
   end Read_String;


   ------------------------------
   -- To_Stream_Element_Offset --
   ------------------------------

   function To_Stream_Element_Offset
    (Item : Ada.Streams.Stream_Element_Array)
     return Ada.Streams.Stream_Element_Offset
   is
      use type Ada.Streams.Stream_Element_Offset;
      Result : Ada.Streams.Stream_Element_Offset := 0;
   begin
      for J of reverse Item loop
         Result := Result * 2 ** 8 + Ada.Streams.Stream_Element_Offset (J);
      end loop;

      return Result;
   end To_Stream_Element_Offset;

   -----------
   -- Write --
   -----------

   procedure Write
     (Stream    : access Ada.Streams.Root_Stream_Type'Class;
      Offset    : Zip.Zip_File_Offset;
      Directory : Central_Directory)
   is
      Codec  : constant League.Text_Codecs.Text_Codec := League.Text_Codecs.Codec
        (League.Strings.To_Universal_String ("UTF-8"));

      Total : Zip.IO_Types.Size := 0;
   begin
      for X of Directory.Files loop
         declare
            use Zip.IO_Types;

            Name : constant League.Stream_Element_Vectors.Stream_Element_Vector
              := Codec.Encode (X.File_Name);

            Header : Central_Directory_File_Header :=
              (Version_Made_By           => 20,
               Version_Needed_To_Extract => 20,
               General_Purpose_Bit_Flag  => Use_UTF_8_Names,
               Compression_Method        => Method (X.Method),
               Last_Modified             => Date_Time (X.Last_Modified),
               CRC32                     => CRC32 (X.CRC32),
               Compressed_Size           => Size (X.Compressed_Size),
               Uncompressed_Size         => Size (X.Uncompressed_Size),
               File_Name_Length          => Length (Name.Length),
               Extra_Field_Length        => 0,
               File_Comment_Length       => 0,
               Disk_Number_Start         => 0,
               Internal_File_Attributes  => 0,
               External_File_Attributes  => 0,
               Relative_Offset_Of_Local_Header => Unsigned_32
                 (X.Local_Header_Offset));
         begin
            Ada.Streams.Stream_Element_Array'Write
              (Stream, Central_Directory_Header_Signature);
            Central_Directory_File_Header'Write (Stream, Header);
            Ada.Streams.Stream_Element_Array'Write
              (Stream, Name.To_Stream_Element_Array);

            Total := Total + 4 + Central_Directory_File_Header_Length +
              Size (Name.Length);
         end;
      end loop;

      declare
         Count : Zip.IO_Types.Unsigned_16 :=
           Zip.IO_Types.Unsigned_16 (Directory.Files.Length);

         Header : End_Of_Central_Directory_Record :=
           (Number_Of_This_Disk => 0,
            Number_Of_The_Disk_With_The_Start_Of_The_Central_Directory => 0,
            Total_Number_Of_Entries_In_The_Central_Directory_On_This_Disk |
            Total_Number_Of_Entries_In_The_Central_Directory  => Count,
            Size_Of_The_Central_Directory => Total,
          Offset_Of_Central_Directory_With_Respect_To_The_Starting_Disk_Number
            => Zip.IO_Types.Size (Offset),
            ZIP_File_Comment_Length => 0);
      begin
         Ada.Streams.Stream_Element_Array'Write
           (Stream, End_Of_Central_Directory_Signature);
         End_Of_Central_Directory_Record'Write (Stream, Header);
      end;
   end Write;

   -----------------------------
   -- Write_Local_File_Header --
   -----------------------------

   procedure Write_Local_File_Header
     (Stream : access Ada.Streams.Root_Stream_Type'Class;
      Header : File_Record)
   is
      Codec  : constant League.Text_Codecs.Text_Codec := League.Text_Codecs.Codec
        (League.Strings.To_Universal_String ("UTF-8"));

      Name : constant League.Stream_Element_Vectors.Stream_Element_Vector :=
        Codec.Encode (Header.File_Name);

      Value : constant Local_File_Header :=
        (Version_Needed_To_Extract => 20,
         General_Purpose_Bit_Flag  => IO_Types.Use_UTF_8_Names,
         Compression_Method        => IO_Types.Method (Header.Method),
         Last_Modified             => IO_Types.Date_Time (Header.Last_Modified),
         CRC32                     => IO_Types.CRC32 (Header.CRC32),
         Compressed_Size           => IO_Types.Size (Header.Compressed_Size),
         Uncompressed_Size         => IO_Types.Size (Header.Uncompressed_Size),
         File_Name_Length          => IO_Types.Length (Name.Length),
         Extra_Field_Length        => 0);
   begin
      Stream.Write (Local_File_Header_Signature);
      Local_File_Header'Write (Stream, Value);
      Ada.Streams.Stream_Element_Array'Write
        (Stream, Name.To_Stream_Element_Array);
   end Write_Local_File_Header;

end Zip.Metadata;
