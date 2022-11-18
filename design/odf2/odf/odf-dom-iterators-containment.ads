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

package ODF.DOM.Iterators.Containment is

   pragma Preelaborate;

   type ODF_Containment_Iterator is
     limited new ODF.DOM.Iterators.Abstract_ODF_Iterator with private;

private

   type ODF_Containment_Iterator is
     limited new ODF.DOM.Iterators.Abstract_ODF_Iterator with null record;

   overriding procedure Visit_Number_Am_Pm
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Am_Pm_Elements.ODF_Number_Am_Pm_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Anim_Animate
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Anim_Animate_Elements.ODF_Anim_Animate_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Anim_AnimateColor
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Anim_AnimateColor_Elements.ODF_Anim_AnimateColor_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Anim_AnimateMotion
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Anim_AnimateMotion_Elements.ODF_Anim_AnimateMotion_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Anim_AnimateTransform
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Anim_AnimateTransform_Elements.ODF_Anim_AnimateTransform_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Anim_Audio
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Anim_Audio_Elements.ODF_Anim_Audio_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Anim_Command
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Anim_Command_Elements.ODF_Anim_Command_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Anim_Iterate
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Anim_Iterate_Elements.ODF_Anim_Iterate_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Anim_Par
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Anim_Par_Elements.ODF_Anim_Par_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Anim_Param
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Anim_Param_Elements.ODF_Anim_Param_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Anim_Seq
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Anim_Seq_Elements.ODF_Anim_Seq_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Anim_Set
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Anim_Set_Elements.ODF_Anim_Set_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Anim_TransitionFilter
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Anim_TransitionFilter_Elements.ODF_Anim_TransitionFilter_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Annotation
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Annotation_Elements.ODF_Office_Annotation_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Annotation_End
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Annotation_End_Elements.ODF_Office_Annotation_End_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Application_Connection_Settings
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Application_Connection_Settings_Elements.ODF_Db_Application_Connection_Settings_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Auto_Increment
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Auto_Increment_Elements.ODF_Db_Auto_Increment_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Axis
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Axis_Elements.ODF_Chart_Axis_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Boolean
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Boolean_Elements.ODF_Number_Boolean_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Boolean_Style
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Boolean_Style_Elements.ODF_Number_Boolean_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Button
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Button_Elements.ODF_Form_Button_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Categories
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Categories_Elements.ODF_Chart_Categories_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Character_Set
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Character_Set_Elements.ODF_Db_Character_Set_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Chart
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Chart_Elements.ODF_Chart_Chart_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Checkbox
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Checkbox_Elements.ODF_Form_Checkbox_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Column
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Column_Elements.ODF_Db_Column_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Column
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Column_Elements.ODF_Form_Column_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Column_Definition
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Column_Definition_Elements.ODF_Db_Column_Definition_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Column_Definitions
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Column_Definitions_Elements.ODF_Db_Column_Definitions_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Columns
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Columns_Elements.ODF_Db_Columns_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Combobox
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Combobox_Elements.ODF_Form_Combobox_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Component
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Component_Elements.ODF_Db_Component_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Component_Collection
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Component_Collection_Elements.ODF_Db_Component_Collection_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Data_Label
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Data_Label_Elements.ODF_Chart_Data_Label_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Data_Point
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Data_Point_Elements.ODF_Chart_Data_Point_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Domain
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Domain_Elements.ODF_Chart_Domain_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Equation
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Equation_Elements.ODF_Chart_Equation_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Error_Indicator
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Error_Indicator_Elements.ODF_Chart_Error_Indicator_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Floor
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Floor_Elements.ODF_Chart_Floor_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Footer
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Footer_Elements.ODF_Chart_Footer_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Grid
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Grid_Elements.ODF_Chart_Grid_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Label_Separator
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Label_Separator_Elements.ODF_Chart_Label_Separator_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Legend
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Legend_Elements.ODF_Chart_Legend_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Mean_Value
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Mean_Value_Elements.ODF_Chart_Mean_Value_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Plot_Area
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Plot_Area_Elements.ODF_Chart_Plot_Area_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Regression_Curve
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Regression_Curve_Elements.ODF_Chart_Regression_Curve_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Series
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Series_Elements.ODF_Chart_Series_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Stock_Gain_Marker
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Stock_Gain_Marker_Elements.ODF_Chart_Stock_Gain_Marker_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Stock_Loss_Marker
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Stock_Loss_Marker_Elements.ODF_Chart_Stock_Loss_Marker_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Stock_Range_Line
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Stock_Range_Line_Elements.ODF_Chart_Stock_Range_Line_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Subtitle
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Subtitle_Elements.ODF_Chart_Subtitle_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Symbol_Image
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Symbol_Image_Elements.ODF_Chart_Symbol_Image_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Title
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Title_Elements.ODF_Chart_Title_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Chart_Wall
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Chart_Wall_Elements.ODF_Chart_Wall_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_A
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_A_Elements.ODF_Draw_A_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Animation_Group
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Animation_Group_Elements.ODF_Presentation_Animation_Group_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Animations
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Animations_Elements.ODF_Presentation_Animations_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Applet
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Applet_Elements.ODF_Draw_Applet_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Area_Circle
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Area_Circle_Elements.ODF_Draw_Area_Circle_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Area_Polygon
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Area_Polygon_Elements.ODF_Draw_Area_Polygon_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Area_Rectangle
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Area_Rectangle_Elements.ODF_Draw_Area_Rectangle_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Caption
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Caption_Elements.ODF_Draw_Caption_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Circle
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Circle_Elements.ODF_Draw_Circle_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_A
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_A_Elements.ODF_Text_A_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Alphabetical_Index
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Alphabetical_Index_Elements.ODF_Text_Alphabetical_Index_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Alphabetical_Index_Auto_Mark_File
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Alphabetical_Index_Auto_Mark_File_Elements.ODF_Text_Alphabetical_Index_Auto_Mark_File_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Alphabetical_Index_Entry_Template
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Alphabetical_Index_Entry_Template_Elements.ODF_Text_Alphabetical_Index_Entry_Template_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Alphabetical_Index_Mark
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Alphabetical_Index_Mark_Elements.ODF_Text_Alphabetical_Index_Mark_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Alphabetical_Index_Mark_End
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Alphabetical_Index_Mark_End_Elements.ODF_Text_Alphabetical_Index_Mark_End_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Alphabetical_Index_Mark_Start
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Alphabetical_Index_Mark_Start_Elements.ODF_Text_Alphabetical_Index_Mark_Start_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Alphabetical_Index_Source
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Alphabetical_Index_Source_Elements.ODF_Text_Alphabetical_Index_Source_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Author_Initials
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Author_Initials_Elements.ODF_Text_Author_Initials_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Author_Name
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Author_Name_Elements.ODF_Text_Author_Name_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Meta_Auto_Reload
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Meta_Auto_Reload_Elements.ODF_Meta_Auto_Reload_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Automatic_Styles
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Automatic_Styles_Elements.ODF_Office_Automatic_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Background_Image
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Background_Image_Elements.ODF_Style_Background_Image_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Chart_Properties
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Chart_Properties_Elements.ODF_Style_Chart_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Column
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Column_Elements.ODF_Style_Column_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Column_Sep
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Column_Sep_Elements.ODF_Style_Column_Sep_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Columns
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Columns_Elements.ODF_Style_Columns_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Background
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Background_Elements.ODF_Table_Background_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Bibliography_Configuration
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Bibliography_Configuration_Elements.ODF_Text_Bibliography_Configuration_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Binary_Data
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Binary_Data_Elements.ODF_Office_Binary_Data_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Body
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Body_Elements.ODF_Table_Body_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Calculation_Settings
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Calculation_Settings_Elements.ODF_Table_Calculation_Settings_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Cell_Address
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Cell_Address_Elements.ODF_Table_Cell_Address_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Cell_Content_Change
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Cell_Content_Change_Elements.ODF_Table_Cell_Content_Change_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Cell_Content_Deletion
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Cell_Content_Deletion_Elements.ODF_Table_Cell_Content_Deletion_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Cell_Range_Source
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Cell_Range_Source_Elements.ODF_Table_Cell_Range_Source_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Change_Deletion
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Change_Deletion_Elements.ODF_Table_Change_Deletion_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Change_Track_Table_Cell
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Change_Track_Table_Cell_Elements.ODF_Table_Change_Track_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Bibliography
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Bibliography_Elements.ODF_Text_Bibliography_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Bibliography_Entry_Template
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Bibliography_Entry_Template_Elements.ODF_Text_Bibliography_Entry_Template_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Bibliography_Mark
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Bibliography_Mark_Elements.ODF_Text_Bibliography_Mark_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Bibliography_Source
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Bibliography_Source_Elements.ODF_Text_Bibliography_Source_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Bookmark
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Bookmark_Elements.ODF_Text_Bookmark_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Bookmark_End
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Bookmark_End_Elements.ODF_Text_Bookmark_End_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Bookmark_Ref
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Bookmark_Ref_Elements.ODF_Text_Bookmark_Ref_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Bookmark_Start
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Bookmark_Start_Elements.ODF_Text_Bookmark_Start_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Change
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Change_Elements.ODF_Text_Change_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Change_End
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Change_End_Elements.ODF_Text_Change_End_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Change_Info
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Change_Info_Elements.ODF_Office_Change_Info_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Change_Start
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Change_Start_Elements.ODF_Text_Change_Start_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Changed_Region
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Changed_Region_Elements.ODF_Text_Changed_Region_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Chapter
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Chapter_Elements.ODF_Text_Chapter_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Character_Count
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Character_Count_Elements.ODF_Text_Character_Count_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Conditional_Text
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Conditional_Text_Elements.ODF_Text_Conditional_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Config_Config_Item
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Config_Config_Item_Elements.ODF_Config_Config_Item_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Config_Config_Item_Map_Entry
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Config_Config_Item_Map_Entry_Elements.ODF_Config_Config_Item_Map_Entry_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Config_Config_Item_Map_Indexed
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Config_Config_Item_Map_Indexed_Elements.ODF_Config_Config_Item_Map_Indexed_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Config_Config_Item_Map_Named
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Config_Config_Item_Map_Named_Elements.ODF_Config_Config_Item_Map_Named_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Config_Config_Item_Set
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Config_Config_Item_Set_Elements.ODF_Config_Config_Item_Set_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Connection_Data
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Connection_Data_Elements.ODF_Db_Connection_Data_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Connection_Resource
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Connection_Resource_Elements.ODF_Db_Connection_Resource_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Data_Source
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Data_Source_Elements.ODF_Db_Data_Source_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Data_Source_Setting
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Data_Source_Setting_Elements.ODF_Db_Data_Source_Setting_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Data_Source_Setting_Value
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Data_Source_Setting_Value_Elements.ODF_Db_Data_Source_Setting_Value_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Data_Source_Settings
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Data_Source_Settings_Elements.ODF_Db_Data_Source_Settings_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Database_Description
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Database_Description_Elements.ODF_Db_Database_Description_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Delimiter
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Delimiter_Elements.ODF_Db_Delimiter_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Driver_Settings
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Driver_Settings_Elements.ODF_Db_Driver_Settings_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_File_Based_Database
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_File_Based_Database_Elements.ODF_Db_File_Based_Database_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Fill_Image
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Fill_Image_Elements.ODF_Draw_Fill_Image_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Filter_Statement
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Filter_Statement_Elements.ODF_Db_Filter_Statement_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Forms
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Forms_Elements.ODF_Db_Forms_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Index
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Index_Elements.ODF_Db_Index_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Index_Column
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Index_Column_Elements.ODF_Db_Index_Column_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Index_Columns
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Index_Columns_Elements.ODF_Db_Index_Columns_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Indices
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Indices_Elements.ODF_Db_Indices_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Key
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Key_Elements.ODF_Db_Key_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Key_Column
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Key_Column_Elements.ODF_Db_Key_Column_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Key_Columns
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Key_Columns_Elements.ODF_Db_Key_Columns_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Keys
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Keys_Elements.ODF_Db_Keys_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Login
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Login_Elements.ODF_Db_Login_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Order_Statement
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Order_Statement_Elements.ODF_Db_Order_Statement_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Queries
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Queries_Elements.ODF_Db_Queries_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Query
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Query_Elements.ODF_Db_Query_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Query_Collection
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Query_Collection_Elements.ODF_Db_Query_Collection_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Reports
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Reports_Elements.ODF_Db_Reports_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Schema_Definition
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Schema_Definition_Elements.ODF_Db_Schema_Definition_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Server_Database
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Server_Database_Elements.ODF_Db_Server_Database_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Table_Definition
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Table_Definition_Elements.ODF_Db_Table_Definition_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Table_Definitions
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Table_Definitions_Elements.ODF_Db_Table_Definitions_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Table_Exclude_Filter
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Table_Exclude_Filter_Elements.ODF_Db_Table_Exclude_Filter_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Table_Filter
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Table_Filter_Elements.ODF_Db_Table_Filter_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Table_Filter_Pattern
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Table_Filter_Pattern_Elements.ODF_Db_Table_Filter_Pattern_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Table_Include_Filter
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Table_Include_Filter_Elements.ODF_Db_Table_Include_Filter_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Table_Representation
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Table_Representation_Elements.ODF_Db_Table_Representation_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Table_Representations
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Table_Representations_Elements.ODF_Db_Table_Representations_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Table_Setting
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Table_Setting_Elements.ODF_Db_Table_Setting_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Table_Settings
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Table_Settings_Elements.ODF_Db_Table_Settings_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Table_Type
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Table_Type_Elements.ODF_Db_Table_Type_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Table_Type_Filter
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Table_Type_Filter_Elements.ODF_Db_Table_Type_Filter_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Db_Update_Table
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Db_Update_Table_Elements.ODF_Db_Update_Table_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Connector
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Connector_Elements.ODF_Draw_Connector_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Contour_Path
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Contour_Path_Elements.ODF_Draw_Contour_Path_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Contour_Polygon
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Contour_Polygon_Elements.ODF_Draw_Contour_Polygon_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Control
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Control_Elements.ODF_Draw_Control_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Connection_Resource
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Connection_Resource_Elements.ODF_Form_Connection_Resource_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Consolidation
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Consolidation_Elements.ODF_Table_Consolidation_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Content_Validation
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Content_Validation_Elements.ODF_Table_Content_Validation_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Content_Validations
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Content_Validations_Elements.ODF_Table_Content_Validations_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Covered_Table_Cell
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Covered_Table_Cell_Elements.ODF_Table_Covered_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Meta_Creation_Date
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Meta_Creation_Date_Elements.ODF_Meta_Creation_Date_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Creation_Date
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Creation_Date_Elements.ODF_Text_Creation_Date_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Creation_Time
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Creation_Time_Elements.ODF_Text_Creation_Time_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Dc_Creator
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Dc_Creator_Elements.ODF_Dc_Creator_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Dr3d_Cube
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Dr3d_Cube_Elements.ODF_Dr3d_Cube_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Currency_Style
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Currency_Style_Elements.ODF_Number_Currency_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Currency_Symbol
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Currency_Symbol_Elements.ODF_Number_Currency_Symbol_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Custom_Shape
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Custom_Shape_Elements.ODF_Draw_Custom_Shape_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Date
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Date_Elements.ODF_Form_Date_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Meta_Date_String
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Meta_Date_String_Elements.ODF_Meta_Date_String_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Date_Style
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Date_Style_Elements.ODF_Number_Date_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Day
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Day_Elements.ODF_Number_Day_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Day_Of_Week
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Day_Of_Week_Elements.ODF_Number_Day_Of_Week_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Embedded_Text
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Embedded_Text_Elements.ODF_Number_Embedded_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Database
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Database_Elements.ODF_Office_Database_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Dde_Source
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Dde_Source_Elements.ODF_Office_Dde_Source_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Date_Time
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Date_Time_Elements.ODF_Presentation_Date_Time_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Date_Time_Decl
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Date_Time_Decl_Elements.ODF_Presentation_Date_Time_Decl_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Default_Page_Layout
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Default_Page_Layout_Elements.ODF_Style_Default_Page_Layout_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Default_Style
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Default_Style_Elements.ODF_Style_Default_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Drawing_Page_Properties
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Drawing_Page_Properties_Elements.ODF_Style_Drawing_Page_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Drop_Cap
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Drop_Cap_Elements.ODF_Style_Drop_Cap_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Svg_Definition_Src
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Svg_Definition_Src_Elements.ODF_Svg_Definition_Src_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Dde_Link
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Dde_Link_Elements.ODF_Table_Dde_Link_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Dim
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Dim_Elements.ODF_Presentation_Dim_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Enhanced_Geometry
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Enhanced_Geometry_Elements.ODF_Draw_Enhanced_Geometry_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Dr3d_Extrude
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Dr3d_Extrude_Elements.ODF_Dr3d_Extrude_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Dr3d_Light
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Dr3d_Light_Elements.ODF_Dr3d_Light_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Dr3d_Rotate
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Dr3d_Rotate_Elements.ODF_Dr3d_Rotate_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Dr3d_Scene
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Dr3d_Scene_Elements.ODF_Dr3d_Scene_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Dr3d_Sphere
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Dr3d_Sphere_Elements.ODF_Dr3d_Sphere_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Svg_Desc
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Svg_Desc_Elements.ODF_Svg_Desc_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Ellipse
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Ellipse_Elements.ODF_Draw_Ellipse_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Equation
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Equation_Elements.ODF_Draw_Equation_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Era
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Era_Elements.ODF_Number_Era_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Even_Columns
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Even_Columns_Elements.ODF_Table_Even_Columns_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Even_Rows
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Even_Rows_Elements.ODF_Table_Even_Rows_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Script_Event_Listener
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Script_Event_Listener_Elements.ODF_Script_Event_Listener_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_File
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_File_Elements.ODF_Form_File_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Fixed_Text
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Fixed_Text_Elements.ODF_Form_Fixed_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Event_Listener
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Event_Listener_Elements.ODF_Presentation_Event_Listener_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Floating_Frame
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Floating_Frame_Elements.ODF_Draw_Floating_Frame_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Form
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Form_Elements.ODF_Form_Form_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Formatted_Text
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Formatted_Text_Elements.ODF_Form_Formatted_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Fraction
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Fraction_Elements.ODF_Number_Fraction_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Frame
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Frame_Elements.ODF_Draw_Frame_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Frame
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Frame_Elements.ODF_Form_Frame_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Generic_Control
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Generic_Control_Elements.ODF_Form_Generic_Control_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Event_Listeners
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Event_Listeners_Elements.ODF_Office_Event_Listeners_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Font_Face
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Font_Face_Elements.ODF_Style_Font_Face_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Svg_Font_Face_Format
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Svg_Font_Face_Format_Elements.ODF_Svg_Font_Face_Format_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Svg_Font_Face_Name
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Svg_Font_Face_Name_Elements.ODF_Svg_Font_Face_Name_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Svg_Font_Face_Src
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Svg_Font_Face_Src_Elements.ODF_Svg_Font_Face_Src_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Svg_Font_Face_Uri
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Svg_Font_Face_Uri_Elements.ODF_Svg_Font_Face_Uri_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_First_Column
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_First_Column_Elements.ODF_Table_First_Column_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_First_Row
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_First_Row_Elements.ODF_Table_First_Row_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Forms
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Forms_Elements.ODF_Office_Forms_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Footer
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Footer_Elements.ODF_Presentation_Footer_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Footer
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Footer_Elements.ODF_Style_Footer_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Footer_Decl
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Footer_Decl_Elements.ODF_Presentation_Footer_Decl_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Footer_Left
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Footer_Left_Elements.ODF_Style_Footer_Left_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Footer_Style
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Footer_Style_Elements.ODF_Style_Footer_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Footnote_Sep
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Footnote_Sep_Elements.ODF_Style_Footnote_Sep_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_G
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_G_Elements.ODF_Draw_G_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Glue_Point
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Glue_Point_Elements.ODF_Draw_Glue_Point_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Gradient
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Gradient_Elements.ODF_Draw_Gradient_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Graphic_Properties
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Graphic_Properties_Elements.ODF_Style_Graphic_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Grid
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Grid_Elements.ODF_Form_Grid_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Handle
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Handle_Elements.ODF_Draw_Handle_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Hatch
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Hatch_Elements.ODF_Draw_Hatch_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Hidden
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Hidden_Elements.ODF_Form_Hidden_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Hours
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Hours_Elements.ODF_Number_Hours_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Image
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Image_Elements.ODF_Form_Image_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Image_Frame
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Image_Frame_Elements.ODF_Form_Image_Frame_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Header
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Header_Elements.ODF_Presentation_Header_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Header
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Header_Elements.ODF_Style_Header_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Header_Decl
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Header_Decl_Elements.ODF_Presentation_Header_Decl_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Header_Footer_Properties
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Header_Footer_Properties_Elements.ODF_Style_Header_Footer_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Header_Left
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Header_Left_Elements.ODF_Style_Header_Left_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Header_Style
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Header_Style_Elements.ODF_Style_Header_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Hide_Shape
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Hide_Shape_Elements.ODF_Presentation_Hide_Shape_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Hide_Text
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Hide_Text_Elements.ODF_Presentation_Hide_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Image
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Image_Elements.ODF_Draw_Image_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Image_Map
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Image_Map_Elements.ODF_Draw_Image_Map_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Item
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Item_Elements.ODF_Form_Item_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Layer
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Layer_Elements.ODF_Draw_Layer_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Layer_Set
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Layer_Set_Elements.ODF_Draw_Layer_Set_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Line
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Line_Elements.ODF_Draw_Line_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_List_Level_Label_Alignment
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_List_Level_Label_Alignment_Elements.ODF_Style_List_Level_Label_Alignment_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_List_Level_Properties
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_List_Level_Properties_Elements.ODF_Style_List_Level_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Marker
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Marker_Elements.ODF_Draw_Marker_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Svg_LinearGradient
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Svg_LinearGradient_Elements.ODF_Svg_LinearGradient_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_List_Property
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_List_Property_Elements.ODF_Form_List_Property_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_List_Value
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_List_Value_Elements.ODF_Form_List_Value_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Listbox
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Listbox_Elements.ODF_Form_Listbox_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Map
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Map_Elements.ODF_Style_Map_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Master_Page
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Master_Page_Elements.ODF_Style_Master_Page_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Math_Math
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Math_Math_Elements.ODF_Math_Math_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Measure
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Measure_Elements.ODF_Draw_Measure_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Minutes
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Minutes_Elements.ODF_Number_Minutes_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Month
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Month_Elements.ODF_Number_Month_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Notes
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Notes_Elements.ODF_Presentation_Notes_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Number
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Number_Elements.ODF_Form_Number_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Number
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Number_Elements.ODF_Number_Number_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Number_Style
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Number_Style_Elements.ODF_Number_Number_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Object
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Object_Elements.ODF_Draw_Object_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Object_Ole
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Object_Ole_Elements.ODF_Draw_Object_Ole_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Opacity
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Opacity_Elements.ODF_Draw_Opacity_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Option
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Option_Elements.ODF_Form_Option_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Page
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Page_Elements.ODF_Draw_Page_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Page_Layout
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Page_Layout_Elements.ODF_Style_Page_Layout_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Page_Layout_Properties
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Page_Layout_Properties_Elements.ODF_Style_Page_Layout_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Page_Thumbnail
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Page_Thumbnail_Elements.ODF_Draw_Page_Thumbnail_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Paragraph_Properties
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Paragraph_Properties_Elements.ODF_Style_Paragraph_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Param
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Param_Elements.ODF_Draw_Param_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Password
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Password_Elements.ODF_Form_Password_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Path
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Path_Elements.ODF_Draw_Path_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Percentage_Style
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Percentage_Style_Elements.ODF_Number_Percentage_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Placeholder
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Placeholder_Elements.ODF_Presentation_Placeholder_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Plugin
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Plugin_Elements.ODF_Draw_Plugin_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Polygon
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Polygon_Elements.ODF_Draw_Polygon_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Polyline
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Polyline_Elements.ODF_Draw_Polyline_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Presentation_Page_Layout
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Presentation_Page_Layout_Elements.ODF_Style_Presentation_Page_Layout_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Properties
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Properties_Elements.ODF_Form_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Property
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Property_Elements.ODF_Form_Property_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Quarter
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Quarter_Elements.ODF_Number_Quarter_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Svg_RadialGradient
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Svg_RadialGradient_Elements.ODF_Svg_RadialGradient_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Radio
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Radio_Elements.ODF_Form_Radio_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Rect
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Rect_Elements.ODF_Draw_Rect_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Region_Center
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Region_Center_Elements.ODF_Style_Region_Center_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Region_Left
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Region_Left_Elements.ODF_Style_Region_Left_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Region_Right
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Region_Right_Elements.ODF_Style_Region_Right_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Regular_Polygon
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Regular_Polygon_Elements.ODF_Draw_Regular_Polygon_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Ruby_Properties
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Ruby_Properties_Elements.ODF_Style_Ruby_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Stroke_Dash
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Stroke_Dash_Elements.ODF_Draw_Stroke_Dash_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Scientific_Number
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Scientific_Number_Elements.ODF_Number_Scientific_Number_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Seconds
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Seconds_Elements.ODF_Number_Seconds_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Section_Properties
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Section_Properties_Elements.ODF_Style_Section_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Svg_Stop
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Svg_Stop_Elements.ODF_Svg_Stop_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Text
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Text_Elements.ODF_Number_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Style
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Style_Elements.ODF_Style_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Tab_Stop
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Tab_Stop_Elements.ODF_Style_Tab_Stop_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Tab_Stops
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Tab_Stops_Elements.ODF_Style_Tab_Stops_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Table_Cell_Properties
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Table_Cell_Properties_Elements.ODF_Style_Table_Cell_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Table_Column_Properties
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Table_Column_Properties_Elements.ODF_Style_Table_Column_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Table_Properties
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Table_Properties_Elements.ODF_Style_Table_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Table_Row_Properties
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Table_Row_Properties_Elements.ODF_Style_Table_Row_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Text
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Text_Elements.ODF_Form_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Draw_Text_Box
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Draw_Text_Box_Elements.ODF_Draw_Text_Box_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Text_Content
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Text_Content_Elements.ODF_Number_Text_Content_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Text_Properties
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Text_Properties_Elements.ODF_Style_Text_Properties_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Text_Style
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Text_Style_Elements.ODF_Number_Text_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Textarea
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Textarea_Elements.ODF_Form_Textarea_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Time
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Time_Elements.ODF_Form_Time_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Time_Style
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Time_Style_Elements.ODF_Number_Time_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Form_Value_Range
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Form_Value_Range_Elements.ODF_Form_Value_Range_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Week_Of_Year
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Week_Of_Year_Elements.ODF_Number_Week_Of_Year_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Number_Year
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Number_Year_Elements.ODF_Number_Year_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Cut_Offs
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Cut_Offs_Elements.ODF_Table_Cut_Offs_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Data_Pilot_Display_Info
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Data_Pilot_Display_Info_Elements.ODF_Table_Data_Pilot_Display_Info_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Data_Pilot_Field
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Data_Pilot_Field_Elements.ODF_Table_Data_Pilot_Field_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Data_Pilot_Field_Reference
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Data_Pilot_Field_Reference_Elements.ODF_Table_Data_Pilot_Field_Reference_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Data_Pilot_Group
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Data_Pilot_Group_Elements.ODF_Table_Data_Pilot_Group_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Data_Pilot_Group_Member
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Data_Pilot_Group_Member_Elements.ODF_Table_Data_Pilot_Group_Member_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Data_Pilot_Groups
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Data_Pilot_Groups_Elements.ODF_Table_Data_Pilot_Groups_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Data_Pilot_Layout_Info
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Data_Pilot_Layout_Info_Elements.ODF_Table_Data_Pilot_Layout_Info_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Data_Pilot_Level
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Data_Pilot_Level_Elements.ODF_Table_Data_Pilot_Level_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Data_Pilot_Member
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Data_Pilot_Member_Elements.ODF_Table_Data_Pilot_Member_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Data_Pilot_Members
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Data_Pilot_Members_Elements.ODF_Table_Data_Pilot_Members_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Data_Pilot_Sort_Info
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Data_Pilot_Sort_Info_Elements.ODF_Table_Data_Pilot_Sort_Info_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Data_Pilot_Subtotal
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Data_Pilot_Subtotal_Elements.ODF_Table_Data_Pilot_Subtotal_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Data_Pilot_Subtotals
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Data_Pilot_Subtotals_Elements.ODF_Table_Data_Pilot_Subtotals_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Data_Pilot_Table
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Data_Pilot_Table_Elements.ODF_Table_Data_Pilot_Table_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Data_Pilot_Tables
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Data_Pilot_Tables_Elements.ODF_Table_Data_Pilot_Tables_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Database_Range
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Database_Range_Elements.ODF_Table_Database_Range_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Database_Ranges
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Database_Ranges_Elements.ODF_Table_Database_Ranges_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Database_Source_Query
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Database_Source_Query_Elements.ODF_Table_Database_Source_Query_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Database_Source_Sql
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Database_Source_Sql_Elements.ODF_Table_Database_Source_Sql_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Database_Source_Table
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Database_Source_Table_Elements.ODF_Table_Database_Source_Table_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Dde_Links
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Dde_Links_Elements.ODF_Table_Dde_Links_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Deletion
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Deletion_Elements.ODF_Table_Deletion_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Deletions
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Deletions_Elements.ODF_Table_Deletions_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Dependencies
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Dependencies_Elements.ODF_Table_Dependencies_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Dependency
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Dependency_Elements.ODF_Table_Dependency_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Desc
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Desc_Elements.ODF_Table_Desc_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Last_Column
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Last_Column_Elements.ODF_Table_Last_Column_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Last_Row
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Last_Row_Elements.ODF_Table_Last_Row_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Odd_Columns
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Odd_Columns_Elements.ODF_Table_Odd_Columns_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Odd_Rows
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Odd_Rows_Elements.ODF_Table_Odd_Rows_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Table_Template
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Table_Template_Elements.ODF_Table_Table_Template_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Creator
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Creator_Elements.ODF_Text_Creator_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Database_Display
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Database_Display_Elements.ODF_Text_Database_Display_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Database_Name
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Database_Name_Elements.ODF_Text_Database_Name_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Database_Next
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Database_Next_Elements.ODF_Text_Database_Next_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Database_Row_Number
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Database_Row_Number_Elements.ODF_Text_Database_Row_Number_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Database_Row_Select
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Database_Row_Select_Elements.ODF_Text_Database_Row_Select_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Dc_Date
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Dc_Date_Elements.ODF_Dc_Date_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Date
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Date_Elements.ODF_Text_Date_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Dde_Connection
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Dde_Connection_Elements.ODF_Text_Dde_Connection_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Dde_Connection_Decl
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Dde_Connection_Decl_Elements.ODF_Text_Dde_Connection_Decl_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Dde_Connection_Decls
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Dde_Connection_Decls_Elements.ODF_Text_Dde_Connection_Decls_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Deletion
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Deletion_Elements.ODF_Text_Deletion_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Dc_Description
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Dc_Description_Elements.ODF_Dc_Description_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Detective
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Detective_Elements.ODF_Table_Detective_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Description
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Description_Elements.ODF_Text_Description_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Meta_Document_Statistic
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Meta_Document_Statistic_Elements.ODF_Meta_Document_Statistic_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Meta_Editing_Cycles
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Meta_Editing_Cycles_Elements.ODF_Meta_Editing_Cycles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Meta_Editing_Duration
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Meta_Editing_Duration_Elements.ODF_Meta_Editing_Duration_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Dc_Language
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Dc_Language_Elements.ODF_Dc_Language_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Dc_Subject
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Dc_Subject_Elements.ODF_Dc_Subject_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Dc_Title
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Dc_Title_Elements.ODF_Dc_Title_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Meta_Generator
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Meta_Generator_Elements.ODF_Meta_Generator_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Meta_Hyperlink_Behaviour
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Meta_Hyperlink_Behaviour_Elements.ODF_Meta_Hyperlink_Behaviour_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Meta_Initial_Creator
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Meta_Initial_Creator_Elements.ODF_Meta_Initial_Creator_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Meta_Keyword
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Meta_Keyword_Elements.ODF_Meta_Keyword_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Meta_Print_Date
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Meta_Print_Date_Elements.ODF_Meta_Print_Date_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Meta_Printed_By
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Meta_Printed_By_Elements.ODF_Meta_Printed_By_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Meta_Template
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Meta_Template_Elements.ODF_Meta_Template_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Meta_User_Defined
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Meta_User_Defined_Elements.ODF_Meta_User_Defined_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Body
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Body_Elements.ODF_Office_Body_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Chart
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Chart_Elements.ODF_Office_Chart_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Document
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Document_Elements.ODF_Office_Document_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Document_Content
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Document_Content_Elements.ODF_Office_Document_Content_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Document_Meta
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Document_Meta_Elements.ODF_Office_Document_Meta_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Document_Settings
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Document_Settings_Elements.ODF_Office_Document_Settings_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Document_Styles
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Document_Styles_Elements.ODF_Office_Document_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Drawing
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Drawing_Elements.ODF_Office_Drawing_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Style_Handout_Master
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Style_Handout_Master_Elements.ODF_Style_Handout_Master_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Error_Macro
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Error_Macro_Elements.ODF_Table_Error_Macro_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Error_Message
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Error_Message_Elements.ODF_Table_Error_Message_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Filter
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Filter_Elements.ODF_Table_Filter_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Filter_And
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Filter_And_Elements.ODF_Table_Filter_And_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Filter_Condition
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Filter_Condition_Elements.ODF_Table_Filter_Condition_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Filter_Or
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Filter_Or_Elements.ODF_Table_Filter_Or_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Filter_Set_Item
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Filter_Set_Item_Elements.ODF_Table_Filter_Set_Item_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Help_Message
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Help_Message_Elements.ODF_Table_Help_Message_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Highlighted_Range
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Highlighted_Range_Elements.ODF_Table_Highlighted_Range_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Editing_Cycles
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Editing_Cycles_Elements.ODF_Text_Editing_Cycles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Editing_Duration
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Editing_Duration_Elements.ODF_Text_Editing_Duration_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Execute_Macro
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Execute_Macro_Elements.ODF_Text_Execute_Macro_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Expression
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Expression_Elements.ODF_Text_Expression_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_File_Name
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_File_Name_Elements.ODF_Text_File_Name_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Font_Face_Decls
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Font_Face_Decls_Elements.ODF_Office_Font_Face_Decls_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Format_Change
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Format_Change_Elements.ODF_Text_Format_Change_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_H
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_H_Elements.ODF_Text_H_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Hidden_Paragraph
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Hidden_Paragraph_Elements.ODF_Text_Hidden_Paragraph_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Hidden_Text
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Hidden_Text_Elements.ODF_Text_Hidden_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Illustration_Index
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Illustration_Index_Elements.ODF_Text_Illustration_Index_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Illustration_Index_Entry_Template
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Illustration_Index_Entry_Template_Elements.ODF_Text_Illustration_Index_Entry_Template_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Illustration_Index_Source
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Illustration_Index_Source_Elements.ODF_Text_Illustration_Index_Source_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Image
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Image_Elements.ODF_Office_Image_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Insertion
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Insertion_Elements.ODF_Table_Insertion_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Insertion_Cut_Off
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Insertion_Cut_Off_Elements.ODF_Table_Insertion_Cut_Off_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Iteration
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Iteration_Elements.ODF_Table_Iteration_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Label_Range
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Label_Range_Elements.ODF_Table_Label_Range_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Label_Ranges
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Label_Ranges_Elements.ODF_Table_Label_Ranges_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Image_Count
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Image_Count_Elements.ODF_Text_Image_Count_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Index_Body
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Index_Body_Elements.ODF_Text_Index_Body_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Index_Entry_Bibliography
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Index_Entry_Bibliography_Elements.ODF_Text_Index_Entry_Bibliography_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Index_Entry_Chapter
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Index_Entry_Chapter_Elements.ODF_Text_Index_Entry_Chapter_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Index_Entry_Link_End
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Index_Entry_Link_End_Elements.ODF_Text_Index_Entry_Link_End_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Index_Entry_Link_Start
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Index_Entry_Link_Start_Elements.ODF_Text_Index_Entry_Link_Start_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Index_Entry_Page_Number
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Index_Entry_Page_Number_Elements.ODF_Text_Index_Entry_Page_Number_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Index_Entry_Span
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Index_Entry_Span_Elements.ODF_Text_Index_Entry_Span_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Index_Entry_Tab_Stop
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Index_Entry_Tab_Stop_Elements.ODF_Text_Index_Entry_Tab_Stop_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Index_Entry_Text
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Index_Entry_Text_Elements.ODF_Text_Index_Entry_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Index_Source_Style
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Index_Source_Style_Elements.ODF_Text_Index_Source_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Index_Source_Styles
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Index_Source_Styles_Elements.ODF_Text_Index_Source_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Index_Title
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Index_Title_Elements.ODF_Text_Index_Title_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Index_Title_Template
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Index_Title_Template_Elements.ODF_Text_Index_Title_Template_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Initial_Creator
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Initial_Creator_Elements.ODF_Text_Initial_Creator_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Insertion
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Insertion_Elements.ODF_Text_Insertion_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Keywords
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Keywords_Elements.ODF_Text_Keywords_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Line_Break
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Line_Break_Elements.ODF_Text_Line_Break_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Linenumbering_Configuration
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Linenumbering_Configuration_Elements.ODF_Text_Linenumbering_Configuration_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Linenumbering_Separator
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Linenumbering_Separator_Elements.ODF_Text_Linenumbering_Separator_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_List
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_List_Elements.ODF_Text_List_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_List_Header
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_List_Header_Elements.ODF_Text_List_Header_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_List_Item
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_List_Item_Elements.ODF_Text_List_Item_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_List_Level_Style_Bullet
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_List_Level_Style_Bullet_Elements.ODF_Text_List_Level_Style_Bullet_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_List_Level_Style_Image
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_List_Level_Style_Image_Elements.ODF_Text_List_Level_Style_Image_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_List_Level_Style_Number
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_List_Level_Style_Number_Elements.ODF_Text_List_Level_Style_Number_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_List_Style
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_List_Style_Elements.ODF_Text_List_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Master_Styles
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Master_Styles_Elements.ODF_Office_Master_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Measure
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Measure_Elements.ODF_Text_Measure_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Meta
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Meta_Elements.ODF_Office_Meta_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Play
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Play_Elements.ODF_Presentation_Play_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Settings
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Settings_Elements.ODF_Presentation_Settings_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Show
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Show_Elements.ODF_Presentation_Show_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Show_Shape
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Show_Shape_Elements.ODF_Presentation_Show_Shape_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Show_Text
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Show_Text_Elements.ODF_Presentation_Show_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Presentation_Sound
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Presentation_Sound_Elements.ODF_Presentation_Sound_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Svg_Title
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Svg_Title_Elements.ODF_Svg_Title_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Movement
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Movement_Elements.ODF_Table_Movement_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Movement_Cut_Off
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Movement_Cut_Off_Elements.ODF_Table_Movement_Cut_Off_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Named_Expression
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Named_Expression_Elements.ODF_Table_Named_Expression_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Named_Expressions
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Named_Expressions_Elements.ODF_Table_Named_Expressions_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Named_Range
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Named_Range_Elements.ODF_Table_Named_Range_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Null_Date
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Null_Date_Elements.ODF_Table_Null_Date_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Operation
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Operation_Elements.ODF_Table_Operation_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Previous
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Previous_Elements.ODF_Table_Previous_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Scenario
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Scenario_Elements.ODF_Table_Scenario_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Shapes
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Shapes_Elements.ODF_Table_Shapes_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Sort
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Sort_Elements.ODF_Table_Sort_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Sort_By
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Sort_By_Elements.ODF_Table_Sort_By_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Sort_Groups
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Sort_Groups_Elements.ODF_Table_Sort_Groups_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Source_Cell_Range
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Source_Cell_Range_Elements.ODF_Table_Source_Cell_Range_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Source_Range_Address
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Source_Range_Address_Elements.ODF_Table_Source_Range_Address_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Source_Service
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Source_Service_Elements.ODF_Table_Source_Service_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Subtotal_Field
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Subtotal_Field_Elements.ODF_Table_Subtotal_Field_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Subtotal_Rule
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Subtotal_Rule_Elements.ODF_Table_Subtotal_Rule_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Subtotal_Rules
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Subtotal_Rules_Elements.ODF_Table_Subtotal_Rules_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Table
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Table_Elements.ODF_Table_Table_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Table_Cell
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Table_Cell_Elements.ODF_Table_Table_Cell_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Table_Column
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Table_Column_Elements.ODF_Table_Table_Column_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Table_Column_Group
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Table_Column_Group_Elements.ODF_Table_Table_Column_Group_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Table_Columns
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Table_Columns_Elements.ODF_Table_Table_Columns_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Table_Header_Columns
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Table_Header_Columns_Elements.ODF_Table_Table_Header_Columns_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Table_Header_Rows
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Table_Header_Rows_Elements.ODF_Table_Table_Header_Rows_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Table_Row
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Table_Row_Elements.ODF_Table_Table_Row_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Table_Row_Group
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Table_Row_Group_Elements.ODF_Table_Table_Row_Group_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Table_Rows
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Table_Rows_Elements.ODF_Table_Table_Rows_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Table_Source
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Table_Source_Elements.ODF_Table_Table_Source_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Target_Range_Address
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Target_Range_Address_Elements.ODF_Table_Target_Range_Address_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Title
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Title_Elements.ODF_Table_Title_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Table_Tracked_Changes
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Table_Tracked_Changes_Elements.ODF_Table_Tracked_Changes_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Meta
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Meta_Elements.ODF_Text_Meta_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Meta_Field
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Meta_Field_Elements.ODF_Text_Meta_Field_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Xforms_Model
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Xforms_Model_Elements.ODF_Xforms_Model_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Modification_Date
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Modification_Date_Elements.ODF_Text_Modification_Date_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Modification_Time
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Modification_Time_Elements.ODF_Text_Modification_Time_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Note
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Note_Elements.ODF_Text_Note_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Note_Body
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Note_Body_Elements.ODF_Text_Note_Body_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Note_Citation
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Note_Citation_Elements.ODF_Text_Note_Citation_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Note_Continuation_Notice_Backward
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Note_Continuation_Notice_Backward_Elements.ODF_Text_Note_Continuation_Notice_Backward_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Note_Continuation_Notice_Forward
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Note_Continuation_Notice_Forward_Elements.ODF_Text_Note_Continuation_Notice_Forward_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Note_Ref
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Note_Ref_Elements.ODF_Text_Note_Ref_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Notes_Configuration
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Notes_Configuration_Elements.ODF_Text_Notes_Configuration_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Number
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Number_Elements.ODF_Text_Number_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Numbered_Paragraph
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Numbered_Paragraph_Elements.ODF_Text_Numbered_Paragraph_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Object_Count
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Object_Count_Elements.ODF_Text_Object_Count_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Object_Index
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Object_Index_Elements.ODF_Text_Object_Index_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Object_Index_Entry_Template
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Object_Index_Entry_Template_Elements.ODF_Text_Object_Index_Entry_Template_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Object_Index_Source
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Object_Index_Source_Elements.ODF_Text_Object_Index_Source_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Outline_Level_Style
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Outline_Level_Style_Elements.ODF_Text_Outline_Level_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Outline_Style
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Outline_Style_Elements.ODF_Text_Outline_Style_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_P
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_P_Elements.ODF_Text_P_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Page
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Page_Elements.ODF_Text_Page_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Page_Continuation
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Page_Continuation_Elements.ODF_Text_Page_Continuation_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Page_Count
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Page_Count_Elements.ODF_Text_Page_Count_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Page_Number
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Page_Number_Elements.ODF_Text_Page_Number_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Page_Sequence
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Page_Sequence_Elements.ODF_Text_Page_Sequence_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Page_Variable_Get
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Page_Variable_Get_Elements.ODF_Text_Page_Variable_Get_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Page_Variable_Set
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Page_Variable_Set_Elements.ODF_Text_Page_Variable_Set_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Paragraph_Count
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Paragraph_Count_Elements.ODF_Text_Paragraph_Count_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Placeholder
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Placeholder_Elements.ODF_Text_Placeholder_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Presentation
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Presentation_Elements.ODF_Office_Presentation_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Print_Date
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Print_Date_Elements.ODF_Text_Print_Date_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Print_Time
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Print_Time_Elements.ODF_Text_Print_Time_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Printed_By
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Printed_By_Elements.ODF_Text_Printed_By_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Reference_Mark
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Reference_Mark_Elements.ODF_Text_Reference_Mark_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Reference_Mark_End
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Reference_Mark_End_Elements.ODF_Text_Reference_Mark_End_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Reference_Mark_Start
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Reference_Mark_Start_Elements.ODF_Text_Reference_Mark_Start_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Reference_Ref
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Reference_Ref_Elements.ODF_Text_Reference_Ref_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Ruby
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Ruby_Elements.ODF_Text_Ruby_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Ruby_Base
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Ruby_Base_Elements.ODF_Text_Ruby_Base_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Ruby_Text
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Ruby_Text_Elements.ODF_Text_Ruby_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_S
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_S_Elements.ODF_Text_S_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Script
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Script_Elements.ODF_Office_Script_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Script
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Script_Elements.ODF_Text_Script_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Scripts
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Scripts_Elements.ODF_Office_Scripts_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Section
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Section_Elements.ODF_Text_Section_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Section_Source
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Section_Source_Elements.ODF_Text_Section_Source_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sender_City
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sender_City_Elements.ODF_Text_Sender_City_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sender_Company
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sender_Company_Elements.ODF_Text_Sender_Company_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sender_Country
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sender_Country_Elements.ODF_Text_Sender_Country_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sender_Email
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sender_Email_Elements.ODF_Text_Sender_Email_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sender_Fax
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sender_Fax_Elements.ODF_Text_Sender_Fax_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sender_Firstname
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sender_Firstname_Elements.ODF_Text_Sender_Firstname_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sender_Initials
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sender_Initials_Elements.ODF_Text_Sender_Initials_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sender_Lastname
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sender_Lastname_Elements.ODF_Text_Sender_Lastname_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sender_Phone_Private
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sender_Phone_Private_Elements.ODF_Text_Sender_Phone_Private_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sender_Phone_Work
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sender_Phone_Work_Elements.ODF_Text_Sender_Phone_Work_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sender_Position
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sender_Position_Elements.ODF_Text_Sender_Position_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sender_Postal_Code
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sender_Postal_Code_Elements.ODF_Text_Sender_Postal_Code_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sender_State_Or_Province
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sender_State_Or_Province_Elements.ODF_Text_Sender_State_Or_Province_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sender_Street
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sender_Street_Elements.ODF_Text_Sender_Street_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sender_Title
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sender_Title_Elements.ODF_Text_Sender_Title_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sequence
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sequence_Elements.ODF_Text_Sequence_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sequence_Decl
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sequence_Decl_Elements.ODF_Text_Sequence_Decl_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sequence_Decls
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sequence_Decls_Elements.ODF_Text_Sequence_Decls_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sequence_Ref
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sequence_Ref_Elements.ODF_Text_Sequence_Ref_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Settings
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Settings_Elements.ODF_Office_Settings_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sheet_Name
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sheet_Name_Elements.ODF_Text_Sheet_Name_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Soft_Page_Break
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Soft_Page_Break_Elements.ODF_Text_Soft_Page_Break_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Sort_Key
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Sort_Key_Elements.ODF_Text_Sort_Key_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Span
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Span_Elements.ODF_Text_Span_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Spreadsheet
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Spreadsheet_Elements.ODF_Office_Spreadsheet_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Styles
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Styles_Elements.ODF_Office_Styles_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Subject
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Subject_Elements.ODF_Text_Subject_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Tab
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Tab_Elements.ODF_Text_Tab_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Table_Count
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Table_Count_Elements.ODF_Text_Table_Count_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Table_Formula
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Table_Formula_Elements.ODF_Text_Table_Formula_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Table_Index
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Table_Index_Elements.ODF_Text_Table_Index_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Table_Index_Entry_Template
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Table_Index_Entry_Template_Elements.ODF_Text_Table_Index_Entry_Template_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Table_Index_Source
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Table_Index_Source_Elements.ODF_Text_Table_Index_Source_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Table_Of_Content
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Table_Of_Content_Elements.ODF_Text_Table_Of_Content_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Table_Of_Content_Entry_Template
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Table_Of_Content_Entry_Template_Elements.ODF_Text_Table_Of_Content_Entry_Template_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Table_Of_Content_Source
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Table_Of_Content_Source_Elements.ODF_Text_Table_Of_Content_Source_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Template_Name
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Template_Name_Elements.ODF_Text_Template_Name_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Office_Text
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Office_Text_Elements.ODF_Office_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Text_Input
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Text_Input_Elements.ODF_Text_Text_Input_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Time
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Time_Elements.ODF_Text_Time_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Title
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Title_Elements.ODF_Text_Title_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Toc_Mark
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Toc_Mark_Elements.ODF_Text_Toc_Mark_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Toc_Mark_End
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Toc_Mark_End_Elements.ODF_Text_Toc_Mark_End_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Toc_Mark_Start
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Toc_Mark_Start_Elements.ODF_Text_Toc_Mark_Start_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Tracked_Changes
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Tracked_Changes_Elements.ODF_Text_Tracked_Changes_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_User_Defined
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_User_Defined_Elements.ODF_Text_User_Defined_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_User_Field_Decl
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_User_Field_Decl_Elements.ODF_Text_User_Field_Decl_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_User_Field_Decls
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_User_Field_Decls_Elements.ODF_Text_User_Field_Decls_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_User_Field_Get
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_User_Field_Get_Elements.ODF_Text_User_Field_Get_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_User_Field_Input
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_User_Field_Input_Elements.ODF_Text_User_Field_Input_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_User_Index
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_User_Index_Elements.ODF_Text_User_Index_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_User_Index_Entry_Template
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_User_Index_Entry_Template_Elements.ODF_Text_User_Index_Entry_Template_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_User_Index_Mark
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_User_Index_Mark_Elements.ODF_Text_User_Index_Mark_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_User_Index_Mark_End
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_User_Index_Mark_End_Elements.ODF_Text_User_Index_Mark_End_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_User_Index_Mark_Start
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_User_Index_Mark_Start_Elements.ODF_Text_User_Index_Mark_Start_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_User_Index_Source
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_User_Index_Source_Elements.ODF_Text_User_Index_Source_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Variable_Decl
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Variable_Decl_Elements.ODF_Text_Variable_Decl_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Variable_Decls
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Variable_Decls_Elements.ODF_Text_Variable_Decls_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Variable_Get
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Variable_Get_Elements.ODF_Text_Variable_Get_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Variable_Input
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Variable_Input_Elements.ODF_Text_Variable_Input_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Variable_Set
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Variable_Set_Elements.ODF_Text_Variable_Set_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Text_Word_Count
    (Self    : in out ODF_Containment_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : not null ODF.DOM.Text_Word_Count_Elements.ODF_Text_Word_Count_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control);

end ODF.DOM.Iterators.Containment;
