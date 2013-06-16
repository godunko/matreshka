with Ada.Streams;
with Ada.Text_IO;
with Interfaces;

with League.Strings;
with League.Text_Codecs;

with Zip.Metadata.Local_File_Headers; use Zip.Metadata.Local_File_Headers;

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

   type End_Of_Central_Directory_Record is record
      Number_Of_This_Disk                                           : Ada.Streams.Stream_Element_Array (0 .. 1);
      Number_Of_The_Disk_With_The_Start_Of_The_Central_Directory    : Ada.Streams.Stream_Element_Array (0 .. 1);
      Total_Number_Of_Entries_In_The_Central_Directory_On_This_Disk : Ada.Streams.Stream_Element_Array (0 .. 1);
      Total_Number_Of_Entries_In_The_Central_Directory              : Ada.Streams.Stream_Element_Array (0 .. 1);
      Size_Of_The_Central_Directory                                 : Ada.Streams.Stream_Element_Array (0 .. 3);
      Offset_Of_Start_Of_Central_Directory_With_Respect_To_The_Starting_Disk_Number : Ada.Streams.Stream_Element_Array (0 .. 3);
      ZIP_File_Comment_Length                                       : Ada.Streams.Stream_Element_Array (0 .. 1);
   end record;

   type ZIP64_End_Of_Central_Directory_Locator is record
      Number_Of_The_Disk_With_The_Start_Of_The_ZIP64_End_Of_Central_Directory : Ada.Streams.Stream_Element_Array (0 .. 3);
      Relative_Offset_Of_The_ZIP64_End_Of_Central_Directory_Record            : Ada.Streams.Stream_Element_Array (0 .. 7);
      Total_Number_Of_Disks                                                   : Ada.Streams.Stream_Element_Array (0 .. 3);
   end record;

   type Central_Directory_File_Header is record
      Version_Made_By                 : Ada.Streams.Stream_Element_Array (0 .. 1);
      Version_Needed_To_Extract       : Ada.Streams.Stream_Element_Array (0 .. 1);
      General_Purpose_Bit_Flag        : Ada.Streams.Stream_Element_Array (0 .. 1);
      Compression_Method              : Ada.Streams.Stream_Element_Array (0 .. 1);
      Last_Mod_File_Time              : Ada.Streams.Stream_Element_Array (0 .. 1);
      Last_Mod_File_Date              : Ada.Streams.Stream_Element_Array (0 .. 1);
      CRC32                           : Ada.Streams.Stream_Element_Array (0 .. 3);
      Compressed_Size                 : Ada.Streams.Stream_Element_Array (0 .. 3);
      Uncompressed_Size               : Ada.Streams.Stream_Element_Array (0 .. 3);
      File_Name_Length                : Ada.Streams.Stream_Element_Array (0 .. 1);
      Extra_Field_Length              : Ada.Streams.Stream_Element_Array (0 .. 1);
      File_Comment_Length             : Ada.Streams.Stream_Element_Array (0 .. 1);
      Disk_Number_Start               : Ada.Streams.Stream_Element_Array (0 .. 1);
      Internal_File_Attributes        : Ada.Streams.Stream_Element_Array (0 .. 1);
      External_File_Attributes        : Ada.Streams.Stream_Element_Array (0 .. 3);
      Relative_Offset_Of_Local_Header : Ada.Streams.Stream_Element_Array (0 .. 3);
   end record;

   Signature_Length                              : constant Ada.Streams.Stream_Element_Offset := 4;

   End_Of_Central_Directory_Record_Length        : constant Ada.Streams.Stream_Element_Offset
     := End_Of_Central_Directory_Record'Size / Ada.Streams.Stream_Element'Size;
   ZIP64_End_Of_Central_Directory_Locator_Length : constant Ada.Streams.Stream_Element_Offset
     := ZIP64_End_Of_Central_Directory_Locator'Size / Ada.Streams.Stream_Element'Size;
   Central_Directory_File_Header_Length          : constant Ada.Streams.Stream_Element_Offset
     := Central_Directory_File_Header'Size / Ada.Streams.Stream_Element'Size;

   function ZIP_File_Comment_Length
    (Item : End_Of_Central_Directory_Record) return Zip_File_Offset_16;

   function Offset_Of_Start_Of_Central_Directory_With_Respect_To_The_Starting_Disk_Number
    (Item : End_Of_Central_Directory_Record) return Zip_File_Offset;

   function File_Name_Length
    (Item : Central_Directory_File_Header) return Zip_File_Offset_16;

   ----------------------
   -- File_Name_Length --
   ----------------------

   function File_Name_Length
    (Item : Central_Directory_File_Header) return Zip_File_Offset_16 is
   begin
      return
        Zip_File_Offset_16 (Item.File_Name_Length (1)) * (2 ** 8)
          + Zip_File_Offset_16 (Item.File_Name_Length (0));
   end File_Name_Length;

   -----------------------------------------------------------------------------------
   -- Offset_Of_Start_Of_Central_Directory_With_Respect_To_The_Starting_Disk_Number --
   -----------------------------------------------------------------------------------

   function Offset_Of_Start_Of_Central_Directory_With_Respect_To_The_Starting_Disk_Number
    (Item : End_Of_Central_Directory_Record) return Zip_File_Offset is
   begin
      return
        Zip_File_Offset (Item.Offset_Of_Start_Of_Central_Directory_With_Respect_To_The_Starting_Disk_Number (3)) * (2 ** 24)
          + Zip_File_Offset (Item.Offset_Of_Start_Of_Central_Directory_With_Respect_To_The_Starting_Disk_Number (2)) * (2 ** 16)
          + Zip_File_Offset (Item.Offset_Of_Start_Of_Central_Directory_With_Respect_To_The_Starting_Disk_Number (1)) * (2 ** 8)
          + Zip_File_Offset (Item.Offset_Of_Start_Of_Central_Directory_With_Respect_To_The_Starting_Disk_Number (0));
   end Offset_Of_Start_Of_Central_Directory_With_Respect_To_The_Starting_Disk_Number;

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

   function Read (File : Zip.IO.File_Type) return Central_Directory is
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
         Record_Size                : constant Ada.Streams.Stream_Element_Offset
           := End_Of_Central_Directory_Record_Length + Signature_Length;
         Maximum_Lookup_Buffer_Size : constant Ada.Streams.Stream_Element_Offset
           := 2 ** 16 - 1 + Record_Size;
         File_Size                  : constant Zip_File_Offset
           := Zip.IO.Get_Size (File);
         Lookup_Buffer_Size         : constant Ada.Streams.Stream_Element_Offset
           := Ada.Streams.Stream_Element_Offset'Min
               (Maximum_Lookup_Buffer_Size,
                Ada.Streams.Stream_Element_Offset (File_Size));

         Position        : constant Zip_File_Offset
           := File_Size - Zip_File_Offset (Lookup_Buffer_Size);
         Buffer          : Ada.Streams.Stream_Element_Array (1 .. Lookup_Buffer_Size);
         Record_Position : Zip_File_Offset := 0;
         Directory_Position : Zip_File_Offset;

      begin
         Zip.IO.Set_Position (File, Position);
         Zip.IO.Read (File, Buffer);

         for J in reverse Buffer'First .. Buffer'Last - Record_Size + 1 loop
            if Buffer (J .. J + Signature_Length - 1)
                 = End_Of_Central_Directory_Signature
            then
               declare
                  Raw_Record      : End_Of_Central_Directory_Record;
                  for Raw_Record'Address use Buffer (J + Signature_Length)'Address;
                  pragma Import (Ada, Raw_Record);

               begin
                  --  Exit when total size of end of central directory record
                  --  is confirmed by record's position (it should be placed at
                  --  the end of the archive file).

                  if Ada.Streams.Stream_Element_Offset
                      (ZIP_File_Comment_Length (Raw_Record))
                         = Buffer'Last - (J + Record_Size - 1)
                  then
                     Record_Position := Position + Zip_File_Offset (J) - 1;

                     Directory_Position := Offset_Of_Start_Of_Central_Directory_With_Respect_To_The_Starting_Disk_Number (Raw_Record);

         Ada.Text_IO.Put_Line ("offset of central directory record position:" & Zip_File_Offset'Image (Offset_Of_Start_Of_Central_Directory_With_Respect_To_The_Starting_Disk_Number (Raw_Record)));

                     exit;
                  end if;

                  --  Otherwise, continue to lookup for end of central
                  --  directory record signature.
               end;
            end if;
         end loop;

         Ada.Text_IO.Put_Line ("end of central directory record position:" & Zip_File_Offset'Image (Record_Position));

         Zip.IO.Set_Position (File, Record_Position - Zip_File_Offset (ZIP64_End_Of_Central_Directory_Locator_Length) - Zip_File_Offset (Signature_Length));
         Zip.IO.Read (File, Signature);

         if Signature = ZIP64_End_Of_Central_Directory_Locator_Signature then
            Ada.Text_IO.Put_Line
             ("end of central directory record position:"
                & Zip_File_Offset'Image
                   (Record_Position - Zip_File_Offset (ZIP64_End_Of_Central_Directory_Locator_Length) - Zip_File_Offset (Signature_Length)));

            raise Program_Error with "ZIP64 is not implemented now";
         end if;

         Zip.IO.Set_Position (File, Directory_Position);

         while Zip.IO.Get_Position (File) < Record_Position loop
            File_Info := (others => <>);

            Zip.IO.Read (File, Signature);

            if Signature /= Central_Directory_Header_Signature then
               raise Program_Error;
            end if;

--            Ada.Text_IO.Put_Line ("read CDH");

            declare
               Buffer : Ada.Streams.Stream_Element_Array (1 .. Central_Directory_File_Header_Length);
               Raw_Header : Central_Directory_File_Header;
               for Raw_Header'Address use Buffer'Address;
               pragma Import (Ada, Raw_Header);
               Name_Length : ZIP_File_Offset_16;

            begin
               Zip.IO.Read (File, Buffer);
               Name_Length := File_Name_Length (Raw_Header);

--               Ada.Text_IO.Put_Line ("file name length:" & Zip_File_Offset'Image (Name_Length));

               declare
                  Buffer : Ada.Streams.Stream_Element_Array (1 .. Ada.Streams.Stream_Element_Offset (Name_Length));
                  Codec  : League.Text_Codecs.Text_Codec
                    := League.Text_Codecs.Codec (League.Strings.To_Universal_String ("IBM437"));
                  Name   : League.Strings.Universal_String;

               begin
                  Zip.IO.Read (File, Buffer);
                  File_Info.File_Name := Codec.Decode (Buffer);
                  Ada.Text_IO.Put_Line (''' & File_Info.File_Name.To_UTF_8_String & ''');
               end;
            end;

            Result.Files.Append (File_Info);
         end loop;
      end;

      return Result;
   end Read;

   -----------------------------
   -- ZIP_File_Comment_Length --
   -----------------------------

   function ZIP_File_Comment_Length
    (Item : End_Of_Central_Directory_Record) return Zip_File_Offset_16 is
   begin
      return
        Zip_File_Offset_16 (Item.ZIP_File_Comment_Length (1)) * (2 ** 8)
          + Zip_File_Offset_16 (Item.ZIP_File_Comment_Length (0));
   end ZIP_File_Comment_Length;

end Zip.Metadata;
