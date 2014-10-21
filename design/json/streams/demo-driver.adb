with Ada.Wide_Wide_Text_IO;

with League.JSON.Streams;

procedure Demo.Driver is
   Stream : aliased League.JSON.Streams.JSON_Stream;
   Data   : Demo.Rect := (1, 2);

begin
   Demo.Rect'Write (Stream'Access, Data);
   Ada.Wide_Wide_Text_IO.Put_Line
    (Stream.Get_JSON_Document.To_JSON.To_Wide_Wide_String);
end Demo.Driver;
