with Ada.Streams;
with Ada.Wide_Wide_Text_IO;

with Zip.Archives;
with League.Calendars;
with League.Stream_Element_Vectors;
with League.String_Vectors;
with League.Strings;

procedure Main2 is
   function "+"
     (Text : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   Input  : Zip.Archives.Input;
   Output : aliased Zip.Archives.Output;
   Data   : League.Stream_Element_Vectors.Stream_Element_Vector;
begin
   Zip.Archives.Initialize;
   Input.Open (+"/tmp/table.ods");
   Output.Create (+"/tmp/copy.zip");

   for J in 1 .. Input.Entry_Count loop
      Ada.Wide_Wide_Text_IO.Put_Line (Input.Path (J).To_Wide_Wide_String);
      Output.Copy (Input, J);
   end loop;

   Data.Append
     (Ada.Streams.Stream_Element_Array'(0, 1, 2, 3, 4, 5));

   Output.Append
     (Path     => +"aaa.txt",
      Data     => Data,
      Modified => League.Calendars.Clock,
      Method   => Zip.Deflate);

   Output.Close;
end Main2;
