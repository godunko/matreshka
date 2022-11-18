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
with Matreshka.DOM_Documents;
with XML.DOM.Elements;

with ODF.DOM.Documents;
with ODF.DOM.Number_Am_Pm_Elements;
with ODF.DOM.Anim_Animate_Elements;
with ODF.DOM.Anim_AnimateColor_Elements;
with ODF.DOM.Anim_AnimateMotion_Elements;
with ODF.DOM.Anim_AnimateTransform_Elements;
with ODF.DOM.Anim_Audio_Elements;
with ODF.DOM.Anim_Command_Elements;
with ODF.DOM.Anim_Iterate_Elements;
with ODF.DOM.Anim_Par_Elements;
with ODF.DOM.Anim_Param_Elements;
with ODF.DOM.Anim_Seq_Elements;
with ODF.DOM.Anim_Set_Elements;
with ODF.DOM.Anim_TransitionFilter_Elements;
with ODF.DOM.Office_Annotation_Elements;
with ODF.DOM.Office_Annotation_End_Elements;
with ODF.DOM.Db_Application_Connection_Settings_Elements;
with ODF.DOM.Db_Auto_Increment_Elements;
with ODF.DOM.Chart_Axis_Elements;
with ODF.DOM.Number_Boolean_Elements;
with ODF.DOM.Number_Boolean_Style_Elements;
with ODF.DOM.Form_Button_Elements;
with ODF.DOM.Chart_Categories_Elements;
with ODF.DOM.Db_Character_Set_Elements;
with ODF.DOM.Chart_Chart_Elements;
with ODF.DOM.Form_Checkbox_Elements;
with ODF.DOM.Db_Column_Elements;
with ODF.DOM.Form_Column_Elements;
with ODF.DOM.Db_Column_Definition_Elements;
with ODF.DOM.Db_Column_Definitions_Elements;
with ODF.DOM.Db_Columns_Elements;
with ODF.DOM.Form_Combobox_Elements;
with ODF.DOM.Db_Component_Elements;
with ODF.DOM.Db_Component_Collection_Elements;
with ODF.DOM.Chart_Data_Label_Elements;
with ODF.DOM.Chart_Data_Point_Elements;
with ODF.DOM.Chart_Domain_Elements;
with ODF.DOM.Chart_Equation_Elements;
with ODF.DOM.Chart_Error_Indicator_Elements;
with ODF.DOM.Chart_Floor_Elements;
with ODF.DOM.Chart_Footer_Elements;
with ODF.DOM.Chart_Grid_Elements;
with ODF.DOM.Chart_Label_Separator_Elements;
with ODF.DOM.Chart_Legend_Elements;
with ODF.DOM.Chart_Mean_Value_Elements;
with ODF.DOM.Chart_Plot_Area_Elements;
with ODF.DOM.Chart_Regression_Curve_Elements;
with ODF.DOM.Chart_Series_Elements;
with ODF.DOM.Chart_Stock_Gain_Marker_Elements;
with ODF.DOM.Chart_Stock_Loss_Marker_Elements;
with ODF.DOM.Chart_Stock_Range_Line_Elements;
with ODF.DOM.Chart_Subtitle_Elements;
with ODF.DOM.Chart_Symbol_Image_Elements;
with ODF.DOM.Chart_Title_Elements;
with ODF.DOM.Chart_Wall_Elements;
with ODF.DOM.Draw_A_Elements;
with ODF.DOM.Presentation_Animation_Group_Elements;
with ODF.DOM.Presentation_Animations_Elements;
with ODF.DOM.Draw_Applet_Elements;
with ODF.DOM.Draw_Area_Circle_Elements;
with ODF.DOM.Draw_Area_Polygon_Elements;
with ODF.DOM.Draw_Area_Rectangle_Elements;
with ODF.DOM.Draw_Caption_Elements;
with ODF.DOM.Draw_Circle_Elements;
with ODF.DOM.Text_A_Elements;
with ODF.DOM.Text_Alphabetical_Index_Elements;
with ODF.DOM.Text_Alphabetical_Index_Auto_Mark_File_Elements;
with ODF.DOM.Text_Alphabetical_Index_Entry_Template_Elements;
with ODF.DOM.Text_Alphabetical_Index_Mark_Elements;
with ODF.DOM.Text_Alphabetical_Index_Mark_End_Elements;
with ODF.DOM.Text_Alphabetical_Index_Mark_Start_Elements;
with ODF.DOM.Text_Alphabetical_Index_Source_Elements;
with ODF.DOM.Text_Author_Initials_Elements;
with ODF.DOM.Text_Author_Name_Elements;
with ODF.DOM.Meta_Auto_Reload_Elements;
with ODF.DOM.Office_Automatic_Styles_Elements;
with ODF.DOM.Style_Background_Image_Elements;
with ODF.DOM.Style_Chart_Properties_Elements;
with ODF.DOM.Style_Column_Elements;
with ODF.DOM.Style_Column_Sep_Elements;
with ODF.DOM.Style_Columns_Elements;
with ODF.DOM.Table_Background_Elements;
with ODF.DOM.Text_Bibliography_Configuration_Elements;
with ODF.DOM.Office_Binary_Data_Elements;
with ODF.DOM.Table_Body_Elements;
with ODF.DOM.Table_Calculation_Settings_Elements;
with ODF.DOM.Table_Cell_Address_Elements;
with ODF.DOM.Table_Cell_Content_Change_Elements;
with ODF.DOM.Table_Cell_Content_Deletion_Elements;
with ODF.DOM.Table_Cell_Range_Source_Elements;
with ODF.DOM.Table_Change_Deletion_Elements;
with ODF.DOM.Table_Change_Track_Table_Cell_Elements;
with ODF.DOM.Text_Bibliography_Elements;
with ODF.DOM.Text_Bibliography_Entry_Template_Elements;
with ODF.DOM.Text_Bibliography_Mark_Elements;
with ODF.DOM.Text_Bibliography_Source_Elements;
with ODF.DOM.Text_Bookmark_Elements;
with ODF.DOM.Text_Bookmark_End_Elements;
with ODF.DOM.Text_Bookmark_Ref_Elements;
with ODF.DOM.Text_Bookmark_Start_Elements;
with ODF.DOM.Text_Change_Elements;
with ODF.DOM.Text_Change_End_Elements;
with ODF.DOM.Office_Change_Info_Elements;
with ODF.DOM.Text_Change_Start_Elements;
with ODF.DOM.Text_Changed_Region_Elements;
with ODF.DOM.Text_Chapter_Elements;
with ODF.DOM.Text_Character_Count_Elements;
with ODF.DOM.Text_Conditional_Text_Elements;
with ODF.DOM.Config_Config_Item_Elements;
with ODF.DOM.Config_Config_Item_Map_Entry_Elements;
with ODF.DOM.Config_Config_Item_Map_Indexed_Elements;
with ODF.DOM.Config_Config_Item_Map_Named_Elements;
with ODF.DOM.Config_Config_Item_Set_Elements;
with ODF.DOM.Db_Connection_Data_Elements;
with ODF.DOM.Db_Connection_Resource_Elements;
with ODF.DOM.Db_Data_Source_Elements;
with ODF.DOM.Db_Data_Source_Setting_Elements;
with ODF.DOM.Db_Data_Source_Setting_Value_Elements;
with ODF.DOM.Db_Data_Source_Settings_Elements;
with ODF.DOM.Db_Database_Description_Elements;
with ODF.DOM.Db_Delimiter_Elements;
with ODF.DOM.Db_Driver_Settings_Elements;
with ODF.DOM.Db_File_Based_Database_Elements;
with ODF.DOM.Draw_Fill_Image_Elements;
with ODF.DOM.Db_Filter_Statement_Elements;
with ODF.DOM.Db_Forms_Elements;
with ODF.DOM.Db_Index_Elements;
with ODF.DOM.Db_Index_Column_Elements;
with ODF.DOM.Db_Index_Columns_Elements;
with ODF.DOM.Db_Indices_Elements;
with ODF.DOM.Db_Key_Elements;
with ODF.DOM.Db_Key_Column_Elements;
with ODF.DOM.Db_Key_Columns_Elements;
with ODF.DOM.Db_Keys_Elements;
with ODF.DOM.Db_Login_Elements;
with ODF.DOM.Db_Order_Statement_Elements;
with ODF.DOM.Db_Queries_Elements;
with ODF.DOM.Db_Query_Elements;
with ODF.DOM.Db_Query_Collection_Elements;
with ODF.DOM.Db_Reports_Elements;
with ODF.DOM.Db_Schema_Definition_Elements;
with ODF.DOM.Db_Server_Database_Elements;
with ODF.DOM.Db_Table_Definition_Elements;
with ODF.DOM.Db_Table_Definitions_Elements;
with ODF.DOM.Db_Table_Exclude_Filter_Elements;
with ODF.DOM.Db_Table_Filter_Elements;
with ODF.DOM.Db_Table_Filter_Pattern_Elements;
with ODF.DOM.Db_Table_Include_Filter_Elements;
with ODF.DOM.Db_Table_Representation_Elements;
with ODF.DOM.Db_Table_Representations_Elements;
with ODF.DOM.Db_Table_Setting_Elements;
with ODF.DOM.Db_Table_Settings_Elements;
with ODF.DOM.Db_Table_Type_Elements;
with ODF.DOM.Db_Table_Type_Filter_Elements;
with ODF.DOM.Db_Update_Table_Elements;
with ODF.DOM.Draw_Connector_Elements;
with ODF.DOM.Draw_Contour_Path_Elements;
with ODF.DOM.Draw_Contour_Polygon_Elements;
with ODF.DOM.Draw_Control_Elements;
with ODF.DOM.Form_Connection_Resource_Elements;
with ODF.DOM.Table_Consolidation_Elements;
with ODF.DOM.Table_Content_Validation_Elements;
with ODF.DOM.Table_Content_Validations_Elements;
with ODF.DOM.Table_Covered_Table_Cell_Elements;
with ODF.DOM.Meta_Creation_Date_Elements;
with ODF.DOM.Text_Creation_Date_Elements;
with ODF.DOM.Text_Creation_Time_Elements;
with ODF.DOM.Dc_Creator_Elements;
with ODF.DOM.Dr3d_Cube_Elements;
with ODF.DOM.Number_Currency_Style_Elements;
with ODF.DOM.Number_Currency_Symbol_Elements;
with ODF.DOM.Draw_Custom_Shape_Elements;
with ODF.DOM.Form_Date_Elements;
with ODF.DOM.Meta_Date_String_Elements;
with ODF.DOM.Number_Date_Style_Elements;
with ODF.DOM.Number_Day_Elements;
with ODF.DOM.Number_Day_Of_Week_Elements;
with ODF.DOM.Number_Embedded_Text_Elements;
with ODF.DOM.Office_Database_Elements;
with ODF.DOM.Office_Dde_Source_Elements;
with ODF.DOM.Presentation_Date_Time_Elements;
with ODF.DOM.Presentation_Date_Time_Decl_Elements;
with ODF.DOM.Style_Default_Page_Layout_Elements;
with ODF.DOM.Style_Default_Style_Elements;
with ODF.DOM.Style_Drawing_Page_Properties_Elements;
with ODF.DOM.Style_Drop_Cap_Elements;
with ODF.DOM.Svg_Definition_Src_Elements;
with ODF.DOM.Table_Dde_Link_Elements;
with ODF.DOM.Presentation_Dim_Elements;
with ODF.DOM.Draw_Enhanced_Geometry_Elements;
with ODF.DOM.Dr3d_Extrude_Elements;
with ODF.DOM.Dr3d_Light_Elements;
with ODF.DOM.Dr3d_Rotate_Elements;
with ODF.DOM.Dr3d_Scene_Elements;
with ODF.DOM.Dr3d_Sphere_Elements;
with ODF.DOM.Svg_Desc_Elements;
with ODF.DOM.Draw_Ellipse_Elements;
with ODF.DOM.Draw_Equation_Elements;
with ODF.DOM.Number_Era_Elements;
with ODF.DOM.Table_Even_Columns_Elements;
with ODF.DOM.Table_Even_Rows_Elements;
with ODF.DOM.Script_Event_Listener_Elements;
with ODF.DOM.Form_File_Elements;
with ODF.DOM.Form_Fixed_Text_Elements;
with ODF.DOM.Presentation_Event_Listener_Elements;
with ODF.DOM.Draw_Floating_Frame_Elements;
with ODF.DOM.Form_Form_Elements;
with ODF.DOM.Form_Formatted_Text_Elements;
with ODF.DOM.Number_Fraction_Elements;
with ODF.DOM.Draw_Frame_Elements;
with ODF.DOM.Form_Frame_Elements;
with ODF.DOM.Form_Generic_Control_Elements;
with ODF.DOM.Office_Event_Listeners_Elements;
with ODF.DOM.Style_Font_Face_Elements;
with ODF.DOM.Svg_Font_Face_Format_Elements;
with ODF.DOM.Svg_Font_Face_Name_Elements;
with ODF.DOM.Svg_Font_Face_Src_Elements;
with ODF.DOM.Svg_Font_Face_Uri_Elements;
with ODF.DOM.Table_First_Column_Elements;
with ODF.DOM.Table_First_Row_Elements;
with ODF.DOM.Office_Forms_Elements;
with ODF.DOM.Presentation_Footer_Elements;
with ODF.DOM.Style_Footer_Elements;
with ODF.DOM.Presentation_Footer_Decl_Elements;
with ODF.DOM.Style_Footer_Left_Elements;
with ODF.DOM.Style_Footer_Style_Elements;
with ODF.DOM.Style_Footnote_Sep_Elements;
with ODF.DOM.Draw_G_Elements;
with ODF.DOM.Draw_Glue_Point_Elements;
with ODF.DOM.Draw_Gradient_Elements;
with ODF.DOM.Style_Graphic_Properties_Elements;
with ODF.DOM.Form_Grid_Elements;
with ODF.DOM.Draw_Handle_Elements;
with ODF.DOM.Draw_Hatch_Elements;
with ODF.DOM.Form_Hidden_Elements;
with ODF.DOM.Number_Hours_Elements;
with ODF.DOM.Form_Image_Elements;
with ODF.DOM.Form_Image_Frame_Elements;
with ODF.DOM.Presentation_Header_Elements;
with ODF.DOM.Style_Header_Elements;
with ODF.DOM.Presentation_Header_Decl_Elements;
with ODF.DOM.Style_Header_Footer_Properties_Elements;
with ODF.DOM.Style_Header_Left_Elements;
with ODF.DOM.Style_Header_Style_Elements;
with ODF.DOM.Presentation_Hide_Shape_Elements;
with ODF.DOM.Presentation_Hide_Text_Elements;
with ODF.DOM.Draw_Image_Elements;
with ODF.DOM.Draw_Image_Map_Elements;
with ODF.DOM.Form_Item_Elements;
with ODF.DOM.Draw_Layer_Elements;
with ODF.DOM.Draw_Layer_Set_Elements;
with ODF.DOM.Draw_Line_Elements;
with ODF.DOM.Style_List_Level_Label_Alignment_Elements;
with ODF.DOM.Style_List_Level_Properties_Elements;
with ODF.DOM.Draw_Marker_Elements;
with ODF.DOM.Svg_LinearGradient_Elements;
with ODF.DOM.Form_List_Property_Elements;
with ODF.DOM.Form_List_Value_Elements;
with ODF.DOM.Form_Listbox_Elements;
with ODF.DOM.Style_Map_Elements;
with ODF.DOM.Style_Master_Page_Elements;
with ODF.DOM.Math_Math_Elements;
with ODF.DOM.Draw_Measure_Elements;
with ODF.DOM.Number_Minutes_Elements;
with ODF.DOM.Number_Month_Elements;
with ODF.DOM.Presentation_Notes_Elements;
with ODF.DOM.Form_Number_Elements;
with ODF.DOM.Number_Number_Elements;
with ODF.DOM.Number_Number_Style_Elements;
with ODF.DOM.Draw_Object_Elements;
with ODF.DOM.Draw_Object_Ole_Elements;
with ODF.DOM.Draw_Opacity_Elements;
with ODF.DOM.Form_Option_Elements;
with ODF.DOM.Draw_Page_Elements;
with ODF.DOM.Style_Page_Layout_Elements;
with ODF.DOM.Style_Page_Layout_Properties_Elements;
with ODF.DOM.Draw_Page_Thumbnail_Elements;
with ODF.DOM.Style_Paragraph_Properties_Elements;
with ODF.DOM.Draw_Param_Elements;
with ODF.DOM.Form_Password_Elements;
with ODF.DOM.Draw_Path_Elements;
with ODF.DOM.Number_Percentage_Style_Elements;
with ODF.DOM.Presentation_Placeholder_Elements;
with ODF.DOM.Draw_Plugin_Elements;
with ODF.DOM.Draw_Polygon_Elements;
with ODF.DOM.Draw_Polyline_Elements;
with ODF.DOM.Style_Presentation_Page_Layout_Elements;
with ODF.DOM.Form_Properties_Elements;
with ODF.DOM.Form_Property_Elements;
with ODF.DOM.Number_Quarter_Elements;
with ODF.DOM.Svg_RadialGradient_Elements;
with ODF.DOM.Form_Radio_Elements;
with ODF.DOM.Draw_Rect_Elements;
with ODF.DOM.Style_Region_Center_Elements;
with ODF.DOM.Style_Region_Left_Elements;
with ODF.DOM.Style_Region_Right_Elements;
with ODF.DOM.Draw_Regular_Polygon_Elements;
with ODF.DOM.Style_Ruby_Properties_Elements;
with ODF.DOM.Draw_Stroke_Dash_Elements;
with ODF.DOM.Number_Scientific_Number_Elements;
with ODF.DOM.Number_Seconds_Elements;
with ODF.DOM.Style_Section_Properties_Elements;
with ODF.DOM.Svg_Stop_Elements;
with ODF.DOM.Number_Text_Elements;
with ODF.DOM.Style_Style_Elements;
with ODF.DOM.Style_Tab_Stop_Elements;
with ODF.DOM.Style_Tab_Stops_Elements;
with ODF.DOM.Style_Table_Cell_Properties_Elements;
with ODF.DOM.Style_Table_Column_Properties_Elements;
with ODF.DOM.Style_Table_Properties_Elements;
with ODF.DOM.Style_Table_Row_Properties_Elements;
with ODF.DOM.Form_Text_Elements;
with ODF.DOM.Draw_Text_Box_Elements;
with ODF.DOM.Number_Text_Content_Elements;
with ODF.DOM.Style_Text_Properties_Elements;
with ODF.DOM.Number_Text_Style_Elements;
with ODF.DOM.Form_Textarea_Elements;
with ODF.DOM.Form_Time_Elements;
with ODF.DOM.Number_Time_Style_Elements;
with ODF.DOM.Form_Value_Range_Elements;
with ODF.DOM.Number_Week_Of_Year_Elements;
with ODF.DOM.Number_Year_Elements;
with ODF.DOM.Table_Cut_Offs_Elements;
with ODF.DOM.Table_Data_Pilot_Display_Info_Elements;
with ODF.DOM.Table_Data_Pilot_Field_Elements;
with ODF.DOM.Table_Data_Pilot_Field_Reference_Elements;
with ODF.DOM.Table_Data_Pilot_Group_Elements;
with ODF.DOM.Table_Data_Pilot_Group_Member_Elements;
with ODF.DOM.Table_Data_Pilot_Groups_Elements;
with ODF.DOM.Table_Data_Pilot_Layout_Info_Elements;
with ODF.DOM.Table_Data_Pilot_Level_Elements;
with ODF.DOM.Table_Data_Pilot_Member_Elements;
with ODF.DOM.Table_Data_Pilot_Members_Elements;
with ODF.DOM.Table_Data_Pilot_Sort_Info_Elements;
with ODF.DOM.Table_Data_Pilot_Subtotal_Elements;
with ODF.DOM.Table_Data_Pilot_Subtotals_Elements;
with ODF.DOM.Table_Data_Pilot_Table_Elements;
with ODF.DOM.Table_Data_Pilot_Tables_Elements;
with ODF.DOM.Table_Database_Range_Elements;
with ODF.DOM.Table_Database_Ranges_Elements;
with ODF.DOM.Table_Database_Source_Query_Elements;
with ODF.DOM.Table_Database_Source_Sql_Elements;
with ODF.DOM.Table_Database_Source_Table_Elements;
with ODF.DOM.Table_Dde_Links_Elements;
with ODF.DOM.Table_Deletion_Elements;
with ODF.DOM.Table_Deletions_Elements;
with ODF.DOM.Table_Dependencies_Elements;
with ODF.DOM.Table_Dependency_Elements;
with ODF.DOM.Table_Desc_Elements;
with ODF.DOM.Table_Last_Column_Elements;
with ODF.DOM.Table_Last_Row_Elements;
with ODF.DOM.Table_Odd_Columns_Elements;
with ODF.DOM.Table_Odd_Rows_Elements;
with ODF.DOM.Table_Table_Template_Elements;
with ODF.DOM.Text_Creator_Elements;
with ODF.DOM.Text_Database_Display_Elements;
with ODF.DOM.Text_Database_Name_Elements;
with ODF.DOM.Text_Database_Next_Elements;
with ODF.DOM.Text_Database_Row_Number_Elements;
with ODF.DOM.Text_Database_Row_Select_Elements;
with ODF.DOM.Dc_Date_Elements;
with ODF.DOM.Text_Date_Elements;
with ODF.DOM.Text_Dde_Connection_Elements;
with ODF.DOM.Text_Dde_Connection_Decl_Elements;
with ODF.DOM.Text_Dde_Connection_Decls_Elements;
with ODF.DOM.Text_Deletion_Elements;
with ODF.DOM.Dc_Description_Elements;
with ODF.DOM.Table_Detective_Elements;
with ODF.DOM.Text_Description_Elements;
with ODF.DOM.Meta_Document_Statistic_Elements;
with ODF.DOM.Meta_Editing_Cycles_Elements;
with ODF.DOM.Meta_Editing_Duration_Elements;
with ODF.DOM.Dc_Language_Elements;
with ODF.DOM.Dc_Subject_Elements;
with ODF.DOM.Dc_Title_Elements;
with ODF.DOM.Meta_Generator_Elements;
with ODF.DOM.Meta_Hyperlink_Behaviour_Elements;
with ODF.DOM.Meta_Initial_Creator_Elements;
with ODF.DOM.Meta_Keyword_Elements;
with ODF.DOM.Meta_Print_Date_Elements;
with ODF.DOM.Meta_Printed_By_Elements;
with ODF.DOM.Meta_Template_Elements;
with ODF.DOM.Meta_User_Defined_Elements;
with ODF.DOM.Office_Body_Elements;
with ODF.DOM.Office_Chart_Elements;
with ODF.DOM.Office_Document_Elements;
with ODF.DOM.Office_Document_Content_Elements;
with ODF.DOM.Office_Document_Meta_Elements;
with ODF.DOM.Office_Document_Settings_Elements;
with ODF.DOM.Office_Document_Styles_Elements;
with ODF.DOM.Office_Drawing_Elements;
with ODF.DOM.Style_Handout_Master_Elements;
with ODF.DOM.Table_Error_Macro_Elements;
with ODF.DOM.Table_Error_Message_Elements;
with ODF.DOM.Table_Filter_Elements;
with ODF.DOM.Table_Filter_And_Elements;
with ODF.DOM.Table_Filter_Condition_Elements;
with ODF.DOM.Table_Filter_Or_Elements;
with ODF.DOM.Table_Filter_Set_Item_Elements;
with ODF.DOM.Table_Help_Message_Elements;
with ODF.DOM.Table_Highlighted_Range_Elements;
with ODF.DOM.Text_Editing_Cycles_Elements;
with ODF.DOM.Text_Editing_Duration_Elements;
with ODF.DOM.Text_Execute_Macro_Elements;
with ODF.DOM.Text_Expression_Elements;
with ODF.DOM.Text_File_Name_Elements;
with ODF.DOM.Office_Font_Face_Decls_Elements;
with ODF.DOM.Text_Format_Change_Elements;
with ODF.DOM.Text_H_Elements;
with ODF.DOM.Text_Hidden_Paragraph_Elements;
with ODF.DOM.Text_Hidden_Text_Elements;
with ODF.DOM.Text_Illustration_Index_Elements;
with ODF.DOM.Text_Illustration_Index_Entry_Template_Elements;
with ODF.DOM.Text_Illustration_Index_Source_Elements;
with ODF.DOM.Office_Image_Elements;
with ODF.DOM.Table_Insertion_Elements;
with ODF.DOM.Table_Insertion_Cut_Off_Elements;
with ODF.DOM.Table_Iteration_Elements;
with ODF.DOM.Table_Label_Range_Elements;
with ODF.DOM.Table_Label_Ranges_Elements;
with ODF.DOM.Text_Image_Count_Elements;
with ODF.DOM.Text_Index_Body_Elements;
with ODF.DOM.Text_Index_Entry_Bibliography_Elements;
with ODF.DOM.Text_Index_Entry_Chapter_Elements;
with ODF.DOM.Text_Index_Entry_Link_End_Elements;
with ODF.DOM.Text_Index_Entry_Link_Start_Elements;
with ODF.DOM.Text_Index_Entry_Page_Number_Elements;
with ODF.DOM.Text_Index_Entry_Span_Elements;
with ODF.DOM.Text_Index_Entry_Tab_Stop_Elements;
with ODF.DOM.Text_Index_Entry_Text_Elements;
with ODF.DOM.Text_Index_Source_Style_Elements;
with ODF.DOM.Text_Index_Source_Styles_Elements;
with ODF.DOM.Text_Index_Title_Elements;
with ODF.DOM.Text_Index_Title_Template_Elements;
with ODF.DOM.Text_Initial_Creator_Elements;
with ODF.DOM.Text_Insertion_Elements;
with ODF.DOM.Text_Keywords_Elements;
with ODF.DOM.Text_Line_Break_Elements;
with ODF.DOM.Text_Linenumbering_Configuration_Elements;
with ODF.DOM.Text_Linenumbering_Separator_Elements;
with ODF.DOM.Text_List_Elements;
with ODF.DOM.Text_List_Header_Elements;
with ODF.DOM.Text_List_Item_Elements;
with ODF.DOM.Text_List_Level_Style_Bullet_Elements;
with ODF.DOM.Text_List_Level_Style_Image_Elements;
with ODF.DOM.Text_List_Level_Style_Number_Elements;
with ODF.DOM.Text_List_Style_Elements;
with ODF.DOM.Office_Master_Styles_Elements;
with ODF.DOM.Text_Measure_Elements;
with ODF.DOM.Office_Meta_Elements;
with ODF.DOM.Presentation_Play_Elements;
with ODF.DOM.Presentation_Settings_Elements;
with ODF.DOM.Presentation_Show_Elements;
with ODF.DOM.Presentation_Show_Shape_Elements;
with ODF.DOM.Presentation_Show_Text_Elements;
with ODF.DOM.Presentation_Sound_Elements;
with ODF.DOM.Svg_Title_Elements;
with ODF.DOM.Table_Movement_Elements;
with ODF.DOM.Table_Movement_Cut_Off_Elements;
with ODF.DOM.Table_Named_Expression_Elements;
with ODF.DOM.Table_Named_Expressions_Elements;
with ODF.DOM.Table_Named_Range_Elements;
with ODF.DOM.Table_Null_Date_Elements;
with ODF.DOM.Table_Operation_Elements;
with ODF.DOM.Table_Previous_Elements;
with ODF.DOM.Table_Scenario_Elements;
with ODF.DOM.Table_Shapes_Elements;
with ODF.DOM.Table_Sort_Elements;
with ODF.DOM.Table_Sort_By_Elements;
with ODF.DOM.Table_Sort_Groups_Elements;
with ODF.DOM.Table_Source_Cell_Range_Elements;
with ODF.DOM.Table_Source_Range_Address_Elements;
with ODF.DOM.Table_Source_Service_Elements;
with ODF.DOM.Table_Subtotal_Field_Elements;
with ODF.DOM.Table_Subtotal_Rule_Elements;
with ODF.DOM.Table_Subtotal_Rules_Elements;
with ODF.DOM.Table_Table_Elements;
with ODF.DOM.Table_Table_Cell_Elements;
with ODF.DOM.Table_Table_Column_Elements;
with ODF.DOM.Table_Table_Column_Group_Elements;
with ODF.DOM.Table_Table_Columns_Elements;
with ODF.DOM.Table_Table_Header_Columns_Elements;
with ODF.DOM.Table_Table_Header_Rows_Elements;
with ODF.DOM.Table_Table_Row_Elements;
with ODF.DOM.Table_Table_Row_Group_Elements;
with ODF.DOM.Table_Table_Rows_Elements;
with ODF.DOM.Table_Table_Source_Elements;
with ODF.DOM.Table_Target_Range_Address_Elements;
with ODF.DOM.Table_Title_Elements;
with ODF.DOM.Table_Tracked_Changes_Elements;
with ODF.DOM.Text_Meta_Elements;
with ODF.DOM.Text_Meta_Field_Elements;
with ODF.DOM.Xforms_Model_Elements;
with ODF.DOM.Text_Modification_Date_Elements;
with ODF.DOM.Text_Modification_Time_Elements;
with ODF.DOM.Text_Note_Elements;
with ODF.DOM.Text_Note_Body_Elements;
with ODF.DOM.Text_Note_Citation_Elements;
with ODF.DOM.Text_Note_Continuation_Notice_Backward_Elements;
with ODF.DOM.Text_Note_Continuation_Notice_Forward_Elements;
with ODF.DOM.Text_Note_Ref_Elements;
with ODF.DOM.Text_Notes_Configuration_Elements;
with ODF.DOM.Text_Number_Elements;
with ODF.DOM.Text_Numbered_Paragraph_Elements;
with ODF.DOM.Text_Object_Count_Elements;
with ODF.DOM.Text_Object_Index_Elements;
with ODF.DOM.Text_Object_Index_Entry_Template_Elements;
with ODF.DOM.Text_Object_Index_Source_Elements;
with ODF.DOM.Text_Outline_Level_Style_Elements;
with ODF.DOM.Text_Outline_Style_Elements;
with ODF.DOM.Text_P_Elements;
with ODF.DOM.Text_Page_Elements;
with ODF.DOM.Text_Page_Continuation_Elements;
with ODF.DOM.Text_Page_Count_Elements;
with ODF.DOM.Text_Page_Number_Elements;
with ODF.DOM.Text_Page_Sequence_Elements;
with ODF.DOM.Text_Page_Variable_Get_Elements;
with ODF.DOM.Text_Page_Variable_Set_Elements;
with ODF.DOM.Text_Paragraph_Count_Elements;
with ODF.DOM.Text_Placeholder_Elements;
with ODF.DOM.Office_Presentation_Elements;
with ODF.DOM.Text_Print_Date_Elements;
with ODF.DOM.Text_Print_Time_Elements;
with ODF.DOM.Text_Printed_By_Elements;
with ODF.DOM.Text_Reference_Mark_Elements;
with ODF.DOM.Text_Reference_Mark_End_Elements;
with ODF.DOM.Text_Reference_Mark_Start_Elements;
with ODF.DOM.Text_Reference_Ref_Elements;
with ODF.DOM.Text_Ruby_Elements;
with ODF.DOM.Text_Ruby_Base_Elements;
with ODF.DOM.Text_Ruby_Text_Elements;
with ODF.DOM.Text_S_Elements;
with ODF.DOM.Office_Script_Elements;
with ODF.DOM.Text_Script_Elements;
with ODF.DOM.Office_Scripts_Elements;
with ODF.DOM.Text_Section_Elements;
with ODF.DOM.Text_Section_Source_Elements;
with ODF.DOM.Text_Sender_City_Elements;
with ODF.DOM.Text_Sender_Company_Elements;
with ODF.DOM.Text_Sender_Country_Elements;
with ODF.DOM.Text_Sender_Email_Elements;
with ODF.DOM.Text_Sender_Fax_Elements;
with ODF.DOM.Text_Sender_Firstname_Elements;
with ODF.DOM.Text_Sender_Initials_Elements;
with ODF.DOM.Text_Sender_Lastname_Elements;
with ODF.DOM.Text_Sender_Phone_Private_Elements;
with ODF.DOM.Text_Sender_Phone_Work_Elements;
with ODF.DOM.Text_Sender_Position_Elements;
with ODF.DOM.Text_Sender_Postal_Code_Elements;
with ODF.DOM.Text_Sender_State_Or_Province_Elements;
with ODF.DOM.Text_Sender_Street_Elements;
with ODF.DOM.Text_Sender_Title_Elements;
with ODF.DOM.Text_Sequence_Elements;
with ODF.DOM.Text_Sequence_Decl_Elements;
with ODF.DOM.Text_Sequence_Decls_Elements;
with ODF.DOM.Text_Sequence_Ref_Elements;
with ODF.DOM.Office_Settings_Elements;
with ODF.DOM.Text_Sheet_Name_Elements;
with ODF.DOM.Text_Soft_Page_Break_Elements;
with ODF.DOM.Text_Sort_Key_Elements;
with ODF.DOM.Text_Span_Elements;
with ODF.DOM.Office_Spreadsheet_Elements;
with ODF.DOM.Office_Styles_Elements;
with ODF.DOM.Text_Subject_Elements;
with ODF.DOM.Text_Tab_Elements;
with ODF.DOM.Text_Table_Count_Elements;
with ODF.DOM.Text_Table_Formula_Elements;
with ODF.DOM.Text_Table_Index_Elements;
with ODF.DOM.Text_Table_Index_Entry_Template_Elements;
with ODF.DOM.Text_Table_Index_Source_Elements;
with ODF.DOM.Text_Table_Of_Content_Elements;
with ODF.DOM.Text_Table_Of_Content_Entry_Template_Elements;
with ODF.DOM.Text_Table_Of_Content_Source_Elements;
with ODF.DOM.Text_Template_Name_Elements;
with ODF.DOM.Office_Text_Elements;
with ODF.DOM.Text_Text_Input_Elements;
with ODF.DOM.Text_Time_Elements;
with ODF.DOM.Text_Title_Elements;
with ODF.DOM.Text_Toc_Mark_Elements;
with ODF.DOM.Text_Toc_Mark_End_Elements;
with ODF.DOM.Text_Toc_Mark_Start_Elements;
with ODF.DOM.Text_Tracked_Changes_Elements;
with ODF.DOM.Text_User_Defined_Elements;
with ODF.DOM.Text_User_Field_Decl_Elements;
with ODF.DOM.Text_User_Field_Decls_Elements;
with ODF.DOM.Text_User_Field_Get_Elements;
with ODF.DOM.Text_User_Field_Input_Elements;
with ODF.DOM.Text_User_Index_Elements;
with ODF.DOM.Text_User_Index_Entry_Template_Elements;
with ODF.DOM.Text_User_Index_Mark_Elements;
with ODF.DOM.Text_User_Index_Mark_End_Elements;
with ODF.DOM.Text_User_Index_Mark_Start_Elements;
with ODF.DOM.Text_User_Index_Source_Elements;
with ODF.DOM.Text_Variable_Decl_Elements;
with ODF.DOM.Text_Variable_Decls_Elements;
with ODF.DOM.Text_Variable_Get_Elements;
with ODF.DOM.Text_Variable_Input_Elements;
with ODF.DOM.Text_Variable_Set_Elements;
with ODF.DOM.Text_Word_Count_Elements;

