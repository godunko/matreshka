with League.Strings; use League.Strings;
with league.Characters; use league.characters;
with Matreshka.Opts.options; use Matreshka.Opts.options;
with League.String_Vectors; use League.String_Vectors;
with Matreshka.Opts.internal.application_options; 
use Matreshka.Opts.internal.application_options;
with Matreshka.Opts.internal.available_options_maps; 
use Matreshka.Opts.internal.available_options_maps;
package Matreshka.Opts.parsers is 

    type parser is tagged limited private;
    type parser_access is access all parser; 

    not overriding
    procedure Add_Option (Self : in out parser;
        Name        : in Universal_String; 
        Long        : in Universal_String;
        Short       : in Universal_Character; 
        Help        : in Universal_String; 
        Required    : in Boolean := False;
        Has_Value   : in Boolean := False);  
    --  Add new option to the list of available options

    not overriding
    function Has_Option (Self : in out parser;
        Name        : in Universal_String) return Boolean;
    --  Returns true if option has been specified in command line

    not overriding
    function Get_Value (Self : in out Parser; Name : in Universal_String) 
        return Universal_String;
    --  Returns value of the option (if option is valued) or 
    --  empty_universal_string if not

    not overriding
    procedure Parse (Self : in out Parser;
        Option_List : in Universal_String_Vector); 
    --  Parse command line (transformed to Option_List 

private
    type parser is tagged limited null record;

    option_list : available_options_map_access :=
        new available_options_map;
    application_list : application_option_access :=
        new application_option;

end Matreshka.Opts.parsers; 

