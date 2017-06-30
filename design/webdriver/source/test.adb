with Ada.Wide_Wide_Text_IO;

with League.Strings;

with WebDriver.Drivers;
with WebDriver.Elements;
with WebDriver.Remote;
with WebDriver.Sessions;

procedure Test is
   function "+"
     (Text : Wide_Wide_String) return League.Strings.Universal_String
      renames League.Strings.To_Universal_String;

   Web_Driver : aliased WebDriver.Drivers.Driver'Class
     := WebDriver.Remote.Create (+"http://127.0.0.1:9515");
   Session    : constant WebDriver.Sessions.Session_Access :=
     Web_Driver.New_Session;
begin
   Session.Go (+"http://www.ada-ru.org/");

   Ada.Wide_Wide_Text_IO.Put_Line
     (Session.Get_Current_URL.To_Wide_Wide_String);

   declare
      Table : constant WebDriver.Elements.Element_Access :=
        Session.Find_Element
          (Strategy => WebDriver.Tag_Name,
           Selector => +"table");
   begin
      Ada.Wide_Wide_Text_IO.Put_Line
        ("Selected=" & Boolean'Wide_Wide_Image (Table.Is_Selected));
      Ada.Wide_Wide_Text_IO.Put_Line
        ("summary=" & Table.Get_Attribute (+"summary").To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Put_Line
        ("height=" & Table.Get_CSS_Value (+"height").To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Put_Line
        ("tag=" & Table.Get_Tag_Name.To_Wide_Wide_String);
   end;
end Test;