package Matreshka.ODF_Documents is

   type Document_Node is
     new Matreshka.DOM_Documents.Document_Node
       and ODF.DOM.Documents.ODF_Document with null record;

   overriding function Create_Number_Am_Pm_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Am_Pm_Elements.ODF_Number_Am_Pm_Access;

   overriding function Create_Anim_Animate_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Animate_Elements.ODF_Anim_Animate_Access;

   overriding function Create_Anim_AnimateColor_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_AnimateColor_Elements.ODF_Anim_AnimateColor_Access;

   overriding function Create_Anim_AnimateMotion_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_AnimateMotion_Elements.ODF_Anim_AnimateMotion_Access;

   overriding function Create_Anim_AnimateTransform_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_AnimateTransform_Elements.ODF_Anim_AnimateTransform_Access;

   overriding function Create_Anim_Audio_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Audio_Elements.ODF_Anim_Audio_Access;

   overriding function Create_Anim_Command_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Command_Elements.ODF_Anim_Command_Access;

   overriding function Create_Anim_Iterate_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Iterate_Elements.ODF_Anim_Iterate_Access;

   overriding function Create_Anim_Par_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Par_Elements.ODF_Anim_Par_Access;

   overriding function Create_Anim_Param_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Param_Elements.ODF_Anim_Param_Access;

   overriding function Create_Anim_Seq_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Seq_Elements.ODF_Anim_Seq_Access;

   overriding function Create_Anim_Set_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Set_Elements.ODF_Anim_Set_Access;

   overriding function Create_Anim_TransitionFilter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_TransitionFilter_Elements.ODF_Anim_TransitionFilter_Access;

   overriding function Create_Office_Annotation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Annotation_Elements.ODF_Office_Annotation_Access;

   overriding function Create_Office_Annotation_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Annotation_End_Elements.ODF_Office_Annotation_End_Access;

   overriding function Create_Db_Application_Connection_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Application_Connection_Settings_Elements.ODF_Db_Application_Connection_Settings_Access;

   overriding function Create_Db_Auto_Increment_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Auto_Increment_Elements.ODF_Db_Auto_Increment_Access;

   overriding function Create_Chart_Axis_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Axis_Elements.ODF_Chart_Axis_Access;

   overriding function Create_Number_Boolean_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Boolean_Elements.ODF_Number_Boolean_Access;

   overriding function Create_Number_Boolean_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Boolean_Style_Elements.ODF_Number_Boolean_Style_Access;

   overriding function Create_Form_Button_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Button_Elements.ODF_Form_Button_Access;

   overriding function Create_Chart_Categories_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Categories_Elements.ODF_Chart_Categories_Access;

   overriding function Create_Db_Character_Set_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Character_Set_Elements.ODF_Db_Character_Set_Access;

   overriding function Create_Chart_Chart_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Chart_Elements.ODF_Chart_Chart_Access;

   overriding function Create_Form_Checkbox_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Checkbox_Elements.ODF_Form_Checkbox_Access;

   overriding function Create_Db_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Column_Elements.ODF_Db_Column_Access;

   overriding function Create_Form_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Column_Elements.ODF_Form_Column_Access;

   overriding function Create_Db_Column_Definition_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Column_Definition_Elements.ODF_Db_Column_Definition_Access;

   overriding function Create_Db_Column_Definitions_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Column_Definitions_Elements.ODF_Db_Column_Definitions_Access;

   overriding function Create_Db_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Columns_Elements.ODF_Db_Columns_Access;

   overriding function Create_Form_Combobox_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Combobox_Elements.ODF_Form_Combobox_Access;

   overriding function Create_Db_Component_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Component_Elements.ODF_Db_Component_Access;

   overriding function Create_Db_Component_Collection_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Component_Collection_Elements.ODF_Db_Component_Collection_Access;

   overriding function Create_Chart_Data_Label_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Data_Label_Elements.ODF_Chart_Data_Label_Access;

   overriding function Create_Chart_Data_Point_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Data_Point_Elements.ODF_Chart_Data_Point_Access;

   overriding function Create_Chart_Domain_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Domain_Elements.ODF_Chart_Domain_Access;

   overriding function Create_Chart_Equation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Equation_Elements.ODF_Chart_Equation_Access;

   overriding function Create_Chart_Error_Indicator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Error_Indicator_Elements.ODF_Chart_Error_Indicator_Access;

   overriding function Create_Chart_Floor_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Floor_Elements.ODF_Chart_Floor_Access;

   overriding function Create_Chart_Footer_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Footer_Elements.ODF_Chart_Footer_Access;

   overriding function Create_Chart_Grid_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Grid_Elements.ODF_Chart_Grid_Access;

   overriding function Create_Chart_Label_Separator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Label_Separator_Elements.ODF_Chart_Label_Separator_Access;

   overriding function Create_Chart_Legend_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Legend_Elements.ODF_Chart_Legend_Access;

   overriding function Create_Chart_Mean_Value_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Mean_Value_Elements.ODF_Chart_Mean_Value_Access;

   overriding function Create_Chart_Plot_Area_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Plot_Area_Elements.ODF_Chart_Plot_Area_Access;

   overriding function Create_Chart_Regression_Curve_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Regression_Curve_Elements.ODF_Chart_Regression_Curve_Access;

   overriding function Create_Chart_Series_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Series_Elements.ODF_Chart_Series_Access;

   overriding function Create_Chart_Stock_Gain_Marker_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Stock_Gain_Marker_Elements.ODF_Chart_Stock_Gain_Marker_Access;

   overriding function Create_Chart_Stock_Loss_Marker_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Stock_Loss_Marker_Elements.ODF_Chart_Stock_Loss_Marker_Access;

   overriding function Create_Chart_Stock_Range_Line_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Stock_Range_Line_Elements.ODF_Chart_Stock_Range_Line_Access;

   overriding function Create_Chart_Subtitle_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Subtitle_Elements.ODF_Chart_Subtitle_Access;

   overriding function Create_Chart_Symbol_Image_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Symbol_Image_Elements.ODF_Chart_Symbol_Image_Access;

   overriding function Create_Chart_Title_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Title_Elements.ODF_Chart_Title_Access;

   overriding function Create_Chart_Wall_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Wall_Elements.ODF_Chart_Wall_Access;

   overriding function Create_Draw_A_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_A_Elements.ODF_Draw_A_Access;

   overriding function Create_Presentation_Animation_Group_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Animation_Group_Elements.ODF_Presentation_Animation_Group_Access;

   overriding function Create_Presentation_Animations_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Animations_Elements.ODF_Presentation_Animations_Access;

   overriding function Create_Draw_Applet_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Applet_Elements.ODF_Draw_Applet_Access;

   overriding function Create_Draw_Area_Circle_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Area_Circle_Elements.ODF_Draw_Area_Circle_Access;

   overriding function Create_Draw_Area_Polygon_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Area_Polygon_Elements.ODF_Draw_Area_Polygon_Access;

   overriding function Create_Draw_Area_Rectangle_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Area_Rectangle_Elements.ODF_Draw_Area_Rectangle_Access;

   overriding function Create_Draw_Caption_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Caption_Elements.ODF_Draw_Caption_Access;

   overriding function Create_Draw_Circle_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Circle_Elements.ODF_Draw_Circle_Access;

   overriding function Create_Text_A_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_A_Elements.ODF_Text_A_Access;

   overriding function Create_Text_Alphabetical_Index_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Alphabetical_Index_Elements.ODF_Text_Alphabetical_Index_Access;

   overriding function Create_Text_Alphabetical_Index_Auto_Mark_File_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Alphabetical_Index_Auto_Mark_File_Elements.ODF_Text_Alphabetical_Index_Auto_Mark_File_Access;

   overriding function Create_Text_Alphabetical_Index_Entry_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Alphabetical_Index_Entry_Template_Elements.ODF_Text_Alphabetical_Index_Entry_Template_Access;

   overriding function Create_Text_Alphabetical_Index_Mark_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Alphabetical_Index_Mark_Elements.ODF_Text_Alphabetical_Index_Mark_Access;

   overriding function Create_Text_Alphabetical_Index_Mark_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Alphabetical_Index_Mark_End_Elements.ODF_Text_Alphabetical_Index_Mark_End_Access;

   overriding function Create_Text_Alphabetical_Index_Mark_Start_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Alphabetical_Index_Mark_Start_Elements.ODF_Text_Alphabetical_Index_Mark_Start_Access;

   overriding function Create_Text_Alphabetical_Index_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Alphabetical_Index_Source_Elements.ODF_Text_Alphabetical_Index_Source_Access;

   overriding function Create_Text_Author_Initials_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Author_Initials_Elements.ODF_Text_Author_Initials_Access;

   overriding function Create_Text_Author_Name_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Author_Name_Elements.ODF_Text_Author_Name_Access;

   overriding function Create_Meta_Auto_Reload_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Auto_Reload_Elements.ODF_Meta_Auto_Reload_Access;

   overriding function Create_Office_Automatic_Styles_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Automatic_Styles_Elements.ODF_Office_Automatic_Styles_Access;

   overriding function Create_Style_Background_Image_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Background_Image_Elements.ODF_Style_Background_Image_Access;

   overriding function Create_Style_Chart_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Chart_Properties_Elements.ODF_Style_Chart_Properties_Access;

   overriding function Create_Style_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Column_Elements.ODF_Style_Column_Access;

   overriding function Create_Style_Column_Sep_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Column_Sep_Elements.ODF_Style_Column_Sep_Access;

   overriding function Create_Style_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Columns_Elements.ODF_Style_Columns_Access;

   overriding function Create_Table_Background_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Background_Elements.ODF_Table_Background_Access;

   overriding function Create_Text_Bibliography_Configuration_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bibliography_Configuration_Elements.ODF_Text_Bibliography_Configuration_Access;

   overriding function Create_Office_Binary_Data_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Binary_Data_Elements.ODF_Office_Binary_Data_Access;

   overriding function Create_Table_Body_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Body_Elements.ODF_Table_Body_Access;

   overriding function Create_Table_Calculation_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Calculation_Settings_Elements.ODF_Table_Calculation_Settings_Access;

   overriding function Create_Table_Cell_Address_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Cell_Address_Elements.ODF_Table_Cell_Address_Access;

   overriding function Create_Table_Cell_Content_Change_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Cell_Content_Change_Elements.ODF_Table_Cell_Content_Change_Access;

   overriding function Create_Table_Cell_Content_Deletion_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Cell_Content_Deletion_Elements.ODF_Table_Cell_Content_Deletion_Access;

   overriding function Create_Table_Cell_Range_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Cell_Range_Source_Elements.ODF_Table_Cell_Range_Source_Access;

   overriding function Create_Table_Change_Deletion_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Change_Deletion_Elements.ODF_Table_Change_Deletion_Access;

   overriding function Create_Table_Change_Track_Table_Cell_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Change_Track_Table_Cell_Elements.ODF_Table_Change_Track_Table_Cell_Access;

   overriding function Create_Text_Bibliography_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bibliography_Elements.ODF_Text_Bibliography_Access;

   overriding function Create_Text_Bibliography_Entry_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bibliography_Entry_Template_Elements.ODF_Text_Bibliography_Entry_Template_Access;

   overriding function Create_Text_Bibliography_Mark_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bibliography_Mark_Elements.ODF_Text_Bibliography_Mark_Access;

   overriding function Create_Text_Bibliography_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bibliography_Source_Elements.ODF_Text_Bibliography_Source_Access;

   overriding function Create_Text_Bookmark_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bookmark_Elements.ODF_Text_Bookmark_Access;

   overriding function Create_Text_Bookmark_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bookmark_End_Elements.ODF_Text_Bookmark_End_Access;

   overriding function Create_Text_Bookmark_Ref_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bookmark_Ref_Elements.ODF_Text_Bookmark_Ref_Access;

   overriding function Create_Text_Bookmark_Start_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bookmark_Start_Elements.ODF_Text_Bookmark_Start_Access;

   overriding function Create_Text_Change_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Change_Elements.ODF_Text_Change_Access;

   overriding function Create_Text_Change_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Change_End_Elements.ODF_Text_Change_End_Access;

   overriding function Create_Office_Change_Info_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Change_Info_Elements.ODF_Office_Change_Info_Access;

   overriding function Create_Text_Change_Start_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Change_Start_Elements.ODF_Text_Change_Start_Access;

   overriding function Create_Text_Changed_Region_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Changed_Region_Elements.ODF_Text_Changed_Region_Access;

   overriding function Create_Text_Chapter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Chapter_Elements.ODF_Text_Chapter_Access;

   overriding function Create_Text_Character_Count_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Character_Count_Elements.ODF_Text_Character_Count_Access;

   overriding function Create_Text_Conditional_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Conditional_Text_Elements.ODF_Text_Conditional_Text_Access;

   overriding function Create_Config_Config_Item_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Config_Config_Item_Elements.ODF_Config_Config_Item_Access;

   overriding function Create_Config_Config_Item_Map_Entry_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Config_Config_Item_Map_Entry_Elements.ODF_Config_Config_Item_Map_Entry_Access;

   overriding function Create_Config_Config_Item_Map_Indexed_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Config_Config_Item_Map_Indexed_Elements.ODF_Config_Config_Item_Map_Indexed_Access;

   overriding function Create_Config_Config_Item_Map_Named_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Config_Config_Item_Map_Named_Elements.ODF_Config_Config_Item_Map_Named_Access;

   overriding function Create_Config_Config_Item_Set_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Config_Config_Item_Set_Elements.ODF_Config_Config_Item_Set_Access;

   overriding function Create_Db_Connection_Data_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Connection_Data_Elements.ODF_Db_Connection_Data_Access;

   overriding function Create_Db_Connection_Resource_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Connection_Resource_Elements.ODF_Db_Connection_Resource_Access;

   overriding function Create_Db_Data_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Data_Source_Elements.ODF_Db_Data_Source_Access;

   overriding function Create_Db_Data_Source_Setting_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Data_Source_Setting_Elements.ODF_Db_Data_Source_Setting_Access;

   overriding function Create_Db_Data_Source_Setting_Value_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Data_Source_Setting_Value_Elements.ODF_Db_Data_Source_Setting_Value_Access;

   overriding function Create_Db_Data_Source_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Data_Source_Settings_Elements.ODF_Db_Data_Source_Settings_Access;

   overriding function Create_Db_Database_Description_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Database_Description_Elements.ODF_Db_Database_Description_Access;

   overriding function Create_Db_Delimiter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Delimiter_Elements.ODF_Db_Delimiter_Access;

   overriding function Create_Db_Driver_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Driver_Settings_Elements.ODF_Db_Driver_Settings_Access;

   overriding function Create_Db_File_Based_Database_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_File_Based_Database_Elements.ODF_Db_File_Based_Database_Access;

   overriding function Create_Draw_Fill_Image_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Fill_Image_Elements.ODF_Draw_Fill_Image_Access;

   overriding function Create_Db_Filter_Statement_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Filter_Statement_Elements.ODF_Db_Filter_Statement_Access;

   overriding function Create_Db_Forms_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Forms_Elements.ODF_Db_Forms_Access;

   overriding function Create_Db_Index_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Index_Elements.ODF_Db_Index_Access;

   overriding function Create_Db_Index_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Index_Column_Elements.ODF_Db_Index_Column_Access;

   overriding function Create_Db_Index_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Index_Columns_Elements.ODF_Db_Index_Columns_Access;

   overriding function Create_Db_Indices_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Indices_Elements.ODF_Db_Indices_Access;

   overriding function Create_Db_Key_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Key_Elements.ODF_Db_Key_Access;

   overriding function Create_Db_Key_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Key_Column_Elements.ODF_Db_Key_Column_Access;

   overriding function Create_Db_Key_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Key_Columns_Elements.ODF_Db_Key_Columns_Access;

   overriding function Create_Db_Keys_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Keys_Elements.ODF_Db_Keys_Access;

   overriding function Create_Db_Login_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Login_Elements.ODF_Db_Login_Access;

   overriding function Create_Db_Order_Statement_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Order_Statement_Elements.ODF_Db_Order_Statement_Access;

   overriding function Create_Db_Queries_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Queries_Elements.ODF_Db_Queries_Access;

   overriding function Create_Db_Query_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Query_Elements.ODF_Db_Query_Access;

   overriding function Create_Db_Query_Collection_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Query_Collection_Elements.ODF_Db_Query_Collection_Access;

   overriding function Create_Db_Reports_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Reports_Elements.ODF_Db_Reports_Access;

   overriding function Create_Db_Schema_Definition_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Schema_Definition_Elements.ODF_Db_Schema_Definition_Access;

   overriding function Create_Db_Server_Database_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Server_Database_Elements.ODF_Db_Server_Database_Access;

   overriding function Create_Db_Table_Definition_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Definition_Elements.ODF_Db_Table_Definition_Access;

   overriding function Create_Db_Table_Definitions_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Definitions_Elements.ODF_Db_Table_Definitions_Access;

   overriding function Create_Db_Table_Exclude_Filter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Exclude_Filter_Elements.ODF_Db_Table_Exclude_Filter_Access;

   overriding function Create_Db_Table_Filter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Filter_Elements.ODF_Db_Table_Filter_Access;

   overriding function Create_Db_Table_Filter_Pattern_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Filter_Pattern_Elements.ODF_Db_Table_Filter_Pattern_Access;

   overriding function Create_Db_Table_Include_Filter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Include_Filter_Elements.ODF_Db_Table_Include_Filter_Access;

   overriding function Create_Db_Table_Representation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Representation_Elements.ODF_Db_Table_Representation_Access;

   overriding function Create_Db_Table_Representations_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Representations_Elements.ODF_Db_Table_Representations_Access;

   overriding function Create_Db_Table_Setting_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Setting_Elements.ODF_Db_Table_Setting_Access;

   overriding function Create_Db_Table_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Settings_Elements.ODF_Db_Table_Settings_Access;

   overriding function Create_Db_Table_Type_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Type_Elements.ODF_Db_Table_Type_Access;

   overriding function Create_Db_Table_Type_Filter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Type_Filter_Elements.ODF_Db_Table_Type_Filter_Access;

   overriding function Create_Db_Update_Table_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Update_Table_Elements.ODF_Db_Update_Table_Access;

   overriding function Create_Draw_Connector_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Connector_Elements.ODF_Draw_Connector_Access;

   overriding function Create_Draw_Contour_Path_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Contour_Path_Elements.ODF_Draw_Contour_Path_Access;

   overriding function Create_Draw_Contour_Polygon_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Contour_Polygon_Elements.ODF_Draw_Contour_Polygon_Access;

   overriding function Create_Draw_Control_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Control_Elements.ODF_Draw_Control_Access;

   overriding function Create_Form_Connection_Resource_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Connection_Resource_Elements.ODF_Form_Connection_Resource_Access;

   overriding function Create_Table_Consolidation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Consolidation_Elements.ODF_Table_Consolidation_Access;

   overriding function Create_Table_Content_Validation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Content_Validation_Elements.ODF_Table_Content_Validation_Access;

   overriding function Create_Table_Content_Validations_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Content_Validations_Elements.ODF_Table_Content_Validations_Access;

   overriding function Create_Table_Covered_Table_Cell_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Covered_Table_Cell_Elements.ODF_Table_Covered_Table_Cell_Access;

   overriding function Create_Meta_Creation_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Creation_Date_Elements.ODF_Meta_Creation_Date_Access;

   overriding function Create_Text_Creation_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Creation_Date_Elements.ODF_Text_Creation_Date_Access;

   overriding function Create_Text_Creation_Time_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Creation_Time_Elements.ODF_Text_Creation_Time_Access;

   overriding function Create_Dc_Creator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dc_Creator_Elements.ODF_Dc_Creator_Access;

   overriding function Create_Dr3d_Cube_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dr3d_Cube_Elements.ODF_Dr3d_Cube_Access;

   overriding function Create_Number_Currency_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Currency_Style_Elements.ODF_Number_Currency_Style_Access;

   overriding function Create_Number_Currency_Symbol_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Currency_Symbol_Elements.ODF_Number_Currency_Symbol_Access;

   overriding function Create_Draw_Custom_Shape_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Custom_Shape_Elements.ODF_Draw_Custom_Shape_Access;

   overriding function Create_Form_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Date_Elements.ODF_Form_Date_Access;

   overriding function Create_Meta_Date_String_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Date_String_Elements.ODF_Meta_Date_String_Access;

   overriding function Create_Number_Date_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Date_Style_Elements.ODF_Number_Date_Style_Access;

   overriding function Create_Number_Day_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Day_Elements.ODF_Number_Day_Access;

   overriding function Create_Number_Day_Of_Week_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Day_Of_Week_Elements.ODF_Number_Day_Of_Week_Access;

   overriding function Create_Number_Embedded_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Embedded_Text_Elements.ODF_Number_Embedded_Text_Access;

   overriding function Create_Office_Database_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Database_Elements.ODF_Office_Database_Access;

   overriding function Create_Office_Dde_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Dde_Source_Elements.ODF_Office_Dde_Source_Access;

   overriding function Create_Presentation_Date_Time_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Date_Time_Elements.ODF_Presentation_Date_Time_Access;

   overriding function Create_Presentation_Date_Time_Decl_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Date_Time_Decl_Elements.ODF_Presentation_Date_Time_Decl_Access;

   overriding function Create_Style_Default_Page_Layout_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Default_Page_Layout_Elements.ODF_Style_Default_Page_Layout_Access;

   overriding function Create_Style_Default_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Default_Style_Elements.ODF_Style_Default_Style_Access;

   overriding function Create_Style_Drawing_Page_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Drawing_Page_Properties_Elements.ODF_Style_Drawing_Page_Properties_Access;

   overriding function Create_Style_Drop_Cap_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Drop_Cap_Elements.ODF_Style_Drop_Cap_Access;

   overriding function Create_Svg_Definition_Src_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Definition_Src_Elements.ODF_Svg_Definition_Src_Access;

   overriding function Create_Table_Dde_Link_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Dde_Link_Elements.ODF_Table_Dde_Link_Access;

   overriding function Create_Presentation_Dim_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Dim_Elements.ODF_Presentation_Dim_Access;

   overriding function Create_Draw_Enhanced_Geometry_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Enhanced_Geometry_Elements.ODF_Draw_Enhanced_Geometry_Access;

   overriding function Create_Dr3d_Extrude_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dr3d_Extrude_Elements.ODF_Dr3d_Extrude_Access;

   overriding function Create_Dr3d_Light_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dr3d_Light_Elements.ODF_Dr3d_Light_Access;

   overriding function Create_Dr3d_Rotate_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dr3d_Rotate_Elements.ODF_Dr3d_Rotate_Access;

   overriding function Create_Dr3d_Scene_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dr3d_Scene_Elements.ODF_Dr3d_Scene_Access;

   overriding function Create_Dr3d_Sphere_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dr3d_Sphere_Elements.ODF_Dr3d_Sphere_Access;

   overriding function Create_Svg_Desc_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Desc_Elements.ODF_Svg_Desc_Access;

   overriding function Create_Draw_Ellipse_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Ellipse_Elements.ODF_Draw_Ellipse_Access;

   overriding function Create_Draw_Equation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Equation_Elements.ODF_Draw_Equation_Access;

   overriding function Create_Number_Era_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Era_Elements.ODF_Number_Era_Access;

   overriding function Create_Table_Even_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Even_Columns_Elements.ODF_Table_Even_Columns_Access;

   overriding function Create_Table_Even_Rows_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Even_Rows_Elements.ODF_Table_Even_Rows_Access;

   overriding function Create_Script_Event_Listener_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Script_Event_Listener_Elements.ODF_Script_Event_Listener_Access;

   overriding function Create_Form_File_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_File_Elements.ODF_Form_File_Access;

   overriding function Create_Form_Fixed_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Fixed_Text_Elements.ODF_Form_Fixed_Text_Access;

   overriding function Create_Presentation_Event_Listener_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Event_Listener_Elements.ODF_Presentation_Event_Listener_Access;

   overriding function Create_Draw_Floating_Frame_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Floating_Frame_Elements.ODF_Draw_Floating_Frame_Access;

   overriding function Create_Form_Form_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Form_Elements.ODF_Form_Form_Access;

   overriding function Create_Form_Formatted_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Formatted_Text_Elements.ODF_Form_Formatted_Text_Access;

   overriding function Create_Number_Fraction_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Fraction_Elements.ODF_Number_Fraction_Access;

   overriding function Create_Draw_Frame_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Frame_Elements.ODF_Draw_Frame_Access;

   overriding function Create_Form_Frame_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Frame_Elements.ODF_Form_Frame_Access;

   overriding function Create_Form_Generic_Control_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Generic_Control_Elements.ODF_Form_Generic_Control_Access;

   overriding function Create_Office_Event_Listeners_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Event_Listeners_Elements.ODF_Office_Event_Listeners_Access;

   overriding function Create_Style_Font_Face_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Font_Face_Elements.ODF_Style_Font_Face_Access;

   overriding function Create_Svg_Font_Face_Format_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Font_Face_Format_Elements.ODF_Svg_Font_Face_Format_Access;

   overriding function Create_Svg_Font_Face_Name_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Font_Face_Name_Elements.ODF_Svg_Font_Face_Name_Access;

   overriding function Create_Svg_Font_Face_Src_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Font_Face_Src_Elements.ODF_Svg_Font_Face_Src_Access;

   overriding function Create_Svg_Font_Face_Uri_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Font_Face_Uri_Elements.ODF_Svg_Font_Face_Uri_Access;

   overriding function Create_Table_First_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_First_Column_Elements.ODF_Table_First_Column_Access;

   overriding function Create_Table_First_Row_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_First_Row_Elements.ODF_Table_First_Row_Access;

   overriding function Create_Office_Forms_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Forms_Elements.ODF_Office_Forms_Access;

   overriding function Create_Presentation_Footer_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Footer_Elements.ODF_Presentation_Footer_Access;

   overriding function Create_Style_Footer_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Footer_Elements.ODF_Style_Footer_Access;

   overriding function Create_Presentation_Footer_Decl_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Footer_Decl_Elements.ODF_Presentation_Footer_Decl_Access;

   overriding function Create_Style_Footer_Left_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Footer_Left_Elements.ODF_Style_Footer_Left_Access;

   overriding function Create_Style_Footer_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Footer_Style_Elements.ODF_Style_Footer_Style_Access;

   overriding function Create_Style_Footnote_Sep_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Footnote_Sep_Elements.ODF_Style_Footnote_Sep_Access;

   overriding function Create_Draw_G_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_G_Elements.ODF_Draw_G_Access;

   overriding function Create_Draw_Glue_Point_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Glue_Point_Elements.ODF_Draw_Glue_Point_Access;

   overriding function Create_Draw_Gradient_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Gradient_Elements.ODF_Draw_Gradient_Access;

   overriding function Create_Style_Graphic_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Graphic_Properties_Elements.ODF_Style_Graphic_Properties_Access;

   overriding function Create_Form_Grid_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Grid_Elements.ODF_Form_Grid_Access;

   overriding function Create_Draw_Handle_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Handle_Elements.ODF_Draw_Handle_Access;

   overriding function Create_Draw_Hatch_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Hatch_Elements.ODF_Draw_Hatch_Access;

   overriding function Create_Form_Hidden_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Hidden_Elements.ODF_Form_Hidden_Access;

   overriding function Create_Number_Hours_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Hours_Elements.ODF_Number_Hours_Access;

   overriding function Create_Form_Image_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Image_Elements.ODF_Form_Image_Access;

   overriding function Create_Form_Image_Frame_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Image_Frame_Elements.ODF_Form_Image_Frame_Access;

   overriding function Create_Presentation_Header_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Header_Elements.ODF_Presentation_Header_Access;

   overriding function Create_Style_Header_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Header_Elements.ODF_Style_Header_Access;

   overriding function Create_Presentation_Header_Decl_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Header_Decl_Elements.ODF_Presentation_Header_Decl_Access;

   overriding function Create_Style_Header_Footer_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Header_Footer_Properties_Elements.ODF_Style_Header_Footer_Properties_Access;

   overriding function Create_Style_Header_Left_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Header_Left_Elements.ODF_Style_Header_Left_Access;

   overriding function Create_Style_Header_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Header_Style_Elements.ODF_Style_Header_Style_Access;

   overriding function Create_Presentation_Hide_Shape_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Hide_Shape_Elements.ODF_Presentation_Hide_Shape_Access;

   overriding function Create_Presentation_Hide_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Hide_Text_Elements.ODF_Presentation_Hide_Text_Access;

   overriding function Create_Draw_Image_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Image_Elements.ODF_Draw_Image_Access;

   overriding function Create_Draw_Image_Map_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Image_Map_Elements.ODF_Draw_Image_Map_Access;

   overriding function Create_Form_Item_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Item_Elements.ODF_Form_Item_Access;

   overriding function Create_Draw_Layer_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Layer_Elements.ODF_Draw_Layer_Access;

   overriding function Create_Draw_Layer_Set_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Layer_Set_Elements.ODF_Draw_Layer_Set_Access;

   overriding function Create_Draw_Line_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Line_Elements.ODF_Draw_Line_Access;

   overriding function Create_Style_List_Level_Label_Alignment_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_List_Level_Label_Alignment_Elements.ODF_Style_List_Level_Label_Alignment_Access;

   overriding function Create_Style_List_Level_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_List_Level_Properties_Elements.ODF_Style_List_Level_Properties_Access;

   overriding function Create_Draw_Marker_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Marker_Elements.ODF_Draw_Marker_Access;

   overriding function Create_Svg_LinearGradient_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_LinearGradient_Elements.ODF_Svg_LinearGradient_Access;

   overriding function Create_Form_List_Property_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_List_Property_Elements.ODF_Form_List_Property_Access;

   overriding function Create_Form_List_Value_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_List_Value_Elements.ODF_Form_List_Value_Access;

   overriding function Create_Form_Listbox_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Listbox_Elements.ODF_Form_Listbox_Access;

   overriding function Create_Style_Map_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Map_Elements.ODF_Style_Map_Access;

   overriding function Create_Style_Master_Page_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Master_Page_Elements.ODF_Style_Master_Page_Access;

   overriding function Create_Math_Math_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Math_Math_Elements.ODF_Math_Math_Access;

   overriding function Create_Draw_Measure_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Measure_Elements.ODF_Draw_Measure_Access;

   overriding function Create_Number_Minutes_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Minutes_Elements.ODF_Number_Minutes_Access;

   overriding function Create_Number_Month_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Month_Elements.ODF_Number_Month_Access;

   overriding function Create_Presentation_Notes_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Notes_Elements.ODF_Presentation_Notes_Access;

   overriding function Create_Form_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Number_Elements.ODF_Form_Number_Access;

   overriding function Create_Number_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Number_Elements.ODF_Number_Number_Access;

   overriding function Create_Number_Number_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Number_Style_Elements.ODF_Number_Number_Style_Access;

   overriding function Create_Draw_Object_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Object_Elements.ODF_Draw_Object_Access;

   overriding function Create_Draw_Object_Ole_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Object_Ole_Elements.ODF_Draw_Object_Ole_Access;

   overriding function Create_Draw_Opacity_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Opacity_Elements.ODF_Draw_Opacity_Access;

   overriding function Create_Form_Option_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Option_Elements.ODF_Form_Option_Access;

   overriding function Create_Draw_Page_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Page_Elements.ODF_Draw_Page_Access;

   overriding function Create_Style_Page_Layout_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Page_Layout_Elements.ODF_Style_Page_Layout_Access;

   overriding function Create_Style_Page_Layout_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Page_Layout_Properties_Elements.ODF_Style_Page_Layout_Properties_Access;

   overriding function Create_Draw_Page_Thumbnail_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Page_Thumbnail_Elements.ODF_Draw_Page_Thumbnail_Access;

   overriding function Create_Style_Paragraph_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Paragraph_Properties_Elements.ODF_Style_Paragraph_Properties_Access;

   overriding function Create_Draw_Param_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Param_Elements.ODF_Draw_Param_Access;

   overriding function Create_Form_Password_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Password_Elements.ODF_Form_Password_Access;

   overriding function Create_Draw_Path_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Path_Elements.ODF_Draw_Path_Access;

   overriding function Create_Number_Percentage_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Percentage_Style_Elements.ODF_Number_Percentage_Style_Access;

   overriding function Create_Presentation_Placeholder_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Placeholder_Elements.ODF_Presentation_Placeholder_Access;

   overriding function Create_Draw_Plugin_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Plugin_Elements.ODF_Draw_Plugin_Access;

   overriding function Create_Draw_Polygon_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Polygon_Elements.ODF_Draw_Polygon_Access;

   overriding function Create_Draw_Polyline_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Polyline_Elements.ODF_Draw_Polyline_Access;

   overriding function Create_Style_Presentation_Page_Layout_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Presentation_Page_Layout_Elements.ODF_Style_Presentation_Page_Layout_Access;

   overriding function Create_Form_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Properties_Elements.ODF_Form_Properties_Access;

   overriding function Create_Form_Property_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Property_Elements.ODF_Form_Property_Access;

   overriding function Create_Number_Quarter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Quarter_Elements.ODF_Number_Quarter_Access;

   overriding function Create_Svg_RadialGradient_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_RadialGradient_Elements.ODF_Svg_RadialGradient_Access;

   overriding function Create_Form_Radio_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Radio_Elements.ODF_Form_Radio_Access;

   overriding function Create_Draw_Rect_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Rect_Elements.ODF_Draw_Rect_Access;

   overriding function Create_Style_Region_Center_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Region_Center_Elements.ODF_Style_Region_Center_Access;

   overriding function Create_Style_Region_Left_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Region_Left_Elements.ODF_Style_Region_Left_Access;

   overriding function Create_Style_Region_Right_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Region_Right_Elements.ODF_Style_Region_Right_Access;

   overriding function Create_Draw_Regular_Polygon_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Regular_Polygon_Elements.ODF_Draw_Regular_Polygon_Access;

   overriding function Create_Style_Ruby_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Ruby_Properties_Elements.ODF_Style_Ruby_Properties_Access;

   overriding function Create_Draw_Stroke_Dash_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Stroke_Dash_Elements.ODF_Draw_Stroke_Dash_Access;

   overriding function Create_Number_Scientific_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Scientific_Number_Elements.ODF_Number_Scientific_Number_Access;

   overriding function Create_Number_Seconds_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Seconds_Elements.ODF_Number_Seconds_Access;

   overriding function Create_Style_Section_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Section_Properties_Elements.ODF_Style_Section_Properties_Access;

   overriding function Create_Svg_Stop_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Stop_Elements.ODF_Svg_Stop_Access;

   overriding function Create_Number_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Text_Elements.ODF_Number_Text_Access;

   overriding function Create_Style_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Style_Elements.ODF_Style_Style_Access;

   overriding function Create_Style_Tab_Stop_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Tab_Stop_Elements.ODF_Style_Tab_Stop_Access;

   overriding function Create_Style_Tab_Stops_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Tab_Stops_Elements.ODF_Style_Tab_Stops_Access;

   overriding function Create_Style_Table_Cell_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Table_Cell_Properties_Elements.ODF_Style_Table_Cell_Properties_Access;

   overriding function Create_Style_Table_Column_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Table_Column_Properties_Elements.ODF_Style_Table_Column_Properties_Access;

   overriding function Create_Style_Table_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Table_Properties_Elements.ODF_Style_Table_Properties_Access;

   overriding function Create_Style_Table_Row_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Table_Row_Properties_Elements.ODF_Style_Table_Row_Properties_Access;

   overriding function Create_Form_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Text_Elements.ODF_Form_Text_Access;

   overriding function Create_Draw_Text_Box_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Text_Box_Elements.ODF_Draw_Text_Box_Access;

   overriding function Create_Number_Text_Content_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Text_Content_Elements.ODF_Number_Text_Content_Access;

   overriding function Create_Style_Text_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Text_Properties_Elements.ODF_Style_Text_Properties_Access;

   overriding function Create_Number_Text_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Text_Style_Elements.ODF_Number_Text_Style_Access;

   overriding function Create_Form_Textarea_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Textarea_Elements.ODF_Form_Textarea_Access;

   overriding function Create_Form_Time_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Time_Elements.ODF_Form_Time_Access;

   overriding function Create_Number_Time_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Time_Style_Elements.ODF_Number_Time_Style_Access;

   overriding function Create_Form_Value_Range_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Value_Range_Elements.ODF_Form_Value_Range_Access;

   overriding function Create_Number_Week_Of_Year_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Week_Of_Year_Elements.ODF_Number_Week_Of_Year_Access;

   overriding function Create_Number_Year_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Year_Elements.ODF_Number_Year_Access;

   overriding function Create_Table_Cut_Offs_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Cut_Offs_Elements.ODF_Table_Cut_Offs_Access;

   overriding function Create_Table_Data_Pilot_Display_Info_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Display_Info_Elements.ODF_Table_Data_Pilot_Display_Info_Access;

   overriding function Create_Table_Data_Pilot_Field_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Field_Elements.ODF_Table_Data_Pilot_Field_Access;

   overriding function Create_Table_Data_Pilot_Field_Reference_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Field_Reference_Elements.ODF_Table_Data_Pilot_Field_Reference_Access;

   overriding function Create_Table_Data_Pilot_Group_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Group_Elements.ODF_Table_Data_Pilot_Group_Access;

   overriding function Create_Table_Data_Pilot_Group_Member_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Group_Member_Elements.ODF_Table_Data_Pilot_Group_Member_Access;

   overriding function Create_Table_Data_Pilot_Groups_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Groups_Elements.ODF_Table_Data_Pilot_Groups_Access;

   overriding function Create_Table_Data_Pilot_Layout_Info_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Layout_Info_Elements.ODF_Table_Data_Pilot_Layout_Info_Access;

   overriding function Create_Table_Data_Pilot_Level_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Level_Elements.ODF_Table_Data_Pilot_Level_Access;

   overriding function Create_Table_Data_Pilot_Member_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Member_Elements.ODF_Table_Data_Pilot_Member_Access;

   overriding function Create_Table_Data_Pilot_Members_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Members_Elements.ODF_Table_Data_Pilot_Members_Access;

   overriding function Create_Table_Data_Pilot_Sort_Info_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Sort_Info_Elements.ODF_Table_Data_Pilot_Sort_Info_Access;

   overriding function Create_Table_Data_Pilot_Subtotal_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Subtotal_Elements.ODF_Table_Data_Pilot_Subtotal_Access;

   overriding function Create_Table_Data_Pilot_Subtotals_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Subtotals_Elements.ODF_Table_Data_Pilot_Subtotals_Access;

   overriding function Create_Table_Data_Pilot_Table_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Table_Elements.ODF_Table_Data_Pilot_Table_Access;

   overriding function Create_Table_Data_Pilot_Tables_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Tables_Elements.ODF_Table_Data_Pilot_Tables_Access;

   overriding function Create_Table_Database_Range_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Database_Range_Elements.ODF_Table_Database_Range_Access;

   overriding function Create_Table_Database_Ranges_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Database_Ranges_Elements.ODF_Table_Database_Ranges_Access;

   overriding function Create_Table_Database_Source_Query_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Database_Source_Query_Elements.ODF_Table_Database_Source_Query_Access;

   overriding function Create_Table_Database_Source_Sql_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Database_Source_Sql_Elements.ODF_Table_Database_Source_Sql_Access;

   overriding function Create_Table_Database_Source_Table_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Database_Source_Table_Elements.ODF_Table_Database_Source_Table_Access;

   overriding function Create_Table_Dde_Links_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Dde_Links_Elements.ODF_Table_Dde_Links_Access;

   overriding function Create_Table_Deletion_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Deletion_Elements.ODF_Table_Deletion_Access;

   overriding function Create_Table_Deletions_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Deletions_Elements.ODF_Table_Deletions_Access;

   overriding function Create_Table_Dependencies_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Dependencies_Elements.ODF_Table_Dependencies_Access;

   overriding function Create_Table_Dependency_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Dependency_Elements.ODF_Table_Dependency_Access;

   overriding function Create_Table_Desc_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Desc_Elements.ODF_Table_Desc_Access;

   overriding function Create_Table_Last_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Last_Column_Elements.ODF_Table_Last_Column_Access;

   overriding function Create_Table_Last_Row_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Last_Row_Elements.ODF_Table_Last_Row_Access;

   overriding function Create_Table_Odd_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Odd_Columns_Elements.ODF_Table_Odd_Columns_Access;

   overriding function Create_Table_Odd_Rows_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Odd_Rows_Elements.ODF_Table_Odd_Rows_Access;

   overriding function Create_Table_Table_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Template_Elements.ODF_Table_Table_Template_Access;

   overriding function Create_Text_Creator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Creator_Elements.ODF_Text_Creator_Access;

   overriding function Create_Text_Database_Display_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Database_Display_Elements.ODF_Text_Database_Display_Access;

   overriding function Create_Text_Database_Name_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Database_Name_Elements.ODF_Text_Database_Name_Access;

   overriding function Create_Text_Database_Next_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Database_Next_Elements.ODF_Text_Database_Next_Access;

   overriding function Create_Text_Database_Row_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Database_Row_Number_Elements.ODF_Text_Database_Row_Number_Access;

   overriding function Create_Text_Database_Row_Select_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Database_Row_Select_Elements.ODF_Text_Database_Row_Select_Access;

   overriding function Create_Dc_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dc_Date_Elements.ODF_Dc_Date_Access;

   overriding function Create_Text_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Date_Elements.ODF_Text_Date_Access;

   overriding function Create_Text_Dde_Connection_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Dde_Connection_Elements.ODF_Text_Dde_Connection_Access;

   overriding function Create_Text_Dde_Connection_Decl_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Dde_Connection_Decl_Elements.ODF_Text_Dde_Connection_Decl_Access;

   overriding function Create_Text_Dde_Connection_Decls_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Dde_Connection_Decls_Elements.ODF_Text_Dde_Connection_Decls_Access;

   overriding function Create_Text_Deletion_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Deletion_Elements.ODF_Text_Deletion_Access;

   overriding function Create_Dc_Description_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dc_Description_Elements.ODF_Dc_Description_Access;

   overriding function Create_Table_Detective_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Detective_Elements.ODF_Table_Detective_Access;

   overriding function Create_Text_Description_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Description_Elements.ODF_Text_Description_Access;

   overriding function Create_Meta_Document_Statistic_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Document_Statistic_Elements.ODF_Meta_Document_Statistic_Access;

   overriding function Create_Meta_Editing_Cycles_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Editing_Cycles_Elements.ODF_Meta_Editing_Cycles_Access;

   overriding function Create_Meta_Editing_Duration_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Editing_Duration_Elements.ODF_Meta_Editing_Duration_Access;

   overriding function Create_Dc_Language_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dc_Language_Elements.ODF_Dc_Language_Access;

   overriding function Create_Dc_Subject_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dc_Subject_Elements.ODF_Dc_Subject_Access;

   overriding function Create_Dc_Title_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dc_Title_Elements.ODF_Dc_Title_Access;

   overriding function Create_Meta_Generator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Generator_Elements.ODF_Meta_Generator_Access;

   overriding function Create_Meta_Hyperlink_Behaviour_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Hyperlink_Behaviour_Elements.ODF_Meta_Hyperlink_Behaviour_Access;

   overriding function Create_Meta_Initial_Creator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Initial_Creator_Elements.ODF_Meta_Initial_Creator_Access;

   overriding function Create_Meta_Keyword_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Keyword_Elements.ODF_Meta_Keyword_Access;

   overriding function Create_Meta_Print_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Print_Date_Elements.ODF_Meta_Print_Date_Access;

   overriding function Create_Meta_Printed_By_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Printed_By_Elements.ODF_Meta_Printed_By_Access;

   overriding function Create_Meta_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Template_Elements.ODF_Meta_Template_Access;

   overriding function Create_Meta_User_Defined_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_User_Defined_Elements.ODF_Meta_User_Defined_Access;

   overriding function Create_Office_Body_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Body_Elements.ODF_Office_Body_Access;

   overriding function Create_Office_Chart_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Chart_Elements.ODF_Office_Chart_Access;

   overriding function Create_Office_Document_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Document_Elements.ODF_Office_Document_Access;

   overriding function Create_Office_Document_Content_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Document_Content_Elements.ODF_Office_Document_Content_Access;

   overriding function Create_Office_Document_Meta_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Document_Meta_Elements.ODF_Office_Document_Meta_Access;

   overriding function Create_Office_Document_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Document_Settings_Elements.ODF_Office_Document_Settings_Access;

   overriding function Create_Office_Document_Styles_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Document_Styles_Elements.ODF_Office_Document_Styles_Access;

   overriding function Create_Office_Drawing_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Drawing_Elements.ODF_Office_Drawing_Access;

   overriding function Create_Style_Handout_Master_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Handout_Master_Elements.ODF_Style_Handout_Master_Access;

   overriding function Create_Table_Error_Macro_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Error_Macro_Elements.ODF_Table_Error_Macro_Access;

   overriding function Create_Table_Error_Message_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Error_Message_Elements.ODF_Table_Error_Message_Access;

   overriding function Create_Table_Filter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Filter_Elements.ODF_Table_Filter_Access;

   overriding function Create_Table_Filter_And_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Filter_And_Elements.ODF_Table_Filter_And_Access;

   overriding function Create_Table_Filter_Condition_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Filter_Condition_Elements.ODF_Table_Filter_Condition_Access;

   overriding function Create_Table_Filter_Or_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Filter_Or_Elements.ODF_Table_Filter_Or_Access;

   overriding function Create_Table_Filter_Set_Item_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Filter_Set_Item_Elements.ODF_Table_Filter_Set_Item_Access;

   overriding function Create_Table_Help_Message_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Help_Message_Elements.ODF_Table_Help_Message_Access;

   overriding function Create_Table_Highlighted_Range_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Highlighted_Range_Elements.ODF_Table_Highlighted_Range_Access;

   overriding function Create_Text_Editing_Cycles_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Editing_Cycles_Elements.ODF_Text_Editing_Cycles_Access;

   overriding function Create_Text_Editing_Duration_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Editing_Duration_Elements.ODF_Text_Editing_Duration_Access;

   overriding function Create_Text_Execute_Macro_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Execute_Macro_Elements.ODF_Text_Execute_Macro_Access;

   overriding function Create_Text_Expression_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Expression_Elements.ODF_Text_Expression_Access;

   overriding function Create_Text_File_Name_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_File_Name_Elements.ODF_Text_File_Name_Access;

   overriding function Create_Office_Font_Face_Decls_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Font_Face_Decls_Elements.ODF_Office_Font_Face_Decls_Access;

   overriding function Create_Text_Format_Change_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Format_Change_Elements.ODF_Text_Format_Change_Access;

   overriding function Create_Text_H_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_H_Elements.ODF_Text_H_Access;

   overriding function Create_Text_Hidden_Paragraph_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Hidden_Paragraph_Elements.ODF_Text_Hidden_Paragraph_Access;

   overriding function Create_Text_Hidden_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Hidden_Text_Elements.ODF_Text_Hidden_Text_Access;

   overriding function Create_Text_Illustration_Index_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Illustration_Index_Elements.ODF_Text_Illustration_Index_Access;

   overriding function Create_Text_Illustration_Index_Entry_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Illustration_Index_Entry_Template_Elements.ODF_Text_Illustration_Index_Entry_Template_Access;

   overriding function Create_Text_Illustration_Index_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Illustration_Index_Source_Elements.ODF_Text_Illustration_Index_Source_Access;

   overriding function Create_Office_Image_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Image_Elements.ODF_Office_Image_Access;

   overriding function Create_Table_Insertion_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Insertion_Elements.ODF_Table_Insertion_Access;

   overriding function Create_Table_Insertion_Cut_Off_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Insertion_Cut_Off_Elements.ODF_Table_Insertion_Cut_Off_Access;

   overriding function Create_Table_Iteration_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Iteration_Elements.ODF_Table_Iteration_Access;

   overriding function Create_Table_Label_Range_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Label_Range_Elements.ODF_Table_Label_Range_Access;

   overriding function Create_Table_Label_Ranges_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Label_Ranges_Elements.ODF_Table_Label_Ranges_Access;

   overriding function Create_Text_Image_Count_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Image_Count_Elements.ODF_Text_Image_Count_Access;

   overriding function Create_Text_Index_Body_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Body_Elements.ODF_Text_Index_Body_Access;

   overriding function Create_Text_Index_Entry_Bibliography_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Bibliography_Elements.ODF_Text_Index_Entry_Bibliography_Access;

   overriding function Create_Text_Index_Entry_Chapter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Chapter_Elements.ODF_Text_Index_Entry_Chapter_Access;

   overriding function Create_Text_Index_Entry_Link_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Link_End_Elements.ODF_Text_Index_Entry_Link_End_Access;

   overriding function Create_Text_Index_Entry_Link_Start_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Link_Start_Elements.ODF_Text_Index_Entry_Link_Start_Access;

   overriding function Create_Text_Index_Entry_Page_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Page_Number_Elements.ODF_Text_Index_Entry_Page_Number_Access;

   overriding function Create_Text_Index_Entry_Span_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Span_Elements.ODF_Text_Index_Entry_Span_Access;

   overriding function Create_Text_Index_Entry_Tab_Stop_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Tab_Stop_Elements.ODF_Text_Index_Entry_Tab_Stop_Access;

   overriding function Create_Text_Index_Entry_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Text_Elements.ODF_Text_Index_Entry_Text_Access;

   overriding function Create_Text_Index_Source_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Source_Style_Elements.ODF_Text_Index_Source_Style_Access;

   overriding function Create_Text_Index_Source_Styles_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Source_Styles_Elements.ODF_Text_Index_Source_Styles_Access;

   overriding function Create_Text_Index_Title_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Title_Elements.ODF_Text_Index_Title_Access;

   overriding function Create_Text_Index_Title_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Title_Template_Elements.ODF_Text_Index_Title_Template_Access;

   overriding function Create_Text_Initial_Creator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Initial_Creator_Elements.ODF_Text_Initial_Creator_Access;

   overriding function Create_Text_Insertion_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Insertion_Elements.ODF_Text_Insertion_Access;

   overriding function Create_Text_Keywords_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Keywords_Elements.ODF_Text_Keywords_Access;

   overriding function Create_Text_Line_Break_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Line_Break_Elements.ODF_Text_Line_Break_Access;

   overriding function Create_Text_Linenumbering_Configuration_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Linenumbering_Configuration_Elements.ODF_Text_Linenumbering_Configuration_Access;

   overriding function Create_Text_Linenumbering_Separator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Linenumbering_Separator_Elements.ODF_Text_Linenumbering_Separator_Access;

   overriding function Create_Text_List_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_List_Elements.ODF_Text_List_Access;

   overriding function Create_Text_List_Header_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_List_Header_Elements.ODF_Text_List_Header_Access;

   overriding function Create_Text_List_Item_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_List_Item_Elements.ODF_Text_List_Item_Access;

   overriding function Create_Text_List_Level_Style_Bullet_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_List_Level_Style_Bullet_Elements.ODF_Text_List_Level_Style_Bullet_Access;

   overriding function Create_Text_List_Level_Style_Image_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_List_Level_Style_Image_Elements.ODF_Text_List_Level_Style_Image_Access;

   overriding function Create_Text_List_Level_Style_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_List_Level_Style_Number_Elements.ODF_Text_List_Level_Style_Number_Access;

   overriding function Create_Text_List_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_List_Style_Elements.ODF_Text_List_Style_Access;

   overriding function Create_Office_Master_Styles_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Master_Styles_Elements.ODF_Office_Master_Styles_Access;

   overriding function Create_Text_Measure_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Measure_Elements.ODF_Text_Measure_Access;

   overriding function Create_Office_Meta_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Meta_Elements.ODF_Office_Meta_Access;

   overriding function Create_Presentation_Play_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Play_Elements.ODF_Presentation_Play_Access;

   overriding function Create_Presentation_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Settings_Elements.ODF_Presentation_Settings_Access;

   overriding function Create_Presentation_Show_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Show_Elements.ODF_Presentation_Show_Access;

   overriding function Create_Presentation_Show_Shape_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Show_Shape_Elements.ODF_Presentation_Show_Shape_Access;

   overriding function Create_Presentation_Show_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Show_Text_Elements.ODF_Presentation_Show_Text_Access;

   overriding function Create_Presentation_Sound_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Sound_Elements.ODF_Presentation_Sound_Access;

   overriding function Create_Svg_Title_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Title_Elements.ODF_Svg_Title_Access;

   overriding function Create_Table_Movement_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Movement_Elements.ODF_Table_Movement_Access;

   overriding function Create_Table_Movement_Cut_Off_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Movement_Cut_Off_Elements.ODF_Table_Movement_Cut_Off_Access;

   overriding function Create_Table_Named_Expression_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Named_Expression_Elements.ODF_Table_Named_Expression_Access;

   overriding function Create_Table_Named_Expressions_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Named_Expressions_Elements.ODF_Table_Named_Expressions_Access;

   overriding function Create_Table_Named_Range_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Named_Range_Elements.ODF_Table_Named_Range_Access;

   overriding function Create_Table_Null_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Null_Date_Elements.ODF_Table_Null_Date_Access;

   overriding function Create_Table_Operation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Operation_Elements.ODF_Table_Operation_Access;

   overriding function Create_Table_Previous_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Previous_Elements.ODF_Table_Previous_Access;

   overriding function Create_Table_Scenario_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Scenario_Elements.ODF_Table_Scenario_Access;

   overriding function Create_Table_Shapes_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Shapes_Elements.ODF_Table_Shapes_Access;

   overriding function Create_Table_Sort_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Sort_Elements.ODF_Table_Sort_Access;

   overriding function Create_Table_Sort_By_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Sort_By_Elements.ODF_Table_Sort_By_Access;

   overriding function Create_Table_Sort_Groups_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Sort_Groups_Elements.ODF_Table_Sort_Groups_Access;

   overriding function Create_Table_Source_Cell_Range_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Source_Cell_Range_Elements.ODF_Table_Source_Cell_Range_Access;

   overriding function Create_Table_Source_Range_Address_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Source_Range_Address_Elements.ODF_Table_Source_Range_Address_Access;

   overriding function Create_Table_Source_Service_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Source_Service_Elements.ODF_Table_Source_Service_Access;

   overriding function Create_Table_Subtotal_Field_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Subtotal_Field_Elements.ODF_Table_Subtotal_Field_Access;

   overriding function Create_Table_Subtotal_Rule_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Subtotal_Rule_Elements.ODF_Table_Subtotal_Rule_Access;

   overriding function Create_Table_Subtotal_Rules_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Subtotal_Rules_Elements.ODF_Table_Subtotal_Rules_Access;

   overriding function Create_Table_Table_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Elements.ODF_Table_Table_Access;

   overriding function Create_Table_Table_Cell_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Cell_Elements.ODF_Table_Table_Cell_Access;

   overriding function Create_Table_Table_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Column_Elements.ODF_Table_Table_Column_Access;

   overriding function Create_Table_Table_Column_Group_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Column_Group_Elements.ODF_Table_Table_Column_Group_Access;

   overriding function Create_Table_Table_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Columns_Elements.ODF_Table_Table_Columns_Access;

   overriding function Create_Table_Table_Header_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Header_Columns_Elements.ODF_Table_Table_Header_Columns_Access;

   overriding function Create_Table_Table_Header_Rows_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Header_Rows_Elements.ODF_Table_Table_Header_Rows_Access;

   overriding function Create_Table_Table_Row_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Row_Elements.ODF_Table_Table_Row_Access;

   overriding function Create_Table_Table_Row_Group_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Row_Group_Elements.ODF_Table_Table_Row_Group_Access;

   overriding function Create_Table_Table_Rows_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Rows_Elements.ODF_Table_Table_Rows_Access;

   overriding function Create_Table_Table_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Source_Elements.ODF_Table_Table_Source_Access;

   overriding function Create_Table_Target_Range_Address_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Target_Range_Address_Elements.ODF_Table_Target_Range_Address_Access;

   overriding function Create_Table_Title_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Title_Elements.ODF_Table_Title_Access;

   overriding function Create_Table_Tracked_Changes_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Tracked_Changes_Elements.ODF_Table_Tracked_Changes_Access;

   overriding function Create_Text_Meta_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Meta_Elements.ODF_Text_Meta_Access;

   overriding function Create_Text_Meta_Field_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Meta_Field_Elements.ODF_Text_Meta_Field_Access;

   overriding function Create_Xforms_Model_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Xforms_Model_Elements.ODF_Xforms_Model_Access;

   overriding function Create_Text_Modification_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Modification_Date_Elements.ODF_Text_Modification_Date_Access;

   overriding function Create_Text_Modification_Time_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Modification_Time_Elements.ODF_Text_Modification_Time_Access;

   overriding function Create_Text_Note_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Note_Elements.ODF_Text_Note_Access;

   overriding function Create_Text_Note_Body_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Note_Body_Elements.ODF_Text_Note_Body_Access;

   overriding function Create_Text_Note_Citation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Note_Citation_Elements.ODF_Text_Note_Citation_Access;

   overriding function Create_Text_Note_Continuation_Notice_Backward_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Note_Continuation_Notice_Backward_Elements.ODF_Text_Note_Continuation_Notice_Backward_Access;

   overriding function Create_Text_Note_Continuation_Notice_Forward_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Note_Continuation_Notice_Forward_Elements.ODF_Text_Note_Continuation_Notice_Forward_Access;

   overriding function Create_Text_Note_Ref_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Note_Ref_Elements.ODF_Text_Note_Ref_Access;

   overriding function Create_Text_Notes_Configuration_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Notes_Configuration_Elements.ODF_Text_Notes_Configuration_Access;

   overriding function Create_Text_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Number_Elements.ODF_Text_Number_Access;

   overriding function Create_Text_Numbered_Paragraph_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Numbered_Paragraph_Elements.ODF_Text_Numbered_Paragraph_Access;

   overriding function Create_Text_Object_Count_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Object_Count_Elements.ODF_Text_Object_Count_Access;

   overriding function Create_Text_Object_Index_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Object_Index_Elements.ODF_Text_Object_Index_Access;

   overriding function Create_Text_Object_Index_Entry_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Object_Index_Entry_Template_Elements.ODF_Text_Object_Index_Entry_Template_Access;

   overriding function Create_Text_Object_Index_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Object_Index_Source_Elements.ODF_Text_Object_Index_Source_Access;

   overriding function Create_Text_Outline_Level_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Outline_Level_Style_Elements.ODF_Text_Outline_Level_Style_Access;

   overriding function Create_Text_Outline_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Outline_Style_Elements.ODF_Text_Outline_Style_Access;

   overriding function Create_Text_P_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_P_Elements.ODF_Text_P_Access;

   overriding function Create_Text_Page_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Page_Elements.ODF_Text_Page_Access;

   overriding function Create_Text_Page_Continuation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Page_Continuation_Elements.ODF_Text_Page_Continuation_Access;

   overriding function Create_Text_Page_Count_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Page_Count_Elements.ODF_Text_Page_Count_Access;

   overriding function Create_Text_Page_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Page_Number_Elements.ODF_Text_Page_Number_Access;

   overriding function Create_Text_Page_Sequence_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Page_Sequence_Elements.ODF_Text_Page_Sequence_Access;

   overriding function Create_Text_Page_Variable_Get_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Page_Variable_Get_Elements.ODF_Text_Page_Variable_Get_Access;

   overriding function Create_Text_Page_Variable_Set_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Page_Variable_Set_Elements.ODF_Text_Page_Variable_Set_Access;

   overriding function Create_Text_Paragraph_Count_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Paragraph_Count_Elements.ODF_Text_Paragraph_Count_Access;

   overriding function Create_Text_Placeholder_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Placeholder_Elements.ODF_Text_Placeholder_Access;

   overriding function Create_Office_Presentation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Presentation_Elements.ODF_Office_Presentation_Access;

   overriding function Create_Text_Print_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Print_Date_Elements.ODF_Text_Print_Date_Access;

   overriding function Create_Text_Print_Time_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Print_Time_Elements.ODF_Text_Print_Time_Access;

   overriding function Create_Text_Printed_By_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Printed_By_Elements.ODF_Text_Printed_By_Access;

   overriding function Create_Text_Reference_Mark_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Reference_Mark_Elements.ODF_Text_Reference_Mark_Access;

   overriding function Create_Text_Reference_Mark_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Reference_Mark_End_Elements.ODF_Text_Reference_Mark_End_Access;

   overriding function Create_Text_Reference_Mark_Start_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Reference_Mark_Start_Elements.ODF_Text_Reference_Mark_Start_Access;

   overriding function Create_Text_Reference_Ref_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Reference_Ref_Elements.ODF_Text_Reference_Ref_Access;

   overriding function Create_Text_Ruby_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Ruby_Elements.ODF_Text_Ruby_Access;

   overriding function Create_Text_Ruby_Base_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Ruby_Base_Elements.ODF_Text_Ruby_Base_Access;

   overriding function Create_Text_Ruby_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Ruby_Text_Elements.ODF_Text_Ruby_Text_Access;

   overriding function Create_Text_S_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_S_Elements.ODF_Text_S_Access;

   overriding function Create_Office_Script_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Script_Elements.ODF_Office_Script_Access;

   overriding function Create_Text_Script_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Script_Elements.ODF_Text_Script_Access;

   overriding function Create_Office_Scripts_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Scripts_Elements.ODF_Office_Scripts_Access;

   overriding function Create_Text_Section_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Section_Elements.ODF_Text_Section_Access;

   overriding function Create_Text_Section_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Section_Source_Elements.ODF_Text_Section_Source_Access;

   overriding function Create_Text_Sender_City_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_City_Elements.ODF_Text_Sender_City_Access;

   overriding function Create_Text_Sender_Company_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Company_Elements.ODF_Text_Sender_Company_Access;

   overriding function Create_Text_Sender_Country_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Country_Elements.ODF_Text_Sender_Country_Access;

   overriding function Create_Text_Sender_Email_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Email_Elements.ODF_Text_Sender_Email_Access;

   overriding function Create_Text_Sender_Fax_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Fax_Elements.ODF_Text_Sender_Fax_Access;

   overriding function Create_Text_Sender_Firstname_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Firstname_Elements.ODF_Text_Sender_Firstname_Access;

   overriding function Create_Text_Sender_Initials_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Initials_Elements.ODF_Text_Sender_Initials_Access;

   overriding function Create_Text_Sender_Lastname_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Lastname_Elements.ODF_Text_Sender_Lastname_Access;

   overriding function Create_Text_Sender_Phone_Private_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Phone_Private_Elements.ODF_Text_Sender_Phone_Private_Access;

   overriding function Create_Text_Sender_Phone_Work_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Phone_Work_Elements.ODF_Text_Sender_Phone_Work_Access;

   overriding function Create_Text_Sender_Position_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Position_Elements.ODF_Text_Sender_Position_Access;

   overriding function Create_Text_Sender_Postal_Code_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Postal_Code_Elements.ODF_Text_Sender_Postal_Code_Access;

   overriding function Create_Text_Sender_State_Or_Province_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_State_Or_Province_Elements.ODF_Text_Sender_State_Or_Province_Access;

   overriding function Create_Text_Sender_Street_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Street_Elements.ODF_Text_Sender_Street_Access;

   overriding function Create_Text_Sender_Title_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Title_Elements.ODF_Text_Sender_Title_Access;

   overriding function Create_Text_Sequence_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sequence_Elements.ODF_Text_Sequence_Access;

   overriding function Create_Text_Sequence_Decl_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sequence_Decl_Elements.ODF_Text_Sequence_Decl_Access;

   overriding function Create_Text_Sequence_Decls_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sequence_Decls_Elements.ODF_Text_Sequence_Decls_Access;

   overriding function Create_Text_Sequence_Ref_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sequence_Ref_Elements.ODF_Text_Sequence_Ref_Access;

   overriding function Create_Office_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Settings_Elements.ODF_Office_Settings_Access;

   overriding function Create_Text_Sheet_Name_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sheet_Name_Elements.ODF_Text_Sheet_Name_Access;

   overriding function Create_Text_Soft_Page_Break_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Soft_Page_Break_Elements.ODF_Text_Soft_Page_Break_Access;

   overriding function Create_Text_Sort_Key_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sort_Key_Elements.ODF_Text_Sort_Key_Access;

   overriding function Create_Text_Span_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Span_Elements.ODF_Text_Span_Access;

   overriding function Create_Office_Spreadsheet_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Spreadsheet_Elements.ODF_Office_Spreadsheet_Access;

   overriding function Create_Office_Styles_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Styles_Elements.ODF_Office_Styles_Access;

   overriding function Create_Text_Subject_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Subject_Elements.ODF_Text_Subject_Access;

   overriding function Create_Text_Tab_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Tab_Elements.ODF_Text_Tab_Access;

   overriding function Create_Text_Table_Count_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Count_Elements.ODF_Text_Table_Count_Access;

   overriding function Create_Text_Table_Formula_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Formula_Elements.ODF_Text_Table_Formula_Access;

   overriding function Create_Text_Table_Index_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Index_Elements.ODF_Text_Table_Index_Access;

   overriding function Create_Text_Table_Index_Entry_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Index_Entry_Template_Elements.ODF_Text_Table_Index_Entry_Template_Access;

   overriding function Create_Text_Table_Index_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Index_Source_Elements.ODF_Text_Table_Index_Source_Access;

   overriding function Create_Text_Table_Of_Content_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Of_Content_Elements.ODF_Text_Table_Of_Content_Access;

   overriding function Create_Text_Table_Of_Content_Entry_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Of_Content_Entry_Template_Elements.ODF_Text_Table_Of_Content_Entry_Template_Access;

   overriding function Create_Text_Table_Of_Content_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Of_Content_Source_Elements.ODF_Text_Table_Of_Content_Source_Access;

   overriding function Create_Text_Template_Name_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Template_Name_Elements.ODF_Text_Template_Name_Access;

   overriding function Create_Office_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Text_Elements.ODF_Office_Text_Access;

   overriding function Create_Text_Text_Input_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Text_Input_Elements.ODF_Text_Text_Input_Access;

   overriding function Create_Text_Time_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Time_Elements.ODF_Text_Time_Access;

   overriding function Create_Text_Title_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Title_Elements.ODF_Text_Title_Access;

   overriding function Create_Text_Toc_Mark_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Toc_Mark_Elements.ODF_Text_Toc_Mark_Access;

   overriding function Create_Text_Toc_Mark_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Toc_Mark_End_Elements.ODF_Text_Toc_Mark_End_Access;

   overriding function Create_Text_Toc_Mark_Start_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Toc_Mark_Start_Elements.ODF_Text_Toc_Mark_Start_Access;

   overriding function Create_Text_Tracked_Changes_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Tracked_Changes_Elements.ODF_Text_Tracked_Changes_Access;

   overriding function Create_Text_User_Defined_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Defined_Elements.ODF_Text_User_Defined_Access;

   overriding function Create_Text_User_Field_Decl_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Field_Decl_Elements.ODF_Text_User_Field_Decl_Access;

   overriding function Create_Text_User_Field_Decls_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Field_Decls_Elements.ODF_Text_User_Field_Decls_Access;

   overriding function Create_Text_User_Field_Get_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Field_Get_Elements.ODF_Text_User_Field_Get_Access;

   overriding function Create_Text_User_Field_Input_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Field_Input_Elements.ODF_Text_User_Field_Input_Access;

   overriding function Create_Text_User_Index_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Index_Elements.ODF_Text_User_Index_Access;

   overriding function Create_Text_User_Index_Entry_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Index_Entry_Template_Elements.ODF_Text_User_Index_Entry_Template_Access;

   overriding function Create_Text_User_Index_Mark_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Index_Mark_Elements.ODF_Text_User_Index_Mark_Access;

   overriding function Create_Text_User_Index_Mark_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Index_Mark_End_Elements.ODF_Text_User_Index_Mark_End_Access;

   overriding function Create_Text_User_Index_Mark_Start_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Index_Mark_Start_Elements.ODF_Text_User_Index_Mark_Start_Access;

   overriding function Create_Text_User_Index_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Index_Source_Elements.ODF_Text_User_Index_Source_Access;

   overriding function Create_Text_Variable_Decl_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Variable_Decl_Elements.ODF_Text_Variable_Decl_Access;

   overriding function Create_Text_Variable_Decls_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Variable_Decls_Elements.ODF_Text_Variable_Decls_Access;

   overriding function Create_Text_Variable_Get_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Variable_Get_Elements.ODF_Text_Variable_Get_Access;

   overriding function Create_Text_Variable_Input_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Variable_Input_Elements.ODF_Text_Variable_Input_Access;

   overriding function Create_Text_Variable_Set_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Variable_Set_Elements.ODF_Text_Variable_Set_Access;

   overriding function Create_Text_Word_Count_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Word_Count_Elements.ODF_Text_Word_Count_Access;

end Matreshka.ODF_Documents;
