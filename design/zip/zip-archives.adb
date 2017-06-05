with GNAT.CRC32;
with Matreshka.Filters.Deflate.Pack;

package body Zip.Archives is

   ------------
   -- Append --
   ------------

   not overriding procedure Append
     (Self     : in out Output;
      Path     : League.Strings.Universal_String;
      Data     : League.Stream_Element_Vectors.Stream_Element_Vector;
      Modified : League.Calendars.Date_Time;
      Method   : Zip.Compression_Method := Zip.Deflate)
   is
      function Get_CRC32 return GNAT.CRC32.CRC32;
      function Complress
        return League.Stream_Element_Vectors.Stream_Element_Vector;

      ---------------
      -- Complress --
      ---------------

      function Complress
        return League.Stream_Element_Vectors.Stream_Element_Vector
      is
         Result : League.Stream_Element_Vectors.Stream_Element_Vector;
         Filter : Matreshka.Filters.Deflate.Pack.Filter;
      begin
         Filter.Read (Data, Result);
         Filter.Flush (Result);
         return Result;
      end Complress;

      ---------------
      -- Get_CRC32 --
      ---------------

      function Get_CRC32 return GNAT.CRC32.CRC32 is
         Result : GNAT.CRC32.CRC32;
      begin
         GNAT.CRC32.Initialize (Result);
         GNAT.CRC32.Update (Result, Data.To_Stream_Element_Array);

         return GNAT.CRC32.CRC32 (GNAT.CRC32.Get_Value (Result));
      end Get_CRC32;

      New_Entry : Zip.Metadata.File_Record :=
        (File_Name               => Path,
         Method                  => Method,
         Last_Modified => Modified,
         CRC32                   => Get_CRC32,
         Compressed_Size         => 0,
         Uncompressed_Size       => Data.Length,
         Has_Data_Descriptor     => False,
         Local_Header_Offset     => Self.Stream.Offset);

      Value      : League.Stream_Element_Vectors.Stream_Element_Vector;

   begin
      if Method = Zip.Deflate and not Data.Is_Empty then
         Value := Complress;
      else
         Value := Data;
      end if;

      New_Entry.Compressed_Size := Value.Length;
      Self.Directory.Files.Append (New_Entry);
      Zip.Metadata.Write_Local_File_Header (Self.Stream'Access, New_Entry);
      Self.Stream.Write (Value.To_Stream_Element_Array);
   end Append;

   -----------
   -- Close --
   -----------

   not overriding procedure Close (Self : in out Input) is
   begin
      Zip.IO.Close (Self.File);
   end Close;

   -----------
   -- Close --
   -----------

   not overriding procedure Close (Self : in out Output) is
   begin
      Zip.Metadata.Write
        (Self.Stream'Access,
         Zip.Zip_File_Offset (Self.Stream.Offset),
         Self.Directory);

      Ada.Streams.Stream_IO.Close (Self.File);
   end Close;

   ----------
   -- Copy --
   ----------

   not overriding procedure Copy
     (To    : in out Output'Class;
      From  : in out Input;
      Index : Positive)
   is
      use type Ada.Streams.Stream_Element_Offset;
      use type League.Strings.Universal_String;
      Header     : Zip.Metadata.File_Record;
      Offset     : Zip.Zip_File_Offset := 0;
   begin
      if Index not in 1 .. From.Directory.Files.Last_Index then
         raise Constraint_Error;
      end if;

      Offset := Zip_File_Offset
        (From.Directory.Files (Index).Local_Header_Offset);
      --  Copy local file header
      From.File.Set_Position (Offset);
      Zip.Metadata.Read_Local_File_Header (From.File'Access, Header);

      pragma Assert
        (Header.File_Name = From.Directory.Files (Index).File_Name);

      Header := From.Directory.Files (Index);
      Header.Has_Data_Descriptor := False;
      Header.Local_Header_Offset := To.Stream.Offset;
      To.Directory.Files.Append (Header);

      Zip.Metadata.Write_Local_File_Header (To.Stream'Access, Header);

      --  Copy file's data
      while Header.Compressed_Size > 0 loop
         declare
            Chunk_Size : constant := 1024;

            Chunk  : constant Ada.Streams.Stream_Element_Offset :=
              Ada.Streams.Stream_Element_Offset'Min
                (Chunk_Size, Header.Compressed_Size);
            Length : constant Ada.Streams.Stream_Element_Offset :=
              Ada.Streams.Stream_Element_Offset (Chunk);
            Buffer : Ada.Streams.Stream_Element_Array (1 .. Length);
         begin
            Zip.IO.Read (From.File, Buffer);
            To.Stream.Write (Buffer);
            Header.Compressed_Size := Header.Compressed_Size - Chunk;
         end;
      end loop;
   end Copy;

   ------------
   -- Create --
   ------------

   not overriding procedure Create
     (Self : out Output;
      Path : League.Strings.Universal_String)
   is
   begin
      Ada.Streams.Stream_IO.Create (Self.File, Name => Path.To_UTF_8_String);
      Self.Stream.Parent := Ada.Streams.Stream_IO.Stream (Self.File);
   end Create;

   -----------------
   -- Entry_Count --
   -----------------

   not overriding function Entry_Count (Self : Input) return Natural is
   begin
      return Positive (Self.Directory.Files.Length);
   end Entry_Count;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is
   begin
      Matreshka.Filters.Deflate.Pack.Initialize;
   end Initialize;

   ----------
   -- Open --
   ----------

   not overriding procedure Open
     (Self : out Input;
      Path : League.Strings.Universal_String)
   is
   begin
      Zip.IO.Open (Self.File, Path.To_UTF_8_String);
      Self.Directory := Zip.Metadata.Read (Self.File'Access);
   end Open;

   ----------
   -- Path --
   ----------

   not overriding function Path
     (Self  : Input;
      Index : Positive) return League.Strings.Universal_String is
   begin
      return Self.Directory.Files.Element (Index).File_Name;
   end Path;

   -----------
   -- Write --
   -----------

   overriding procedure Write
     (Stream : in out Counting_Stream;
      Item   : Ada.Streams.Stream_Element_Array)
   is
      use type Ada.Streams.Stream_Element_Offset;
   begin
      Stream.Offset := Stream.Offset + Item'Length;
      Stream.Parent.Write (Item);
   end Write;

end Zip.Archives;
