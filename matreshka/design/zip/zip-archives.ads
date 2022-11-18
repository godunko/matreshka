with League.Calendars;
with League.Stream_Element_Vectors;
with League.String_Vectors;
with League.Strings;

private with Ada.Containers.Vectors;
private with Ada.Streams.Stream_IO;
private with Zip.IO;
private with Zip.Metadata;

package Zip.Archives is

   procedure Initialize;

   type Input is tagged limited private;
   --  Zip archive opened for reading

   not overriding procedure Open
     (Self : out Input;
      Path : League.Strings.Universal_String);
   --  Open existing archive for reading

   not overriding function Entry_Count (Self : Input) return Natural;
   --  Return count of file/dir nested in given archive.

   not overriding function Path
     (Self  : Input;
      Index : Positive) return League.Strings.Universal_String;
   --  Return path of given entry.

   not overriding procedure Close (Self : in out Input);

   type Output is tagged limited private;
   --  Zip archive opened for writing

   not overriding procedure Create
     (Self : out Output;
      Path : League.Strings.Universal_String);

   not overriding procedure Copy
     (To    : in out Output'Class;
      From  : in out Input;
      Index : Positive);

   not overriding procedure Append
     (Self     : in out Output;
      Path     : League.Strings.Universal_String;
      Data     : League.Stream_Element_Vectors.Stream_Element_Vector;
      Modified : League.Calendars.Date_Time;
      Method   : Zip.Compression_Method := Zip.Deflate);

   not overriding procedure Close (Self : in out Output);

private

   type Input is tagged limited record
      File      : aliased Zip.IO.File_Type;
      Directory : Zip.Metadata.Central_Directory;
   end record;

   type Counting_Stream is new Ada.Streams.Root_Stream_Type with record
      Parent : access Ada.Streams.Root_Stream_Type'Class;
      Offset : Ada.Streams.Stream_Element_Offset := 0;
   end record;
   --  Decorator to count written elements

   overriding procedure Read
     (Stream : in out Counting_Stream;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset) is null;

   overriding procedure Write
     (Stream : in out Counting_Stream;
      Item   : Ada.Streams.Stream_Element_Array);

   type Output is tagged limited record
      File      : Ada.Streams.Stream_IO.File_Type;
      Stream    : aliased Counting_Stream;
      Directory : Zip.Metadata.Central_Directory;
   end record;

end Zip.Archives;
