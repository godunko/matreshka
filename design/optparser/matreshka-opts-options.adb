package body Matreshka.Opts.options is 

    not overriding
    procedure Set_Name (Self : in out Option; Name : in Universal_String)
    is
    begin
        Self.Name := Name;
    end Set_Name;


    not overriding
    procedure Set_Long (Self : in out Option; Long : in Universal_String)
    is
    begin
        Self.Long_Option := Long;
    end Set_Long;


    not overriding
    procedure Set_Short (Self : in out Option;
        Short : in Universal_Character) is
    begin
        Self.Short_Option := Short;
    end Set_Short;


    not overriding
    procedure Set_Help (Self : in out Option; Help : in Universal_String)
    is
    begin
        Self.Help_String := Help;
    end Set_Help;

    not overriding
    procedure Set_Valued (Self : in out Option) is 
    begin
        Self.Has_Value := True;
    end Set_Valued;

    not overriding
    procedure Set_Required (Self : in out Option) is
    begin
        Self.Required := True;
    end Set_Required;

end Matreshka.Opts.options; 

