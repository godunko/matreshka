with League.Strings;
with Matreshka.Internals.Locales;
with XML.SAX.File_Input_Sources;
with XML.SAX.Simple_Readers;

with AllKeys_Reader;
with Builder;
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
--      ("../../data/cldr/25/common/collation/ru.xml"));
      ("../../data/cldr/25/common/collation/uk.xml"));
   Parser.Collations := Collations;
   Reader.Set_Content_Handler (Parser'Unchecked_Access);
   Reader.Parse (Input'Unchecked_Access);
   Input.Close;

   declare
      Locale : constant Matreshka.Internals.Locales.Collation_Data
        := Builder.Build (Collations.all);

   begin
      null;
   end;
end MLC;
