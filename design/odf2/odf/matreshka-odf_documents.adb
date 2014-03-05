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
with Matreshka.DOM_Nodes;

with Matreshka.ODF_String_Constants;
with Matreshka.ODF_Number.Am_Pm_Elements;
with Matreshka.ODF_Anim.Animate_Elements;
with Matreshka.ODF_Anim.AnimateColor_Elements;
with Matreshka.ODF_Anim.AnimateMotion_Elements;
with Matreshka.ODF_Anim.AnimateTransform_Elements;
with Matreshka.ODF_Anim.Audio_Elements;
with Matreshka.ODF_Anim.Command_Elements;
with Matreshka.ODF_Anim.Iterate_Elements;
with Matreshka.ODF_Anim.Par_Elements;
with Matreshka.ODF_Anim.Param_Elements;
with Matreshka.ODF_Anim.Seq_Elements;
with Matreshka.ODF_Anim.Set_Elements;
with Matreshka.ODF_Anim.TransitionFilter_Elements;
with Matreshka.ODF_Office.Annotation_Elements;
with Matreshka.ODF_Office.Annotation_End_Elements;
with Matreshka.ODF_Db.Application_Connection_Settings_Elements;
with Matreshka.ODF_Db.Auto_Increment_Elements;
with Matreshka.ODF_Chart.Axis_Elements;
with Matreshka.ODF_Number.Boolean_Elements;
with Matreshka.ODF_Number.Boolean_Style_Elements;
with Matreshka.ODF_Form.Button_Elements;
with Matreshka.ODF_Chart.Categories_Elements;
with Matreshka.ODF_Db.Character_Set_Elements;
with Matreshka.ODF_Chart.Chart_Elements;
with Matreshka.ODF_Form.Checkbox_Elements;
with Matreshka.ODF_Db.Column_Elements;
with Matreshka.ODF_Form.Column_Elements;
with Matreshka.ODF_Db.Column_Definition_Elements;
with Matreshka.ODF_Db.Column_Definitions_Elements;
with Matreshka.ODF_Db.Columns_Elements;
with Matreshka.ODF_Form.Combobox_Elements;
with Matreshka.ODF_Db.Component_Elements;
with Matreshka.ODF_Db.Component_Collection_Elements;
with Matreshka.ODF_Chart.Data_Label_Elements;
with Matreshka.ODF_Chart.Data_Point_Elements;
with Matreshka.ODF_Chart.Domain_Elements;
with Matreshka.ODF_Chart.Equation_Elements;
with Matreshka.ODF_Chart.Error_Indicator_Elements;
with Matreshka.ODF_Chart.Floor_Elements;
with Matreshka.ODF_Chart.Footer_Elements;
with Matreshka.ODF_Chart.Grid_Elements;
with Matreshka.ODF_Chart.Label_Separator_Elements;
with Matreshka.ODF_Chart.Legend_Elements;
with Matreshka.ODF_Chart.Mean_Value_Elements;
with Matreshka.ODF_Chart.Plot_Area_Elements;
with Matreshka.ODF_Chart.Regression_Curve_Elements;
with Matreshka.ODF_Chart.Series_Elements;
with Matreshka.ODF_Chart.Stock_Gain_Marker_Elements;
with Matreshka.ODF_Chart.Stock_Loss_Marker_Elements;
with Matreshka.ODF_Chart.Stock_Range_Line_Elements;
with Matreshka.ODF_Chart.Subtitle_Elements;
with Matreshka.ODF_Chart.Symbol_Image_Elements;
with Matreshka.ODF_Chart.Title_Elements;
with Matreshka.ODF_Chart.Wall_Elements;
with Matreshka.ODF_Draw.A_Elements;
with Matreshka.ODF_Presentation.Animation_Group_Elements;
with Matreshka.ODF_Presentation.Animations_Elements;
with Matreshka.ODF_Draw.Applet_Elements;
with Matreshka.ODF_Draw.Area_Circle_Elements;
with Matreshka.ODF_Draw.Area_Polygon_Elements;
with Matreshka.ODF_Draw.Area_Rectangle_Elements;
with Matreshka.ODF_Draw.Caption_Elements;
with Matreshka.ODF_Draw.Circle_Elements;
with Matreshka.ODF_Text.A_Elements;
with Matreshka.ODF_Text.Alphabetical_Index_Elements;
with Matreshka.ODF_Text.Alphabetical_Index_Auto_Mark_File_Elements;
with Matreshka.ODF_Text.Alphabetical_Index_Entry_Template_Elements;
with Matreshka.ODF_Text.Alphabetical_Index_Mark_Elements;
with Matreshka.ODF_Text.Alphabetical_Index_Mark_End_Elements;
with Matreshka.ODF_Text.Alphabetical_Index_Mark_Start_Elements;
with Matreshka.ODF_Text.Alphabetical_Index_Source_Elements;
with Matreshka.ODF_Text.Author_Initials_Elements;
with Matreshka.ODF_Text.Author_Name_Elements;
with Matreshka.ODF_Meta.Auto_Reload_Elements;
with Matreshka.ODF_Office.Automatic_Styles_Elements;
with Matreshka.ODF_Style.Background_Image_Elements;
with Matreshka.ODF_Style.Chart_Properties_Elements;
with Matreshka.ODF_Style.Column_Elements;
with Matreshka.ODF_Style.Column_Sep_Elements;
with Matreshka.ODF_Style.Columns_Elements;
with Matreshka.ODF_Table.Background_Elements;
with Matreshka.ODF_Text.Bibliography_Configuration_Elements;
with Matreshka.ODF_Office.Binary_Data_Elements;
with Matreshka.ODF_Table.Body_Elements;
with Matreshka.ODF_Table.Calculation_Settings_Elements;
with Matreshka.ODF_Table.Cell_Address_Elements;
with Matreshka.ODF_Table.Cell_Content_Change_Elements;
with Matreshka.ODF_Table.Cell_Content_Deletion_Elements;
with Matreshka.ODF_Table.Cell_Range_Source_Elements;
with Matreshka.ODF_Table.Change_Deletion_Elements;
with Matreshka.ODF_Table.Change_Track_Table_Cell_Elements;
with Matreshka.ODF_Text.Bibliography_Elements;
with Matreshka.ODF_Text.Bibliography_Entry_Template_Elements;
with Matreshka.ODF_Text.Bibliography_Mark_Elements;
with Matreshka.ODF_Text.Bibliography_Source_Elements;
with Matreshka.ODF_Text.Bookmark_Elements;
with Matreshka.ODF_Text.Bookmark_End_Elements;
with Matreshka.ODF_Text.Bookmark_Ref_Elements;
with Matreshka.ODF_Text.Bookmark_Start_Elements;
with Matreshka.ODF_Text.Change_Elements;
with Matreshka.ODF_Text.Change_End_Elements;
with Matreshka.ODF_Office.Change_Info_Elements;
with Matreshka.ODF_Text.Change_Start_Elements;
with Matreshka.ODF_Text.Changed_Region_Elements;
with Matreshka.ODF_Text.Chapter_Elements;
with Matreshka.ODF_Text.Character_Count_Elements;
with Matreshka.ODF_Text.Conditional_Text_Elements;
with Matreshka.ODF_Config.Config_Item_Elements;
with Matreshka.ODF_Config.Config_Item_Map_Entry_Elements;
with Matreshka.ODF_Config.Config_Item_Map_Indexed_Elements;
with Matreshka.ODF_Config.Config_Item_Map_Named_Elements;
with Matreshka.ODF_Config.Config_Item_Set_Elements;
with Matreshka.ODF_Db.Connection_Data_Elements;
with Matreshka.ODF_Db.Connection_Resource_Elements;
with Matreshka.ODF_Db.Data_Source_Elements;
with Matreshka.ODF_Db.Data_Source_Setting_Elements;
with Matreshka.ODF_Db.Data_Source_Setting_Value_Elements;
with Matreshka.ODF_Db.Data_Source_Settings_Elements;
with Matreshka.ODF_Db.Database_Description_Elements;
with Matreshka.ODF_Db.Delimiter_Elements;
with Matreshka.ODF_Db.Driver_Settings_Elements;
with Matreshka.ODF_Db.File_Based_Database_Elements;
with Matreshka.ODF_Draw.Fill_Image_Elements;
with Matreshka.ODF_Db.Filter_Statement_Elements;
with Matreshka.ODF_Db.Forms_Elements;
with Matreshka.ODF_Db.Index_Elements;
with Matreshka.ODF_Db.Index_Column_Elements;
with Matreshka.ODF_Db.Index_Columns_Elements;
with Matreshka.ODF_Db.Indices_Elements;
with Matreshka.ODF_Db.Key_Elements;
with Matreshka.ODF_Db.Key_Column_Elements;
with Matreshka.ODF_Db.Key_Columns_Elements;
with Matreshka.ODF_Db.Keys_Elements;
with Matreshka.ODF_Db.Login_Elements;
with Matreshka.ODF_Db.Order_Statement_Elements;
with Matreshka.ODF_Db.Queries_Elements;
with Matreshka.ODF_Db.Query_Elements;
with Matreshka.ODF_Db.Query_Collection_Elements;
with Matreshka.ODF_Db.Reports_Elements;
with Matreshka.ODF_Db.Schema_Definition_Elements;
with Matreshka.ODF_Db.Server_Database_Elements;
with Matreshka.ODF_Db.Table_Definition_Elements;
with Matreshka.ODF_Db.Table_Definitions_Elements;
with Matreshka.ODF_Db.Table_Exclude_Filter_Elements;
with Matreshka.ODF_Db.Table_Filter_Elements;
with Matreshka.ODF_Db.Table_Filter_Pattern_Elements;
with Matreshka.ODF_Db.Table_Include_Filter_Elements;
with Matreshka.ODF_Db.Table_Representation_Elements;
with Matreshka.ODF_Db.Table_Representations_Elements;
with Matreshka.ODF_Db.Table_Setting_Elements;
with Matreshka.ODF_Db.Table_Settings_Elements;
with Matreshka.ODF_Db.Table_Type_Elements;
with Matreshka.ODF_Db.Table_Type_Filter_Elements;
with Matreshka.ODF_Db.Update_Table_Elements;
with Matreshka.ODF_Draw.Connector_Elements;
with Matreshka.ODF_Draw.Contour_Path_Elements;
with Matreshka.ODF_Draw.Contour_Polygon_Elements;
with Matreshka.ODF_Draw.Control_Elements;
with Matreshka.ODF_Form.Connection_Resource_Elements;
with Matreshka.ODF_Table.Consolidation_Elements;
with Matreshka.ODF_Table.Content_Validation_Elements;
with Matreshka.ODF_Table.Content_Validations_Elements;
with Matreshka.ODF_Table.Covered_Table_Cell_Elements;
with Matreshka.ODF_Meta.Creation_Date_Elements;
with Matreshka.ODF_Text.Creation_Date_Elements;
with Matreshka.ODF_Text.Creation_Time_Elements;
with Matreshka.ODF_Dc.Creator_Elements;
with Matreshka.ODF_Dr3d.Cube_Elements;
with Matreshka.ODF_Number.Currency_Style_Elements;
with Matreshka.ODF_Number.Currency_Symbol_Elements;
with Matreshka.ODF_Draw.Custom_Shape_Elements;
with Matreshka.ODF_Form.Date_Elements;
with Matreshka.ODF_Meta.Date_String_Elements;
with Matreshka.ODF_Number.Date_Style_Elements;
with Matreshka.ODF_Number.Day_Elements;
with Matreshka.ODF_Number.Day_Of_Week_Elements;
with Matreshka.ODF_Number.Embedded_Text_Elements;
with Matreshka.ODF_Office.Database_Elements;
with Matreshka.ODF_Office.Dde_Source_Elements;
with Matreshka.ODF_Presentation.Date_Time_Elements;
with Matreshka.ODF_Presentation.Date_Time_Decl_Elements;
with Matreshka.ODF_Style.Default_Page_Layout_Elements;
with Matreshka.ODF_Style.Default_Style_Elements;
with Matreshka.ODF_Style.Drawing_Page_Properties_Elements;
with Matreshka.ODF_Style.Drop_Cap_Elements;
with Matreshka.ODF_Svg.Definition_Src_Elements;
with Matreshka.ODF_Table.Dde_Link_Elements;
with Matreshka.ODF_Presentation.Dim_Elements;
with Matreshka.ODF_Draw.Enhanced_Geometry_Elements;
with Matreshka.ODF_Dr3d.Extrude_Elements;
with Matreshka.ODF_Dr3d.Light_Elements;
with Matreshka.ODF_Dr3d.Rotate_Elements;
with Matreshka.ODF_Dr3d.Scene_Elements;
with Matreshka.ODF_Dr3d.Sphere_Elements;
with Matreshka.ODF_Svg.Desc_Elements;
with Matreshka.ODF_Draw.Ellipse_Elements;
with Matreshka.ODF_Draw.Equation_Elements;
with Matreshka.ODF_Number.Era_Elements;
with Matreshka.ODF_Table.Even_Columns_Elements;
with Matreshka.ODF_Table.Even_Rows_Elements;
with Matreshka.ODF_Script.Event_Listener_Elements;
with Matreshka.ODF_Form.File_Elements;
with Matreshka.ODF_Form.Fixed_Text_Elements;
with Matreshka.ODF_Presentation.Event_Listener_Elements;
with Matreshka.ODF_Draw.Floating_Frame_Elements;
with Matreshka.ODF_Form.Form_Elements;
with Matreshka.ODF_Form.Formatted_Text_Elements;
with Matreshka.ODF_Number.Fraction_Elements;
with Matreshka.ODF_Draw.Frame_Elements;
with Matreshka.ODF_Form.Frame_Elements;
with Matreshka.ODF_Form.Generic_Control_Elements;
with Matreshka.ODF_Office.Event_Listeners_Elements;
with Matreshka.ODF_Style.Font_Face_Elements;
with Matreshka.ODF_Svg.Font_Face_Format_Elements;
with Matreshka.ODF_Svg.Font_Face_Name_Elements;
with Matreshka.ODF_Svg.Font_Face_Src_Elements;
with Matreshka.ODF_Svg.Font_Face_Uri_Elements;
with Matreshka.ODF_Table.First_Column_Elements;
with Matreshka.ODF_Table.First_Row_Elements;
with Matreshka.ODF_Office.Forms_Elements;
with Matreshka.ODF_Presentation.Footer_Elements;
with Matreshka.ODF_Style.Footer_Elements;
with Matreshka.ODF_Presentation.Footer_Decl_Elements;
with Matreshka.ODF_Style.Footer_Left_Elements;
with Matreshka.ODF_Style.Footer_Style_Elements;
with Matreshka.ODF_Style.Footnote_Sep_Elements;
with Matreshka.ODF_Draw.G_Elements;
with Matreshka.ODF_Draw.Glue_Point_Elements;
with Matreshka.ODF_Draw.Gradient_Elements;
with Matreshka.ODF_Style.Graphic_Properties_Elements;
with Matreshka.ODF_Form.Grid_Elements;
with Matreshka.ODF_Draw.Handle_Elements;
with Matreshka.ODF_Draw.Hatch_Elements;
with Matreshka.ODF_Form.Hidden_Elements;
with Matreshka.ODF_Number.Hours_Elements;
with Matreshka.ODF_Form.Image_Elements;
with Matreshka.ODF_Form.Image_Frame_Elements;
with Matreshka.ODF_Presentation.Header_Elements;
with Matreshka.ODF_Style.Header_Elements;
with Matreshka.ODF_Presentation.Header_Decl_Elements;
with Matreshka.ODF_Style.Header_Footer_Properties_Elements;
with Matreshka.ODF_Style.Header_Left_Elements;
with Matreshka.ODF_Style.Header_Style_Elements;
with Matreshka.ODF_Presentation.Hide_Shape_Elements;
with Matreshka.ODF_Presentation.Hide_Text_Elements;
with Matreshka.ODF_Draw.Image_Elements;
with Matreshka.ODF_Draw.Image_Map_Elements;
with Matreshka.ODF_Form.Item_Elements;
with Matreshka.ODF_Draw.Layer_Elements;
with Matreshka.ODF_Draw.Layer_Set_Elements;
with Matreshka.ODF_Draw.Line_Elements;
with Matreshka.ODF_Style.List_Level_Label_Alignment_Elements;
with Matreshka.ODF_Style.List_Level_Properties_Elements;
with Matreshka.ODF_Draw.Marker_Elements;
with Matreshka.ODF_Svg.LinearGradient_Elements;
with Matreshka.ODF_Form.List_Property_Elements;
with Matreshka.ODF_Form.List_Value_Elements;
with Matreshka.ODF_Form.Listbox_Elements;
with Matreshka.ODF_Style.Map_Elements;
with Matreshka.ODF_Style.Master_Page_Elements;
with Matreshka.ODF_Math.Math_Elements;
with Matreshka.ODF_Draw.Measure_Elements;
with Matreshka.ODF_Number.Minutes_Elements;
with Matreshka.ODF_Number.Month_Elements;
with Matreshka.ODF_Presentation.Notes_Elements;
with Matreshka.ODF_Form.Number_Elements;
with Matreshka.ODF_Number.Number_Elements;
with Matreshka.ODF_Number.Number_Style_Elements;
with Matreshka.ODF_Draw.Object_Elements;
with Matreshka.ODF_Draw.Object_Ole_Elements;
with Matreshka.ODF_Draw.Opacity_Elements;
with Matreshka.ODF_Form.Option_Elements;
with Matreshka.ODF_Draw.Page_Elements;
with Matreshka.ODF_Style.Page_Layout_Elements;
with Matreshka.ODF_Style.Page_Layout_Properties_Elements;
with Matreshka.ODF_Draw.Page_Thumbnail_Elements;
with Matreshka.ODF_Style.Paragraph_Properties_Elements;
with Matreshka.ODF_Draw.Param_Elements;
with Matreshka.ODF_Form.Password_Elements;
with Matreshka.ODF_Draw.Path_Elements;
with Matreshka.ODF_Number.Percentage_Style_Elements;
with Matreshka.ODF_Presentation.Placeholder_Elements;
with Matreshka.ODF_Draw.Plugin_Elements;
with Matreshka.ODF_Draw.Polygon_Elements;
with Matreshka.ODF_Draw.Polyline_Elements;
with Matreshka.ODF_Style.Presentation_Page_Layout_Elements;
with Matreshka.ODF_Form.Properties_Elements;
with Matreshka.ODF_Form.Property_Elements;
with Matreshka.ODF_Number.Quarter_Elements;
with Matreshka.ODF_Svg.RadialGradient_Elements;
with Matreshka.ODF_Form.Radio_Elements;
with Matreshka.ODF_Draw.Rect_Elements;
with Matreshka.ODF_Style.Region_Center_Elements;
with Matreshka.ODF_Style.Region_Left_Elements;
with Matreshka.ODF_Style.Region_Right_Elements;
with Matreshka.ODF_Draw.Regular_Polygon_Elements;
with Matreshka.ODF_Style.Ruby_Properties_Elements;
with Matreshka.ODF_Draw.Stroke_Dash_Elements;
with Matreshka.ODF_Number.Scientific_Number_Elements;
with Matreshka.ODF_Number.Seconds_Elements;
with Matreshka.ODF_Style.Section_Properties_Elements;
with Matreshka.ODF_Svg.Stop_Elements;
with Matreshka.ODF_Number.Text_Elements;
with Matreshka.ODF_Style.Style_Elements;
with Matreshka.ODF_Style.Tab_Stop_Elements;
with Matreshka.ODF_Style.Tab_Stops_Elements;
with Matreshka.ODF_Style.Table_Cell_Properties_Elements;
with Matreshka.ODF_Style.Table_Column_Properties_Elements;
with Matreshka.ODF_Style.Table_Properties_Elements;
with Matreshka.ODF_Style.Table_Row_Properties_Elements;
with Matreshka.ODF_Form.Text_Elements;
with Matreshka.ODF_Draw.Text_Box_Elements;
with Matreshka.ODF_Number.Text_Content_Elements;
with Matreshka.ODF_Style.Text_Properties_Elements;
with Matreshka.ODF_Number.Text_Style_Elements;
with Matreshka.ODF_Form.Textarea_Elements;
with Matreshka.ODF_Form.Time_Elements;
with Matreshka.ODF_Number.Time_Style_Elements;
with Matreshka.ODF_Form.Value_Range_Elements;
with Matreshka.ODF_Number.Week_Of_Year_Elements;
with Matreshka.ODF_Number.Year_Elements;
with Matreshka.ODF_Table.Cut_Offs_Elements;
with Matreshka.ODF_Table.Data_Pilot_Display_Info_Elements;
with Matreshka.ODF_Table.Data_Pilot_Field_Elements;
with Matreshka.ODF_Table.Data_Pilot_Field_Reference_Elements;
with Matreshka.ODF_Table.Data_Pilot_Group_Elements;
with Matreshka.ODF_Table.Data_Pilot_Group_Member_Elements;
with Matreshka.ODF_Table.Data_Pilot_Groups_Elements;
with Matreshka.ODF_Table.Data_Pilot_Layout_Info_Elements;
with Matreshka.ODF_Table.Data_Pilot_Level_Elements;
with Matreshka.ODF_Table.Data_Pilot_Member_Elements;
with Matreshka.ODF_Table.Data_Pilot_Members_Elements;
with Matreshka.ODF_Table.Data_Pilot_Sort_Info_Elements;
with Matreshka.ODF_Table.Data_Pilot_Subtotal_Elements;
with Matreshka.ODF_Table.Data_Pilot_Subtotals_Elements;
with Matreshka.ODF_Table.Data_Pilot_Table_Elements;
with Matreshka.ODF_Table.Data_Pilot_Tables_Elements;
with Matreshka.ODF_Table.Database_Range_Elements;
with Matreshka.ODF_Table.Database_Ranges_Elements;
with Matreshka.ODF_Table.Database_Source_Query_Elements;
with Matreshka.ODF_Table.Database_Source_Sql_Elements;
with Matreshka.ODF_Table.Database_Source_Table_Elements;
with Matreshka.ODF_Table.Dde_Links_Elements;
with Matreshka.ODF_Table.Deletion_Elements;
with Matreshka.ODF_Table.Deletions_Elements;
with Matreshka.ODF_Table.Dependencies_Elements;
with Matreshka.ODF_Table.Dependency_Elements;
with Matreshka.ODF_Table.Desc_Elements;
with Matreshka.ODF_Table.Last_Column_Elements;
with Matreshka.ODF_Table.Last_Row_Elements;
with Matreshka.ODF_Table.Odd_Columns_Elements;
with Matreshka.ODF_Table.Odd_Rows_Elements;
with Matreshka.ODF_Table.Table_Template_Elements;
with Matreshka.ODF_Text.Creator_Elements;
with Matreshka.ODF_Text.Database_Display_Elements;
with Matreshka.ODF_Text.Database_Name_Elements;
with Matreshka.ODF_Text.Database_Next_Elements;
with Matreshka.ODF_Text.Database_Row_Number_Elements;
with Matreshka.ODF_Text.Database_Row_Select_Elements;
with Matreshka.ODF_Dc.Date_Elements;
with Matreshka.ODF_Text.Date_Elements;
with Matreshka.ODF_Text.Dde_Connection_Elements;
with Matreshka.ODF_Text.Dde_Connection_Decl_Elements;
with Matreshka.ODF_Text.Dde_Connection_Decls_Elements;
with Matreshka.ODF_Text.Deletion_Elements;
with Matreshka.ODF_Dc.Description_Elements;
with Matreshka.ODF_Table.Detective_Elements;
with Matreshka.ODF_Text.Description_Elements;
with Matreshka.ODF_Meta.Document_Statistic_Elements;
with Matreshka.ODF_Meta.Editing_Cycles_Elements;
with Matreshka.ODF_Meta.Editing_Duration_Elements;
with Matreshka.ODF_Dc.Language_Elements;
with Matreshka.ODF_Dc.Subject_Elements;
with Matreshka.ODF_Dc.Title_Elements;
with Matreshka.ODF_Meta.Generator_Elements;
with Matreshka.ODF_Meta.Hyperlink_Behaviour_Elements;
with Matreshka.ODF_Meta.Initial_Creator_Elements;
with Matreshka.ODF_Meta.Keyword_Elements;
with Matreshka.ODF_Meta.Print_Date_Elements;
with Matreshka.ODF_Meta.Printed_By_Elements;
with Matreshka.ODF_Meta.Template_Elements;
with Matreshka.ODF_Meta.User_Defined_Elements;
with Matreshka.ODF_Office.Body_Elements;
with Matreshka.ODF_Office.Chart_Elements;
with Matreshka.ODF_Office.Document_Elements;
with Matreshka.ODF_Office.Document_Content_Elements;
with Matreshka.ODF_Office.Document_Meta_Elements;
with Matreshka.ODF_Office.Document_Settings_Elements;
with Matreshka.ODF_Office.Document_Styles_Elements;
with Matreshka.ODF_Office.Drawing_Elements;
with Matreshka.ODF_Style.Handout_Master_Elements;
with Matreshka.ODF_Table.Error_Macro_Elements;
with Matreshka.ODF_Table.Error_Message_Elements;
with Matreshka.ODF_Table.Filter_Elements;
with Matreshka.ODF_Table.Filter_And_Elements;
with Matreshka.ODF_Table.Filter_Condition_Elements;
with Matreshka.ODF_Table.Filter_Or_Elements;
with Matreshka.ODF_Table.Filter_Set_Item_Elements;
with Matreshka.ODF_Table.Help_Message_Elements;
with Matreshka.ODF_Table.Highlighted_Range_Elements;
with Matreshka.ODF_Text.Editing_Cycles_Elements;
with Matreshka.ODF_Text.Editing_Duration_Elements;
with Matreshka.ODF_Text.Execute_Macro_Elements;
with Matreshka.ODF_Text.Expression_Elements;
with Matreshka.ODF_Text.File_Name_Elements;
with Matreshka.ODF_Office.Font_Face_Decls_Elements;
with Matreshka.ODF_Text.Format_Change_Elements;
with Matreshka.ODF_Text.H_Elements;
with Matreshka.ODF_Text.Hidden_Paragraph_Elements;
with Matreshka.ODF_Text.Hidden_Text_Elements;
with Matreshka.ODF_Text.Illustration_Index_Elements;
with Matreshka.ODF_Text.Illustration_Index_Entry_Template_Elements;
with Matreshka.ODF_Text.Illustration_Index_Source_Elements;
with Matreshka.ODF_Office.Image_Elements;
with Matreshka.ODF_Table.Insertion_Elements;
with Matreshka.ODF_Table.Insertion_Cut_Off_Elements;
with Matreshka.ODF_Table.Iteration_Elements;
with Matreshka.ODF_Table.Label_Range_Elements;
with Matreshka.ODF_Table.Label_Ranges_Elements;
with Matreshka.ODF_Text.Image_Count_Elements;
with Matreshka.ODF_Text.Index_Body_Elements;
with Matreshka.ODF_Text.Index_Entry_Bibliography_Elements;
with Matreshka.ODF_Text.Index_Entry_Chapter_Elements;
with Matreshka.ODF_Text.Index_Entry_Link_End_Elements;
with Matreshka.ODF_Text.Index_Entry_Link_Start_Elements;
with Matreshka.ODF_Text.Index_Entry_Page_Number_Elements;
with Matreshka.ODF_Text.Index_Entry_Span_Elements;
with Matreshka.ODF_Text.Index_Entry_Tab_Stop_Elements;
with Matreshka.ODF_Text.Index_Entry_Text_Elements;
with Matreshka.ODF_Text.Index_Source_Style_Elements;
with Matreshka.ODF_Text.Index_Source_Styles_Elements;
with Matreshka.ODF_Text.Index_Title_Elements;
with Matreshka.ODF_Text.Index_Title_Template_Elements;
with Matreshka.ODF_Text.Initial_Creator_Elements;
with Matreshka.ODF_Text.Insertion_Elements;
with Matreshka.ODF_Text.Keywords_Elements;
with Matreshka.ODF_Text.Line_Break_Elements;
with Matreshka.ODF_Text.Linenumbering_Configuration_Elements;
with Matreshka.ODF_Text.Linenumbering_Separator_Elements;
with Matreshka.ODF_Text.List_Elements;
with Matreshka.ODF_Text.List_Header_Elements;
with Matreshka.ODF_Text.List_Item_Elements;
with Matreshka.ODF_Text.List_Level_Style_Bullet_Elements;
with Matreshka.ODF_Text.List_Level_Style_Image_Elements;
with Matreshka.ODF_Text.List_Level_Style_Number_Elements;
with Matreshka.ODF_Text.List_Style_Elements;
with Matreshka.ODF_Office.Master_Styles_Elements;
with Matreshka.ODF_Text.Measure_Elements;
with Matreshka.ODF_Office.Meta_Elements;
with Matreshka.ODF_Presentation.Play_Elements;
with Matreshka.ODF_Presentation.Settings_Elements;
with Matreshka.ODF_Presentation.Show_Elements;
with Matreshka.ODF_Presentation.Show_Shape_Elements;
with Matreshka.ODF_Presentation.Show_Text_Elements;
with Matreshka.ODF_Presentation.Sound_Elements;
with Matreshka.ODF_Svg.Title_Elements;
with Matreshka.ODF_Table.Movement_Elements;
with Matreshka.ODF_Table.Movement_Cut_Off_Elements;
with Matreshka.ODF_Table.Named_Expression_Elements;
with Matreshka.ODF_Table.Named_Expressions_Elements;
with Matreshka.ODF_Table.Named_Range_Elements;
with Matreshka.ODF_Table.Null_Date_Elements;
with Matreshka.ODF_Table.Operation_Elements;
with Matreshka.ODF_Table.Previous_Elements;
with Matreshka.ODF_Table.Scenario_Elements;
with Matreshka.ODF_Table.Shapes_Elements;
with Matreshka.ODF_Table.Sort_Elements;
with Matreshka.ODF_Table.Sort_By_Elements;
with Matreshka.ODF_Table.Sort_Groups_Elements;
with Matreshka.ODF_Table.Source_Cell_Range_Elements;
with Matreshka.ODF_Table.Source_Range_Address_Elements;
with Matreshka.ODF_Table.Source_Service_Elements;
with Matreshka.ODF_Table.Subtotal_Field_Elements;
with Matreshka.ODF_Table.Subtotal_Rule_Elements;
with Matreshka.ODF_Table.Subtotal_Rules_Elements;
with Matreshka.ODF_Table.Table_Elements;
with Matreshka.ODF_Table.Table_Cell_Elements;
with Matreshka.ODF_Table.Table_Column_Elements;
with Matreshka.ODF_Table.Table_Column_Group_Elements;
with Matreshka.ODF_Table.Table_Columns_Elements;
with Matreshka.ODF_Table.Table_Header_Columns_Elements;
with Matreshka.ODF_Table.Table_Header_Rows_Elements;
with Matreshka.ODF_Table.Table_Row_Elements;
with Matreshka.ODF_Table.Table_Row_Group_Elements;
with Matreshka.ODF_Table.Table_Rows_Elements;
with Matreshka.ODF_Table.Table_Source_Elements;
with Matreshka.ODF_Table.Target_Range_Address_Elements;
with Matreshka.ODF_Table.Title_Elements;
with Matreshka.ODF_Table.Tracked_Changes_Elements;
with Matreshka.ODF_Text.Meta_Elements;
with Matreshka.ODF_Text.Meta_Field_Elements;
with Matreshka.ODF_Xforms.Model_Elements;
with Matreshka.ODF_Text.Modification_Date_Elements;
with Matreshka.ODF_Text.Modification_Time_Elements;
with Matreshka.ODF_Text.Note_Elements;
with Matreshka.ODF_Text.Note_Body_Elements;
with Matreshka.ODF_Text.Note_Citation_Elements;
with Matreshka.ODF_Text.Note_Continuation_Notice_Backward_Elements;
with Matreshka.ODF_Text.Note_Continuation_Notice_Forward_Elements;
with Matreshka.ODF_Text.Note_Ref_Elements;
with Matreshka.ODF_Text.Notes_Configuration_Elements;
with Matreshka.ODF_Text.Number_Elements;
with Matreshka.ODF_Text.Numbered_Paragraph_Elements;
with Matreshka.ODF_Text.Object_Count_Elements;
with Matreshka.ODF_Text.Object_Index_Elements;
with Matreshka.ODF_Text.Object_Index_Entry_Template_Elements;
with Matreshka.ODF_Text.Object_Index_Source_Elements;
with Matreshka.ODF_Text.Outline_Level_Style_Elements;
with Matreshka.ODF_Text.Outline_Style_Elements;
with Matreshka.ODF_Text.P_Elements;
with Matreshka.ODF_Text.Page_Elements;
with Matreshka.ODF_Text.Page_Continuation_Elements;
with Matreshka.ODF_Text.Page_Count_Elements;
with Matreshka.ODF_Text.Page_Number_Elements;
with Matreshka.ODF_Text.Page_Sequence_Elements;
with Matreshka.ODF_Text.Page_Variable_Get_Elements;
with Matreshka.ODF_Text.Page_Variable_Set_Elements;
with Matreshka.ODF_Text.Paragraph_Count_Elements;
with Matreshka.ODF_Text.Placeholder_Elements;
with Matreshka.ODF_Office.Presentation_Elements;
with Matreshka.ODF_Text.Print_Date_Elements;
with Matreshka.ODF_Text.Print_Time_Elements;
with Matreshka.ODF_Text.Printed_By_Elements;
with Matreshka.ODF_Text.Reference_Mark_Elements;
with Matreshka.ODF_Text.Reference_Mark_End_Elements;
with Matreshka.ODF_Text.Reference_Mark_Start_Elements;
with Matreshka.ODF_Text.Reference_Ref_Elements;
with Matreshka.ODF_Text.Ruby_Elements;
with Matreshka.ODF_Text.Ruby_Base_Elements;
with Matreshka.ODF_Text.Ruby_Text_Elements;
with Matreshka.ODF_Text.S_Elements;
with Matreshka.ODF_Office.Script_Elements;
with Matreshka.ODF_Text.Script_Elements;
with Matreshka.ODF_Office.Scripts_Elements;
with Matreshka.ODF_Text.Section_Elements;
with Matreshka.ODF_Text.Section_Source_Elements;
with Matreshka.ODF_Text.Sender_City_Elements;
with Matreshka.ODF_Text.Sender_Company_Elements;
with Matreshka.ODF_Text.Sender_Country_Elements;
with Matreshka.ODF_Text.Sender_Email_Elements;
with Matreshka.ODF_Text.Sender_Fax_Elements;
with Matreshka.ODF_Text.Sender_Firstname_Elements;
with Matreshka.ODF_Text.Sender_Initials_Elements;
with Matreshka.ODF_Text.Sender_Lastname_Elements;
with Matreshka.ODF_Text.Sender_Phone_Private_Elements;
with Matreshka.ODF_Text.Sender_Phone_Work_Elements;
with Matreshka.ODF_Text.Sender_Position_Elements;
with Matreshka.ODF_Text.Sender_Postal_Code_Elements;
with Matreshka.ODF_Text.Sender_State_Or_Province_Elements;
with Matreshka.ODF_Text.Sender_Street_Elements;
with Matreshka.ODF_Text.Sender_Title_Elements;
with Matreshka.ODF_Text.Sequence_Elements;
with Matreshka.ODF_Text.Sequence_Decl_Elements;
with Matreshka.ODF_Text.Sequence_Decls_Elements;
with Matreshka.ODF_Text.Sequence_Ref_Elements;
with Matreshka.ODF_Office.Settings_Elements;
with Matreshka.ODF_Text.Sheet_Name_Elements;
with Matreshka.ODF_Text.Soft_Page_Break_Elements;
with Matreshka.ODF_Text.Sort_Key_Elements;
with Matreshka.ODF_Text.Span_Elements;
with Matreshka.ODF_Office.Spreadsheet_Elements;
with Matreshka.ODF_Office.Styles_Elements;
with Matreshka.ODF_Text.Subject_Elements;
with Matreshka.ODF_Text.Tab_Elements;
with Matreshka.ODF_Text.Table_Count_Elements;
with Matreshka.ODF_Text.Table_Formula_Elements;
with Matreshka.ODF_Text.Table_Index_Elements;
with Matreshka.ODF_Text.Table_Index_Entry_Template_Elements;
with Matreshka.ODF_Text.Table_Index_Source_Elements;
with Matreshka.ODF_Text.Table_Of_Content_Elements;
with Matreshka.ODF_Text.Table_Of_Content_Entry_Template_Elements;
with Matreshka.ODF_Text.Table_Of_Content_Source_Elements;
with Matreshka.ODF_Text.Template_Name_Elements;
with Matreshka.ODF_Office.Text_Elements;
with Matreshka.ODF_Text.Text_Input_Elements;
with Matreshka.ODF_Text.Time_Elements;
with Matreshka.ODF_Text.Title_Elements;
with Matreshka.ODF_Text.Toc_Mark_Elements;
with Matreshka.ODF_Text.Toc_Mark_End_Elements;
with Matreshka.ODF_Text.Toc_Mark_Start_Elements;
with Matreshka.ODF_Text.Tracked_Changes_Elements;
with Matreshka.ODF_Text.User_Defined_Elements;
with Matreshka.ODF_Text.User_Field_Decl_Elements;
with Matreshka.ODF_Text.User_Field_Decls_Elements;
with Matreshka.ODF_Text.User_Field_Get_Elements;
with Matreshka.ODF_Text.User_Field_Input_Elements;
with Matreshka.ODF_Text.User_Index_Elements;
with Matreshka.ODF_Text.User_Index_Entry_Template_Elements;
with Matreshka.ODF_Text.User_Index_Mark_Elements;
with Matreshka.ODF_Text.User_Index_Mark_End_Elements;
with Matreshka.ODF_Text.User_Index_Mark_Start_Elements;
with Matreshka.ODF_Text.User_Index_Source_Elements;
with Matreshka.ODF_Text.Variable_Decl_Elements;
with Matreshka.ODF_Text.Variable_Decls_Elements;
with Matreshka.ODF_Text.Variable_Get_Elements;
with Matreshka.ODF_Text.Variable_Input_Elements;
with Matreshka.ODF_Text.Variable_Set_Elements;
with Matreshka.ODF_Text.Word_Count_Elements;

