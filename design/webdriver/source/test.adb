with Ada.Wide_Wide_Text_IO;

with League.Strings;

with WebDriver.Remote;
with WebDriver.Drivers;
with WebDriver.Sessions;

procedure Test is
   Server     : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("http://127.0.0.1:9515");
   Page      : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("http://www.ada-ru.org/");
   Web_Driver : aliased WebDriver.Drivers.Driver'Class
     := WebDriver.Remote.Create (Server);
   Session    : constant WebDriver.Sessions.Session_Access :=
     Web_Driver.New_Session;
begin
   Session.Go (Page);

   Ada.Wide_Wide_Text_IO.Put_Line
     (Session.Get_Current_URL.To_Wide_Wide_String);
end Test;
