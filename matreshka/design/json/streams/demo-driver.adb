with Ada.Wide_Wide_Text_IO;

with League.JSON.Streams;

procedure Demo.Driver is
   Stream   : aliased League.JSON.Streams.JSON_Stream;
   In_Data  : Demo.Rect := (True, 1, 2, League.Strings.To_Universal_String ("str"));
   Out_Data : Demo.Rect;

begin
   Demo.Rect'Write (Stream'Access, In_Data);
   Ada.Wide_Wide_Text_IO.Put_Line
    (Stream.Get_JSON_Document.To_JSON.To_Wide_Wide_String);
   Stream.Set_JSON_Document (Stream.Get_JSON_Document);
   Demo.Rect'Read (Stream'Access, Out_Data);
   Ada.Wide_Wide_Text_IO.Put_Line
    (Boolean'Wide_Wide_Image (Out_Data.F)
       & Integer'Wide_Wide_Image (Out_Data.X)
       & Integer'Wide_Wide_Image (Out_Data.Y)
       & " """
       & Out_Data.N.To_Wide_Wide_String
       & '"');
end Demo.Driver;
