with Matreshka.Opts.parsers; use Matreshka.Opts.parsers; 
with Ada.Wide_Wide_Text_IO;
with League.Strings; use League.Strings;
with League.Characters;
with League.Text_Codecs;
with League.String_Vectors; use League.String_Vectors;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Streams;
procedure adaopts is 
    myparser : parser_access := new parser;
    function "+"
        (Item : Wide_Wide_String) return League.Strings.Universal_String
        renames League.Strings.To_Universal_String;
    function "+"
        (Item : Wide_Wide_Character) return League.Characters.Universal_Character
        renames League.Characters.To_Universal_Character;

    function To_Universal_String(Str : String) return Universal_String is
        use Ada.Streams;
        US : Universal_String;
        Result : Stream_Element_Array (Stream_Element_Offset (Str'First) ..
            Stream_Element_Offset (Str'Last));
        for Result'Address use Str'Address;
    begin
        US := League.Text_Codecs.Codec_For_Application_Locale.Decode(Result);
        return US;
    end To_Universal_String;

    Vect : Universal_String_Vector := Empty_Universal_String_Vector;
begin
    myparser.add_option (Name => +"Filename",
                         Long => +"fname",
                         Short => +'f',
                         Help => +"Name of file", 
                         Required => True, 
                         Has_Value => True);
    myparser.add_option (Name => +"filetype",
                         Long => +"ftype",
                         Short => +'t',
                         Help => +"Type of the file");

    for I in 1..Ada.Command_Line.Argument_Count loop
        Vect.Append(To_Universal_String(Ada.Command_Line.Argument(I)));
    end loop;
    myparser.parse(Vect);
    



end adaopts; 

