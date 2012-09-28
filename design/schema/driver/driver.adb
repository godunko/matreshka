with League.Application;
with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Simple_Readers;

with Matreshka.XML_Schema.Handlers;

procedure Driver is
   Source  : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
   Handler : aliased Matreshka.XML_Schema.Handlers.XML_Schema_Handler;
   Reader  : aliased XML.SAX.Simple_Readers.SAX_Simple_Reader;

begin
   Reader.Set_Content_Handler (Handler'Unchecked_Access);
   Source.Open_By_File_Name (League.Application.Arguments.Element (1));
   Reader.Parse (Source'Unchecked_Access);
end Driver;
