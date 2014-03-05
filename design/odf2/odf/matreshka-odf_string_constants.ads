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
   About_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("about");
   Accelerate_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("accelerate");
   Accent_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("accent-height");
   Acceptance_State_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("acceptance-state");
   Accumulate_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("accumulate");
   Action_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("action");
   Active_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("active");
   Actuate_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("actuate");
   Add_Empty_Lines_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("add-empty-lines");
   Additional_Column_Statement_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("additional-column-statement");
   Additive_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("additive");
   Address_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("address");
   Adjustment_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("adjustment");
   Algorithm_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("algorithm");
   Align_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("align");
   Allow_Deletes_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("allow-deletes");
   Allow_Empty_Cell_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("allow-empty-cell");
   Allow_Inserts_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("allow-inserts");
   Allow_Updates_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("allow-updates");
   Alphabetic_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("alphabetic");
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
   Alphabetical_Separators_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("alphabetical-separators");
   Am_Pm_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("am-pm");
   Ambient_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ambient-color");
   Anchor_Page_Number_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("anchor-page-number");
   Anchor_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("anchor-type");
   Angle_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("angle");
   Angle_Offset_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("angle-offset");
   AnimateColor_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animateColor");
   AnimateMotion_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animateMotion");
   AnimateTransform_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animateTransform");
   Animate_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animate");
   Animation_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animation");
   Animation_Delay_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animation-delay");
   Animation_Direction_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animation-direction");
   Animation_Group_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animation-group");
   Animation_Repeat_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animation-repeat");
   Animation_Start_Inside_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animation-start-inside");
   Animation_Steps_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animation-steps");
   Animation_Stop_Inside_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animation-stop-inside");
   Animations_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animations");
   Animations_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("animations");
   Annotation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("annotation");
   Annotation_End_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("annotation-end");
   Annote_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("annote");
   Append_Table_Alias_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("append-table-alias-name");
   Applet_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("applet");
   Application_Connection_Settings_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("application-connection-settings");
   Application_Data_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("application-data");
   Apply_Command_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("apply-command");
   Apply_Design_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("apply-design-mode");
   Apply_Filter_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("apply-filter");
   Apply_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("apply-style-name");
   Archive_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("archive");
   Area_Circle_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("area-circle");
   Area_Polygon_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("area-polygon");
   Area_Rectangle_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("area-rectangle");
   As_Template_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("as-template");
   Ascent_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ascent");
   Attached_Axis_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("attached-axis");
   AttributeName_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("attributeName");
   Audio_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("audio");
   Audio_Level_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("audio-level");
   Author_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("author");
   Author_Initials_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("author-initials");
   Author_Name_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("author-name");
   AutoReverse_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("autoReverse");
   Auto_Complete_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("auto-complete");
   Auto_Grow_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("auto-grow-height");
   Auto_Grow_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("auto-grow-width");
   Auto_Increment_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("auto-increment");
   Auto_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("auto-position");
   Auto_Reload_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("auto-reload");
   Auto_Size_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("auto-size");
   Auto_Text_Indent_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("auto-text-indent");
   Auto_Update_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("auto-update");
   Automatic_Content_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("automatic-content");
   Automatic_Find_Labels_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("automatic-find-labels");
   Automatic_Focus_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("automatic-focus");
   Automatic_Order_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("automatic-order");
   Automatic_Styles_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("automatic-styles");
   Automatic_Update_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("automatic-update");
   Axis_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("axis");
   Axis_Label_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("axis-label-position");
   Axis_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("axis-position");
   Back_Scale_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("back-scale");
   Backface_Culling_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("backface-culling");
   Background_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("background-color");
   Background_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("background");
   Background_Image_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("background-image");
   Background_Objects_Visible_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("background-objects-visible");
   Background_Size_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("background-size");
   Background_Transparency_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("background-transparency");
   Background_Visible_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("background-visible");
   Base_Cell_Address_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("base-cell-address");
   Base_Dn_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("base-dn");
   Bbox_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bbox");
   Begin_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("begin");
   Bibliography_Configuration_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bibliography-configuration");
   Bibliography_Data_Field_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bibliography-data-field");
   Bibliography_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bibliography");
   Bibliography_Entry_Template_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bibliography-entry-template");
   Bibliography_Mark_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bibliography-mark");
   Bibliography_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bibliography-source");
   Bibliography_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bibliography-type");
   Binary_Data_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("binary-data");
   Bind_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bind");
   Bind_Styles_To_Content_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bind-styles-to-content");
   Blue_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("blue");
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
   Booktitle_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("booktitle");
   Boolean_Comparison_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("boolean-comparison-mode");
   Boolean_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("boolean");
   Boolean_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("boolean-style");
   Boolean_Value_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("boolean-value");
   Border_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border");
   Border_Bottom_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-bottom");
   Border_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-color");
   Border_Left_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-left");
   Border_Line_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-line-width");
   Border_Line_Width_Bottom_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-line-width-bottom");
   Border_Line_Width_Left_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-line-width-left");
   Border_Line_Width_Right_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-line-width-right");
   Border_Line_Width_Top_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-line-width-top");
   Border_Model_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-model");
   Border_Right_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-right");
   Border_Top_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("border-top");
   Bound_Column_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bound-column");
   Break_After_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("break-after");
   Break_Before_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("break-before");
   Bullet_Char_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bullet-char");
   Bullet_Relative_Size_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bullet-relative-size");
   Button_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("button");
   Button_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("button-type");
   Buttons_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("buttons");
   By_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("by");
   C_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("c");
   CalcMode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("calcMode");
   Calculation_Settings_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("calculation-settings");
   Calendar_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("calendar");
   Cap_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cap-height");
   Capitalize_Entries_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("capitalize-entries");
   Caption_Angle_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("caption-angle");
   Caption_Angle_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("caption-angle-type");
   Caption_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("caption");
   Caption_Escape_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("caption-escape");
   Caption_Escape_Direction_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("caption-escape-direction");
   Caption_Fit_Line_Length_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("caption-fit-line-length");
   Caption_Gap_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("caption-gap");
   Caption_Id_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("caption-id");
   Caption_Line_Length_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("caption-line-length");
   Caption_Point_X_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("caption-point-x");
   Caption_Point_Y_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("caption-point-y");
   Caption_Sequence_Format_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("caption-sequence-format");
   Caption_Sequence_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("caption-sequence-name");
   Caption_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("caption-type");
   Case_Sensitive_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("case-sensitive");
   Catalog_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("catalog-name");
   Categories_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("categories");
   Cell_Address_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cell-address");
   Cell_Address_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cell-address");
   Cell_Content_Change_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cell-content-change");
   Cell_Content_Deletion_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cell-content-deletion");
   Cell_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cell-count");
   Cell_Protect_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cell-protect");
   Cell_Range_Address_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cell-range-address");
   Cell_Range_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cell-range");
   Cell_Range_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cell-range-source");
   Center_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("center");
   Chain_Next_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("chain-next-name");
   Change_Deletion_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("change-deletion");
   Change_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("change");
   Change_End_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("change-end");
   Change_Id_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("change-id");
   Change_Info_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("change-info");
   Change_Start_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("change-start");
   Change_Track_Table_Cell_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("change-track-table-cell");
   Changed_Region_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("changed-region");
   Chapter_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("chapter");
   Chapter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("chapter");
   Char_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("char");
   Character_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("character-count");
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
   Citation_Body_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("citation-body-style-name");
   Citation_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("citation-style-name");
   Class_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("class");
   Class_Id_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("class-id");
   Class_Names_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("class-names");
   Clip_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("clip");
   Close_Back_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("close-back");
   Close_Front_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("close-front");
   Code_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("code");
   Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("color");
   Color_Interpolation_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("color-interpolation");
   Color_Interpolation_Direction_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("color-interpolation-direction");
   Color_Inversion_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("color-inversion");
   Color_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("color-mode");
   Column_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column");
   Column_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column-count");
   Column_Definition_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column-definition");
   Column_Definitions_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column-definitions");
   Column_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column");
   Column_Gap_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column-gap");
   Column_Mapping_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column-mapping");
   Column_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column-name");
   Column_Sep_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column-sep");
   Column_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("column-width");
   Columns_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("columns");
   Combine_Entries_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("combine-entries");
   Combine_Entries_With_Dash_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("combine-entries-with-dash");
   Combine_Entries_With_Pp_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("combine-entries-with-pp");
   Combobox_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("combobox");
   Comma_Separated_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("comma-separated");
   Command_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("command");
   Command_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("command");
   Command_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("command-type");
   Comment_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("comment");
   Component_Collection_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("component-collection");
   Component_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("component");
   Concave_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("concave");
   Concentric_Gradient_Fill_Allowed_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("concentric-gradient-fill-allowed");
   Cond_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cond-style-name");
   Condition_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("condition");
   Condition_Source_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("condition-source");
   Condition_Source_Range_Address_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("condition-source-range-address");
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
   Connect_Bars_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("connect-bars");
   Connection_Data_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("connection-data");
   Connection_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("connection-name");
   Connection_Resource_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("connection-resource");
   Connector_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("connector");
   Consecutive_Numbering_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("consecutive-numbering");
   Consolidation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("consolidation");
   Contains_Error_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("contains-error");
   Content_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("content");
   Content_Validation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("content-validation");
   Content_Validation_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("content-validation-name");
   Content_Validations_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("content-validations");
   Continue_List_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("continue-list");
   Continue_Numbering_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("continue-numbering");
   Contour_Path_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("contour-path");
   Contour_Polygon_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("contour-polygon");
   Contrast_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("contrast");
   Control_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("control");
   Control_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("control");
   Control_Implementation_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("control-implementation");
   Conversion_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("conversion-mode");
   Convert_Empty_To_Null_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("convert-empty-to-null");
   Copy_Back_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("copy-back");
   Copy_Formulas_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("copy-formulas");
   Copy_Of_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("copy-of");
   Copy_Outline_Levels_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("copy-outline-levels");
   Copy_Styles_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("copy-styles");
   Corner_Radius_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("corner-radius");
   Corners_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("corners");
   Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("count");
   Count_Empty_Lines_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("count-empty-lines");
   Count_In_Text_Boxes_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("count-in-text-boxes");
   Country_Asian_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("country-asian");
   Country_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("country");
   Country_Complex_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("country-complex");
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
   Currency_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("currency");
   Currency_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("currency-style");
   Currency_Symbol_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("currency-symbol");
   Current_Selected_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("current-selected");
   Current_State_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("current-state");
   Current_Value_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("current-value");
   Custom1_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("custom1");
   Custom2_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("custom2");
   Custom3_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("custom3");
   Custom4_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("custom4");
   Custom5_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("custom5");
   Custom_Shape_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("custom-shape");
   Cut_Offs_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cut-offs");
   Cx_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cx");
   Cy_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cy");
   D_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("d");
   Data_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data");
   Data_Cell_Range_Address_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-cell-range-address");
   Data_Field_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-field");
   Data_Label_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-label");
   Data_Label_Number_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-label-number");
   Data_Label_Symbol_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-label-symbol");
   Data_Label_Text_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-label-text");
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
   Data_Source_Has_Labels_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-source-has-labels");
   Data_Source_Setting_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-source-setting");
   Data_Source_Setting_Is_List_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-source-setting-is-list");
   Data_Source_Setting_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-source-setting-name");
   Data_Source_Setting_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-source-setting-type");
   Data_Source_Setting_Value_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-source-setting-value");
   Data_Source_Settings_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-source-settings");
   Data_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-style-name");
   Data_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("data-type");
   Database_Description_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database-description");
   Database_Display_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database-display");
   Database_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database");
   Database_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database-name");
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
   Database_Table_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("database-table-name");
   Datasource_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("datasource");
   Datatype_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("datatype");
   Date_Adjust_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("date-adjust");
   Date_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("date");
   Date_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("date");
   Date_End_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("date-end");
   Date_Start_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("date-start");
   Date_String_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("date-string");
   Date_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("date-style");
   Date_Time_Decl_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("date-time-decl");
   Date_Time_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("date-time");
   Date_Value_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("date-value");
   Day_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("day");
   Day_Of_Week_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("day-of-week");
   Dde_Application_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dde-application");
   Dde_Connection_Decl_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dde-connection-decl");
   Dde_Connection_Decls_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dde-connection-decls");
   Dde_Connection_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dde-connection");
   Dde_Item_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dde-item");
   Dde_Link_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dde-link");
   Dde_Links_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dde-links");
   Dde_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dde-source");
   Dde_Topic_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dde-topic");
   Decelerate_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("decelerate");
   Decimal_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("decimal");
   Decimal_Places_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("decimal-places");
   Decimal_Replacement_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("decimal-replacement");
   Deep_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("deep");
   Default_Button_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("default-button");
   Default_Cell_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("default-cell-style-name");
   Default_Outline_Level_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("default-outline-level");
   Default_Page_Layout_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("default-page-layout");
   Default_Row_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("default-row-style-name");
   Default_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("default-style");
   Default_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("default-style-name");
   Definition_Src_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("definition-src");
   Delay_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("delay");
   Delay_For_Repeat_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("delay-for-repeat");
   Delete_Rule_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("delete-rule");
   Deletion_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("deletion");
   Deletions_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("deletions");
   Delimiter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("delimiter");
   Denominator_Value_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("denominator-value");
   Dependencies_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dependencies");
   Dependency_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dependency");
   Depth_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("depth");
   Desc_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("desc");
   Descent_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("descent");
   Description_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("description");
   Description_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("description");
   Detail_Fields_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("detail-fields");
   Detective_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("detective");
   Diagonal_Bl_Tr_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("diagonal-bl-tr");
   Diagonal_Bl_Tr_Widths_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("diagonal-bl-tr-widths");
   Diagonal_Tl_Br_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("diagonal-tl-br");
   Diagonal_Tl_Br_Widths_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("diagonal-tl-br-widths");
   Diffuse_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("diffuse-color");
   Dim_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dim");
   Dimension_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dimension");
   Direction_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("direction");
   Disabled_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("disabled");
   Display_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display");
   Display_Border_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-border");
   Display_Date_Time_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-date-time");
   Display_Duplicates_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-duplicates");
   Display_Equation_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-equation");
   Display_Factor_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-factor");
   Display_Filter_Buttons_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-filter-buttons");
   Display_Footer_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-footer");
   Display_Header_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-header");
   Display_Label_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-label");
   Display_Levels_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-levels");
   Display_List_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-list");
   Display_Member_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-member-mode");
   Display_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-name");
   Display_Outline_Level_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-outline-level");
   Display_Page_Number_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-page-number");
   Display_R_Square_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("display-r-square");
   Distance_After_Sep_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("distance-after-sep");
   Distance_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("distance");
   Distance_Before_Sep_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("distance-before-sep");
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
   Dont_Balance_Text_Columns_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dont-balance-text-columns");
   Dots1_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dots1");
   Dots1_Length_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dots1-length");
   Dots2_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dots2");
   Dots2_Length_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dots2-length");
   Draw_Aspect_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("draw-aspect");
   Draw_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("draw-count");
   Drawing_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("drawing");
   Drawing_Page_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("drawing-page-properties");
   Drill_Down_On_Double_Click_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("drill-down-on-double-click");
   Driver_Settings_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("driver-settings");
   Drop_Cap_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("drop-cap");
   Dropdown_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dropdown");
   Dur_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dur");
   Duration_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("duration");
   Dynamic_Spacing_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("dynamic-spacing");
   Echo_Char_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("echo-char");
   Edge_Rounding_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("edge-rounding");
   Edge_Rounding_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("edge-rounding-mode");
   Editable_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("editable");
   Editing_Cycles_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("editing-cycles");
   Editing_Duration_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("editing-duration");
   Edition_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("edition");
   Editor_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("editor");
   Effect_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("effect");
   Ellipse_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ellipse");
   Embedded_Number_Behavior_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("embedded-number-behavior");
   Embedded_Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("embedded-text");
   Emissive_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("emissive-color");
   Enable_Sql92_Check_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("enable-sql92-check");
   Enabled_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("enabled");
   Encoding_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("encoding");
   Enctype_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("enctype");
   End_Angle_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-angle");
   End_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end");
   End_Cell_Address_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-cell-address");
   End_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-color");
   End_Column_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-column");
   End_Glue_Point_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-glue-point");
   End_Guide_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-guide");
   End_Indent_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-indent");
   End_Intensity_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-intensity");
   End_Line_Spacing_Horizontal_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-line-spacing-horizontal");
   End_Line_Spacing_Vertical_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-line-spacing-vertical");
   End_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-position");
   End_Row_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-row");
   End_Shape_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-shape");
   End_Table_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-table");
   End_X_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-x");
   End_Y_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("end-y");
   Endless_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("endless");
   Endsync_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("endsync");
   Engine_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("engine");
   Enhanced_Geometry_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("enhanced-geometry");
   Enhanced_Path_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("enhanced-path");
   Equation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("equation");
   Era_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("era");
   Error_Category_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("error-category");
   Error_Indicator_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("error-indicator");
   Error_Lower_Indicator_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("error-lower-indicator");
   Error_Lower_Limit_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("error-lower-limit");
   Error_Lower_Range_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("error-lower-range");
   Error_Macro_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("error-macro");
   Error_Margin_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("error-margin");
   Error_Message_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("error-message");
   Error_Percentage_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("error-percentage");
   Error_Upper_Indicator_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("error-upper-indicator");
   Error_Upper_Limit_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("error-upper-limit");
   Error_Upper_Range_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("error-upper-range");
   Escape_Direction_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("escape-direction");
   Escape_Processing_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("escape-processing");
   Even_Columns_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("even-columns");
   Even_Rows_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("even-rows");
   Event_Listener_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("event-listener");
   Event_Listeners_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("event-listeners");
   Event_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("event-name");
   Execute_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("execute");
   Execute_Macro_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("execute-macro");
   Expression_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("expression");
   Expression_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("expression");
   Extension_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extension");
   Extrude_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrude");
   Extrusion_Allowed_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-allowed");
   Extrusion_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion");
   Extrusion_Brightness_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-brightness");
   Extrusion_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-color");
   Extrusion_Depth_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-depth");
   Extrusion_Diffusion_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-diffusion");
   Extrusion_First_Light_Direction_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-first-light-direction");
   Extrusion_First_Light_Harsh_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-first-light-harsh");
   Extrusion_First_Light_Level_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-first-light-level");
   Extrusion_Light_Face_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-light-face");
   Extrusion_Metal_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-metal");
   Extrusion_Number_Of_Line_Segments_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-number-of-line-segments");
   Extrusion_Origin_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-origin");
   Extrusion_Rotation_Angle_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-rotation-angle");
   Extrusion_Rotation_Center_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-rotation-center");
   Extrusion_Second_Light_Direction_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-second-light-direction");
   Extrusion_Second_Light_Harsh_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-second-light-harsh");
   Extrusion_Second_Light_Level_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-second-light-level");
   Extrusion_Shininess_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-shininess");
   Extrusion_Skew_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-skew");
   Extrusion_Specularity_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-specularity");
   Extrusion_Viewpoint_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extrusion-viewpoint");
   FadeColor_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fadeColor");
   Family_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("family");
   Field_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("field");
   Field_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("field-name");
   Field_Number_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("field-number");
   File_Based_Database_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("file-based-database");
   File_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("file");
   File_Name_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("file-name");
   FillDefault_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fillDefault");
   Fill_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fill");
   Fill_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fill-color");
   Fill_Gradient_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fill-gradient-name");
   Fill_Hatch_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fill-hatch-name");
   Fill_Hatch_Solid_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fill-hatch-solid");
   Fill_Image_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fill-image");
   Fill_Image_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fill-image-height");
   Fill_Image_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fill-image-name");
   Fill_Image_Ref_Point_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fill-image-ref-point");
   Fill_Image_Ref_Point_X_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fill-image-ref-point-x");
   Fill_Image_Ref_Point_Y_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fill-image-ref-point-y");
   Fill_Image_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fill-image-width");
   Fill_Rule_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fill-rule");
   Filter_And_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("filter-and");
   Filter_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("filter");
   Filter_Condition_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("filter-condition");
   Filter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("filter");
   Filter_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("filter-name");
   Filter_Options_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("filter-options");
   Filter_Or_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("filter-or");
   Filter_Set_Item_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("filter-set-item");
   Filter_Statement_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("filter-statement");
   First_Column_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("first-column");
   First_Page_Number_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("first-page-number");
   First_Row_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("first-row");
   First_Row_End_Column_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("first-row-end-column");
   First_Row_Start_Column_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("first-row-start-column");
   Fit_To_Contour_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fit-to-contour");
   Fit_To_Size_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fit-to-size");
   Fixed_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fixed");
   Fixed_Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fixed-text");
   Floating_Frame_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("floating-frame");
   Floor_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("floor");
   Flow_With_Text_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("flow-with-text");
   Focal_Length_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("focal-length");
   Focus_On_Click_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("focus-on-click");
   Font_Adornments_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-adornments");
   Font_Charset_Asian_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-charset-asian");
   Font_Charset_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-charset");
   Font_Charset_Complex_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-charset-complex");
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
   Font_Family_Asian_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-family-asian");
   Font_Family_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-family");
   Font_Family_Complex_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-family-complex");
   Font_Family_Generic_Asian_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-family-generic-asian");
   Font_Family_Generic_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-family-generic");
   Font_Family_Generic_Complex_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-family-generic-complex");
   Font_Independent_Line_Spacing_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-independent-line-spacing");
   Font_Name_Asian_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-name-asian");
   Font_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-name");
   Font_Name_Complex_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-name-complex");
   Font_Pitch_Asian_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-pitch-asian");
   Font_Pitch_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-pitch");
   Font_Pitch_Complex_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-pitch-complex");
   Font_Relief_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-relief");
   Font_Size_Asian_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-size-asian");
   Font_Size_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-size");
   Font_Size_Complex_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-size-complex");
   Font_Size_Rel_Asian_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-size-rel-asian");
   Font_Size_Rel_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-size-rel");
   Font_Size_Rel_Complex_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-size-rel-complex");
   Font_Stretch_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-stretch");
   Font_Style_Asian_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-style-asian");
   Font_Style_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-style");
   Font_Style_Complex_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-style-complex");
   Font_Style_Name_Asian_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-style-name-asian");
   Font_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-style-name");
   Font_Style_Name_Complex_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-style-name-complex");
   Font_Variant_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-variant");
   Font_Weight_Asian_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-weight-asian");
   Font_Weight_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-weight");
   Font_Weight_Complex_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-weight-complex");
   Footer_Decl_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footer-decl");
   Footer_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footer");
   Footer_Left_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footer-left");
   Footer_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footer-style");
   Footnote_Max_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footnote-max-height");
   Footnote_Sep_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footnote-sep");
   Footnotes_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("footnotes-position");
   For_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("for");
   Force_Manual_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("force-manual");
   Form_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("form");
   Format_Change_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("format-change");
   Format_Source_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("format-source");
   Formatted_Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("formatted-text");
   Forms_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("forms");
   Formula_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("formula");
   Fraction_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fraction");
   Frame_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("frame-count");
   Frame_Display_Border_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("frame-display-border");
   Frame_Display_Scrollbar_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("frame-display-scrollbar");
   Frame_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("frame");
   Frame_Margin_Horizontal_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("frame-margin-horizontal");
   Frame_Margin_Vertical_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("frame-margin-vertical");
   Frame_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("frame-name");
   From_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("from");
   Full_Screen_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("full-screen");
   Fx_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fx");
   Fy_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fy");
   G_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("g");
   Gamma_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("gamma");
   Gap_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("gap-width");
   Generator_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("generator");
   Generic_Control_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("generic-control");
   Global_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("global");
   Glue_Point_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("glue-point");
   Glue_Point_Leaving_Directions_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("glue-point-leaving-directions");
   Glue_Point_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("glue-point-type");
   Glue_Points_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("glue-points");
   Glyph_Orientation_Vertical_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("glyph-orientation-vertical");
   GradientTransform_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("gradientTransform");
   GradientUnits_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("gradientUnits");
   Gradient_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("gradient");
   Gradient_Step_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("gradient-step-count");
   Grand_Total_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("grand-total");
   Graphic_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("graphic-properties");
   Green_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("green");
   Grid_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("grid");
   Group_Bars_Per_Axis_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("group-bars-per-axis");
   Group_By_Field_Number_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("group-by-field-number");
   Group_Id_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("group-id");
   Grouped_By_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("grouped-by");
   Grouping_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("grouping");
   Guide_Distance_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("guide-distance");
   Guide_Overhang_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("guide-overhang");
   H_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("h");
   Handle_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("handle");
   Handle_Mirror_Horizontal_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("handle-mirror-horizontal");
   Handle_Mirror_Vertical_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("handle-mirror-vertical");
   Handle_Polar_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("handle-polar");
   Handle_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("handle-position");
   Handle_Radius_Range_Maximum_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("handle-radius-range-maximum");
   Handle_Radius_Range_Minimum_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("handle-radius-range-minimum");
   Handle_Range_X_Maximum_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("handle-range-x-maximum");
   Handle_Range_X_Minimum_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("handle-range-x-minimum");
   Handle_Range_Y_Maximum_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("handle-range-y-maximum");
   Handle_Range_Y_Minimum_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("handle-range-y-minimum");
   Handle_Switched_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("handle-switched");
   Handout_Master_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("handout-master");
   Hanging_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hanging");
   Has_Persistent_Data_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("has-persistent-data");
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
   Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("height");
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
   Hole_Size_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hole-size");
   Horizontal_Pos_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("horizontal-pos");
   Horizontal_Rel_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("horizontal-rel");
   Horizontal_Segments_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("horizontal-segments");
   Hostname_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hostname");
   Hours_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hours");
   Howpublished_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("howpublished");
   Href_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("href");
   Hyperlink_Behaviour_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hyperlink-behaviour");
   Hyphenate_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hyphenate");
   Hyphenation_Keep_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hyphenation-keep");
   Hyphenation_Ladder_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hyphenation-ladder-count");
   Hyphenation_Push_Char_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hyphenation-push-char-count");
   Hyphenation_Remain_Char_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hyphenation-remain-char-count");
   Id_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("id");
   Identifier_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("identifier");
   Identify_Categories_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("identify-categories");
   Ideographic_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ideographic");
   Ignore_Case_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ignore-case");
   Ignore_Driver_Privileges_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ignore-driver-privileges");
   Ignore_Empty_Rows_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ignore-empty-rows");
   Ignore_Result_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ignore-result");
   Illustration_Index_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("illustration-index");
   Illustration_Index_Entry_Template_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("illustration-index-entry-template");
   Illustration_Index_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("illustration-index-source");
   Image_Align_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("image-align");
   Image_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("image-count");
   Image_Count_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("image-count");
   Image_Data_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("image-data");
   Image_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("image");
   Image_Frame_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("image-frame");
   Image_Map_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("image-map");
   Image_Opacity_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("image-opacity");
   Image_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("image-position");
   Include_Hidden_Cells_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("include-hidden-cells");
   Increment_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("increment");
   Index_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index");
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
   Index_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-name");
   Index_Scope_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("index-scope");
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
   Institution_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("institution");
   Interpolation_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("interpolation");
   Interval_Major_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("interval-major");
   Interval_Minor_Divisor_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("interval-minor-divisor");
   Is_Active_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-active");
   Is_Ascending_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-ascending");
   Is_Autoincrement_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-autoincrement");
   Is_Clustered_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-clustered");
   Is_Data_Layout_Field_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-data-layout-field");
   Is_Empty_Allowed_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-empty-allowed");
   Is_First_Row_Header_Line_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-first-row-header-line");
   Is_Hidden_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-hidden");
   Is_List_Header_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-list-header");
   Is_Nullable_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-nullable");
   Is_Password_Required_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-password-required");
   Is_Selection_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-selection");
   Is_Sub_Table_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-sub-table");
   Is_Table_Name_Length_Limited_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-table-name-length-limited");
   Is_Tristate_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-tristate");
   Is_Unique_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("is-unique");
   Isbn_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("isbn");
   Issn_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("issn");
   Item_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("item");
   Iterate_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("iterate");
   Iterate_Interval_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("iterate-interval");
   Iterate_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("iterate-type");
   Iteration_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("iteration");
   Japanese_Candle_Stick_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("japanese-candle-stick");
   Join_Border_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("join-border");
   Journal_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("journal");
   Justify_Single_Word_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("justify-single-word");
   Keep_Together_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("keep-together");
   Keep_With_Next_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("keep-with-next");
   Key1_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("key1");
   Key1_Phonetic_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("key1-phonetic");
   Key2_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("key2");
   Key2_Phonetic_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("key2-phonetic");
   KeySplines_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("keySplines");
   KeyTimes_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("keyTimes");
   Key_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("key");
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
   Kind_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("kind");
   Label_Arrangement_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("label-arrangement");
   Label_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("label");
   Label_Cell_Address_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("label-cell-address");
   Label_Cell_Range_Address_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("label-cell-range-address");
   Label_Followed_By_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("label-followed-by");
   Label_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("label-position");
   Label_Position_Negative_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("label-position-negative");
   Label_Range_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("label-range");
   Label_Ranges_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("label-ranges");
   Label_Separator_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("label-separator");
   Language_Asian_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("language-asian");
   Language_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("language");
   Language_Complex_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("language-complex");
   Language_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("language");
   Last_Column_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("last-column");
   Last_Column_Spanned_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("last-column-spanned");
   Last_Row_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("last-row");
   Last_Row_End_Column_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("last-row-end-column");
   Last_Row_Spanned_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("last-row-spanned");
   Last_Row_Start_Column_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("last-row-start-column");
   Layer_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layer");
   Layer_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layer");
   Layer_Set_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layer-set");
   Layout_Grid_Base_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layout-grid-base-height");
   Layout_Grid_Base_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layout-grid-base-width");
   Layout_Grid_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layout-grid-color");
   Layout_Grid_Display_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layout-grid-display");
   Layout_Grid_Lines_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layout-grid-lines");
   Layout_Grid_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layout-grid-mode");
   Layout_Grid_Print_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layout-grid-print");
   Layout_Grid_Ruby_Below_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layout-grid-ruby-below");
   Layout_Grid_Ruby_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layout-grid-ruby-height");
   Layout_Grid_Snap_To_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layout-grid-snap-to");
   Layout_Grid_Standard_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layout-grid-standard-mode");
   Layout_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("layout-mode");
   Leader_Char_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("leader-char");
   Leader_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("leader-color");
   Leader_Style_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("leader-style");
   Leader_Text_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("leader-text");
   Leader_Text_Style_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("leader-text-style");
   Leader_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("leader-type");
   Leader_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("leader-width");
   Legend_Align_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("legend-align");
   Legend_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("legend");
   Legend_Expansion_Aspect_Ratio_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("legend-expansion-aspect-ratio");
   Legend_Expansion_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("legend-expansion");
   Legend_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("legend-position");
   Length_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("length");
   Letter_Kerning_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("letter-kerning");
   Letter_Spacing_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("letter-spacing");
   Level_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("level");
   Light_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("light");
   Lighting_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("lighting-mode");
   Line_Break_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("line-break");
   Line_Break_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("line-break");
   Line_Distance_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("line-distance");
   Line_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("line");
   Line_Height_At_Least_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("line-height-at-least");
   Line_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("line-height");
   Line_Number_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("line-number");
   Line_Skew_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("line-skew");
   Line_Spacing_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("line-spacing");
   Line_Style_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("line-style");
   LinearGradient_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("linearGradient");
   Linenumbering_Configuration_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("linenumbering-configuration");
   Linenumbering_Separator_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("linenumbering-separator");
   Lines_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("lines");
   Link_Data_Style_To_Source_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("link-data-style-to-source");
   Link_To_Source_Data_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("link-to-source-data");
   Linked_Cell_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("linked-cell");
   List_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list");
   List_Header_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-header");
   List_Id_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-id");
   List_Item_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-item");
   List_Level_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level");
   List_Level_Label_Alignment_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level-label-alignment");
   List_Level_Position_And_Space_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level-position-and-space-mode");
   List_Level_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level-properties");
   List_Level_Style_Bullet_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level-style-bullet");
   List_Level_Style_Image_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level-style-image");
   List_Level_Style_Number_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-level-style-number");
   List_Linkage_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-linkage-type");
   List_Property_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-property");
   List_Source_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-source");
   List_Source_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-source-type");
   List_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-style");
   List_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-style-name");
   List_Tab_Stop_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-tab-stop-position");
   List_Value_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list-value");
   Listbox_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("listbox");
   Local_Socket_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("local-socket");
   Logarithmic_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("logarithmic");
   Login_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("login");
   Login_Timeout_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("login-timeout");
   Luminance_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("luminance");
   Macro_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("macro-name");
   Main_Entry_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("main-entry");
   Main_Entry_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("main-entry-style-name");
   Map_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("map");
   Margin_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("margin");
   Margin_Bottom_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("margin-bottom");
   Margin_Left_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("margin-left");
   Margin_Right_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("margin-right");
   Margin_Top_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("margin-top");
   Marked_Invalid_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("marked-invalid");
   Marker_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("marker");
   Marker_End_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("marker-end");
   Marker_End_Center_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("marker-end-center");
   Marker_End_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("marker-end-width");
   Marker_Start_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("marker-start");
   Marker_Start_Center_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("marker-start-center");
   Marker_Start_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("marker-start-width");
   Master_Element_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("master-element");
   Master_Fields_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("master-fields");
   Master_Page_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("master-page");
   Master_Page_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("master-page-name");
   Master_Styles_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("master-styles");
   Math_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("math");
   Mathematical_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("mathematical");
   Matrix_Covered_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("matrix-covered");
   Max_Edge_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("max-edge");
   Max_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("max-height");
   Max_Length_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("max-length");
   Max_Row_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("max-row-count");
   Max_Value_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("max-value");
   Max_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("max-width");
   Maximum_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("maximum");
   Maximum_Difference_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("maximum-difference");
   May_Break_Between_Rows_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("may-break-between-rows");
   May_Script_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("may-script");
   Mean_Value_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("mean-value");
   Mean_Value_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("mean-value");
   Measure_Align_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("measure-align");
   Measure_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("measure");
   Measure_Vertical_Align_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("measure-vertical-align");
   Media_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("media-type");
   Member_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("member-count");
   Member_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("member-name");
   Member_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("member-type");
   Message_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("message-type");
   Meta_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("meta");
   Meta_Field_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("meta-field");
   Method_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("method");
   Mime_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("mime-type");
   Mimetype_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("mimetype");
   Min_Denominator_Digits_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("min-denominator-digits");
   Min_Edge_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("min-edge");
   Min_Exponent_Digits_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("min-exponent-digits");
   Min_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("min-height");
   Min_Integer_Digits_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("min-integer-digits");
   Min_Label_Distance_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("min-label-distance");
   Min_Label_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("min-label-width");
   Min_Numerator_Digits_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("min-numerator-digits");
   Min_Row_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("min-row-height");
   Min_Value_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("min-value");
   Min_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("min-width");
   Minimum_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("minimum");
   Minutes_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("minutes");
   Mirror_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("mirror");
   Mirror_Horizontal_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("mirror-horizontal");
   Mirror_Vertical_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("mirror-vertical");
   Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("mode");
   Model_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("model");
   Modification_Date_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("modification-date");
   Modification_Time_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("modification-time");
   Modifiers_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("modifiers");
   Month_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("month");
   Month_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("month");
   Mouse_As_Pen_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("mouse-as-pen");
   Mouse_Visible_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("mouse-visible");
   Movement_Cut_Off_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("movement-cut-off");
   Movement_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("movement");
   Multi_Deletion_Spanned_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("multi-deletion-spanned");
   Multi_Line_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("multi-line");
   Multiple_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("multiple");
   Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("name");
   Named_Expression_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("named-expression");
   Named_Expressions_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("named-expressions");
   Named_Range_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("named-range");
   Nav_Order_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("nav-order");
   Navigation_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("navigation-mode");
   Next_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("next-style-name");
   Node_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("node-type");
   Nohref_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("nohref");
   Non_Whitespace_Character_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("non-whitespace-character-count");
   Normals_Direction_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("normals-direction");
   Normals_Kind_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("normals-kind");
   Note_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("note");
   Note_Body_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("note-body");
   Note_Citation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("note-citation");
   Note_Class_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("note-class");
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
   Notify_On_Update_Of_Ranges_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("notify-on-update-of-ranges");
   Null_Date_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("null-date");
   Null_Year_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("null-year");
   Num_Format_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("num-format");
   Num_Letter_Sync_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("num-letter-sync");
   Num_Prefix_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("num-prefix");
   Num_Suffix_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("num-suffix");
   Number_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number");
   Number_Columns_Repeated_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number-columns-repeated");
   Number_Columns_Spanned_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number-columns-spanned");
   Number_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number");
   Number_Lines_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number-lines");
   Number_Matrix_Columns_Spanned_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number-matrix-columns-spanned");
   Number_Matrix_Rows_Spanned_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number-matrix-rows-spanned");
   Number_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number-position");
   Number_Rows_Repeated_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number-rows-repeated");
   Number_Rows_Spanned_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number-rows-spanned");
   Number_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number-style");
   Number_Wrapped_Paragraphs_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("number-wrapped-paragraphs");
   Numbered_Entries_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("numbered-entries");
   Numbered_Paragraph_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("numbered-paragraph");
   Object_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("object");
   Object_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("object-count");
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
   Object_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("object-name");
   Object_Ole_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("object-ole");
   Odd_Columns_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("odd-columns");
   Odd_Rows_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("odd-rows");
   Offset_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("offset");
   Ole_Draw_Aspect_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ole-draw-aspect");
   Ole_Object_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ole-object-count");
   On_Update_Keep_Size_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("on-update-keep-size");
   On_Update_Keep_Styles_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("on-update-keep-styles");
   Opacity_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("opacity");
   Opacity_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("opacity");
   Opacity_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("opacity-name");
   Operation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("operation");
   Operator_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("operator");
   Option_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("option");
   Order_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("order");
   Order_Statement_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("order-statement");
   Organizations_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("organizations");
   Orientation_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("orientation");
   Origin_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("origin");
   Orphans_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("orphans");
   Outline_Level_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("outline-level");
   Outline_Level_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("outline-level-style");
   Outline_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("outline-style");
   Overflow_Behavior_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("overflow-behavior");
   Overlap_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("overlap");
   Overline_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("overline-position");
   Overline_Thickness_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("overline-thickness");
   P_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("p");
   Padding_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("padding");
   Padding_Bottom_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("padding-bottom");
   Padding_Left_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("padding-left");
   Padding_Right_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("padding-right");
   Padding_Top_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("padding-top");
   Page_Adjust_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-adjust");
   Page_Breaks_On_Group_Change_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-breaks-on-group-change");
   Page_Continuation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-continuation");
   Page_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-count");
   Page_Count_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-count");
   Page_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page");
   Page_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-height");
   Page_Layout_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-layout");
   Page_Layout_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-layout-name");
   Page_Layout_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-layout-properties");
   Page_Number_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-number");
   Page_Number_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-number");
   Page_Sequence_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-sequence");
   Page_Step_Size_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-step-size");
   Page_Thumbnail_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-thumbnail");
   Page_Usage_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-usage");
   Page_Variable_Get_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-variable-get");
   Page_Variable_Set_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-variable-set");
   Page_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("page-width");
   Pages_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("pages");
   Panose_1_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("panose-1");
   Paper_Tray_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("paper-tray-name");
   Par_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("par");
   Paragraph_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("paragraph-count");
   Paragraph_Count_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("paragraph-count");
   Paragraph_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("paragraph-properties");
   Paragraph_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("paragraph-style-name");
   Parallel_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("parallel");
   Param_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("param");
   Parameter_Name_Substitution_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("parameter-name-substitution");
   Parent_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("parent-style-name");
   Parse_Sql_Statement_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("parse-sql-statement");
   Password_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("password");
   Password_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("password");
   Path_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("path");
   Path_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("path");
   Path_Id_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("path-id");
   Path_Stretchpoint_X_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("path-stretchpoint-x");
   Path_Stretchpoint_Y_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("path-stretchpoint-y");
   Pause_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("pause");
   Percentage_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("percentage");
   Percentage_Data_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("percentage-data-style-name");
   Percentage_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("percentage-style");
   Pie_Offset_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("pie-offset");
   Placeholder_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("placeholder");
   Placeholder_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("placeholder");
   Placeholder_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("placeholder-type");
   Placing_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("placing");
   Play_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("play");
   Play_Full_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("play-full");
   Plot_Area_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("plot-area");
   Plugin_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("plugin");
   Points_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("points");
   Polygon_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("polygon");
   Polyline_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("polyline");
   Port_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("port");
   Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("position");
   Possessive_Form_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("possessive-form");
   Precision_As_Shown_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("precision-as-shown");
   Precision_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("precision");
   Prefix_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("prefix");
   Presentation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("presentation");
   Presentation_Page_Layout_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("presentation-page-layout");
   Presentation_Page_Layout_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("presentation-page-layout-name");
   Preset_Class_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("preset-class");
   Preset_Id_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("preset-id");
   Preset_Sub_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("preset-sub-type");
   Previous_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("previous");
   Print_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("print");
   Print_Content_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("print-content");
   Print_Date_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("print-date");
   Print_Orientation_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("print-orientation");
   Print_Page_Order_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("print-page-order");
   Print_Ranges_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("print-ranges");
   Print_Time_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("print-time");
   Printable_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("printable");
   Printed_By_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("printed-by");
   Process_Content_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("process-content");
   Projection_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("projection");
   Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("properties");
   Property_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("property");
   Property_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("property");
   Property_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("property-name");
   Protect_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("protect");
   Protected_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("protected");
   Protection_Key_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("protection-key");
   Protection_Key_Digest_Algorithm_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("protection-key-digest-algorithm");
   Publisher_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("publisher");
   Punctuation_Wrap_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("punctuation-wrap");
   Quarter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("quarter");
   Queries_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("queries");
   Query_Collection_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("query-collection");
   Query_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("query");
   Query_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("query-name");
   R_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("r");
   RadialGradient_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("radialGradient");
   Radio_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("radio");
   Range_Usable_As_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("range-usable-as");
   Readonly_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("readonly");
   Recreate_On_Edit_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("recreate-on-edit");
   Rect_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rect");
   Red_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("red");
   Ref_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ref-name");
   Reference_Format_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("reference-format");
   Reference_Mark_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("reference-mark");
   Reference_Mark_End_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("reference-mark-end");
   Reference_Mark_Start_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("reference-mark-start");
   Reference_Ref_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("reference-ref");
   Referenced_Table_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("referenced-table-name");
   Refresh_Delay_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("refresh-delay");
   Region_Center_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("region-center");
   Region_Left_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("region-left");
   Region_Right_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("region-right");
   Register_True_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("register-true");
   Register_Truth_Ref_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("register-truth-ref-style-name");
   Regression_Curve_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("regression-curve");
   Regression_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("regression-type");
   Regular_Polygon_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("regular-polygon");
   Rejecting_Change_Id_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rejecting-change-id");
   Rel_Column_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rel-column-width");
   Rel_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rel-height");
   Rel_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rel-width");
   Related_Column_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("related-column-name");
   Relative_Tab_Stop_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("relative-tab-stop-position");
   RepeatCount_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("repeatCount");
   RepeatDur_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("repeatDur");
   Repeat_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("repeat");
   Repeat_Content_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("repeat-content");
   Repeated_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("repeated");
   Report_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("report-type");
   Reports_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("reports");
   RestartDefault_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("restartDefault");
   Restart_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("restart");
   Restart_Numbering_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("restart-numbering");
   Restart_On_Page_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("restart-on-page");
   Reverse_Direction_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("reverse-direction");
   Rfc_Language_Tag_Asian_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rfc-language-tag-asian");
   Rfc_Language_Tag_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rfc-language-tag");
   Rfc_Language_Tag_Complex_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rfc-language-tag-complex");
   Right_Angled_Axes_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("right-angled-axes");
   Rotate_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rotate");
   Rotation_Align_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rotation-align");
   Rotation_Angle_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rotation-angle");
   Rotation_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rotation");
   Row_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("row");
   Row_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("row-count");
   Row_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("row-height");
   Row_Mapping_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("row-mapping");
   Row_Number_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("row-number");
   Row_Retrieving_Statement_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("row-retrieving-statement");
   Ruby_Align_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ruby-align");
   Ruby_Base_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ruby-base");
   Ruby_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ruby");
   Ruby_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ruby-position");
   Ruby_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ruby-properties");
   Ruby_Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ruby-text");
   Run_Through_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("run-through");
   Rx_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("rx");
   Ry_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ry");
   S_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("s");
   Scale_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scale");
   Scale_Text_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scale-text");
   Scale_To_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scale-to");
   Scale_To_Pages_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scale-to-pages");
   Scenario_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scenario");
   Scenario_Ranges_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scenario-ranges");
   Scene_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scene");
   Schema_Definition_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("schema-definition");
   Schema_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("schema-name");
   School_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("school");
   Scientific_Number_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scientific-number");
   Script_Asian_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("script-asian");
   Script_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("script");
   Script_Complex_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("script-complex");
   Script_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("script");
   Script_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("script-type");
   Scripts_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scripts");
   Search_Criteria_Must_Apply_To_Whole_Cell_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("search-criteria-must-apply-to-whole-cell");
   Secondary_Fill_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("secondary-fill-color");
   Seconds_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("seconds");
   Section_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("section");
   Section_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("section-name");
   Section_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("section-properties");
   Section_Source_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("section-source");
   Select_Page_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("select-page");
   Selected_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("selected");
   Selected_Page_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("selected-page");
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
   Sentence_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sentence-count");
   Separation_Character_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("separation-character");
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
   Series_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("series");
   Series_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("series");
   Series_Source_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("series-source");
   Server_Database_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("server-database");
   Server_Map_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("server-map");
   Set_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("set");
   Settings_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("settings");
   Shade_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("shade-mode");
   Shadow_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("shadow");
   Shadow_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("shadow-color");
   Shadow_Offset_X_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("shadow-offset-x");
   Shadow_Offset_Y_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("shadow-offset-y");
   Shadow_Opacity_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("shadow-opacity");
   Shadow_Slant_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("shadow-slant");
   Shape_Id_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("shape-id");
   Shapes_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("shapes");
   Sharpness_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sharpness");
   Sheet_Name_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sheet-name");
   Shininess_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("shininess");
   Show_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("show");
   Show_Deleted_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("show-deleted");
   Show_Details_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("show-details");
   Show_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("show");
   Show_Empty_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("show-empty");
   Show_End_Of_Presentation_Slide_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("show-end-of-presentation-slide");
   Show_Filter_Button_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("show-filter-button");
   Show_Logo_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("show-logo");
   Show_Shape_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("show-shape");
   Show_Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("show-text");
   Show_Unit_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("show-unit");
   Shrink_To_Fit_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("shrink-to-fit");
   Size_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("size");
   Slope_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("slope");
   Snap_To_Layout_Grid_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("snap-to-layout-grid");
   Soft_Page_Break_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("soft-page-break");
   Solid_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("solid-type");
   Sort_Algorithm_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sort-algorithm");
   Sort_Ascending_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sort-ascending");
   Sort_By_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sort-by");
   Sort_By_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sort-by-position");
   Sort_By_X_Values_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sort-by-x-values");
   Sort_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sort");
   Sort_Groups_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sort-groups");
   Sort_Key_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sort-key");
   Sort_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sort-mode");
   Sound_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sound");
   Source_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("source");
   Source_Cell_Range_Addresses_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("source-cell-range-addresses");
   Source_Cell_Range_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("source-cell-range");
   Source_Cell_Range_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("source-cell-range");
   Source_Field_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("source-field-name");
   Source_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("source-name");
   Source_Range_Address_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("source-range-address");
   Source_Service_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("source-service");
   Space_After_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("space-after");
   Space_Before_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("space-before");
   Span_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("span");
   Specular_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("specular");
   Specular_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("specular-color");
   Speed_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("speed");
   Sphere_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sphere");
   Spin_Button_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("spin-button");
   Spline_Order_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("spline-order");
   Spline_Resolution_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("spline-resolution");
   SpreadMethod_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("spreadMethod");
   Spreadsheet_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("spreadsheet");
   Sql_Statement_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sql-statement");
   Stacked_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stacked");
   Start_Angle_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-angle");
   Start_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start");
   Start_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-color");
   Start_Column_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-column");
   Start_Glue_Point_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-glue-point");
   Start_Guide_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-guide");
   Start_Indent_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-indent");
   Start_Intensity_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-intensity");
   Start_Line_Spacing_Horizontal_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-line-spacing-horizontal");
   Start_Line_Spacing_Vertical_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-line-spacing-vertical");
   Start_Numbering_At_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-numbering-at");
   Start_Page_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-page");
   Start_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-position");
   Start_Row_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-row");
   Start_Scale_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-scale");
   Start_Shape_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-shape");
   Start_Table_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-table");
   Start_Value_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-value");
   Start_With_Navigator_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("start-with-navigator");
   State_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("state");
   Status_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("status");
   Stay_On_Top_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stay-on-top");
   Stemh_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stemh");
   Stemv_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stemv");
   Step_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("step");
   Step_Size_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("step-size");
   Steps_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("steps");
   Stock_Gain_Marker_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stock-gain-marker");
   Stock_Loss_Marker_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stock-loss-marker");
   Stock_Range_Line_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stock-range-line");
   Stop_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stop-color");
   Stop_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stop");
   Stop_Opacity_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stop-opacity");
   Strikethrough_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("strikethrough-position");
   Strikethrough_Thickness_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("strikethrough-thickness");
   String_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("string");
   String_Value_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("string-value");
   String_Value_If_False_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("string-value-if-false");
   String_Value_If_True_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("string-value-if-true");
   String_Value_Phonetic_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("string-value-phonetic");
   Stroke_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stroke");
   Stroke_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stroke-color");
   Stroke_Dash_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stroke-dash");
   Stroke_Dash_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stroke-dash");
   Stroke_Dash_Names_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stroke-dash-names");
   Stroke_Linecap_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stroke-linecap");
   Stroke_Linejoin_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stroke-linejoin");
   Stroke_Opacity_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stroke-opacity");
   Stroke_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stroke-width");
   Structure_Protected_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("structure-protected");
   Style_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("style");
   Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("style");
   Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("style-name");
   Style_Override_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("style-override");
   Styles_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("styles");
   Sub_Item_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("sub-item");
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
   Subtype_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("subtype");
   Suffix_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("suffix");
   Suppress_Version_Columns_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("suppress-version-columns");
   Syllable_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("syllable-count");
   Symbol_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("symbol-color");
   Symbol_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("symbol-height");
   Symbol_Image_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("symbol-image");
   Symbol_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("symbol-name");
   Symbol_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("symbol-type");
   Symbol_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("symbol-width");
   System_Driver_Settings_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("system-driver-settings");
   Tab_Cycle_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tab-cycle");
   Tab_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tab");
   Tab_Index_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tab-index");
   Tab_Ref_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tab-ref");
   Tab_Stop_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tab-stop");
   Tab_Stop_Distance_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tab-stop-distance");
   Tab_Stop_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tab-stop");
   Tab_Stops_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tab-stops");
   Table_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table");
   Table_Background_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-background");
   Table_Cell_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-cell");
   Table_Cell_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-cell-properties");
   Table_Centering_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-centering");
   Table_Column_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-column");
   Table_Column_Group_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-column-group");
   Table_Column_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-column-properties");
   Table_Columns_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-columns");
   Table_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-count");
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
   Table_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-name");
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
   Table_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-type");
   Table_Type_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-type");
   Table_Type_Filter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("table-type-filter");
   TargetElement_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("targetElement");
   Target_Cell_Address_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("target-cell-address");
   Target_Frame_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("target-frame");
   Target_Frame_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("target-frame-name");
   Target_Range_Address_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("target-range-address");
   Target_Range_Address_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("target-range-address");
   Template_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("template");
   Template_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("template-name");
   Template_Name_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("template-name");
   Text_Align_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-align");
   Text_Align_Last_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-align-last");
   Text_Align_Source_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-align-source");
   Text_Areas_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-areas");
   Text_Autospace_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-autospace");
   Text_Blinking_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-blinking");
   Text_Box_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-box");
   Text_Combine_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-combine");
   Text_Combine_End_Char_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-combine-end-char");
   Text_Combine_Start_Char_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-combine-start-char");
   Text_Content_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-content");
   Text_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text");
   Text_Emphasize_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-emphasize");
   Text_Indent_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-indent");
   Text_Input_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-input");
   Text_Line_Through_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-line-through-color");
   Text_Line_Through_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-line-through-mode");
   Text_Line_Through_Style_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-line-through-style");
   Text_Line_Through_Text_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-line-through-text");
   Text_Line_Through_Text_Style_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-line-through-text-style");
   Text_Line_Through_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-line-through-type");
   Text_Line_Through_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-line-through-width");
   Text_Outline_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-outline");
   Text_Overlap_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-overlap");
   Text_Overline_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-overline-color");
   Text_Overline_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-overline-mode");
   Text_Overline_Style_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-overline-style");
   Text_Overline_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-overline-type");
   Text_Overline_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-overline-width");
   Text_Path_Allowed_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-path-allowed");
   Text_Path_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-path");
   Text_Path_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-path-mode");
   Text_Path_Same_Letter_Heights_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-path-same-letter-heights");
   Text_Path_Scale_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-path-scale");
   Text_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-position");
   Text_Properties_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-properties");
   Text_Rotate_Angle_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-rotate-angle");
   Text_Rotation_Angle_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-rotation-angle");
   Text_Rotation_Scale_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-rotation-scale");
   Text_Scale_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-scale");
   Text_Shadow_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-shadow");
   Text_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-style");
   Text_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-style-name");
   Text_Transform_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-transform");
   Text_Underline_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-underline-color");
   Text_Underline_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-underline-mode");
   Text_Underline_Style_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-underline-style");
   Text_Underline_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-underline-type");
   Text_Underline_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text-underline-width");
   Textarea_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("textarea");
   Textarea_Horizontal_Align_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("textarea-horizontal-align");
   Textarea_Vertical_Align_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("textarea-vertical-align");
   Textual_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("textual");
   Texture_Filter_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("texture-filter");
   Texture_Generation_Mode_X_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("texture-generation-mode-x");
   Texture_Generation_Mode_Y_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("texture-generation-mode-y");
   Texture_Kind_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("texture-kind");
   Texture_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("texture-mode");
   Thousand_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("thousand");
   Three_Dimensional_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("three-dimensional");
   Tick_Mark_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tick-mark-position");
   Tick_Marks_Major_Inner_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tick-marks-major-inner");
   Tick_Marks_Major_Outer_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tick-marks-major-outer");
   Tick_Marks_Minor_Inner_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tick-marks-minor-inner");
   Tick_Marks_Minor_Outer_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tick-marks-minor-outer");
   Tile_Repeat_Offset_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tile-repeat-offset");
   Time_Adjust_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("time-adjust");
   Time_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("time");
   Time_Style_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("time-style");
   Time_Value_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("time-value");
   Title_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("title");
   Title_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("title");
   To_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("to");
   Toc_Mark_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("toc-mark");
   Toc_Mark_End_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("toc-mark-end");
   Toc_Mark_Start_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("toc-mark-start");
   Toggle_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("toggle");
   Track_Changes_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("track-changes");
   Tracked_Changes_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("tracked-changes");
   Transform_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("transform");
   Transformation_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("transformation");
   TransitionFilter_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("transitionFilter");
   Transition_On_Click_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("transition-on-click");
   Transition_Speed_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("transition-speed");
   Transition_Style_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("transition-style");
   Transition_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("transition-type");
   Transliteration_Country_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("transliteration-country");
   Transliteration_Format_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("transliteration-format");
   Transliteration_Language_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("transliteration-language");
   Transliteration_Style_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("transliteration-style");
   Treat_Empty_Cells_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("treat-empty-cells");
   Truncate_On_Overflow_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("truncate-on-overflow");
   Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("type");
   Type_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("type-name");
   Underline_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("underline-position");
   Underline_Thickness_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("underline-thickness");
   Unicode_Range_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("unicode-range");
   Unit_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("unit");
   Units_Per_Em_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("units-per-em");
   Update_Rule_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("update-rule");
   Update_Table_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("update-table");
   Url_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("url");
   Use_Banding_Columns_Styles_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-banding-columns-styles");
   Use_Banding_Rows_Styles_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-banding-rows-styles");
   Use_Caption_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-caption");
   Use_Catalog_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-catalog");
   Use_Chart_Objects_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-chart-objects");
   Use_Date_Time_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-date-time-name");
   Use_Draw_Objects_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-draw-objects");
   Use_First_Column_Styles_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-first-column-styles");
   Use_First_Row_Styles_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-first-row-styles");
   Use_Floating_Frames_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-floating-frames");
   Use_Footer_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-footer-name");
   Use_Graphics_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-graphics");
   Use_Header_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-header-name");
   Use_Index_Marks_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-index-marks");
   Use_Index_Source_Styles_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-index-source-styles");
   Use_Keys_As_Entries_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-keys-as-entries");
   Use_Labels_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-labels");
   Use_Last_Column_Styles_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-last-column-styles");
   Use_Last_Row_Styles_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-last-row-styles");
   Use_Math_Objects_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-math-objects");
   Use_Objects_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-objects");
   Use_Optimal_Column_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-optimal-column-width");
   Use_Optimal_Row_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-optimal-row-height");
   Use_Other_Objects_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-other-objects");
   Use_Outline_Level_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-outline-level");
   Use_Regular_Expressions_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-regular-expressions");
   Use_Soft_Page_Breaks_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-soft-page-breaks");
   Use_Spreadsheet_Objects_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-spreadsheet-objects");
   Use_System_User_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-system-user");
   Use_Tables_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-tables");
   Use_Wildcards_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-wildcards");
   Use_Window_Font_Color_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("use-window-font-color");
   Used_Hierarchy_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("used-hierarchy");
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
   User_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("user-name");
   User_Transformed_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("user-transformed");
   V_Alphabetic_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("v-alphabetic");
   V_Hanging_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("v-hanging");
   V_Ideographic_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("v-ideographic");
   V_Mathematical_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("v-mathematical");
   Validation_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("validation");
   Value_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("value");
   Value_Range_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("value-range");
   Value_Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("value-type");
   Values_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("values");
   Values_Cell_Range_Address_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("values-cell-range-address");
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
   Verb_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("verb");
   Version_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("version");
   Vertical_Align_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("vertical-align");
   Vertical_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("vertical");
   Vertical_Pos_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("vertical-pos");
   Vertical_Rel_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("vertical-rel");
   Vertical_Segments_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("vertical-segments");
   ViewBox_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("viewBox");
   Visibility_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("visibility");
   Visible_Area_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("visible-area-height");
   Visible_Area_Left_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("visible-area-left");
   Visible_Area_Top_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("visible-area-top");
   Visible_Area_Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("visible-area-width");
   Visible_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("visible");
   Visited_Style_Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("visited-style-name");
   Visual_Effect_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("visual-effect");
   Volatile_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("volatile");
   Volume_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("volume");
   Vpn_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("vpn");
   Vrp_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("vrp");
   Vup_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("vup");
   Wall_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("wall");
   Week_Of_Year_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("week-of-year");
   Widows_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("widows");
   Width_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("width");
   Widths_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("widths");
   Word_Count_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("word-count");
   Word_Count_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("word-count");
   Wrap_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("wrap");
   Wrap_Contour_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("wrap-contour");
   Wrap_Contour_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("wrap-contour-mode");
   Wrap_Dynamic_Threshold_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("wrap-dynamic-threshold");
   Wrap_Influence_On_Position_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("wrap-influence-on-position");
   Wrap_Option_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("wrap-option");
   Writing_Mode_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("writing-mode");
   Writing_Mode_Automatic_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("writing-mode-automatic");
   X1_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("x1");
   X2_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("x2");
   X_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("x");
   X_Height_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("x-height");
   Xforms_List_Source_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xforms-list-source");
   Xforms_Submission_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xforms-submission");
   Y1_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("y1");
   Y2_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("y2");
   Y_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("y");
   Year_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("year");
   Year_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("year");
   Z_Index_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("z-index");

end Matreshka.ODF_String_Constants;
