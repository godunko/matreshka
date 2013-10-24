pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~xsd_to_ada_generator.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~xsd_to_ada_generator.adb");
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E357 : Short_Integer; pragma Import (Ada, E357, "system__os_lib_E");
   E011 : Short_Integer; pragma Import (Ada, E011, "system__soft_links_E");
   E021 : Short_Integer; pragma Import (Ada, E021, "system__exception_table_E");
   E332 : Short_Integer; pragma Import (Ada, E332, "ada__containers_E");
   E223 : Short_Integer; pragma Import (Ada, E223, "ada__io_exceptions_E");
   E058 : Short_Integer; pragma Import (Ada, E058, "ada__strings_E");
   E062 : Short_Integer; pragma Import (Ada, E062, "ada__strings__maps_E");
   E416 : Short_Integer; pragma Import (Ada, E416, "ada__strings__maps__constants_E");
   E329 : Short_Integer; pragma Import (Ada, E329, "ada__strings__utf_encoding_E");
   E046 : Short_Integer; pragma Import (Ada, E046, "ada__tags_E");
   E057 : Short_Integer; pragma Import (Ada, E057, "ada__streams_E");
   E070 : Short_Integer; pragma Import (Ada, E070, "interfaces__c_E");
   E072 : Short_Integer; pragma Import (Ada, E072, "interfaces__c__strings_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exceptions_E");
   E243 : Short_Integer; pragma Import (Ada, E243, "system__finalization_root_E");
   E241 : Short_Integer; pragma Import (Ada, E241, "ada__finalization_E");
   E245 : Short_Integer; pragma Import (Ada, E245, "system__storage_pools_E");
   E235 : Short_Integer; pragma Import (Ada, E235, "system__finalization_masters_E");
   E231 : Short_Integer; pragma Import (Ada, E231, "system__storage_pools__subpools_E");
   E396 : Short_Integer; pragma Import (Ada, E396, "ada__calendar_E");
   E402 : Short_Integer; pragma Import (Ada, E402, "ada__calendar__time_zones_E");
   E313 : Short_Integer; pragma Import (Ada, E313, "system__pool_global_E");
   E360 : Short_Integer; pragma Import (Ada, E360, "system__file_control_block_E");
   E429 : Short_Integer; pragma Import (Ada, E429, "ada__streams__stream_io_E");
   E352 : Short_Integer; pragma Import (Ada, E352, "system__file_io_E");
   E369 : Short_Integer; pragma Import (Ada, E369, "ada__wide_wide_text_io_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__secondary_stack_E");
   E420 : Short_Integer; pragma Import (Ada, E420, "ada__strings__unbounded_E");
   E623 : Short_Integer; pragma Import (Ada, E623, "ada__strings__wide_wide_maps_E");
   E648 : Short_Integer; pragma Import (Ada, E648, "ada__strings__wide_wide_unbounded_E");
   E394 : Short_Integer; pragma Import (Ada, E394, "ada__directories_E");
   E427 : Short_Integer; pragma Import (Ada, E427, "system__regexp_E");
   E348 : Short_Integer; pragma Import (Ada, E348, "ada__text_io_E");
   E566 : Short_Integer; pragma Import (Ada, E566, "matreshka__internals__calendars_E");
   E565 : Short_Integer; pragma Import (Ada, E565, "league__calendars_E");
   E278 : Short_Integer; pragma Import (Ada, E278, "matreshka__internals__stream_element_vectors_E");
   E341 : Short_Integer; pragma Import (Ada, E341, "league__stream_element_vectors_E");
   E078 : Short_Integer; pragma Import (Ada, E078, "league__characters_E");
   E084 : Short_Integer; pragma Import (Ada, E084, "matreshka__internals__unicode__properties_E");
   E275 : Short_Integer; pragma Import (Ada, E275, "matreshka__internals__locales_E");
   E323 : Short_Integer; pragma Import (Ada, E323, "matreshka__internals__unicode__ucd__norms_E");
   E249 : Short_Integer; pragma Import (Ada, E249, "matreshka__internals__strings_E");
   E076 : Short_Integer; pragma Import (Ada, E076, "league__strings_E");
   E563 : Short_Integer; pragma Import (Ada, E563, "league__holders_E");
   E271 : Short_Integer; pragma Import (Ada, E271, "matreshka__internals__string_vectors_E");
   E227 : Short_Integer; pragma Import (Ada, E227, "league__string_vectors_E");
   E371 : Short_Integer; pragma Import (Ada, E371, "league__iris_E");
   E383 : Short_Integer; pragma Import (Ada, E383, "matreshka__internals__sax_locators_E");
   E255 : Short_Integer; pragma Import (Ada, E255, "matreshka__internals__strings__handlers_E");
   E267 : Short_Integer; pragma Import (Ada, E267, "matreshka__internals__strings__handlers__portable_E");
   E257 : Short_Integer; pragma Import (Ada, E257, "matreshka__internals__strings__handlers__x86_64_E");
   E282 : Short_Integer; pragma Import (Ada, E282, "matreshka__internals__text_codecs_E");
   E284 : Short_Integer; pragma Import (Ada, E284, "matreshka__internals__text_codecs__ascii_E");
   E287 : Short_Integer; pragma Import (Ada, E287, "matreshka__internals__text_codecs__iana_registry_E");
   E289 : Short_Integer; pragma Import (Ada, E289, "matreshka__internals__text_codecs__ibm437_E");
   E291 : Short_Integer; pragma Import (Ada, E291, "matreshka__internals__text_codecs__iso88591_E");
   E293 : Short_Integer; pragma Import (Ada, E293, "matreshka__internals__text_codecs__iso88595_E");
   E295 : Short_Integer; pragma Import (Ada, E295, "matreshka__internals__text_codecs__koi8r_E");
   E297 : Short_Integer; pragma Import (Ada, E297, "matreshka__internals__text_codecs__koi8u_E");
   E299 : Short_Integer; pragma Import (Ada, E299, "matreshka__internals__text_codecs__shiftjis_E");
   E302 : Short_Integer; pragma Import (Ada, E302, "matreshka__internals__text_codecs__utf16_E");
   E304 : Short_Integer; pragma Import (Ada, E304, "matreshka__internals__text_codecs__utf8_E");
   E306 : Short_Integer; pragma Import (Ada, E306, "matreshka__internals__text_codecs__windows1250_E");
   E308 : Short_Integer; pragma Import (Ada, E308, "matreshka__internals__text_codecs__windows1251_E");
   E310 : Short_Integer; pragma Import (Ada, E310, "matreshka__internals__text_codecs__windows1252_E");
   E473 : Short_Integer; pragma Import (Ada, E473, "matreshka__internals__xml__base_scopes_E");
   E496 : Short_Integer; pragma Import (Ada, E496, "matreshka__xml_schema__ast_E");
   E498 : Short_Integer; pragma Import (Ada, E498, "matreshka__xml_schema__ast__annotations_E");
   E541 : Short_Integer; pragma Import (Ada, E541, "matreshka__xml_schema__named_maps_E");
   E525 : Short_Integer; pragma Import (Ada, E525, "matreshka__xml_schema__object_lists_E");
   E500 : Short_Integer; pragma Import (Ada, E500, "matreshka__xml_schema__visitors_E");
   E617 : Short_Integer; pragma Import (Ada, E617, "matreshka__xml_schema__containment_iterators_E");
   E635 : Short_Integer; pragma Import (Ada, E635, "matreshka__xml_schema__namespace_builders_E");
   E378 : Short_Integer; pragma Import (Ada, E378, "xml__sax__attributes_E");
   E486 : Short_Integer; pragma Import (Ada, E486, "xml__sax__declaration_handlers_E");
   E487 : Short_Integer; pragma Import (Ada, E487, "xml__sax__dtd_handlers_E");
   E388 : Short_Integer; pragma Import (Ada, E388, "xml__sax__input_sources_E");
   E489 : Short_Integer; pragma Import (Ada, E489, "xml__sax__entity_resolvers_E");
   E390 : Short_Integer; pragma Import (Ada, E390, "xml__sax__input_sources__streams_E");
   E387 : Short_Integer; pragma Import (Ada, E387, "xml__sax__lexical_handlers_E");
   E381 : Short_Integer; pragma Import (Ada, E381, "xml__sax__locators_E");
   E379 : Short_Integer; pragma Import (Ada, E379, "xml__sax__content_handlers_E");
   E386 : Short_Integer; pragma Import (Ada, E386, "xml__sax__parse_exceptions_E");
   E384 : Short_Integer; pragma Import (Ada, E384, "xml__sax__error_handlers_E");
   E485 : Short_Integer; pragma Import (Ada, E485, "xml__sax__default_handlers_E");
   E488 : Short_Integer; pragma Import (Ada, E488, "xml__sax__readers_E");
   E505 : Short_Integer; pragma Import (Ada, E505, "matreshka__xml_schema__ast__objects_E");
   E504 : Short_Integer; pragma Import (Ada, E504, "matreshka__xml_schema__ast__types_E");
   E502 : Short_Integer; pragma Import (Ada, E502, "matreshka__xml_schema__ast__assertions_E");
   E509 : Short_Integer; pragma Import (Ada, E509, "matreshka__xml_schema__ast__attribute_declarations_E");
   E511 : Short_Integer; pragma Import (Ada, E511, "matreshka__xml_schema__ast__attribute_groups_E");
   E513 : Short_Integer; pragma Import (Ada, E513, "matreshka__xml_schema__ast__attribute_uses_E");
   E515 : Short_Integer; pragma Import (Ada, E515, "matreshka__xml_schema__ast__complex_types_E");
   E517 : Short_Integer; pragma Import (Ada, E517, "matreshka__xml_schema__ast__constraining_facets_E");
   E519 : Short_Integer; pragma Import (Ada, E519, "matreshka__xml_schema__ast__element_declarations_E");
   E521 : Short_Integer; pragma Import (Ada, E521, "matreshka__xml_schema__ast__identity_constraints_E");
   E523 : Short_Integer; pragma Import (Ada, E523, "matreshka__xml_schema__ast__model_groups_E");
   E527 : Short_Integer; pragma Import (Ada, E527, "matreshka__xml_schema__ast__models_E");
   E529 : Short_Integer; pragma Import (Ada, E529, "matreshka__xml_schema__ast__namespaces_E");
   E531 : Short_Integer; pragma Import (Ada, E531, "matreshka__xml_schema__ast__notation_declarations_E");
   E533 : Short_Integer; pragma Import (Ada, E533, "matreshka__xml_schema__ast__particles_E");
   E507 : Short_Integer; pragma Import (Ada, E507, "matreshka__xml_schema__ast__schemas_E");
   E535 : Short_Integer; pragma Import (Ada, E535, "matreshka__xml_schema__ast__simple_types_E");
   E537 : Short_Integer; pragma Import (Ada, E537, "matreshka__xml_schema__ast__type_alternatives_E");
   E539 : Short_Integer; pragma Import (Ada, E539, "matreshka__xml_schema__ast__wildcards_E");
   E611 : Short_Integer; pragma Import (Ada, E611, "xml__schema__namespace_item_lists_E");
   E544 : Short_Integer; pragma Import (Ada, E544, "xml__schema__objects_E");
   E596 : Short_Integer; pragma Import (Ada, E596, "xml__schema__named_maps_E");
   E550 : Short_Integer; pragma Import (Ada, E550, "xml__schema__object_lists_E");
   E556 : Short_Integer; pragma Import (Ada, E556, "xml__schema__objects__annotations_E");
   E592 : Short_Integer; pragma Import (Ada, E592, "xml__schema__objects__attribute_group_definitions_E");
   E594 : Short_Integer; pragma Import (Ada, E594, "xml__schema__objects__model_group_definitions_E");
   E598 : Short_Integer; pragma Import (Ada, E598, "xml__schema__objects__notation_declarations_E");
   E546 : Short_Integer; pragma Import (Ada, E546, "xml__schema__objects__terms_E");
   E581 : Short_Integer; pragma Import (Ada, E581, "xml__schema__objects__particles_E");
   E548 : Short_Integer; pragma Import (Ada, E548, "xml__schema__objects__terms__model_groups_E");
   E575 : Short_Integer; pragma Import (Ada, E575, "xml__schema__objects__type_definitions_E");
   E579 : Short_Integer; pragma Import (Ada, E579, "xml__schema__objects__type_definitions__complex_type_definitions_E");
   E588 : Short_Integer; pragma Import (Ada, E588, "xml__schema__objects__type_definitions__simple_type_definitions_E");
   E561 : Short_Integer; pragma Import (Ada, E561, "xml__schema__objects__attribute_declarations_E");
   E601 : Short_Integer; pragma Import (Ada, E601, "xml__schema__objects__terms__element_declarations_E");
   E494 : Short_Integer; pragma Import (Ada, E494, "xml__schema__models_E");
   E558 : Short_Integer; pragma Import (Ada, E558, "xml__schema__namespace_items_E");
   E660 : Short_Integer; pragma Import (Ada, E660, "xsd_to_ada__writers_E");
   E074 : Short_Integer; pragma Import (Ada, E074, "league__environment_variables_E");
   E056 : Short_Integer; pragma Import (Ada, E056, "league__application_E");
   E337 : Short_Integer; pragma Import (Ada, E337, "league__text_codecs_E");
   E363 : Short_Integer; pragma Import (Ada, E363, "matreshka__xml_catalogs__entry_files_E");
   E367 : Short_Integer; pragma Import (Ada, E367, "matreshka__xml_catalogs__handlers_E");
   E365 : Short_Integer; pragma Import (Ada, E365, "matreshka__xml_catalogs__loader_E");
   E374 : Short_Integer; pragma Import (Ada, E374, "matreshka__xml_catalogs__normalization_E");
   E491 : Short_Integer; pragma Import (Ada, E491, "matreshka__xml_catalogs__resolver_E");
   E615 : Short_Integer; pragma Import (Ada, E615, "matreshka__xml_schema__loaders_E");
   E619 : Short_Integer; pragma Import (Ada, E619, "matreshka__xml_schema__handlers_E");
   E633 : Short_Integer; pragma Import (Ada, E633, "matreshka__xml_schema__name_resolvers_E");
   E346 : Short_Integer; pragma Import (Ada, E346, "matreshka__xml_schema__uri_rewriter_E");
   E436 : Short_Integer; pragma Import (Ada, E436, "xml__sax__constants_E");
   E392 : Short_Integer; pragma Import (Ada, E392, "xml__sax__input_sources__streams__files_E");
   E433 : Short_Integer; pragma Import (Ada, E433, "xml__sax__simple_readers_E");
   E456 : Short_Integer; pragma Import (Ada, E456, "xml__sax__simple_readers__analyzer_E");
   E438 : Short_Integer; pragma Import (Ada, E438, "xml__sax__simple_readers__callbacks_E");
   E446 : Short_Integer; pragma Import (Ada, E446, "xml__sax__simple_readers__parser_E");
   E452 : Short_Integer; pragma Import (Ada, E452, "xml__sax__simple_readers__parser__actions_E");
   E444 : Short_Integer; pragma Import (Ada, E444, "xml__sax__simple_readers__resolver_E");
   E458 : Short_Integer; pragma Import (Ada, E458, "xml__sax__simple_readers__scanner_E");
   E462 : Short_Integer; pragma Import (Ada, E462, "xml__sax__simple_readers__scanner__actions_E");
   E463 : Short_Integer; pragma Import (Ada, E463, "xml__sax__simple_readers__scanner__tables_E");
   E465 : Short_Integer; pragma Import (Ada, E465, "xml__sax__simple_readers__validator_E");
   E637 : Short_Integer; pragma Import (Ada, E637, "xml__schema__models__internals_E");
   E613 : Short_Integer; pragma Import (Ada, E613, "xml__schema__utilities_E");
   E640 : Short_Integer; pragma Import (Ada, E640, "xsd_to_ada__generator_E");
   E643 : Short_Integer; pragma Import (Ada, E643, "xsd_to_ada__mappings_E");
   E642 : Short_Integer; pragma Import (Ada, E642, "xsd_to_ada__mappings_xml_E");
   E645 : Short_Integer; pragma Import (Ada, E645, "xsd_to_ada__utils_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E645 := E645 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "xsd_to_ada__utils__finalize_spec");
      begin
         F1;
      end;
      E642 := E642 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "xsd_to_ada__mappings_xml__finalize_spec");
      begin
         F2;
      end;
      E433 := E433 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "xml__sax__simple_readers__resolver__finalize_body");
      begin
         E444 := E444 - 1;
         F3;
      end;
      E615 := E615 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "matreshka__xml_schema__handlers__finalize_body");
      begin
         E619 := E619 - 1;
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "xml__sax__simple_readers__finalize_spec");
      begin
         F5;
      end;
      E392 := E392 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "xml__sax__input_sources__streams__files__finalize_spec");
      begin
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "xml__sax__constants__finalize_spec");
      begin
         E436 := E436 - 1;
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "matreshka__xml_schema__uri_rewriter__finalize_body");
      begin
         E346 := E346 - 1;
         F8;
      end;
      E633 := E633 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "matreshka__xml_schema__name_resolvers__finalize_spec");
      begin
         F9;
      end;
      declare
         procedure F10;
         pragma Import (Ada, F10, "matreshka__xml_schema__handlers__finalize_spec");
      begin
         F10;
      end;
      declare
         procedure F11;
         pragma Import (Ada, F11, "matreshka__xml_schema__loaders__finalize_spec");
      begin
         F11;
      end;
      declare
         procedure F12;
         pragma Import (Ada, F12, "matreshka__xml_catalogs__resolver__finalize_body");
      begin
         E491 := E491 - 1;
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "matreshka__xml_catalogs__handlers__finalize_body");
      begin
         E367 := E367 - 1;
         F13;
      end;
      declare
         procedure F14;
         pragma Import (Ada, F14, "matreshka__xml_catalogs__normalization__finalize_body");
      begin
         E374 := E374 - 1;
         F14;
      end;
      declare
         procedure F15;
         pragma Import (Ada, F15, "matreshka__xml_catalogs__handlers__finalize_spec");
      begin
         F15;
      end;
      E363 := E363 - 1;
      declare
         procedure F16;
         pragma Import (Ada, F16, "matreshka__xml_catalogs__entry_files__finalize_spec");
      begin
         F16;
      end;
      declare
         procedure F17;
         pragma Import (Ada, F17, "league__application__finalize_body");
      begin
         E056 := E056 - 1;
         F17;
      end;
      E337 := E337 - 1;
      declare
         procedure F18;
         pragma Import (Ada, F18, "league__text_codecs__finalize_spec");
      begin
         F18;
      end;
      E074 := E074 - 1;
      declare
         procedure F19;
         pragma Import (Ada, F19, "league__environment_variables__finalize_spec");
      begin
         F19;
      end;
      E660 := E660 - 1;
      declare
         procedure F20;
         pragma Import (Ada, F20, "xsd_to_ada__writers__finalize_spec");
      begin
         F20;
      end;
      E544 := E544 - 1;
      E494 := E494 - 1;
      E558 := E558 - 1;
      declare
         procedure F21;
         pragma Import (Ada, F21, "xml__schema__namespace_items__finalize_spec");
      begin
         F21;
      end;
      declare
         procedure F22;
         pragma Import (Ada, F22, "xml__schema__models__finalize_spec");
      begin
         F22;
      end;
      E601 := E601 - 1;
      declare
         procedure F23;
         pragma Import (Ada, F23, "xml__schema__objects__terms__element_declarations__finalize_spec");
      begin
         F23;
      end;
      E561 := E561 - 1;
      declare
         procedure F24;
         pragma Import (Ada, F24, "xml__schema__objects__attribute_declarations__finalize_spec");
      begin
         F24;
      end;
      E588 := E588 - 1;
      declare
         procedure F25;
         pragma Import (Ada, F25, "xml__schema__objects__type_definitions__simple_type_definitions__finalize_spec");
      begin
         F25;
      end;
      E575 := E575 - 1;
      E579 := E579 - 1;
      declare
         procedure F26;
         pragma Import (Ada, F26, "xml__schema__objects__type_definitions__complex_type_definitions__finalize_spec");
      begin
         F26;
      end;
      declare
         procedure F27;
         pragma Import (Ada, F27, "xml__schema__objects__type_definitions__finalize_spec");
      begin
         F27;
      end;
      E548 := E548 - 1;
      declare
         procedure F28;
         pragma Import (Ada, F28, "xml__schema__objects__terms__model_groups__finalize_spec");
      begin
         F28;
      end;
      E581 := E581 - 1;
      declare
         procedure F29;
         pragma Import (Ada, F29, "xml__schema__objects__particles__finalize_spec");
      begin
         F29;
      end;
      declare
         procedure F30;
         pragma Import (Ada, F30, "xml__schema__objects__terms__finalize_spec");
      begin
         E546 := E546 - 1;
         F30;
      end;
      declare
         procedure F31;
         pragma Import (Ada, F31, "xml__schema__objects__notation_declarations__finalize_spec");
      begin
         E598 := E598 - 1;
         F31;
      end;
      declare
         procedure F32;
         pragma Import (Ada, F32, "xml__schema__objects__model_group_definitions__finalize_spec");
      begin
         E594 := E594 - 1;
         F32;
      end;
      E596 := E596 - 1;
      E550 := E550 - 1;
      declare
         procedure F33;
         pragma Import (Ada, F33, "xml__schema__objects__attribute_group_definitions__finalize_spec");
      begin
         E592 := E592 - 1;
         F33;
      end;
      declare
         procedure F34;
         pragma Import (Ada, F34, "xml__schema__objects__annotations__finalize_spec");
      begin
         E556 := E556 - 1;
         F34;
      end;
      declare
         procedure F35;
         pragma Import (Ada, F35, "xml__schema__object_lists__finalize_spec");
      begin
         F35;
      end;
      declare
         procedure F36;
         pragma Import (Ada, F36, "xml__schema__named_maps__finalize_spec");
      begin
         F36;
      end;
      declare
         procedure F37;
         pragma Import (Ada, F37, "xml__schema__objects__finalize_spec");
      begin
         F37;
      end;
      declare
         procedure F38;
         pragma Import (Ada, F38, "xml__schema__namespace_item_lists__finalize_spec");
      begin
         E611 := E611 - 1;
         F38;
      end;
      E617 := E617 - 1;
      E539 := E539 - 1;
      declare
         procedure F39;
         pragma Import (Ada, F39, "matreshka__xml_schema__ast__wildcards__finalize_spec");
      begin
         F39;
      end;
      E537 := E537 - 1;
      declare
         procedure F40;
         pragma Import (Ada, F40, "matreshka__xml_schema__ast__type_alternatives__finalize_spec");
      begin
         F40;
      end;
      E635 := E635 - 1;
      E535 := E535 - 1;
      declare
         procedure F41;
         pragma Import (Ada, F41, "matreshka__xml_schema__ast__simple_types__finalize_spec");
      begin
         F41;
      end;
      E507 := E507 - 1;
      declare
         procedure F42;
         pragma Import (Ada, F42, "matreshka__xml_schema__ast__schemas__finalize_spec");
      begin
         F42;
      end;
      E533 := E533 - 1;
      declare
         procedure F43;
         pragma Import (Ada, F43, "matreshka__xml_schema__ast__particles__finalize_spec");
      begin
         F43;
      end;
      E531 := E531 - 1;
      declare
         procedure F44;
         pragma Import (Ada, F44, "matreshka__xml_schema__ast__notation_declarations__finalize_spec");
      begin
         F44;
      end;
      E527 := E527 - 1;
      E529 := E529 - 1;
      declare
         procedure F45;
         pragma Import (Ada, F45, "matreshka__xml_schema__ast__namespaces__finalize_spec");
      begin
         F45;
      end;
      declare
         procedure F46;
         pragma Import (Ada, F46, "matreshka__xml_schema__ast__models__finalize_spec");
      begin
         F46;
      end;
      E523 := E523 - 1;
      declare
         procedure F47;
         pragma Import (Ada, F47, "matreshka__xml_schema__ast__model_groups__finalize_spec");
      begin
         F47;
      end;
      E521 := E521 - 1;
      declare
         procedure F48;
         pragma Import (Ada, F48, "matreshka__xml_schema__ast__identity_constraints__finalize_spec");
      begin
         F48;
      end;
      E519 := E519 - 1;
      declare
         procedure F49;
         pragma Import (Ada, F49, "matreshka__xml_schema__ast__element_declarations__finalize_spec");
      begin
         F49;
      end;
      E517 := E517 - 1;
      declare
         procedure F50;
         pragma Import (Ada, F50, "matreshka__xml_schema__ast__constraining_facets__finalize_spec");
      begin
         F50;
      end;
      E515 := E515 - 1;
      declare
         procedure F51;
         pragma Import (Ada, F51, "matreshka__xml_schema__ast__complex_types__finalize_spec");
      begin
         F51;
      end;
      E513 := E513 - 1;
      declare
         procedure F52;
         pragma Import (Ada, F52, "matreshka__xml_schema__ast__attribute_uses__finalize_spec");
      begin
         F52;
      end;
      E511 := E511 - 1;
      declare
         procedure F53;
         pragma Import (Ada, F53, "matreshka__xml_schema__ast__attribute_groups__finalize_spec");
      begin
         F53;
      end;
      E509 := E509 - 1;
      declare
         procedure F54;
         pragma Import (Ada, F54, "matreshka__xml_schema__ast__attribute_declarations__finalize_spec");
      begin
         F54;
      end;
      E502 := E502 - 1;
      declare
         procedure F55;
         pragma Import (Ada, F55, "matreshka__xml_schema__ast__assertions__finalize_spec");
      begin
         F55;
      end;
      E504 := E504 - 1;
      declare
         procedure F56;
         pragma Import (Ada, F56, "matreshka__xml_schema__ast__types__finalize_spec");
      begin
         F56;
      end;
      E541 := E541 - 1;
      declare
         procedure F57;
         pragma Import (Ada, F57, "xml__sax__readers__finalize_spec");
      begin
         E488 := E488 - 1;
         F57;
      end;
      E485 := E485 - 1;
      declare
         procedure F58;
         pragma Import (Ada, F58, "xml__sax__default_handlers__finalize_spec");
      begin
         F58;
      end;
      E386 := E386 - 1;
      declare
         procedure F59;
         pragma Import (Ada, F59, "xml__sax__parse_exceptions__finalize_spec");
      begin
         F59;
      end;
      E381 := E381 - 1;
      declare
         procedure F60;
         pragma Import (Ada, F60, "xml__sax__locators__finalize_spec");
      begin
         F60;
      end;
      E390 := E390 - 1;
      declare
         procedure F61;
         pragma Import (Ada, F61, "xml__sax__input_sources__streams__finalize_spec");
      begin
         F61;
      end;
      declare
         procedure F62;
         pragma Import (Ada, F62, "xml__sax__input_sources__finalize_spec");
      begin
         E388 := E388 - 1;
         F62;
      end;
      E378 := E378 - 1;
      declare
         procedure F63;
         pragma Import (Ada, F63, "xml__sax__attributes__finalize_spec");
      begin
         F63;
      end;
      declare
         procedure F64;
         pragma Import (Ada, F64, "matreshka__xml_schema__namespace_builders__finalize_spec");
      begin
         F64;
      end;
      declare
         procedure F65;
         pragma Import (Ada, F65, "matreshka__xml_schema__containment_iterators__finalize_spec");
      begin
         F65;
      end;
      E498 := E498 - 1;
      E525 := E525 - 1;
      declare
         procedure F66;
         pragma Import (Ada, F66, "matreshka__xml_schema__object_lists__finalize_spec");
      begin
         F66;
      end;
      declare
         procedure F67;
         pragma Import (Ada, F67, "matreshka__xml_schema__named_maps__finalize_spec");
      begin
         F67;
      end;
      declare
         procedure F68;
         pragma Import (Ada, F68, "matreshka__xml_schema__ast__annotations__finalize_spec");
      begin
         F68;
      end;
      E496 := E496 - 1;
      declare
         procedure F69;
         pragma Import (Ada, F69, "matreshka__xml_schema__ast__finalize_spec");
      begin
         F69;
      end;
      E473 := E473 - 1;
      declare
         procedure F70;
         pragma Import (Ada, F70, "matreshka__internals__xml__base_scopes__finalize_spec");
      begin
         F70;
      end;
      E076 := E076 - 1;
      E282 := E282 - 1;
      E310 := E310 - 1;
      declare
         procedure F71;
         pragma Import (Ada, F71, "matreshka__internals__text_codecs__windows1252__finalize_spec");
      begin
         F71;
      end;
      E308 := E308 - 1;
      declare
         procedure F72;
         pragma Import (Ada, F72, "matreshka__internals__text_codecs__windows1251__finalize_spec");
      begin
         F72;
      end;
      E306 := E306 - 1;
      declare
         procedure F73;
         pragma Import (Ada, F73, "matreshka__internals__text_codecs__windows1250__finalize_spec");
      begin
         F73;
      end;
      E304 := E304 - 1;
      declare
         procedure F74;
         pragma Import (Ada, F74, "matreshka__internals__text_codecs__utf8__finalize_spec");
      begin
         F74;
      end;
      E302 := E302 - 1;
      declare
         procedure F75;
         pragma Import (Ada, F75, "matreshka__internals__text_codecs__utf16__finalize_spec");
      begin
         F75;
      end;
      E299 := E299 - 1;
      declare
         procedure F76;
         pragma Import (Ada, F76, "matreshka__internals__text_codecs__shiftjis__finalize_spec");
      begin
         F76;
      end;
      E297 := E297 - 1;
      declare
         procedure F77;
         pragma Import (Ada, F77, "matreshka__internals__text_codecs__koi8u__finalize_spec");
      begin
         F77;
      end;
      E295 := E295 - 1;
      declare
         procedure F78;
         pragma Import (Ada, F78, "matreshka__internals__text_codecs__koi8r__finalize_spec");
      begin
         F78;
      end;
      E293 := E293 - 1;
      declare
         procedure F79;
         pragma Import (Ada, F79, "matreshka__internals__text_codecs__iso88595__finalize_spec");
      begin
         F79;
      end;
      E291 := E291 - 1;
      declare
         procedure F80;
         pragma Import (Ada, F80, "matreshka__internals__text_codecs__iso88591__finalize_spec");
      begin
         F80;
      end;
      E289 := E289 - 1;
      declare
         procedure F81;
         pragma Import (Ada, F81, "matreshka__internals__text_codecs__ibm437__finalize_spec");
      begin
         F81;
      end;
      E284 := E284 - 1;
      declare
         procedure F82;
         pragma Import (Ada, F82, "matreshka__internals__text_codecs__ascii__finalize_spec");
      begin
         F82;
      end;
      declare
         procedure F83;
         pragma Import (Ada, F83, "matreshka__internals__text_codecs__finalize_spec");
      begin
         F83;
      end;
      E227 := E227 - 1;
      E267 := E267 - 1;
      declare
         procedure F84;
         pragma Import (Ada, F84, "matreshka__internals__strings__handlers__portable__finalize_spec");
      begin
         F84;
      end;
      E383 := E383 - 1;
      declare
         procedure F85;
         pragma Import (Ada, F85, "matreshka__internals__sax_locators__finalize_spec");
      begin
         F85;
      end;
      E371 := E371 - 1;
      declare
         procedure F86;
         pragma Import (Ada, F86, "league__iris__finalize_spec");
      begin
         F86;
      end;
      declare
         procedure F87;
         pragma Import (Ada, F87, "league__string_vectors__finalize_spec");
      begin
         F87;
      end;
      E563 := E563 - 1;
      declare
         procedure F88;
         pragma Import (Ada, F88, "league__holders__finalize_spec");
      begin
         F88;
      end;
      declare
         procedure F89;
         pragma Import (Ada, F89, "league__strings__finalize_spec");
      begin
         F89;
      end;
      E275 := E275 - 1;
      declare
         procedure F90;
         pragma Import (Ada, F90, "matreshka__internals__locales__finalize_spec");
      begin
         F90;
      end;
      E078 := E078 - 1;
      declare
         procedure F91;
         pragma Import (Ada, F91, "league__characters__finalize_spec");
      begin
         F91;
      end;
      E341 := E341 - 1;
      declare
         procedure F92;
         pragma Import (Ada, F92, "league__stream_element_vectors__finalize_spec");
      begin
         F92;
      end;
      E348 := E348 - 1;
      declare
         procedure F93;
         pragma Import (Ada, F93, "ada__text_io__finalize_spec");
      begin
         F93;
      end;
      E369 := E369 - 1;
      E394 := E394 - 1;
      E427 := E427 - 1;
      declare
         procedure F94;
         pragma Import (Ada, F94, "system__regexp__finalize_spec");
      begin
         F94;
      end;
      declare
         procedure F95;
         pragma Import (Ada, F95, "ada__directories__finalize_spec");
      begin
         F95;
      end;
      E648 := E648 - 1;
      declare
         procedure F96;
         pragma Import (Ada, F96, "ada__strings__wide_wide_unbounded__finalize_spec");
      begin
         F96;
      end;
      E623 := E623 - 1;
      declare
         procedure F97;
         pragma Import (Ada, F97, "ada__strings__wide_wide_maps__finalize_spec");
      begin
         F97;
      end;
      E420 := E420 - 1;
      declare
         procedure F98;
         pragma Import (Ada, F98, "ada__strings__unbounded__finalize_spec");
      begin
         F98;
      end;
      E235 := E235 - 1;
      E231 := E231 - 1;
      declare
         procedure F99;
         pragma Import (Ada, F99, "system__file_io__finalize_body");
      begin
         E352 := E352 - 1;
         F99;
      end;
      declare
         procedure F100;
         pragma Import (Ada, F100, "ada__wide_wide_text_io__finalize_spec");
      begin
         F100;
      end;
      E429 := E429 - 1;
      declare
         procedure F101;
         pragma Import (Ada, F101, "ada__streams__stream_io__finalize_spec");
      begin
         F101;
      end;
      declare
         procedure F102;
         pragma Import (Ada, F102, "system__file_control_block__finalize_spec");
      begin
         E360 := E360 - 1;
         F102;
      end;
      E313 := E313 - 1;
      declare
         procedure F103;
         pragma Import (Ada, F103, "system__pool_global__finalize_spec");
      begin
         F103;
      end;
      declare
         procedure F104;
         pragma Import (Ada, F104, "system__storage_pools__subpools__finalize_spec");
      begin
         F104;
      end;
      declare
         procedure F105;
         pragma Import (Ada, F105, "system__finalization_masters__finalize_spec");
      begin
         F105;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");
   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Install_Handler;
      pragma Import (C, Install_Handler, "__gnat_install_handler");

      Handler_Installed : Integer;
      pragma Import (C, Handler_Installed, "__gnat_handler_installed");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      if Handler_Installed = 0 then
         Install_Handler;
      end if;

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E021 := E021 + 1;
      Ada.Containers'Elab_Spec;
      E332 := E332 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E223 := E223 + 1;
      Ada.Strings'Elab_Spec;
      E058 := E058 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E416 := E416 + 1;
      Ada.Strings.Utf_Encoding'Elab_Spec;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E057 := E057 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E027 := E027 + 1;
      System.Finalization_Root'Elab_Spec;
      E243 := E243 + 1;
      Ada.Finalization'Elab_Spec;
      E241 := E241 + 1;
      System.Storage_Pools'Elab_Spec;
      E245 := E245 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Storage_Pools.Subpools'Elab_Spec;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E396 := E396 + 1;
      Ada.Calendar.Time_Zones'Elab_Spec;
      E402 := E402 + 1;
      System.Pool_Global'Elab_Spec;
      E313 := E313 + 1;
      System.File_Control_Block'Elab_Spec;
      E360 := E360 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E429 := E429 + 1;
      Ada.Wide_Wide_Text_Io'Elab_Spec;
      System.File_Io'Elab_Body;
      E352 := E352 + 1;
      E231 := E231 + 1;
      System.Finalization_Masters'Elab_Body;
      E235 := E235 + 1;
      E072 := E072 + 1;
      E070 := E070 + 1;
      Ada.Tags'Elab_Body;
      E046 := E046 + 1;
      E329 := E329 + 1;
      E062 := E062 + 1;
      System.Soft_Links'Elab_Body;
      E011 := E011 + 1;
      System.Os_Lib'Elab_Body;
      E357 := E357 + 1;
      System.Secondary_Stack'Elab_Body;
      E015 := E015 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E420 := E420 + 1;
      Ada.Strings.Wide_Wide_Maps'Elab_Spec;
      E623 := E623 + 1;
      Ada.Strings.Wide_Wide_Unbounded'Elab_Spec;
      E648 := E648 + 1;
      Ada.Directories'Elab_Spec;
      System.Regexp'Elab_Spec;
      E427 := E427 + 1;
      Ada.Directories'Elab_Body;
      E394 := E394 + 1;
      Ada.Wide_Wide_Text_Io'Elab_Body;
      E369 := E369 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E348 := E348 + 1;
      Matreshka.Internals.Calendars'Elab_Spec;
      E566 := E566 + 1;
      League.Calendars'Elab_Spec;
      E565 := E565 + 1;
      Matreshka.Internals.Stream_Element_Vectors'Elab_Spec;
      E278 := E278 + 1;
      League.Stream_Element_Vectors'Elab_Spec;
      E341 := E341 + 1;
      League.Characters'Elab_Spec;
      E078 := E078 + 1;
      Matreshka.Internals.Locales'Elab_Spec;
      Matreshka.Internals.Locales'Elab_Body;
      E275 := E275 + 1;
      Matreshka.Internals.Unicode.Properties'Elab_Body;
      E084 := E084 + 1;
      Matreshka.Internals.Unicode.Ucd.Norms'Elab_Spec;
      E323 := E323 + 1;
      Matreshka.Internals.Strings'Elab_Spec;
      League.Strings'Elab_Spec;
      League.Holders'Elab_Spec;
      E563 := E563 + 1;
      Matreshka.Internals.String_Vectors'Elab_Spec;
      E271 := E271 + 1;
      League.String_Vectors'Elab_Spec;
      League.Iris'Elab_Spec;
      E371 := E371 + 1;
      Matreshka.Internals.Sax_Locators'Elab_Spec;
      E383 := E383 + 1;
      Matreshka.Internals.Strings.Handlers'Elab_Spec;
      E255 := E255 + 1;
      Matreshka.Internals.Strings.Handlers.Portable'Elab_Spec;
      E267 := E267 + 1;
      Matreshka.Internals.Strings.Handlers.X86_64'Elab_Spec;
      E257 := E257 + 1;
      E227 := E227 + 1;
      Matreshka.Internals.Strings'Elab_Body;
      E249 := E249 + 1;
      Matreshka.Internals.Text_Codecs'Elab_Spec;
      Matreshka.Internals.Text_Codecs.Ascii'Elab_Spec;
      E284 := E284 + 1;
      Matreshka.Internals.Text_Codecs.Iana_Registry'Elab_Spec;
      E287 := E287 + 1;
      Matreshka.Internals.Text_Codecs.Ibm437'Elab_Spec;
      E289 := E289 + 1;
      Matreshka.Internals.Text_Codecs.Iso88591'Elab_Spec;
      E291 := E291 + 1;
      Matreshka.Internals.Text_Codecs.Iso88595'Elab_Spec;
      E293 := E293 + 1;
      Matreshka.Internals.Text_Codecs.Koi8r'Elab_Spec;
      E295 := E295 + 1;
      Matreshka.Internals.Text_Codecs.Koi8u'Elab_Spec;
      E297 := E297 + 1;
      Matreshka.Internals.Text_Codecs.Shiftjis'Elab_Spec;
      E299 := E299 + 1;
      Matreshka.Internals.Text_Codecs.Utf16'Elab_Spec;
      E302 := E302 + 1;
      Matreshka.Internals.Text_Codecs.Utf8'Elab_Spec;
      E304 := E304 + 1;
      Matreshka.Internals.Text_Codecs.Windows1250'Elab_Spec;
      E306 := E306 + 1;
      Matreshka.Internals.Text_Codecs.Windows1251'Elab_Spec;
      E308 := E308 + 1;
      Matreshka.Internals.Text_Codecs.Windows1252'Elab_Spec;
      E310 := E310 + 1;
      E282 := E282 + 1;
      E076 := E076 + 1;
      Matreshka.Internals.Xml.Base_Scopes'Elab_Spec;
      E473 := E473 + 1;
      Matreshka.Xml_Schema.Ast'Elab_Spec;
      E496 := E496 + 1;
      Matreshka.Xml_Schema.Ast.Annotations'Elab_Spec;
      Matreshka.Xml_Schema.Named_Maps'Elab_Spec;
      Matreshka.Xml_Schema.Object_Lists'Elab_Spec;
      E525 := E525 + 1;
      Matreshka.Xml_Schema.Visitors'Elab_Spec;
      E500 := E500 + 1;
      E498 := E498 + 1;
      Matreshka.Xml_Schema.Containment_Iterators'Elab_Spec;
      Matreshka.Xml_Schema.Namespace_Builders'Elab_Spec;
      XML.SAX.ATTRIBUTES'ELAB_SPEC;
      E378 := E378 + 1;
      XML.SAX.DECLARATION_HANDLERS'ELAB_SPEC;
      E486 := E486 + 1;
      XML.SAX.DTD_HANDLERS'ELAB_SPEC;
      E487 := E487 + 1;
      XML.SAX.INPUT_SOURCES'ELAB_SPEC;
      E388 := E388 + 1;
      XML.SAX.ENTITY_RESOLVERS'ELAB_SPEC;
      E489 := E489 + 1;
      XML.SAX.INPUT_SOURCES.STREAMS'ELAB_SPEC;
      E390 := E390 + 1;
      XML.SAX.LEXICAL_HANDLERS'ELAB_SPEC;
      E387 := E387 + 1;
      XML.SAX.LOCATORS'ELAB_SPEC;
      E381 := E381 + 1;
      XML.SAX.CONTENT_HANDLERS'ELAB_SPEC;
      E379 := E379 + 1;
      XML.SAX.PARSE_EXCEPTIONS'ELAB_SPEC;
      E386 := E386 + 1;
      XML.SAX.ERROR_HANDLERS'ELAB_SPEC;
      E384 := E384 + 1;
      XML.SAX.DEFAULT_HANDLERS'ELAB_SPEC;
      E485 := E485 + 1;
      XML.SAX.READERS'ELAB_SPEC;
      E488 := E488 + 1;
      Matreshka.Xml_Schema.Ast.Objects'Elab_Spec;
      E505 := E505 + 1;
      E541 := E541 + 1;
      Matreshka.Xml_Schema.Ast.Types'Elab_Spec;
      E504 := E504 + 1;
      Matreshka.Xml_Schema.Ast.Assertions'Elab_Spec;
      E502 := E502 + 1;
      Matreshka.Xml_Schema.Ast.Attribute_Declarations'Elab_Spec;
      E509 := E509 + 1;
      Matreshka.Xml_Schema.Ast.Attribute_Groups'Elab_Spec;
      E511 := E511 + 1;
      Matreshka.Xml_Schema.Ast.Attribute_Uses'Elab_Spec;
      E513 := E513 + 1;
      Matreshka.Xml_Schema.Ast.Complex_Types'Elab_Spec;
      E515 := E515 + 1;
      Matreshka.Xml_Schema.Ast.Constraining_Facets'Elab_Spec;
      E517 := E517 + 1;
      Matreshka.Xml_Schema.Ast.Element_Declarations'Elab_Spec;
      E519 := E519 + 1;
      Matreshka.Xml_Schema.Ast.Identity_Constraints'Elab_Spec;
      E521 := E521 + 1;
      Matreshka.Xml_Schema.Ast.Model_Groups'Elab_Spec;
      E523 := E523 + 1;
      Matreshka.Xml_Schema.Ast.Models'Elab_Spec;
      Matreshka.Xml_Schema.Ast.Namespaces'Elab_Spec;
      E529 := E529 + 1;
      E527 := E527 + 1;
      Matreshka.Xml_Schema.Ast.Notation_Declarations'Elab_Spec;
      E531 := E531 + 1;
      Matreshka.Xml_Schema.Ast.Particles'Elab_Spec;
      E533 := E533 + 1;
      Matreshka.Xml_Schema.Ast.Schemas'Elab_Spec;
      E507 := E507 + 1;
      Matreshka.Xml_Schema.Ast.Simple_Types'Elab_Spec;
      E535 := E535 + 1;
      E635 := E635 + 1;
      Matreshka.Xml_Schema.Ast.Type_Alternatives'Elab_Spec;
      E537 := E537 + 1;
      Matreshka.Xml_Schema.Ast.Wildcards'Elab_Spec;
      E539 := E539 + 1;
      E617 := E617 + 1;
      XML.SCHEMA.NAMESPACE_ITEM_LISTS'ELAB_SPEC;
      E611 := E611 + 1;
      XML.SCHEMA.OBJECTS'ELAB_SPEC;
      XML.SCHEMA.NAMED_MAPS'ELAB_SPEC;
      XML.SCHEMA.OBJECT_LISTS'ELAB_SPEC;
      XML.SCHEMA.OBJECTS.ANNOTATIONS'ELAB_SPEC;
      E556 := E556 + 1;
      XML.SCHEMA.OBJECTS.ATTRIBUTE_GROUP_DEFINITIONS'ELAB_SPEC;
      E592 := E592 + 1;
      E550 := E550 + 1;
      E596 := E596 + 1;
      XML.SCHEMA.OBJECTS.MODEL_GROUP_DEFINITIONS'ELAB_SPEC;
      E594 := E594 + 1;
      XML.SCHEMA.OBJECTS.NOTATION_DECLARATIONS'ELAB_SPEC;
      E598 := E598 + 1;
      XML.SCHEMA.OBJECTS.TERMS'ELAB_SPEC;
      E546 := E546 + 1;
      XML.SCHEMA.OBJECTS.PARTICLES'ELAB_SPEC;
      E581 := E581 + 1;
      XML.SCHEMA.OBJECTS.TERMS.MODEL_GROUPS'ELAB_SPEC;
      E548 := E548 + 1;
      XML.SCHEMA.OBJECTS.TYPE_DEFINITIONS'ELAB_SPEC;
      XML.SCHEMA.OBJECTS.TYPE_DEFINITIONS.COMPLEX_TYPE_DEFINITIONS'ELAB_SPEC;
      E579 := E579 + 1;
      E575 := E575 + 1;
      XML.SCHEMA.OBJECTS.TYPE_DEFINITIONS.SIMPLE_TYPE_DEFINITIONS'ELAB_SPEC;
      E588 := E588 + 1;
      XML.SCHEMA.OBJECTS.ATTRIBUTE_DECLARATIONS'ELAB_SPEC;
      E561 := E561 + 1;
      XML.SCHEMA.OBJECTS.TERMS.ELEMENT_DECLARATIONS'ELAB_SPEC;
      E601 := E601 + 1;
      XML.SCHEMA.MODELS'ELAB_SPEC;
      XML.SCHEMA.NAMESPACE_ITEMS'ELAB_SPEC;
      E558 := E558 + 1;
      E494 := E494 + 1;
      E544 := E544 + 1;
      Xsd_To_Ada.Writers'Elab_Spec;
      E660 := E660 + 1;
      League.Environment_Variables'Elab_Spec;
      E074 := E074 + 1;
      League.Text_Codecs'Elab_Spec;
      League.Text_Codecs'Elab_Body;
      E337 := E337 + 1;
      League.Application'Elab_Body;
      E056 := E056 + 1;
      Matreshka.Xml_Catalogs.Entry_Files'Elab_Spec;
      E363 := E363 + 1;
      Matreshka.Xml_Catalogs.Handlers'Elab_Spec;
      Matreshka.Xml_Catalogs.Normalization'Elab_Body;
      E374 := E374 + 1;
      Matreshka.Xml_Catalogs.Handlers'Elab_Body;
      E367 := E367 + 1;
      Matreshka.Xml_Catalogs.Resolver'Elab_Body;
      E491 := E491 + 1;
      Matreshka.Xml_Schema.Loaders'Elab_Spec;
      Matreshka.Xml_Schema.Handlers'Elab_Spec;
      Matreshka.Xml_Schema.Name_Resolvers'Elab_Spec;
      E633 := E633 + 1;
      Matreshka.Xml_Schema.Uri_Rewriter'Elab_Body;
      E346 := E346 + 1;
      XML.SAX.CONSTANTS'ELAB_SPEC;
      E436 := E436 + 1;
      XML.SAX.INPUT_SOURCES.STREAMS.FILES'ELAB_SPEC;
      XML.SAX.INPUT_SOURCES.STREAMS.FILES'ELAB_BODY;
      E392 := E392 + 1;
      XML.SAX.SIMPLE_READERS'ELAB_SPEC;
      Matreshka.Xml_Schema.Handlers'Elab_Body;
      E619 := E619 + 1;
      E615 := E615 + 1;
      E365 := E365 + 1;
      E456 := E456 + 1;
      XML.SAX.SIMPLE_READERS.RESOLVER'ELAB_BODY;
      E444 := E444 + 1;
      E438 := E438 + 1;
      E446 := E446 + 1;
      E433 := E433 + 1;
      XML.SAX.SIMPLE_READERS.SCANNER.TABLES'ELAB_SPEC;
      E463 := E463 + 1;
      E462 := E462 + 1;
      E458 := E458 + 1;
      E465 := E465 + 1;
      E452 := E452 + 1;
      E637 := E637 + 1;
      E613 := E613 + 1;
      Xsd_To_Ada.Mappings'Elab_Spec;
      E643 := E643 + 1;
      Xsd_To_Ada.Mappings_Xml'Elab_Spec;
      E642 := E642 + 1;
      Xsd_To_Ada.Utils'Elab_Spec;
      E645 := E645 + 1;
      E640 := E640 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_xsd_to_ada_generator");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-object_lists.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-visitors.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-annotations.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-objects.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-named_maps.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-types.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-assertions.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-attribute_declarations.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-attribute_groups.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-attribute_uses.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-complex_types.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-constraining_facets.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-element_declarations.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-identity_constraints.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-model_groups.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-namespaces.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-models.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-notation_declarations.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-particles.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-schemas.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-simple_types.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-namespace_builders.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-type_alternatives.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-ast-wildcards.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-containment_iterators.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-namespace_item_lists.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-named_maps-internals.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-object_lists-internals.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-annotations.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-annotations.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-attribute_group_definitions.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-attribute_group_definitions.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-internals.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-object_lists.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-named_maps.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-model_group_definitions.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-model_group_definitions.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-notation_declarations.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-notation_declarations.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-terms.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-particles-internals.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-terms-internals.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-particles.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-terms-model_groups.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-model_groups.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-terms-model_groups-internals.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-type_definitions-complex_type_definitions.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-complex_type_definitions.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-type_definitions-complex_type_definitions-internals.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-type_definitions-internals.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-type_definitions.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-type_definitions-simple_type_definitions-internals.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-type_definitions-simple_type_definitions.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-particles.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-simple_type_definitions.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-attribute_declarations.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-attribute_declarations.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-type_definitions.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-terms-element_declarations.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-element_declarations.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-namespace_items.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects-terms-element_declarations-internals.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-models.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-objects.o
   --   /home/kan/work/matreshka/design/xsd_to_ada_encoder/.objs/xsd_to_ada.o
   --   /home/kan/work/matreshka/design/xsd_to_ada_encoder/.objs/xsd_to_ada-writers.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-name_resolvers.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-uri_rewriter.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-handlers.o
   --   /home/kan/work/matreshka/design/schema/.objs/matreshka-xml_schema-loaders.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-models-internals.o
   --   /home/kan/work/matreshka/design/schema/.objs/xml-schema-utilities.o
   --   /home/kan/work/matreshka/design/xsd_to_ada_encoder/.objs/xsd_to_ada_generator.o
   --   /home/kan/work/matreshka/design/xsd_to_ada_encoder/.objs/xsd_to_ada-mappings.o
   --   /home/kan/work/matreshka/design/xsd_to_ada_encoder/.objs/xsd_to_ada-mappings_xml.o
   --   /home/kan/work/matreshka/design/xsd_to_ada_encoder/.objs/xsd_to_ada-utils.o
   --   /home/kan/work/matreshka/design/xsd_to_ada_encoder/.objs/xsd_to_ada-generator.o
   --   -L/home/kan/work/matreshka/design/xsd_to_ada_encoder/.objs/
   --   -L/home/kan/work/matreshka/design/xsd_to_ada_encoder/.objs/
   --   -L/home/kan/work/matreshka/design/schema/.objs/
   --   -L/home/kan/work/matreshka/.libs/matreshka/
   --   -L/home/kan/Gnat-2013/lib/gcc/x86_64-pc-linux-gnu/4.7.4/adalib/
   --   -shared
   --   -lgnat-2013
--  END Object file/option list   

end ada_main;