package body Matreshka.ODF_Documents is

   --------------------------------------
   -- Create_Number_Am_Pm_Element --
   --------------------------------------

   overriding function Create_Number_Am_Pm_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Am_Pm_Elements.ODF_Number_Am_Pm_Element_Access is
   begin
      return
        ODF.DOM.Number_Am_Pm_Elements.ODF_Number_Am_Pm_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Am_Pm_Element));
   end Create_Number_Am_Pm_Element;

   --------------------------------------
   -- Create_Anim_Animate_Element --
   --------------------------------------

   overriding function Create_Anim_Animate_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Animate_Elements.ODF_Anim_Animate_Element_Access is
   begin
      return
        ODF.DOM.Anim_Animate_Elements.ODF_Anim_Animate_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Anim_URI,
            Matreshka.ODF_String_Constants.Anim_Prefix,
            Matreshka.ODF_String_Constants.Animate_Element));
   end Create_Anim_Animate_Element;

   --------------------------------------
   -- Create_Anim_AnimateColor_Element --
   --------------------------------------

   overriding function Create_Anim_AnimateColor_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_AnimateColor_Elements.ODF_Anim_AnimateColor_Element_Access is
   begin
      return
        ODF.DOM.Anim_AnimateColor_Elements.ODF_Anim_AnimateColor_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Anim_URI,
            Matreshka.ODF_String_Constants.Anim_Prefix,
            Matreshka.ODF_String_Constants.AnimateColor_Element));
   end Create_Anim_AnimateColor_Element;

   --------------------------------------
   -- Create_Anim_AnimateMotion_Element --
   --------------------------------------

   overriding function Create_Anim_AnimateMotion_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_AnimateMotion_Elements.ODF_Anim_AnimateMotion_Element_Access is
   begin
      return
        ODF.DOM.Anim_AnimateMotion_Elements.ODF_Anim_AnimateMotion_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Anim_URI,
            Matreshka.ODF_String_Constants.Anim_Prefix,
            Matreshka.ODF_String_Constants.AnimateMotion_Element));
   end Create_Anim_AnimateMotion_Element;

   --------------------------------------
   -- Create_Anim_AnimateTransform_Element --
   --------------------------------------

   overriding function Create_Anim_AnimateTransform_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_AnimateTransform_Elements.ODF_Anim_AnimateTransform_Element_Access is
   begin
      return
        ODF.DOM.Anim_AnimateTransform_Elements.ODF_Anim_AnimateTransform_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Anim_URI,
            Matreshka.ODF_String_Constants.Anim_Prefix,
            Matreshka.ODF_String_Constants.AnimateTransform_Element));
   end Create_Anim_AnimateTransform_Element;

   --------------------------------------
   -- Create_Anim_Audio_Element --
   --------------------------------------

   overriding function Create_Anim_Audio_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Audio_Elements.ODF_Anim_Audio_Element_Access is
   begin
      return
        ODF.DOM.Anim_Audio_Elements.ODF_Anim_Audio_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Anim_URI,
            Matreshka.ODF_String_Constants.Anim_Prefix,
            Matreshka.ODF_String_Constants.Audio_Element));
   end Create_Anim_Audio_Element;

   --------------------------------------
   -- Create_Anim_Command_Element --
   --------------------------------------

   overriding function Create_Anim_Command_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Command_Elements.ODF_Anim_Command_Element_Access is
   begin
      return
        ODF.DOM.Anim_Command_Elements.ODF_Anim_Command_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Anim_URI,
            Matreshka.ODF_String_Constants.Anim_Prefix,
            Matreshka.ODF_String_Constants.Command_Element));
   end Create_Anim_Command_Element;

   --------------------------------------
   -- Create_Anim_Iterate_Element --
   --------------------------------------

   overriding function Create_Anim_Iterate_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Iterate_Elements.ODF_Anim_Iterate_Element_Access is
   begin
      return
        ODF.DOM.Anim_Iterate_Elements.ODF_Anim_Iterate_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Anim_URI,
            Matreshka.ODF_String_Constants.Anim_Prefix,
            Matreshka.ODF_String_Constants.Iterate_Element));
   end Create_Anim_Iterate_Element;

   --------------------------------------
   -- Create_Anim_Par_Element --
   --------------------------------------

   overriding function Create_Anim_Par_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Par_Elements.ODF_Anim_Par_Element_Access is
   begin
      return
        ODF.DOM.Anim_Par_Elements.ODF_Anim_Par_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Anim_URI,
            Matreshka.ODF_String_Constants.Anim_Prefix,
            Matreshka.ODF_String_Constants.Par_Element));
   end Create_Anim_Par_Element;

   --------------------------------------
   -- Create_Anim_Param_Element --
   --------------------------------------

   overriding function Create_Anim_Param_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Param_Elements.ODF_Anim_Param_Element_Access is
   begin
      return
        ODF.DOM.Anim_Param_Elements.ODF_Anim_Param_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Anim_URI,
            Matreshka.ODF_String_Constants.Anim_Prefix,
            Matreshka.ODF_String_Constants.Param_Element));
   end Create_Anim_Param_Element;

   --------------------------------------
   -- Create_Anim_Seq_Element --
   --------------------------------------

   overriding function Create_Anim_Seq_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Seq_Elements.ODF_Anim_Seq_Element_Access is
   begin
      return
        ODF.DOM.Anim_Seq_Elements.ODF_Anim_Seq_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Anim_URI,
            Matreshka.ODF_String_Constants.Anim_Prefix,
            Matreshka.ODF_String_Constants.Seq_Element));
   end Create_Anim_Seq_Element;

   --------------------------------------
   -- Create_Anim_Set_Element --
   --------------------------------------

   overriding function Create_Anim_Set_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_Set_Elements.ODF_Anim_Set_Element_Access is
   begin
      return
        ODF.DOM.Anim_Set_Elements.ODF_Anim_Set_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Anim_URI,
            Matreshka.ODF_String_Constants.Anim_Prefix,
            Matreshka.ODF_String_Constants.Set_Element));
   end Create_Anim_Set_Element;

   --------------------------------------
   -- Create_Anim_TransitionFilter_Element --
   --------------------------------------

   overriding function Create_Anim_TransitionFilter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Anim_TransitionFilter_Elements.ODF_Anim_TransitionFilter_Element_Access is
   begin
      return
        ODF.DOM.Anim_TransitionFilter_Elements.ODF_Anim_TransitionFilter_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Anim_URI,
            Matreshka.ODF_String_Constants.Anim_Prefix,
            Matreshka.ODF_String_Constants.TransitionFilter_Element));
   end Create_Anim_TransitionFilter_Element;

   --------------------------------------
   -- Create_Office_Annotation_Element --
   --------------------------------------

   overriding function Create_Office_Annotation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Annotation_Elements.ODF_Office_Annotation_Element_Access is
   begin
      return
        ODF.DOM.Office_Annotation_Elements.ODF_Office_Annotation_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Annotation_Element));
   end Create_Office_Annotation_Element;

   --------------------------------------
   -- Create_Office_Annotation_End_Element --
   --------------------------------------

   overriding function Create_Office_Annotation_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Annotation_End_Elements.ODF_Office_Annotation_End_Element_Access is
   begin
      return
        ODF.DOM.Office_Annotation_End_Elements.ODF_Office_Annotation_End_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Annotation_End_Element));
   end Create_Office_Annotation_End_Element;

   --------------------------------------
   -- Create_Db_Application_Connection_Settings_Element --
   --------------------------------------

   overriding function Create_Db_Application_Connection_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Application_Connection_Settings_Elements.ODF_Db_Application_Connection_Settings_Element_Access is
   begin
      return
        ODF.DOM.Db_Application_Connection_Settings_Elements.ODF_Db_Application_Connection_Settings_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Application_Connection_Settings_Element));
   end Create_Db_Application_Connection_Settings_Element;

   --------------------------------------
   -- Create_Db_Auto_Increment_Element --
   --------------------------------------

   overriding function Create_Db_Auto_Increment_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Auto_Increment_Elements.ODF_Db_Auto_Increment_Element_Access is
   begin
      return
        ODF.DOM.Db_Auto_Increment_Elements.ODF_Db_Auto_Increment_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Auto_Increment_Element));
   end Create_Db_Auto_Increment_Element;

   --------------------------------------
   -- Create_Chart_Axis_Element --
   --------------------------------------

   overriding function Create_Chart_Axis_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Axis_Elements.ODF_Chart_Axis_Element_Access is
   begin
      return
        ODF.DOM.Chart_Axis_Elements.ODF_Chart_Axis_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Axis_Element));
   end Create_Chart_Axis_Element;

   --------------------------------------
   -- Create_Number_Boolean_Element --
   --------------------------------------

   overriding function Create_Number_Boolean_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Boolean_Elements.ODF_Number_Boolean_Element_Access is
   begin
      return
        ODF.DOM.Number_Boolean_Elements.ODF_Number_Boolean_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Boolean_Element));
   end Create_Number_Boolean_Element;

   --------------------------------------
   -- Create_Number_Boolean_Style_Element --
   --------------------------------------

   overriding function Create_Number_Boolean_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Boolean_Style_Elements.ODF_Number_Boolean_Style_Element_Access is
   begin
      return
        ODF.DOM.Number_Boolean_Style_Elements.ODF_Number_Boolean_Style_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Boolean_Style_Element));
   end Create_Number_Boolean_Style_Element;

   --------------------------------------
   -- Create_Form_Button_Element --
   --------------------------------------

   overriding function Create_Form_Button_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Button_Elements.ODF_Form_Button_Element_Access is
   begin
      return
        ODF.DOM.Form_Button_Elements.ODF_Form_Button_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Button_Element));
   end Create_Form_Button_Element;

   --------------------------------------
   -- Create_Chart_Categories_Element --
   --------------------------------------

   overriding function Create_Chart_Categories_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Categories_Elements.ODF_Chart_Categories_Element_Access is
   begin
      return
        ODF.DOM.Chart_Categories_Elements.ODF_Chart_Categories_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Categories_Element));
   end Create_Chart_Categories_Element;

   --------------------------------------
   -- Create_Db_Character_Set_Element --
   --------------------------------------

   overriding function Create_Db_Character_Set_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Character_Set_Elements.ODF_Db_Character_Set_Element_Access is
   begin
      return
        ODF.DOM.Db_Character_Set_Elements.ODF_Db_Character_Set_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Character_Set_Element));
   end Create_Db_Character_Set_Element;

   --------------------------------------
   -- Create_Chart_Chart_Element --
   --------------------------------------

   overriding function Create_Chart_Chart_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Chart_Elements.ODF_Chart_Chart_Element_Access is
   begin
      return
        ODF.DOM.Chart_Chart_Elements.ODF_Chart_Chart_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Chart_Element));
   end Create_Chart_Chart_Element;

   --------------------------------------
   -- Create_Form_Checkbox_Element --
   --------------------------------------

   overriding function Create_Form_Checkbox_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Checkbox_Elements.ODF_Form_Checkbox_Element_Access is
   begin
      return
        ODF.DOM.Form_Checkbox_Elements.ODF_Form_Checkbox_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Checkbox_Element));
   end Create_Form_Checkbox_Element;

   --------------------------------------
   -- Create_Db_Column_Element --
   --------------------------------------

   overriding function Create_Db_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Column_Elements.ODF_Db_Column_Element_Access is
   begin
      return
        ODF.DOM.Db_Column_Elements.ODF_Db_Column_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Column_Element));
   end Create_Db_Column_Element;

   --------------------------------------
   -- Create_Form_Column_Element --
   --------------------------------------

   overriding function Create_Form_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Column_Elements.ODF_Form_Column_Element_Access is
   begin
      return
        ODF.DOM.Form_Column_Elements.ODF_Form_Column_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Column_Element));
   end Create_Form_Column_Element;

   --------------------------------------
   -- Create_Db_Column_Definition_Element --
   --------------------------------------

   overriding function Create_Db_Column_Definition_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Column_Definition_Elements.ODF_Db_Column_Definition_Element_Access is
   begin
      return
        ODF.DOM.Db_Column_Definition_Elements.ODF_Db_Column_Definition_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Column_Definition_Element));
   end Create_Db_Column_Definition_Element;

   --------------------------------------
   -- Create_Db_Column_Definitions_Element --
   --------------------------------------

   overriding function Create_Db_Column_Definitions_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Column_Definitions_Elements.ODF_Db_Column_Definitions_Element_Access is
   begin
      return
        ODF.DOM.Db_Column_Definitions_Elements.ODF_Db_Column_Definitions_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Column_Definitions_Element));
   end Create_Db_Column_Definitions_Element;

   --------------------------------------
   -- Create_Db_Columns_Element --
   --------------------------------------

   overriding function Create_Db_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Columns_Elements.ODF_Db_Columns_Element_Access is
   begin
      return
        ODF.DOM.Db_Columns_Elements.ODF_Db_Columns_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Columns_Element));
   end Create_Db_Columns_Element;

   --------------------------------------
   -- Create_Form_Combobox_Element --
   --------------------------------------

   overriding function Create_Form_Combobox_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Combobox_Elements.ODF_Form_Combobox_Element_Access is
   begin
      return
        ODF.DOM.Form_Combobox_Elements.ODF_Form_Combobox_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Combobox_Element));
   end Create_Form_Combobox_Element;

   --------------------------------------
   -- Create_Db_Component_Element --
   --------------------------------------

   overriding function Create_Db_Component_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Component_Elements.ODF_Db_Component_Element_Access is
   begin
      return
        ODF.DOM.Db_Component_Elements.ODF_Db_Component_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Component_Element));
   end Create_Db_Component_Element;

   --------------------------------------
   -- Create_Db_Component_Collection_Element --
   --------------------------------------

   overriding function Create_Db_Component_Collection_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Component_Collection_Elements.ODF_Db_Component_Collection_Element_Access is
   begin
      return
        ODF.DOM.Db_Component_Collection_Elements.ODF_Db_Component_Collection_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Component_Collection_Element));
   end Create_Db_Component_Collection_Element;

   --------------------------------------
   -- Create_Chart_Data_Label_Element --
   --------------------------------------

   overriding function Create_Chart_Data_Label_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Data_Label_Elements.ODF_Chart_Data_Label_Element_Access is
   begin
      return
        ODF.DOM.Chart_Data_Label_Elements.ODF_Chart_Data_Label_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Data_Label_Element));
   end Create_Chart_Data_Label_Element;

   --------------------------------------
   -- Create_Chart_Data_Point_Element --
   --------------------------------------

   overriding function Create_Chart_Data_Point_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Data_Point_Elements.ODF_Chart_Data_Point_Element_Access is
   begin
      return
        ODF.DOM.Chart_Data_Point_Elements.ODF_Chart_Data_Point_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Data_Point_Element));
   end Create_Chart_Data_Point_Element;

   --------------------------------------
   -- Create_Chart_Domain_Element --
   --------------------------------------

   overriding function Create_Chart_Domain_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Domain_Elements.ODF_Chart_Domain_Element_Access is
   begin
      return
        ODF.DOM.Chart_Domain_Elements.ODF_Chart_Domain_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Domain_Element));
   end Create_Chart_Domain_Element;

   --------------------------------------
   -- Create_Chart_Equation_Element --
   --------------------------------------

   overriding function Create_Chart_Equation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Equation_Elements.ODF_Chart_Equation_Element_Access is
   begin
      return
        ODF.DOM.Chart_Equation_Elements.ODF_Chart_Equation_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Equation_Element));
   end Create_Chart_Equation_Element;

   --------------------------------------
   -- Create_Chart_Error_Indicator_Element --
   --------------------------------------

   overriding function Create_Chart_Error_Indicator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Error_Indicator_Elements.ODF_Chart_Error_Indicator_Element_Access is
   begin
      return
        ODF.DOM.Chart_Error_Indicator_Elements.ODF_Chart_Error_Indicator_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Error_Indicator_Element));
   end Create_Chart_Error_Indicator_Element;

   --------------------------------------
   -- Create_Chart_Floor_Element --
   --------------------------------------

   overriding function Create_Chart_Floor_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Floor_Elements.ODF_Chart_Floor_Element_Access is
   begin
      return
        ODF.DOM.Chart_Floor_Elements.ODF_Chart_Floor_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Floor_Element));
   end Create_Chart_Floor_Element;

   --------------------------------------
   -- Create_Chart_Footer_Element --
   --------------------------------------

   overriding function Create_Chart_Footer_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Footer_Elements.ODF_Chart_Footer_Element_Access is
   begin
      return
        ODF.DOM.Chart_Footer_Elements.ODF_Chart_Footer_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Footer_Element));
   end Create_Chart_Footer_Element;

   --------------------------------------
   -- Create_Chart_Grid_Element --
   --------------------------------------

   overriding function Create_Chart_Grid_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Grid_Elements.ODF_Chart_Grid_Element_Access is
   begin
      return
        ODF.DOM.Chart_Grid_Elements.ODF_Chart_Grid_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Grid_Element));
   end Create_Chart_Grid_Element;

   --------------------------------------
   -- Create_Chart_Label_Separator_Element --
   --------------------------------------

   overriding function Create_Chart_Label_Separator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Label_Separator_Elements.ODF_Chart_Label_Separator_Element_Access is
   begin
      return
        ODF.DOM.Chart_Label_Separator_Elements.ODF_Chart_Label_Separator_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Label_Separator_Element));
   end Create_Chart_Label_Separator_Element;

   --------------------------------------
   -- Create_Chart_Legend_Element --
   --------------------------------------

   overriding function Create_Chart_Legend_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Legend_Elements.ODF_Chart_Legend_Element_Access is
   begin
      return
        ODF.DOM.Chart_Legend_Elements.ODF_Chart_Legend_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Legend_Element));
   end Create_Chart_Legend_Element;

   --------------------------------------
   -- Create_Chart_Mean_Value_Element --
   --------------------------------------

   overriding function Create_Chart_Mean_Value_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Mean_Value_Elements.ODF_Chart_Mean_Value_Element_Access is
   begin
      return
        ODF.DOM.Chart_Mean_Value_Elements.ODF_Chart_Mean_Value_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Mean_Value_Element));
   end Create_Chart_Mean_Value_Element;

   --------------------------------------
   -- Create_Chart_Plot_Area_Element --
   --------------------------------------

   overriding function Create_Chart_Plot_Area_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Plot_Area_Elements.ODF_Chart_Plot_Area_Element_Access is
   begin
      return
        ODF.DOM.Chart_Plot_Area_Elements.ODF_Chart_Plot_Area_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Plot_Area_Element));
   end Create_Chart_Plot_Area_Element;

   --------------------------------------
   -- Create_Chart_Regression_Curve_Element --
   --------------------------------------

   overriding function Create_Chart_Regression_Curve_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Regression_Curve_Elements.ODF_Chart_Regression_Curve_Element_Access is
   begin
      return
        ODF.DOM.Chart_Regression_Curve_Elements.ODF_Chart_Regression_Curve_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Regression_Curve_Element));
   end Create_Chart_Regression_Curve_Element;

   --------------------------------------
   -- Create_Chart_Series_Element --
   --------------------------------------

   overriding function Create_Chart_Series_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Series_Elements.ODF_Chart_Series_Element_Access is
   begin
      return
        ODF.DOM.Chart_Series_Elements.ODF_Chart_Series_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Series_Element));
   end Create_Chart_Series_Element;

   --------------------------------------
   -- Create_Chart_Stock_Gain_Marker_Element --
   --------------------------------------

   overriding function Create_Chart_Stock_Gain_Marker_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Stock_Gain_Marker_Elements.ODF_Chart_Stock_Gain_Marker_Element_Access is
   begin
      return
        ODF.DOM.Chart_Stock_Gain_Marker_Elements.ODF_Chart_Stock_Gain_Marker_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Stock_Gain_Marker_Element));
   end Create_Chart_Stock_Gain_Marker_Element;

   --------------------------------------
   -- Create_Chart_Stock_Loss_Marker_Element --
   --------------------------------------

   overriding function Create_Chart_Stock_Loss_Marker_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Stock_Loss_Marker_Elements.ODF_Chart_Stock_Loss_Marker_Element_Access is
   begin
      return
        ODF.DOM.Chart_Stock_Loss_Marker_Elements.ODF_Chart_Stock_Loss_Marker_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Stock_Loss_Marker_Element));
   end Create_Chart_Stock_Loss_Marker_Element;

   --------------------------------------
   -- Create_Chart_Stock_Range_Line_Element --
   --------------------------------------

   overriding function Create_Chart_Stock_Range_Line_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Stock_Range_Line_Elements.ODF_Chart_Stock_Range_Line_Element_Access is
   begin
      return
        ODF.DOM.Chart_Stock_Range_Line_Elements.ODF_Chart_Stock_Range_Line_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Stock_Range_Line_Element));
   end Create_Chart_Stock_Range_Line_Element;

   --------------------------------------
   -- Create_Chart_Subtitle_Element --
   --------------------------------------

   overriding function Create_Chart_Subtitle_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Subtitle_Elements.ODF_Chart_Subtitle_Element_Access is
   begin
      return
        ODF.DOM.Chart_Subtitle_Elements.ODF_Chart_Subtitle_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Subtitle_Element));
   end Create_Chart_Subtitle_Element;

   --------------------------------------
   -- Create_Chart_Symbol_Image_Element --
   --------------------------------------

   overriding function Create_Chart_Symbol_Image_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Symbol_Image_Elements.ODF_Chart_Symbol_Image_Element_Access is
   begin
      return
        ODF.DOM.Chart_Symbol_Image_Elements.ODF_Chart_Symbol_Image_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Symbol_Image_Element));
   end Create_Chart_Symbol_Image_Element;

   --------------------------------------
   -- Create_Chart_Title_Element --
   --------------------------------------

   overriding function Create_Chart_Title_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Title_Elements.ODF_Chart_Title_Element_Access is
   begin
      return
        ODF.DOM.Chart_Title_Elements.ODF_Chart_Title_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Title_Element));
   end Create_Chart_Title_Element;

   --------------------------------------
   -- Create_Chart_Wall_Element --
   --------------------------------------

   overriding function Create_Chart_Wall_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Chart_Wall_Elements.ODF_Chart_Wall_Element_Access is
   begin
      return
        ODF.DOM.Chart_Wall_Elements.ODF_Chart_Wall_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Chart_URI,
            Matreshka.ODF_String_Constants.Chart_Prefix,
            Matreshka.ODF_String_Constants.Wall_Element));
   end Create_Chart_Wall_Element;

   --------------------------------------
   -- Create_Draw_A_Element --
   --------------------------------------

   overriding function Create_Draw_A_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_A_Elements.ODF_Draw_A_Element_Access is
   begin
      return
        ODF.DOM.Draw_A_Elements.ODF_Draw_A_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.A_Element));
   end Create_Draw_A_Element;

   --------------------------------------
   -- Create_Presentation_Animation_Group_Element --
   --------------------------------------

   overriding function Create_Presentation_Animation_Group_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Animation_Group_Elements.ODF_Presentation_Animation_Group_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Animation_Group_Elements.ODF_Presentation_Animation_Group_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Animation_Group_Element));
   end Create_Presentation_Animation_Group_Element;

   --------------------------------------
   -- Create_Presentation_Animations_Element --
   --------------------------------------

   overriding function Create_Presentation_Animations_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Animations_Elements.ODF_Presentation_Animations_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Animations_Elements.ODF_Presentation_Animations_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Animations_Element));
   end Create_Presentation_Animations_Element;

   --------------------------------------
   -- Create_Draw_Applet_Element --
   --------------------------------------

   overriding function Create_Draw_Applet_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Applet_Elements.ODF_Draw_Applet_Element_Access is
   begin
      return
        ODF.DOM.Draw_Applet_Elements.ODF_Draw_Applet_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Applet_Element));
   end Create_Draw_Applet_Element;

   --------------------------------------
   -- Create_Draw_Area_Circle_Element --
   --------------------------------------

   overriding function Create_Draw_Area_Circle_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Area_Circle_Elements.ODF_Draw_Area_Circle_Element_Access is
   begin
      return
        ODF.DOM.Draw_Area_Circle_Elements.ODF_Draw_Area_Circle_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Area_Circle_Element));
   end Create_Draw_Area_Circle_Element;

   --------------------------------------
   -- Create_Draw_Area_Polygon_Element --
   --------------------------------------

   overriding function Create_Draw_Area_Polygon_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Area_Polygon_Elements.ODF_Draw_Area_Polygon_Element_Access is
   begin
      return
        ODF.DOM.Draw_Area_Polygon_Elements.ODF_Draw_Area_Polygon_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Area_Polygon_Element));
   end Create_Draw_Area_Polygon_Element;

   --------------------------------------
   -- Create_Draw_Area_Rectangle_Element --
   --------------------------------------

   overriding function Create_Draw_Area_Rectangle_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Area_Rectangle_Elements.ODF_Draw_Area_Rectangle_Element_Access is
   begin
      return
        ODF.DOM.Draw_Area_Rectangle_Elements.ODF_Draw_Area_Rectangle_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Area_Rectangle_Element));
   end Create_Draw_Area_Rectangle_Element;

   --------------------------------------
   -- Create_Draw_Caption_Element --
   --------------------------------------

   overriding function Create_Draw_Caption_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Caption_Elements.ODF_Draw_Caption_Element_Access is
   begin
      return
        ODF.DOM.Draw_Caption_Elements.ODF_Draw_Caption_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Caption_Element));
   end Create_Draw_Caption_Element;

   --------------------------------------
   -- Create_Draw_Circle_Element --
   --------------------------------------

   overriding function Create_Draw_Circle_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Circle_Elements.ODF_Draw_Circle_Element_Access is
   begin
      return
        ODF.DOM.Draw_Circle_Elements.ODF_Draw_Circle_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Circle_Element));
   end Create_Draw_Circle_Element;

   --------------------------------------
   -- Create_Text_A_Element --
   --------------------------------------

   overriding function Create_Text_A_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_A_Elements.ODF_Text_A_Element_Access is
   begin
      return
        ODF.DOM.Text_A_Elements.ODF_Text_A_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.A_Element));
   end Create_Text_A_Element;

   --------------------------------------
   -- Create_Text_Alphabetical_Index_Element --
   --------------------------------------

   overriding function Create_Text_Alphabetical_Index_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Alphabetical_Index_Elements.ODF_Text_Alphabetical_Index_Element_Access is
   begin
      return
        ODF.DOM.Text_Alphabetical_Index_Elements.ODF_Text_Alphabetical_Index_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Alphabetical_Index_Element));
   end Create_Text_Alphabetical_Index_Element;

   --------------------------------------
   -- Create_Text_Alphabetical_Index_Auto_Mark_File_Element --
   --------------------------------------

   overriding function Create_Text_Alphabetical_Index_Auto_Mark_File_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Alphabetical_Index_Auto_Mark_File_Elements.ODF_Text_Alphabetical_Index_Auto_Mark_File_Element_Access is
   begin
      return
        ODF.DOM.Text_Alphabetical_Index_Auto_Mark_File_Elements.ODF_Text_Alphabetical_Index_Auto_Mark_File_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Alphabetical_Index_Auto_Mark_File_Element));
   end Create_Text_Alphabetical_Index_Auto_Mark_File_Element;

   --------------------------------------
   -- Create_Text_Alphabetical_Index_Entry_Template_Element --
   --------------------------------------

   overriding function Create_Text_Alphabetical_Index_Entry_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Alphabetical_Index_Entry_Template_Elements.ODF_Text_Alphabetical_Index_Entry_Template_Element_Access is
   begin
      return
        ODF.DOM.Text_Alphabetical_Index_Entry_Template_Elements.ODF_Text_Alphabetical_Index_Entry_Template_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Alphabetical_Index_Entry_Template_Element));
   end Create_Text_Alphabetical_Index_Entry_Template_Element;

   --------------------------------------
   -- Create_Text_Alphabetical_Index_Mark_Element --
   --------------------------------------

   overriding function Create_Text_Alphabetical_Index_Mark_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Alphabetical_Index_Mark_Elements.ODF_Text_Alphabetical_Index_Mark_Element_Access is
   begin
      return
        ODF.DOM.Text_Alphabetical_Index_Mark_Elements.ODF_Text_Alphabetical_Index_Mark_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Alphabetical_Index_Mark_Element));
   end Create_Text_Alphabetical_Index_Mark_Element;

   --------------------------------------
   -- Create_Text_Alphabetical_Index_Mark_End_Element --
   --------------------------------------

   overriding function Create_Text_Alphabetical_Index_Mark_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Alphabetical_Index_Mark_End_Elements.ODF_Text_Alphabetical_Index_Mark_End_Element_Access is
   begin
      return
        ODF.DOM.Text_Alphabetical_Index_Mark_End_Elements.ODF_Text_Alphabetical_Index_Mark_End_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Alphabetical_Index_Mark_End_Element));
   end Create_Text_Alphabetical_Index_Mark_End_Element;

   --------------------------------------
   -- Create_Text_Alphabetical_Index_Mark_Start_Element --
   --------------------------------------

   overriding function Create_Text_Alphabetical_Index_Mark_Start_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Alphabetical_Index_Mark_Start_Elements.ODF_Text_Alphabetical_Index_Mark_Start_Element_Access is
   begin
      return
        ODF.DOM.Text_Alphabetical_Index_Mark_Start_Elements.ODF_Text_Alphabetical_Index_Mark_Start_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Alphabetical_Index_Mark_Start_Element));
   end Create_Text_Alphabetical_Index_Mark_Start_Element;

   --------------------------------------
   -- Create_Text_Alphabetical_Index_Source_Element --
   --------------------------------------

   overriding function Create_Text_Alphabetical_Index_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Alphabetical_Index_Source_Elements.ODF_Text_Alphabetical_Index_Source_Element_Access is
   begin
      return
        ODF.DOM.Text_Alphabetical_Index_Source_Elements.ODF_Text_Alphabetical_Index_Source_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Alphabetical_Index_Source_Element));
   end Create_Text_Alphabetical_Index_Source_Element;

   --------------------------------------
   -- Create_Text_Author_Initials_Element --
   --------------------------------------

   overriding function Create_Text_Author_Initials_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Author_Initials_Elements.ODF_Text_Author_Initials_Element_Access is
   begin
      return
        ODF.DOM.Text_Author_Initials_Elements.ODF_Text_Author_Initials_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Author_Initials_Element));
   end Create_Text_Author_Initials_Element;

   --------------------------------------
   -- Create_Text_Author_Name_Element --
   --------------------------------------

   overriding function Create_Text_Author_Name_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Author_Name_Elements.ODF_Text_Author_Name_Element_Access is
   begin
      return
        ODF.DOM.Text_Author_Name_Elements.ODF_Text_Author_Name_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Author_Name_Element));
   end Create_Text_Author_Name_Element;

   --------------------------------------
   -- Create_Meta_Auto_Reload_Element --
   --------------------------------------

   overriding function Create_Meta_Auto_Reload_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Auto_Reload_Elements.ODF_Meta_Auto_Reload_Element_Access is
   begin
      return
        ODF.DOM.Meta_Auto_Reload_Elements.ODF_Meta_Auto_Reload_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Meta_URI,
            Matreshka.ODF_String_Constants.Meta_Prefix,
            Matreshka.ODF_String_Constants.Auto_Reload_Element));
   end Create_Meta_Auto_Reload_Element;

   --------------------------------------
   -- Create_Office_Automatic_Styles_Element --
   --------------------------------------

   overriding function Create_Office_Automatic_Styles_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Automatic_Styles_Elements.ODF_Office_Automatic_Styles_Element_Access is
   begin
      return
        ODF.DOM.Office_Automatic_Styles_Elements.ODF_Office_Automatic_Styles_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Automatic_Styles_Element));
   end Create_Office_Automatic_Styles_Element;

   --------------------------------------
   -- Create_Style_Background_Image_Element --
   --------------------------------------

   overriding function Create_Style_Background_Image_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Background_Image_Elements.ODF_Style_Background_Image_Element_Access is
   begin
      return
        ODF.DOM.Style_Background_Image_Elements.ODF_Style_Background_Image_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Background_Image_Element));
   end Create_Style_Background_Image_Element;

   --------------------------------------
   -- Create_Style_Chart_Properties_Element --
   --------------------------------------

   overriding function Create_Style_Chart_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Chart_Properties_Elements.ODF_Style_Chart_Properties_Element_Access is
   begin
      return
        ODF.DOM.Style_Chart_Properties_Elements.ODF_Style_Chart_Properties_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Chart_Properties_Element));
   end Create_Style_Chart_Properties_Element;

   --------------------------------------
   -- Create_Style_Column_Element --
   --------------------------------------

   overriding function Create_Style_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Column_Elements.ODF_Style_Column_Element_Access is
   begin
      return
        ODF.DOM.Style_Column_Elements.ODF_Style_Column_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Column_Element));
   end Create_Style_Column_Element;

   --------------------------------------
   -- Create_Style_Column_Sep_Element --
   --------------------------------------

   overriding function Create_Style_Column_Sep_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Column_Sep_Elements.ODF_Style_Column_Sep_Element_Access is
   begin
      return
        ODF.DOM.Style_Column_Sep_Elements.ODF_Style_Column_Sep_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Column_Sep_Element));
   end Create_Style_Column_Sep_Element;

   --------------------------------------
   -- Create_Style_Columns_Element --
   --------------------------------------

   overriding function Create_Style_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Columns_Elements.ODF_Style_Columns_Element_Access is
   begin
      return
        ODF.DOM.Style_Columns_Elements.ODF_Style_Columns_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Columns_Element));
   end Create_Style_Columns_Element;

   --------------------------------------
   -- Create_Table_Background_Element --
   --------------------------------------

   overriding function Create_Table_Background_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Background_Elements.ODF_Table_Background_Element_Access is
   begin
      return
        ODF.DOM.Table_Background_Elements.ODF_Table_Background_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Background_Element));
   end Create_Table_Background_Element;

   --------------------------------------
   -- Create_Text_Bibliography_Configuration_Element --
   --------------------------------------

   overriding function Create_Text_Bibliography_Configuration_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bibliography_Configuration_Elements.ODF_Text_Bibliography_Configuration_Element_Access is
   begin
      return
        ODF.DOM.Text_Bibliography_Configuration_Elements.ODF_Text_Bibliography_Configuration_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Bibliography_Configuration_Element));
   end Create_Text_Bibliography_Configuration_Element;

   --------------------------------------
   -- Create_Office_Binary_Data_Element --
   --------------------------------------

   overriding function Create_Office_Binary_Data_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Binary_Data_Elements.ODF_Office_Binary_Data_Element_Access is
   begin
      return
        ODF.DOM.Office_Binary_Data_Elements.ODF_Office_Binary_Data_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Binary_Data_Element));
   end Create_Office_Binary_Data_Element;

   --------------------------------------
   -- Create_Table_Body_Element --
   --------------------------------------

   overriding function Create_Table_Body_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Body_Elements.ODF_Table_Body_Element_Access is
   begin
      return
        ODF.DOM.Table_Body_Elements.ODF_Table_Body_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Body_Element));
   end Create_Table_Body_Element;

   --------------------------------------
   -- Create_Table_Calculation_Settings_Element --
   --------------------------------------

   overriding function Create_Table_Calculation_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Calculation_Settings_Elements.ODF_Table_Calculation_Settings_Element_Access is
   begin
      return
        ODF.DOM.Table_Calculation_Settings_Elements.ODF_Table_Calculation_Settings_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Calculation_Settings_Element));
   end Create_Table_Calculation_Settings_Element;

   --------------------------------------
   -- Create_Table_Cell_Address_Element --
   --------------------------------------

   overriding function Create_Table_Cell_Address_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Cell_Address_Elements.ODF_Table_Cell_Address_Element_Access is
   begin
      return
        ODF.DOM.Table_Cell_Address_Elements.ODF_Table_Cell_Address_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Cell_Address_Element));
   end Create_Table_Cell_Address_Element;

   --------------------------------------
   -- Create_Table_Cell_Content_Change_Element --
   --------------------------------------

   overriding function Create_Table_Cell_Content_Change_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Cell_Content_Change_Elements.ODF_Table_Cell_Content_Change_Element_Access is
   begin
      return
        ODF.DOM.Table_Cell_Content_Change_Elements.ODF_Table_Cell_Content_Change_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Cell_Content_Change_Element));
   end Create_Table_Cell_Content_Change_Element;

   --------------------------------------
   -- Create_Table_Cell_Content_Deletion_Element --
   --------------------------------------

   overriding function Create_Table_Cell_Content_Deletion_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Cell_Content_Deletion_Elements.ODF_Table_Cell_Content_Deletion_Element_Access is
   begin
      return
        ODF.DOM.Table_Cell_Content_Deletion_Elements.ODF_Table_Cell_Content_Deletion_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Cell_Content_Deletion_Element));
   end Create_Table_Cell_Content_Deletion_Element;

   --------------------------------------
   -- Create_Table_Cell_Range_Source_Element --
   --------------------------------------

   overriding function Create_Table_Cell_Range_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Cell_Range_Source_Elements.ODF_Table_Cell_Range_Source_Element_Access is
   begin
      return
        ODF.DOM.Table_Cell_Range_Source_Elements.ODF_Table_Cell_Range_Source_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Cell_Range_Source_Element));
   end Create_Table_Cell_Range_Source_Element;

   --------------------------------------
   -- Create_Table_Change_Deletion_Element --
   --------------------------------------

   overriding function Create_Table_Change_Deletion_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Change_Deletion_Elements.ODF_Table_Change_Deletion_Element_Access is
   begin
      return
        ODF.DOM.Table_Change_Deletion_Elements.ODF_Table_Change_Deletion_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Change_Deletion_Element));
   end Create_Table_Change_Deletion_Element;

   --------------------------------------
   -- Create_Table_Change_Track_Table_Cell_Element --
   --------------------------------------

   overriding function Create_Table_Change_Track_Table_Cell_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Change_Track_Table_Cell_Elements.ODF_Table_Change_Track_Table_Cell_Element_Access is
   begin
      return
        ODF.DOM.Table_Change_Track_Table_Cell_Elements.ODF_Table_Change_Track_Table_Cell_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Change_Track_Table_Cell_Element));
   end Create_Table_Change_Track_Table_Cell_Element;

   --------------------------------------
   -- Create_Text_Bibliography_Element --
   --------------------------------------

   overriding function Create_Text_Bibliography_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bibliography_Elements.ODF_Text_Bibliography_Element_Access is
   begin
      return
        ODF.DOM.Text_Bibliography_Elements.ODF_Text_Bibliography_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Bibliography_Element));
   end Create_Text_Bibliography_Element;

   --------------------------------------
   -- Create_Text_Bibliography_Entry_Template_Element --
   --------------------------------------

   overriding function Create_Text_Bibliography_Entry_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bibliography_Entry_Template_Elements.ODF_Text_Bibliography_Entry_Template_Element_Access is
   begin
      return
        ODF.DOM.Text_Bibliography_Entry_Template_Elements.ODF_Text_Bibliography_Entry_Template_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Bibliography_Entry_Template_Element));
   end Create_Text_Bibliography_Entry_Template_Element;

   --------------------------------------
   -- Create_Text_Bibliography_Mark_Element --
   --------------------------------------

   overriding function Create_Text_Bibliography_Mark_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bibliography_Mark_Elements.ODF_Text_Bibliography_Mark_Element_Access is
   begin
      return
        ODF.DOM.Text_Bibliography_Mark_Elements.ODF_Text_Bibliography_Mark_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Bibliography_Mark_Element));
   end Create_Text_Bibliography_Mark_Element;

   --------------------------------------
   -- Create_Text_Bibliography_Source_Element --
   --------------------------------------

   overriding function Create_Text_Bibliography_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bibliography_Source_Elements.ODF_Text_Bibliography_Source_Element_Access is
   begin
      return
        ODF.DOM.Text_Bibliography_Source_Elements.ODF_Text_Bibliography_Source_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Bibliography_Source_Element));
   end Create_Text_Bibliography_Source_Element;

   --------------------------------------
   -- Create_Text_Bookmark_Element --
   --------------------------------------

   overriding function Create_Text_Bookmark_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bookmark_Elements.ODF_Text_Bookmark_Element_Access is
   begin
      return
        ODF.DOM.Text_Bookmark_Elements.ODF_Text_Bookmark_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Bookmark_Element));
   end Create_Text_Bookmark_Element;

   --------------------------------------
   -- Create_Text_Bookmark_End_Element --
   --------------------------------------

   overriding function Create_Text_Bookmark_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bookmark_End_Elements.ODF_Text_Bookmark_End_Element_Access is
   begin
      return
        ODF.DOM.Text_Bookmark_End_Elements.ODF_Text_Bookmark_End_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Bookmark_End_Element));
   end Create_Text_Bookmark_End_Element;

   --------------------------------------
   -- Create_Text_Bookmark_Ref_Element --
   --------------------------------------

   overriding function Create_Text_Bookmark_Ref_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bookmark_Ref_Elements.ODF_Text_Bookmark_Ref_Element_Access is
   begin
      return
        ODF.DOM.Text_Bookmark_Ref_Elements.ODF_Text_Bookmark_Ref_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Bookmark_Ref_Element));
   end Create_Text_Bookmark_Ref_Element;

   --------------------------------------
   -- Create_Text_Bookmark_Start_Element --
   --------------------------------------

   overriding function Create_Text_Bookmark_Start_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Bookmark_Start_Elements.ODF_Text_Bookmark_Start_Element_Access is
   begin
      return
        ODF.DOM.Text_Bookmark_Start_Elements.ODF_Text_Bookmark_Start_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Bookmark_Start_Element));
   end Create_Text_Bookmark_Start_Element;

   --------------------------------------
   -- Create_Text_Change_Element --
   --------------------------------------

   overriding function Create_Text_Change_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Change_Elements.ODF_Text_Change_Element_Access is
   begin
      return
        ODF.DOM.Text_Change_Elements.ODF_Text_Change_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Change_Element));
   end Create_Text_Change_Element;

   --------------------------------------
   -- Create_Text_Change_End_Element --
   --------------------------------------

   overriding function Create_Text_Change_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Change_End_Elements.ODF_Text_Change_End_Element_Access is
   begin
      return
        ODF.DOM.Text_Change_End_Elements.ODF_Text_Change_End_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Change_End_Element));
   end Create_Text_Change_End_Element;

   --------------------------------------
   -- Create_Office_Change_Info_Element --
   --------------------------------------

   overriding function Create_Office_Change_Info_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Change_Info_Elements.ODF_Office_Change_Info_Element_Access is
   begin
      return
        ODF.DOM.Office_Change_Info_Elements.ODF_Office_Change_Info_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Change_Info_Element));
   end Create_Office_Change_Info_Element;

   --------------------------------------
   -- Create_Text_Change_Start_Element --
   --------------------------------------

   overriding function Create_Text_Change_Start_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Change_Start_Elements.ODF_Text_Change_Start_Element_Access is
   begin
      return
        ODF.DOM.Text_Change_Start_Elements.ODF_Text_Change_Start_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Change_Start_Element));
   end Create_Text_Change_Start_Element;

   --------------------------------------
   -- Create_Text_Changed_Region_Element --
   --------------------------------------

   overriding function Create_Text_Changed_Region_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Changed_Region_Elements.ODF_Text_Changed_Region_Element_Access is
   begin
      return
        ODF.DOM.Text_Changed_Region_Elements.ODF_Text_Changed_Region_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Changed_Region_Element));
   end Create_Text_Changed_Region_Element;

   --------------------------------------
   -- Create_Text_Chapter_Element --
   --------------------------------------

   overriding function Create_Text_Chapter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Chapter_Elements.ODF_Text_Chapter_Element_Access is
   begin
      return
        ODF.DOM.Text_Chapter_Elements.ODF_Text_Chapter_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Chapter_Element));
   end Create_Text_Chapter_Element;

   --------------------------------------
   -- Create_Text_Character_Count_Element --
   --------------------------------------

   overriding function Create_Text_Character_Count_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Character_Count_Elements.ODF_Text_Character_Count_Element_Access is
   begin
      return
        ODF.DOM.Text_Character_Count_Elements.ODF_Text_Character_Count_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Character_Count_Element));
   end Create_Text_Character_Count_Element;

   --------------------------------------
   -- Create_Text_Conditional_Text_Element --
   --------------------------------------

   overriding function Create_Text_Conditional_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Conditional_Text_Elements.ODF_Text_Conditional_Text_Element_Access is
   begin
      return
        ODF.DOM.Text_Conditional_Text_Elements.ODF_Text_Conditional_Text_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Conditional_Text_Element));
   end Create_Text_Conditional_Text_Element;

   --------------------------------------
   -- Create_Config_Config_Item_Element --
   --------------------------------------

   overriding function Create_Config_Config_Item_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Config_Config_Item_Elements.ODF_Config_Config_Item_Element_Access is
   begin
      return
        ODF.DOM.Config_Config_Item_Elements.ODF_Config_Config_Item_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Config_URI,
            Matreshka.ODF_String_Constants.Config_Prefix,
            Matreshka.ODF_String_Constants.Config_Item_Element));
   end Create_Config_Config_Item_Element;

   --------------------------------------
   -- Create_Config_Config_Item_Map_Entry_Element --
   --------------------------------------

   overriding function Create_Config_Config_Item_Map_Entry_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Config_Config_Item_Map_Entry_Elements.ODF_Config_Config_Item_Map_Entry_Element_Access is
   begin
      return
        ODF.DOM.Config_Config_Item_Map_Entry_Elements.ODF_Config_Config_Item_Map_Entry_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Config_URI,
            Matreshka.ODF_String_Constants.Config_Prefix,
            Matreshka.ODF_String_Constants.Config_Item_Map_Entry_Element));
   end Create_Config_Config_Item_Map_Entry_Element;

   --------------------------------------
   -- Create_Config_Config_Item_Map_Indexed_Element --
   --------------------------------------

   overriding function Create_Config_Config_Item_Map_Indexed_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Config_Config_Item_Map_Indexed_Elements.ODF_Config_Config_Item_Map_Indexed_Element_Access is
   begin
      return
        ODF.DOM.Config_Config_Item_Map_Indexed_Elements.ODF_Config_Config_Item_Map_Indexed_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Config_URI,
            Matreshka.ODF_String_Constants.Config_Prefix,
            Matreshka.ODF_String_Constants.Config_Item_Map_Indexed_Element));
   end Create_Config_Config_Item_Map_Indexed_Element;

   --------------------------------------
   -- Create_Config_Config_Item_Map_Named_Element --
   --------------------------------------

   overriding function Create_Config_Config_Item_Map_Named_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Config_Config_Item_Map_Named_Elements.ODF_Config_Config_Item_Map_Named_Element_Access is
   begin
      return
        ODF.DOM.Config_Config_Item_Map_Named_Elements.ODF_Config_Config_Item_Map_Named_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Config_URI,
            Matreshka.ODF_String_Constants.Config_Prefix,
            Matreshka.ODF_String_Constants.Config_Item_Map_Named_Element));
   end Create_Config_Config_Item_Map_Named_Element;

   --------------------------------------
   -- Create_Config_Config_Item_Set_Element --
   --------------------------------------

   overriding function Create_Config_Config_Item_Set_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Config_Config_Item_Set_Elements.ODF_Config_Config_Item_Set_Element_Access is
   begin
      return
        ODF.DOM.Config_Config_Item_Set_Elements.ODF_Config_Config_Item_Set_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Config_URI,
            Matreshka.ODF_String_Constants.Config_Prefix,
            Matreshka.ODF_String_Constants.Config_Item_Set_Element));
   end Create_Config_Config_Item_Set_Element;

   --------------------------------------
   -- Create_Db_Connection_Data_Element --
   --------------------------------------

   overriding function Create_Db_Connection_Data_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Connection_Data_Elements.ODF_Db_Connection_Data_Element_Access is
   begin
      return
        ODF.DOM.Db_Connection_Data_Elements.ODF_Db_Connection_Data_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Connection_Data_Element));
   end Create_Db_Connection_Data_Element;

   --------------------------------------
   -- Create_Db_Connection_Resource_Element --
   --------------------------------------

   overriding function Create_Db_Connection_Resource_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Connection_Resource_Elements.ODF_Db_Connection_Resource_Element_Access is
   begin
      return
        ODF.DOM.Db_Connection_Resource_Elements.ODF_Db_Connection_Resource_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Connection_Resource_Element));
   end Create_Db_Connection_Resource_Element;

   --------------------------------------
   -- Create_Db_Data_Source_Element --
   --------------------------------------

   overriding function Create_Db_Data_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Data_Source_Elements.ODF_Db_Data_Source_Element_Access is
   begin
      return
        ODF.DOM.Db_Data_Source_Elements.ODF_Db_Data_Source_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Data_Source_Element));
   end Create_Db_Data_Source_Element;

   --------------------------------------
   -- Create_Db_Data_Source_Setting_Element --
   --------------------------------------

   overriding function Create_Db_Data_Source_Setting_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Data_Source_Setting_Elements.ODF_Db_Data_Source_Setting_Element_Access is
   begin
      return
        ODF.DOM.Db_Data_Source_Setting_Elements.ODF_Db_Data_Source_Setting_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Data_Source_Setting_Element));
   end Create_Db_Data_Source_Setting_Element;

   --------------------------------------
   -- Create_Db_Data_Source_Setting_Value_Element --
   --------------------------------------

   overriding function Create_Db_Data_Source_Setting_Value_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Data_Source_Setting_Value_Elements.ODF_Db_Data_Source_Setting_Value_Element_Access is
   begin
      return
        ODF.DOM.Db_Data_Source_Setting_Value_Elements.ODF_Db_Data_Source_Setting_Value_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Data_Source_Setting_Value_Element));
   end Create_Db_Data_Source_Setting_Value_Element;

   --------------------------------------
   -- Create_Db_Data_Source_Settings_Element --
   --------------------------------------

   overriding function Create_Db_Data_Source_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Data_Source_Settings_Elements.ODF_Db_Data_Source_Settings_Element_Access is
   begin
      return
        ODF.DOM.Db_Data_Source_Settings_Elements.ODF_Db_Data_Source_Settings_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Data_Source_Settings_Element));
   end Create_Db_Data_Source_Settings_Element;

   --------------------------------------
   -- Create_Db_Database_Description_Element --
   --------------------------------------

   overriding function Create_Db_Database_Description_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Database_Description_Elements.ODF_Db_Database_Description_Element_Access is
   begin
      return
        ODF.DOM.Db_Database_Description_Elements.ODF_Db_Database_Description_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Database_Description_Element));
   end Create_Db_Database_Description_Element;

   --------------------------------------
   -- Create_Db_Delimiter_Element --
   --------------------------------------

   overriding function Create_Db_Delimiter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Delimiter_Elements.ODF_Db_Delimiter_Element_Access is
   begin
      return
        ODF.DOM.Db_Delimiter_Elements.ODF_Db_Delimiter_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Delimiter_Element));
   end Create_Db_Delimiter_Element;

   --------------------------------------
   -- Create_Db_Driver_Settings_Element --
   --------------------------------------

   overriding function Create_Db_Driver_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Driver_Settings_Elements.ODF_Db_Driver_Settings_Element_Access is
   begin
      return
        ODF.DOM.Db_Driver_Settings_Elements.ODF_Db_Driver_Settings_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Driver_Settings_Element));
   end Create_Db_Driver_Settings_Element;

   --------------------------------------
   -- Create_Db_File_Based_Database_Element --
   --------------------------------------

   overriding function Create_Db_File_Based_Database_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_File_Based_Database_Elements.ODF_Db_File_Based_Database_Element_Access is
   begin
      return
        ODF.DOM.Db_File_Based_Database_Elements.ODF_Db_File_Based_Database_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.File_Based_Database_Element));
   end Create_Db_File_Based_Database_Element;

   --------------------------------------
   -- Create_Draw_Fill_Image_Element --
   --------------------------------------

   overriding function Create_Draw_Fill_Image_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Fill_Image_Elements.ODF_Draw_Fill_Image_Element_Access is
   begin
      return
        ODF.DOM.Draw_Fill_Image_Elements.ODF_Draw_Fill_Image_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Fill_Image_Element));
   end Create_Draw_Fill_Image_Element;

   --------------------------------------
   -- Create_Db_Filter_Statement_Element --
   --------------------------------------

   overriding function Create_Db_Filter_Statement_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Filter_Statement_Elements.ODF_Db_Filter_Statement_Element_Access is
   begin
      return
        ODF.DOM.Db_Filter_Statement_Elements.ODF_Db_Filter_Statement_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Filter_Statement_Element));
   end Create_Db_Filter_Statement_Element;

   --------------------------------------
   -- Create_Db_Forms_Element --
   --------------------------------------

   overriding function Create_Db_Forms_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Forms_Elements.ODF_Db_Forms_Element_Access is
   begin
      return
        ODF.DOM.Db_Forms_Elements.ODF_Db_Forms_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Forms_Element));
   end Create_Db_Forms_Element;

   --------------------------------------
   -- Create_Db_Index_Element --
   --------------------------------------

   overriding function Create_Db_Index_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Index_Elements.ODF_Db_Index_Element_Access is
   begin
      return
        ODF.DOM.Db_Index_Elements.ODF_Db_Index_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Index_Element));
   end Create_Db_Index_Element;

   --------------------------------------
   -- Create_Db_Index_Column_Element --
   --------------------------------------

   overriding function Create_Db_Index_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Index_Column_Elements.ODF_Db_Index_Column_Element_Access is
   begin
      return
        ODF.DOM.Db_Index_Column_Elements.ODF_Db_Index_Column_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Index_Column_Element));
   end Create_Db_Index_Column_Element;

   --------------------------------------
   -- Create_Db_Index_Columns_Element --
   --------------------------------------

   overriding function Create_Db_Index_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Index_Columns_Elements.ODF_Db_Index_Columns_Element_Access is
   begin
      return
        ODF.DOM.Db_Index_Columns_Elements.ODF_Db_Index_Columns_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Index_Columns_Element));
   end Create_Db_Index_Columns_Element;

   --------------------------------------
   -- Create_Db_Indices_Element --
   --------------------------------------

   overriding function Create_Db_Indices_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Indices_Elements.ODF_Db_Indices_Element_Access is
   begin
      return
        ODF.DOM.Db_Indices_Elements.ODF_Db_Indices_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Indices_Element));
   end Create_Db_Indices_Element;

   --------------------------------------
   -- Create_Db_Key_Element --
   --------------------------------------

   overriding function Create_Db_Key_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Key_Elements.ODF_Db_Key_Element_Access is
   begin
      return
        ODF.DOM.Db_Key_Elements.ODF_Db_Key_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Key_Element));
   end Create_Db_Key_Element;

   --------------------------------------
   -- Create_Db_Key_Column_Element --
   --------------------------------------

   overriding function Create_Db_Key_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Key_Column_Elements.ODF_Db_Key_Column_Element_Access is
   begin
      return
        ODF.DOM.Db_Key_Column_Elements.ODF_Db_Key_Column_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Key_Column_Element));
   end Create_Db_Key_Column_Element;

   --------------------------------------
   -- Create_Db_Key_Columns_Element --
   --------------------------------------

   overriding function Create_Db_Key_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Key_Columns_Elements.ODF_Db_Key_Columns_Element_Access is
   begin
      return
        ODF.DOM.Db_Key_Columns_Elements.ODF_Db_Key_Columns_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Key_Columns_Element));
   end Create_Db_Key_Columns_Element;

   --------------------------------------
   -- Create_Db_Keys_Element --
   --------------------------------------

   overriding function Create_Db_Keys_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Keys_Elements.ODF_Db_Keys_Element_Access is
   begin
      return
        ODF.DOM.Db_Keys_Elements.ODF_Db_Keys_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Keys_Element));
   end Create_Db_Keys_Element;

   --------------------------------------
   -- Create_Db_Login_Element --
   --------------------------------------

   overriding function Create_Db_Login_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Login_Elements.ODF_Db_Login_Element_Access is
   begin
      return
        ODF.DOM.Db_Login_Elements.ODF_Db_Login_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Login_Element));
   end Create_Db_Login_Element;

   --------------------------------------
   -- Create_Db_Order_Statement_Element --
   --------------------------------------

   overriding function Create_Db_Order_Statement_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Order_Statement_Elements.ODF_Db_Order_Statement_Element_Access is
   begin
      return
        ODF.DOM.Db_Order_Statement_Elements.ODF_Db_Order_Statement_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Order_Statement_Element));
   end Create_Db_Order_Statement_Element;

   --------------------------------------
   -- Create_Db_Queries_Element --
   --------------------------------------

   overriding function Create_Db_Queries_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Queries_Elements.ODF_Db_Queries_Element_Access is
   begin
      return
        ODF.DOM.Db_Queries_Elements.ODF_Db_Queries_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Queries_Element));
   end Create_Db_Queries_Element;

   --------------------------------------
   -- Create_Db_Query_Element --
   --------------------------------------

   overriding function Create_Db_Query_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Query_Elements.ODF_Db_Query_Element_Access is
   begin
      return
        ODF.DOM.Db_Query_Elements.ODF_Db_Query_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Query_Element));
   end Create_Db_Query_Element;

   --------------------------------------
   -- Create_Db_Query_Collection_Element --
   --------------------------------------

   overriding function Create_Db_Query_Collection_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Query_Collection_Elements.ODF_Db_Query_Collection_Element_Access is
   begin
      return
        ODF.DOM.Db_Query_Collection_Elements.ODF_Db_Query_Collection_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Query_Collection_Element));
   end Create_Db_Query_Collection_Element;

   --------------------------------------
   -- Create_Db_Reports_Element --
   --------------------------------------

   overriding function Create_Db_Reports_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Reports_Elements.ODF_Db_Reports_Element_Access is
   begin
      return
        ODF.DOM.Db_Reports_Elements.ODF_Db_Reports_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Reports_Element));
   end Create_Db_Reports_Element;

   --------------------------------------
   -- Create_Db_Schema_Definition_Element --
   --------------------------------------

   overriding function Create_Db_Schema_Definition_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Schema_Definition_Elements.ODF_Db_Schema_Definition_Element_Access is
   begin
      return
        ODF.DOM.Db_Schema_Definition_Elements.ODF_Db_Schema_Definition_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Schema_Definition_Element));
   end Create_Db_Schema_Definition_Element;

   --------------------------------------
   -- Create_Db_Server_Database_Element --
   --------------------------------------

   overriding function Create_Db_Server_Database_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Server_Database_Elements.ODF_Db_Server_Database_Element_Access is
   begin
      return
        ODF.DOM.Db_Server_Database_Elements.ODF_Db_Server_Database_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Server_Database_Element));
   end Create_Db_Server_Database_Element;

   --------------------------------------
   -- Create_Db_Table_Definition_Element --
   --------------------------------------

   overriding function Create_Db_Table_Definition_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Definition_Elements.ODF_Db_Table_Definition_Element_Access is
   begin
      return
        ODF.DOM.Db_Table_Definition_Elements.ODF_Db_Table_Definition_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Table_Definition_Element));
   end Create_Db_Table_Definition_Element;

   --------------------------------------
   -- Create_Db_Table_Definitions_Element --
   --------------------------------------

   overriding function Create_Db_Table_Definitions_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Definitions_Elements.ODF_Db_Table_Definitions_Element_Access is
   begin
      return
        ODF.DOM.Db_Table_Definitions_Elements.ODF_Db_Table_Definitions_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Table_Definitions_Element));
   end Create_Db_Table_Definitions_Element;

   --------------------------------------
   -- Create_Db_Table_Exclude_Filter_Element --
   --------------------------------------

   overriding function Create_Db_Table_Exclude_Filter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Exclude_Filter_Elements.ODF_Db_Table_Exclude_Filter_Element_Access is
   begin
      return
        ODF.DOM.Db_Table_Exclude_Filter_Elements.ODF_Db_Table_Exclude_Filter_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Table_Exclude_Filter_Element));
   end Create_Db_Table_Exclude_Filter_Element;

   --------------------------------------
   -- Create_Db_Table_Filter_Element --
   --------------------------------------

   overriding function Create_Db_Table_Filter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Filter_Elements.ODF_Db_Table_Filter_Element_Access is
   begin
      return
        ODF.DOM.Db_Table_Filter_Elements.ODF_Db_Table_Filter_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Table_Filter_Element));
   end Create_Db_Table_Filter_Element;

   --------------------------------------
   -- Create_Db_Table_Filter_Pattern_Element --
   --------------------------------------

   overriding function Create_Db_Table_Filter_Pattern_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Filter_Pattern_Elements.ODF_Db_Table_Filter_Pattern_Element_Access is
   begin
      return
        ODF.DOM.Db_Table_Filter_Pattern_Elements.ODF_Db_Table_Filter_Pattern_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Table_Filter_Pattern_Element));
   end Create_Db_Table_Filter_Pattern_Element;

   --------------------------------------
   -- Create_Db_Table_Include_Filter_Element --
   --------------------------------------

   overriding function Create_Db_Table_Include_Filter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Include_Filter_Elements.ODF_Db_Table_Include_Filter_Element_Access is
   begin
      return
        ODF.DOM.Db_Table_Include_Filter_Elements.ODF_Db_Table_Include_Filter_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Table_Include_Filter_Element));
   end Create_Db_Table_Include_Filter_Element;

   --------------------------------------
   -- Create_Db_Table_Representation_Element --
   --------------------------------------

   overriding function Create_Db_Table_Representation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Representation_Elements.ODF_Db_Table_Representation_Element_Access is
   begin
      return
        ODF.DOM.Db_Table_Representation_Elements.ODF_Db_Table_Representation_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Table_Representation_Element));
   end Create_Db_Table_Representation_Element;

   --------------------------------------
   -- Create_Db_Table_Representations_Element --
   --------------------------------------

   overriding function Create_Db_Table_Representations_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Representations_Elements.ODF_Db_Table_Representations_Element_Access is
   begin
      return
        ODF.DOM.Db_Table_Representations_Elements.ODF_Db_Table_Representations_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Table_Representations_Element));
   end Create_Db_Table_Representations_Element;

   --------------------------------------
   -- Create_Db_Table_Setting_Element --
   --------------------------------------

   overriding function Create_Db_Table_Setting_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Setting_Elements.ODF_Db_Table_Setting_Element_Access is
   begin
      return
        ODF.DOM.Db_Table_Setting_Elements.ODF_Db_Table_Setting_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Table_Setting_Element));
   end Create_Db_Table_Setting_Element;

   --------------------------------------
   -- Create_Db_Table_Settings_Element --
   --------------------------------------

   overriding function Create_Db_Table_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Settings_Elements.ODF_Db_Table_Settings_Element_Access is
   begin
      return
        ODF.DOM.Db_Table_Settings_Elements.ODF_Db_Table_Settings_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Table_Settings_Element));
   end Create_Db_Table_Settings_Element;

   --------------------------------------
   -- Create_Db_Table_Type_Element --
   --------------------------------------

   overriding function Create_Db_Table_Type_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Type_Elements.ODF_Db_Table_Type_Element_Access is
   begin
      return
        ODF.DOM.Db_Table_Type_Elements.ODF_Db_Table_Type_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Table_Type_Element));
   end Create_Db_Table_Type_Element;

   --------------------------------------
   -- Create_Db_Table_Type_Filter_Element --
   --------------------------------------

   overriding function Create_Db_Table_Type_Filter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Table_Type_Filter_Elements.ODF_Db_Table_Type_Filter_Element_Access is
   begin
      return
        ODF.DOM.Db_Table_Type_Filter_Elements.ODF_Db_Table_Type_Filter_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Table_Type_Filter_Element));
   end Create_Db_Table_Type_Filter_Element;

   --------------------------------------
   -- Create_Db_Update_Table_Element --
   --------------------------------------

   overriding function Create_Db_Update_Table_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Db_Update_Table_Elements.ODF_Db_Update_Table_Element_Access is
   begin
      return
        ODF.DOM.Db_Update_Table_Elements.ODF_Db_Update_Table_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Db_URI,
            Matreshka.ODF_String_Constants.Db_Prefix,
            Matreshka.ODF_String_Constants.Update_Table_Element));
   end Create_Db_Update_Table_Element;

   --------------------------------------
   -- Create_Draw_Connector_Element --
   --------------------------------------

   overriding function Create_Draw_Connector_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Connector_Elements.ODF_Draw_Connector_Element_Access is
   begin
      return
        ODF.DOM.Draw_Connector_Elements.ODF_Draw_Connector_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Connector_Element));
   end Create_Draw_Connector_Element;

   --------------------------------------
   -- Create_Draw_Contour_Path_Element --
   --------------------------------------

   overriding function Create_Draw_Contour_Path_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Contour_Path_Elements.ODF_Draw_Contour_Path_Element_Access is
   begin
      return
        ODF.DOM.Draw_Contour_Path_Elements.ODF_Draw_Contour_Path_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Contour_Path_Element));
   end Create_Draw_Contour_Path_Element;

   --------------------------------------
   -- Create_Draw_Contour_Polygon_Element --
   --------------------------------------

   overriding function Create_Draw_Contour_Polygon_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Contour_Polygon_Elements.ODF_Draw_Contour_Polygon_Element_Access is
   begin
      return
        ODF.DOM.Draw_Contour_Polygon_Elements.ODF_Draw_Contour_Polygon_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Contour_Polygon_Element));
   end Create_Draw_Contour_Polygon_Element;

   --------------------------------------
   -- Create_Draw_Control_Element --
   --------------------------------------

   overriding function Create_Draw_Control_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Control_Elements.ODF_Draw_Control_Element_Access is
   begin
      return
        ODF.DOM.Draw_Control_Elements.ODF_Draw_Control_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Control_Element));
   end Create_Draw_Control_Element;

   --------------------------------------
   -- Create_Form_Connection_Resource_Element --
   --------------------------------------

   overriding function Create_Form_Connection_Resource_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Connection_Resource_Elements.ODF_Form_Connection_Resource_Element_Access is
   begin
      return
        ODF.DOM.Form_Connection_Resource_Elements.ODF_Form_Connection_Resource_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Connection_Resource_Element));
   end Create_Form_Connection_Resource_Element;

   --------------------------------------
   -- Create_Table_Consolidation_Element --
   --------------------------------------

   overriding function Create_Table_Consolidation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Consolidation_Elements.ODF_Table_Consolidation_Element_Access is
   begin
      return
        ODF.DOM.Table_Consolidation_Elements.ODF_Table_Consolidation_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Consolidation_Element));
   end Create_Table_Consolidation_Element;

   --------------------------------------
   -- Create_Table_Content_Validation_Element --
   --------------------------------------

   overriding function Create_Table_Content_Validation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Content_Validation_Elements.ODF_Table_Content_Validation_Element_Access is
   begin
      return
        ODF.DOM.Table_Content_Validation_Elements.ODF_Table_Content_Validation_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Content_Validation_Element));
   end Create_Table_Content_Validation_Element;

   --------------------------------------
   -- Create_Table_Content_Validations_Element --
   --------------------------------------

   overriding function Create_Table_Content_Validations_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Content_Validations_Elements.ODF_Table_Content_Validations_Element_Access is
   begin
      return
        ODF.DOM.Table_Content_Validations_Elements.ODF_Table_Content_Validations_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Content_Validations_Element));
   end Create_Table_Content_Validations_Element;

   --------------------------------------
   -- Create_Table_Covered_Table_Cell_Element --
   --------------------------------------

   overriding function Create_Table_Covered_Table_Cell_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Covered_Table_Cell_Elements.ODF_Table_Covered_Table_Cell_Element_Access is
   begin
      return
        ODF.DOM.Table_Covered_Table_Cell_Elements.ODF_Table_Covered_Table_Cell_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Covered_Table_Cell_Element));
   end Create_Table_Covered_Table_Cell_Element;

   --------------------------------------
   -- Create_Meta_Creation_Date_Element --
   --------------------------------------

   overriding function Create_Meta_Creation_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Creation_Date_Elements.ODF_Meta_Creation_Date_Element_Access is
   begin
      return
        ODF.DOM.Meta_Creation_Date_Elements.ODF_Meta_Creation_Date_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Meta_URI,
            Matreshka.ODF_String_Constants.Meta_Prefix,
            Matreshka.ODF_String_Constants.Creation_Date_Element));
   end Create_Meta_Creation_Date_Element;

   --------------------------------------
   -- Create_Text_Creation_Date_Element --
   --------------------------------------

   overriding function Create_Text_Creation_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Creation_Date_Elements.ODF_Text_Creation_Date_Element_Access is
   begin
      return
        ODF.DOM.Text_Creation_Date_Elements.ODF_Text_Creation_Date_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Creation_Date_Element));
   end Create_Text_Creation_Date_Element;

   --------------------------------------
   -- Create_Text_Creation_Time_Element --
   --------------------------------------

   overriding function Create_Text_Creation_Time_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Creation_Time_Elements.ODF_Text_Creation_Time_Element_Access is
   begin
      return
        ODF.DOM.Text_Creation_Time_Elements.ODF_Text_Creation_Time_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Creation_Time_Element));
   end Create_Text_Creation_Time_Element;

   --------------------------------------
   -- Create_Dc_Creator_Element --
   --------------------------------------

   overriding function Create_Dc_Creator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dc_Creator_Elements.ODF_Dc_Creator_Element_Access is
   begin
      return
        ODF.DOM.Dc_Creator_Elements.ODF_Dc_Creator_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Dc_URI,
            Matreshka.ODF_String_Constants.Dc_Prefix,
            Matreshka.ODF_String_Constants.Creator_Element));
   end Create_Dc_Creator_Element;

   --------------------------------------
   -- Create_Dr3d_Cube_Element --
   --------------------------------------

   overriding function Create_Dr3d_Cube_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dr3d_Cube_Elements.ODF_Dr3d_Cube_Element_Access is
   begin
      return
        ODF.DOM.Dr3d_Cube_Elements.ODF_Dr3d_Cube_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Dr3d_URI,
            Matreshka.ODF_String_Constants.Dr3d_Prefix,
            Matreshka.ODF_String_Constants.Cube_Element));
   end Create_Dr3d_Cube_Element;

   --------------------------------------
   -- Create_Number_Currency_Style_Element --
   --------------------------------------

   overriding function Create_Number_Currency_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Currency_Style_Elements.ODF_Number_Currency_Style_Element_Access is
   begin
      return
        ODF.DOM.Number_Currency_Style_Elements.ODF_Number_Currency_Style_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Currency_Style_Element));
   end Create_Number_Currency_Style_Element;

   --------------------------------------
   -- Create_Number_Currency_Symbol_Element --
   --------------------------------------

   overriding function Create_Number_Currency_Symbol_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Currency_Symbol_Elements.ODF_Number_Currency_Symbol_Element_Access is
   begin
      return
        ODF.DOM.Number_Currency_Symbol_Elements.ODF_Number_Currency_Symbol_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Currency_Symbol_Element));
   end Create_Number_Currency_Symbol_Element;

   --------------------------------------
   -- Create_Draw_Custom_Shape_Element --
   --------------------------------------

   overriding function Create_Draw_Custom_Shape_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Custom_Shape_Elements.ODF_Draw_Custom_Shape_Element_Access is
   begin
      return
        ODF.DOM.Draw_Custom_Shape_Elements.ODF_Draw_Custom_Shape_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Custom_Shape_Element));
   end Create_Draw_Custom_Shape_Element;

   --------------------------------------
   -- Create_Form_Date_Element --
   --------------------------------------

   overriding function Create_Form_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Date_Elements.ODF_Form_Date_Element_Access is
   begin
      return
        ODF.DOM.Form_Date_Elements.ODF_Form_Date_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Date_Element));
   end Create_Form_Date_Element;

   --------------------------------------
   -- Create_Meta_Date_String_Element --
   --------------------------------------

   overriding function Create_Meta_Date_String_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Date_String_Elements.ODF_Meta_Date_String_Element_Access is
   begin
      return
        ODF.DOM.Meta_Date_String_Elements.ODF_Meta_Date_String_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Meta_URI,
            Matreshka.ODF_String_Constants.Meta_Prefix,
            Matreshka.ODF_String_Constants.Date_String_Element));
   end Create_Meta_Date_String_Element;

   --------------------------------------
   -- Create_Number_Date_Style_Element --
   --------------------------------------

   overriding function Create_Number_Date_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Date_Style_Elements.ODF_Number_Date_Style_Element_Access is
   begin
      return
        ODF.DOM.Number_Date_Style_Elements.ODF_Number_Date_Style_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Date_Style_Element));
   end Create_Number_Date_Style_Element;

   --------------------------------------
   -- Create_Number_Day_Element --
   --------------------------------------

   overriding function Create_Number_Day_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Day_Elements.ODF_Number_Day_Element_Access is
   begin
      return
        ODF.DOM.Number_Day_Elements.ODF_Number_Day_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Day_Element));
   end Create_Number_Day_Element;

   --------------------------------------
   -- Create_Number_Day_Of_Week_Element --
   --------------------------------------

   overriding function Create_Number_Day_Of_Week_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Day_Of_Week_Elements.ODF_Number_Day_Of_Week_Element_Access is
   begin
      return
        ODF.DOM.Number_Day_Of_Week_Elements.ODF_Number_Day_Of_Week_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Day_Of_Week_Element));
   end Create_Number_Day_Of_Week_Element;

   --------------------------------------
   -- Create_Number_Embedded_Text_Element --
   --------------------------------------

   overriding function Create_Number_Embedded_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Embedded_Text_Elements.ODF_Number_Embedded_Text_Element_Access is
   begin
      return
        ODF.DOM.Number_Embedded_Text_Elements.ODF_Number_Embedded_Text_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Embedded_Text_Element));
   end Create_Number_Embedded_Text_Element;

   --------------------------------------
   -- Create_Office_Database_Element --
   --------------------------------------

   overriding function Create_Office_Database_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Database_Elements.ODF_Office_Database_Element_Access is
   begin
      return
        ODF.DOM.Office_Database_Elements.ODF_Office_Database_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Database_Element));
   end Create_Office_Database_Element;

   --------------------------------------
   -- Create_Office_Dde_Source_Element --
   --------------------------------------

   overriding function Create_Office_Dde_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Dde_Source_Elements.ODF_Office_Dde_Source_Element_Access is
   begin
      return
        ODF.DOM.Office_Dde_Source_Elements.ODF_Office_Dde_Source_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Dde_Source_Element));
   end Create_Office_Dde_Source_Element;

   --------------------------------------
   -- Create_Presentation_Date_Time_Element --
   --------------------------------------

   overriding function Create_Presentation_Date_Time_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Date_Time_Elements.ODF_Presentation_Date_Time_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Date_Time_Elements.ODF_Presentation_Date_Time_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Date_Time_Element));
   end Create_Presentation_Date_Time_Element;

   --------------------------------------
   -- Create_Presentation_Date_Time_Decl_Element --
   --------------------------------------

   overriding function Create_Presentation_Date_Time_Decl_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Date_Time_Decl_Elements.ODF_Presentation_Date_Time_Decl_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Date_Time_Decl_Elements.ODF_Presentation_Date_Time_Decl_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Date_Time_Decl_Element));
   end Create_Presentation_Date_Time_Decl_Element;

   --------------------------------------
   -- Create_Style_Default_Page_Layout_Element --
   --------------------------------------

   overriding function Create_Style_Default_Page_Layout_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Default_Page_Layout_Elements.ODF_Style_Default_Page_Layout_Element_Access is
   begin
      return
        ODF.DOM.Style_Default_Page_Layout_Elements.ODF_Style_Default_Page_Layout_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Default_Page_Layout_Element));
   end Create_Style_Default_Page_Layout_Element;

   --------------------------------------
   -- Create_Style_Default_Style_Element --
   --------------------------------------

   overriding function Create_Style_Default_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Default_Style_Elements.ODF_Style_Default_Style_Element_Access is
   begin
      return
        ODF.DOM.Style_Default_Style_Elements.ODF_Style_Default_Style_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Default_Style_Element));
   end Create_Style_Default_Style_Element;

   --------------------------------------
   -- Create_Style_Drawing_Page_Properties_Element --
   --------------------------------------

   overriding function Create_Style_Drawing_Page_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Drawing_Page_Properties_Elements.ODF_Style_Drawing_Page_Properties_Element_Access is
   begin
      return
        ODF.DOM.Style_Drawing_Page_Properties_Elements.ODF_Style_Drawing_Page_Properties_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Drawing_Page_Properties_Element));
   end Create_Style_Drawing_Page_Properties_Element;

   --------------------------------------
   -- Create_Style_Drop_Cap_Element --
   --------------------------------------

   overriding function Create_Style_Drop_Cap_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Drop_Cap_Elements.ODF_Style_Drop_Cap_Element_Access is
   begin
      return
        ODF.DOM.Style_Drop_Cap_Elements.ODF_Style_Drop_Cap_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Drop_Cap_Element));
   end Create_Style_Drop_Cap_Element;

   --------------------------------------
   -- Create_Svg_Definition_Src_Element --
   --------------------------------------

   overriding function Create_Svg_Definition_Src_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Definition_Src_Elements.ODF_Svg_Definition_Src_Element_Access is
   begin
      return
        ODF.DOM.Svg_Definition_Src_Elements.ODF_Svg_Definition_Src_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Svg_URI,
            Matreshka.ODF_String_Constants.Svg_Prefix,
            Matreshka.ODF_String_Constants.Definition_Src_Element));
   end Create_Svg_Definition_Src_Element;

   --------------------------------------
   -- Create_Table_Dde_Link_Element --
   --------------------------------------

   overriding function Create_Table_Dde_Link_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Dde_Link_Elements.ODF_Table_Dde_Link_Element_Access is
   begin
      return
        ODF.DOM.Table_Dde_Link_Elements.ODF_Table_Dde_Link_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Dde_Link_Element));
   end Create_Table_Dde_Link_Element;

   --------------------------------------
   -- Create_Presentation_Dim_Element --
   --------------------------------------

   overriding function Create_Presentation_Dim_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Dim_Elements.ODF_Presentation_Dim_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Dim_Elements.ODF_Presentation_Dim_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Dim_Element));
   end Create_Presentation_Dim_Element;

   --------------------------------------
   -- Create_Draw_Enhanced_Geometry_Element --
   --------------------------------------

   overriding function Create_Draw_Enhanced_Geometry_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Enhanced_Geometry_Elements.ODF_Draw_Enhanced_Geometry_Element_Access is
   begin
      return
        ODF.DOM.Draw_Enhanced_Geometry_Elements.ODF_Draw_Enhanced_Geometry_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Enhanced_Geometry_Element));
   end Create_Draw_Enhanced_Geometry_Element;

   --------------------------------------
   -- Create_Dr3d_Extrude_Element --
   --------------------------------------

   overriding function Create_Dr3d_Extrude_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dr3d_Extrude_Elements.ODF_Dr3d_Extrude_Element_Access is
   begin
      return
        ODF.DOM.Dr3d_Extrude_Elements.ODF_Dr3d_Extrude_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Dr3d_URI,
            Matreshka.ODF_String_Constants.Dr3d_Prefix,
            Matreshka.ODF_String_Constants.Extrude_Element));
   end Create_Dr3d_Extrude_Element;

   --------------------------------------
   -- Create_Dr3d_Light_Element --
   --------------------------------------

   overriding function Create_Dr3d_Light_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dr3d_Light_Elements.ODF_Dr3d_Light_Element_Access is
   begin
      return
        ODF.DOM.Dr3d_Light_Elements.ODF_Dr3d_Light_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Dr3d_URI,
            Matreshka.ODF_String_Constants.Dr3d_Prefix,
            Matreshka.ODF_String_Constants.Light_Element));
   end Create_Dr3d_Light_Element;

   --------------------------------------
   -- Create_Dr3d_Rotate_Element --
   --------------------------------------

   overriding function Create_Dr3d_Rotate_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dr3d_Rotate_Elements.ODF_Dr3d_Rotate_Element_Access is
   begin
      return
        ODF.DOM.Dr3d_Rotate_Elements.ODF_Dr3d_Rotate_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Dr3d_URI,
            Matreshka.ODF_String_Constants.Dr3d_Prefix,
            Matreshka.ODF_String_Constants.Rotate_Element));
   end Create_Dr3d_Rotate_Element;

   --------------------------------------
   -- Create_Dr3d_Scene_Element --
   --------------------------------------

   overriding function Create_Dr3d_Scene_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dr3d_Scene_Elements.ODF_Dr3d_Scene_Element_Access is
   begin
      return
        ODF.DOM.Dr3d_Scene_Elements.ODF_Dr3d_Scene_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Dr3d_URI,
            Matreshka.ODF_String_Constants.Dr3d_Prefix,
            Matreshka.ODF_String_Constants.Scene_Element));
   end Create_Dr3d_Scene_Element;

   --------------------------------------
   -- Create_Dr3d_Sphere_Element --
   --------------------------------------

   overriding function Create_Dr3d_Sphere_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dr3d_Sphere_Elements.ODF_Dr3d_Sphere_Element_Access is
   begin
      return
        ODF.DOM.Dr3d_Sphere_Elements.ODF_Dr3d_Sphere_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Dr3d_URI,
            Matreshka.ODF_String_Constants.Dr3d_Prefix,
            Matreshka.ODF_String_Constants.Sphere_Element));
   end Create_Dr3d_Sphere_Element;

   --------------------------------------
   -- Create_Svg_Desc_Element --
   --------------------------------------

   overriding function Create_Svg_Desc_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Desc_Elements.ODF_Svg_Desc_Element_Access is
   begin
      return
        ODF.DOM.Svg_Desc_Elements.ODF_Svg_Desc_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Svg_URI,
            Matreshka.ODF_String_Constants.Svg_Prefix,
            Matreshka.ODF_String_Constants.Desc_Element));
   end Create_Svg_Desc_Element;

   --------------------------------------
   -- Create_Draw_Ellipse_Element --
   --------------------------------------

   overriding function Create_Draw_Ellipse_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Ellipse_Elements.ODF_Draw_Ellipse_Element_Access is
   begin
      return
        ODF.DOM.Draw_Ellipse_Elements.ODF_Draw_Ellipse_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Ellipse_Element));
   end Create_Draw_Ellipse_Element;

   --------------------------------------
   -- Create_Draw_Equation_Element --
   --------------------------------------

   overriding function Create_Draw_Equation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Equation_Elements.ODF_Draw_Equation_Element_Access is
   begin
      return
        ODF.DOM.Draw_Equation_Elements.ODF_Draw_Equation_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Equation_Element));
   end Create_Draw_Equation_Element;

   --------------------------------------
   -- Create_Number_Era_Element --
   --------------------------------------

   overriding function Create_Number_Era_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Era_Elements.ODF_Number_Era_Element_Access is
   begin
      return
        ODF.DOM.Number_Era_Elements.ODF_Number_Era_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Era_Element));
   end Create_Number_Era_Element;

   --------------------------------------
   -- Create_Table_Even_Columns_Element --
   --------------------------------------

   overriding function Create_Table_Even_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Even_Columns_Elements.ODF_Table_Even_Columns_Element_Access is
   begin
      return
        ODF.DOM.Table_Even_Columns_Elements.ODF_Table_Even_Columns_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Even_Columns_Element));
   end Create_Table_Even_Columns_Element;

   --------------------------------------
   -- Create_Table_Even_Rows_Element --
   --------------------------------------

   overriding function Create_Table_Even_Rows_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Even_Rows_Elements.ODF_Table_Even_Rows_Element_Access is
   begin
      return
        ODF.DOM.Table_Even_Rows_Elements.ODF_Table_Even_Rows_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Even_Rows_Element));
   end Create_Table_Even_Rows_Element;

   --------------------------------------
   -- Create_Script_Event_Listener_Element --
   --------------------------------------

   overriding function Create_Script_Event_Listener_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Script_Event_Listener_Elements.ODF_Script_Event_Listener_Element_Access is
   begin
      return
        ODF.DOM.Script_Event_Listener_Elements.ODF_Script_Event_Listener_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Script_URI,
            Matreshka.ODF_String_Constants.Script_Prefix,
            Matreshka.ODF_String_Constants.Event_Listener_Element));
   end Create_Script_Event_Listener_Element;

   --------------------------------------
   -- Create_Form_File_Element --
   --------------------------------------

   overriding function Create_Form_File_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_File_Elements.ODF_Form_File_Element_Access is
   begin
      return
        ODF.DOM.Form_File_Elements.ODF_Form_File_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.File_Element));
   end Create_Form_File_Element;

   --------------------------------------
   -- Create_Form_Fixed_Text_Element --
   --------------------------------------

   overriding function Create_Form_Fixed_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Fixed_Text_Elements.ODF_Form_Fixed_Text_Element_Access is
   begin
      return
        ODF.DOM.Form_Fixed_Text_Elements.ODF_Form_Fixed_Text_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Fixed_Text_Element));
   end Create_Form_Fixed_Text_Element;

   --------------------------------------
   -- Create_Presentation_Event_Listener_Element --
   --------------------------------------

   overriding function Create_Presentation_Event_Listener_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Event_Listener_Elements.ODF_Presentation_Event_Listener_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Event_Listener_Elements.ODF_Presentation_Event_Listener_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Event_Listener_Element));
   end Create_Presentation_Event_Listener_Element;

   --------------------------------------
   -- Create_Draw_Floating_Frame_Element --
   --------------------------------------

   overriding function Create_Draw_Floating_Frame_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Floating_Frame_Elements.ODF_Draw_Floating_Frame_Element_Access is
   begin
      return
        ODF.DOM.Draw_Floating_Frame_Elements.ODF_Draw_Floating_Frame_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Floating_Frame_Element));
   end Create_Draw_Floating_Frame_Element;

   --------------------------------------
   -- Create_Form_Form_Element --
   --------------------------------------

   overriding function Create_Form_Form_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Form_Elements.ODF_Form_Form_Element_Access is
   begin
      return
        ODF.DOM.Form_Form_Elements.ODF_Form_Form_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Form_Element));
   end Create_Form_Form_Element;

   --------------------------------------
   -- Create_Form_Formatted_Text_Element --
   --------------------------------------

   overriding function Create_Form_Formatted_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Formatted_Text_Elements.ODF_Form_Formatted_Text_Element_Access is
   begin
      return
        ODF.DOM.Form_Formatted_Text_Elements.ODF_Form_Formatted_Text_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Formatted_Text_Element));
   end Create_Form_Formatted_Text_Element;

   --------------------------------------
   -- Create_Number_Fraction_Element --
   --------------------------------------

   overriding function Create_Number_Fraction_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Fraction_Elements.ODF_Number_Fraction_Element_Access is
   begin
      return
        ODF.DOM.Number_Fraction_Elements.ODF_Number_Fraction_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Fraction_Element));
   end Create_Number_Fraction_Element;

   --------------------------------------
   -- Create_Draw_Frame_Element --
   --------------------------------------

   overriding function Create_Draw_Frame_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Frame_Elements.ODF_Draw_Frame_Element_Access is
   begin
      return
        ODF.DOM.Draw_Frame_Elements.ODF_Draw_Frame_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Frame_Element));
   end Create_Draw_Frame_Element;

   --------------------------------------
   -- Create_Form_Frame_Element --
   --------------------------------------

   overriding function Create_Form_Frame_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Frame_Elements.ODF_Form_Frame_Element_Access is
   begin
      return
        ODF.DOM.Form_Frame_Elements.ODF_Form_Frame_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Frame_Element));
   end Create_Form_Frame_Element;

   --------------------------------------
   -- Create_Form_Generic_Control_Element --
   --------------------------------------

   overriding function Create_Form_Generic_Control_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Generic_Control_Elements.ODF_Form_Generic_Control_Element_Access is
   begin
      return
        ODF.DOM.Form_Generic_Control_Elements.ODF_Form_Generic_Control_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Generic_Control_Element));
   end Create_Form_Generic_Control_Element;

   --------------------------------------
   -- Create_Office_Event_Listeners_Element --
   --------------------------------------

   overriding function Create_Office_Event_Listeners_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Event_Listeners_Elements.ODF_Office_Event_Listeners_Element_Access is
   begin
      return
        ODF.DOM.Office_Event_Listeners_Elements.ODF_Office_Event_Listeners_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Event_Listeners_Element));
   end Create_Office_Event_Listeners_Element;

   --------------------------------------
   -- Create_Style_Font_Face_Element --
   --------------------------------------

   overriding function Create_Style_Font_Face_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Font_Face_Elements.ODF_Style_Font_Face_Element_Access is
   begin
      return
        ODF.DOM.Style_Font_Face_Elements.ODF_Style_Font_Face_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Font_Face_Element));
   end Create_Style_Font_Face_Element;

   --------------------------------------
   -- Create_Svg_Font_Face_Format_Element --
   --------------------------------------

   overriding function Create_Svg_Font_Face_Format_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Font_Face_Format_Elements.ODF_Svg_Font_Face_Format_Element_Access is
   begin
      return
        ODF.DOM.Svg_Font_Face_Format_Elements.ODF_Svg_Font_Face_Format_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Svg_URI,
            Matreshka.ODF_String_Constants.Svg_Prefix,
            Matreshka.ODF_String_Constants.Font_Face_Format_Element));
   end Create_Svg_Font_Face_Format_Element;

   --------------------------------------
   -- Create_Svg_Font_Face_Name_Element --
   --------------------------------------

   overriding function Create_Svg_Font_Face_Name_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Font_Face_Name_Elements.ODF_Svg_Font_Face_Name_Element_Access is
   begin
      return
        ODF.DOM.Svg_Font_Face_Name_Elements.ODF_Svg_Font_Face_Name_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Svg_URI,
            Matreshka.ODF_String_Constants.Svg_Prefix,
            Matreshka.ODF_String_Constants.Font_Face_Name_Element));
   end Create_Svg_Font_Face_Name_Element;

   --------------------------------------
   -- Create_Svg_Font_Face_Src_Element --
   --------------------------------------

   overriding function Create_Svg_Font_Face_Src_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Font_Face_Src_Elements.ODF_Svg_Font_Face_Src_Element_Access is
   begin
      return
        ODF.DOM.Svg_Font_Face_Src_Elements.ODF_Svg_Font_Face_Src_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Svg_URI,
            Matreshka.ODF_String_Constants.Svg_Prefix,
            Matreshka.ODF_String_Constants.Font_Face_Src_Element));
   end Create_Svg_Font_Face_Src_Element;

   --------------------------------------
   -- Create_Svg_Font_Face_Uri_Element --
   --------------------------------------

   overriding function Create_Svg_Font_Face_Uri_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Font_Face_Uri_Elements.ODF_Svg_Font_Face_Uri_Element_Access is
   begin
      return
        ODF.DOM.Svg_Font_Face_Uri_Elements.ODF_Svg_Font_Face_Uri_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Svg_URI,
            Matreshka.ODF_String_Constants.Svg_Prefix,
            Matreshka.ODF_String_Constants.Font_Face_Uri_Element));
   end Create_Svg_Font_Face_Uri_Element;

   --------------------------------------
   -- Create_Table_First_Column_Element --
   --------------------------------------

   overriding function Create_Table_First_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_First_Column_Elements.ODF_Table_First_Column_Element_Access is
   begin
      return
        ODF.DOM.Table_First_Column_Elements.ODF_Table_First_Column_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.First_Column_Element));
   end Create_Table_First_Column_Element;

   --------------------------------------
   -- Create_Table_First_Row_Element --
   --------------------------------------

   overriding function Create_Table_First_Row_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_First_Row_Elements.ODF_Table_First_Row_Element_Access is
   begin
      return
        ODF.DOM.Table_First_Row_Elements.ODF_Table_First_Row_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.First_Row_Element));
   end Create_Table_First_Row_Element;

   --------------------------------------
   -- Create_Office_Forms_Element --
   --------------------------------------

   overriding function Create_Office_Forms_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Forms_Elements.ODF_Office_Forms_Element_Access is
   begin
      return
        ODF.DOM.Office_Forms_Elements.ODF_Office_Forms_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Forms_Element));
   end Create_Office_Forms_Element;

   --------------------------------------
   -- Create_Presentation_Footer_Element --
   --------------------------------------

   overriding function Create_Presentation_Footer_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Footer_Elements.ODF_Presentation_Footer_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Footer_Elements.ODF_Presentation_Footer_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Footer_Element));
   end Create_Presentation_Footer_Element;

   --------------------------------------
   -- Create_Style_Footer_Element --
   --------------------------------------

   overriding function Create_Style_Footer_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Footer_Elements.ODF_Style_Footer_Element_Access is
   begin
      return
        ODF.DOM.Style_Footer_Elements.ODF_Style_Footer_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Footer_Element));
   end Create_Style_Footer_Element;

   --------------------------------------
   -- Create_Presentation_Footer_Decl_Element --
   --------------------------------------

   overriding function Create_Presentation_Footer_Decl_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Footer_Decl_Elements.ODF_Presentation_Footer_Decl_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Footer_Decl_Elements.ODF_Presentation_Footer_Decl_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Footer_Decl_Element));
   end Create_Presentation_Footer_Decl_Element;

   --------------------------------------
   -- Create_Style_Footer_Left_Element --
   --------------------------------------

   overriding function Create_Style_Footer_Left_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Footer_Left_Elements.ODF_Style_Footer_Left_Element_Access is
   begin
      return
        ODF.DOM.Style_Footer_Left_Elements.ODF_Style_Footer_Left_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Footer_Left_Element));
   end Create_Style_Footer_Left_Element;

   --------------------------------------
   -- Create_Style_Footer_Style_Element --
   --------------------------------------

   overriding function Create_Style_Footer_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Footer_Style_Elements.ODF_Style_Footer_Style_Element_Access is
   begin
      return
        ODF.DOM.Style_Footer_Style_Elements.ODF_Style_Footer_Style_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Footer_Style_Element));
   end Create_Style_Footer_Style_Element;

   --------------------------------------
   -- Create_Style_Footnote_Sep_Element --
   --------------------------------------

   overriding function Create_Style_Footnote_Sep_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Footnote_Sep_Elements.ODF_Style_Footnote_Sep_Element_Access is
   begin
      return
        ODF.DOM.Style_Footnote_Sep_Elements.ODF_Style_Footnote_Sep_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Footnote_Sep_Element));
   end Create_Style_Footnote_Sep_Element;

   --------------------------------------
   -- Create_Draw_G_Element --
   --------------------------------------

   overriding function Create_Draw_G_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_G_Elements.ODF_Draw_G_Element_Access is
   begin
      return
        ODF.DOM.Draw_G_Elements.ODF_Draw_G_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.G_Element));
   end Create_Draw_G_Element;

   --------------------------------------
   -- Create_Draw_Glue_Point_Element --
   --------------------------------------

   overriding function Create_Draw_Glue_Point_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Glue_Point_Elements.ODF_Draw_Glue_Point_Element_Access is
   begin
      return
        ODF.DOM.Draw_Glue_Point_Elements.ODF_Draw_Glue_Point_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Glue_Point_Element));
   end Create_Draw_Glue_Point_Element;

   --------------------------------------
   -- Create_Draw_Gradient_Element --
   --------------------------------------

   overriding function Create_Draw_Gradient_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Gradient_Elements.ODF_Draw_Gradient_Element_Access is
   begin
      return
        ODF.DOM.Draw_Gradient_Elements.ODF_Draw_Gradient_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Gradient_Element));
   end Create_Draw_Gradient_Element;

   --------------------------------------
   -- Create_Style_Graphic_Properties_Element --
   --------------------------------------

   overriding function Create_Style_Graphic_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Graphic_Properties_Elements.ODF_Style_Graphic_Properties_Element_Access is
   begin
      return
        ODF.DOM.Style_Graphic_Properties_Elements.ODF_Style_Graphic_Properties_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Graphic_Properties_Element));
   end Create_Style_Graphic_Properties_Element;

   --------------------------------------
   -- Create_Form_Grid_Element --
   --------------------------------------

   overriding function Create_Form_Grid_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Grid_Elements.ODF_Form_Grid_Element_Access is
   begin
      return
        ODF.DOM.Form_Grid_Elements.ODF_Form_Grid_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Grid_Element));
   end Create_Form_Grid_Element;

   --------------------------------------
   -- Create_Draw_Handle_Element --
   --------------------------------------

   overriding function Create_Draw_Handle_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Handle_Elements.ODF_Draw_Handle_Element_Access is
   begin
      return
        ODF.DOM.Draw_Handle_Elements.ODF_Draw_Handle_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Handle_Element));
   end Create_Draw_Handle_Element;

   --------------------------------------
   -- Create_Draw_Hatch_Element --
   --------------------------------------

   overriding function Create_Draw_Hatch_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Hatch_Elements.ODF_Draw_Hatch_Element_Access is
   begin
      return
        ODF.DOM.Draw_Hatch_Elements.ODF_Draw_Hatch_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Hatch_Element));
   end Create_Draw_Hatch_Element;

   --------------------------------------
   -- Create_Form_Hidden_Element --
   --------------------------------------

   overriding function Create_Form_Hidden_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Hidden_Elements.ODF_Form_Hidden_Element_Access is
   begin
      return
        ODF.DOM.Form_Hidden_Elements.ODF_Form_Hidden_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Hidden_Element));
   end Create_Form_Hidden_Element;

   --------------------------------------
   -- Create_Number_Hours_Element --
   --------------------------------------

   overriding function Create_Number_Hours_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Hours_Elements.ODF_Number_Hours_Element_Access is
   begin
      return
        ODF.DOM.Number_Hours_Elements.ODF_Number_Hours_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Hours_Element));
   end Create_Number_Hours_Element;

   --------------------------------------
   -- Create_Form_Image_Element --
   --------------------------------------

   overriding function Create_Form_Image_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Image_Elements.ODF_Form_Image_Element_Access is
   begin
      return
        ODF.DOM.Form_Image_Elements.ODF_Form_Image_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Image_Element));
   end Create_Form_Image_Element;

   --------------------------------------
   -- Create_Form_Image_Frame_Element --
   --------------------------------------

   overriding function Create_Form_Image_Frame_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Image_Frame_Elements.ODF_Form_Image_Frame_Element_Access is
   begin
      return
        ODF.DOM.Form_Image_Frame_Elements.ODF_Form_Image_Frame_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Image_Frame_Element));
   end Create_Form_Image_Frame_Element;

   --------------------------------------
   -- Create_Presentation_Header_Element --
   --------------------------------------

   overriding function Create_Presentation_Header_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Header_Elements.ODF_Presentation_Header_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Header_Elements.ODF_Presentation_Header_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Header_Element));
   end Create_Presentation_Header_Element;

   --------------------------------------
   -- Create_Style_Header_Element --
   --------------------------------------

   overriding function Create_Style_Header_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Header_Elements.ODF_Style_Header_Element_Access is
   begin
      return
        ODF.DOM.Style_Header_Elements.ODF_Style_Header_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Header_Element));
   end Create_Style_Header_Element;

   --------------------------------------
   -- Create_Presentation_Header_Decl_Element --
   --------------------------------------

   overriding function Create_Presentation_Header_Decl_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Header_Decl_Elements.ODF_Presentation_Header_Decl_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Header_Decl_Elements.ODF_Presentation_Header_Decl_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Header_Decl_Element));
   end Create_Presentation_Header_Decl_Element;

   --------------------------------------
   -- Create_Style_Header_Footer_Properties_Element --
   --------------------------------------

   overriding function Create_Style_Header_Footer_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Header_Footer_Properties_Elements.ODF_Style_Header_Footer_Properties_Element_Access is
   begin
      return
        ODF.DOM.Style_Header_Footer_Properties_Elements.ODF_Style_Header_Footer_Properties_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Header_Footer_Properties_Element));
   end Create_Style_Header_Footer_Properties_Element;

   --------------------------------------
   -- Create_Style_Header_Left_Element --
   --------------------------------------

   overriding function Create_Style_Header_Left_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Header_Left_Elements.ODF_Style_Header_Left_Element_Access is
   begin
      return
        ODF.DOM.Style_Header_Left_Elements.ODF_Style_Header_Left_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Header_Left_Element));
   end Create_Style_Header_Left_Element;

   --------------------------------------
   -- Create_Style_Header_Style_Element --
   --------------------------------------

   overriding function Create_Style_Header_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Header_Style_Elements.ODF_Style_Header_Style_Element_Access is
   begin
      return
        ODF.DOM.Style_Header_Style_Elements.ODF_Style_Header_Style_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Header_Style_Element));
   end Create_Style_Header_Style_Element;

   --------------------------------------
   -- Create_Presentation_Hide_Shape_Element --
   --------------------------------------

   overriding function Create_Presentation_Hide_Shape_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Hide_Shape_Elements.ODF_Presentation_Hide_Shape_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Hide_Shape_Elements.ODF_Presentation_Hide_Shape_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Hide_Shape_Element));
   end Create_Presentation_Hide_Shape_Element;

   --------------------------------------
   -- Create_Presentation_Hide_Text_Element --
   --------------------------------------

   overriding function Create_Presentation_Hide_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Hide_Text_Elements.ODF_Presentation_Hide_Text_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Hide_Text_Elements.ODF_Presentation_Hide_Text_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Hide_Text_Element));
   end Create_Presentation_Hide_Text_Element;

   --------------------------------------
   -- Create_Draw_Image_Element --
   --------------------------------------

   overriding function Create_Draw_Image_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Image_Elements.ODF_Draw_Image_Element_Access is
   begin
      return
        ODF.DOM.Draw_Image_Elements.ODF_Draw_Image_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Image_Element));
   end Create_Draw_Image_Element;

   --------------------------------------
   -- Create_Draw_Image_Map_Element --
   --------------------------------------

   overriding function Create_Draw_Image_Map_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Image_Map_Elements.ODF_Draw_Image_Map_Element_Access is
   begin
      return
        ODF.DOM.Draw_Image_Map_Elements.ODF_Draw_Image_Map_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Image_Map_Element));
   end Create_Draw_Image_Map_Element;

   --------------------------------------
   -- Create_Form_Item_Element --
   --------------------------------------

   overriding function Create_Form_Item_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Item_Elements.ODF_Form_Item_Element_Access is
   begin
      return
        ODF.DOM.Form_Item_Elements.ODF_Form_Item_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Item_Element));
   end Create_Form_Item_Element;

   --------------------------------------
   -- Create_Draw_Layer_Element --
   --------------------------------------

   overriding function Create_Draw_Layer_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Layer_Elements.ODF_Draw_Layer_Element_Access is
   begin
      return
        ODF.DOM.Draw_Layer_Elements.ODF_Draw_Layer_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Layer_Element));
   end Create_Draw_Layer_Element;

   --------------------------------------
   -- Create_Draw_Layer_Set_Element --
   --------------------------------------

   overriding function Create_Draw_Layer_Set_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Layer_Set_Elements.ODF_Draw_Layer_Set_Element_Access is
   begin
      return
        ODF.DOM.Draw_Layer_Set_Elements.ODF_Draw_Layer_Set_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Layer_Set_Element));
   end Create_Draw_Layer_Set_Element;

   --------------------------------------
   -- Create_Draw_Line_Element --
   --------------------------------------

   overriding function Create_Draw_Line_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Line_Elements.ODF_Draw_Line_Element_Access is
   begin
      return
        ODF.DOM.Draw_Line_Elements.ODF_Draw_Line_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Line_Element));
   end Create_Draw_Line_Element;

   --------------------------------------
   -- Create_Style_List_Level_Label_Alignment_Element --
   --------------------------------------

   overriding function Create_Style_List_Level_Label_Alignment_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_List_Level_Label_Alignment_Elements.ODF_Style_List_Level_Label_Alignment_Element_Access is
   begin
      return
        ODF.DOM.Style_List_Level_Label_Alignment_Elements.ODF_Style_List_Level_Label_Alignment_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.List_Level_Label_Alignment_Element));
   end Create_Style_List_Level_Label_Alignment_Element;

   --------------------------------------
   -- Create_Style_List_Level_Properties_Element --
   --------------------------------------

   overriding function Create_Style_List_Level_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_List_Level_Properties_Elements.ODF_Style_List_Level_Properties_Element_Access is
   begin
      return
        ODF.DOM.Style_List_Level_Properties_Elements.ODF_Style_List_Level_Properties_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.List_Level_Properties_Element));
   end Create_Style_List_Level_Properties_Element;

   --------------------------------------
   -- Create_Draw_Marker_Element --
   --------------------------------------

   overriding function Create_Draw_Marker_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Marker_Elements.ODF_Draw_Marker_Element_Access is
   begin
      return
        ODF.DOM.Draw_Marker_Elements.ODF_Draw_Marker_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Marker_Element));
   end Create_Draw_Marker_Element;

   --------------------------------------
   -- Create_Svg_LinearGradient_Element --
   --------------------------------------

   overriding function Create_Svg_LinearGradient_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_LinearGradient_Elements.ODF_Svg_LinearGradient_Element_Access is
   begin
      return
        ODF.DOM.Svg_LinearGradient_Elements.ODF_Svg_LinearGradient_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Svg_URI,
            Matreshka.ODF_String_Constants.Svg_Prefix,
            Matreshka.ODF_String_Constants.LinearGradient_Element));
   end Create_Svg_LinearGradient_Element;

   --------------------------------------
   -- Create_Form_List_Property_Element --
   --------------------------------------

   overriding function Create_Form_List_Property_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_List_Property_Elements.ODF_Form_List_Property_Element_Access is
   begin
      return
        ODF.DOM.Form_List_Property_Elements.ODF_Form_List_Property_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.List_Property_Element));
   end Create_Form_List_Property_Element;

   --------------------------------------
   -- Create_Form_List_Value_Element --
   --------------------------------------

   overriding function Create_Form_List_Value_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_List_Value_Elements.ODF_Form_List_Value_Element_Access is
   begin
      return
        ODF.DOM.Form_List_Value_Elements.ODF_Form_List_Value_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.List_Value_Element));
   end Create_Form_List_Value_Element;

   --------------------------------------
   -- Create_Form_Listbox_Element --
   --------------------------------------

   overriding function Create_Form_Listbox_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Listbox_Elements.ODF_Form_Listbox_Element_Access is
   begin
      return
        ODF.DOM.Form_Listbox_Elements.ODF_Form_Listbox_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Listbox_Element));
   end Create_Form_Listbox_Element;

   --------------------------------------
   -- Create_Style_Map_Element --
   --------------------------------------

   overriding function Create_Style_Map_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Map_Elements.ODF_Style_Map_Element_Access is
   begin
      return
        ODF.DOM.Style_Map_Elements.ODF_Style_Map_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Map_Element));
   end Create_Style_Map_Element;

   --------------------------------------
   -- Create_Style_Master_Page_Element --
   --------------------------------------

   overriding function Create_Style_Master_Page_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Master_Page_Elements.ODF_Style_Master_Page_Element_Access is
   begin
      return
        ODF.DOM.Style_Master_Page_Elements.ODF_Style_Master_Page_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Master_Page_Element));
   end Create_Style_Master_Page_Element;

   --------------------------------------
   -- Create_Math_Math_Element --
   --------------------------------------

   overriding function Create_Math_Math_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Math_Math_Elements.ODF_Math_Math_Element_Access is
   begin
      return
        ODF.DOM.Math_Math_Elements.ODF_Math_Math_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Math_URI,
            Matreshka.ODF_String_Constants.Math_Prefix,
            Matreshka.ODF_String_Constants.Math_Element));
   end Create_Math_Math_Element;

   --------------------------------------
   -- Create_Draw_Measure_Element --
   --------------------------------------

   overriding function Create_Draw_Measure_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Measure_Elements.ODF_Draw_Measure_Element_Access is
   begin
      return
        ODF.DOM.Draw_Measure_Elements.ODF_Draw_Measure_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Measure_Element));
   end Create_Draw_Measure_Element;

   --------------------------------------
   -- Create_Number_Minutes_Element --
   --------------------------------------

   overriding function Create_Number_Minutes_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Minutes_Elements.ODF_Number_Minutes_Element_Access is
   begin
      return
        ODF.DOM.Number_Minutes_Elements.ODF_Number_Minutes_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Minutes_Element));
   end Create_Number_Minutes_Element;

   --------------------------------------
   -- Create_Number_Month_Element --
   --------------------------------------

   overriding function Create_Number_Month_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Month_Elements.ODF_Number_Month_Element_Access is
   begin
      return
        ODF.DOM.Number_Month_Elements.ODF_Number_Month_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Month_Element));
   end Create_Number_Month_Element;

   --------------------------------------
   -- Create_Presentation_Notes_Element --
   --------------------------------------

   overriding function Create_Presentation_Notes_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Notes_Elements.ODF_Presentation_Notes_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Notes_Elements.ODF_Presentation_Notes_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Notes_Element));
   end Create_Presentation_Notes_Element;

   --------------------------------------
   -- Create_Form_Number_Element --
   --------------------------------------

   overriding function Create_Form_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Number_Elements.ODF_Form_Number_Element_Access is
   begin
      return
        ODF.DOM.Form_Number_Elements.ODF_Form_Number_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Number_Element));
   end Create_Form_Number_Element;

   --------------------------------------
   -- Create_Number_Number_Element --
   --------------------------------------

   overriding function Create_Number_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Number_Elements.ODF_Number_Number_Element_Access is
   begin
      return
        ODF.DOM.Number_Number_Elements.ODF_Number_Number_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Number_Element));
   end Create_Number_Number_Element;

   --------------------------------------
   -- Create_Number_Number_Style_Element --
   --------------------------------------

   overriding function Create_Number_Number_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Number_Style_Elements.ODF_Number_Number_Style_Element_Access is
   begin
      return
        ODF.DOM.Number_Number_Style_Elements.ODF_Number_Number_Style_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Number_Style_Element));
   end Create_Number_Number_Style_Element;

   --------------------------------------
   -- Create_Draw_Object_Element --
   --------------------------------------

   overriding function Create_Draw_Object_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Object_Elements.ODF_Draw_Object_Element_Access is
   begin
      return
        ODF.DOM.Draw_Object_Elements.ODF_Draw_Object_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Object_Element));
   end Create_Draw_Object_Element;

   --------------------------------------
   -- Create_Draw_Object_Ole_Element --
   --------------------------------------

   overriding function Create_Draw_Object_Ole_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Object_Ole_Elements.ODF_Draw_Object_Ole_Element_Access is
   begin
      return
        ODF.DOM.Draw_Object_Ole_Elements.ODF_Draw_Object_Ole_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Object_Ole_Element));
   end Create_Draw_Object_Ole_Element;

   --------------------------------------
   -- Create_Draw_Opacity_Element --
   --------------------------------------

   overriding function Create_Draw_Opacity_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Opacity_Elements.ODF_Draw_Opacity_Element_Access is
   begin
      return
        ODF.DOM.Draw_Opacity_Elements.ODF_Draw_Opacity_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Opacity_Element));
   end Create_Draw_Opacity_Element;

   --------------------------------------
   -- Create_Form_Option_Element --
   --------------------------------------

   overriding function Create_Form_Option_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Option_Elements.ODF_Form_Option_Element_Access is
   begin
      return
        ODF.DOM.Form_Option_Elements.ODF_Form_Option_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Option_Element));
   end Create_Form_Option_Element;

   --------------------------------------
   -- Create_Draw_Page_Element --
   --------------------------------------

   overriding function Create_Draw_Page_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Page_Elements.ODF_Draw_Page_Element_Access is
   begin
      return
        ODF.DOM.Draw_Page_Elements.ODF_Draw_Page_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Page_Element));
   end Create_Draw_Page_Element;

   --------------------------------------
   -- Create_Style_Page_Layout_Element --
   --------------------------------------

   overriding function Create_Style_Page_Layout_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Page_Layout_Elements.ODF_Style_Page_Layout_Element_Access is
   begin
      return
        ODF.DOM.Style_Page_Layout_Elements.ODF_Style_Page_Layout_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Page_Layout_Element));
   end Create_Style_Page_Layout_Element;

   --------------------------------------
   -- Create_Style_Page_Layout_Properties_Element --
   --------------------------------------

   overriding function Create_Style_Page_Layout_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Page_Layout_Properties_Elements.ODF_Style_Page_Layout_Properties_Element_Access is
   begin
      return
        ODF.DOM.Style_Page_Layout_Properties_Elements.ODF_Style_Page_Layout_Properties_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Page_Layout_Properties_Element));
   end Create_Style_Page_Layout_Properties_Element;

   --------------------------------------
   -- Create_Draw_Page_Thumbnail_Element --
   --------------------------------------

   overriding function Create_Draw_Page_Thumbnail_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Page_Thumbnail_Elements.ODF_Draw_Page_Thumbnail_Element_Access is
   begin
      return
        ODF.DOM.Draw_Page_Thumbnail_Elements.ODF_Draw_Page_Thumbnail_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Page_Thumbnail_Element));
   end Create_Draw_Page_Thumbnail_Element;

   --------------------------------------
   -- Create_Style_Paragraph_Properties_Element --
   --------------------------------------

   overriding function Create_Style_Paragraph_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Paragraph_Properties_Elements.ODF_Style_Paragraph_Properties_Element_Access is
   begin
      return
        ODF.DOM.Style_Paragraph_Properties_Elements.ODF_Style_Paragraph_Properties_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Paragraph_Properties_Element));
   end Create_Style_Paragraph_Properties_Element;

   --------------------------------------
   -- Create_Draw_Param_Element --
   --------------------------------------

   overriding function Create_Draw_Param_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Param_Elements.ODF_Draw_Param_Element_Access is
   begin
      return
        ODF.DOM.Draw_Param_Elements.ODF_Draw_Param_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Param_Element));
   end Create_Draw_Param_Element;

   --------------------------------------
   -- Create_Form_Password_Element --
   --------------------------------------

   overriding function Create_Form_Password_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Password_Elements.ODF_Form_Password_Element_Access is
   begin
      return
        ODF.DOM.Form_Password_Elements.ODF_Form_Password_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Password_Element));
   end Create_Form_Password_Element;

   --------------------------------------
   -- Create_Draw_Path_Element --
   --------------------------------------

   overriding function Create_Draw_Path_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Path_Elements.ODF_Draw_Path_Element_Access is
   begin
      return
        ODF.DOM.Draw_Path_Elements.ODF_Draw_Path_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Path_Element));
   end Create_Draw_Path_Element;

   --------------------------------------
   -- Create_Number_Percentage_Style_Element --
   --------------------------------------

   overriding function Create_Number_Percentage_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Percentage_Style_Elements.ODF_Number_Percentage_Style_Element_Access is
   begin
      return
        ODF.DOM.Number_Percentage_Style_Elements.ODF_Number_Percentage_Style_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Percentage_Style_Element));
   end Create_Number_Percentage_Style_Element;

   --------------------------------------
   -- Create_Presentation_Placeholder_Element --
   --------------------------------------

   overriding function Create_Presentation_Placeholder_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Placeholder_Elements.ODF_Presentation_Placeholder_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Placeholder_Elements.ODF_Presentation_Placeholder_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Placeholder_Element));
   end Create_Presentation_Placeholder_Element;

   --------------------------------------
   -- Create_Draw_Plugin_Element --
   --------------------------------------

   overriding function Create_Draw_Plugin_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Plugin_Elements.ODF_Draw_Plugin_Element_Access is
   begin
      return
        ODF.DOM.Draw_Plugin_Elements.ODF_Draw_Plugin_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Plugin_Element));
   end Create_Draw_Plugin_Element;

   --------------------------------------
   -- Create_Draw_Polygon_Element --
   --------------------------------------

   overriding function Create_Draw_Polygon_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Polygon_Elements.ODF_Draw_Polygon_Element_Access is
   begin
      return
        ODF.DOM.Draw_Polygon_Elements.ODF_Draw_Polygon_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Polygon_Element));
   end Create_Draw_Polygon_Element;

   --------------------------------------
   -- Create_Draw_Polyline_Element --
   --------------------------------------

   overriding function Create_Draw_Polyline_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Polyline_Elements.ODF_Draw_Polyline_Element_Access is
   begin
      return
        ODF.DOM.Draw_Polyline_Elements.ODF_Draw_Polyline_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Polyline_Element));
   end Create_Draw_Polyline_Element;

   --------------------------------------
   -- Create_Style_Presentation_Page_Layout_Element --
   --------------------------------------

   overriding function Create_Style_Presentation_Page_Layout_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Presentation_Page_Layout_Elements.ODF_Style_Presentation_Page_Layout_Element_Access is
   begin
      return
        ODF.DOM.Style_Presentation_Page_Layout_Elements.ODF_Style_Presentation_Page_Layout_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Presentation_Page_Layout_Element));
   end Create_Style_Presentation_Page_Layout_Element;

   --------------------------------------
   -- Create_Form_Properties_Element --
   --------------------------------------

   overriding function Create_Form_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Properties_Elements.ODF_Form_Properties_Element_Access is
   begin
      return
        ODF.DOM.Form_Properties_Elements.ODF_Form_Properties_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Properties_Element));
   end Create_Form_Properties_Element;

   --------------------------------------
   -- Create_Form_Property_Element --
   --------------------------------------

   overriding function Create_Form_Property_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Property_Elements.ODF_Form_Property_Element_Access is
   begin
      return
        ODF.DOM.Form_Property_Elements.ODF_Form_Property_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Property_Element));
   end Create_Form_Property_Element;

   --------------------------------------
   -- Create_Number_Quarter_Element --
   --------------------------------------

   overriding function Create_Number_Quarter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Quarter_Elements.ODF_Number_Quarter_Element_Access is
   begin
      return
        ODF.DOM.Number_Quarter_Elements.ODF_Number_Quarter_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Quarter_Element));
   end Create_Number_Quarter_Element;

   --------------------------------------
   -- Create_Svg_RadialGradient_Element --
   --------------------------------------

   overriding function Create_Svg_RadialGradient_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_RadialGradient_Elements.ODF_Svg_RadialGradient_Element_Access is
   begin
      return
        ODF.DOM.Svg_RadialGradient_Elements.ODF_Svg_RadialGradient_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Svg_URI,
            Matreshka.ODF_String_Constants.Svg_Prefix,
            Matreshka.ODF_String_Constants.RadialGradient_Element));
   end Create_Svg_RadialGradient_Element;

   --------------------------------------
   -- Create_Form_Radio_Element --
   --------------------------------------

   overriding function Create_Form_Radio_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Radio_Elements.ODF_Form_Radio_Element_Access is
   begin
      return
        ODF.DOM.Form_Radio_Elements.ODF_Form_Radio_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Radio_Element));
   end Create_Form_Radio_Element;

   --------------------------------------
   -- Create_Draw_Rect_Element --
   --------------------------------------

   overriding function Create_Draw_Rect_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Rect_Elements.ODF_Draw_Rect_Element_Access is
   begin
      return
        ODF.DOM.Draw_Rect_Elements.ODF_Draw_Rect_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Rect_Element));
   end Create_Draw_Rect_Element;

   --------------------------------------
   -- Create_Style_Region_Center_Element --
   --------------------------------------

   overriding function Create_Style_Region_Center_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Region_Center_Elements.ODF_Style_Region_Center_Element_Access is
   begin
      return
        ODF.DOM.Style_Region_Center_Elements.ODF_Style_Region_Center_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Region_Center_Element));
   end Create_Style_Region_Center_Element;

   --------------------------------------
   -- Create_Style_Region_Left_Element --
   --------------------------------------

   overriding function Create_Style_Region_Left_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Region_Left_Elements.ODF_Style_Region_Left_Element_Access is
   begin
      return
        ODF.DOM.Style_Region_Left_Elements.ODF_Style_Region_Left_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Region_Left_Element));
   end Create_Style_Region_Left_Element;

   --------------------------------------
   -- Create_Style_Region_Right_Element --
   --------------------------------------

   overriding function Create_Style_Region_Right_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Region_Right_Elements.ODF_Style_Region_Right_Element_Access is
   begin
      return
        ODF.DOM.Style_Region_Right_Elements.ODF_Style_Region_Right_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Region_Right_Element));
   end Create_Style_Region_Right_Element;

   --------------------------------------
   -- Create_Draw_Regular_Polygon_Element --
   --------------------------------------

   overriding function Create_Draw_Regular_Polygon_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Regular_Polygon_Elements.ODF_Draw_Regular_Polygon_Element_Access is
   begin
      return
        ODF.DOM.Draw_Regular_Polygon_Elements.ODF_Draw_Regular_Polygon_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Regular_Polygon_Element));
   end Create_Draw_Regular_Polygon_Element;

   --------------------------------------
   -- Create_Style_Ruby_Properties_Element --
   --------------------------------------

   overriding function Create_Style_Ruby_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Ruby_Properties_Elements.ODF_Style_Ruby_Properties_Element_Access is
   begin
      return
        ODF.DOM.Style_Ruby_Properties_Elements.ODF_Style_Ruby_Properties_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Ruby_Properties_Element));
   end Create_Style_Ruby_Properties_Element;

   --------------------------------------
   -- Create_Draw_Stroke_Dash_Element --
   --------------------------------------

   overriding function Create_Draw_Stroke_Dash_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Stroke_Dash_Elements.ODF_Draw_Stroke_Dash_Element_Access is
   begin
      return
        ODF.DOM.Draw_Stroke_Dash_Elements.ODF_Draw_Stroke_Dash_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Stroke_Dash_Element));
   end Create_Draw_Stroke_Dash_Element;

   --------------------------------------
   -- Create_Number_Scientific_Number_Element --
   --------------------------------------

   overriding function Create_Number_Scientific_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Scientific_Number_Elements.ODF_Number_Scientific_Number_Element_Access is
   begin
      return
        ODF.DOM.Number_Scientific_Number_Elements.ODF_Number_Scientific_Number_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Scientific_Number_Element));
   end Create_Number_Scientific_Number_Element;

   --------------------------------------
   -- Create_Number_Seconds_Element --
   --------------------------------------

   overriding function Create_Number_Seconds_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Seconds_Elements.ODF_Number_Seconds_Element_Access is
   begin
      return
        ODF.DOM.Number_Seconds_Elements.ODF_Number_Seconds_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Seconds_Element));
   end Create_Number_Seconds_Element;

   --------------------------------------
   -- Create_Style_Section_Properties_Element --
   --------------------------------------

   overriding function Create_Style_Section_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Section_Properties_Elements.ODF_Style_Section_Properties_Element_Access is
   begin
      return
        ODF.DOM.Style_Section_Properties_Elements.ODF_Style_Section_Properties_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Section_Properties_Element));
   end Create_Style_Section_Properties_Element;

   --------------------------------------
   -- Create_Svg_Stop_Element --
   --------------------------------------

   overriding function Create_Svg_Stop_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Stop_Elements.ODF_Svg_Stop_Element_Access is
   begin
      return
        ODF.DOM.Svg_Stop_Elements.ODF_Svg_Stop_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Svg_URI,
            Matreshka.ODF_String_Constants.Svg_Prefix,
            Matreshka.ODF_String_Constants.Stop_Element));
   end Create_Svg_Stop_Element;

   --------------------------------------
   -- Create_Number_Text_Element --
   --------------------------------------

   overriding function Create_Number_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Text_Elements.ODF_Number_Text_Element_Access is
   begin
      return
        ODF.DOM.Number_Text_Elements.ODF_Number_Text_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Text_Element));
   end Create_Number_Text_Element;

   --------------------------------------
   -- Create_Style_Style_Element --
   --------------------------------------

   overriding function Create_Style_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Style_Elements.ODF_Style_Style_Element_Access is
   begin
      return
        ODF.DOM.Style_Style_Elements.ODF_Style_Style_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Style_Element));
   end Create_Style_Style_Element;

   --------------------------------------
   -- Create_Style_Tab_Stop_Element --
   --------------------------------------

   overriding function Create_Style_Tab_Stop_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Tab_Stop_Elements.ODF_Style_Tab_Stop_Element_Access is
   begin
      return
        ODF.DOM.Style_Tab_Stop_Elements.ODF_Style_Tab_Stop_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Tab_Stop_Element));
   end Create_Style_Tab_Stop_Element;

   --------------------------------------
   -- Create_Style_Tab_Stops_Element --
   --------------------------------------

   overriding function Create_Style_Tab_Stops_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Tab_Stops_Elements.ODF_Style_Tab_Stops_Element_Access is
   begin
      return
        ODF.DOM.Style_Tab_Stops_Elements.ODF_Style_Tab_Stops_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Tab_Stops_Element));
   end Create_Style_Tab_Stops_Element;

   --------------------------------------
   -- Create_Style_Table_Cell_Properties_Element --
   --------------------------------------

   overriding function Create_Style_Table_Cell_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Table_Cell_Properties_Elements.ODF_Style_Table_Cell_Properties_Element_Access is
   begin
      return
        ODF.DOM.Style_Table_Cell_Properties_Elements.ODF_Style_Table_Cell_Properties_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Table_Cell_Properties_Element));
   end Create_Style_Table_Cell_Properties_Element;

   --------------------------------------
   -- Create_Style_Table_Column_Properties_Element --
   --------------------------------------

   overriding function Create_Style_Table_Column_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Table_Column_Properties_Elements.ODF_Style_Table_Column_Properties_Element_Access is
   begin
      return
        ODF.DOM.Style_Table_Column_Properties_Elements.ODF_Style_Table_Column_Properties_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Table_Column_Properties_Element));
   end Create_Style_Table_Column_Properties_Element;

   --------------------------------------
   -- Create_Style_Table_Properties_Element --
   --------------------------------------

   overriding function Create_Style_Table_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Table_Properties_Elements.ODF_Style_Table_Properties_Element_Access is
   begin
      return
        ODF.DOM.Style_Table_Properties_Elements.ODF_Style_Table_Properties_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Table_Properties_Element));
   end Create_Style_Table_Properties_Element;

   --------------------------------------
   -- Create_Style_Table_Row_Properties_Element --
   --------------------------------------

   overriding function Create_Style_Table_Row_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Table_Row_Properties_Elements.ODF_Style_Table_Row_Properties_Element_Access is
   begin
      return
        ODF.DOM.Style_Table_Row_Properties_Elements.ODF_Style_Table_Row_Properties_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Table_Row_Properties_Element));
   end Create_Style_Table_Row_Properties_Element;

   --------------------------------------
   -- Create_Form_Text_Element --
   --------------------------------------

   overriding function Create_Form_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Text_Elements.ODF_Form_Text_Element_Access is
   begin
      return
        ODF.DOM.Form_Text_Elements.ODF_Form_Text_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Text_Element));
   end Create_Form_Text_Element;

   --------------------------------------
   -- Create_Draw_Text_Box_Element --
   --------------------------------------

   overriding function Create_Draw_Text_Box_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Draw_Text_Box_Elements.ODF_Draw_Text_Box_Element_Access is
   begin
      return
        ODF.DOM.Draw_Text_Box_Elements.ODF_Draw_Text_Box_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Draw_URI,
            Matreshka.ODF_String_Constants.Draw_Prefix,
            Matreshka.ODF_String_Constants.Text_Box_Element));
   end Create_Draw_Text_Box_Element;

   --------------------------------------
   -- Create_Number_Text_Content_Element --
   --------------------------------------

   overriding function Create_Number_Text_Content_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Text_Content_Elements.ODF_Number_Text_Content_Element_Access is
   begin
      return
        ODF.DOM.Number_Text_Content_Elements.ODF_Number_Text_Content_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Text_Content_Element));
   end Create_Number_Text_Content_Element;

   --------------------------------------
   -- Create_Style_Text_Properties_Element --
   --------------------------------------

   overriding function Create_Style_Text_Properties_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Text_Properties_Elements.ODF_Style_Text_Properties_Element_Access is
   begin
      return
        ODF.DOM.Style_Text_Properties_Elements.ODF_Style_Text_Properties_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Text_Properties_Element));
   end Create_Style_Text_Properties_Element;

   --------------------------------------
   -- Create_Number_Text_Style_Element --
   --------------------------------------

   overriding function Create_Number_Text_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Text_Style_Elements.ODF_Number_Text_Style_Element_Access is
   begin
      return
        ODF.DOM.Number_Text_Style_Elements.ODF_Number_Text_Style_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Text_Style_Element));
   end Create_Number_Text_Style_Element;

   --------------------------------------
   -- Create_Form_Textarea_Element --
   --------------------------------------

   overriding function Create_Form_Textarea_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Textarea_Elements.ODF_Form_Textarea_Element_Access is
   begin
      return
        ODF.DOM.Form_Textarea_Elements.ODF_Form_Textarea_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Textarea_Element));
   end Create_Form_Textarea_Element;

   --------------------------------------
   -- Create_Form_Time_Element --
   --------------------------------------

   overriding function Create_Form_Time_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Time_Elements.ODF_Form_Time_Element_Access is
   begin
      return
        ODF.DOM.Form_Time_Elements.ODF_Form_Time_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Time_Element));
   end Create_Form_Time_Element;

   --------------------------------------
   -- Create_Number_Time_Style_Element --
   --------------------------------------

   overriding function Create_Number_Time_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Time_Style_Elements.ODF_Number_Time_Style_Element_Access is
   begin
      return
        ODF.DOM.Number_Time_Style_Elements.ODF_Number_Time_Style_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Time_Style_Element));
   end Create_Number_Time_Style_Element;

   --------------------------------------
   -- Create_Form_Value_Range_Element --
   --------------------------------------

   overriding function Create_Form_Value_Range_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Form_Value_Range_Elements.ODF_Form_Value_Range_Element_Access is
   begin
      return
        ODF.DOM.Form_Value_Range_Elements.ODF_Form_Value_Range_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Form_URI,
            Matreshka.ODF_String_Constants.Form_Prefix,
            Matreshka.ODF_String_Constants.Value_Range_Element));
   end Create_Form_Value_Range_Element;

   --------------------------------------
   -- Create_Number_Week_Of_Year_Element --
   --------------------------------------

   overriding function Create_Number_Week_Of_Year_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Week_Of_Year_Elements.ODF_Number_Week_Of_Year_Element_Access is
   begin
      return
        ODF.DOM.Number_Week_Of_Year_Elements.ODF_Number_Week_Of_Year_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Week_Of_Year_Element));
   end Create_Number_Week_Of_Year_Element;

   --------------------------------------
   -- Create_Number_Year_Element --
   --------------------------------------

   overriding function Create_Number_Year_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Number_Year_Elements.ODF_Number_Year_Element_Access is
   begin
      return
        ODF.DOM.Number_Year_Elements.ODF_Number_Year_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Number_URI,
            Matreshka.ODF_String_Constants.Number_Prefix,
            Matreshka.ODF_String_Constants.Year_Element));
   end Create_Number_Year_Element;

   --------------------------------------
   -- Create_Table_Cut_Offs_Element --
   --------------------------------------

   overriding function Create_Table_Cut_Offs_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Cut_Offs_Elements.ODF_Table_Cut_Offs_Element_Access is
   begin
      return
        ODF.DOM.Table_Cut_Offs_Elements.ODF_Table_Cut_Offs_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Cut_Offs_Element));
   end Create_Table_Cut_Offs_Element;

   --------------------------------------
   -- Create_Table_Data_Pilot_Display_Info_Element --
   --------------------------------------

   overriding function Create_Table_Data_Pilot_Display_Info_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Display_Info_Elements.ODF_Table_Data_Pilot_Display_Info_Element_Access is
   begin
      return
        ODF.DOM.Table_Data_Pilot_Display_Info_Elements.ODF_Table_Data_Pilot_Display_Info_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Data_Pilot_Display_Info_Element));
   end Create_Table_Data_Pilot_Display_Info_Element;

   --------------------------------------
   -- Create_Table_Data_Pilot_Field_Element --
   --------------------------------------

   overriding function Create_Table_Data_Pilot_Field_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Field_Elements.ODF_Table_Data_Pilot_Field_Element_Access is
   begin
      return
        ODF.DOM.Table_Data_Pilot_Field_Elements.ODF_Table_Data_Pilot_Field_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Data_Pilot_Field_Element));
   end Create_Table_Data_Pilot_Field_Element;

   --------------------------------------
   -- Create_Table_Data_Pilot_Field_Reference_Element --
   --------------------------------------

   overriding function Create_Table_Data_Pilot_Field_Reference_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Field_Reference_Elements.ODF_Table_Data_Pilot_Field_Reference_Element_Access is
   begin
      return
        ODF.DOM.Table_Data_Pilot_Field_Reference_Elements.ODF_Table_Data_Pilot_Field_Reference_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Data_Pilot_Field_Reference_Element));
   end Create_Table_Data_Pilot_Field_Reference_Element;

   --------------------------------------
   -- Create_Table_Data_Pilot_Group_Element --
   --------------------------------------

   overriding function Create_Table_Data_Pilot_Group_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Group_Elements.ODF_Table_Data_Pilot_Group_Element_Access is
   begin
      return
        ODF.DOM.Table_Data_Pilot_Group_Elements.ODF_Table_Data_Pilot_Group_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Data_Pilot_Group_Element));
   end Create_Table_Data_Pilot_Group_Element;

   --------------------------------------
   -- Create_Table_Data_Pilot_Group_Member_Element --
   --------------------------------------

   overriding function Create_Table_Data_Pilot_Group_Member_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Group_Member_Elements.ODF_Table_Data_Pilot_Group_Member_Element_Access is
   begin
      return
        ODF.DOM.Table_Data_Pilot_Group_Member_Elements.ODF_Table_Data_Pilot_Group_Member_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Data_Pilot_Group_Member_Element));
   end Create_Table_Data_Pilot_Group_Member_Element;

   --------------------------------------
   -- Create_Table_Data_Pilot_Groups_Element --
   --------------------------------------

   overriding function Create_Table_Data_Pilot_Groups_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Groups_Elements.ODF_Table_Data_Pilot_Groups_Element_Access is
   begin
      return
        ODF.DOM.Table_Data_Pilot_Groups_Elements.ODF_Table_Data_Pilot_Groups_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Data_Pilot_Groups_Element));
   end Create_Table_Data_Pilot_Groups_Element;

   --------------------------------------
   -- Create_Table_Data_Pilot_Layout_Info_Element --
   --------------------------------------

   overriding function Create_Table_Data_Pilot_Layout_Info_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Layout_Info_Elements.ODF_Table_Data_Pilot_Layout_Info_Element_Access is
   begin
      return
        ODF.DOM.Table_Data_Pilot_Layout_Info_Elements.ODF_Table_Data_Pilot_Layout_Info_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Data_Pilot_Layout_Info_Element));
   end Create_Table_Data_Pilot_Layout_Info_Element;

   --------------------------------------
   -- Create_Table_Data_Pilot_Level_Element --
   --------------------------------------

   overriding function Create_Table_Data_Pilot_Level_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Level_Elements.ODF_Table_Data_Pilot_Level_Element_Access is
   begin
      return
        ODF.DOM.Table_Data_Pilot_Level_Elements.ODF_Table_Data_Pilot_Level_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Data_Pilot_Level_Element));
   end Create_Table_Data_Pilot_Level_Element;

   --------------------------------------
   -- Create_Table_Data_Pilot_Member_Element --
   --------------------------------------

   overriding function Create_Table_Data_Pilot_Member_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Member_Elements.ODF_Table_Data_Pilot_Member_Element_Access is
   begin
      return
        ODF.DOM.Table_Data_Pilot_Member_Elements.ODF_Table_Data_Pilot_Member_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Data_Pilot_Member_Element));
   end Create_Table_Data_Pilot_Member_Element;

   --------------------------------------
   -- Create_Table_Data_Pilot_Members_Element --
   --------------------------------------

   overriding function Create_Table_Data_Pilot_Members_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Members_Elements.ODF_Table_Data_Pilot_Members_Element_Access is
   begin
      return
        ODF.DOM.Table_Data_Pilot_Members_Elements.ODF_Table_Data_Pilot_Members_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Data_Pilot_Members_Element));
   end Create_Table_Data_Pilot_Members_Element;

   --------------------------------------
   -- Create_Table_Data_Pilot_Sort_Info_Element --
   --------------------------------------

   overriding function Create_Table_Data_Pilot_Sort_Info_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Sort_Info_Elements.ODF_Table_Data_Pilot_Sort_Info_Element_Access is
   begin
      return
        ODF.DOM.Table_Data_Pilot_Sort_Info_Elements.ODF_Table_Data_Pilot_Sort_Info_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Data_Pilot_Sort_Info_Element));
   end Create_Table_Data_Pilot_Sort_Info_Element;

   --------------------------------------
   -- Create_Table_Data_Pilot_Subtotal_Element --
   --------------------------------------

   overriding function Create_Table_Data_Pilot_Subtotal_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Subtotal_Elements.ODF_Table_Data_Pilot_Subtotal_Element_Access is
   begin
      return
        ODF.DOM.Table_Data_Pilot_Subtotal_Elements.ODF_Table_Data_Pilot_Subtotal_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Data_Pilot_Subtotal_Element));
   end Create_Table_Data_Pilot_Subtotal_Element;

   --------------------------------------
   -- Create_Table_Data_Pilot_Subtotals_Element --
   --------------------------------------

   overriding function Create_Table_Data_Pilot_Subtotals_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Subtotals_Elements.ODF_Table_Data_Pilot_Subtotals_Element_Access is
   begin
      return
        ODF.DOM.Table_Data_Pilot_Subtotals_Elements.ODF_Table_Data_Pilot_Subtotals_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Data_Pilot_Subtotals_Element));
   end Create_Table_Data_Pilot_Subtotals_Element;

   --------------------------------------
   -- Create_Table_Data_Pilot_Table_Element --
   --------------------------------------

   overriding function Create_Table_Data_Pilot_Table_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Table_Elements.ODF_Table_Data_Pilot_Table_Element_Access is
   begin
      return
        ODF.DOM.Table_Data_Pilot_Table_Elements.ODF_Table_Data_Pilot_Table_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Data_Pilot_Table_Element));
   end Create_Table_Data_Pilot_Table_Element;

   --------------------------------------
   -- Create_Table_Data_Pilot_Tables_Element --
   --------------------------------------

   overriding function Create_Table_Data_Pilot_Tables_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Data_Pilot_Tables_Elements.ODF_Table_Data_Pilot_Tables_Element_Access is
   begin
      return
        ODF.DOM.Table_Data_Pilot_Tables_Elements.ODF_Table_Data_Pilot_Tables_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Data_Pilot_Tables_Element));
   end Create_Table_Data_Pilot_Tables_Element;

   --------------------------------------
   -- Create_Table_Database_Range_Element --
   --------------------------------------

   overriding function Create_Table_Database_Range_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Database_Range_Elements.ODF_Table_Database_Range_Element_Access is
   begin
      return
        ODF.DOM.Table_Database_Range_Elements.ODF_Table_Database_Range_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Database_Range_Element));
   end Create_Table_Database_Range_Element;

   --------------------------------------
   -- Create_Table_Database_Ranges_Element --
   --------------------------------------

   overriding function Create_Table_Database_Ranges_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Database_Ranges_Elements.ODF_Table_Database_Ranges_Element_Access is
   begin
      return
        ODF.DOM.Table_Database_Ranges_Elements.ODF_Table_Database_Ranges_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Database_Ranges_Element));
   end Create_Table_Database_Ranges_Element;

   --------------------------------------
   -- Create_Table_Database_Source_Query_Element --
   --------------------------------------

   overriding function Create_Table_Database_Source_Query_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Database_Source_Query_Elements.ODF_Table_Database_Source_Query_Element_Access is
   begin
      return
        ODF.DOM.Table_Database_Source_Query_Elements.ODF_Table_Database_Source_Query_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Database_Source_Query_Element));
   end Create_Table_Database_Source_Query_Element;

   --------------------------------------
   -- Create_Table_Database_Source_Sql_Element --
   --------------------------------------

   overriding function Create_Table_Database_Source_Sql_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Database_Source_Sql_Elements.ODF_Table_Database_Source_Sql_Element_Access is
   begin
      return
        ODF.DOM.Table_Database_Source_Sql_Elements.ODF_Table_Database_Source_Sql_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Database_Source_Sql_Element));
   end Create_Table_Database_Source_Sql_Element;

   --------------------------------------
   -- Create_Table_Database_Source_Table_Element --
   --------------------------------------

   overriding function Create_Table_Database_Source_Table_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Database_Source_Table_Elements.ODF_Table_Database_Source_Table_Element_Access is
   begin
      return
        ODF.DOM.Table_Database_Source_Table_Elements.ODF_Table_Database_Source_Table_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Database_Source_Table_Element));
   end Create_Table_Database_Source_Table_Element;

   --------------------------------------
   -- Create_Table_Dde_Links_Element --
   --------------------------------------

   overriding function Create_Table_Dde_Links_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Dde_Links_Elements.ODF_Table_Dde_Links_Element_Access is
   begin
      return
        ODF.DOM.Table_Dde_Links_Elements.ODF_Table_Dde_Links_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Dde_Links_Element));
   end Create_Table_Dde_Links_Element;

   --------------------------------------
   -- Create_Table_Deletion_Element --
   --------------------------------------

   overriding function Create_Table_Deletion_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Deletion_Elements.ODF_Table_Deletion_Element_Access is
   begin
      return
        ODF.DOM.Table_Deletion_Elements.ODF_Table_Deletion_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Deletion_Element));
   end Create_Table_Deletion_Element;

   --------------------------------------
   -- Create_Table_Deletions_Element --
   --------------------------------------

   overriding function Create_Table_Deletions_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Deletions_Elements.ODF_Table_Deletions_Element_Access is
   begin
      return
        ODF.DOM.Table_Deletions_Elements.ODF_Table_Deletions_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Deletions_Element));
   end Create_Table_Deletions_Element;

   --------------------------------------
   -- Create_Table_Dependencies_Element --
   --------------------------------------

   overriding function Create_Table_Dependencies_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Dependencies_Elements.ODF_Table_Dependencies_Element_Access is
   begin
      return
        ODF.DOM.Table_Dependencies_Elements.ODF_Table_Dependencies_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Dependencies_Element));
   end Create_Table_Dependencies_Element;

   --------------------------------------
   -- Create_Table_Dependency_Element --
   --------------------------------------

   overriding function Create_Table_Dependency_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Dependency_Elements.ODF_Table_Dependency_Element_Access is
   begin
      return
        ODF.DOM.Table_Dependency_Elements.ODF_Table_Dependency_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Dependency_Element));
   end Create_Table_Dependency_Element;

   --------------------------------------
   -- Create_Table_Desc_Element --
   --------------------------------------

   overriding function Create_Table_Desc_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Desc_Elements.ODF_Table_Desc_Element_Access is
   begin
      return
        ODF.DOM.Table_Desc_Elements.ODF_Table_Desc_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Desc_Element));
   end Create_Table_Desc_Element;

   --------------------------------------
   -- Create_Table_Last_Column_Element --
   --------------------------------------

   overriding function Create_Table_Last_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Last_Column_Elements.ODF_Table_Last_Column_Element_Access is
   begin
      return
        ODF.DOM.Table_Last_Column_Elements.ODF_Table_Last_Column_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Last_Column_Element));
   end Create_Table_Last_Column_Element;

   --------------------------------------
   -- Create_Table_Last_Row_Element --
   --------------------------------------

   overriding function Create_Table_Last_Row_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Last_Row_Elements.ODF_Table_Last_Row_Element_Access is
   begin
      return
        ODF.DOM.Table_Last_Row_Elements.ODF_Table_Last_Row_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Last_Row_Element));
   end Create_Table_Last_Row_Element;

   --------------------------------------
   -- Create_Table_Odd_Columns_Element --
   --------------------------------------

   overriding function Create_Table_Odd_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Odd_Columns_Elements.ODF_Table_Odd_Columns_Element_Access is
   begin
      return
        ODF.DOM.Table_Odd_Columns_Elements.ODF_Table_Odd_Columns_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Odd_Columns_Element));
   end Create_Table_Odd_Columns_Element;

   --------------------------------------
   -- Create_Table_Odd_Rows_Element --
   --------------------------------------

   overriding function Create_Table_Odd_Rows_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Odd_Rows_Elements.ODF_Table_Odd_Rows_Element_Access is
   begin
      return
        ODF.DOM.Table_Odd_Rows_Elements.ODF_Table_Odd_Rows_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Odd_Rows_Element));
   end Create_Table_Odd_Rows_Element;

   --------------------------------------
   -- Create_Table_Table_Template_Element --
   --------------------------------------

   overriding function Create_Table_Table_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Template_Elements.ODF_Table_Table_Template_Element_Access is
   begin
      return
        ODF.DOM.Table_Table_Template_Elements.ODF_Table_Table_Template_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Table_Template_Element));
   end Create_Table_Table_Template_Element;

   --------------------------------------
   -- Create_Text_Creator_Element --
   --------------------------------------

   overriding function Create_Text_Creator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Creator_Elements.ODF_Text_Creator_Element_Access is
   begin
      return
        ODF.DOM.Text_Creator_Elements.ODF_Text_Creator_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Creator_Element));
   end Create_Text_Creator_Element;

   --------------------------------------
   -- Create_Text_Database_Display_Element --
   --------------------------------------

   overriding function Create_Text_Database_Display_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Database_Display_Elements.ODF_Text_Database_Display_Element_Access is
   begin
      return
        ODF.DOM.Text_Database_Display_Elements.ODF_Text_Database_Display_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Database_Display_Element));
   end Create_Text_Database_Display_Element;

   --------------------------------------
   -- Create_Text_Database_Name_Element --
   --------------------------------------

   overriding function Create_Text_Database_Name_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Database_Name_Elements.ODF_Text_Database_Name_Element_Access is
   begin
      return
        ODF.DOM.Text_Database_Name_Elements.ODF_Text_Database_Name_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Database_Name_Element));
   end Create_Text_Database_Name_Element;

   --------------------------------------
   -- Create_Text_Database_Next_Element --
   --------------------------------------

   overriding function Create_Text_Database_Next_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Database_Next_Elements.ODF_Text_Database_Next_Element_Access is
   begin
      return
        ODF.DOM.Text_Database_Next_Elements.ODF_Text_Database_Next_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Database_Next_Element));
   end Create_Text_Database_Next_Element;

   --------------------------------------
   -- Create_Text_Database_Row_Number_Element --
   --------------------------------------

   overriding function Create_Text_Database_Row_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Database_Row_Number_Elements.ODF_Text_Database_Row_Number_Element_Access is
   begin
      return
        ODF.DOM.Text_Database_Row_Number_Elements.ODF_Text_Database_Row_Number_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Database_Row_Number_Element));
   end Create_Text_Database_Row_Number_Element;

   --------------------------------------
   -- Create_Text_Database_Row_Select_Element --
   --------------------------------------

   overriding function Create_Text_Database_Row_Select_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Database_Row_Select_Elements.ODF_Text_Database_Row_Select_Element_Access is
   begin
      return
        ODF.DOM.Text_Database_Row_Select_Elements.ODF_Text_Database_Row_Select_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Database_Row_Select_Element));
   end Create_Text_Database_Row_Select_Element;

   --------------------------------------
   -- Create_Dc_Date_Element --
   --------------------------------------

   overriding function Create_Dc_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dc_Date_Elements.ODF_Dc_Date_Element_Access is
   begin
      return
        ODF.DOM.Dc_Date_Elements.ODF_Dc_Date_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Dc_URI,
            Matreshka.ODF_String_Constants.Dc_Prefix,
            Matreshka.ODF_String_Constants.Date_Element));
   end Create_Dc_Date_Element;

   --------------------------------------
   -- Create_Text_Date_Element --
   --------------------------------------

   overriding function Create_Text_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Date_Elements.ODF_Text_Date_Element_Access is
   begin
      return
        ODF.DOM.Text_Date_Elements.ODF_Text_Date_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Date_Element));
   end Create_Text_Date_Element;

   --------------------------------------
   -- Create_Text_Dde_Connection_Element --
   --------------------------------------

   overriding function Create_Text_Dde_Connection_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Dde_Connection_Elements.ODF_Text_Dde_Connection_Element_Access is
   begin
      return
        ODF.DOM.Text_Dde_Connection_Elements.ODF_Text_Dde_Connection_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Dde_Connection_Element));
   end Create_Text_Dde_Connection_Element;

   --------------------------------------
   -- Create_Text_Dde_Connection_Decl_Element --
   --------------------------------------

   overriding function Create_Text_Dde_Connection_Decl_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Dde_Connection_Decl_Elements.ODF_Text_Dde_Connection_Decl_Element_Access is
   begin
      return
        ODF.DOM.Text_Dde_Connection_Decl_Elements.ODF_Text_Dde_Connection_Decl_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Dde_Connection_Decl_Element));
   end Create_Text_Dde_Connection_Decl_Element;

   --------------------------------------
   -- Create_Text_Dde_Connection_Decls_Element --
   --------------------------------------

   overriding function Create_Text_Dde_Connection_Decls_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Dde_Connection_Decls_Elements.ODF_Text_Dde_Connection_Decls_Element_Access is
   begin
      return
        ODF.DOM.Text_Dde_Connection_Decls_Elements.ODF_Text_Dde_Connection_Decls_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Dde_Connection_Decls_Element));
   end Create_Text_Dde_Connection_Decls_Element;

   --------------------------------------
   -- Create_Text_Deletion_Element --
   --------------------------------------

   overriding function Create_Text_Deletion_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Deletion_Elements.ODF_Text_Deletion_Element_Access is
   begin
      return
        ODF.DOM.Text_Deletion_Elements.ODF_Text_Deletion_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Deletion_Element));
   end Create_Text_Deletion_Element;

   --------------------------------------
   -- Create_Dc_Description_Element --
   --------------------------------------

   overriding function Create_Dc_Description_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dc_Description_Elements.ODF_Dc_Description_Element_Access is
   begin
      return
        ODF.DOM.Dc_Description_Elements.ODF_Dc_Description_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Dc_URI,
            Matreshka.ODF_String_Constants.Dc_Prefix,
            Matreshka.ODF_String_Constants.Description_Element));
   end Create_Dc_Description_Element;

   --------------------------------------
   -- Create_Table_Detective_Element --
   --------------------------------------

   overriding function Create_Table_Detective_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Detective_Elements.ODF_Table_Detective_Element_Access is
   begin
      return
        ODF.DOM.Table_Detective_Elements.ODF_Table_Detective_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Detective_Element));
   end Create_Table_Detective_Element;

   --------------------------------------
   -- Create_Text_Description_Element --
   --------------------------------------

   overriding function Create_Text_Description_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Description_Elements.ODF_Text_Description_Element_Access is
   begin
      return
        ODF.DOM.Text_Description_Elements.ODF_Text_Description_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Description_Element));
   end Create_Text_Description_Element;

   --------------------------------------
   -- Create_Meta_Document_Statistic_Element --
   --------------------------------------

   overriding function Create_Meta_Document_Statistic_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Document_Statistic_Elements.ODF_Meta_Document_Statistic_Element_Access is
   begin
      return
        ODF.DOM.Meta_Document_Statistic_Elements.ODF_Meta_Document_Statistic_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Meta_URI,
            Matreshka.ODF_String_Constants.Meta_Prefix,
            Matreshka.ODF_String_Constants.Document_Statistic_Element));
   end Create_Meta_Document_Statistic_Element;

   --------------------------------------
   -- Create_Meta_Editing_Cycles_Element --
   --------------------------------------

   overriding function Create_Meta_Editing_Cycles_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Editing_Cycles_Elements.ODF_Meta_Editing_Cycles_Element_Access is
   begin
      return
        ODF.DOM.Meta_Editing_Cycles_Elements.ODF_Meta_Editing_Cycles_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Meta_URI,
            Matreshka.ODF_String_Constants.Meta_Prefix,
            Matreshka.ODF_String_Constants.Editing_Cycles_Element));
   end Create_Meta_Editing_Cycles_Element;

   --------------------------------------
   -- Create_Meta_Editing_Duration_Element --
   --------------------------------------

   overriding function Create_Meta_Editing_Duration_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Editing_Duration_Elements.ODF_Meta_Editing_Duration_Element_Access is
   begin
      return
        ODF.DOM.Meta_Editing_Duration_Elements.ODF_Meta_Editing_Duration_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Meta_URI,
            Matreshka.ODF_String_Constants.Meta_Prefix,
            Matreshka.ODF_String_Constants.Editing_Duration_Element));
   end Create_Meta_Editing_Duration_Element;

   --------------------------------------
   -- Create_Dc_Language_Element --
   --------------------------------------

   overriding function Create_Dc_Language_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dc_Language_Elements.ODF_Dc_Language_Element_Access is
   begin
      return
        ODF.DOM.Dc_Language_Elements.ODF_Dc_Language_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Dc_URI,
            Matreshka.ODF_String_Constants.Dc_Prefix,
            Matreshka.ODF_String_Constants.Language_Element));
   end Create_Dc_Language_Element;

   --------------------------------------
   -- Create_Dc_Subject_Element --
   --------------------------------------

   overriding function Create_Dc_Subject_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dc_Subject_Elements.ODF_Dc_Subject_Element_Access is
   begin
      return
        ODF.DOM.Dc_Subject_Elements.ODF_Dc_Subject_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Dc_URI,
            Matreshka.ODF_String_Constants.Dc_Prefix,
            Matreshka.ODF_String_Constants.Subject_Element));
   end Create_Dc_Subject_Element;

   --------------------------------------
   -- Create_Dc_Title_Element --
   --------------------------------------

   overriding function Create_Dc_Title_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Dc_Title_Elements.ODF_Dc_Title_Element_Access is
   begin
      return
        ODF.DOM.Dc_Title_Elements.ODF_Dc_Title_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Dc_URI,
            Matreshka.ODF_String_Constants.Dc_Prefix,
            Matreshka.ODF_String_Constants.Title_Element));
   end Create_Dc_Title_Element;

   --------------------------------------
   -- Create_Meta_Generator_Element --
   --------------------------------------

   overriding function Create_Meta_Generator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Generator_Elements.ODF_Meta_Generator_Element_Access is
   begin
      return
        ODF.DOM.Meta_Generator_Elements.ODF_Meta_Generator_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Meta_URI,
            Matreshka.ODF_String_Constants.Meta_Prefix,
            Matreshka.ODF_String_Constants.Generator_Element));
   end Create_Meta_Generator_Element;

   --------------------------------------
   -- Create_Meta_Hyperlink_Behaviour_Element --
   --------------------------------------

   overriding function Create_Meta_Hyperlink_Behaviour_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Hyperlink_Behaviour_Elements.ODF_Meta_Hyperlink_Behaviour_Element_Access is
   begin
      return
        ODF.DOM.Meta_Hyperlink_Behaviour_Elements.ODF_Meta_Hyperlink_Behaviour_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Meta_URI,
            Matreshka.ODF_String_Constants.Meta_Prefix,
            Matreshka.ODF_String_Constants.Hyperlink_Behaviour_Element));
   end Create_Meta_Hyperlink_Behaviour_Element;

   --------------------------------------
   -- Create_Meta_Initial_Creator_Element --
   --------------------------------------

   overriding function Create_Meta_Initial_Creator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Initial_Creator_Elements.ODF_Meta_Initial_Creator_Element_Access is
   begin
      return
        ODF.DOM.Meta_Initial_Creator_Elements.ODF_Meta_Initial_Creator_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Meta_URI,
            Matreshka.ODF_String_Constants.Meta_Prefix,
            Matreshka.ODF_String_Constants.Initial_Creator_Element));
   end Create_Meta_Initial_Creator_Element;

   --------------------------------------
   -- Create_Meta_Keyword_Element --
   --------------------------------------

   overriding function Create_Meta_Keyword_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Keyword_Elements.ODF_Meta_Keyword_Element_Access is
   begin
      return
        ODF.DOM.Meta_Keyword_Elements.ODF_Meta_Keyword_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Meta_URI,
            Matreshka.ODF_String_Constants.Meta_Prefix,
            Matreshka.ODF_String_Constants.Keyword_Element));
   end Create_Meta_Keyword_Element;

   --------------------------------------
   -- Create_Meta_Print_Date_Element --
   --------------------------------------

   overriding function Create_Meta_Print_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Print_Date_Elements.ODF_Meta_Print_Date_Element_Access is
   begin
      return
        ODF.DOM.Meta_Print_Date_Elements.ODF_Meta_Print_Date_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Meta_URI,
            Matreshka.ODF_String_Constants.Meta_Prefix,
            Matreshka.ODF_String_Constants.Print_Date_Element));
   end Create_Meta_Print_Date_Element;

   --------------------------------------
   -- Create_Meta_Printed_By_Element --
   --------------------------------------

   overriding function Create_Meta_Printed_By_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Printed_By_Elements.ODF_Meta_Printed_By_Element_Access is
   begin
      return
        ODF.DOM.Meta_Printed_By_Elements.ODF_Meta_Printed_By_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Meta_URI,
            Matreshka.ODF_String_Constants.Meta_Prefix,
            Matreshka.ODF_String_Constants.Printed_By_Element));
   end Create_Meta_Printed_By_Element;

   --------------------------------------
   -- Create_Meta_Template_Element --
   --------------------------------------

   overriding function Create_Meta_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_Template_Elements.ODF_Meta_Template_Element_Access is
   begin
      return
        ODF.DOM.Meta_Template_Elements.ODF_Meta_Template_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Meta_URI,
            Matreshka.ODF_String_Constants.Meta_Prefix,
            Matreshka.ODF_String_Constants.Template_Element));
   end Create_Meta_Template_Element;

   --------------------------------------
   -- Create_Meta_User_Defined_Element --
   --------------------------------------

   overriding function Create_Meta_User_Defined_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Meta_User_Defined_Elements.ODF_Meta_User_Defined_Element_Access is
   begin
      return
        ODF.DOM.Meta_User_Defined_Elements.ODF_Meta_User_Defined_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Meta_URI,
            Matreshka.ODF_String_Constants.Meta_Prefix,
            Matreshka.ODF_String_Constants.User_Defined_Element));
   end Create_Meta_User_Defined_Element;

   --------------------------------------
   -- Create_Office_Body_Element --
   --------------------------------------

   overriding function Create_Office_Body_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Body_Elements.ODF_Office_Body_Element_Access is
   begin
      return
        ODF.DOM.Office_Body_Elements.ODF_Office_Body_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Body_Element));
   end Create_Office_Body_Element;

   --------------------------------------
   -- Create_Office_Chart_Element --
   --------------------------------------

   overriding function Create_Office_Chart_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Chart_Elements.ODF_Office_Chart_Element_Access is
   begin
      return
        ODF.DOM.Office_Chart_Elements.ODF_Office_Chart_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Chart_Element));
   end Create_Office_Chart_Element;

   --------------------------------------
   -- Create_Office_Document_Element --
   --------------------------------------

   overriding function Create_Office_Document_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Document_Elements.ODF_Office_Document_Element_Access is
   begin
      return
        ODF.DOM.Office_Document_Elements.ODF_Office_Document_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Document_Element));
   end Create_Office_Document_Element;

   --------------------------------------
   -- Create_Office_Document_Content_Element --
   --------------------------------------

   overriding function Create_Office_Document_Content_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Document_Content_Elements.ODF_Office_Document_Content_Element_Access is
   begin
      return
        ODF.DOM.Office_Document_Content_Elements.ODF_Office_Document_Content_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Document_Content_Element));
   end Create_Office_Document_Content_Element;

   --------------------------------------
   -- Create_Office_Document_Meta_Element --
   --------------------------------------

   overriding function Create_Office_Document_Meta_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Document_Meta_Elements.ODF_Office_Document_Meta_Element_Access is
   begin
      return
        ODF.DOM.Office_Document_Meta_Elements.ODF_Office_Document_Meta_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Document_Meta_Element));
   end Create_Office_Document_Meta_Element;

   --------------------------------------
   -- Create_Office_Document_Settings_Element --
   --------------------------------------

   overriding function Create_Office_Document_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Document_Settings_Elements.ODF_Office_Document_Settings_Element_Access is
   begin
      return
        ODF.DOM.Office_Document_Settings_Elements.ODF_Office_Document_Settings_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Document_Settings_Element));
   end Create_Office_Document_Settings_Element;

   --------------------------------------
   -- Create_Office_Document_Styles_Element --
   --------------------------------------

   overriding function Create_Office_Document_Styles_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Document_Styles_Elements.ODF_Office_Document_Styles_Element_Access is
   begin
      return
        ODF.DOM.Office_Document_Styles_Elements.ODF_Office_Document_Styles_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Document_Styles_Element));
   end Create_Office_Document_Styles_Element;

   --------------------------------------
   -- Create_Office_Drawing_Element --
   --------------------------------------

   overriding function Create_Office_Drawing_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Drawing_Elements.ODF_Office_Drawing_Element_Access is
   begin
      return
        ODF.DOM.Office_Drawing_Elements.ODF_Office_Drawing_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Drawing_Element));
   end Create_Office_Drawing_Element;

   --------------------------------------
   -- Create_Style_Handout_Master_Element --
   --------------------------------------

   overriding function Create_Style_Handout_Master_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Style_Handout_Master_Elements.ODF_Style_Handout_Master_Element_Access is
   begin
      return
        ODF.DOM.Style_Handout_Master_Elements.ODF_Style_Handout_Master_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Style_URI,
            Matreshka.ODF_String_Constants.Style_Prefix,
            Matreshka.ODF_String_Constants.Handout_Master_Element));
   end Create_Style_Handout_Master_Element;

   --------------------------------------
   -- Create_Table_Error_Macro_Element --
   --------------------------------------

   overriding function Create_Table_Error_Macro_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Error_Macro_Elements.ODF_Table_Error_Macro_Element_Access is
   begin
      return
        ODF.DOM.Table_Error_Macro_Elements.ODF_Table_Error_Macro_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Error_Macro_Element));
   end Create_Table_Error_Macro_Element;

   --------------------------------------
   -- Create_Table_Error_Message_Element --
   --------------------------------------

   overriding function Create_Table_Error_Message_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Error_Message_Elements.ODF_Table_Error_Message_Element_Access is
   begin
      return
        ODF.DOM.Table_Error_Message_Elements.ODF_Table_Error_Message_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Error_Message_Element));
   end Create_Table_Error_Message_Element;

   --------------------------------------
   -- Create_Table_Filter_Element --
   --------------------------------------

   overriding function Create_Table_Filter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Filter_Elements.ODF_Table_Filter_Element_Access is
   begin
      return
        ODF.DOM.Table_Filter_Elements.ODF_Table_Filter_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Filter_Element));
   end Create_Table_Filter_Element;

   --------------------------------------
   -- Create_Table_Filter_And_Element --
   --------------------------------------

   overriding function Create_Table_Filter_And_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Filter_And_Elements.ODF_Table_Filter_And_Element_Access is
   begin
      return
        ODF.DOM.Table_Filter_And_Elements.ODF_Table_Filter_And_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Filter_And_Element));
   end Create_Table_Filter_And_Element;

   --------------------------------------
   -- Create_Table_Filter_Condition_Element --
   --------------------------------------

   overriding function Create_Table_Filter_Condition_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Filter_Condition_Elements.ODF_Table_Filter_Condition_Element_Access is
   begin
      return
        ODF.DOM.Table_Filter_Condition_Elements.ODF_Table_Filter_Condition_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Filter_Condition_Element));
   end Create_Table_Filter_Condition_Element;

   --------------------------------------
   -- Create_Table_Filter_Or_Element --
   --------------------------------------

   overriding function Create_Table_Filter_Or_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Filter_Or_Elements.ODF_Table_Filter_Or_Element_Access is
   begin
      return
        ODF.DOM.Table_Filter_Or_Elements.ODF_Table_Filter_Or_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Filter_Or_Element));
   end Create_Table_Filter_Or_Element;

   --------------------------------------
   -- Create_Table_Filter_Set_Item_Element --
   --------------------------------------

   overriding function Create_Table_Filter_Set_Item_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Filter_Set_Item_Elements.ODF_Table_Filter_Set_Item_Element_Access is
   begin
      return
        ODF.DOM.Table_Filter_Set_Item_Elements.ODF_Table_Filter_Set_Item_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Filter_Set_Item_Element));
   end Create_Table_Filter_Set_Item_Element;

   --------------------------------------
   -- Create_Table_Help_Message_Element --
   --------------------------------------

   overriding function Create_Table_Help_Message_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Help_Message_Elements.ODF_Table_Help_Message_Element_Access is
   begin
      return
        ODF.DOM.Table_Help_Message_Elements.ODF_Table_Help_Message_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Help_Message_Element));
   end Create_Table_Help_Message_Element;

   --------------------------------------
   -- Create_Table_Highlighted_Range_Element --
   --------------------------------------

   overriding function Create_Table_Highlighted_Range_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Highlighted_Range_Elements.ODF_Table_Highlighted_Range_Element_Access is
   begin
      return
        ODF.DOM.Table_Highlighted_Range_Elements.ODF_Table_Highlighted_Range_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Highlighted_Range_Element));
   end Create_Table_Highlighted_Range_Element;

   --------------------------------------
   -- Create_Text_Editing_Cycles_Element --
   --------------------------------------

   overriding function Create_Text_Editing_Cycles_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Editing_Cycles_Elements.ODF_Text_Editing_Cycles_Element_Access is
   begin
      return
        ODF.DOM.Text_Editing_Cycles_Elements.ODF_Text_Editing_Cycles_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Editing_Cycles_Element));
   end Create_Text_Editing_Cycles_Element;

   --------------------------------------
   -- Create_Text_Editing_Duration_Element --
   --------------------------------------

   overriding function Create_Text_Editing_Duration_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Editing_Duration_Elements.ODF_Text_Editing_Duration_Element_Access is
   begin
      return
        ODF.DOM.Text_Editing_Duration_Elements.ODF_Text_Editing_Duration_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Editing_Duration_Element));
   end Create_Text_Editing_Duration_Element;

   --------------------------------------
   -- Create_Text_Execute_Macro_Element --
   --------------------------------------

   overriding function Create_Text_Execute_Macro_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Execute_Macro_Elements.ODF_Text_Execute_Macro_Element_Access is
   begin
      return
        ODF.DOM.Text_Execute_Macro_Elements.ODF_Text_Execute_Macro_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Execute_Macro_Element));
   end Create_Text_Execute_Macro_Element;

   --------------------------------------
   -- Create_Text_Expression_Element --
   --------------------------------------

   overriding function Create_Text_Expression_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Expression_Elements.ODF_Text_Expression_Element_Access is
   begin
      return
        ODF.DOM.Text_Expression_Elements.ODF_Text_Expression_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Expression_Element));
   end Create_Text_Expression_Element;

   --------------------------------------
   -- Create_Text_File_Name_Element --
   --------------------------------------

   overriding function Create_Text_File_Name_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_File_Name_Elements.ODF_Text_File_Name_Element_Access is
   begin
      return
        ODF.DOM.Text_File_Name_Elements.ODF_Text_File_Name_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.File_Name_Element));
   end Create_Text_File_Name_Element;

   --------------------------------------
   -- Create_Office_Font_Face_Decls_Element --
   --------------------------------------

   overriding function Create_Office_Font_Face_Decls_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Font_Face_Decls_Elements.ODF_Office_Font_Face_Decls_Element_Access is
   begin
      return
        ODF.DOM.Office_Font_Face_Decls_Elements.ODF_Office_Font_Face_Decls_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Font_Face_Decls_Element));
   end Create_Office_Font_Face_Decls_Element;

   --------------------------------------
   -- Create_Text_Format_Change_Element --
   --------------------------------------

   overriding function Create_Text_Format_Change_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Format_Change_Elements.ODF_Text_Format_Change_Element_Access is
   begin
      return
        ODF.DOM.Text_Format_Change_Elements.ODF_Text_Format_Change_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Format_Change_Element));
   end Create_Text_Format_Change_Element;

   --------------------------------------
   -- Create_Text_H_Element --
   --------------------------------------

   overriding function Create_Text_H_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_H_Elements.ODF_Text_H_Element_Access is
   begin
      return
        ODF.DOM.Text_H_Elements.ODF_Text_H_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.H_Element));
   end Create_Text_H_Element;

   --------------------------------------
   -- Create_Text_Hidden_Paragraph_Element --
   --------------------------------------

   overriding function Create_Text_Hidden_Paragraph_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Hidden_Paragraph_Elements.ODF_Text_Hidden_Paragraph_Element_Access is
   begin
      return
        ODF.DOM.Text_Hidden_Paragraph_Elements.ODF_Text_Hidden_Paragraph_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Hidden_Paragraph_Element));
   end Create_Text_Hidden_Paragraph_Element;

   --------------------------------------
   -- Create_Text_Hidden_Text_Element --
   --------------------------------------

   overriding function Create_Text_Hidden_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Hidden_Text_Elements.ODF_Text_Hidden_Text_Element_Access is
   begin
      return
        ODF.DOM.Text_Hidden_Text_Elements.ODF_Text_Hidden_Text_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Hidden_Text_Element));
   end Create_Text_Hidden_Text_Element;

   --------------------------------------
   -- Create_Text_Illustration_Index_Element --
   --------------------------------------

   overriding function Create_Text_Illustration_Index_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Illustration_Index_Elements.ODF_Text_Illustration_Index_Element_Access is
   begin
      return
        ODF.DOM.Text_Illustration_Index_Elements.ODF_Text_Illustration_Index_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Illustration_Index_Element));
   end Create_Text_Illustration_Index_Element;

   --------------------------------------
   -- Create_Text_Illustration_Index_Entry_Template_Element --
   --------------------------------------

   overriding function Create_Text_Illustration_Index_Entry_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Illustration_Index_Entry_Template_Elements.ODF_Text_Illustration_Index_Entry_Template_Element_Access is
   begin
      return
        ODF.DOM.Text_Illustration_Index_Entry_Template_Elements.ODF_Text_Illustration_Index_Entry_Template_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Illustration_Index_Entry_Template_Element));
   end Create_Text_Illustration_Index_Entry_Template_Element;

   --------------------------------------
   -- Create_Text_Illustration_Index_Source_Element --
   --------------------------------------

   overriding function Create_Text_Illustration_Index_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Illustration_Index_Source_Elements.ODF_Text_Illustration_Index_Source_Element_Access is
   begin
      return
        ODF.DOM.Text_Illustration_Index_Source_Elements.ODF_Text_Illustration_Index_Source_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Illustration_Index_Source_Element));
   end Create_Text_Illustration_Index_Source_Element;

   --------------------------------------
   -- Create_Office_Image_Element --
   --------------------------------------

   overriding function Create_Office_Image_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Image_Elements.ODF_Office_Image_Element_Access is
   begin
      return
        ODF.DOM.Office_Image_Elements.ODF_Office_Image_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Image_Element));
   end Create_Office_Image_Element;

   --------------------------------------
   -- Create_Table_Insertion_Element --
   --------------------------------------

   overriding function Create_Table_Insertion_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Insertion_Elements.ODF_Table_Insertion_Element_Access is
   begin
      return
        ODF.DOM.Table_Insertion_Elements.ODF_Table_Insertion_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Insertion_Element));
   end Create_Table_Insertion_Element;

   --------------------------------------
   -- Create_Table_Insertion_Cut_Off_Element --
   --------------------------------------

   overriding function Create_Table_Insertion_Cut_Off_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Insertion_Cut_Off_Elements.ODF_Table_Insertion_Cut_Off_Element_Access is
   begin
      return
        ODF.DOM.Table_Insertion_Cut_Off_Elements.ODF_Table_Insertion_Cut_Off_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Insertion_Cut_Off_Element));
   end Create_Table_Insertion_Cut_Off_Element;

   --------------------------------------
   -- Create_Table_Iteration_Element --
   --------------------------------------

   overriding function Create_Table_Iteration_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Iteration_Elements.ODF_Table_Iteration_Element_Access is
   begin
      return
        ODF.DOM.Table_Iteration_Elements.ODF_Table_Iteration_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Iteration_Element));
   end Create_Table_Iteration_Element;

   --------------------------------------
   -- Create_Table_Label_Range_Element --
   --------------------------------------

   overriding function Create_Table_Label_Range_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Label_Range_Elements.ODF_Table_Label_Range_Element_Access is
   begin
      return
        ODF.DOM.Table_Label_Range_Elements.ODF_Table_Label_Range_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Label_Range_Element));
   end Create_Table_Label_Range_Element;

   --------------------------------------
   -- Create_Table_Label_Ranges_Element --
   --------------------------------------

   overriding function Create_Table_Label_Ranges_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Label_Ranges_Elements.ODF_Table_Label_Ranges_Element_Access is
   begin
      return
        ODF.DOM.Table_Label_Ranges_Elements.ODF_Table_Label_Ranges_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Label_Ranges_Element));
   end Create_Table_Label_Ranges_Element;

   --------------------------------------
   -- Create_Text_Image_Count_Element --
   --------------------------------------

   overriding function Create_Text_Image_Count_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Image_Count_Elements.ODF_Text_Image_Count_Element_Access is
   begin
      return
        ODF.DOM.Text_Image_Count_Elements.ODF_Text_Image_Count_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Image_Count_Element));
   end Create_Text_Image_Count_Element;

   --------------------------------------
   -- Create_Text_Index_Body_Element --
   --------------------------------------

   overriding function Create_Text_Index_Body_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Body_Elements.ODF_Text_Index_Body_Element_Access is
   begin
      return
        ODF.DOM.Text_Index_Body_Elements.ODF_Text_Index_Body_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Index_Body_Element));
   end Create_Text_Index_Body_Element;

   --------------------------------------
   -- Create_Text_Index_Entry_Bibliography_Element --
   --------------------------------------

   overriding function Create_Text_Index_Entry_Bibliography_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Bibliography_Elements.ODF_Text_Index_Entry_Bibliography_Element_Access is
   begin
      return
        ODF.DOM.Text_Index_Entry_Bibliography_Elements.ODF_Text_Index_Entry_Bibliography_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Index_Entry_Bibliography_Element));
   end Create_Text_Index_Entry_Bibliography_Element;

   --------------------------------------
   -- Create_Text_Index_Entry_Chapter_Element --
   --------------------------------------

   overriding function Create_Text_Index_Entry_Chapter_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Chapter_Elements.ODF_Text_Index_Entry_Chapter_Element_Access is
   begin
      return
        ODF.DOM.Text_Index_Entry_Chapter_Elements.ODF_Text_Index_Entry_Chapter_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Index_Entry_Chapter_Element));
   end Create_Text_Index_Entry_Chapter_Element;

   --------------------------------------
   -- Create_Text_Index_Entry_Link_End_Element --
   --------------------------------------

   overriding function Create_Text_Index_Entry_Link_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Link_End_Elements.ODF_Text_Index_Entry_Link_End_Element_Access is
   begin
      return
        ODF.DOM.Text_Index_Entry_Link_End_Elements.ODF_Text_Index_Entry_Link_End_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Index_Entry_Link_End_Element));
   end Create_Text_Index_Entry_Link_End_Element;

   --------------------------------------
   -- Create_Text_Index_Entry_Link_Start_Element --
   --------------------------------------

   overriding function Create_Text_Index_Entry_Link_Start_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Link_Start_Elements.ODF_Text_Index_Entry_Link_Start_Element_Access is
   begin
      return
        ODF.DOM.Text_Index_Entry_Link_Start_Elements.ODF_Text_Index_Entry_Link_Start_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Index_Entry_Link_Start_Element));
   end Create_Text_Index_Entry_Link_Start_Element;

   --------------------------------------
   -- Create_Text_Index_Entry_Page_Number_Element --
   --------------------------------------

   overriding function Create_Text_Index_Entry_Page_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Page_Number_Elements.ODF_Text_Index_Entry_Page_Number_Element_Access is
   begin
      return
        ODF.DOM.Text_Index_Entry_Page_Number_Elements.ODF_Text_Index_Entry_Page_Number_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Index_Entry_Page_Number_Element));
   end Create_Text_Index_Entry_Page_Number_Element;

   --------------------------------------
   -- Create_Text_Index_Entry_Span_Element --
   --------------------------------------

   overriding function Create_Text_Index_Entry_Span_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Span_Elements.ODF_Text_Index_Entry_Span_Element_Access is
   begin
      return
        ODF.DOM.Text_Index_Entry_Span_Elements.ODF_Text_Index_Entry_Span_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Index_Entry_Span_Element));
   end Create_Text_Index_Entry_Span_Element;

   --------------------------------------
   -- Create_Text_Index_Entry_Tab_Stop_Element --
   --------------------------------------

   overriding function Create_Text_Index_Entry_Tab_Stop_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Tab_Stop_Elements.ODF_Text_Index_Entry_Tab_Stop_Element_Access is
   begin
      return
        ODF.DOM.Text_Index_Entry_Tab_Stop_Elements.ODF_Text_Index_Entry_Tab_Stop_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Index_Entry_Tab_Stop_Element));
   end Create_Text_Index_Entry_Tab_Stop_Element;

   --------------------------------------
   -- Create_Text_Index_Entry_Text_Element --
   --------------------------------------

   overriding function Create_Text_Index_Entry_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Entry_Text_Elements.ODF_Text_Index_Entry_Text_Element_Access is
   begin
      return
        ODF.DOM.Text_Index_Entry_Text_Elements.ODF_Text_Index_Entry_Text_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Index_Entry_Text_Element));
   end Create_Text_Index_Entry_Text_Element;

   --------------------------------------
   -- Create_Text_Index_Source_Style_Element --
   --------------------------------------

   overriding function Create_Text_Index_Source_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Source_Style_Elements.ODF_Text_Index_Source_Style_Element_Access is
   begin
      return
        ODF.DOM.Text_Index_Source_Style_Elements.ODF_Text_Index_Source_Style_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Index_Source_Style_Element));
   end Create_Text_Index_Source_Style_Element;

   --------------------------------------
   -- Create_Text_Index_Source_Styles_Element --
   --------------------------------------

   overriding function Create_Text_Index_Source_Styles_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Source_Styles_Elements.ODF_Text_Index_Source_Styles_Element_Access is
   begin
      return
        ODF.DOM.Text_Index_Source_Styles_Elements.ODF_Text_Index_Source_Styles_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Index_Source_Styles_Element));
   end Create_Text_Index_Source_Styles_Element;

   --------------------------------------
   -- Create_Text_Index_Title_Element --
   --------------------------------------

   overriding function Create_Text_Index_Title_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Title_Elements.ODF_Text_Index_Title_Element_Access is
   begin
      return
        ODF.DOM.Text_Index_Title_Elements.ODF_Text_Index_Title_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Index_Title_Element));
   end Create_Text_Index_Title_Element;

   --------------------------------------
   -- Create_Text_Index_Title_Template_Element --
   --------------------------------------

   overriding function Create_Text_Index_Title_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Index_Title_Template_Elements.ODF_Text_Index_Title_Template_Element_Access is
   begin
      return
        ODF.DOM.Text_Index_Title_Template_Elements.ODF_Text_Index_Title_Template_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Index_Title_Template_Element));
   end Create_Text_Index_Title_Template_Element;

   --------------------------------------
   -- Create_Text_Initial_Creator_Element --
   --------------------------------------

   overriding function Create_Text_Initial_Creator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Initial_Creator_Elements.ODF_Text_Initial_Creator_Element_Access is
   begin
      return
        ODF.DOM.Text_Initial_Creator_Elements.ODF_Text_Initial_Creator_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Initial_Creator_Element));
   end Create_Text_Initial_Creator_Element;

   --------------------------------------
   -- Create_Text_Insertion_Element --
   --------------------------------------

   overriding function Create_Text_Insertion_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Insertion_Elements.ODF_Text_Insertion_Element_Access is
   begin
      return
        ODF.DOM.Text_Insertion_Elements.ODF_Text_Insertion_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Insertion_Element));
   end Create_Text_Insertion_Element;

   --------------------------------------
   -- Create_Text_Keywords_Element --
   --------------------------------------

   overriding function Create_Text_Keywords_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Keywords_Elements.ODF_Text_Keywords_Element_Access is
   begin
      return
        ODF.DOM.Text_Keywords_Elements.ODF_Text_Keywords_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Keywords_Element));
   end Create_Text_Keywords_Element;

   --------------------------------------
   -- Create_Text_Line_Break_Element --
   --------------------------------------

   overriding function Create_Text_Line_Break_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Line_Break_Elements.ODF_Text_Line_Break_Element_Access is
   begin
      return
        ODF.DOM.Text_Line_Break_Elements.ODF_Text_Line_Break_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Line_Break_Element));
   end Create_Text_Line_Break_Element;

   --------------------------------------
   -- Create_Text_Linenumbering_Configuration_Element --
   --------------------------------------

   overriding function Create_Text_Linenumbering_Configuration_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Linenumbering_Configuration_Elements.ODF_Text_Linenumbering_Configuration_Element_Access is
   begin
      return
        ODF.DOM.Text_Linenumbering_Configuration_Elements.ODF_Text_Linenumbering_Configuration_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Linenumbering_Configuration_Element));
   end Create_Text_Linenumbering_Configuration_Element;

   --------------------------------------
   -- Create_Text_Linenumbering_Separator_Element --
   --------------------------------------

   overriding function Create_Text_Linenumbering_Separator_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Linenumbering_Separator_Elements.ODF_Text_Linenumbering_Separator_Element_Access is
   begin
      return
        ODF.DOM.Text_Linenumbering_Separator_Elements.ODF_Text_Linenumbering_Separator_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Linenumbering_Separator_Element));
   end Create_Text_Linenumbering_Separator_Element;

   --------------------------------------
   -- Create_Text_List_Element --
   --------------------------------------

   overriding function Create_Text_List_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_List_Elements.ODF_Text_List_Element_Access is
   begin
      return
        ODF.DOM.Text_List_Elements.ODF_Text_List_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.List_Element));
   end Create_Text_List_Element;

   --------------------------------------
   -- Create_Text_List_Header_Element --
   --------------------------------------

   overriding function Create_Text_List_Header_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_List_Header_Elements.ODF_Text_List_Header_Element_Access is
   begin
      return
        ODF.DOM.Text_List_Header_Elements.ODF_Text_List_Header_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.List_Header_Element));
   end Create_Text_List_Header_Element;

   --------------------------------------
   -- Create_Text_List_Item_Element --
   --------------------------------------

   overriding function Create_Text_List_Item_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_List_Item_Elements.ODF_Text_List_Item_Element_Access is
   begin
      return
        ODF.DOM.Text_List_Item_Elements.ODF_Text_List_Item_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.List_Item_Element));
   end Create_Text_List_Item_Element;

   --------------------------------------
   -- Create_Text_List_Level_Style_Bullet_Element --
   --------------------------------------

   overriding function Create_Text_List_Level_Style_Bullet_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_List_Level_Style_Bullet_Elements.ODF_Text_List_Level_Style_Bullet_Element_Access is
   begin
      return
        ODF.DOM.Text_List_Level_Style_Bullet_Elements.ODF_Text_List_Level_Style_Bullet_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.List_Level_Style_Bullet_Element));
   end Create_Text_List_Level_Style_Bullet_Element;

   --------------------------------------
   -- Create_Text_List_Level_Style_Image_Element --
   --------------------------------------

   overriding function Create_Text_List_Level_Style_Image_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_List_Level_Style_Image_Elements.ODF_Text_List_Level_Style_Image_Element_Access is
   begin
      return
        ODF.DOM.Text_List_Level_Style_Image_Elements.ODF_Text_List_Level_Style_Image_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.List_Level_Style_Image_Element));
   end Create_Text_List_Level_Style_Image_Element;

   --------------------------------------
   -- Create_Text_List_Level_Style_Number_Element --
   --------------------------------------

   overriding function Create_Text_List_Level_Style_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_List_Level_Style_Number_Elements.ODF_Text_List_Level_Style_Number_Element_Access is
   begin
      return
        ODF.DOM.Text_List_Level_Style_Number_Elements.ODF_Text_List_Level_Style_Number_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.List_Level_Style_Number_Element));
   end Create_Text_List_Level_Style_Number_Element;

   --------------------------------------
   -- Create_Text_List_Style_Element --
   --------------------------------------

   overriding function Create_Text_List_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_List_Style_Elements.ODF_Text_List_Style_Element_Access is
   begin
      return
        ODF.DOM.Text_List_Style_Elements.ODF_Text_List_Style_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.List_Style_Element));
   end Create_Text_List_Style_Element;

   --------------------------------------
   -- Create_Office_Master_Styles_Element --
   --------------------------------------

   overriding function Create_Office_Master_Styles_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Master_Styles_Elements.ODF_Office_Master_Styles_Element_Access is
   begin
      return
        ODF.DOM.Office_Master_Styles_Elements.ODF_Office_Master_Styles_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Master_Styles_Element));
   end Create_Office_Master_Styles_Element;

   --------------------------------------
   -- Create_Text_Measure_Element --
   --------------------------------------

   overriding function Create_Text_Measure_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Measure_Elements.ODF_Text_Measure_Element_Access is
   begin
      return
        ODF.DOM.Text_Measure_Elements.ODF_Text_Measure_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Measure_Element));
   end Create_Text_Measure_Element;

   --------------------------------------
   -- Create_Office_Meta_Element --
   --------------------------------------

   overriding function Create_Office_Meta_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Meta_Elements.ODF_Office_Meta_Element_Access is
   begin
      return
        ODF.DOM.Office_Meta_Elements.ODF_Office_Meta_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Meta_Element));
   end Create_Office_Meta_Element;

   --------------------------------------
   -- Create_Presentation_Play_Element --
   --------------------------------------

   overriding function Create_Presentation_Play_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Play_Elements.ODF_Presentation_Play_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Play_Elements.ODF_Presentation_Play_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Play_Element));
   end Create_Presentation_Play_Element;

   --------------------------------------
   -- Create_Presentation_Settings_Element --
   --------------------------------------

   overriding function Create_Presentation_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Settings_Elements.ODF_Presentation_Settings_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Settings_Elements.ODF_Presentation_Settings_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Settings_Element));
   end Create_Presentation_Settings_Element;

   --------------------------------------
   -- Create_Presentation_Show_Element --
   --------------------------------------

   overriding function Create_Presentation_Show_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Show_Elements.ODF_Presentation_Show_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Show_Elements.ODF_Presentation_Show_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Show_Element));
   end Create_Presentation_Show_Element;

   --------------------------------------
   -- Create_Presentation_Show_Shape_Element --
   --------------------------------------

   overriding function Create_Presentation_Show_Shape_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Show_Shape_Elements.ODF_Presentation_Show_Shape_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Show_Shape_Elements.ODF_Presentation_Show_Shape_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Show_Shape_Element));
   end Create_Presentation_Show_Shape_Element;

   --------------------------------------
   -- Create_Presentation_Show_Text_Element --
   --------------------------------------

   overriding function Create_Presentation_Show_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Show_Text_Elements.ODF_Presentation_Show_Text_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Show_Text_Elements.ODF_Presentation_Show_Text_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Show_Text_Element));
   end Create_Presentation_Show_Text_Element;

   --------------------------------------
   -- Create_Presentation_Sound_Element --
   --------------------------------------

   overriding function Create_Presentation_Sound_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Presentation_Sound_Elements.ODF_Presentation_Sound_Element_Access is
   begin
      return
        ODF.DOM.Presentation_Sound_Elements.ODF_Presentation_Sound_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Presentation_URI,
            Matreshka.ODF_String_Constants.Presentation_Prefix,
            Matreshka.ODF_String_Constants.Sound_Element));
   end Create_Presentation_Sound_Element;

   --------------------------------------
   -- Create_Svg_Title_Element --
   --------------------------------------

   overriding function Create_Svg_Title_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Svg_Title_Elements.ODF_Svg_Title_Element_Access is
   begin
      return
        ODF.DOM.Svg_Title_Elements.ODF_Svg_Title_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Svg_URI,
            Matreshka.ODF_String_Constants.Svg_Prefix,
            Matreshka.ODF_String_Constants.Title_Element));
   end Create_Svg_Title_Element;

   --------------------------------------
   -- Create_Table_Movement_Element --
   --------------------------------------

   overriding function Create_Table_Movement_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Movement_Elements.ODF_Table_Movement_Element_Access is
   begin
      return
        ODF.DOM.Table_Movement_Elements.ODF_Table_Movement_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Movement_Element));
   end Create_Table_Movement_Element;

   --------------------------------------
   -- Create_Table_Movement_Cut_Off_Element --
   --------------------------------------

   overriding function Create_Table_Movement_Cut_Off_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Movement_Cut_Off_Elements.ODF_Table_Movement_Cut_Off_Element_Access is
   begin
      return
        ODF.DOM.Table_Movement_Cut_Off_Elements.ODF_Table_Movement_Cut_Off_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Movement_Cut_Off_Element));
   end Create_Table_Movement_Cut_Off_Element;

   --------------------------------------
   -- Create_Table_Named_Expression_Element --
   --------------------------------------

   overriding function Create_Table_Named_Expression_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Named_Expression_Elements.ODF_Table_Named_Expression_Element_Access is
   begin
      return
        ODF.DOM.Table_Named_Expression_Elements.ODF_Table_Named_Expression_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Named_Expression_Element));
   end Create_Table_Named_Expression_Element;

   --------------------------------------
   -- Create_Table_Named_Expressions_Element --
   --------------------------------------

   overriding function Create_Table_Named_Expressions_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Named_Expressions_Elements.ODF_Table_Named_Expressions_Element_Access is
   begin
      return
        ODF.DOM.Table_Named_Expressions_Elements.ODF_Table_Named_Expressions_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Named_Expressions_Element));
   end Create_Table_Named_Expressions_Element;

   --------------------------------------
   -- Create_Table_Named_Range_Element --
   --------------------------------------

   overriding function Create_Table_Named_Range_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Named_Range_Elements.ODF_Table_Named_Range_Element_Access is
   begin
      return
        ODF.DOM.Table_Named_Range_Elements.ODF_Table_Named_Range_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Named_Range_Element));
   end Create_Table_Named_Range_Element;

   --------------------------------------
   -- Create_Table_Null_Date_Element --
   --------------------------------------

   overriding function Create_Table_Null_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Null_Date_Elements.ODF_Table_Null_Date_Element_Access is
   begin
      return
        ODF.DOM.Table_Null_Date_Elements.ODF_Table_Null_Date_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Null_Date_Element));
   end Create_Table_Null_Date_Element;

   --------------------------------------
   -- Create_Table_Operation_Element --
   --------------------------------------

   overriding function Create_Table_Operation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Operation_Elements.ODF_Table_Operation_Element_Access is
   begin
      return
        ODF.DOM.Table_Operation_Elements.ODF_Table_Operation_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Operation_Element));
   end Create_Table_Operation_Element;

   --------------------------------------
   -- Create_Table_Previous_Element --
   --------------------------------------

   overriding function Create_Table_Previous_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Previous_Elements.ODF_Table_Previous_Element_Access is
   begin
      return
        ODF.DOM.Table_Previous_Elements.ODF_Table_Previous_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Previous_Element));
   end Create_Table_Previous_Element;

   --------------------------------------
   -- Create_Table_Scenario_Element --
   --------------------------------------

   overriding function Create_Table_Scenario_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Scenario_Elements.ODF_Table_Scenario_Element_Access is
   begin
      return
        ODF.DOM.Table_Scenario_Elements.ODF_Table_Scenario_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Scenario_Element));
   end Create_Table_Scenario_Element;

   --------------------------------------
   -- Create_Table_Shapes_Element --
   --------------------------------------

   overriding function Create_Table_Shapes_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Shapes_Elements.ODF_Table_Shapes_Element_Access is
   begin
      return
        ODF.DOM.Table_Shapes_Elements.ODF_Table_Shapes_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Shapes_Element));
   end Create_Table_Shapes_Element;

   --------------------------------------
   -- Create_Table_Sort_Element --
   --------------------------------------

   overriding function Create_Table_Sort_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Sort_Elements.ODF_Table_Sort_Element_Access is
   begin
      return
        ODF.DOM.Table_Sort_Elements.ODF_Table_Sort_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Sort_Element));
   end Create_Table_Sort_Element;

   --------------------------------------
   -- Create_Table_Sort_By_Element --
   --------------------------------------

   overriding function Create_Table_Sort_By_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Sort_By_Elements.ODF_Table_Sort_By_Element_Access is
   begin
      return
        ODF.DOM.Table_Sort_By_Elements.ODF_Table_Sort_By_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Sort_By_Element));
   end Create_Table_Sort_By_Element;

   --------------------------------------
   -- Create_Table_Sort_Groups_Element --
   --------------------------------------

   overriding function Create_Table_Sort_Groups_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Sort_Groups_Elements.ODF_Table_Sort_Groups_Element_Access is
   begin
      return
        ODF.DOM.Table_Sort_Groups_Elements.ODF_Table_Sort_Groups_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Sort_Groups_Element));
   end Create_Table_Sort_Groups_Element;

   --------------------------------------
   -- Create_Table_Source_Cell_Range_Element --
   --------------------------------------

   overriding function Create_Table_Source_Cell_Range_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Source_Cell_Range_Elements.ODF_Table_Source_Cell_Range_Element_Access is
   begin
      return
        ODF.DOM.Table_Source_Cell_Range_Elements.ODF_Table_Source_Cell_Range_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Source_Cell_Range_Element));
   end Create_Table_Source_Cell_Range_Element;

   --------------------------------------
   -- Create_Table_Source_Range_Address_Element --
   --------------------------------------

   overriding function Create_Table_Source_Range_Address_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Source_Range_Address_Elements.ODF_Table_Source_Range_Address_Element_Access is
   begin
      return
        ODF.DOM.Table_Source_Range_Address_Elements.ODF_Table_Source_Range_Address_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Source_Range_Address_Element));
   end Create_Table_Source_Range_Address_Element;

   --------------------------------------
   -- Create_Table_Source_Service_Element --
   --------------------------------------

   overriding function Create_Table_Source_Service_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Source_Service_Elements.ODF_Table_Source_Service_Element_Access is
   begin
      return
        ODF.DOM.Table_Source_Service_Elements.ODF_Table_Source_Service_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Source_Service_Element));
   end Create_Table_Source_Service_Element;

   --------------------------------------
   -- Create_Table_Subtotal_Field_Element --
   --------------------------------------

   overriding function Create_Table_Subtotal_Field_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Subtotal_Field_Elements.ODF_Table_Subtotal_Field_Element_Access is
   begin
      return
        ODF.DOM.Table_Subtotal_Field_Elements.ODF_Table_Subtotal_Field_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Subtotal_Field_Element));
   end Create_Table_Subtotal_Field_Element;

   --------------------------------------
   -- Create_Table_Subtotal_Rule_Element --
   --------------------------------------

   overriding function Create_Table_Subtotal_Rule_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Subtotal_Rule_Elements.ODF_Table_Subtotal_Rule_Element_Access is
   begin
      return
        ODF.DOM.Table_Subtotal_Rule_Elements.ODF_Table_Subtotal_Rule_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Subtotal_Rule_Element));
   end Create_Table_Subtotal_Rule_Element;

   --------------------------------------
   -- Create_Table_Subtotal_Rules_Element --
   --------------------------------------

   overriding function Create_Table_Subtotal_Rules_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Subtotal_Rules_Elements.ODF_Table_Subtotal_Rules_Element_Access is
   begin
      return
        ODF.DOM.Table_Subtotal_Rules_Elements.ODF_Table_Subtotal_Rules_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Subtotal_Rules_Element));
   end Create_Table_Subtotal_Rules_Element;

   --------------------------------------
   -- Create_Table_Table_Element --
   --------------------------------------

   overriding function Create_Table_Table_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Elements.ODF_Table_Table_Element_Access is
   begin
      return
        ODF.DOM.Table_Table_Elements.ODF_Table_Table_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Table_Element));
   end Create_Table_Table_Element;

   --------------------------------------
   -- Create_Table_Table_Cell_Element --
   --------------------------------------

   overriding function Create_Table_Table_Cell_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Cell_Elements.ODF_Table_Table_Cell_Element_Access is
   begin
      return
        ODF.DOM.Table_Table_Cell_Elements.ODF_Table_Table_Cell_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Table_Cell_Element));
   end Create_Table_Table_Cell_Element;

   --------------------------------------
   -- Create_Table_Table_Column_Element --
   --------------------------------------

   overriding function Create_Table_Table_Column_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Column_Elements.ODF_Table_Table_Column_Element_Access is
   begin
      return
        ODF.DOM.Table_Table_Column_Elements.ODF_Table_Table_Column_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Table_Column_Element));
   end Create_Table_Table_Column_Element;

   --------------------------------------
   -- Create_Table_Table_Column_Group_Element --
   --------------------------------------

   overriding function Create_Table_Table_Column_Group_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Column_Group_Elements.ODF_Table_Table_Column_Group_Element_Access is
   begin
      return
        ODF.DOM.Table_Table_Column_Group_Elements.ODF_Table_Table_Column_Group_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Table_Column_Group_Element));
   end Create_Table_Table_Column_Group_Element;

   --------------------------------------
   -- Create_Table_Table_Columns_Element --
   --------------------------------------

   overriding function Create_Table_Table_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Columns_Elements.ODF_Table_Table_Columns_Element_Access is
   begin
      return
        ODF.DOM.Table_Table_Columns_Elements.ODF_Table_Table_Columns_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Table_Columns_Element));
   end Create_Table_Table_Columns_Element;

   --------------------------------------
   -- Create_Table_Table_Header_Columns_Element --
   --------------------------------------

   overriding function Create_Table_Table_Header_Columns_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Header_Columns_Elements.ODF_Table_Table_Header_Columns_Element_Access is
   begin
      return
        ODF.DOM.Table_Table_Header_Columns_Elements.ODF_Table_Table_Header_Columns_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Table_Header_Columns_Element));
   end Create_Table_Table_Header_Columns_Element;

   --------------------------------------
   -- Create_Table_Table_Header_Rows_Element --
   --------------------------------------

   overriding function Create_Table_Table_Header_Rows_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Header_Rows_Elements.ODF_Table_Table_Header_Rows_Element_Access is
   begin
      return
        ODF.DOM.Table_Table_Header_Rows_Elements.ODF_Table_Table_Header_Rows_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Table_Header_Rows_Element));
   end Create_Table_Table_Header_Rows_Element;

   --------------------------------------
   -- Create_Table_Table_Row_Element --
   --------------------------------------

   overriding function Create_Table_Table_Row_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Row_Elements.ODF_Table_Table_Row_Element_Access is
   begin
      return
        ODF.DOM.Table_Table_Row_Elements.ODF_Table_Table_Row_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Table_Row_Element));
   end Create_Table_Table_Row_Element;

   --------------------------------------
   -- Create_Table_Table_Row_Group_Element --
   --------------------------------------

   overriding function Create_Table_Table_Row_Group_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Row_Group_Elements.ODF_Table_Table_Row_Group_Element_Access is
   begin
      return
        ODF.DOM.Table_Table_Row_Group_Elements.ODF_Table_Table_Row_Group_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Table_Row_Group_Element));
   end Create_Table_Table_Row_Group_Element;

   --------------------------------------
   -- Create_Table_Table_Rows_Element --
   --------------------------------------

   overriding function Create_Table_Table_Rows_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Rows_Elements.ODF_Table_Table_Rows_Element_Access is
   begin
      return
        ODF.DOM.Table_Table_Rows_Elements.ODF_Table_Table_Rows_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Table_Rows_Element));
   end Create_Table_Table_Rows_Element;

   --------------------------------------
   -- Create_Table_Table_Source_Element --
   --------------------------------------

   overriding function Create_Table_Table_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Table_Source_Elements.ODF_Table_Table_Source_Element_Access is
   begin
      return
        ODF.DOM.Table_Table_Source_Elements.ODF_Table_Table_Source_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Table_Source_Element));
   end Create_Table_Table_Source_Element;

   --------------------------------------
   -- Create_Table_Target_Range_Address_Element --
   --------------------------------------

   overriding function Create_Table_Target_Range_Address_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Target_Range_Address_Elements.ODF_Table_Target_Range_Address_Element_Access is
   begin
      return
        ODF.DOM.Table_Target_Range_Address_Elements.ODF_Table_Target_Range_Address_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Target_Range_Address_Element));
   end Create_Table_Target_Range_Address_Element;

   --------------------------------------
   -- Create_Table_Title_Element --
   --------------------------------------

   overriding function Create_Table_Title_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Title_Elements.ODF_Table_Title_Element_Access is
   begin
      return
        ODF.DOM.Table_Title_Elements.ODF_Table_Title_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Title_Element));
   end Create_Table_Title_Element;

   --------------------------------------
   -- Create_Table_Tracked_Changes_Element --
   --------------------------------------

   overriding function Create_Table_Tracked_Changes_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Table_Tracked_Changes_Elements.ODF_Table_Tracked_Changes_Element_Access is
   begin
      return
        ODF.DOM.Table_Tracked_Changes_Elements.ODF_Table_Tracked_Changes_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Table_URI,
            Matreshka.ODF_String_Constants.Table_Prefix,
            Matreshka.ODF_String_Constants.Tracked_Changes_Element));
   end Create_Table_Tracked_Changes_Element;

   --------------------------------------
   -- Create_Text_Meta_Element --
   --------------------------------------

   overriding function Create_Text_Meta_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Meta_Elements.ODF_Text_Meta_Element_Access is
   begin
      return
        ODF.DOM.Text_Meta_Elements.ODF_Text_Meta_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Meta_Element));
   end Create_Text_Meta_Element;

   --------------------------------------
   -- Create_Text_Meta_Field_Element --
   --------------------------------------

   overriding function Create_Text_Meta_Field_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Meta_Field_Elements.ODF_Text_Meta_Field_Element_Access is
   begin
      return
        ODF.DOM.Text_Meta_Field_Elements.ODF_Text_Meta_Field_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Meta_Field_Element));
   end Create_Text_Meta_Field_Element;

   --------------------------------------
   -- Create_Xforms_Model_Element --
   --------------------------------------

   overriding function Create_Xforms_Model_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Xforms_Model_Elements.ODF_Xforms_Model_Element_Access is
   begin
      return
        ODF.DOM.Xforms_Model_Elements.ODF_Xforms_Model_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Xforms_URI,
            Matreshka.ODF_String_Constants.Xforms_Prefix,
            Matreshka.ODF_String_Constants.Model_Element));
   end Create_Xforms_Model_Element;

   --------------------------------------
   -- Create_Text_Modification_Date_Element --
   --------------------------------------

   overriding function Create_Text_Modification_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Modification_Date_Elements.ODF_Text_Modification_Date_Element_Access is
   begin
      return
        ODF.DOM.Text_Modification_Date_Elements.ODF_Text_Modification_Date_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Modification_Date_Element));
   end Create_Text_Modification_Date_Element;

   --------------------------------------
   -- Create_Text_Modification_Time_Element --
   --------------------------------------

   overriding function Create_Text_Modification_Time_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Modification_Time_Elements.ODF_Text_Modification_Time_Element_Access is
   begin
      return
        ODF.DOM.Text_Modification_Time_Elements.ODF_Text_Modification_Time_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Modification_Time_Element));
   end Create_Text_Modification_Time_Element;

   --------------------------------------
   -- Create_Text_Note_Element --
   --------------------------------------

   overriding function Create_Text_Note_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Note_Elements.ODF_Text_Note_Element_Access is
   begin
      return
        ODF.DOM.Text_Note_Elements.ODF_Text_Note_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Note_Element));
   end Create_Text_Note_Element;

   --------------------------------------
   -- Create_Text_Note_Body_Element --
   --------------------------------------

   overriding function Create_Text_Note_Body_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Note_Body_Elements.ODF_Text_Note_Body_Element_Access is
   begin
      return
        ODF.DOM.Text_Note_Body_Elements.ODF_Text_Note_Body_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Note_Body_Element));
   end Create_Text_Note_Body_Element;

   --------------------------------------
   -- Create_Text_Note_Citation_Element --
   --------------------------------------

   overriding function Create_Text_Note_Citation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Note_Citation_Elements.ODF_Text_Note_Citation_Element_Access is
   begin
      return
        ODF.DOM.Text_Note_Citation_Elements.ODF_Text_Note_Citation_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Note_Citation_Element));
   end Create_Text_Note_Citation_Element;

   --------------------------------------
   -- Create_Text_Note_Continuation_Notice_Backward_Element --
   --------------------------------------

   overriding function Create_Text_Note_Continuation_Notice_Backward_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Note_Continuation_Notice_Backward_Elements.ODF_Text_Note_Continuation_Notice_Backward_Element_Access is
   begin
      return
        ODF.DOM.Text_Note_Continuation_Notice_Backward_Elements.ODF_Text_Note_Continuation_Notice_Backward_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Note_Continuation_Notice_Backward_Element));
   end Create_Text_Note_Continuation_Notice_Backward_Element;

   --------------------------------------
   -- Create_Text_Note_Continuation_Notice_Forward_Element --
   --------------------------------------

   overriding function Create_Text_Note_Continuation_Notice_Forward_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Note_Continuation_Notice_Forward_Elements.ODF_Text_Note_Continuation_Notice_Forward_Element_Access is
   begin
      return
        ODF.DOM.Text_Note_Continuation_Notice_Forward_Elements.ODF_Text_Note_Continuation_Notice_Forward_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Note_Continuation_Notice_Forward_Element));
   end Create_Text_Note_Continuation_Notice_Forward_Element;

   --------------------------------------
   -- Create_Text_Note_Ref_Element --
   --------------------------------------

   overriding function Create_Text_Note_Ref_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Note_Ref_Elements.ODF_Text_Note_Ref_Element_Access is
   begin
      return
        ODF.DOM.Text_Note_Ref_Elements.ODF_Text_Note_Ref_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Note_Ref_Element));
   end Create_Text_Note_Ref_Element;

   --------------------------------------
   -- Create_Text_Notes_Configuration_Element --
   --------------------------------------

   overriding function Create_Text_Notes_Configuration_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Notes_Configuration_Elements.ODF_Text_Notes_Configuration_Element_Access is
   begin
      return
        ODF.DOM.Text_Notes_Configuration_Elements.ODF_Text_Notes_Configuration_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Notes_Configuration_Element));
   end Create_Text_Notes_Configuration_Element;

   --------------------------------------
   -- Create_Text_Number_Element --
   --------------------------------------

   overriding function Create_Text_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Number_Elements.ODF_Text_Number_Element_Access is
   begin
      return
        ODF.DOM.Text_Number_Elements.ODF_Text_Number_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Number_Element));
   end Create_Text_Number_Element;

   --------------------------------------
   -- Create_Text_Numbered_Paragraph_Element --
   --------------------------------------

   overriding function Create_Text_Numbered_Paragraph_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Numbered_Paragraph_Elements.ODF_Text_Numbered_Paragraph_Element_Access is
   begin
      return
        ODF.DOM.Text_Numbered_Paragraph_Elements.ODF_Text_Numbered_Paragraph_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Numbered_Paragraph_Element));
   end Create_Text_Numbered_Paragraph_Element;

   --------------------------------------
   -- Create_Text_Object_Count_Element --
   --------------------------------------

   overriding function Create_Text_Object_Count_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Object_Count_Elements.ODF_Text_Object_Count_Element_Access is
   begin
      return
        ODF.DOM.Text_Object_Count_Elements.ODF_Text_Object_Count_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Object_Count_Element));
   end Create_Text_Object_Count_Element;

   --------------------------------------
   -- Create_Text_Object_Index_Element --
   --------------------------------------

   overriding function Create_Text_Object_Index_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Object_Index_Elements.ODF_Text_Object_Index_Element_Access is
   begin
      return
        ODF.DOM.Text_Object_Index_Elements.ODF_Text_Object_Index_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Object_Index_Element));
   end Create_Text_Object_Index_Element;

   --------------------------------------
   -- Create_Text_Object_Index_Entry_Template_Element --
   --------------------------------------

   overriding function Create_Text_Object_Index_Entry_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Object_Index_Entry_Template_Elements.ODF_Text_Object_Index_Entry_Template_Element_Access is
   begin
      return
        ODF.DOM.Text_Object_Index_Entry_Template_Elements.ODF_Text_Object_Index_Entry_Template_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Object_Index_Entry_Template_Element));
   end Create_Text_Object_Index_Entry_Template_Element;

   --------------------------------------
   -- Create_Text_Object_Index_Source_Element --
   --------------------------------------

   overriding function Create_Text_Object_Index_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Object_Index_Source_Elements.ODF_Text_Object_Index_Source_Element_Access is
   begin
      return
        ODF.DOM.Text_Object_Index_Source_Elements.ODF_Text_Object_Index_Source_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Object_Index_Source_Element));
   end Create_Text_Object_Index_Source_Element;

   --------------------------------------
   -- Create_Text_Outline_Level_Style_Element --
   --------------------------------------

   overriding function Create_Text_Outline_Level_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Outline_Level_Style_Elements.ODF_Text_Outline_Level_Style_Element_Access is
   begin
      return
        ODF.DOM.Text_Outline_Level_Style_Elements.ODF_Text_Outline_Level_Style_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Outline_Level_Style_Element));
   end Create_Text_Outline_Level_Style_Element;

   --------------------------------------
   -- Create_Text_Outline_Style_Element --
   --------------------------------------

   overriding function Create_Text_Outline_Style_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Outline_Style_Elements.ODF_Text_Outline_Style_Element_Access is
   begin
      return
        ODF.DOM.Text_Outline_Style_Elements.ODF_Text_Outline_Style_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Outline_Style_Element));
   end Create_Text_Outline_Style_Element;

   --------------------------------------
   -- Create_Text_P_Element --
   --------------------------------------

   overriding function Create_Text_P_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_P_Elements.ODF_Text_P_Element_Access is
   begin
      return
        ODF.DOM.Text_P_Elements.ODF_Text_P_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.P_Element));
   end Create_Text_P_Element;

   --------------------------------------
   -- Create_Text_Page_Element --
   --------------------------------------

   overriding function Create_Text_Page_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Page_Elements.ODF_Text_Page_Element_Access is
   begin
      return
        ODF.DOM.Text_Page_Elements.ODF_Text_Page_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Page_Element));
   end Create_Text_Page_Element;

   --------------------------------------
   -- Create_Text_Page_Continuation_Element --
   --------------------------------------

   overriding function Create_Text_Page_Continuation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Page_Continuation_Elements.ODF_Text_Page_Continuation_Element_Access is
   begin
      return
        ODF.DOM.Text_Page_Continuation_Elements.ODF_Text_Page_Continuation_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Page_Continuation_Element));
   end Create_Text_Page_Continuation_Element;

   --------------------------------------
   -- Create_Text_Page_Count_Element --
   --------------------------------------

   overriding function Create_Text_Page_Count_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Page_Count_Elements.ODF_Text_Page_Count_Element_Access is
   begin
      return
        ODF.DOM.Text_Page_Count_Elements.ODF_Text_Page_Count_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Page_Count_Element));
   end Create_Text_Page_Count_Element;

   --------------------------------------
   -- Create_Text_Page_Number_Element --
   --------------------------------------

   overriding function Create_Text_Page_Number_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Page_Number_Elements.ODF_Text_Page_Number_Element_Access is
   begin
      return
        ODF.DOM.Text_Page_Number_Elements.ODF_Text_Page_Number_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Page_Number_Element));
   end Create_Text_Page_Number_Element;

   --------------------------------------
   -- Create_Text_Page_Sequence_Element --
   --------------------------------------

   overriding function Create_Text_Page_Sequence_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Page_Sequence_Elements.ODF_Text_Page_Sequence_Element_Access is
   begin
      return
        ODF.DOM.Text_Page_Sequence_Elements.ODF_Text_Page_Sequence_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Page_Sequence_Element));
   end Create_Text_Page_Sequence_Element;

   --------------------------------------
   -- Create_Text_Page_Variable_Get_Element --
   --------------------------------------

   overriding function Create_Text_Page_Variable_Get_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Page_Variable_Get_Elements.ODF_Text_Page_Variable_Get_Element_Access is
   begin
      return
        ODF.DOM.Text_Page_Variable_Get_Elements.ODF_Text_Page_Variable_Get_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Page_Variable_Get_Element));
   end Create_Text_Page_Variable_Get_Element;

   --------------------------------------
   -- Create_Text_Page_Variable_Set_Element --
   --------------------------------------

   overriding function Create_Text_Page_Variable_Set_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Page_Variable_Set_Elements.ODF_Text_Page_Variable_Set_Element_Access is
   begin
      return
        ODF.DOM.Text_Page_Variable_Set_Elements.ODF_Text_Page_Variable_Set_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Page_Variable_Set_Element));
   end Create_Text_Page_Variable_Set_Element;

   --------------------------------------
   -- Create_Text_Paragraph_Count_Element --
   --------------------------------------

   overriding function Create_Text_Paragraph_Count_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Paragraph_Count_Elements.ODF_Text_Paragraph_Count_Element_Access is
   begin
      return
        ODF.DOM.Text_Paragraph_Count_Elements.ODF_Text_Paragraph_Count_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Paragraph_Count_Element));
   end Create_Text_Paragraph_Count_Element;

   --------------------------------------
   -- Create_Text_Placeholder_Element --
   --------------------------------------

   overriding function Create_Text_Placeholder_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Placeholder_Elements.ODF_Text_Placeholder_Element_Access is
   begin
      return
        ODF.DOM.Text_Placeholder_Elements.ODF_Text_Placeholder_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Placeholder_Element));
   end Create_Text_Placeholder_Element;

   --------------------------------------
   -- Create_Office_Presentation_Element --
   --------------------------------------

   overriding function Create_Office_Presentation_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Presentation_Elements.ODF_Office_Presentation_Element_Access is
   begin
      return
        ODF.DOM.Office_Presentation_Elements.ODF_Office_Presentation_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Presentation_Element));
   end Create_Office_Presentation_Element;

   --------------------------------------
   -- Create_Text_Print_Date_Element --
   --------------------------------------

   overriding function Create_Text_Print_Date_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Print_Date_Elements.ODF_Text_Print_Date_Element_Access is
   begin
      return
        ODF.DOM.Text_Print_Date_Elements.ODF_Text_Print_Date_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Print_Date_Element));
   end Create_Text_Print_Date_Element;

   --------------------------------------
   -- Create_Text_Print_Time_Element --
   --------------------------------------

   overriding function Create_Text_Print_Time_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Print_Time_Elements.ODF_Text_Print_Time_Element_Access is
   begin
      return
        ODF.DOM.Text_Print_Time_Elements.ODF_Text_Print_Time_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Print_Time_Element));
   end Create_Text_Print_Time_Element;

   --------------------------------------
   -- Create_Text_Printed_By_Element --
   --------------------------------------

   overriding function Create_Text_Printed_By_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Printed_By_Elements.ODF_Text_Printed_By_Element_Access is
   begin
      return
        ODF.DOM.Text_Printed_By_Elements.ODF_Text_Printed_By_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Printed_By_Element));
   end Create_Text_Printed_By_Element;

   --------------------------------------
   -- Create_Text_Reference_Mark_Element --
   --------------------------------------

   overriding function Create_Text_Reference_Mark_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Reference_Mark_Elements.ODF_Text_Reference_Mark_Element_Access is
   begin
      return
        ODF.DOM.Text_Reference_Mark_Elements.ODF_Text_Reference_Mark_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Reference_Mark_Element));
   end Create_Text_Reference_Mark_Element;

   --------------------------------------
   -- Create_Text_Reference_Mark_End_Element --
   --------------------------------------

   overriding function Create_Text_Reference_Mark_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Reference_Mark_End_Elements.ODF_Text_Reference_Mark_End_Element_Access is
   begin
      return
        ODF.DOM.Text_Reference_Mark_End_Elements.ODF_Text_Reference_Mark_End_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Reference_Mark_End_Element));
   end Create_Text_Reference_Mark_End_Element;

   --------------------------------------
   -- Create_Text_Reference_Mark_Start_Element --
   --------------------------------------

   overriding function Create_Text_Reference_Mark_Start_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Reference_Mark_Start_Elements.ODF_Text_Reference_Mark_Start_Element_Access is
   begin
      return
        ODF.DOM.Text_Reference_Mark_Start_Elements.ODF_Text_Reference_Mark_Start_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Reference_Mark_Start_Element));
   end Create_Text_Reference_Mark_Start_Element;

   --------------------------------------
   -- Create_Text_Reference_Ref_Element --
   --------------------------------------

   overriding function Create_Text_Reference_Ref_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Reference_Ref_Elements.ODF_Text_Reference_Ref_Element_Access is
   begin
      return
        ODF.DOM.Text_Reference_Ref_Elements.ODF_Text_Reference_Ref_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Reference_Ref_Element));
   end Create_Text_Reference_Ref_Element;

   --------------------------------------
   -- Create_Text_Ruby_Element --
   --------------------------------------

   overriding function Create_Text_Ruby_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Ruby_Elements.ODF_Text_Ruby_Element_Access is
   begin
      return
        ODF.DOM.Text_Ruby_Elements.ODF_Text_Ruby_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Ruby_Element));
   end Create_Text_Ruby_Element;

   --------------------------------------
   -- Create_Text_Ruby_Base_Element --
   --------------------------------------

   overriding function Create_Text_Ruby_Base_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Ruby_Base_Elements.ODF_Text_Ruby_Base_Element_Access is
   begin
      return
        ODF.DOM.Text_Ruby_Base_Elements.ODF_Text_Ruby_Base_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Ruby_Base_Element));
   end Create_Text_Ruby_Base_Element;

   --------------------------------------
   -- Create_Text_Ruby_Text_Element --
   --------------------------------------

   overriding function Create_Text_Ruby_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Ruby_Text_Elements.ODF_Text_Ruby_Text_Element_Access is
   begin
      return
        ODF.DOM.Text_Ruby_Text_Elements.ODF_Text_Ruby_Text_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Ruby_Text_Element));
   end Create_Text_Ruby_Text_Element;

   --------------------------------------
   -- Create_Text_S_Element --
   --------------------------------------

   overriding function Create_Text_S_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_S_Elements.ODF_Text_S_Element_Access is
   begin
      return
        ODF.DOM.Text_S_Elements.ODF_Text_S_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.S_Element));
   end Create_Text_S_Element;

   --------------------------------------
   -- Create_Office_Script_Element --
   --------------------------------------

   overriding function Create_Office_Script_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Script_Elements.ODF_Office_Script_Element_Access is
   begin
      return
        ODF.DOM.Office_Script_Elements.ODF_Office_Script_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Script_Element));
   end Create_Office_Script_Element;

   --------------------------------------
   -- Create_Text_Script_Element --
   --------------------------------------

   overriding function Create_Text_Script_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Script_Elements.ODF_Text_Script_Element_Access is
   begin
      return
        ODF.DOM.Text_Script_Elements.ODF_Text_Script_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Script_Element));
   end Create_Text_Script_Element;

   --------------------------------------
   -- Create_Office_Scripts_Element --
   --------------------------------------

   overriding function Create_Office_Scripts_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Scripts_Elements.ODF_Office_Scripts_Element_Access is
   begin
      return
        ODF.DOM.Office_Scripts_Elements.ODF_Office_Scripts_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Scripts_Element));
   end Create_Office_Scripts_Element;

   --------------------------------------
   -- Create_Text_Section_Element --
   --------------------------------------

   overriding function Create_Text_Section_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Section_Elements.ODF_Text_Section_Element_Access is
   begin
      return
        ODF.DOM.Text_Section_Elements.ODF_Text_Section_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Section_Element));
   end Create_Text_Section_Element;

   --------------------------------------
   -- Create_Text_Section_Source_Element --
   --------------------------------------

   overriding function Create_Text_Section_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Section_Source_Elements.ODF_Text_Section_Source_Element_Access is
   begin
      return
        ODF.DOM.Text_Section_Source_Elements.ODF_Text_Section_Source_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Section_Source_Element));
   end Create_Text_Section_Source_Element;

   --------------------------------------
   -- Create_Text_Sender_City_Element --
   --------------------------------------

   overriding function Create_Text_Sender_City_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_City_Elements.ODF_Text_Sender_City_Element_Access is
   begin
      return
        ODF.DOM.Text_Sender_City_Elements.ODF_Text_Sender_City_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sender_City_Element));
   end Create_Text_Sender_City_Element;

   --------------------------------------
   -- Create_Text_Sender_Company_Element --
   --------------------------------------

   overriding function Create_Text_Sender_Company_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Company_Elements.ODF_Text_Sender_Company_Element_Access is
   begin
      return
        ODF.DOM.Text_Sender_Company_Elements.ODF_Text_Sender_Company_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sender_Company_Element));
   end Create_Text_Sender_Company_Element;

   --------------------------------------
   -- Create_Text_Sender_Country_Element --
   --------------------------------------

   overriding function Create_Text_Sender_Country_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Country_Elements.ODF_Text_Sender_Country_Element_Access is
   begin
      return
        ODF.DOM.Text_Sender_Country_Elements.ODF_Text_Sender_Country_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sender_Country_Element));
   end Create_Text_Sender_Country_Element;

   --------------------------------------
   -- Create_Text_Sender_Email_Element --
   --------------------------------------

   overriding function Create_Text_Sender_Email_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Email_Elements.ODF_Text_Sender_Email_Element_Access is
   begin
      return
        ODF.DOM.Text_Sender_Email_Elements.ODF_Text_Sender_Email_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sender_Email_Element));
   end Create_Text_Sender_Email_Element;

   --------------------------------------
   -- Create_Text_Sender_Fax_Element --
   --------------------------------------

   overriding function Create_Text_Sender_Fax_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Fax_Elements.ODF_Text_Sender_Fax_Element_Access is
   begin
      return
        ODF.DOM.Text_Sender_Fax_Elements.ODF_Text_Sender_Fax_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sender_Fax_Element));
   end Create_Text_Sender_Fax_Element;

   --------------------------------------
   -- Create_Text_Sender_Firstname_Element --
   --------------------------------------

   overriding function Create_Text_Sender_Firstname_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Firstname_Elements.ODF_Text_Sender_Firstname_Element_Access is
   begin
      return
        ODF.DOM.Text_Sender_Firstname_Elements.ODF_Text_Sender_Firstname_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sender_Firstname_Element));
   end Create_Text_Sender_Firstname_Element;

   --------------------------------------
   -- Create_Text_Sender_Initials_Element --
   --------------------------------------

   overriding function Create_Text_Sender_Initials_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Initials_Elements.ODF_Text_Sender_Initials_Element_Access is
   begin
      return
        ODF.DOM.Text_Sender_Initials_Elements.ODF_Text_Sender_Initials_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sender_Initials_Element));
   end Create_Text_Sender_Initials_Element;

   --------------------------------------
   -- Create_Text_Sender_Lastname_Element --
   --------------------------------------

   overriding function Create_Text_Sender_Lastname_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Lastname_Elements.ODF_Text_Sender_Lastname_Element_Access is
   begin
      return
        ODF.DOM.Text_Sender_Lastname_Elements.ODF_Text_Sender_Lastname_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sender_Lastname_Element));
   end Create_Text_Sender_Lastname_Element;

   --------------------------------------
   -- Create_Text_Sender_Phone_Private_Element --
   --------------------------------------

   overriding function Create_Text_Sender_Phone_Private_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Phone_Private_Elements.ODF_Text_Sender_Phone_Private_Element_Access is
   begin
      return
        ODF.DOM.Text_Sender_Phone_Private_Elements.ODF_Text_Sender_Phone_Private_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sender_Phone_Private_Element));
   end Create_Text_Sender_Phone_Private_Element;

   --------------------------------------
   -- Create_Text_Sender_Phone_Work_Element --
   --------------------------------------

   overriding function Create_Text_Sender_Phone_Work_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Phone_Work_Elements.ODF_Text_Sender_Phone_Work_Element_Access is
   begin
      return
        ODF.DOM.Text_Sender_Phone_Work_Elements.ODF_Text_Sender_Phone_Work_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sender_Phone_Work_Element));
   end Create_Text_Sender_Phone_Work_Element;

   --------------------------------------
   -- Create_Text_Sender_Position_Element --
   --------------------------------------

   overriding function Create_Text_Sender_Position_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Position_Elements.ODF_Text_Sender_Position_Element_Access is
   begin
      return
        ODF.DOM.Text_Sender_Position_Elements.ODF_Text_Sender_Position_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sender_Position_Element));
   end Create_Text_Sender_Position_Element;

   --------------------------------------
   -- Create_Text_Sender_Postal_Code_Element --
   --------------------------------------

   overriding function Create_Text_Sender_Postal_Code_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Postal_Code_Elements.ODF_Text_Sender_Postal_Code_Element_Access is
   begin
      return
        ODF.DOM.Text_Sender_Postal_Code_Elements.ODF_Text_Sender_Postal_Code_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sender_Postal_Code_Element));
   end Create_Text_Sender_Postal_Code_Element;

   --------------------------------------
   -- Create_Text_Sender_State_Or_Province_Element --
   --------------------------------------

   overriding function Create_Text_Sender_State_Or_Province_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_State_Or_Province_Elements.ODF_Text_Sender_State_Or_Province_Element_Access is
   begin
      return
        ODF.DOM.Text_Sender_State_Or_Province_Elements.ODF_Text_Sender_State_Or_Province_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sender_State_Or_Province_Element));
   end Create_Text_Sender_State_Or_Province_Element;

   --------------------------------------
   -- Create_Text_Sender_Street_Element --
   --------------------------------------

   overriding function Create_Text_Sender_Street_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Street_Elements.ODF_Text_Sender_Street_Element_Access is
   begin
      return
        ODF.DOM.Text_Sender_Street_Elements.ODF_Text_Sender_Street_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sender_Street_Element));
   end Create_Text_Sender_Street_Element;

   --------------------------------------
   -- Create_Text_Sender_Title_Element --
   --------------------------------------

   overriding function Create_Text_Sender_Title_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sender_Title_Elements.ODF_Text_Sender_Title_Element_Access is
   begin
      return
        ODF.DOM.Text_Sender_Title_Elements.ODF_Text_Sender_Title_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sender_Title_Element));
   end Create_Text_Sender_Title_Element;

   --------------------------------------
   -- Create_Text_Sequence_Element --
   --------------------------------------

   overriding function Create_Text_Sequence_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sequence_Elements.ODF_Text_Sequence_Element_Access is
   begin
      return
        ODF.DOM.Text_Sequence_Elements.ODF_Text_Sequence_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sequence_Element));
   end Create_Text_Sequence_Element;

   --------------------------------------
   -- Create_Text_Sequence_Decl_Element --
   --------------------------------------

   overriding function Create_Text_Sequence_Decl_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sequence_Decl_Elements.ODF_Text_Sequence_Decl_Element_Access is
   begin
      return
        ODF.DOM.Text_Sequence_Decl_Elements.ODF_Text_Sequence_Decl_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sequence_Decl_Element));
   end Create_Text_Sequence_Decl_Element;

   --------------------------------------
   -- Create_Text_Sequence_Decls_Element --
   --------------------------------------

   overriding function Create_Text_Sequence_Decls_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sequence_Decls_Elements.ODF_Text_Sequence_Decls_Element_Access is
   begin
      return
        ODF.DOM.Text_Sequence_Decls_Elements.ODF_Text_Sequence_Decls_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sequence_Decls_Element));
   end Create_Text_Sequence_Decls_Element;

   --------------------------------------
   -- Create_Text_Sequence_Ref_Element --
   --------------------------------------

   overriding function Create_Text_Sequence_Ref_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sequence_Ref_Elements.ODF_Text_Sequence_Ref_Element_Access is
   begin
      return
        ODF.DOM.Text_Sequence_Ref_Elements.ODF_Text_Sequence_Ref_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sequence_Ref_Element));
   end Create_Text_Sequence_Ref_Element;

   --------------------------------------
   -- Create_Office_Settings_Element --
   --------------------------------------

   overriding function Create_Office_Settings_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Settings_Elements.ODF_Office_Settings_Element_Access is
   begin
      return
        ODF.DOM.Office_Settings_Elements.ODF_Office_Settings_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Settings_Element));
   end Create_Office_Settings_Element;

   --------------------------------------
   -- Create_Text_Sheet_Name_Element --
   --------------------------------------

   overriding function Create_Text_Sheet_Name_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sheet_Name_Elements.ODF_Text_Sheet_Name_Element_Access is
   begin
      return
        ODF.DOM.Text_Sheet_Name_Elements.ODF_Text_Sheet_Name_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sheet_Name_Element));
   end Create_Text_Sheet_Name_Element;

   --------------------------------------
   -- Create_Text_Soft_Page_Break_Element --
   --------------------------------------

   overriding function Create_Text_Soft_Page_Break_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Soft_Page_Break_Elements.ODF_Text_Soft_Page_Break_Element_Access is
   begin
      return
        ODF.DOM.Text_Soft_Page_Break_Elements.ODF_Text_Soft_Page_Break_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Soft_Page_Break_Element));
   end Create_Text_Soft_Page_Break_Element;

   --------------------------------------
   -- Create_Text_Sort_Key_Element --
   --------------------------------------

   overriding function Create_Text_Sort_Key_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Sort_Key_Elements.ODF_Text_Sort_Key_Element_Access is
   begin
      return
        ODF.DOM.Text_Sort_Key_Elements.ODF_Text_Sort_Key_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Sort_Key_Element));
   end Create_Text_Sort_Key_Element;

   --------------------------------------
   -- Create_Text_Span_Element --
   --------------------------------------

   overriding function Create_Text_Span_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Span_Elements.ODF_Text_Span_Element_Access is
   begin
      return
        ODF.DOM.Text_Span_Elements.ODF_Text_Span_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Span_Element));
   end Create_Text_Span_Element;

   --------------------------------------
   -- Create_Office_Spreadsheet_Element --
   --------------------------------------

   overriding function Create_Office_Spreadsheet_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Spreadsheet_Elements.ODF_Office_Spreadsheet_Element_Access is
   begin
      return
        ODF.DOM.Office_Spreadsheet_Elements.ODF_Office_Spreadsheet_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Spreadsheet_Element));
   end Create_Office_Spreadsheet_Element;

   --------------------------------------
   -- Create_Office_Styles_Element --
   --------------------------------------

   overriding function Create_Office_Styles_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Styles_Elements.ODF_Office_Styles_Element_Access is
   begin
      return
        ODF.DOM.Office_Styles_Elements.ODF_Office_Styles_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Styles_Element));
   end Create_Office_Styles_Element;

   --------------------------------------
   -- Create_Text_Subject_Element --
   --------------------------------------

   overriding function Create_Text_Subject_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Subject_Elements.ODF_Text_Subject_Element_Access is
   begin
      return
        ODF.DOM.Text_Subject_Elements.ODF_Text_Subject_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Subject_Element));
   end Create_Text_Subject_Element;

   --------------------------------------
   -- Create_Text_Tab_Element --
   --------------------------------------

   overriding function Create_Text_Tab_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Tab_Elements.ODF_Text_Tab_Element_Access is
   begin
      return
        ODF.DOM.Text_Tab_Elements.ODF_Text_Tab_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Tab_Element));
   end Create_Text_Tab_Element;

   --------------------------------------
   -- Create_Text_Table_Count_Element --
   --------------------------------------

   overriding function Create_Text_Table_Count_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Count_Elements.ODF_Text_Table_Count_Element_Access is
   begin
      return
        ODF.DOM.Text_Table_Count_Elements.ODF_Text_Table_Count_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Table_Count_Element));
   end Create_Text_Table_Count_Element;

   --------------------------------------
   -- Create_Text_Table_Formula_Element --
   --------------------------------------

   overriding function Create_Text_Table_Formula_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Formula_Elements.ODF_Text_Table_Formula_Element_Access is
   begin
      return
        ODF.DOM.Text_Table_Formula_Elements.ODF_Text_Table_Formula_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Table_Formula_Element));
   end Create_Text_Table_Formula_Element;

   --------------------------------------
   -- Create_Text_Table_Index_Element --
   --------------------------------------

   overriding function Create_Text_Table_Index_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Index_Elements.ODF_Text_Table_Index_Element_Access is
   begin
      return
        ODF.DOM.Text_Table_Index_Elements.ODF_Text_Table_Index_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Table_Index_Element));
   end Create_Text_Table_Index_Element;

   --------------------------------------
   -- Create_Text_Table_Index_Entry_Template_Element --
   --------------------------------------

   overriding function Create_Text_Table_Index_Entry_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Index_Entry_Template_Elements.ODF_Text_Table_Index_Entry_Template_Element_Access is
   begin
      return
        ODF.DOM.Text_Table_Index_Entry_Template_Elements.ODF_Text_Table_Index_Entry_Template_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Table_Index_Entry_Template_Element));
   end Create_Text_Table_Index_Entry_Template_Element;

   --------------------------------------
   -- Create_Text_Table_Index_Source_Element --
   --------------------------------------

   overriding function Create_Text_Table_Index_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Index_Source_Elements.ODF_Text_Table_Index_Source_Element_Access is
   begin
      return
        ODF.DOM.Text_Table_Index_Source_Elements.ODF_Text_Table_Index_Source_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Table_Index_Source_Element));
   end Create_Text_Table_Index_Source_Element;

   --------------------------------------
   -- Create_Text_Table_Of_Content_Element --
   --------------------------------------

   overriding function Create_Text_Table_Of_Content_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Of_Content_Elements.ODF_Text_Table_Of_Content_Element_Access is
   begin
      return
        ODF.DOM.Text_Table_Of_Content_Elements.ODF_Text_Table_Of_Content_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Table_Of_Content_Element));
   end Create_Text_Table_Of_Content_Element;

   --------------------------------------
   -- Create_Text_Table_Of_Content_Entry_Template_Element --
   --------------------------------------

   overriding function Create_Text_Table_Of_Content_Entry_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Of_Content_Entry_Template_Elements.ODF_Text_Table_Of_Content_Entry_Template_Element_Access is
   begin
      return
        ODF.DOM.Text_Table_Of_Content_Entry_Template_Elements.ODF_Text_Table_Of_Content_Entry_Template_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Table_Of_Content_Entry_Template_Element));
   end Create_Text_Table_Of_Content_Entry_Template_Element;

   --------------------------------------
   -- Create_Text_Table_Of_Content_Source_Element --
   --------------------------------------

   overriding function Create_Text_Table_Of_Content_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Table_Of_Content_Source_Elements.ODF_Text_Table_Of_Content_Source_Element_Access is
   begin
      return
        ODF.DOM.Text_Table_Of_Content_Source_Elements.ODF_Text_Table_Of_Content_Source_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Table_Of_Content_Source_Element));
   end Create_Text_Table_Of_Content_Source_Element;

   --------------------------------------
   -- Create_Text_Template_Name_Element --
   --------------------------------------

   overriding function Create_Text_Template_Name_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Template_Name_Elements.ODF_Text_Template_Name_Element_Access is
   begin
      return
        ODF.DOM.Text_Template_Name_Elements.ODF_Text_Template_Name_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Template_Name_Element));
   end Create_Text_Template_Name_Element;

   --------------------------------------
   -- Create_Office_Text_Element --
   --------------------------------------

   overriding function Create_Office_Text_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Office_Text_Elements.ODF_Office_Text_Element_Access is
   begin
      return
        ODF.DOM.Office_Text_Elements.ODF_Office_Text_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Office_URI,
            Matreshka.ODF_String_Constants.Office_Prefix,
            Matreshka.ODF_String_Constants.Text_Element));
   end Create_Office_Text_Element;

   --------------------------------------
   -- Create_Text_Text_Input_Element --
   --------------------------------------

   overriding function Create_Text_Text_Input_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Text_Input_Elements.ODF_Text_Text_Input_Element_Access is
   begin
      return
        ODF.DOM.Text_Text_Input_Elements.ODF_Text_Text_Input_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Text_Input_Element));
   end Create_Text_Text_Input_Element;

   --------------------------------------
   -- Create_Text_Time_Element --
   --------------------------------------

   overriding function Create_Text_Time_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Time_Elements.ODF_Text_Time_Element_Access is
   begin
      return
        ODF.DOM.Text_Time_Elements.ODF_Text_Time_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Time_Element));
   end Create_Text_Time_Element;

   --------------------------------------
   -- Create_Text_Title_Element --
   --------------------------------------

   overriding function Create_Text_Title_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Title_Elements.ODF_Text_Title_Element_Access is
   begin
      return
        ODF.DOM.Text_Title_Elements.ODF_Text_Title_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Title_Element));
   end Create_Text_Title_Element;

   --------------------------------------
   -- Create_Text_Toc_Mark_Element --
   --------------------------------------

   overriding function Create_Text_Toc_Mark_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Toc_Mark_Elements.ODF_Text_Toc_Mark_Element_Access is
   begin
      return
        ODF.DOM.Text_Toc_Mark_Elements.ODF_Text_Toc_Mark_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Toc_Mark_Element));
   end Create_Text_Toc_Mark_Element;

   --------------------------------------
   -- Create_Text_Toc_Mark_End_Element --
   --------------------------------------

   overriding function Create_Text_Toc_Mark_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Toc_Mark_End_Elements.ODF_Text_Toc_Mark_End_Element_Access is
   begin
      return
        ODF.DOM.Text_Toc_Mark_End_Elements.ODF_Text_Toc_Mark_End_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Toc_Mark_End_Element));
   end Create_Text_Toc_Mark_End_Element;

   --------------------------------------
   -- Create_Text_Toc_Mark_Start_Element --
   --------------------------------------

   overriding function Create_Text_Toc_Mark_Start_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Toc_Mark_Start_Elements.ODF_Text_Toc_Mark_Start_Element_Access is
   begin
      return
        ODF.DOM.Text_Toc_Mark_Start_Elements.ODF_Text_Toc_Mark_Start_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Toc_Mark_Start_Element));
   end Create_Text_Toc_Mark_Start_Element;

   --------------------------------------
   -- Create_Text_Tracked_Changes_Element --
   --------------------------------------

   overriding function Create_Text_Tracked_Changes_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Tracked_Changes_Elements.ODF_Text_Tracked_Changes_Element_Access is
   begin
      return
        ODF.DOM.Text_Tracked_Changes_Elements.ODF_Text_Tracked_Changes_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Tracked_Changes_Element));
   end Create_Text_Tracked_Changes_Element;

   --------------------------------------
   -- Create_Text_User_Defined_Element --
   --------------------------------------

   overriding function Create_Text_User_Defined_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Defined_Elements.ODF_Text_User_Defined_Element_Access is
   begin
      return
        ODF.DOM.Text_User_Defined_Elements.ODF_Text_User_Defined_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.User_Defined_Element));
   end Create_Text_User_Defined_Element;

   --------------------------------------
   -- Create_Text_User_Field_Decl_Element --
   --------------------------------------

   overriding function Create_Text_User_Field_Decl_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Field_Decl_Elements.ODF_Text_User_Field_Decl_Element_Access is
   begin
      return
        ODF.DOM.Text_User_Field_Decl_Elements.ODF_Text_User_Field_Decl_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.User_Field_Decl_Element));
   end Create_Text_User_Field_Decl_Element;

   --------------------------------------
   -- Create_Text_User_Field_Decls_Element --
   --------------------------------------

   overriding function Create_Text_User_Field_Decls_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Field_Decls_Elements.ODF_Text_User_Field_Decls_Element_Access is
   begin
      return
        ODF.DOM.Text_User_Field_Decls_Elements.ODF_Text_User_Field_Decls_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.User_Field_Decls_Element));
   end Create_Text_User_Field_Decls_Element;

   --------------------------------------
   -- Create_Text_User_Field_Get_Element --
   --------------------------------------

   overriding function Create_Text_User_Field_Get_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Field_Get_Elements.ODF_Text_User_Field_Get_Element_Access is
   begin
      return
        ODF.DOM.Text_User_Field_Get_Elements.ODF_Text_User_Field_Get_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.User_Field_Get_Element));
   end Create_Text_User_Field_Get_Element;

   --------------------------------------
   -- Create_Text_User_Field_Input_Element --
   --------------------------------------

   overriding function Create_Text_User_Field_Input_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Field_Input_Elements.ODF_Text_User_Field_Input_Element_Access is
   begin
      return
        ODF.DOM.Text_User_Field_Input_Elements.ODF_Text_User_Field_Input_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.User_Field_Input_Element));
   end Create_Text_User_Field_Input_Element;

   --------------------------------------
   -- Create_Text_User_Index_Element --
   --------------------------------------

   overriding function Create_Text_User_Index_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Index_Elements.ODF_Text_User_Index_Element_Access is
   begin
      return
        ODF.DOM.Text_User_Index_Elements.ODF_Text_User_Index_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.User_Index_Element));
   end Create_Text_User_Index_Element;

   --------------------------------------
   -- Create_Text_User_Index_Entry_Template_Element --
   --------------------------------------

   overriding function Create_Text_User_Index_Entry_Template_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Index_Entry_Template_Elements.ODF_Text_User_Index_Entry_Template_Element_Access is
   begin
      return
        ODF.DOM.Text_User_Index_Entry_Template_Elements.ODF_Text_User_Index_Entry_Template_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.User_Index_Entry_Template_Element));
   end Create_Text_User_Index_Entry_Template_Element;

   --------------------------------------
   -- Create_Text_User_Index_Mark_Element --
   --------------------------------------

   overriding function Create_Text_User_Index_Mark_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Index_Mark_Elements.ODF_Text_User_Index_Mark_Element_Access is
   begin
      return
        ODF.DOM.Text_User_Index_Mark_Elements.ODF_Text_User_Index_Mark_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.User_Index_Mark_Element));
   end Create_Text_User_Index_Mark_Element;

   --------------------------------------
   -- Create_Text_User_Index_Mark_End_Element --
   --------------------------------------

   overriding function Create_Text_User_Index_Mark_End_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Index_Mark_End_Elements.ODF_Text_User_Index_Mark_End_Element_Access is
   begin
      return
        ODF.DOM.Text_User_Index_Mark_End_Elements.ODF_Text_User_Index_Mark_End_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.User_Index_Mark_End_Element));
   end Create_Text_User_Index_Mark_End_Element;

   --------------------------------------
   -- Create_Text_User_Index_Mark_Start_Element --
   --------------------------------------

   overriding function Create_Text_User_Index_Mark_Start_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Index_Mark_Start_Elements.ODF_Text_User_Index_Mark_Start_Element_Access is
   begin
      return
        ODF.DOM.Text_User_Index_Mark_Start_Elements.ODF_Text_User_Index_Mark_Start_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.User_Index_Mark_Start_Element));
   end Create_Text_User_Index_Mark_Start_Element;

   --------------------------------------
   -- Create_Text_User_Index_Source_Element --
   --------------------------------------

   overriding function Create_Text_User_Index_Source_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_User_Index_Source_Elements.ODF_Text_User_Index_Source_Element_Access is
   begin
      return
        ODF.DOM.Text_User_Index_Source_Elements.ODF_Text_User_Index_Source_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.User_Index_Source_Element));
   end Create_Text_User_Index_Source_Element;

   --------------------------------------
   -- Create_Text_Variable_Decl_Element --
   --------------------------------------

   overriding function Create_Text_Variable_Decl_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Variable_Decl_Elements.ODF_Text_Variable_Decl_Element_Access is
   begin
      return
        ODF.DOM.Text_Variable_Decl_Elements.ODF_Text_Variable_Decl_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Variable_Decl_Element));
   end Create_Text_Variable_Decl_Element;

   --------------------------------------
   -- Create_Text_Variable_Decls_Element --
   --------------------------------------

   overriding function Create_Text_Variable_Decls_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Variable_Decls_Elements.ODF_Text_Variable_Decls_Element_Access is
   begin
      return
        ODF.DOM.Text_Variable_Decls_Elements.ODF_Text_Variable_Decls_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Variable_Decls_Element));
   end Create_Text_Variable_Decls_Element;

   --------------------------------------
   -- Create_Text_Variable_Get_Element --
   --------------------------------------

   overriding function Create_Text_Variable_Get_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Variable_Get_Elements.ODF_Text_Variable_Get_Element_Access is
   begin
      return
        ODF.DOM.Text_Variable_Get_Elements.ODF_Text_Variable_Get_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Variable_Get_Element));
   end Create_Text_Variable_Get_Element;

   --------------------------------------
   -- Create_Text_Variable_Input_Element --
   --------------------------------------

   overriding function Create_Text_Variable_Input_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Variable_Input_Elements.ODF_Text_Variable_Input_Element_Access is
   begin
      return
        ODF.DOM.Text_Variable_Input_Elements.ODF_Text_Variable_Input_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Variable_Input_Element));
   end Create_Text_Variable_Input_Element;

   --------------------------------------
   -- Create_Text_Variable_Set_Element --
   --------------------------------------

   overriding function Create_Text_Variable_Set_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Variable_Set_Elements.ODF_Text_Variable_Set_Element_Access is
   begin
      return
        ODF.DOM.Text_Variable_Set_Elements.ODF_Text_Variable_Set_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Variable_Set_Element));
   end Create_Text_Variable_Set_Element;

   --------------------------------------
   -- Create_Text_Word_Count_Element --
   --------------------------------------

   overriding function Create_Text_Word_Count_Element
    (Self : not null access Document_Node)
       return not null ODF.DOM.Text_Word_Count_Elements.ODF_Text_Word_Count_Element_Access is
   begin
      return
        ODF.DOM.Text_Word_Count_Elements.ODF_Text_Word_Count_Element_Access
         (Self.Create_Element
           (Matreshka.ODF_String_Constants.Text_URI,
            Matreshka.ODF_String_Constants.Text_Prefix,
            Matreshka.ODF_String_Constants.Word_Count_Element));
   end Create_Text_Word_Count_Element;

end Matreshka.ODF_Documents;
