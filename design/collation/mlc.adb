with League.Strings;
with XML.SAX.File_Input_Sources;
with XML.SAX.Simple_Readers;

with AllKeys_Reader;
with CLDR_Parsers;

procedure MLC is
   Collations : AllKeys_Reader.Collation_Information_Access;

   Input      : aliased XML.SAX.File_Input_Sources.File_Input_Source;
   Parser     : aliased CLDR_Parsers.CLDR_Parser;
   Reader     : XML.SAX.Simple_Readers.Simple_Reader;

begin
   Collations := AllKeys_Reader.Load_AllKeys_File;

   Input.Open_By_File_Name
    (League.Strings.To_Universal_String
      ("../../data/cldr/25/common/collation/uk.xml"));
   Parser.Collations := Collations;
   Reader.Set_Content_Handler (Parser'Unchecked_Access);
   Reader.Parse (Input'Unchecked_Access);
   Input.Close;
end MLC;
