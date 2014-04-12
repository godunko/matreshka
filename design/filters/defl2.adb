with Matreshka.Filters.Deflate.Pack;
with Matreshka.Filters.Deflate.Unpack;
with League.Application;
with League.Strings;
with League.Stream_Element_Vectors;
with Ada.Streams.Stream_IO;

procedure Defl2 is
   package P renames Matreshka.Filters.Deflate.Pack;
   package D renames Matreshka.Filters.Deflate.Unpack;

   Name : constant League.Strings.Universal_String :=
     League.Application.Arguments.Element (1);

   function Read return League.Stream_Element_Vectors.Stream_Element_Vector is
      File : Ada.Streams.Stream_IO.File_Type;
   begin
      Ada.Streams.Stream_IO.Open
        (File, Ada.Streams.Stream_IO.In_File, Name.To_UTF_8_String);

      declare
         Size : constant Ada.Streams.Stream_IO.Count :=
           Ada.Streams.Stream_IO.Size (File);
         Data : Ada.Streams.Stream_Element_Array
           (1 .. Ada.Streams.Stream_Element_Count (Size));
         Last : Ada.Streams.Stream_Element_Count;
      begin
         Ada.Streams.Stream_IO.Read (File, Data, Last);
         Ada.Streams.Stream_IO.Close (File);
         return League.Stream_Element_Vectors.To_Stream_Element_Vector
           (Data (1 .. Last));
      end;
   end Read;

   Input  : constant League.Stream_Element_Vectors.Stream_Element_Vector :=
     Read;
   Output : League.Stream_Element_Vectors.Stream_Element_Vector;

begin
   P.Initialize;
   D.Initialize;

   if Name.Ends_With (".gz") then
      declare
         Filter : D.Filter;
      begin
         --  FIXME: Skip gzip header here from Input
         Filter.Read (Input, Output);
         Filter.Flush (Output);
      end;
   else
      declare
         use type Ada.Streams.Stream_Element_Count;
         Filter : P.Filter;
--         Length : Ada.Streams.Stream_Element_Count;
      begin
         Output.Append (16#1F#);
         Output.Append (16#8B#);
         Output.Append (16#08#);
         Output.Append (Ada.Streams.Stream_Element_Array'(1 .. 6 => 16#00#));
         Output.Append (16#FF#);
         Filter.Read (Input, Output);
         Filter.Flush (Output);
--         Length := Output.Length - 10;
         Output.Append (Ada.Streams.Stream_Element_Array'(1 .. 8 => 16#00#));
      end;
   end if;

   declare
      File : Ada.Streams.Stream_IO.File_Type;
   begin
      Ada.Streams.Stream_IO.Create
        (File,
         Name => League.Application.Arguments.Element (2).To_UTF_8_String);
      Ada.Streams.Stream_IO.Write (File, Output.To_Stream_Element_Array);
      Ada.Streams.Stream_IO.Close (File);
   end;
end Defl2;
