with league.strings; use league.strings; 
with league.characters; use league.characters; 
with Ada.Finalization; use Ada.Finalization;

package Matreshka.Opts.options is 

    type option is new limited_controlled with private;
    type option_access is access all option;
    type any_option is access all option'Class;


    -- Set of setters 
    not overriding
    procedure Set_Name (Self : in out Option; Name : in Universal_String);
    not overriding
    procedure Set_Long (Self : in out Option; Long : in Universal_String);
    not overriding
    procedure Set_Short (Self : in out Option;
        Short : in Universal_Character);
    not overriding
    procedure Set_Help (Self : in out Option; Help : in Universal_String);
    not overriding
    procedure Set_Valued (Self : in out Option);
    not overriding
    procedure Set_Required (Self : in out Option); 

private

    type option is new limited_controlled with record
        name : universal_String := Empty_Universal_String; 
        -- main identify of the option. Used for getters/setters
        long_option : universal_string := Empty_Universal_String; 
        --  myapplication --long 12
        short_option : universal_character; 
        --  myapplication -s=12
        help_string : universal_string := Empty_Universal_String;
        -- short description of the option for USAGE output
        required    : Boolean := False; 
        --  make some options required
        has_value   : Boolean := False;
        --  If true parser must read next element as value
        --  for example -long 12 => 12 here is value if long option is
        --  valueable, or single parameter overwise 
    end record;

end Matreshka.Opts.options; 

