with Ada.Containers.Ordered_Maps; use Ada.Containers; 
with league.strings; use league.strings;
package Matreshka.Opts.internal.application_options is 

    package application_options_container is 
        new Ada.Containers.Ordered_Maps(Element_Type => Universal_String,
        Key_type => Universal_String);

    subtype application_option is application_options_container.Map;
    type application_option_access is access all application_option;

end Matreshka.Opts.internal.application_options; 

