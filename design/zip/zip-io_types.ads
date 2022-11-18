with League.Calendars;

package Zip.IO_Types is

   type Unsigned_16 is mod 2 ** 16
     with Read => Read, Write => Write;

   procedure Read
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : out Unsigned_16);

   procedure Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Unsigned_16);

   type Method is new Compression_Method
     with Read => Read, Write => Write, Size => Unsigned_16'Size;
   for Method use (None => 0, Deflate => 8);

   procedure Read
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : out Method);

   procedure Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Method);

   type Date_Time is new League.Calendars.Date_Time
     with Read => Read, Write => Write;

   procedure Read
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : out Date_Time);

   procedure Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Date_Time);

   type Unsigned_32 is mod 2 ** 32
     with Read => Read, Write => Write;

   procedure Read
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : out Unsigned_32);

   procedure Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Unsigned_32);

   type Version is new Unsigned_16;
   type Flags   is new Unsigned_16;
   type Length  is new Unsigned_16;
   type CRC32   is new Unsigned_32;
   type Size    is new Unsigned_32;

   Has_Data_Descriptor : constant Flags := 16#008#;
   Use_UTF_8_Names     : constant Flags := 16#800#;

end Zip.IO_Types;
