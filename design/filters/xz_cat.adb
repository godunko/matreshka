with Ada.Command_Line;
with Ada.Streams.Stream_IO;

with League.Stream_Element_Vectors;
with Matreshka.Filters.LZMA.XZ_Unpack;

procedure XZ_Cat is

   Data   : Ada.Streams.Stream_Element_Array (1 .. 4096);
   File   : Ada.Streams.Stream_IO.File_Type;
   Last   : Ada.Streams.Stream_Element_Offset;

   Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
   Output : League.Stream_Element_Vectors.Stream_Element_Vector;
   Filter : Matreshka.Filters.LZMA.XZ_Unpack.Filter;
begin
   Ada.Streams.Stream_IO.Open
     (File, Ada.Streams.Stream_IO.In_File, Ada.Command_Line.Argument (1));

   while not Ada.Streams.Stream_IO.End_Of_File (File) loop
      Ada.Streams.Stream_IO.Read (File, Data, Last);
      Input.Clear;
      Input.Append (Data (1 .. Last));
      Filter.Read (Input, Output);
   end loop;

   Ada.Streams.Stream_IO.Close (File);

   Ada.Streams.Stream_IO.Create
     (File, Ada.Streams.Stream_IO.Out_File, Ada.Command_Line.Argument (2));

   Ada.Streams.Stream_IO.Write (File, Output.To_Stream_Element_Array);

   Ada.Streams.Stream_IO.Close (File);
end XZ_Cat;
