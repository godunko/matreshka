with league.strings; use league.strings;
with ada.containers.ordered_maps; use ada.containers;
with Matreshka.Opts.options; use Matreshka.Opts.options;
package Matreshka.Opts.internal.available_options_maps is 

    package available_options_container is 
        new ada.containers.ordered_maps(Key_Type     => Universal_String, 
                                        Element_Type => Option_Access);

    subtype available_options_map is available_options_container.Map;
    type  available_options_map_access is access all available_options_map;
end Matreshka.Opts.internal.available_options_maps; 

