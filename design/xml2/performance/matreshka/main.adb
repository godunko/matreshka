with Ada.Calendar;

with League.Application;
with League.Strings;
--with XML.SAX.Input_Sources.Strings;
with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Simple_Readers;

with Events_Printers;
with Put_Line;
with Read_File;

procedure Main is
   use type League.Strings.Universal_String;
   use type Ada.Calendar.Time;

   Source      : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
--   Source      : aliased XML.SAX.Input_Sources.Strings.String_Input_Source;
   Reader      : aliased XML.SAX.Simple_Readers.SAX_Simple_Reader;
   Handler     : aliased Events_Printers.Events_Printer;
   Load_Start  : Ada.Calendar.Time;
   Parse_Start : Ada.Calendar.Time;
   Stop        : Ada.Calendar.Time;

--   task type T;
--
--   task body T is
--   begin
--      null;
--   end T;

begin
   Reader.Set_Entity_Resolver (Handler'Unchecked_Access);

   Load_Start := Ada.Calendar.Clock;
   Source.Open_By_File_Name (League.Application.Arguments.Element (1));
--   Source.Set_String (Read_File (Ada.Command_Line.Argument (1)));
   Parse_Start := Ada.Calendar.Clock;
   Reader.Parse (Source'Access);
   Stop := Ada.Calendar.Clock;
   Put_Line
    ("Loading time:   "
       & League.Strings.To_Universal_String
          (Duration'Wide_Wide_Image (Parse_Start - Load_Start)));
   Put_Line
    ("Parsing time:   "
       & League.Strings.To_Universal_String
          (Duration'Wide_Wide_Image (Stop - Parse_Start)));
   Put_Line
    ("Processing time:"
       & League.Strings.To_Universal_String
          (Duration'Wide_Wide_Image (Stop - Load_Start)));
end Main;
