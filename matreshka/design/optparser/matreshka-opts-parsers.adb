package body Matreshka.Opts.parsers is 

    not overriding
    procedure Add_Option (Self : in out parser;
        Name        : in Universal_String; 
        Long        : in Universal_String;
        Short       : in Universal_Character; 
        Help        : in Universal_String; 
        Required    : in Boolean := False;
        Has_Value   : in Boolean := False) 
    is 
        Opt  : Any_Option := new Option; 
    begin
        Opt.Set_Name(Name);
        Opt.Set_Long(Long);
        Opt.Set_Short(Short);
        Opt.Set_Help(Help);
        if Required then
            Opt.Set_Required;
        end if;
        if Has_Value then
            Opt.Set_Valued;
        end if;
    end Add_Option; 

    not overriding
    function Has_Option (Self : in out parser;
        Name        : in Universal_String) return Boolean is 
    begin
        return option_list.Contains(Name);
    end Has_Option;

    not overriding
    function Get_Value (Self : in out Parser; Name : in Universal_String) 
        return Universal_String is
    begin
        if Self.Has_Option(Name) then
            return application_list.element(Name);
        else
            raise PROGRAM_ERROR with "No such option.";
        end if;
    end Get_Value;

    not overriding
    procedure Parse (Self : in out Parser;
        Option_List : in Universal_String_Vector) is 
    begin
        raise constraint_error with "Not implemented yet";
    end Parse;
end Matreshka.Opts.parsers; 

