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
with XML.DOM.Visitors;

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

package ODF.DOM.Visitors is

   pragma Preelaborate;

   type Abstract_ODF_Visitor is limited interface
     and XML.DOM.Visitors.Abstract_Visitor;

   not overriding procedure Enter_Number_Am_Pm
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Am_Pm_Elements.ODF_Number_Am_Pm_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Am_Pm
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Am_Pm_Elements.ODF_Number_Am_Pm_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Anim_Animate
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Animate_Elements.ODF_Anim_Animate_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Anim_Animate
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Animate_Elements.ODF_Anim_Animate_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Anim_AnimateColor
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_AnimateColor_Elements.ODF_Anim_AnimateColor_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Anim_AnimateColor
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_AnimateColor_Elements.ODF_Anim_AnimateColor_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Anim_AnimateMotion
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_AnimateMotion_Elements.ODF_Anim_AnimateMotion_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Anim_AnimateMotion
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_AnimateMotion_Elements.ODF_Anim_AnimateMotion_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Anim_AnimateTransform
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_AnimateTransform_Elements.ODF_Anim_AnimateTransform_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Anim_AnimateTransform
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_AnimateTransform_Elements.ODF_Anim_AnimateTransform_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Anim_Audio
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Audio_Elements.ODF_Anim_Audio_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Anim_Audio
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Audio_Elements.ODF_Anim_Audio_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Anim_Command
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Command_Elements.ODF_Anim_Command_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Anim_Command
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Command_Elements.ODF_Anim_Command_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Anim_Iterate
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Iterate_Elements.ODF_Anim_Iterate_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Anim_Iterate
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Iterate_Elements.ODF_Anim_Iterate_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Anim_Par
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Par_Elements.ODF_Anim_Par_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Anim_Par
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Par_Elements.ODF_Anim_Par_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Anim_Param
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Param_Elements.ODF_Anim_Param_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Anim_Param
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Param_Elements.ODF_Anim_Param_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Anim_Seq
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Seq_Elements.ODF_Anim_Seq_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Anim_Seq
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Seq_Elements.ODF_Anim_Seq_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Anim_Set
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Set_Elements.ODF_Anim_Set_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Anim_Set
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_Set_Elements.ODF_Anim_Set_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Anim_TransitionFilter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_TransitionFilter_Elements.ODF_Anim_TransitionFilter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Anim_TransitionFilter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Anim_TransitionFilter_Elements.ODF_Anim_TransitionFilter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Annotation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Annotation_Elements.ODF_Office_Annotation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Annotation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Annotation_Elements.ODF_Office_Annotation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Annotation_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Annotation_End_Elements.ODF_Office_Annotation_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Annotation_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Annotation_End_Elements.ODF_Office_Annotation_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Application_Connection_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Application_Connection_Settings_Elements.ODF_Db_Application_Connection_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Application_Connection_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Application_Connection_Settings_Elements.ODF_Db_Application_Connection_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Auto_Increment
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Auto_Increment_Elements.ODF_Db_Auto_Increment_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Auto_Increment
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Auto_Increment_Elements.ODF_Db_Auto_Increment_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Axis
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Axis_Elements.ODF_Chart_Axis_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Axis
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Axis_Elements.ODF_Chart_Axis_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Boolean
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Boolean_Elements.ODF_Number_Boolean_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Boolean
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Boolean_Elements.ODF_Number_Boolean_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Boolean_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Boolean_Style_Elements.ODF_Number_Boolean_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Boolean_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Boolean_Style_Elements.ODF_Number_Boolean_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Button
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Button_Elements.ODF_Form_Button_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Button
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Button_Elements.ODF_Form_Button_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Categories
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Categories_Elements.ODF_Chart_Categories_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Categories
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Categories_Elements.ODF_Chart_Categories_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Character_Set
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Character_Set_Elements.ODF_Db_Character_Set_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Character_Set
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Character_Set_Elements.ODF_Db_Character_Set_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Chart
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Chart_Elements.ODF_Chart_Chart_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Chart
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Chart_Elements.ODF_Chart_Chart_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Checkbox
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Checkbox_Elements.ODF_Form_Checkbox_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Checkbox
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Checkbox_Elements.ODF_Form_Checkbox_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Column_Elements.ODF_Db_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Column_Elements.ODF_Db_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Column_Elements.ODF_Form_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Column_Elements.ODF_Form_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Column_Definition
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Column_Definition_Elements.ODF_Db_Column_Definition_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Column_Definition
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Column_Definition_Elements.ODF_Db_Column_Definition_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Column_Definitions
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Column_Definitions_Elements.ODF_Db_Column_Definitions_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Column_Definitions
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Column_Definitions_Elements.ODF_Db_Column_Definitions_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Columns_Elements.ODF_Db_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Columns_Elements.ODF_Db_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Combobox
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Combobox_Elements.ODF_Form_Combobox_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Combobox
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Combobox_Elements.ODF_Form_Combobox_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Component
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Component_Elements.ODF_Db_Component_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Component
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Component_Elements.ODF_Db_Component_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Component_Collection
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Component_Collection_Elements.ODF_Db_Component_Collection_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Component_Collection
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Component_Collection_Elements.ODF_Db_Component_Collection_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Data_Label
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Data_Label_Elements.ODF_Chart_Data_Label_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Data_Label
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Data_Label_Elements.ODF_Chart_Data_Label_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Data_Point
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Data_Point_Elements.ODF_Chart_Data_Point_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Data_Point
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Data_Point_Elements.ODF_Chart_Data_Point_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Domain
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Domain_Elements.ODF_Chart_Domain_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Domain
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Domain_Elements.ODF_Chart_Domain_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Equation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Equation_Elements.ODF_Chart_Equation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Equation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Equation_Elements.ODF_Chart_Equation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Error_Indicator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Error_Indicator_Elements.ODF_Chart_Error_Indicator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Error_Indicator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Error_Indicator_Elements.ODF_Chart_Error_Indicator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Floor
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Floor_Elements.ODF_Chart_Floor_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Floor
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Floor_Elements.ODF_Chart_Floor_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Footer
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Footer_Elements.ODF_Chart_Footer_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Footer
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Footer_Elements.ODF_Chart_Footer_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Grid
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Grid_Elements.ODF_Chart_Grid_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Grid
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Grid_Elements.ODF_Chart_Grid_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Label_Separator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Label_Separator_Elements.ODF_Chart_Label_Separator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Label_Separator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Label_Separator_Elements.ODF_Chart_Label_Separator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Legend
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Legend_Elements.ODF_Chart_Legend_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Legend
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Legend_Elements.ODF_Chart_Legend_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Mean_Value
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Mean_Value_Elements.ODF_Chart_Mean_Value_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Mean_Value
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Mean_Value_Elements.ODF_Chart_Mean_Value_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Plot_Area
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Plot_Area_Elements.ODF_Chart_Plot_Area_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Plot_Area
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Plot_Area_Elements.ODF_Chart_Plot_Area_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Regression_Curve
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Regression_Curve_Elements.ODF_Chart_Regression_Curve_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Regression_Curve
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Regression_Curve_Elements.ODF_Chart_Regression_Curve_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Series
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Series_Elements.ODF_Chart_Series_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Series
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Series_Elements.ODF_Chart_Series_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Stock_Gain_Marker
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Stock_Gain_Marker_Elements.ODF_Chart_Stock_Gain_Marker_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Stock_Gain_Marker
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Stock_Gain_Marker_Elements.ODF_Chart_Stock_Gain_Marker_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Stock_Loss_Marker
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Stock_Loss_Marker_Elements.ODF_Chart_Stock_Loss_Marker_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Stock_Loss_Marker
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Stock_Loss_Marker_Elements.ODF_Chart_Stock_Loss_Marker_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Stock_Range_Line
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Stock_Range_Line_Elements.ODF_Chart_Stock_Range_Line_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Stock_Range_Line
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Stock_Range_Line_Elements.ODF_Chart_Stock_Range_Line_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Subtitle
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Subtitle_Elements.ODF_Chart_Subtitle_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Subtitle
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Subtitle_Elements.ODF_Chart_Subtitle_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Symbol_Image
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Symbol_Image_Elements.ODF_Chart_Symbol_Image_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Symbol_Image
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Symbol_Image_Elements.ODF_Chart_Symbol_Image_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Title
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Title_Elements.ODF_Chart_Title_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Title
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Title_Elements.ODF_Chart_Title_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Chart_Wall
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Wall_Elements.ODF_Chart_Wall_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Chart_Wall
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Chart_Wall_Elements.ODF_Chart_Wall_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_A
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_A_Elements.ODF_Draw_A_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_A
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_A_Elements.ODF_Draw_A_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Animation_Group
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Animation_Group_Elements.ODF_Presentation_Animation_Group_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Animation_Group
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Animation_Group_Elements.ODF_Presentation_Animation_Group_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Animations
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Animations_Elements.ODF_Presentation_Animations_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Animations
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Animations_Elements.ODF_Presentation_Animations_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Applet
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Applet_Elements.ODF_Draw_Applet_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Applet
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Applet_Elements.ODF_Draw_Applet_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Area_Circle
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Area_Circle_Elements.ODF_Draw_Area_Circle_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Area_Circle
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Area_Circle_Elements.ODF_Draw_Area_Circle_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Area_Polygon
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Area_Polygon_Elements.ODF_Draw_Area_Polygon_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Area_Polygon
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Area_Polygon_Elements.ODF_Draw_Area_Polygon_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Area_Rectangle
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Area_Rectangle_Elements.ODF_Draw_Area_Rectangle_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Area_Rectangle
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Area_Rectangle_Elements.ODF_Draw_Area_Rectangle_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Caption
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Caption_Elements.ODF_Draw_Caption_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Caption
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Caption_Elements.ODF_Draw_Caption_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Circle
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Circle_Elements.ODF_Draw_Circle_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Circle
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Circle_Elements.ODF_Draw_Circle_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_A
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_A_Elements.ODF_Text_A_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_A
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_A_Elements.ODF_Text_A_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Alphabetical_Index
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Alphabetical_Index_Elements.ODF_Text_Alphabetical_Index_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Alphabetical_Index
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Alphabetical_Index_Elements.ODF_Text_Alphabetical_Index_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Alphabetical_Index_Auto_Mark_File
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Alphabetical_Index_Auto_Mark_File_Elements.ODF_Text_Alphabetical_Index_Auto_Mark_File_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Alphabetical_Index_Auto_Mark_File
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Alphabetical_Index_Auto_Mark_File_Elements.ODF_Text_Alphabetical_Index_Auto_Mark_File_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Alphabetical_Index_Entry_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Alphabetical_Index_Entry_Template_Elements.ODF_Text_Alphabetical_Index_Entry_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Alphabetical_Index_Entry_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Alphabetical_Index_Entry_Template_Elements.ODF_Text_Alphabetical_Index_Entry_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Alphabetical_Index_Mark
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Alphabetical_Index_Mark_Elements.ODF_Text_Alphabetical_Index_Mark_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Alphabetical_Index_Mark
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Alphabetical_Index_Mark_Elements.ODF_Text_Alphabetical_Index_Mark_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Alphabetical_Index_Mark_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Alphabetical_Index_Mark_End_Elements.ODF_Text_Alphabetical_Index_Mark_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Alphabetical_Index_Mark_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Alphabetical_Index_Mark_End_Elements.ODF_Text_Alphabetical_Index_Mark_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Alphabetical_Index_Mark_Start
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Alphabetical_Index_Mark_Start_Elements.ODF_Text_Alphabetical_Index_Mark_Start_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Alphabetical_Index_Mark_Start
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Alphabetical_Index_Mark_Start_Elements.ODF_Text_Alphabetical_Index_Mark_Start_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Alphabetical_Index_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Alphabetical_Index_Source_Elements.ODF_Text_Alphabetical_Index_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Alphabetical_Index_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Alphabetical_Index_Source_Elements.ODF_Text_Alphabetical_Index_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Author_Initials
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Author_Initials_Elements.ODF_Text_Author_Initials_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Author_Initials
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Author_Initials_Elements.ODF_Text_Author_Initials_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Author_Name
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Author_Name_Elements.ODF_Text_Author_Name_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Author_Name
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Author_Name_Elements.ODF_Text_Author_Name_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Meta_Auto_Reload
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Auto_Reload_Elements.ODF_Meta_Auto_Reload_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Meta_Auto_Reload
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Auto_Reload_Elements.ODF_Meta_Auto_Reload_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Automatic_Styles
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Automatic_Styles_Elements.ODF_Office_Automatic_Styles_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Automatic_Styles
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Automatic_Styles_Elements.ODF_Office_Automatic_Styles_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Background_Image
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Background_Image_Elements.ODF_Style_Background_Image_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Background_Image
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Background_Image_Elements.ODF_Style_Background_Image_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Chart_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Chart_Properties_Elements.ODF_Style_Chart_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Chart_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Chart_Properties_Elements.ODF_Style_Chart_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Column_Elements.ODF_Style_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Column_Elements.ODF_Style_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Column_Sep
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Column_Sep_Elements.ODF_Style_Column_Sep_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Column_Sep
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Column_Sep_Elements.ODF_Style_Column_Sep_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Columns_Elements.ODF_Style_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Columns_Elements.ODF_Style_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Background
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Background_Elements.ODF_Table_Background_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Background
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Background_Elements.ODF_Table_Background_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Bibliography_Configuration
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bibliography_Configuration_Elements.ODF_Text_Bibliography_Configuration_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Bibliography_Configuration
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bibliography_Configuration_Elements.ODF_Text_Bibliography_Configuration_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Binary_Data
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Binary_Data_Elements.ODF_Office_Binary_Data_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Binary_Data
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Binary_Data_Elements.ODF_Office_Binary_Data_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Body
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Body_Elements.ODF_Table_Body_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Body
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Body_Elements.ODF_Table_Body_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Calculation_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Calculation_Settings_Elements.ODF_Table_Calculation_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Calculation_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Calculation_Settings_Elements.ODF_Table_Calculation_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Cell_Address
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Cell_Address_Elements.ODF_Table_Cell_Address_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Cell_Address
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Cell_Address_Elements.ODF_Table_Cell_Address_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Cell_Content_Change
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Cell_Content_Change_Elements.ODF_Table_Cell_Content_Change_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Cell_Content_Change
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Cell_Content_Change_Elements.ODF_Table_Cell_Content_Change_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Cell_Content_Deletion
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Cell_Content_Deletion_Elements.ODF_Table_Cell_Content_Deletion_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Cell_Content_Deletion
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Cell_Content_Deletion_Elements.ODF_Table_Cell_Content_Deletion_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Cell_Range_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Cell_Range_Source_Elements.ODF_Table_Cell_Range_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Cell_Range_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Cell_Range_Source_Elements.ODF_Table_Cell_Range_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Change_Deletion
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Change_Deletion_Elements.ODF_Table_Change_Deletion_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Change_Deletion
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Change_Deletion_Elements.ODF_Table_Change_Deletion_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Change_Track_Table_Cell
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Change_Track_Table_Cell_Elements.ODF_Table_Change_Track_Table_Cell_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Change_Track_Table_Cell
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Change_Track_Table_Cell_Elements.ODF_Table_Change_Track_Table_Cell_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Bibliography
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bibliography_Elements.ODF_Text_Bibliography_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Bibliography
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bibliography_Elements.ODF_Text_Bibliography_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Bibliography_Entry_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bibliography_Entry_Template_Elements.ODF_Text_Bibliography_Entry_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Bibliography_Entry_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bibliography_Entry_Template_Elements.ODF_Text_Bibliography_Entry_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Bibliography_Mark
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bibliography_Mark_Elements.ODF_Text_Bibliography_Mark_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Bibliography_Mark
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bibliography_Mark_Elements.ODF_Text_Bibliography_Mark_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Bibliography_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bibliography_Source_Elements.ODF_Text_Bibliography_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Bibliography_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bibliography_Source_Elements.ODF_Text_Bibliography_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Bookmark
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bookmark_Elements.ODF_Text_Bookmark_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Bookmark
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bookmark_Elements.ODF_Text_Bookmark_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Bookmark_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bookmark_End_Elements.ODF_Text_Bookmark_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Bookmark_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bookmark_End_Elements.ODF_Text_Bookmark_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Bookmark_Ref
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bookmark_Ref_Elements.ODF_Text_Bookmark_Ref_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Bookmark_Ref
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bookmark_Ref_Elements.ODF_Text_Bookmark_Ref_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Bookmark_Start
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bookmark_Start_Elements.ODF_Text_Bookmark_Start_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Bookmark_Start
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Bookmark_Start_Elements.ODF_Text_Bookmark_Start_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Change
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Change_Elements.ODF_Text_Change_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Change
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Change_Elements.ODF_Text_Change_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Change_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Change_End_Elements.ODF_Text_Change_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Change_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Change_End_Elements.ODF_Text_Change_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Change_Info
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Change_Info_Elements.ODF_Office_Change_Info_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Change_Info
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Change_Info_Elements.ODF_Office_Change_Info_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Change_Start
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Change_Start_Elements.ODF_Text_Change_Start_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Change_Start
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Change_Start_Elements.ODF_Text_Change_Start_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Changed_Region
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Changed_Region_Elements.ODF_Text_Changed_Region_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Changed_Region
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Changed_Region_Elements.ODF_Text_Changed_Region_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Chapter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Chapter_Elements.ODF_Text_Chapter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Chapter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Chapter_Elements.ODF_Text_Chapter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Character_Count
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Character_Count_Elements.ODF_Text_Character_Count_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Character_Count
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Character_Count_Elements.ODF_Text_Character_Count_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Conditional_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Conditional_Text_Elements.ODF_Text_Conditional_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Conditional_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Conditional_Text_Elements.ODF_Text_Conditional_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Config_Config_Item
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Config_Config_Item_Elements.ODF_Config_Config_Item_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Config_Config_Item
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Config_Config_Item_Elements.ODF_Config_Config_Item_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Config_Config_Item_Map_Entry
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Config_Config_Item_Map_Entry_Elements.ODF_Config_Config_Item_Map_Entry_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Config_Config_Item_Map_Entry
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Config_Config_Item_Map_Entry_Elements.ODF_Config_Config_Item_Map_Entry_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Config_Config_Item_Map_Indexed
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Config_Config_Item_Map_Indexed_Elements.ODF_Config_Config_Item_Map_Indexed_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Config_Config_Item_Map_Indexed
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Config_Config_Item_Map_Indexed_Elements.ODF_Config_Config_Item_Map_Indexed_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Config_Config_Item_Map_Named
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Config_Config_Item_Map_Named_Elements.ODF_Config_Config_Item_Map_Named_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Config_Config_Item_Map_Named
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Config_Config_Item_Map_Named_Elements.ODF_Config_Config_Item_Map_Named_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Config_Config_Item_Set
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Config_Config_Item_Set_Elements.ODF_Config_Config_Item_Set_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Config_Config_Item_Set
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Config_Config_Item_Set_Elements.ODF_Config_Config_Item_Set_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Connection_Data
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Connection_Data_Elements.ODF_Db_Connection_Data_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Connection_Data
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Connection_Data_Elements.ODF_Db_Connection_Data_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Connection_Resource
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Connection_Resource_Elements.ODF_Db_Connection_Resource_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Connection_Resource
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Connection_Resource_Elements.ODF_Db_Connection_Resource_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Data_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Data_Source_Elements.ODF_Db_Data_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Data_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Data_Source_Elements.ODF_Db_Data_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Data_Source_Setting
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Data_Source_Setting_Elements.ODF_Db_Data_Source_Setting_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Data_Source_Setting
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Data_Source_Setting_Elements.ODF_Db_Data_Source_Setting_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Data_Source_Setting_Value
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Data_Source_Setting_Value_Elements.ODF_Db_Data_Source_Setting_Value_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Data_Source_Setting_Value
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Data_Source_Setting_Value_Elements.ODF_Db_Data_Source_Setting_Value_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Data_Source_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Data_Source_Settings_Elements.ODF_Db_Data_Source_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Data_Source_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Data_Source_Settings_Elements.ODF_Db_Data_Source_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Database_Description
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Database_Description_Elements.ODF_Db_Database_Description_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Database_Description
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Database_Description_Elements.ODF_Db_Database_Description_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Delimiter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Delimiter_Elements.ODF_Db_Delimiter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Delimiter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Delimiter_Elements.ODF_Db_Delimiter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Driver_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Driver_Settings_Elements.ODF_Db_Driver_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Driver_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Driver_Settings_Elements.ODF_Db_Driver_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_File_Based_Database
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_File_Based_Database_Elements.ODF_Db_File_Based_Database_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_File_Based_Database
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_File_Based_Database_Elements.ODF_Db_File_Based_Database_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Fill_Image
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Fill_Image_Elements.ODF_Draw_Fill_Image_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Fill_Image
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Fill_Image_Elements.ODF_Draw_Fill_Image_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Filter_Statement
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Filter_Statement_Elements.ODF_Db_Filter_Statement_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Filter_Statement
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Filter_Statement_Elements.ODF_Db_Filter_Statement_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Forms
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Forms_Elements.ODF_Db_Forms_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Forms
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Forms_Elements.ODF_Db_Forms_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Index
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Index_Elements.ODF_Db_Index_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Index
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Index_Elements.ODF_Db_Index_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Index_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Index_Column_Elements.ODF_Db_Index_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Index_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Index_Column_Elements.ODF_Db_Index_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Index_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Index_Columns_Elements.ODF_Db_Index_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Index_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Index_Columns_Elements.ODF_Db_Index_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Indices
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Indices_Elements.ODF_Db_Indices_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Indices
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Indices_Elements.ODF_Db_Indices_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Key
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Key_Elements.ODF_Db_Key_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Key
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Key_Elements.ODF_Db_Key_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Key_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Key_Column_Elements.ODF_Db_Key_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Key_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Key_Column_Elements.ODF_Db_Key_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Key_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Key_Columns_Elements.ODF_Db_Key_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Key_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Key_Columns_Elements.ODF_Db_Key_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Keys
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Keys_Elements.ODF_Db_Keys_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Keys
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Keys_Elements.ODF_Db_Keys_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Login
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Login_Elements.ODF_Db_Login_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Login
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Login_Elements.ODF_Db_Login_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Order_Statement
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Order_Statement_Elements.ODF_Db_Order_Statement_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Order_Statement
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Order_Statement_Elements.ODF_Db_Order_Statement_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Queries
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Queries_Elements.ODF_Db_Queries_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Queries
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Queries_Elements.ODF_Db_Queries_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Query
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Query_Elements.ODF_Db_Query_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Query
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Query_Elements.ODF_Db_Query_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Query_Collection
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Query_Collection_Elements.ODF_Db_Query_Collection_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Query_Collection
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Query_Collection_Elements.ODF_Db_Query_Collection_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Reports
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Reports_Elements.ODF_Db_Reports_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Reports
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Reports_Elements.ODF_Db_Reports_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Schema_Definition
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Schema_Definition_Elements.ODF_Db_Schema_Definition_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Schema_Definition
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Schema_Definition_Elements.ODF_Db_Schema_Definition_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Server_Database
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Server_Database_Elements.ODF_Db_Server_Database_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Server_Database
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Server_Database_Elements.ODF_Db_Server_Database_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Table_Definition
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Definition_Elements.ODF_Db_Table_Definition_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Table_Definition
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Definition_Elements.ODF_Db_Table_Definition_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Table_Definitions
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Definitions_Elements.ODF_Db_Table_Definitions_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Table_Definitions
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Definitions_Elements.ODF_Db_Table_Definitions_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Table_Exclude_Filter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Exclude_Filter_Elements.ODF_Db_Table_Exclude_Filter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Table_Exclude_Filter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Exclude_Filter_Elements.ODF_Db_Table_Exclude_Filter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Table_Filter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Filter_Elements.ODF_Db_Table_Filter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Table_Filter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Filter_Elements.ODF_Db_Table_Filter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Table_Filter_Pattern
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Filter_Pattern_Elements.ODF_Db_Table_Filter_Pattern_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Table_Filter_Pattern
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Filter_Pattern_Elements.ODF_Db_Table_Filter_Pattern_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Table_Include_Filter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Include_Filter_Elements.ODF_Db_Table_Include_Filter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Table_Include_Filter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Include_Filter_Elements.ODF_Db_Table_Include_Filter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Table_Representation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Representation_Elements.ODF_Db_Table_Representation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Table_Representation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Representation_Elements.ODF_Db_Table_Representation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Table_Representations
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Representations_Elements.ODF_Db_Table_Representations_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Table_Representations
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Representations_Elements.ODF_Db_Table_Representations_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Table_Setting
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Setting_Elements.ODF_Db_Table_Setting_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Table_Setting
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Setting_Elements.ODF_Db_Table_Setting_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Table_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Settings_Elements.ODF_Db_Table_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Table_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Settings_Elements.ODF_Db_Table_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Table_Type
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Type_Elements.ODF_Db_Table_Type_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Table_Type
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Type_Elements.ODF_Db_Table_Type_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Table_Type_Filter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Type_Filter_Elements.ODF_Db_Table_Type_Filter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Table_Type_Filter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Table_Type_Filter_Elements.ODF_Db_Table_Type_Filter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Db_Update_Table
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Update_Table_Elements.ODF_Db_Update_Table_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Db_Update_Table
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Db_Update_Table_Elements.ODF_Db_Update_Table_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Connector
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Connector_Elements.ODF_Draw_Connector_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Connector
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Connector_Elements.ODF_Draw_Connector_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Contour_Path
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Contour_Path_Elements.ODF_Draw_Contour_Path_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Contour_Path
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Contour_Path_Elements.ODF_Draw_Contour_Path_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Contour_Polygon
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Contour_Polygon_Elements.ODF_Draw_Contour_Polygon_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Contour_Polygon
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Contour_Polygon_Elements.ODF_Draw_Contour_Polygon_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Control
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Control_Elements.ODF_Draw_Control_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Control
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Control_Elements.ODF_Draw_Control_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Connection_Resource
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Connection_Resource_Elements.ODF_Form_Connection_Resource_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Connection_Resource
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Connection_Resource_Elements.ODF_Form_Connection_Resource_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Consolidation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Consolidation_Elements.ODF_Table_Consolidation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Consolidation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Consolidation_Elements.ODF_Table_Consolidation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Content_Validation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Content_Validation_Elements.ODF_Table_Content_Validation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Content_Validation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Content_Validation_Elements.ODF_Table_Content_Validation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Content_Validations
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Content_Validations_Elements.ODF_Table_Content_Validations_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Content_Validations
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Content_Validations_Elements.ODF_Table_Content_Validations_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Covered_Table_Cell
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Covered_Table_Cell_Elements.ODF_Table_Covered_Table_Cell_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Covered_Table_Cell
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Covered_Table_Cell_Elements.ODF_Table_Covered_Table_Cell_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Meta_Creation_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Creation_Date_Elements.ODF_Meta_Creation_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Meta_Creation_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Creation_Date_Elements.ODF_Meta_Creation_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Creation_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Creation_Date_Elements.ODF_Text_Creation_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Creation_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Creation_Date_Elements.ODF_Text_Creation_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Creation_Time
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Creation_Time_Elements.ODF_Text_Creation_Time_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Creation_Time
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Creation_Time_Elements.ODF_Text_Creation_Time_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Dc_Creator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dc_Creator_Elements.ODF_Dc_Creator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Dc_Creator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dc_Creator_Elements.ODF_Dc_Creator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Dr3d_Cube
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dr3d_Cube_Elements.ODF_Dr3d_Cube_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Dr3d_Cube
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dr3d_Cube_Elements.ODF_Dr3d_Cube_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Currency_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Currency_Style_Elements.ODF_Number_Currency_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Currency_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Currency_Style_Elements.ODF_Number_Currency_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Currency_Symbol
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Currency_Symbol_Elements.ODF_Number_Currency_Symbol_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Currency_Symbol
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Currency_Symbol_Elements.ODF_Number_Currency_Symbol_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Custom_Shape
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Custom_Shape_Elements.ODF_Draw_Custom_Shape_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Custom_Shape
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Custom_Shape_Elements.ODF_Draw_Custom_Shape_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Date_Elements.ODF_Form_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Date_Elements.ODF_Form_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Meta_Date_String
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Date_String_Elements.ODF_Meta_Date_String_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Meta_Date_String
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Date_String_Elements.ODF_Meta_Date_String_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Date_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Date_Style_Elements.ODF_Number_Date_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Date_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Date_Style_Elements.ODF_Number_Date_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Day
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Day_Elements.ODF_Number_Day_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Day
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Day_Elements.ODF_Number_Day_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Day_Of_Week
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Day_Of_Week_Elements.ODF_Number_Day_Of_Week_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Day_Of_Week
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Day_Of_Week_Elements.ODF_Number_Day_Of_Week_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Embedded_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Embedded_Text_Elements.ODF_Number_Embedded_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Embedded_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Embedded_Text_Elements.ODF_Number_Embedded_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Database
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Database_Elements.ODF_Office_Database_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Database
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Database_Elements.ODF_Office_Database_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Dde_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Dde_Source_Elements.ODF_Office_Dde_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Dde_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Dde_Source_Elements.ODF_Office_Dde_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Date_Time
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Date_Time_Elements.ODF_Presentation_Date_Time_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Date_Time
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Date_Time_Elements.ODF_Presentation_Date_Time_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Date_Time_Decl
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Date_Time_Decl_Elements.ODF_Presentation_Date_Time_Decl_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Date_Time_Decl
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Date_Time_Decl_Elements.ODF_Presentation_Date_Time_Decl_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Default_Page_Layout
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Default_Page_Layout_Elements.ODF_Style_Default_Page_Layout_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Default_Page_Layout
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Default_Page_Layout_Elements.ODF_Style_Default_Page_Layout_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Default_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Default_Style_Elements.ODF_Style_Default_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Default_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Default_Style_Elements.ODF_Style_Default_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Drawing_Page_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Drawing_Page_Properties_Elements.ODF_Style_Drawing_Page_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Drawing_Page_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Drawing_Page_Properties_Elements.ODF_Style_Drawing_Page_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Drop_Cap
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Drop_Cap_Elements.ODF_Style_Drop_Cap_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Drop_Cap
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Drop_Cap_Elements.ODF_Style_Drop_Cap_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Svg_Definition_Src
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Definition_Src_Elements.ODF_Svg_Definition_Src_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Svg_Definition_Src
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Definition_Src_Elements.ODF_Svg_Definition_Src_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Dde_Link
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Dde_Link_Elements.ODF_Table_Dde_Link_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Dde_Link
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Dde_Link_Elements.ODF_Table_Dde_Link_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Dim
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Dim_Elements.ODF_Presentation_Dim_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Dim
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Dim_Elements.ODF_Presentation_Dim_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Enhanced_Geometry
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Enhanced_Geometry_Elements.ODF_Draw_Enhanced_Geometry_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Enhanced_Geometry
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Enhanced_Geometry_Elements.ODF_Draw_Enhanced_Geometry_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Dr3d_Extrude
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dr3d_Extrude_Elements.ODF_Dr3d_Extrude_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Dr3d_Extrude
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dr3d_Extrude_Elements.ODF_Dr3d_Extrude_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Dr3d_Light
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dr3d_Light_Elements.ODF_Dr3d_Light_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Dr3d_Light
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dr3d_Light_Elements.ODF_Dr3d_Light_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Dr3d_Rotate
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dr3d_Rotate_Elements.ODF_Dr3d_Rotate_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Dr3d_Rotate
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dr3d_Rotate_Elements.ODF_Dr3d_Rotate_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Dr3d_Scene
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dr3d_Scene_Elements.ODF_Dr3d_Scene_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Dr3d_Scene
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dr3d_Scene_Elements.ODF_Dr3d_Scene_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Dr3d_Sphere
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dr3d_Sphere_Elements.ODF_Dr3d_Sphere_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Dr3d_Sphere
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dr3d_Sphere_Elements.ODF_Dr3d_Sphere_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Svg_Desc
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Desc_Elements.ODF_Svg_Desc_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Svg_Desc
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Desc_Elements.ODF_Svg_Desc_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Ellipse
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Ellipse_Elements.ODF_Draw_Ellipse_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Ellipse
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Ellipse_Elements.ODF_Draw_Ellipse_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Equation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Equation_Elements.ODF_Draw_Equation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Equation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Equation_Elements.ODF_Draw_Equation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Era
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Era_Elements.ODF_Number_Era_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Era
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Era_Elements.ODF_Number_Era_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Even_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Even_Columns_Elements.ODF_Table_Even_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Even_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Even_Columns_Elements.ODF_Table_Even_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Even_Rows
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Even_Rows_Elements.ODF_Table_Even_Rows_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Even_Rows
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Even_Rows_Elements.ODF_Table_Even_Rows_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Script_Event_Listener
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Script_Event_Listener_Elements.ODF_Script_Event_Listener_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Script_Event_Listener
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Script_Event_Listener_Elements.ODF_Script_Event_Listener_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_File
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_File_Elements.ODF_Form_File_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_File
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_File_Elements.ODF_Form_File_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Fixed_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Fixed_Text_Elements.ODF_Form_Fixed_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Fixed_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Fixed_Text_Elements.ODF_Form_Fixed_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Event_Listener
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Event_Listener_Elements.ODF_Presentation_Event_Listener_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Event_Listener
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Event_Listener_Elements.ODF_Presentation_Event_Listener_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Floating_Frame
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Floating_Frame_Elements.ODF_Draw_Floating_Frame_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Floating_Frame
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Floating_Frame_Elements.ODF_Draw_Floating_Frame_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Form
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Form_Elements.ODF_Form_Form_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Form
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Form_Elements.ODF_Form_Form_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Formatted_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Formatted_Text_Elements.ODF_Form_Formatted_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Formatted_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Formatted_Text_Elements.ODF_Form_Formatted_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Fraction
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Fraction_Elements.ODF_Number_Fraction_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Fraction
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Fraction_Elements.ODF_Number_Fraction_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Frame
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Frame_Elements.ODF_Draw_Frame_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Frame
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Frame_Elements.ODF_Draw_Frame_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Frame
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Frame_Elements.ODF_Form_Frame_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Frame
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Frame_Elements.ODF_Form_Frame_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Generic_Control
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Generic_Control_Elements.ODF_Form_Generic_Control_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Generic_Control
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Generic_Control_Elements.ODF_Form_Generic_Control_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Event_Listeners
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Event_Listeners_Elements.ODF_Office_Event_Listeners_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Event_Listeners
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Event_Listeners_Elements.ODF_Office_Event_Listeners_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Font_Face
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Font_Face_Elements.ODF_Style_Font_Face_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Font_Face
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Font_Face_Elements.ODF_Style_Font_Face_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Svg_Font_Face_Format
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Font_Face_Format_Elements.ODF_Svg_Font_Face_Format_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Svg_Font_Face_Format
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Font_Face_Format_Elements.ODF_Svg_Font_Face_Format_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Svg_Font_Face_Name
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Font_Face_Name_Elements.ODF_Svg_Font_Face_Name_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Svg_Font_Face_Name
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Font_Face_Name_Elements.ODF_Svg_Font_Face_Name_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Svg_Font_Face_Src
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Font_Face_Src_Elements.ODF_Svg_Font_Face_Src_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Svg_Font_Face_Src
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Font_Face_Src_Elements.ODF_Svg_Font_Face_Src_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Svg_Font_Face_Uri
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Font_Face_Uri_Elements.ODF_Svg_Font_Face_Uri_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Svg_Font_Face_Uri
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Font_Face_Uri_Elements.ODF_Svg_Font_Face_Uri_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_First_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_First_Column_Elements.ODF_Table_First_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_First_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_First_Column_Elements.ODF_Table_First_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_First_Row
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_First_Row_Elements.ODF_Table_First_Row_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_First_Row
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_First_Row_Elements.ODF_Table_First_Row_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Forms
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Forms_Elements.ODF_Office_Forms_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Forms
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Forms_Elements.ODF_Office_Forms_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Footer
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Footer_Elements.ODF_Presentation_Footer_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Footer
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Footer_Elements.ODF_Presentation_Footer_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Footer
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Footer_Elements.ODF_Style_Footer_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Footer
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Footer_Elements.ODF_Style_Footer_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Footer_Decl
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Footer_Decl_Elements.ODF_Presentation_Footer_Decl_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Footer_Decl
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Footer_Decl_Elements.ODF_Presentation_Footer_Decl_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Footer_Left
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Footer_Left_Elements.ODF_Style_Footer_Left_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Footer_Left
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Footer_Left_Elements.ODF_Style_Footer_Left_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Footer_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Footer_Style_Elements.ODF_Style_Footer_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Footer_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Footer_Style_Elements.ODF_Style_Footer_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Footnote_Sep
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Footnote_Sep_Elements.ODF_Style_Footnote_Sep_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Footnote_Sep
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Footnote_Sep_Elements.ODF_Style_Footnote_Sep_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_G
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_G_Elements.ODF_Draw_G_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_G
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_G_Elements.ODF_Draw_G_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Glue_Point
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Glue_Point_Elements.ODF_Draw_Glue_Point_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Glue_Point
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Glue_Point_Elements.ODF_Draw_Glue_Point_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Gradient
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Gradient_Elements.ODF_Draw_Gradient_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Gradient
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Gradient_Elements.ODF_Draw_Gradient_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Graphic_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Graphic_Properties_Elements.ODF_Style_Graphic_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Graphic_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Graphic_Properties_Elements.ODF_Style_Graphic_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Grid
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Grid_Elements.ODF_Form_Grid_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Grid
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Grid_Elements.ODF_Form_Grid_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Handle
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Handle_Elements.ODF_Draw_Handle_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Handle
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Handle_Elements.ODF_Draw_Handle_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Hatch
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Hatch_Elements.ODF_Draw_Hatch_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Hatch
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Hatch_Elements.ODF_Draw_Hatch_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Hidden
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Hidden_Elements.ODF_Form_Hidden_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Hidden
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Hidden_Elements.ODF_Form_Hidden_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Hours
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Hours_Elements.ODF_Number_Hours_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Hours
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Hours_Elements.ODF_Number_Hours_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Image
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Image_Elements.ODF_Form_Image_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Image
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Image_Elements.ODF_Form_Image_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Image_Frame
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Image_Frame_Elements.ODF_Form_Image_Frame_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Image_Frame
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Image_Frame_Elements.ODF_Form_Image_Frame_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Header
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Header_Elements.ODF_Presentation_Header_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Header
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Header_Elements.ODF_Presentation_Header_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Header
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Header_Elements.ODF_Style_Header_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Header
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Header_Elements.ODF_Style_Header_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Header_Decl
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Header_Decl_Elements.ODF_Presentation_Header_Decl_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Header_Decl
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Header_Decl_Elements.ODF_Presentation_Header_Decl_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Header_Footer_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Header_Footer_Properties_Elements.ODF_Style_Header_Footer_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Header_Footer_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Header_Footer_Properties_Elements.ODF_Style_Header_Footer_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Header_Left
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Header_Left_Elements.ODF_Style_Header_Left_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Header_Left
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Header_Left_Elements.ODF_Style_Header_Left_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Header_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Header_Style_Elements.ODF_Style_Header_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Header_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Header_Style_Elements.ODF_Style_Header_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Hide_Shape
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Hide_Shape_Elements.ODF_Presentation_Hide_Shape_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Hide_Shape
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Hide_Shape_Elements.ODF_Presentation_Hide_Shape_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Hide_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Hide_Text_Elements.ODF_Presentation_Hide_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Hide_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Hide_Text_Elements.ODF_Presentation_Hide_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Image
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Image_Elements.ODF_Draw_Image_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Image
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Image_Elements.ODF_Draw_Image_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Image_Map
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Image_Map_Elements.ODF_Draw_Image_Map_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Image_Map
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Image_Map_Elements.ODF_Draw_Image_Map_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Item
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Item_Elements.ODF_Form_Item_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Item
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Item_Elements.ODF_Form_Item_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Layer
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Layer_Elements.ODF_Draw_Layer_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Layer
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Layer_Elements.ODF_Draw_Layer_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Layer_Set
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Layer_Set_Elements.ODF_Draw_Layer_Set_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Layer_Set
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Layer_Set_Elements.ODF_Draw_Layer_Set_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Line
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Line_Elements.ODF_Draw_Line_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Line
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Line_Elements.ODF_Draw_Line_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_List_Level_Label_Alignment
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_List_Level_Label_Alignment_Elements.ODF_Style_List_Level_Label_Alignment_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_List_Level_Label_Alignment
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_List_Level_Label_Alignment_Elements.ODF_Style_List_Level_Label_Alignment_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_List_Level_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_List_Level_Properties_Elements.ODF_Style_List_Level_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_List_Level_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_List_Level_Properties_Elements.ODF_Style_List_Level_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Marker
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Marker_Elements.ODF_Draw_Marker_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Marker
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Marker_Elements.ODF_Draw_Marker_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Svg_LinearGradient
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_LinearGradient_Elements.ODF_Svg_LinearGradient_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Svg_LinearGradient
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_LinearGradient_Elements.ODF_Svg_LinearGradient_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_List_Property
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_List_Property_Elements.ODF_Form_List_Property_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_List_Property
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_List_Property_Elements.ODF_Form_List_Property_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_List_Value
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_List_Value_Elements.ODF_Form_List_Value_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_List_Value
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_List_Value_Elements.ODF_Form_List_Value_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Listbox
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Listbox_Elements.ODF_Form_Listbox_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Listbox
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Listbox_Elements.ODF_Form_Listbox_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Map
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Map_Elements.ODF_Style_Map_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Map
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Map_Elements.ODF_Style_Map_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Master_Page
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Master_Page_Elements.ODF_Style_Master_Page_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Master_Page
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Master_Page_Elements.ODF_Style_Master_Page_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Math_Math
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Math_Math_Elements.ODF_Math_Math_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Math_Math
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Math_Math_Elements.ODF_Math_Math_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Measure
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Measure_Elements.ODF_Draw_Measure_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Measure
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Measure_Elements.ODF_Draw_Measure_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Minutes
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Minutes_Elements.ODF_Number_Minutes_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Minutes
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Minutes_Elements.ODF_Number_Minutes_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Month
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Month_Elements.ODF_Number_Month_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Month
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Month_Elements.ODF_Number_Month_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Notes
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Notes_Elements.ODF_Presentation_Notes_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Notes
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Notes_Elements.ODF_Presentation_Notes_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Number_Elements.ODF_Form_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Number_Elements.ODF_Form_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Number_Elements.ODF_Number_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Number_Elements.ODF_Number_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Number_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Number_Style_Elements.ODF_Number_Number_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Number_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Number_Style_Elements.ODF_Number_Number_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Object
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Object_Elements.ODF_Draw_Object_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Object
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Object_Elements.ODF_Draw_Object_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Object_Ole
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Object_Ole_Elements.ODF_Draw_Object_Ole_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Object_Ole
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Object_Ole_Elements.ODF_Draw_Object_Ole_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Opacity
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Opacity_Elements.ODF_Draw_Opacity_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Opacity
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Opacity_Elements.ODF_Draw_Opacity_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Option
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Option_Elements.ODF_Form_Option_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Option
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Option_Elements.ODF_Form_Option_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Page
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Page_Elements.ODF_Draw_Page_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Page
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Page_Elements.ODF_Draw_Page_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Page_Layout
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Page_Layout_Elements.ODF_Style_Page_Layout_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Page_Layout
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Page_Layout_Elements.ODF_Style_Page_Layout_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Page_Layout_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Page_Layout_Properties_Elements.ODF_Style_Page_Layout_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Page_Layout_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Page_Layout_Properties_Elements.ODF_Style_Page_Layout_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Page_Thumbnail
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Page_Thumbnail_Elements.ODF_Draw_Page_Thumbnail_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Page_Thumbnail
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Page_Thumbnail_Elements.ODF_Draw_Page_Thumbnail_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Paragraph_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Paragraph_Properties_Elements.ODF_Style_Paragraph_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Paragraph_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Paragraph_Properties_Elements.ODF_Style_Paragraph_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Param
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Param_Elements.ODF_Draw_Param_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Param
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Param_Elements.ODF_Draw_Param_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Password
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Password_Elements.ODF_Form_Password_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Password
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Password_Elements.ODF_Form_Password_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Path
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Path_Elements.ODF_Draw_Path_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Path
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Path_Elements.ODF_Draw_Path_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Percentage_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Percentage_Style_Elements.ODF_Number_Percentage_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Percentage_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Percentage_Style_Elements.ODF_Number_Percentage_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Placeholder
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Placeholder_Elements.ODF_Presentation_Placeholder_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Placeholder
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Placeholder_Elements.ODF_Presentation_Placeholder_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Plugin
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Plugin_Elements.ODF_Draw_Plugin_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Plugin
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Plugin_Elements.ODF_Draw_Plugin_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Polygon
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Polygon_Elements.ODF_Draw_Polygon_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Polygon
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Polygon_Elements.ODF_Draw_Polygon_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Polyline
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Polyline_Elements.ODF_Draw_Polyline_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Polyline
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Polyline_Elements.ODF_Draw_Polyline_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Presentation_Page_Layout
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Presentation_Page_Layout_Elements.ODF_Style_Presentation_Page_Layout_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Presentation_Page_Layout
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Presentation_Page_Layout_Elements.ODF_Style_Presentation_Page_Layout_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Properties_Elements.ODF_Form_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Properties_Elements.ODF_Form_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Property
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Property_Elements.ODF_Form_Property_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Property
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Property_Elements.ODF_Form_Property_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Quarter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Quarter_Elements.ODF_Number_Quarter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Quarter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Quarter_Elements.ODF_Number_Quarter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Svg_RadialGradient
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_RadialGradient_Elements.ODF_Svg_RadialGradient_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Svg_RadialGradient
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_RadialGradient_Elements.ODF_Svg_RadialGradient_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Radio
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Radio_Elements.ODF_Form_Radio_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Radio
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Radio_Elements.ODF_Form_Radio_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Rect
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Rect_Elements.ODF_Draw_Rect_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Rect
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Rect_Elements.ODF_Draw_Rect_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Region_Center
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Region_Center_Elements.ODF_Style_Region_Center_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Region_Center
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Region_Center_Elements.ODF_Style_Region_Center_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Region_Left
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Region_Left_Elements.ODF_Style_Region_Left_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Region_Left
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Region_Left_Elements.ODF_Style_Region_Left_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Region_Right
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Region_Right_Elements.ODF_Style_Region_Right_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Region_Right
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Region_Right_Elements.ODF_Style_Region_Right_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Regular_Polygon
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Regular_Polygon_Elements.ODF_Draw_Regular_Polygon_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Regular_Polygon
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Regular_Polygon_Elements.ODF_Draw_Regular_Polygon_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Ruby_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Ruby_Properties_Elements.ODF_Style_Ruby_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Ruby_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Ruby_Properties_Elements.ODF_Style_Ruby_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Stroke_Dash
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Stroke_Dash_Elements.ODF_Draw_Stroke_Dash_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Stroke_Dash
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Stroke_Dash_Elements.ODF_Draw_Stroke_Dash_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Scientific_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Scientific_Number_Elements.ODF_Number_Scientific_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Scientific_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Scientific_Number_Elements.ODF_Number_Scientific_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Seconds
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Seconds_Elements.ODF_Number_Seconds_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Seconds
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Seconds_Elements.ODF_Number_Seconds_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Section_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Section_Properties_Elements.ODF_Style_Section_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Section_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Section_Properties_Elements.ODF_Style_Section_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Svg_Stop
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Stop_Elements.ODF_Svg_Stop_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Svg_Stop
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Stop_Elements.ODF_Svg_Stop_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Text_Elements.ODF_Number_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Text_Elements.ODF_Number_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Style_Elements.ODF_Style_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Style_Elements.ODF_Style_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Tab_Stop
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Tab_Stop_Elements.ODF_Style_Tab_Stop_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Tab_Stop
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Tab_Stop_Elements.ODF_Style_Tab_Stop_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Tab_Stops
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Tab_Stops_Elements.ODF_Style_Tab_Stops_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Tab_Stops
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Tab_Stops_Elements.ODF_Style_Tab_Stops_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Table_Cell_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Table_Cell_Properties_Elements.ODF_Style_Table_Cell_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Table_Cell_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Table_Cell_Properties_Elements.ODF_Style_Table_Cell_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Table_Column_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Table_Column_Properties_Elements.ODF_Style_Table_Column_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Table_Column_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Table_Column_Properties_Elements.ODF_Style_Table_Column_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Table_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Table_Properties_Elements.ODF_Style_Table_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Table_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Table_Properties_Elements.ODF_Style_Table_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Table_Row_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Table_Row_Properties_Elements.ODF_Style_Table_Row_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Table_Row_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Table_Row_Properties_Elements.ODF_Style_Table_Row_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Text_Elements.ODF_Form_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Text_Elements.ODF_Form_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Draw_Text_Box
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Text_Box_Elements.ODF_Draw_Text_Box_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Draw_Text_Box
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Draw_Text_Box_Elements.ODF_Draw_Text_Box_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Text_Content
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Text_Content_Elements.ODF_Number_Text_Content_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Text_Content
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Text_Content_Elements.ODF_Number_Text_Content_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Text_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Text_Properties_Elements.ODF_Style_Text_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Text_Properties
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Text_Properties_Elements.ODF_Style_Text_Properties_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Text_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Text_Style_Elements.ODF_Number_Text_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Text_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Text_Style_Elements.ODF_Number_Text_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Textarea
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Textarea_Elements.ODF_Form_Textarea_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Textarea
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Textarea_Elements.ODF_Form_Textarea_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Time
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Time_Elements.ODF_Form_Time_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Time
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Time_Elements.ODF_Form_Time_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Time_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Time_Style_Elements.ODF_Number_Time_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Time_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Time_Style_Elements.ODF_Number_Time_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Form_Value_Range
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Value_Range_Elements.ODF_Form_Value_Range_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Form_Value_Range
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Form_Value_Range_Elements.ODF_Form_Value_Range_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Week_Of_Year
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Week_Of_Year_Elements.ODF_Number_Week_Of_Year_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Week_Of_Year
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Week_Of_Year_Elements.ODF_Number_Week_Of_Year_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Number_Year
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Year_Elements.ODF_Number_Year_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Number_Year
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Number_Year_Elements.ODF_Number_Year_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Cut_Offs
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Cut_Offs_Elements.ODF_Table_Cut_Offs_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Cut_Offs
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Cut_Offs_Elements.ODF_Table_Cut_Offs_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Data_Pilot_Display_Info
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Display_Info_Elements.ODF_Table_Data_Pilot_Display_Info_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Data_Pilot_Display_Info
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Display_Info_Elements.ODF_Table_Data_Pilot_Display_Info_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Data_Pilot_Field
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Field_Elements.ODF_Table_Data_Pilot_Field_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Data_Pilot_Field
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Field_Elements.ODF_Table_Data_Pilot_Field_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Data_Pilot_Field_Reference
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Field_Reference_Elements.ODF_Table_Data_Pilot_Field_Reference_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Data_Pilot_Field_Reference
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Field_Reference_Elements.ODF_Table_Data_Pilot_Field_Reference_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Data_Pilot_Group
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Group_Elements.ODF_Table_Data_Pilot_Group_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Data_Pilot_Group
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Group_Elements.ODF_Table_Data_Pilot_Group_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Data_Pilot_Group_Member
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Group_Member_Elements.ODF_Table_Data_Pilot_Group_Member_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Data_Pilot_Group_Member
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Group_Member_Elements.ODF_Table_Data_Pilot_Group_Member_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Data_Pilot_Groups
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Groups_Elements.ODF_Table_Data_Pilot_Groups_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Data_Pilot_Groups
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Groups_Elements.ODF_Table_Data_Pilot_Groups_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Data_Pilot_Layout_Info
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Layout_Info_Elements.ODF_Table_Data_Pilot_Layout_Info_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Data_Pilot_Layout_Info
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Layout_Info_Elements.ODF_Table_Data_Pilot_Layout_Info_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Data_Pilot_Level
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Level_Elements.ODF_Table_Data_Pilot_Level_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Data_Pilot_Level
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Level_Elements.ODF_Table_Data_Pilot_Level_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Data_Pilot_Member
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Member_Elements.ODF_Table_Data_Pilot_Member_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Data_Pilot_Member
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Member_Elements.ODF_Table_Data_Pilot_Member_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Data_Pilot_Members
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Members_Elements.ODF_Table_Data_Pilot_Members_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Data_Pilot_Members
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Members_Elements.ODF_Table_Data_Pilot_Members_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Data_Pilot_Sort_Info
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Sort_Info_Elements.ODF_Table_Data_Pilot_Sort_Info_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Data_Pilot_Sort_Info
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Sort_Info_Elements.ODF_Table_Data_Pilot_Sort_Info_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Data_Pilot_Subtotal
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Subtotal_Elements.ODF_Table_Data_Pilot_Subtotal_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Data_Pilot_Subtotal
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Subtotal_Elements.ODF_Table_Data_Pilot_Subtotal_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Data_Pilot_Subtotals
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Subtotals_Elements.ODF_Table_Data_Pilot_Subtotals_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Data_Pilot_Subtotals
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Subtotals_Elements.ODF_Table_Data_Pilot_Subtotals_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Data_Pilot_Table
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Table_Elements.ODF_Table_Data_Pilot_Table_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Data_Pilot_Table
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Table_Elements.ODF_Table_Data_Pilot_Table_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Data_Pilot_Tables
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Tables_Elements.ODF_Table_Data_Pilot_Tables_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Data_Pilot_Tables
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Data_Pilot_Tables_Elements.ODF_Table_Data_Pilot_Tables_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Database_Range
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Database_Range_Elements.ODF_Table_Database_Range_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Database_Range
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Database_Range_Elements.ODF_Table_Database_Range_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Database_Ranges
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Database_Ranges_Elements.ODF_Table_Database_Ranges_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Database_Ranges
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Database_Ranges_Elements.ODF_Table_Database_Ranges_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Database_Source_Query
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Database_Source_Query_Elements.ODF_Table_Database_Source_Query_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Database_Source_Query
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Database_Source_Query_Elements.ODF_Table_Database_Source_Query_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Database_Source_Sql
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Database_Source_Sql_Elements.ODF_Table_Database_Source_Sql_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Database_Source_Sql
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Database_Source_Sql_Elements.ODF_Table_Database_Source_Sql_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Database_Source_Table
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Database_Source_Table_Elements.ODF_Table_Database_Source_Table_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Database_Source_Table
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Database_Source_Table_Elements.ODF_Table_Database_Source_Table_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Dde_Links
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Dde_Links_Elements.ODF_Table_Dde_Links_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Dde_Links
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Dde_Links_Elements.ODF_Table_Dde_Links_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Deletion
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Deletion_Elements.ODF_Table_Deletion_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Deletion
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Deletion_Elements.ODF_Table_Deletion_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Deletions
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Deletions_Elements.ODF_Table_Deletions_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Deletions
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Deletions_Elements.ODF_Table_Deletions_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Dependencies
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Dependencies_Elements.ODF_Table_Dependencies_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Dependencies
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Dependencies_Elements.ODF_Table_Dependencies_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Dependency
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Dependency_Elements.ODF_Table_Dependency_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Dependency
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Dependency_Elements.ODF_Table_Dependency_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Desc
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Desc_Elements.ODF_Table_Desc_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Desc
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Desc_Elements.ODF_Table_Desc_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Last_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Last_Column_Elements.ODF_Table_Last_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Last_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Last_Column_Elements.ODF_Table_Last_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Last_Row
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Last_Row_Elements.ODF_Table_Last_Row_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Last_Row
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Last_Row_Elements.ODF_Table_Last_Row_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Odd_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Odd_Columns_Elements.ODF_Table_Odd_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Odd_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Odd_Columns_Elements.ODF_Table_Odd_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Odd_Rows
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Odd_Rows_Elements.ODF_Table_Odd_Rows_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Odd_Rows
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Odd_Rows_Elements.ODF_Table_Odd_Rows_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Template_Elements.ODF_Table_Table_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Template_Elements.ODF_Table_Table_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Creator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Creator_Elements.ODF_Text_Creator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Creator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Creator_Elements.ODF_Text_Creator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Database_Display
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Database_Display_Elements.ODF_Text_Database_Display_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Database_Display
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Database_Display_Elements.ODF_Text_Database_Display_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Database_Name
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Database_Name_Elements.ODF_Text_Database_Name_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Database_Name
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Database_Name_Elements.ODF_Text_Database_Name_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Database_Next
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Database_Next_Elements.ODF_Text_Database_Next_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Database_Next
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Database_Next_Elements.ODF_Text_Database_Next_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Database_Row_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Database_Row_Number_Elements.ODF_Text_Database_Row_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Database_Row_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Database_Row_Number_Elements.ODF_Text_Database_Row_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Database_Row_Select
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Database_Row_Select_Elements.ODF_Text_Database_Row_Select_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Database_Row_Select
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Database_Row_Select_Elements.ODF_Text_Database_Row_Select_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Dc_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dc_Date_Elements.ODF_Dc_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Dc_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dc_Date_Elements.ODF_Dc_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Date_Elements.ODF_Text_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Date_Elements.ODF_Text_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Dde_Connection
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Dde_Connection_Elements.ODF_Text_Dde_Connection_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Dde_Connection
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Dde_Connection_Elements.ODF_Text_Dde_Connection_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Dde_Connection_Decl
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Dde_Connection_Decl_Elements.ODF_Text_Dde_Connection_Decl_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Dde_Connection_Decl
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Dde_Connection_Decl_Elements.ODF_Text_Dde_Connection_Decl_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Dde_Connection_Decls
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Dde_Connection_Decls_Elements.ODF_Text_Dde_Connection_Decls_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Dde_Connection_Decls
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Dde_Connection_Decls_Elements.ODF_Text_Dde_Connection_Decls_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Deletion
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Deletion_Elements.ODF_Text_Deletion_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Deletion
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Deletion_Elements.ODF_Text_Deletion_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Dc_Description
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dc_Description_Elements.ODF_Dc_Description_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Dc_Description
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dc_Description_Elements.ODF_Dc_Description_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Detective
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Detective_Elements.ODF_Table_Detective_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Detective
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Detective_Elements.ODF_Table_Detective_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Description
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Description_Elements.ODF_Text_Description_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Description
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Description_Elements.ODF_Text_Description_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Meta_Document_Statistic
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Document_Statistic_Elements.ODF_Meta_Document_Statistic_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Meta_Document_Statistic
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Document_Statistic_Elements.ODF_Meta_Document_Statistic_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Meta_Editing_Cycles
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Editing_Cycles_Elements.ODF_Meta_Editing_Cycles_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Meta_Editing_Cycles
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Editing_Cycles_Elements.ODF_Meta_Editing_Cycles_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Meta_Editing_Duration
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Editing_Duration_Elements.ODF_Meta_Editing_Duration_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Meta_Editing_Duration
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Editing_Duration_Elements.ODF_Meta_Editing_Duration_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Dc_Language
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dc_Language_Elements.ODF_Dc_Language_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Dc_Language
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dc_Language_Elements.ODF_Dc_Language_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Dc_Subject
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dc_Subject_Elements.ODF_Dc_Subject_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Dc_Subject
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dc_Subject_Elements.ODF_Dc_Subject_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Dc_Title
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dc_Title_Elements.ODF_Dc_Title_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Dc_Title
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Dc_Title_Elements.ODF_Dc_Title_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Meta_Generator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Generator_Elements.ODF_Meta_Generator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Meta_Generator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Generator_Elements.ODF_Meta_Generator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Meta_Hyperlink_Behaviour
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Hyperlink_Behaviour_Elements.ODF_Meta_Hyperlink_Behaviour_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Meta_Hyperlink_Behaviour
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Hyperlink_Behaviour_Elements.ODF_Meta_Hyperlink_Behaviour_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Meta_Initial_Creator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Initial_Creator_Elements.ODF_Meta_Initial_Creator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Meta_Initial_Creator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Initial_Creator_Elements.ODF_Meta_Initial_Creator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Meta_Keyword
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Keyword_Elements.ODF_Meta_Keyword_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Meta_Keyword
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Keyword_Elements.ODF_Meta_Keyword_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Meta_Print_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Print_Date_Elements.ODF_Meta_Print_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Meta_Print_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Print_Date_Elements.ODF_Meta_Print_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Meta_Printed_By
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Printed_By_Elements.ODF_Meta_Printed_By_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Meta_Printed_By
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Printed_By_Elements.ODF_Meta_Printed_By_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Meta_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Template_Elements.ODF_Meta_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Meta_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_Template_Elements.ODF_Meta_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Meta_User_Defined
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_User_Defined_Elements.ODF_Meta_User_Defined_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Meta_User_Defined
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Meta_User_Defined_Elements.ODF_Meta_User_Defined_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Body
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Body_Elements.ODF_Office_Body_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Body
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Body_Elements.ODF_Office_Body_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Chart
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Chart_Elements.ODF_Office_Chart_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Chart
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Chart_Elements.ODF_Office_Chart_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Document
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Document_Elements.ODF_Office_Document_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Document
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Document_Elements.ODF_Office_Document_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Document_Content
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Document_Content_Elements.ODF_Office_Document_Content_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Document_Content
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Document_Content_Elements.ODF_Office_Document_Content_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Document_Meta
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Document_Meta_Elements.ODF_Office_Document_Meta_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Document_Meta
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Document_Meta_Elements.ODF_Office_Document_Meta_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Document_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Document_Settings_Elements.ODF_Office_Document_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Document_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Document_Settings_Elements.ODF_Office_Document_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Document_Styles
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Document_Styles_Elements.ODF_Office_Document_Styles_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Document_Styles
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Document_Styles_Elements.ODF_Office_Document_Styles_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Drawing
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Drawing_Elements.ODF_Office_Drawing_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Drawing
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Drawing_Elements.ODF_Office_Drawing_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Style_Handout_Master
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Handout_Master_Elements.ODF_Style_Handout_Master_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Style_Handout_Master
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Style_Handout_Master_Elements.ODF_Style_Handout_Master_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Error_Macro
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Error_Macro_Elements.ODF_Table_Error_Macro_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Error_Macro
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Error_Macro_Elements.ODF_Table_Error_Macro_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Error_Message
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Error_Message_Elements.ODF_Table_Error_Message_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Error_Message
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Error_Message_Elements.ODF_Table_Error_Message_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Filter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Filter_Elements.ODF_Table_Filter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Filter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Filter_Elements.ODF_Table_Filter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Filter_And
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Filter_And_Elements.ODF_Table_Filter_And_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Filter_And
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Filter_And_Elements.ODF_Table_Filter_And_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Filter_Condition
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Filter_Condition_Elements.ODF_Table_Filter_Condition_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Filter_Condition
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Filter_Condition_Elements.ODF_Table_Filter_Condition_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Filter_Or
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Filter_Or_Elements.ODF_Table_Filter_Or_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Filter_Or
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Filter_Or_Elements.ODF_Table_Filter_Or_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Filter_Set_Item
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Filter_Set_Item_Elements.ODF_Table_Filter_Set_Item_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Filter_Set_Item
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Filter_Set_Item_Elements.ODF_Table_Filter_Set_Item_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Help_Message
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Help_Message_Elements.ODF_Table_Help_Message_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Help_Message
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Help_Message_Elements.ODF_Table_Help_Message_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Highlighted_Range
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Highlighted_Range_Elements.ODF_Table_Highlighted_Range_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Highlighted_Range
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Highlighted_Range_Elements.ODF_Table_Highlighted_Range_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Editing_Cycles
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Editing_Cycles_Elements.ODF_Text_Editing_Cycles_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Editing_Cycles
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Editing_Cycles_Elements.ODF_Text_Editing_Cycles_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Editing_Duration
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Editing_Duration_Elements.ODF_Text_Editing_Duration_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Editing_Duration
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Editing_Duration_Elements.ODF_Text_Editing_Duration_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Execute_Macro
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Execute_Macro_Elements.ODF_Text_Execute_Macro_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Execute_Macro
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Execute_Macro_Elements.ODF_Text_Execute_Macro_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Expression
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Expression_Elements.ODF_Text_Expression_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Expression
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Expression_Elements.ODF_Text_Expression_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_File_Name
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_File_Name_Elements.ODF_Text_File_Name_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_File_Name
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_File_Name_Elements.ODF_Text_File_Name_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Font_Face_Decls
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Font_Face_Decls_Elements.ODF_Office_Font_Face_Decls_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Font_Face_Decls
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Font_Face_Decls_Elements.ODF_Office_Font_Face_Decls_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Format_Change
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Format_Change_Elements.ODF_Text_Format_Change_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Format_Change
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Format_Change_Elements.ODF_Text_Format_Change_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_H
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_H_Elements.ODF_Text_H_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_H
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_H_Elements.ODF_Text_H_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Hidden_Paragraph
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Hidden_Paragraph_Elements.ODF_Text_Hidden_Paragraph_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Hidden_Paragraph
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Hidden_Paragraph_Elements.ODF_Text_Hidden_Paragraph_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Hidden_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Hidden_Text_Elements.ODF_Text_Hidden_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Hidden_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Hidden_Text_Elements.ODF_Text_Hidden_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Illustration_Index
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Illustration_Index_Elements.ODF_Text_Illustration_Index_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Illustration_Index
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Illustration_Index_Elements.ODF_Text_Illustration_Index_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Illustration_Index_Entry_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Illustration_Index_Entry_Template_Elements.ODF_Text_Illustration_Index_Entry_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Illustration_Index_Entry_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Illustration_Index_Entry_Template_Elements.ODF_Text_Illustration_Index_Entry_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Illustration_Index_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Illustration_Index_Source_Elements.ODF_Text_Illustration_Index_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Illustration_Index_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Illustration_Index_Source_Elements.ODF_Text_Illustration_Index_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Image
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Image_Elements.ODF_Office_Image_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Image
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Image_Elements.ODF_Office_Image_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Insertion
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Insertion_Elements.ODF_Table_Insertion_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Insertion
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Insertion_Elements.ODF_Table_Insertion_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Insertion_Cut_Off
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Insertion_Cut_Off_Elements.ODF_Table_Insertion_Cut_Off_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Insertion_Cut_Off
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Insertion_Cut_Off_Elements.ODF_Table_Insertion_Cut_Off_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Iteration
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Iteration_Elements.ODF_Table_Iteration_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Iteration
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Iteration_Elements.ODF_Table_Iteration_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Label_Range
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Label_Range_Elements.ODF_Table_Label_Range_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Label_Range
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Label_Range_Elements.ODF_Table_Label_Range_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Label_Ranges
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Label_Ranges_Elements.ODF_Table_Label_Ranges_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Label_Ranges
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Label_Ranges_Elements.ODF_Table_Label_Ranges_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Image_Count
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Image_Count_Elements.ODF_Text_Image_Count_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Image_Count
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Image_Count_Elements.ODF_Text_Image_Count_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Index_Body
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Body_Elements.ODF_Text_Index_Body_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Index_Body
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Body_Elements.ODF_Text_Index_Body_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Index_Entry_Bibliography
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Bibliography_Elements.ODF_Text_Index_Entry_Bibliography_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Index_Entry_Bibliography
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Bibliography_Elements.ODF_Text_Index_Entry_Bibliography_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Index_Entry_Chapter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Chapter_Elements.ODF_Text_Index_Entry_Chapter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Index_Entry_Chapter
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Chapter_Elements.ODF_Text_Index_Entry_Chapter_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Index_Entry_Link_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Link_End_Elements.ODF_Text_Index_Entry_Link_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Index_Entry_Link_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Link_End_Elements.ODF_Text_Index_Entry_Link_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Index_Entry_Link_Start
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Link_Start_Elements.ODF_Text_Index_Entry_Link_Start_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Index_Entry_Link_Start
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Link_Start_Elements.ODF_Text_Index_Entry_Link_Start_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Index_Entry_Page_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Page_Number_Elements.ODF_Text_Index_Entry_Page_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Index_Entry_Page_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Page_Number_Elements.ODF_Text_Index_Entry_Page_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Index_Entry_Span
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Span_Elements.ODF_Text_Index_Entry_Span_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Index_Entry_Span
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Span_Elements.ODF_Text_Index_Entry_Span_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Index_Entry_Tab_Stop
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Tab_Stop_Elements.ODF_Text_Index_Entry_Tab_Stop_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Index_Entry_Tab_Stop
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Tab_Stop_Elements.ODF_Text_Index_Entry_Tab_Stop_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Index_Entry_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Text_Elements.ODF_Text_Index_Entry_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Index_Entry_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Entry_Text_Elements.ODF_Text_Index_Entry_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Index_Source_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Source_Style_Elements.ODF_Text_Index_Source_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Index_Source_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Source_Style_Elements.ODF_Text_Index_Source_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Index_Source_Styles
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Source_Styles_Elements.ODF_Text_Index_Source_Styles_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Index_Source_Styles
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Source_Styles_Elements.ODF_Text_Index_Source_Styles_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Index_Title
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Title_Elements.ODF_Text_Index_Title_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Index_Title
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Title_Elements.ODF_Text_Index_Title_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Index_Title_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Title_Template_Elements.ODF_Text_Index_Title_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Index_Title_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Index_Title_Template_Elements.ODF_Text_Index_Title_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Initial_Creator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Initial_Creator_Elements.ODF_Text_Initial_Creator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Initial_Creator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Initial_Creator_Elements.ODF_Text_Initial_Creator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Insertion
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Insertion_Elements.ODF_Text_Insertion_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Insertion
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Insertion_Elements.ODF_Text_Insertion_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Keywords
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Keywords_Elements.ODF_Text_Keywords_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Keywords
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Keywords_Elements.ODF_Text_Keywords_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Line_Break
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Line_Break_Elements.ODF_Text_Line_Break_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Line_Break
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Line_Break_Elements.ODF_Text_Line_Break_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Linenumbering_Configuration
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Linenumbering_Configuration_Elements.ODF_Text_Linenumbering_Configuration_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Linenumbering_Configuration
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Linenumbering_Configuration_Elements.ODF_Text_Linenumbering_Configuration_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Linenumbering_Separator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Linenumbering_Separator_Elements.ODF_Text_Linenumbering_Separator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Linenumbering_Separator
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Linenumbering_Separator_Elements.ODF_Text_Linenumbering_Separator_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_List
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_List_Elements.ODF_Text_List_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_List
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_List_Elements.ODF_Text_List_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_List_Header
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_List_Header_Elements.ODF_Text_List_Header_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_List_Header
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_List_Header_Elements.ODF_Text_List_Header_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_List_Item
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_List_Item_Elements.ODF_Text_List_Item_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_List_Item
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_List_Item_Elements.ODF_Text_List_Item_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_List_Level_Style_Bullet
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_List_Level_Style_Bullet_Elements.ODF_Text_List_Level_Style_Bullet_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_List_Level_Style_Bullet
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_List_Level_Style_Bullet_Elements.ODF_Text_List_Level_Style_Bullet_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_List_Level_Style_Image
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_List_Level_Style_Image_Elements.ODF_Text_List_Level_Style_Image_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_List_Level_Style_Image
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_List_Level_Style_Image_Elements.ODF_Text_List_Level_Style_Image_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_List_Level_Style_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_List_Level_Style_Number_Elements.ODF_Text_List_Level_Style_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_List_Level_Style_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_List_Level_Style_Number_Elements.ODF_Text_List_Level_Style_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_List_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_List_Style_Elements.ODF_Text_List_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_List_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_List_Style_Elements.ODF_Text_List_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Master_Styles
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Master_Styles_Elements.ODF_Office_Master_Styles_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Master_Styles
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Master_Styles_Elements.ODF_Office_Master_Styles_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Measure
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Measure_Elements.ODF_Text_Measure_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Measure
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Measure_Elements.ODF_Text_Measure_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Meta
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Meta_Elements.ODF_Office_Meta_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Meta
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Meta_Elements.ODF_Office_Meta_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Play
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Play_Elements.ODF_Presentation_Play_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Play
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Play_Elements.ODF_Presentation_Play_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Settings_Elements.ODF_Presentation_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Settings_Elements.ODF_Presentation_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Show
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Show_Elements.ODF_Presentation_Show_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Show
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Show_Elements.ODF_Presentation_Show_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Show_Shape
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Show_Shape_Elements.ODF_Presentation_Show_Shape_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Show_Shape
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Show_Shape_Elements.ODF_Presentation_Show_Shape_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Show_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Show_Text_Elements.ODF_Presentation_Show_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Show_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Show_Text_Elements.ODF_Presentation_Show_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Presentation_Sound
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Sound_Elements.ODF_Presentation_Sound_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Presentation_Sound
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Presentation_Sound_Elements.ODF_Presentation_Sound_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Svg_Title
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Title_Elements.ODF_Svg_Title_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Svg_Title
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Svg_Title_Elements.ODF_Svg_Title_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Movement
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Movement_Elements.ODF_Table_Movement_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Movement
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Movement_Elements.ODF_Table_Movement_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Movement_Cut_Off
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Movement_Cut_Off_Elements.ODF_Table_Movement_Cut_Off_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Movement_Cut_Off
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Movement_Cut_Off_Elements.ODF_Table_Movement_Cut_Off_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Named_Expression
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Named_Expression_Elements.ODF_Table_Named_Expression_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Named_Expression
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Named_Expression_Elements.ODF_Table_Named_Expression_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Named_Expressions
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Named_Expressions_Elements.ODF_Table_Named_Expressions_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Named_Expressions
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Named_Expressions_Elements.ODF_Table_Named_Expressions_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Named_Range
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Named_Range_Elements.ODF_Table_Named_Range_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Named_Range
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Named_Range_Elements.ODF_Table_Named_Range_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Null_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Null_Date_Elements.ODF_Table_Null_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Null_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Null_Date_Elements.ODF_Table_Null_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Operation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Operation_Elements.ODF_Table_Operation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Operation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Operation_Elements.ODF_Table_Operation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Previous
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Previous_Elements.ODF_Table_Previous_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Previous
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Previous_Elements.ODF_Table_Previous_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Scenario
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Scenario_Elements.ODF_Table_Scenario_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Scenario
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Scenario_Elements.ODF_Table_Scenario_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Shapes
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Shapes_Elements.ODF_Table_Shapes_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Shapes
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Shapes_Elements.ODF_Table_Shapes_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Sort
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Sort_Elements.ODF_Table_Sort_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Sort
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Sort_Elements.ODF_Table_Sort_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Sort_By
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Sort_By_Elements.ODF_Table_Sort_By_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Sort_By
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Sort_By_Elements.ODF_Table_Sort_By_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Sort_Groups
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Sort_Groups_Elements.ODF_Table_Sort_Groups_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Sort_Groups
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Sort_Groups_Elements.ODF_Table_Sort_Groups_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Source_Cell_Range
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Source_Cell_Range_Elements.ODF_Table_Source_Cell_Range_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Source_Cell_Range
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Source_Cell_Range_Elements.ODF_Table_Source_Cell_Range_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Source_Range_Address
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Source_Range_Address_Elements.ODF_Table_Source_Range_Address_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Source_Range_Address
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Source_Range_Address_Elements.ODF_Table_Source_Range_Address_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Source_Service
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Source_Service_Elements.ODF_Table_Source_Service_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Source_Service
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Source_Service_Elements.ODF_Table_Source_Service_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Subtotal_Field
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Subtotal_Field_Elements.ODF_Table_Subtotal_Field_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Subtotal_Field
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Subtotal_Field_Elements.ODF_Table_Subtotal_Field_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Subtotal_Rule
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Subtotal_Rule_Elements.ODF_Table_Subtotal_Rule_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Subtotal_Rule
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Subtotal_Rule_Elements.ODF_Table_Subtotal_Rule_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Subtotal_Rules
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Subtotal_Rules_Elements.ODF_Table_Subtotal_Rules_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Subtotal_Rules
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Subtotal_Rules_Elements.ODF_Table_Subtotal_Rules_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Elements.ODF_Table_Table_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Elements.ODF_Table_Table_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table_Cell
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Cell_Elements.ODF_Table_Table_Cell_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table_Cell
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Cell_Elements.ODF_Table_Table_Cell_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Column_Elements.ODF_Table_Table_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table_Column
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Column_Elements.ODF_Table_Table_Column_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table_Column_Group
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Column_Group_Elements.ODF_Table_Table_Column_Group_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table_Column_Group
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Column_Group_Elements.ODF_Table_Table_Column_Group_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Columns_Elements.ODF_Table_Table_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Columns_Elements.ODF_Table_Table_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table_Header_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Header_Columns_Elements.ODF_Table_Table_Header_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table_Header_Columns
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Header_Columns_Elements.ODF_Table_Table_Header_Columns_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table_Header_Rows
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Header_Rows_Elements.ODF_Table_Table_Header_Rows_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table_Header_Rows
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Header_Rows_Elements.ODF_Table_Table_Header_Rows_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table_Row
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Row_Elements.ODF_Table_Table_Row_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table_Row
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Row_Elements.ODF_Table_Table_Row_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table_Row_Group
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Row_Group_Elements.ODF_Table_Table_Row_Group_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table_Row_Group
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Row_Group_Elements.ODF_Table_Table_Row_Group_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table_Rows
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Rows_Elements.ODF_Table_Table_Rows_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table_Rows
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Rows_Elements.ODF_Table_Table_Rows_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Table_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Source_Elements.ODF_Table_Table_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Table_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Table_Source_Elements.ODF_Table_Table_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Target_Range_Address
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Target_Range_Address_Elements.ODF_Table_Target_Range_Address_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Target_Range_Address
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Target_Range_Address_Elements.ODF_Table_Target_Range_Address_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Title
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Title_Elements.ODF_Table_Title_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Title
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Title_Elements.ODF_Table_Title_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Table_Tracked_Changes
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Tracked_Changes_Elements.ODF_Table_Tracked_Changes_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Table_Tracked_Changes
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Table_Tracked_Changes_Elements.ODF_Table_Tracked_Changes_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Meta
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Meta_Elements.ODF_Text_Meta_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Meta
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Meta_Elements.ODF_Text_Meta_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Meta_Field
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Meta_Field_Elements.ODF_Text_Meta_Field_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Meta_Field
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Meta_Field_Elements.ODF_Text_Meta_Field_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Xforms_Model
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Xforms_Model_Elements.ODF_Xforms_Model_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Xforms_Model
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Xforms_Model_Elements.ODF_Xforms_Model_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Modification_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Modification_Date_Elements.ODF_Text_Modification_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Modification_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Modification_Date_Elements.ODF_Text_Modification_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Modification_Time
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Modification_Time_Elements.ODF_Text_Modification_Time_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Modification_Time
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Modification_Time_Elements.ODF_Text_Modification_Time_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Note
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Note_Elements.ODF_Text_Note_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Note
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Note_Elements.ODF_Text_Note_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Note_Body
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Note_Body_Elements.ODF_Text_Note_Body_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Note_Body
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Note_Body_Elements.ODF_Text_Note_Body_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Note_Citation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Note_Citation_Elements.ODF_Text_Note_Citation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Note_Citation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Note_Citation_Elements.ODF_Text_Note_Citation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Note_Continuation_Notice_Backward
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Note_Continuation_Notice_Backward_Elements.ODF_Text_Note_Continuation_Notice_Backward_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Note_Continuation_Notice_Backward
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Note_Continuation_Notice_Backward_Elements.ODF_Text_Note_Continuation_Notice_Backward_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Note_Continuation_Notice_Forward
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Note_Continuation_Notice_Forward_Elements.ODF_Text_Note_Continuation_Notice_Forward_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Note_Continuation_Notice_Forward
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Note_Continuation_Notice_Forward_Elements.ODF_Text_Note_Continuation_Notice_Forward_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Note_Ref
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Note_Ref_Elements.ODF_Text_Note_Ref_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Note_Ref
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Note_Ref_Elements.ODF_Text_Note_Ref_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Notes_Configuration
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Notes_Configuration_Elements.ODF_Text_Notes_Configuration_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Notes_Configuration
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Notes_Configuration_Elements.ODF_Text_Notes_Configuration_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Number_Elements.ODF_Text_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Number_Elements.ODF_Text_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Numbered_Paragraph
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Numbered_Paragraph_Elements.ODF_Text_Numbered_Paragraph_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Numbered_Paragraph
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Numbered_Paragraph_Elements.ODF_Text_Numbered_Paragraph_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Object_Count
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Object_Count_Elements.ODF_Text_Object_Count_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Object_Count
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Object_Count_Elements.ODF_Text_Object_Count_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Object_Index
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Object_Index_Elements.ODF_Text_Object_Index_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Object_Index
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Object_Index_Elements.ODF_Text_Object_Index_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Object_Index_Entry_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Object_Index_Entry_Template_Elements.ODF_Text_Object_Index_Entry_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Object_Index_Entry_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Object_Index_Entry_Template_Elements.ODF_Text_Object_Index_Entry_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Object_Index_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Object_Index_Source_Elements.ODF_Text_Object_Index_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Object_Index_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Object_Index_Source_Elements.ODF_Text_Object_Index_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Outline_Level_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Outline_Level_Style_Elements.ODF_Text_Outline_Level_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Outline_Level_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Outline_Level_Style_Elements.ODF_Text_Outline_Level_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Outline_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Outline_Style_Elements.ODF_Text_Outline_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Outline_Style
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Outline_Style_Elements.ODF_Text_Outline_Style_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_P
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_P_Elements.ODF_Text_P_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_P
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_P_Elements.ODF_Text_P_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Page
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Page_Elements.ODF_Text_Page_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Page
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Page_Elements.ODF_Text_Page_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Page_Continuation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Page_Continuation_Elements.ODF_Text_Page_Continuation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Page_Continuation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Page_Continuation_Elements.ODF_Text_Page_Continuation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Page_Count
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Page_Count_Elements.ODF_Text_Page_Count_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Page_Count
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Page_Count_Elements.ODF_Text_Page_Count_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Page_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Page_Number_Elements.ODF_Text_Page_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Page_Number
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Page_Number_Elements.ODF_Text_Page_Number_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Page_Sequence
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Page_Sequence_Elements.ODF_Text_Page_Sequence_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Page_Sequence
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Page_Sequence_Elements.ODF_Text_Page_Sequence_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Page_Variable_Get
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Page_Variable_Get_Elements.ODF_Text_Page_Variable_Get_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Page_Variable_Get
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Page_Variable_Get_Elements.ODF_Text_Page_Variable_Get_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Page_Variable_Set
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Page_Variable_Set_Elements.ODF_Text_Page_Variable_Set_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Page_Variable_Set
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Page_Variable_Set_Elements.ODF_Text_Page_Variable_Set_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Paragraph_Count
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Paragraph_Count_Elements.ODF_Text_Paragraph_Count_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Paragraph_Count
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Paragraph_Count_Elements.ODF_Text_Paragraph_Count_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Placeholder
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Placeholder_Elements.ODF_Text_Placeholder_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Placeholder
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Placeholder_Elements.ODF_Text_Placeholder_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Presentation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Presentation_Elements.ODF_Office_Presentation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Presentation
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Presentation_Elements.ODF_Office_Presentation_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Print_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Print_Date_Elements.ODF_Text_Print_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Print_Date
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Print_Date_Elements.ODF_Text_Print_Date_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Print_Time
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Print_Time_Elements.ODF_Text_Print_Time_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Print_Time
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Print_Time_Elements.ODF_Text_Print_Time_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Printed_By
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Printed_By_Elements.ODF_Text_Printed_By_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Printed_By
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Printed_By_Elements.ODF_Text_Printed_By_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Reference_Mark
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Reference_Mark_Elements.ODF_Text_Reference_Mark_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Reference_Mark
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Reference_Mark_Elements.ODF_Text_Reference_Mark_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Reference_Mark_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Reference_Mark_End_Elements.ODF_Text_Reference_Mark_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Reference_Mark_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Reference_Mark_End_Elements.ODF_Text_Reference_Mark_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Reference_Mark_Start
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Reference_Mark_Start_Elements.ODF_Text_Reference_Mark_Start_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Reference_Mark_Start
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Reference_Mark_Start_Elements.ODF_Text_Reference_Mark_Start_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Reference_Ref
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Reference_Ref_Elements.ODF_Text_Reference_Ref_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Reference_Ref
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Reference_Ref_Elements.ODF_Text_Reference_Ref_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Ruby
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Ruby_Elements.ODF_Text_Ruby_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Ruby
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Ruby_Elements.ODF_Text_Ruby_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Ruby_Base
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Ruby_Base_Elements.ODF_Text_Ruby_Base_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Ruby_Base
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Ruby_Base_Elements.ODF_Text_Ruby_Base_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Ruby_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Ruby_Text_Elements.ODF_Text_Ruby_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Ruby_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Ruby_Text_Elements.ODF_Text_Ruby_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_S
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_S_Elements.ODF_Text_S_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_S
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_S_Elements.ODF_Text_S_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Script
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Script_Elements.ODF_Office_Script_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Script
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Script_Elements.ODF_Office_Script_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Script
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Script_Elements.ODF_Text_Script_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Script
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Script_Elements.ODF_Text_Script_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Scripts
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Scripts_Elements.ODF_Office_Scripts_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Scripts
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Scripts_Elements.ODF_Office_Scripts_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Section
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Section_Elements.ODF_Text_Section_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Section
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Section_Elements.ODF_Text_Section_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Section_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Section_Source_Elements.ODF_Text_Section_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Section_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Section_Source_Elements.ODF_Text_Section_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sender_City
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_City_Elements.ODF_Text_Sender_City_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sender_City
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_City_Elements.ODF_Text_Sender_City_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sender_Company
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Company_Elements.ODF_Text_Sender_Company_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sender_Company
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Company_Elements.ODF_Text_Sender_Company_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sender_Country
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Country_Elements.ODF_Text_Sender_Country_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sender_Country
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Country_Elements.ODF_Text_Sender_Country_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sender_Email
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Email_Elements.ODF_Text_Sender_Email_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sender_Email
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Email_Elements.ODF_Text_Sender_Email_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sender_Fax
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Fax_Elements.ODF_Text_Sender_Fax_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sender_Fax
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Fax_Elements.ODF_Text_Sender_Fax_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sender_Firstname
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Firstname_Elements.ODF_Text_Sender_Firstname_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sender_Firstname
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Firstname_Elements.ODF_Text_Sender_Firstname_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sender_Initials
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Initials_Elements.ODF_Text_Sender_Initials_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sender_Initials
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Initials_Elements.ODF_Text_Sender_Initials_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sender_Lastname
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Lastname_Elements.ODF_Text_Sender_Lastname_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sender_Lastname
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Lastname_Elements.ODF_Text_Sender_Lastname_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sender_Phone_Private
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Phone_Private_Elements.ODF_Text_Sender_Phone_Private_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sender_Phone_Private
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Phone_Private_Elements.ODF_Text_Sender_Phone_Private_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sender_Phone_Work
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Phone_Work_Elements.ODF_Text_Sender_Phone_Work_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sender_Phone_Work
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Phone_Work_Elements.ODF_Text_Sender_Phone_Work_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sender_Position
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Position_Elements.ODF_Text_Sender_Position_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sender_Position
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Position_Elements.ODF_Text_Sender_Position_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sender_Postal_Code
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Postal_Code_Elements.ODF_Text_Sender_Postal_Code_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sender_Postal_Code
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Postal_Code_Elements.ODF_Text_Sender_Postal_Code_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sender_State_Or_Province
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_State_Or_Province_Elements.ODF_Text_Sender_State_Or_Province_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sender_State_Or_Province
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_State_Or_Province_Elements.ODF_Text_Sender_State_Or_Province_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sender_Street
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Street_Elements.ODF_Text_Sender_Street_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sender_Street
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Street_Elements.ODF_Text_Sender_Street_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sender_Title
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Title_Elements.ODF_Text_Sender_Title_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sender_Title
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sender_Title_Elements.ODF_Text_Sender_Title_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sequence
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sequence_Elements.ODF_Text_Sequence_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sequence
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sequence_Elements.ODF_Text_Sequence_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sequence_Decl
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sequence_Decl_Elements.ODF_Text_Sequence_Decl_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sequence_Decl
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sequence_Decl_Elements.ODF_Text_Sequence_Decl_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sequence_Decls
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sequence_Decls_Elements.ODF_Text_Sequence_Decls_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sequence_Decls
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sequence_Decls_Elements.ODF_Text_Sequence_Decls_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sequence_Ref
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sequence_Ref_Elements.ODF_Text_Sequence_Ref_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sequence_Ref
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sequence_Ref_Elements.ODF_Text_Sequence_Ref_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Settings_Elements.ODF_Office_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Settings
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Settings_Elements.ODF_Office_Settings_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sheet_Name
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sheet_Name_Elements.ODF_Text_Sheet_Name_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sheet_Name
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sheet_Name_Elements.ODF_Text_Sheet_Name_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Soft_Page_Break
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Soft_Page_Break_Elements.ODF_Text_Soft_Page_Break_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Soft_Page_Break
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Soft_Page_Break_Elements.ODF_Text_Soft_Page_Break_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Sort_Key
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sort_Key_Elements.ODF_Text_Sort_Key_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Sort_Key
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Sort_Key_Elements.ODF_Text_Sort_Key_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Span
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Span_Elements.ODF_Text_Span_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Span
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Span_Elements.ODF_Text_Span_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Spreadsheet
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Spreadsheet_Elements.ODF_Office_Spreadsheet_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Spreadsheet
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Spreadsheet_Elements.ODF_Office_Spreadsheet_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Styles
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Styles_Elements.ODF_Office_Styles_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Styles
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Styles_Elements.ODF_Office_Styles_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Subject
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Subject_Elements.ODF_Text_Subject_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Subject
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Subject_Elements.ODF_Text_Subject_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Tab
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Tab_Elements.ODF_Text_Tab_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Tab
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Tab_Elements.ODF_Text_Tab_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Table_Count
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Count_Elements.ODF_Text_Table_Count_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Table_Count
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Count_Elements.ODF_Text_Table_Count_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Table_Formula
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Formula_Elements.ODF_Text_Table_Formula_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Table_Formula
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Formula_Elements.ODF_Text_Table_Formula_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Table_Index
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Index_Elements.ODF_Text_Table_Index_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Table_Index
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Index_Elements.ODF_Text_Table_Index_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Table_Index_Entry_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Index_Entry_Template_Elements.ODF_Text_Table_Index_Entry_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Table_Index_Entry_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Index_Entry_Template_Elements.ODF_Text_Table_Index_Entry_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Table_Index_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Index_Source_Elements.ODF_Text_Table_Index_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Table_Index_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Index_Source_Elements.ODF_Text_Table_Index_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Table_Of_Content
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Of_Content_Elements.ODF_Text_Table_Of_Content_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Table_Of_Content
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Of_Content_Elements.ODF_Text_Table_Of_Content_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Table_Of_Content_Entry_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Of_Content_Entry_Template_Elements.ODF_Text_Table_Of_Content_Entry_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Table_Of_Content_Entry_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Of_Content_Entry_Template_Elements.ODF_Text_Table_Of_Content_Entry_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Table_Of_Content_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Of_Content_Source_Elements.ODF_Text_Table_Of_Content_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Table_Of_Content_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Table_Of_Content_Source_Elements.ODF_Text_Table_Of_Content_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Template_Name
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Template_Name_Elements.ODF_Text_Template_Name_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Template_Name
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Template_Name_Elements.ODF_Text_Template_Name_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Office_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Text_Elements.ODF_Office_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Office_Text
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Office_Text_Elements.ODF_Office_Text_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Text_Input
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Text_Input_Elements.ODF_Text_Text_Input_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Text_Input
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Text_Input_Elements.ODF_Text_Text_Input_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Time
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Time_Elements.ODF_Text_Time_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Time
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Time_Elements.ODF_Text_Time_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Title
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Title_Elements.ODF_Text_Title_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Title
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Title_Elements.ODF_Text_Title_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Toc_Mark
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Toc_Mark_Elements.ODF_Text_Toc_Mark_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Toc_Mark
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Toc_Mark_Elements.ODF_Text_Toc_Mark_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Toc_Mark_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Toc_Mark_End_Elements.ODF_Text_Toc_Mark_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Toc_Mark_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Toc_Mark_End_Elements.ODF_Text_Toc_Mark_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Toc_Mark_Start
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Toc_Mark_Start_Elements.ODF_Text_Toc_Mark_Start_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Toc_Mark_Start
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Toc_Mark_Start_Elements.ODF_Text_Toc_Mark_Start_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Tracked_Changes
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Tracked_Changes_Elements.ODF_Text_Tracked_Changes_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Tracked_Changes
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Tracked_Changes_Elements.ODF_Text_Tracked_Changes_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_User_Defined
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Defined_Elements.ODF_Text_User_Defined_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_User_Defined
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Defined_Elements.ODF_Text_User_Defined_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_User_Field_Decl
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Field_Decl_Elements.ODF_Text_User_Field_Decl_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_User_Field_Decl
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Field_Decl_Elements.ODF_Text_User_Field_Decl_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_User_Field_Decls
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Field_Decls_Elements.ODF_Text_User_Field_Decls_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_User_Field_Decls
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Field_Decls_Elements.ODF_Text_User_Field_Decls_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_User_Field_Get
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Field_Get_Elements.ODF_Text_User_Field_Get_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_User_Field_Get
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Field_Get_Elements.ODF_Text_User_Field_Get_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_User_Field_Input
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Field_Input_Elements.ODF_Text_User_Field_Input_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_User_Field_Input
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Field_Input_Elements.ODF_Text_User_Field_Input_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_User_Index
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Index_Elements.ODF_Text_User_Index_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_User_Index
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Index_Elements.ODF_Text_User_Index_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_User_Index_Entry_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Index_Entry_Template_Elements.ODF_Text_User_Index_Entry_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_User_Index_Entry_Template
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Index_Entry_Template_Elements.ODF_Text_User_Index_Entry_Template_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_User_Index_Mark
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Index_Mark_Elements.ODF_Text_User_Index_Mark_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_User_Index_Mark
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Index_Mark_Elements.ODF_Text_User_Index_Mark_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_User_Index_Mark_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Index_Mark_End_Elements.ODF_Text_User_Index_Mark_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_User_Index_Mark_End
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Index_Mark_End_Elements.ODF_Text_User_Index_Mark_End_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_User_Index_Mark_Start
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Index_Mark_Start_Elements.ODF_Text_User_Index_Mark_Start_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_User_Index_Mark_Start
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Index_Mark_Start_Elements.ODF_Text_User_Index_Mark_Start_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_User_Index_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Index_Source_Elements.ODF_Text_User_Index_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_User_Index_Source
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_User_Index_Source_Elements.ODF_Text_User_Index_Source_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Variable_Decl
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Variable_Decl_Elements.ODF_Text_Variable_Decl_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Variable_Decl
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Variable_Decl_Elements.ODF_Text_Variable_Decl_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Variable_Decls
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Variable_Decls_Elements.ODF_Text_Variable_Decls_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Variable_Decls
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Variable_Decls_Elements.ODF_Text_Variable_Decls_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Variable_Get
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Variable_Get_Elements.ODF_Text_Variable_Get_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Variable_Get
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Variable_Get_Elements.ODF_Text_Variable_Get_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Variable_Input
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Variable_Input_Elements.ODF_Text_Variable_Input_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Variable_Input
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Variable_Input_Elements.ODF_Text_Variable_Input_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Variable_Set
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Variable_Set_Elements.ODF_Text_Variable_Set_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Variable_Set
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Variable_Set_Elements.ODF_Text_Variable_Set_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text_Word_Count
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Word_Count_Elements.ODF_Text_Word_Count_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text_Word_Count
    (Self    : in out Abstract_ODF_Visitor;
     Element : ODF.DOM.Text_Word_Count_Elements.ODF_Text_Word_Count_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

end ODF.DOM.Visitors;
