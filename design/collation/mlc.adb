with League.Strings;
with Matreshka.Internals.Locales;
with XML.SAX.File_Input_Sources;
with XML.SAX.Simple_Readers;

with Matreshka.CLDR.AllKeys_Reader;
with Matreshka.CLDR.Collation_Compiler;
with Matreshka.CLDR.LDML_Parsers;

procedure MLC is
   Collations : Matreshka.CLDR.AllKeys_Reader.Collation_Information_Access;

   Input      : aliased XML.SAX.File_Input_Sources.File_Input_Source;
   Parser     : aliased Matreshka.CLDR.LDML_Parsers.LDML_Parser;
   Reader     : XML.SAX.Simple_Readers.Simple_Reader;
   Locale     : Matreshka.Internals.Locales.Locale_Data_Access
     := Matreshka.Internals.Locales.Get_Locale;

begin
   Collations := Matreshka.CLDR.AllKeys_Reader.Load_AllKeys_File;

   Input.Open_By_File_Name
    (League.Strings.To_Universal_String
--      ("../../data/cldr/25/common/collation/ru.xml"));
      ("../../data/cldr/25/common/collation/uk.xml"));
   Parser.Collations := Collations;
   Reader.Set_Content_Handler (Parser'Unchecked_Access);
   Reader.Parse (Input'Unchecked_Access);
   Input.Close;

   Matreshka.CLDR.Collation_Compiler.Construct_Collation_Information
    (Collations.all, Locale);
end MLC;
