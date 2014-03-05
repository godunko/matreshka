------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Open Document Toolkit                           --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2014, Vadim Godunko <vgodunko@gmail.com>                     --
-- All rights reserved.                                                     --
--                                                                          --
-- Redistribution and use in source and binary forms, with or without       --
-- modification, are permitted provided that the following conditions       --
-- are met:                                                                 --
--                                                                          --
--  * Redistributions of source code must retain the above copyright        --
--    notice, this list of conditions and the following disclaimer.         --
--                                                                          --
--  * Redistributions in binary form must reproduce the above copyright     --
--    notice, this list of conditions and the following disclaimer in the   --
--    documentation and/or other materials provided with the distribution.  --
--                                                                          --
--  * Neither the name of the Vadim Godunko, IE nor the names of its        --
--    contributors may be used to endorse or promote products derived from  --
--    this software without specific prior written permission.              --
--                                                                          --
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     --
-- HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   --
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED --
-- TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   --
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   --
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     --
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       --
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------
with League.Strings;

package Matreshka.ODF_String_Constants is

     --  urn:oasis:names:tc:opendocument:xmlns:manifest:1.0
     --  urn:oasis:names:tc:opendocument:xmlns:digitalsignature:1.0
     --  urn:oasis:names:tc:opendocument:xmlns:of:1.2
     --
     --  http://docs.oasis-open.org/ns/office/1.2/meta/pkg#
     --  http://docs.oasis-open.org/ns/office/1.2/meta/odf#
     --  http://www.w3.org/2000/09/xmldsig#
   Anim_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:animation:1.0");
   Chart_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:chart:1.0");
   Config_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:config:1.0");
   Db_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:database:1.0");
   Dc_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://purl.org/dc/elements/1.1/");
   Dr3d_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0");
   Draw_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:drawing:1.0");
   Fo_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0");
   Form_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:form:1.0");
   Grddl_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://www.w3.org/2003/g/data-view#");
   Math_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://www.w3.org/1998/Math/MathML");
   Meta_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:meta:1.0");
   Number_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0");
   Office_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:office:1.0");
   Presentation_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:presentation:1.0");
   Script_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:script:1.0");
   Smil_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:smil-compatible:1.0");
   Style_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:style:1.0");
   Svg_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0");
   Table_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:table:1.0");
   Text_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("urn:oasis:names:tc:opendocument:xmlns:text:1.0");
   Xforms_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://www.w3.org/2002/xforms");
   Xhtml_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://www.w3.org/1999/xhtml");
   Xlink_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://www.w3.org/1999/xlink");
   Anim_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("anim");
   Chart_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("chart");
   Config_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("config");
   Db_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("db");
   Dc_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dc");
   Dr3d_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dr3d");
   Draw_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("draw");
   Fo_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fo");
   Form_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("form");
   Grddl_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("grddl");
   Math_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("math");
   Meta_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("meta");
   Number_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number");
   Office_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("office");
   Presentation_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("presentation");
   Script_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("script");
   Smil_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("smil");
   Style_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("style");
   Svg_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("svg");
   Table_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table");
   Text_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text");
   Xforms_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xforms");
   Xhtml_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xhtml");
   Xlink_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xlink");
   A_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("a");
   Alphabetical_Index_Auto_Mark_File_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("alphabetical-index-auto-mark-file");
   Alphabetical_Index_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("alphabetical-index");
   Alphabetical_Index_Entry_Template_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("alphabetical-index-entry-template");
   Alphabetical_Index_Mark_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("alphabetical-index-mark");
   Alphabetical_Index_Mark_End_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("alphabetical-index-mark-end");
   Alphabetical_Index_Mark_Start_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("alphabetical-index-mark-start");
   Alphabetical_Index_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("alphabetical-index-source");
   Am_Pm_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("am-pm");
   AnimateColor_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animateColor");
   AnimateMotion_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animateMotion");
   AnimateTransform_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animateTransform");
   Animate_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animate");
   Animation_Group_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animation-group");
   Animations_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animations");
   Annotation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("annotation");
   Annotation_End_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("annotation-end");
   Applet_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("applet");
   Application_Connection_Settings_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("application-connection-settings");
   Area_Circle_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("area-circle");
   Area_Polygon_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("area-polygon");
   Area_Rectangle_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("area-rectangle");
   Audio_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("audio");
   Author_Initials_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("author-initials");
   Author_Name_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("author-name");
   Auto_Increment_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("auto-increment");
   Auto_Reload_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("auto-reload");
   Automatic_Styles_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("automatic-styles");
   Axis_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("axis");
   Background_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("background");
   Background_Image_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("background-image");
   Bibliography_Configuration_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bibliography-configuration");
   Bibliography_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bibliography");
   Bibliography_Entry_Template_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bibliography-entry-template");
   Bibliography_Mark_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bibliography-mark");
   Bibliography_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bibliography-source");
   Binary_Data_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("binary-data");
   Body_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("body");
   Bookmark_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bookmark");
   Bookmark_End_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bookmark-end");
   Bookmark_Ref_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bookmark-ref");
   Bookmark_Start_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bookmark-start");
   Boolean_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("boolean");
   Boolean_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("boolean-style");
   Button_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("button");
   Calculation_Settings_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("calculation-settings");
   Caption_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("caption");
   Categories_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("categories");
   Cell_Address_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cell-address");
   Cell_Content_Change_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cell-content-change");
   Cell_Content_Deletion_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cell-content-deletion");
   Cell_Range_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cell-range-source");
   Change_Deletion_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("change-deletion");
   Change_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("change");
   Change_End_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("change-end");
   Change_Info_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("change-info");
   Change_Start_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("change-start");
   Change_Track_Table_Cell_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("change-track-table-cell");
   Changed_Region_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("changed-region");
   Chapter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("chapter");
   Character_Count_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("character-count");
   Character_Set_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("character-set");
   Chart_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("chart");
   Chart_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("chart-properties");
   Checkbox_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("checkbox");
   Circle_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("circle");
   Column_Definition_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column-definition");
   Column_Definitions_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column-definitions");
   Column_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column");
   Column_Sep_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column-sep");
   Columns_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("columns");
   Combobox_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("combobox");
   Command_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("command");
   Component_Collection_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("component-collection");
   Component_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("component");
   Conditional_Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("conditional-text");
   Config_Item_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("config-item");
   Config_Item_Map_Entry_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("config-item-map-entry");
   Config_Item_Map_Indexed_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("config-item-map-indexed");
   Config_Item_Map_Named_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("config-item-map-named");
   Config_Item_Set_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("config-item-set");
   Connection_Data_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("connection-data");
   Connection_Resource_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("connection-resource");
   Connector_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("connector");
   Consolidation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("consolidation");
   Content_Validation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("content-validation");
   Content_Validations_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("content-validations");
   Contour_Path_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("contour-path");
   Contour_Polygon_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("contour-polygon");
   Control_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("control");
   Covered_Table_Cell_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("covered-table-cell");
   Creation_Date_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("creation-date");
   Creation_Time_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("creation-time");
   Creator_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("creator");
   Cube_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cube");
   Currency_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("currency-style");
   Currency_Symbol_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("currency-symbol");
   Custom_Shape_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("custom-shape");
   Cut_Offs_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cut-offs");
   Data_Label_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-label");
   Data_Pilot_Display_Info_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-pilot-display-info");
   Data_Pilot_Field_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-pilot-field");
   Data_Pilot_Field_Reference_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-pilot-field-reference");
   Data_Pilot_Group_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-pilot-group");
   Data_Pilot_Group_Member_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-pilot-group-member");
   Data_Pilot_Groups_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-pilot-groups");
   Data_Pilot_Layout_Info_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-pilot-layout-info");
   Data_Pilot_Level_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-pilot-level");
   Data_Pilot_Member_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-pilot-member");
   Data_Pilot_Members_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-pilot-members");
   Data_Pilot_Sort_Info_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-pilot-sort-info");
   Data_Pilot_Subtotal_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-pilot-subtotal");
   Data_Pilot_Subtotals_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-pilot-subtotals");
   Data_Pilot_Table_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-pilot-table");
   Data_Pilot_Tables_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-pilot-tables");
   Data_Point_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-point");
   Data_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-source");
   Data_Source_Setting_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-source-setting");
   Data_Source_Setting_Value_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-source-setting-value");
   Data_Source_Settings_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-source-settings");
   Database_Description_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database-description");
   Database_Display_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database-display");
   Database_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database");
   Database_Name_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database-name");
   Database_Next_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database-next");
   Database_Range_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database-range");
   Database_Ranges_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database-ranges");
   Database_Row_Number_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database-row-number");
   Database_Row_Select_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database-row-select");
   Database_Source_Query_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database-source-query");
   Database_Source_Sql_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database-source-sql");
   Database_Source_Table_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database-source-table");
   Date_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("date");
   Date_String_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("date-string");
   Date_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("date-style");
   Date_Time_Decl_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("date-time-decl");
   Date_Time_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("date-time");
   Day_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("day");
   Day_Of_Week_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("day-of-week");
   Dde_Connection_Decl_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dde-connection-decl");
   Dde_Connection_Decls_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dde-connection-decls");
   Dde_Connection_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dde-connection");
   Dde_Link_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dde-link");
   Dde_Links_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dde-links");
   Dde_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dde-source");
   Default_Page_Layout_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("default-page-layout");
   Default_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("default-style");
   Definition_Src_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("definition-src");
   Deletion_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("deletion");
   Deletions_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("deletions");
   Delimiter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("delimiter");
   Dependencies_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dependencies");
   Dependency_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dependency");
   Desc_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("desc");
   Description_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("description");
   Detective_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("detective");
   Dim_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dim");
   Document_Content_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("document-content");
   Document_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("document");
   Document_Meta_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("document-meta");
   Document_Settings_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("document-settings");
   Document_Statistic_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("document-statistic");
   Document_Styles_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("document-styles");
   Domain_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("domain");
   Drawing_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("drawing");
   Drawing_Page_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("drawing-page-properties");
   Driver_Settings_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("driver-settings");
   Drop_Cap_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("drop-cap");
   Editing_Cycles_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("editing-cycles");
   Editing_Duration_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("editing-duration");
   Ellipse_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ellipse");
   Embedded_Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("embedded-text");
   Enhanced_Geometry_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("enhanced-geometry");
   Equation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("equation");
   Era_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("era");
   Error_Indicator_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("error-indicator");
   Error_Macro_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("error-macro");
   Error_Message_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("error-message");
   Even_Columns_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("even-columns");
   Even_Rows_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("even-rows");
   Event_Listener_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("event-listener");
   Event_Listeners_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("event-listeners");
   Execute_Macro_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("execute-macro");
   Expression_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("expression");
   Extrude_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrude");
   File_Based_Database_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("file-based-database");
   File_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("file");
   File_Name_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("file-name");
   Fill_Image_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fill-image");
   Filter_And_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("filter-and");
   Filter_Condition_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("filter-condition");
   Filter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("filter");
   Filter_Or_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("filter-or");
   Filter_Set_Item_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("filter-set-item");
   Filter_Statement_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("filter-statement");
   First_Column_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("first-column");
   First_Row_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("first-row");
   Fixed_Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fixed-text");
   Floating_Frame_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("floating-frame");
   Floor_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("floor");
   Font_Face_Decls_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-face-decls");
   Font_Face_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-face");
   Font_Face_Format_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-face-format");
   Font_Face_Name_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-face-name");
   Font_Face_Src_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-face-src");
   Font_Face_Uri_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-face-uri");
   Footer_Decl_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footer-decl");
   Footer_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footer");
   Footer_Left_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footer-left");
   Footer_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footer-style");
   Footnote_Sep_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footnote-sep");
   Form_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("form");
   Format_Change_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("format-change");
   Formatted_Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("formatted-text");
   Forms_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("forms");
   Fraction_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fraction");
   Frame_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("frame");
   G_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("g");
   Generator_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("generator");
   Generic_Control_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("generic-control");
   Glue_Point_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("glue-point");
   Gradient_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("gradient");
   Graphic_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("graphic-properties");
   Grid_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("grid");
   H_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("h");
   Handle_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("handle");
   Handout_Master_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("handout-master");
   Hatch_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hatch");
   Header_Decl_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("header-decl");
   Header_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("header");
   Header_Footer_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("header-footer-properties");
   Header_Left_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("header-left");
   Header_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("header-style");
   Help_Message_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("help-message");
   Hidden_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hidden");
   Hidden_Paragraph_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hidden-paragraph");
   Hidden_Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hidden-text");
   Hide_Shape_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hide-shape");
   Hide_Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hide-text");
   Highlighted_Range_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("highlighted-range");
   Hours_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hours");
   Hyperlink_Behaviour_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hyperlink-behaviour");
   Illustration_Index_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("illustration-index");
   Illustration_Index_Entry_Template_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("illustration-index-entry-template");
   Illustration_Index_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("illustration-index-source");
   Image_Count_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("image-count");
   Image_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("image");
   Image_Frame_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("image-frame");
   Image_Map_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("image-map");
   Index_Body_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-body");
   Index_Column_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-column");
   Index_Columns_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-columns");
   Index_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index");
   Index_Entry_Bibliography_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-entry-bibliography");
   Index_Entry_Chapter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-entry-chapter");
   Index_Entry_Link_End_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-entry-link-end");
   Index_Entry_Link_Start_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-entry-link-start");
   Index_Entry_Page_Number_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-entry-page-number");
   Index_Entry_Span_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-entry-span");
   Index_Entry_Tab_Stop_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-entry-tab-stop");
   Index_Entry_Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-entry-text");
   Index_Source_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-source-style");
   Index_Source_Styles_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-source-styles");
   Index_Title_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-title");
   Index_Title_Template_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-title-template");
   Indices_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("indices");
   Initial_Creator_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("initial-creator");
   Insertion_Cut_Off_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("insertion-cut-off");
   Insertion_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("insertion");
   Item_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("item");
   Iterate_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("iterate");
   Iteration_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("iteration");
   Key_Column_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("key-column");
   Key_Columns_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("key-columns");
   Key_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("key");
   Keys_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("keys");
   Keyword_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("keyword");
   Keywords_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("keywords");
   Label_Range_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("label-range");
   Label_Ranges_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("label-ranges");
   Label_Separator_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("label-separator");
   Language_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("language");
   Last_Column_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("last-column");
   Last_Row_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("last-row");
   Layer_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layer");
   Layer_Set_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layer-set");
   Legend_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("legend");
   Light_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("light");
   Line_Break_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("line-break");
   Line_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("line");
   LinearGradient_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("linearGradient");
   Linenumbering_Configuration_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("linenumbering-configuration");
   Linenumbering_Separator_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("linenumbering-separator");
   List_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list");
   List_Header_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-header");
   List_Item_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-item");
   List_Level_Label_Alignment_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level-label-alignment");
   List_Level_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level-properties");
   List_Level_Style_Bullet_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level-style-bullet");
   List_Level_Style_Image_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level-style-image");
   List_Level_Style_Number_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level-style-number");
   List_Property_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-property");
   List_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-style");
   List_Value_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-value");
   Listbox_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("listbox");
   Login_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("login");
   Map_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("map");
   Marker_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("marker");
   Master_Page_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("master-page");
   Master_Styles_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("master-styles");
   Math_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("math");
   Mean_Value_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("mean-value");
   Measure_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("measure");
   Meta_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("meta");
   Meta_Field_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("meta-field");
   Minutes_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("minutes");
   Model_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("model");
   Modification_Date_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("modification-date");
   Modification_Time_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("modification-time");
   Month_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("month");
   Movement_Cut_Off_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("movement-cut-off");
   Movement_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("movement");
   Named_Expression_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("named-expression");
   Named_Expressions_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("named-expressions");
   Named_Range_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("named-range");
   Note_Body_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("note-body");
   Note_Citation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("note-citation");
   Note_Continuation_Notice_Backward_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("note-continuation-notice-backward");
   Note_Continuation_Notice_Forward_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("note-continuation-notice-forward");
   Note_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("note");
   Note_Ref_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("note-ref");
   Notes_Configuration_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("notes-configuration");
   Notes_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("notes");
   Null_Date_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("null-date");
   Number_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number");
   Number_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number-style");
   Numbered_Paragraph_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("numbered-paragraph");
   Object_Count_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("object-count");
   Object_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("object");
   Object_Index_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("object-index");
   Object_Index_Entry_Template_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("object-index-entry-template");
   Object_Index_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("object-index-source");
   Object_Ole_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("object-ole");
   Odd_Columns_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("odd-columns");
   Odd_Rows_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("odd-rows");
   Opacity_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("opacity");
   Operation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("operation");
   Option_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("option");
   Order_Statement_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("order-statement");
   Outline_Level_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("outline-level-style");
   Outline_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("outline-style");
   P_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("p");
   Page_Continuation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-continuation");
   Page_Count_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-count");
   Page_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page");
   Page_Layout_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-layout");
   Page_Layout_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-layout-properties");
   Page_Number_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-number");
   Page_Sequence_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-sequence");
   Page_Thumbnail_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-thumbnail");
   Page_Variable_Get_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-variable-get");
   Page_Variable_Set_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-variable-set");
   Par_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("par");
   Paragraph_Count_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("paragraph-count");
   Paragraph_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("paragraph-properties");
   Param_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("param");
   Password_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("password");
   Path_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("path");
   Percentage_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("percentage-style");
   Placeholder_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("placeholder");
   Play_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("play");
   Plot_Area_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("plot-area");
   Plugin_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("plugin");
   Polygon_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("polygon");
   Polyline_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("polyline");
   Presentation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("presentation");
   Presentation_Page_Layout_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("presentation-page-layout");
   Previous_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("previous");
   Print_Date_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("print-date");
   Print_Time_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("print-time");
   Printed_By_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("printed-by");
   Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("properties");
   Property_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("property");
   Quarter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("quarter");
   Queries_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("queries");
   Query_Collection_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("query-collection");
   Query_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("query");
   RadialGradient_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("radialGradient");
   Radio_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("radio");
   Rect_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rect");
   Reference_Mark_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("reference-mark");
   Reference_Mark_End_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("reference-mark-end");
   Reference_Mark_Start_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("reference-mark-start");
   Reference_Ref_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("reference-ref");
   Region_Center_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("region-center");
   Region_Left_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("region-left");
   Region_Right_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("region-right");
   Regression_Curve_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("regression-curve");
   Regular_Polygon_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("regular-polygon");
   Reports_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("reports");
   Rotate_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rotate");
   Ruby_Base_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ruby-base");
   Ruby_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ruby");
   Ruby_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ruby-properties");
   Ruby_Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ruby-text");
   S_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("s");
   Scenario_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scenario");
   Scene_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scene");
   Schema_Definition_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("schema-definition");
   Scientific_Number_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scientific-number");
   Script_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("script");
   Scripts_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scripts");
   Seconds_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("seconds");
   Section_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("section");
   Section_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("section-properties");
   Section_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("section-source");
   Sender_City_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sender-city");
   Sender_Company_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sender-company");
   Sender_Country_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sender-country");
   Sender_Email_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sender-email");
   Sender_Fax_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sender-fax");
   Sender_Firstname_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sender-firstname");
   Sender_Initials_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sender-initials");
   Sender_Lastname_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sender-lastname");
   Sender_Phone_Private_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sender-phone-private");
   Sender_Phone_Work_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sender-phone-work");
   Sender_Position_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sender-position");
   Sender_Postal_Code_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sender-postal-code");
   Sender_State_Or_Province_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sender-state-or-province");
   Sender_Street_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sender-street");
   Sender_Title_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sender-title");
   Seq_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("seq");
   Sequence_Decl_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sequence-decl");
   Sequence_Decls_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sequence-decls");
   Sequence_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sequence");
   Sequence_Ref_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sequence-ref");
   Series_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("series");
   Server_Database_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("server-database");
   Set_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("set");
   Settings_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("settings");
   Shapes_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("shapes");
   Sheet_Name_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sheet-name");
   Show_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("show");
   Show_Shape_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("show-shape");
   Show_Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("show-text");
   Soft_Page_Break_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("soft-page-break");
   Sort_By_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sort-by");
   Sort_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sort");
   Sort_Groups_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sort-groups");
   Sort_Key_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sort-key");
   Sound_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sound");
   Source_Cell_Range_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("source-cell-range");
   Source_Range_Address_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("source-range-address");
   Source_Service_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("source-service");
   Span_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("span");
   Sphere_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sphere");
   Spreadsheet_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("spreadsheet");
   Stock_Gain_Marker_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stock-gain-marker");
   Stock_Loss_Marker_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stock-loss-marker");
   Stock_Range_Line_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stock-range-line");
   Stop_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stop");
   Stroke_Dash_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stroke-dash");
   Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("style");
   Styles_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("styles");
   Subject_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("subject");
   Subtitle_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("subtitle");
   Subtotal_Field_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("subtotal-field");
   Subtotal_Rule_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("subtotal-rule");
   Subtotal_Rules_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("subtotal-rules");
   Symbol_Image_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("symbol-image");
   Tab_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tab");
   Tab_Stop_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tab-stop");
   Tab_Stops_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tab-stops");
   Table_Cell_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-cell");
   Table_Cell_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-cell-properties");
   Table_Column_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-column");
   Table_Column_Group_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-column-group");
   Table_Column_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-column-properties");
   Table_Columns_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-columns");
   Table_Count_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-count");
   Table_Definition_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-definition");
   Table_Definitions_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-definitions");
   Table_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table");
   Table_Exclude_Filter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-exclude-filter");
   Table_Filter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-filter");
   Table_Filter_Pattern_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-filter-pattern");
   Table_Formula_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-formula");
   Table_Header_Columns_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-header-columns");
   Table_Header_Rows_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-header-rows");
   Table_Include_Filter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-include-filter");
   Table_Index_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-index");
   Table_Index_Entry_Template_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-index-entry-template");
   Table_Index_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-index-source");
   Table_Of_Content_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-of-content");
   Table_Of_Content_Entry_Template_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-of-content-entry-template");
   Table_Of_Content_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-of-content-source");
   Table_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-properties");
   Table_Representation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-representation");
   Table_Representations_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-representations");
   Table_Row_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-row");
   Table_Row_Group_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-row-group");
   Table_Row_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-row-properties");
   Table_Rows_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-rows");
   Table_Setting_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-setting");
   Table_Settings_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-settings");
   Table_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-source");
   Table_Template_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-template");
   Table_Type_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-type");
   Table_Type_Filter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-type-filter");
   Target_Range_Address_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("target-range-address");
   Template_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("template");
   Template_Name_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("template-name");
   Text_Box_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-box");
   Text_Content_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-content");
   Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text");
   Text_Input_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-input");
   Text_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-properties");
   Text_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-style");
   Textarea_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("textarea");
   Time_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("time");
   Time_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("time-style");
   Title_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("title");
   Toc_Mark_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("toc-mark");
   Toc_Mark_End_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("toc-mark-end");
   Toc_Mark_Start_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("toc-mark-start");
   Tracked_Changes_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tracked-changes");
   TransitionFilter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("transitionFilter");
   Update_Table_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("update-table");
   User_Defined_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("user-defined");
   User_Field_Decl_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("user-field-decl");
   User_Field_Decls_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("user-field-decls");
   User_Field_Get_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("user-field-get");
   User_Field_Input_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("user-field-input");
   User_Index_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("user-index");
   User_Index_Entry_Template_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("user-index-entry-template");
   User_Index_Mark_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("user-index-mark");
   User_Index_Mark_End_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("user-index-mark-end");
   User_Index_Mark_Start_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("user-index-mark-start");
   User_Index_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("user-index-source");
   Value_Range_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("value-range");
   Variable_Decl_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("variable-decl");
   Variable_Decls_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("variable-decls");
   Variable_Get_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("variable-get");
   Variable_Input_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("variable-input");
   Variable_Set_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("variable-set");
   Wall_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("wall");
   Week_Of_Year_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("week-of-year");
   Word_Count_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("word-count");
   Year_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("year");

end Matreshka.ODF_String_Constants;
