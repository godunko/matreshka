with Ada.Wide_Wide_Text_IO;

with League.JSON.Streams;

procedure Demo.Driver is
   Stream   : aliased League.JSON.Streams.JSON_Stream;
   In_Data  : Demo.Rect := (1, 2);
   Out_Data : Demo.Rect;

begin
   Demo.Rect'Write (Stream'Access, In_Data);
   Ada.Wide_Wide_Text_IO.Put_Line
    (Stream.Get_JSON_Document.To_JSON.To_Wide_Wide_String);
   Stream.Set_JSON_Document (Stream.Get_JSON_Document);
   Demo.Rect'Read (Stream'Access, Out_Data);
   Ada.Wide_Wide_Text_IO.Put_Line
    (Integer'Wide_Wide_Image (Out_Data.X)
       & Integer'Wide_Wide_Image (Out_Data.Y));
end Demo.Driver;
