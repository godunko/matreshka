with League.Application;
with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Simple_Readers;

with Matreshka.XML_Schema.Document_Parsers;

procedure Driver is
   Input  : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
   Reader : aliased XML.SAX.Simple_Readers.SAX_Simple_Reader;
   Parser : aliased Matreshka.XML_Schema.Document_Parsers.Document_Parser;

begin
   Reader.Set_Content_Handler (Parser'Unchecked_Access);
   Input.Open_By_File_Name (League.Application.Arguments.Element (1));
   Reader.Parse (Input'Unchecked_Access);
end Driver;
