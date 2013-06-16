with League.Text_Codecs;

package body Zip.Metadata.Local_File_Headers is

   use type Ada.Streams.Stream_Element_Offset;

   type Raw_Local_File_Header_Type is record
      Version            : Ada.Streams.Stream_Element_Array (0 .. 1);
      Flags              : Ada.Streams.Stream_Element_Array (0 .. 1);
      Compression_Method : Ada.Streams.Stream_Element_Array (0 .. 1);
      Time               : Ada.Streams.Stream_Element_Array (0 .. 1);
      Date               : Ada.Streams.Stream_Element_Array (0 .. 1);
      CRC_32             : Ada.Streams.Stream_Element_Array (0 .. 3);
      Compressed_Size    : Ada.Streams.Stream_Element_Array (0 .. 3);
      Uncompressed_Size  : Ada.Streams.Stream_Element_Array (0 .. 3);
      Name_Length        : Ada.Streams.Stream_Element_Array (0 .. 1);
      Extra_Length       : Ada.Streams.Stream_Element_Array (0 .. 1);
   end record;

   function File_Name_Length
    (Header : Raw_Local_File_Header_Type)
       return Ada.Streams.Stream_Element_Offset;

   function Compressed_Size
    (Header : Raw_Local_File_Header_Type) return Zip_File_Offset;

   ---------------------
   -- Compressed_Size --
   ---------------------

   function Compressed_Size
    (Header : Raw_Local_File_Header_Type)
       return Zip_File_Offset is
   begin
      return
        Zip_File_Offset (Header.Compressed_Size (3)) * (2 ** 24)
          + Zip_File_Offset (Header.Compressed_Size (2)) * (2 ** 16)
          + Zip_File_Offset (Header.Compressed_Size (1)) * (2 ** 8)
          + Zip_File_Offset (Header.Compressed_Size (0));
   end Compressed_Size;

   ------------------------
   -- Extra_Field_Length --
   ------------------------

   function Extra_Field_Length
    (Header : Raw_Local_File_Header_Type)
       return Ada.Streams.Stream_Element_Offset is
   begin
      return
        Ada.Streams.Stream_Element_Offset (Header.Extra_Length (1)) * (2 ** 8)
          + Ada.Streams.Stream_Element_Offset (Header.Extra_Length (0));
   end Extra_Field_Length;

   ----------------------
   -- File_Name_Length --
   ----------------------

   function File_Name_Length
    (Header : Raw_Local_File_Header_Type)
       return Ada.Streams.Stream_Element_Offset is
   begin
      return
        Ada.Streams.Stream_Element_Offset (Header.Name_Length (1)) * (2 ** 8)
          + Ada.Streams.Stream_Element_Offset (Header.Name_Length (0));
   end File_Name_Length;

   ----------
   -- Read --
   ----------

   procedure Read
    (File   : Zip.IO.File_Type;
     Header : out Local_File_Header_Type)
   is
      use type Ada.Streams.Stream_Element;
      use type Ada.Streams.Stream_Element_Offset;

      Raw_Header      : Raw_Local_File_Header_Type;
      Raw_Header_Data :
        Ada.Streams.Stream_Element_Array
         (1 .. Raw_Local_File_Header_Type'Size
                 / Ada.Streams.Stream_Element'Size);
      for Raw_Header_Data'Address use Raw_Header'Address;
      pragma Import (Ada, Raw_Header_Data);

   begin
      Header.Position := Zip.IO.Get_Position (File);

      --  Read header data.

      Zip.IO.Read (File, Raw_Header_Data);

      Header.Compressed_Size := Compressed_Size (Raw_Header);

      --  Read file name.

      declare
         Raw_Name_Data :
           Ada.Streams.Stream_Element_Array (1 .. File_Name_Length (Raw_Header));
         Codec         : League.Text_Codecs.Text_Codec
           := League.Text_Codecs.Codec (League.Strings.To_Universal_String ("IBM437"));

      begin
         Zip.IO.Read (File, Raw_Name_Data);
         Header.File_Name := Codec.Decode (Raw_Name_Data);
      end;

      --  Read extra field.

      declare
         Raw_Extra_Field_Data :
           Ada.Streams.Stream_Element_Array (1 .. Extra_Field_Length (Raw_Header));

      begin
         if Raw_Extra_Field_Data'Length /= 0 then
            raise Program_Error;
         end if;

         Zip.IO.Read (File, Raw_Extra_Field_Data);
      end;

      --  XXX

      if (Raw_Header.Flags (0) and 2#0000_1000#) /= 0 then
         raise Program_Error;
      end if;
   end Read;

end Zip.Metadata.Local_File_Headers;
