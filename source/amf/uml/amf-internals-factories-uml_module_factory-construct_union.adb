------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Ada Modeling Framework                          --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2012-2013, Vadim Godunko <vgodunko@gmail.com>                --
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
--  This file is generated, don't edit it.
------------------------------------------------------------------------------
with AMF.Internals.Links;
with AMF.Internals.Tables.DI_Metamodel;
with AMF.Internals.Tables.Standard_Profile_L2_Metamodel;
with AMF.Internals.Tables.UMLDI_Metamodel;
with AMF.Internals.Tables.UML_Element_Table;
with AMF.Internals.Tables.UML_Metamodel;
with AMF.Internals.Tables.UML_Types;

separate (AMF.Internals.Factories.UML_Module_Factory)
procedure Construct_Union
 (Element  : AMF.Internals.AMF_Element;
  Property : AMF.Internals.CMOF_Element;
  Link     : AMF.Internals.AMF_Link)
is
   Element_Kind : constant AMF.Internals.Tables.UML_Types.Element_Kinds
     := AMF.Internals.Tables.UML_Element_Table.Table (Element).Kind;
   Opposite     : constant AMF.Internals.AMF_Element
     := AMF.Internals.Links.Opposite_Element (Link, Element);

begin
   case Element_Kind is
      when AMF.Internals.Tables.UML_Types.E_UML_Model =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Package_Package_Merge_Package_Merge_Receiving_Package then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Package_Packaged_Element_A_Owning_Package then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Package_Profile_Application_Profile_Application_Applying_Package then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Conditional_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Activity_Activity_Structured_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_In_Activity,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Node_Activity,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Conditional_Node_Clause_A_Conditional_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Edge_Activity_Edge_In_Structured_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Edge_In_Group,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_In_Activity_Activity_Group then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Node_Activity_Node_In_Structured_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Conditional_Node_Result_A_Conditional_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Activity_Node_Structured_Node_Output_Structured_Activity_Node,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Structured_Node_Input_A_Structured_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Structured_Node_Output_A_Structured_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_Subgroup_Activity_Group_Super_Group then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_Super_Group_Activity_Group_Subgroup then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Variable_Variable_Scope then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Accept_Call_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Accept_Event_Action_Result_A_Accept_Event_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Accept_Call_Action_Return_Information_A_Accept_Call_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Accept_Event_Action_Trigger_A_Accept_Event_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Template_Binding =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Binding_Bound_Element_Templateable_Element_Template_Binding then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Binding_Parameter_Substitution_Template_Parameter_Substitution_Template_Binding then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Binding_Signature_A_Template_Binding then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Protocol_Conformance =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Protocol_Conformance_General_Machine_A_Protocol_Conformance then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Protocol_Conformance_Specific_Machine_Protocol_State_Machine_Conformance then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Broadcast_Signal_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Invocation_Action_Argument_A_Invocation_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Interaction_Operand =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Interaction_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Operand_Interaction_Operand_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Operand_Fragment_Interaction_Fragment_Enclosing_Operand then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_General_Ordering_A_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Operand_Guard_A_Interaction_Operand then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Enumeration =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Data_Type_Owned_Attribute_Property_Datatype then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Enumeration_Owned_Literal_Enumeration_Literal_Enumeration then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Data_Type_Owned_Operation_Operation_Datatype then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Protocol_State_Machine =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Protocol_State_Machine_Conformance_Protocol_Conformance_Specific_Machine then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Machine_Connection_Point_Pseudostate_State_Machine then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Context_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Machine_Extended_State_Machine_A_State_Machine then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Behavior_Redefined_Behavior_Behavior,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Owned_Attribute_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Attribute_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Role_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Connector_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Owned_Parameter_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Owned_Parameter_Set_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Reception_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Machine_Region_Region_State_Machine then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Role_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Super_Class_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_General_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Accept_Event_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Accept_Event_Action_Result_A_Accept_Event_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Accept_Event_Action_Trigger_A_Accept_Event_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Template_Parameter =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Parameter_Owned_Default_A_Template_Parameter then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Parameter_Owned_Parametered_Element_Parameterable_Element_Owning_Template_Parameter then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Enumeration_Literal =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Enumeration_Literal_Classifier_A_Enumeration_Literal then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Instance_Specification_Classifier_Instance_Specification,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Deployment_Target_Deployment_Deployment_Location then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Enumeration_Literal_Enumeration_Enumeration_Owned_Literal then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Instance_Specification_Slot_Slot_Owning_Instance then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Instance_Specification_Specification_A_Owning_Instance_Spec then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Interaction_Use =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Use_Actual_Gate_A_Interaction_Use then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Use_Argument_A_Interaction_Use then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Interaction_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Operand_Interaction_Operand_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_General_Ordering_A_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Use_Return_Value_A_Interaction_Use then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Remove_Structural_Feature_Value_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structural_Feature_Action_Object_A_Structural_Feature_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Remove_Structural_Feature_Value_Action_Remove_At_A_Remove_Structural_Feature_Value_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Write_Structural_Feature_Action_Result_A_Write_Structural_Feature_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Write_Structural_Feature_Action_Value_A_Write_Structural_Feature_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Operation_Template_Parameter =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Parameter_Owned_Default_A_Template_Parameter then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Parameter_Owned_Parametered_Element_Parameterable_Element_Owning_Template_Parameter then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Operation_Template_Parameter_Parametered_Element_Operation_Template_Parameter then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Template_Parameter_Substitution =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Parameter_Substitution_Owned_Actual_A_Template_Parameter_Substitution then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Parameter_Substitution_Template_Binding_Template_Binding_Parameter_Substitution then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Exception_Handler =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Exception_Handler_Protected_Node_Executable_Node_Handler then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Protocol_Transition =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Transition_Container_Region_Transition then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Transition_Effect_A_Transition then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Transition_Redefined_Transition_A_Transition then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Transition_Redefinition_Context_A_Transition then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Transition_Trigger_A_Transition then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Output_Pin =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Lower_Value_A_Owning_Lower then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Object_Node_Upper_Bound_A_Object_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Upper_Value_A_Owning_Upper then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Call_Behavior_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Invocation_Action_Argument_A_Invocation_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Call_Action_Result_A_Call_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Remove_Variable_Value_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Remove_Variable_Value_Action_Remove_At_A_Remove_Variable_Value_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Write_Variable_Action_Value_A_Write_Variable_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Package =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Package_Package_Merge_Package_Merge_Receiving_Package then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Package_Packaged_Element_A_Owning_Package then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Package_Profile_Application_Profile_Application_Applying_Package then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Connectable_Element_Template_Parameter =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Parameter_Owned_Default_A_Template_Parameter then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Parameter_Owned_Parametered_Element_Parameterable_Element_Owning_Template_Parameter then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Connectable_Element_Template_Parameter_Parametered_Element_Connectable_Element_Template_Parameter then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Template_Signature =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Signature_Owned_Parameter_Template_Parameter_Signature then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Signature_Template_Templateable_Element_Owned_Template_Signature then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Connection_Point_Reference =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Vertex_Container_Region_Subvertex then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Connection_Point_Reference_State_State_Connection then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Activity_Diagram =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Activity_Diagram_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UMLDI_Metamodel.MA_UMLDI_UML_Behavior_Diagram_Model_Element_Uml_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Behavior_Diagram_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UMLDI_Metamodel.MA_UMLDI_UML_Diagram_Element_Model_Element_Uml_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Reply_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Reply_Action_Reply_Value_A_Reply_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Reply_Action_Return_Information_A_Reply_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Call_Event =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Call_Operation_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Invocation_Action_Argument_A_Invocation_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Call_Action_Result_A_Call_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Call_Operation_Action_Target_A_Call_Operation_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Interface =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interface_Owned_Attribute_Property_Interface then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interface_Owned_Operation_Operation_Interface then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interface_Owned_Reception_A_Interface then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interface_Protocol_A_Interface then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Association_End_Label =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Association_End_Label_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UMLDI_Metamodel.MA_UMLDI_UML_Diagram_Element_Model_Element_Uml_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Pseudostate =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Vertex_Container_Region_Subvertex then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Pseudostate_State_State_Connection_Point then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Pseudostate_State_Machine_State_Machine_Connection_Point then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Action_Execution_Specification =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Interaction_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Operand_Interaction_Operand_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_General_Ordering_A_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Connector =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Connector_End_A_Connector then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Connector_Redefined_Connector_A_Connector then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Execution_Environment =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Deployment_Target_Deployment_Deployment_Location then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Node_Nested_Node_A_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Owned_Attribute_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Attribute_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Role_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Connector_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Reception_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Role_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Super_Class_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_General_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Send_Object_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Invocation_Action_Argument_A_Invocation_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Send_Object_Action_Request_A_Send_Object_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Invocation_Action_Argument_Invocation_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Send_Object_Action_Target_A_Send_Object_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Execution_Occurrence_Specification =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Occurrence_Specification_Covered_A_Events then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Interaction_Fragment_Covered_Covered_By,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Interaction_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Operand_Interaction_Operand_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_General_Ordering_A_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Association_Or_Connector_Or_Link_Shape =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Action_Input_Pin =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_Pin_From_Action_A_Action_Input_Pin then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Lower_Value_A_Owning_Lower then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Object_Node_Upper_Bound_A_Object_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Upper_Value_A_Owning_Upper then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Send_Signal_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Invocation_Action_Argument_A_Invocation_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Send_Signal_Action_Target_A_Send_Signal_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Central_Buffer_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Object_Node_Upper_Bound_A_Object_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Test_Identity_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Test_Identity_Action_First_A_Test_Identity_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Test_Identity_Action_Result_A_Test_Identity_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Test_Identity_Action_Second_A_Test_Identity_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Interface_Realization =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Client_Named_Element_Client_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Abstraction_Mapping_A_Abstraction then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Supplier_A_Supplier_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Change_Event =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Change_Event_Change_Expression_A_Change_Event then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Expansion_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Object_Node_Upper_Bound_A_Object_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Activity =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Context_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Edge_Activity_Edge_Activity then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_Activity_Group_In_Activity then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Node_Activity then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Owned_Attribute_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Attribute_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Role_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Connector_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Owned_Parameter_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Owned_Parameter_Set_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Reception_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Role_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Super_Class_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_General_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Variable_Variable_Activity_Scope then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Class =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Owned_Attribute_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Attribute_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Role_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Connector_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Reception_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Role_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Super_Class_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_General_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Interruptible_Activity_Region =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_In_Activity_Activity_Group then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interruptible_Activity_Region_Node_Activity_Node_In_Interruptible_Region then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_Subgroup_Activity_Group_Super_Group then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_Super_Group_Activity_Group_Subgroup then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Sequence_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Activity_Activity_Structured_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_In_Activity,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Node_Activity,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Edge_Activity_Edge_In_Structured_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Edge_In_Group,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Sequence_Node_Executable_Node_A_Sequence_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Activity_Node_Node_In_Structured_Node,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_In_Activity_Activity_Group then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Node_Activity_Node_In_Structured_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Structured_Node_Input_A_Structured_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Structured_Node_Output_A_Structured_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_Subgroup_Activity_Group_Super_Group then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_Super_Group_Activity_Group_Subgroup then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Variable_Variable_Scope then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Signal =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Signal_Owned_Attribute_A_Owning_Signal then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Expansion_Region =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Activity_Activity_Structured_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_In_Activity,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Node_Activity,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Edge_Activity_Edge_In_Structured_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Edge_In_Group,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_In_Activity_Activity_Group then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Node_Activity_Node_In_Structured_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Structured_Node_Input_A_Structured_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Structured_Node_Output_A_Structured_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_Subgroup_Activity_Group_Super_Group then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_Super_Group_Activity_Group_Subgroup then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Variable_Variable_Scope then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Class_Diagram =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Signal_Event =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Interval =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Time_Constraint =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Constraint_Context_Namespace_Owned_Rule then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Constraint_Specification_A_Owning_Constraint then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interval_Constraint_Specification_A_Interval_Constraint then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Constraint_Specification_Owning_Constraint,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Time_Constraint_Specification_A_Time_Constraint then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Interval_Constraint_Specification_Interval_Constraint,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Connector_End =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Lower_Value_A_Owning_Lower then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Upper_Value_A_Owning_Upper then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Qualifier_Value =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Slot =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Slot_Owning_Instance_Instance_Specification_Slot then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Slot_Value_A_Owning_Slot then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Interval_Constraint =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Constraint_Context_Namespace_Owned_Rule then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Constraint_Specification_A_Owning_Constraint then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interval_Constraint_Specification_A_Interval_Constraint then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Constraint_Specification_Owning_Constraint,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Time_Event =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Time_Event_When_A_Time_Event then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Expression =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Expression_Operand_A_Expression then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Classifier_Shape =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Compartmentable_Shape_Compartment_A_Compartmented_Shape then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Classifier_Shape_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UMLDI_Metamodel.MA_UMLDI_UML_Diagram_Element_Model_Element_Uml_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Start_Classifier_Behavior_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Start_Classifier_Behavior_Action_Object_A_Start_Classifier_Behavior_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Extend =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Extend_Condition_A_Extend then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Extend_Extended_Case_A_Extend then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Extend_Extension_Use_Case_Extend then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Raise_Exception_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Raise_Exception_Action_Exception_A_Raise_Exception_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Package_Import =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Package_Import_Imported_Package_A_Package_Import then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Package_Import_Importing_Namespace_Namespace_Package_Import then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Time_Expression =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Time_Expression_Expr_A_Time_Expression then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Join_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Join_Node_Join_Spec_A_Join_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Compartment =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Compartment_Element_In_Compartment_A_Owning_Compartment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Start_Object_Behavior_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Invocation_Action_Argument_A_Invocation_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Start_Object_Behavior_Action_Object_A_Start_Object_Behavior_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Call_Action_Result_A_Call_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Read_Extent_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Read_Extent_Action_Result_A_Read_Extent_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Time_Interval =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Time_Interval_Max_A_Time_Interval then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Interval_Max_Interval,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Time_Interval_Min_A_Time_Interval then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Interval_Min_Interval,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Consider_Ignore_Fragment =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Combined_Fragment_Cfragment_Gate_A_Combined_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Interaction_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Operand_Interaction_Operand_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_General_Ordering_A_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Combined_Fragment_Operand_A_Combined_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Extension =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Association_End_Type_A_Association then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Association_Member_End_Property_Association then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Extension_Owned_End_A_Extension then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Association_Owned_End_Owning_Association,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Compartmentable_Shape =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Compartmentable_Shape_Compartment_A_Compartmented_Shape then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Package_Merge =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Package_Merge_Merged_Package_A_Package_Merge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Package_Merge_Receiving_Package_Package_Package_Merge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Component_Diagram =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Time_Observation =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Lifeline =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Lifeline_Interaction_Interaction_Lifeline then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Lifeline_Selector_A_Lifeline then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Read_Is_Classified_Object_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Read_Is_Classified_Object_Action_Object_A_Read_Is_Classified_Object_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Read_Is_Classified_Object_Action_Result_A_Read_Is_Classified_Object_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Composite_Structure_Diagram =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Constraint =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Constraint_Context_Namespace_Owned_Rule then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Constraint_Specification_A_Owning_Constraint then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Transition =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Transition_Container_Region_Transition then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Transition_Effect_A_Transition then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Transition_Redefined_Transition_A_Transition then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Transition_Redefinition_Context_A_Transition then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Transition_Trigger_A_Transition then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Parameter =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameter_Default_Value_A_Owning_Parameter then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Lower_Value_A_Owning_Lower then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Connectable_Element_Template_Parameter_Connectable_Element_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Upper_Value_A_Owning_Upper then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_State =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Connection_Connection_Point_Reference_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Connection_Point_Pseudostate_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Vertex_Container_Region_Subvertex then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Deferrable_Trigger_A_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Do_Activity_A_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Entry_A_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Exit_A_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Redefined_State_A_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Redefinition_Context_A_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Region_Region_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Deployment_Diagram =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Activity_Final_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Read_Link_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Link_Action_End_Data_A_Link_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Link_Action_Input_Value_A_Link_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Read_Link_Action_Result_A_Read_Link_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Extension_End =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Association_End_Property_Qualifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Class_Class_Owned_Attribute then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Datatype_Data_Type_Owned_Attribute then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Default_Value_A_Owning_Property then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Deployment_Target_Deployment_Deployment_Location then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Interface_Interface_Owned_Attribute then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Lower_Value_A_Owning_Lower then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Owning_Association_Association_Owned_End then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Qualifier_Property_Association_End then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Redefined_Property_A_Property then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Connectable_Element_Template_Parameter_Connectable_Element_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Extension_End_Type_A_Extension_End then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Typed_Element_Type_Typed_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Upper_Value_A_Owning_Upper then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Continuation =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Interaction_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Operand_Interaction_Operand_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_General_Ordering_A_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Control_Flow =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Edge_Activity_Activity_Edge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Edge_Guard_A_Activity_Edge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Edge_In_Partition_Activity_Partition_Edge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Edge_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Edge_In_Structured_Node_Structured_Activity_Node_Edge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Edge_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Edge_Redefined_Edge_A_Activity_Edge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Edge_Weight_A_Activity_Edge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Link_End_Creation_Data =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Link_End_Data_Qualifier_A_Link_End_Data then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Extension_Point =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Extension_Point_Use_Case_Use_Case_Extension_Point then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Read_Link_Object_End_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Read_Link_Object_End_Action_Object_A_Read_Link_Object_End_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Read_Link_Object_End_Action_Result_A_Read_Link_Object_End_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Edge =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Edge_Source_A_Source_Edge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Edge_Source_Source_Edge,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Edge_Target_A_Target_Edge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Edge_Target_Target_Edge,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Create_Link_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Create_Link_Action_End_Data_A_Create_Link_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Link_Action_End_Data_Link_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Link_Action_End_Data_A_Link_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Link_Action_Input_Value_A_Link_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Parameter_Set =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameter_Set_Condition_A_Parameter_Set then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Interaction_Diagram =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Behavior_Diagram_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UMLDI_Metamodel.MA_UMLDI_UML_Diagram_Element_Model_Element_Uml_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Interaction_Diagram_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UMLDI_Metamodel.MA_UMLDI_UML_Behavior_Diagram_Model_Element_Uml_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Create_Link_Object_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Create_Link_Action_End_Data_A_Create_Link_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Link_Action_End_Data_Link_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Link_Action_End_Data_A_Link_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Link_Action_Input_Value_A_Link_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Create_Link_Object_Action_Result_A_Create_Link_Object_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Link_End_Data =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Link_End_Data_Qualifier_A_Link_End_Data then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Interaction_Table_Label =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Keyword_Label =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Final_State =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Connection_Connection_Point_Reference_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Connection_Point_Pseudostate_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Vertex_Container_Region_Subvertex then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Deferrable_Trigger_A_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Do_Activity_A_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Entry_A_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Exit_A_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Redefined_State_A_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Redefinition_Context_A_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Region_Region_State then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Label =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Create_Object_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Create_Object_Action_Result_A_Create_Object_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Activity_Parameter_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Object_Node_Upper_Bound_A_Object_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Read_Link_Object_End_Qualifier_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Read_Link_Object_End_Qualifier_Action_Object_A_Read_Link_Object_End_Qualifier_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Read_Link_Object_End_Qualifier_Action_Result_A_Read_Link_Object_End_Qualifier_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Deployment_Target_Deployment_Deployment_Location then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Node_Nested_Node_A_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Owned_Attribute_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Attribute_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Role_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Connector_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Reception_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Role_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Super_Class_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_General_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Multiplicity_Label =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Multiplicity_Label_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UMLDI_Metamodel.MA_UMLDI_UML_Diagram_Element_Model_Element_Uml_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Trigger =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Name_Label =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Name_Label_Mode_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UMLDI_Metamodel.MA_UMLDI_UML_Diagram_Element_Model_Element_Uml_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Link_End_Destruction_Data =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Link_End_Data_Qualifier_A_Link_End_Data then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Object_Flow =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Edge_Activity_Activity_Edge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Edge_Guard_A_Activity_Edge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Edge_In_Partition_Activity_Partition_Edge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Edge_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Edge_In_Structured_Node_Structured_Activity_Node_Edge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Edge_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Edge_Redefined_Edge_A_Activity_Edge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Edge_Weight_A_Activity_Edge then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Part_Decomposition =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Use_Actual_Gate_A_Interaction_Use then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Use_Argument_A_Interaction_Use then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Interaction_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Operand_Interaction_Operand_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_General_Ordering_A_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Use_Return_Value_A_Interaction_Use then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Flow_Final_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Object_Diagram =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Fork_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Data_Store_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Object_Node_Upper_Bound_A_Object_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Data_Type =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Data_Type_Owned_Attribute_Property_Datatype then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Data_Type_Owned_Operation_Operation_Datatype then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Package_Diagram =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Literal_Boolean =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Function_Behavior =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Context_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Owned_Attribute_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Attribute_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Role_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Connector_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Owned_Parameter_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Owned_Parameter_Set_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Reception_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Role_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Super_Class_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_General_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Profile_Diagram =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Activity_Partition =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Partition_Edge_Activity_Edge_In_Partition then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Edge_In_Group,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_In_Activity_Activity_Group then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Partition_Node_Activity_Node_In_Partition then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_Subgroup_Activity_Group_Super_Group then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Partition_Subpartition_Activity_Partition_Super_Partition then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Subgroup_Super_Group,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_Super_Group_Activity_Group_Subgroup then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Partition_Super_Partition_Activity_Partition_Subpartition then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Subgroup_Super_Group,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Redefines_Label =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Redefines_Label_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UMLDI_Metamodel.MA_UMLDI_UML_Diagram_Element_Model_Element_Uml_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Decision_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Unmarshall_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Unmarshall_Action_Object_A_Unmarshall_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Unmarshall_Action_Result_A_Unmarshall_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Gate =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_State_Invariant =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Invariant_Covered_A_State_Invariant then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Interaction_Fragment_Covered_Covered_By,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Interaction_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Operand_Interaction_Operand_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_General_Ordering_A_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Invariant_Invariant_A_State_Invariant then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Port =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Association_End_Property_Qualifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Class_Class_Owned_Attribute then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Datatype_Data_Type_Owned_Attribute then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Default_Value_A_Owning_Property then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Deployment_Target_Deployment_Deployment_Location then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Interface_Interface_Owned_Attribute then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Lower_Value_A_Owning_Lower then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Owning_Association_Association_Owned_End then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Qualifier_Property_Association_End then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Redefined_Property_A_Property then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Connectable_Element_Template_Parameter_Connectable_Element_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Upper_Value_A_Owning_Upper then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Shape =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_State_Machine_Diagram =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Behavior_Diagram_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UMLDI_Metamodel.MA_UMLDI_UML_Diagram_Element_Model_Element_Uml_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_State_Machine_Diagram_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UMLDI_Metamodel.MA_UMLDI_UML_Behavior_Diagram_Model_Element_Uml_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Literal_Integer =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Read_Self_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Read_Self_Action_Result_A_Read_Self_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_State_Machine =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Machine_Connection_Point_Pseudostate_State_Machine then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Context_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Machine_Extended_State_Machine_A_State_Machine then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Behavior_Redefined_Behavior_Behavior,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Owned_Attribute_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Attribute_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Role_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Connector_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Owned_Parameter_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Owned_Parameter_Set_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Reception_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_State_Machine_Region_Region_State_Machine then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Role_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Super_Class_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_General_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_General_Ordering =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_State_Shape =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Compartmentable_Shape_Compartment_A_Compartmented_Shape then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_State_Shape_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UMLDI_Metamodel.MA_UMLDI_UML_Diagram_Element_Model_Element_Uml_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Generalization =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Generalization_General_A_Generalization then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Generalization_Specific_Classifier_Generalization then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Classifier_Template_Parameter =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Parameter_Owned_Default_A_Template_Parameter then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Parameter_Owned_Parametered_Element_Parameterable_Element_Owning_Template_Parameter then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Parametered_Element_Classifier_Template_Parameter then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Literal_Null =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Stereotype_Property_Value_Label =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Stereotype_Property_Value_Label_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UMLDI_Metamodel.MA_UMLDI_UML_Diagram_Element_Model_Element_Uml_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Read_Structural_Feature_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structural_Feature_Action_Object_A_Structural_Feature_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Read_Structural_Feature_Action_Result_A_Read_Structural_Feature_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Actor =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Dependency =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Client_Named_Element_Client_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Supplier_A_Supplier_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Clause =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Usage =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Client_Named_Element_Client_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Supplier_A_Supplier_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Add_Structural_Feature_Value_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Add_Structural_Feature_Value_Action_Insert_At_A_Add_Structural_Feature_Value_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structural_Feature_Action_Object_A_Structural_Feature_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Write_Structural_Feature_Action_Result_A_Write_Structural_Feature_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Write_Structural_Feature_Action_Value_A_Write_Structural_Feature_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Use_Case =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Use_Case_Extension_Point_Extension_Point_Use_Case then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Literal_Real =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Generalization_Set =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Read_Variable_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Read_Variable_Action_Result_A_Read_Variable_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Style =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Deployment =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Client_Named_Element_Client_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Deployment_Configuration_Deployment_Specification_Deployment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Supplier_A_Supplier_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Primitive_Type =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Data_Type_Owned_Attribute_Property_Datatype then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Data_Type_Owned_Operation_Operation_Datatype then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Profile =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Package_Package_Merge_Package_Merge_Receiving_Package then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Package_Packaged_Element_A_Owning_Package then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Package_Profile_Application_Profile_Application_Applying_Package then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Occurrence_Specification =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Occurrence_Specification_Covered_A_Events then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Interaction_Fragment_Covered_Covered_By,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Interaction_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Operand_Interaction_Operand_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_General_Ordering_A_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Realization =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Client_Named_Element_Client_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Abstraction_Mapping_A_Abstraction then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Supplier_A_Supplier_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Add_Variable_Value_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Add_Variable_Value_Action_Insert_At_A_Add_Variable_Value_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Write_Variable_Action_Value_A_Write_Variable_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Typed_Element_Label =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Reception =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavioral_Feature_Owned_Parameter_A_Owner_Formal_Param then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavioral_Feature_Owned_Parameter_Set_A_Behavioral_Feature then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Deployment_Specification =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Deployment_Specification_Deployment_Deployment_Configuration then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Artifact_Manifestation_A_Artifact then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Artifact_Nested_Artifact_A_Artifact then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Artifact_Owned_Attribute_A_Artifact then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Literal_String =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Image =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Opaque_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Opaque_Action_Input_Value_A_Opaque_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Opaque_Action_Output_Value_A_Opaque_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Reclassify_Object_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Reclassify_Object_Action_Object_A_Reclassify_Object_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Profile_Application =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Profile_Application_Applied_Profile_A_Profile_Application then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Profile_Application_Applying_Package_Package_Profile_Application then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Clear_Association_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Clear_Association_Action_Object_A_Clear_Association_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UMLDI_UML_Use_Case_Diagram =>
         if Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Local_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Local_Style_Styled_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Behavior_Diagram_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UMLDI_Metamodel.MA_UMLDI_UML_Diagram_Element_Model_Element_Uml_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Model_Element_A_Uml_Diagram_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Model_Element_Diagram_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owned_Element_UML_Diagram_Element_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Owning_Element_UML_Diagram_Element_Owned_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Owned_Element_Owning_Element,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UMLDI_Metamodel.MP_UMLDI_UML_Diagram_Element_Shared_Style_A_Styled_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.DI_Metamodel.MA_DI_Diagram_Element_Shared_Style_Styled_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Any_Receive_Event =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Stereotype =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Stereotype_Icon_A_Stereotype then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Owned_Attribute_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Attribute_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Role_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Connector_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Reception_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Role_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Super_Class_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_General_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Include =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Include_Addition_A_Include then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Include_Including_Case_Use_Case_Include then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Artifact =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Artifact_Manifestation_A_Artifact then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Artifact_Nested_Artifact_A_Artifact then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Artifact_Owned_Attribute_A_Artifact then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Value_Pin =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Lower_Value_A_Owning_Lower then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Object_Node_Upper_Bound_A_Object_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Upper_Value_A_Owning_Upper then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Value_Pin_Value_A_Value_Pin then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Opaque_Behavior =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Context_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Owned_Attribute_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Attribute_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Role_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Connector_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Owned_Parameter_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Owned_Parameter_Set_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Reception_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Role_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Super_Class_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_General_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Property =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Association_End_Property_Qualifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Class_Class_Owned_Attribute then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Datatype_Data_Type_Owned_Attribute then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Default_Value_A_Owning_Property then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Deployment_Target_Deployment_Deployment_Location then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Interface_Interface_Owned_Attribute then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Lower_Value_A_Owning_Lower then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Owning_Association_Association_Owned_End then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Qualifier_Property_Association_End then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Property_Redefined_Property_A_Property then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Connectable_Element_Template_Parameter_Connectable_Element_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Upper_Value_A_Owning_Upper then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Literal_Unlimited_Natural =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Information_Flow =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Information_Flow_Information_Source_A_Information_Flow then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Information_Flow_Information_Target_A_Information_Flow then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Clear_Structural_Feature_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structural_Feature_Action_Object_A_Structural_Feature_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Clear_Structural_Feature_Action_Result_A_Clear_Structural_Feature_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Opaque_Expression =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_Standard_Profile_L2_Document =>
         if Property = AMF.Internals.Tables.Standard_Profile_L2_Metamodel.MP_Standard_Profile_L2_Document_Base_Artifact_A_Extension_Document then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.Standard_Profile_L2_Metamodel.MA_Standard_Profile_L2_A_Extension_File_Base_Artifact,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Association =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Association_End_Type_A_Association then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Association_Member_End_Property_Association then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Destroy_Link_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Destroy_Link_Action_End_Data_A_Destroy_Link_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Link_Action_End_Data_Link_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Link_Action_End_Data_A_Link_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Link_Action_Input_Value_A_Link_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Clear_Variable_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_Standard_Profile_L2_Executable =>
         if Property = AMF.Internals.Tables.Standard_Profile_L2_Metamodel.MP_Standard_Profile_L2_Executable_Base_Artifact_A_Extension_Executable then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.Standard_Profile_L2_Metamodel.MA_Standard_Profile_L2_A_Extension_File_Base_Artifact,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Loop_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Activity_Activity_Structured_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_In_Activity,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Node_Activity,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Edge_Activity_Edge_In_Structured_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Edge_In_Group,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_In_Activity_Activity_Group then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Loop_Node_Loop_Variable_Input_A_Loop_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Activity_Node_Structured_Node_Input_Structured_Activity_Node,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Node_Activity_Node_In_Structured_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Loop_Node_Result_A_Loop_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Activity_Node_Structured_Node_Output_Structured_Activity_Node,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Structured_Node_Input_A_Structured_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Structured_Node_Output_A_Structured_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_Subgroup_Activity_Group_Super_Group then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_Super_Group_Activity_Group_Subgroup then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Variable_Variable_Scope then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Destroy_Object_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Destroy_Object_Action_Target_A_Destroy_Object_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Collaboration =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Collaboration_Collaboration_Role_A_Collaboration then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Role_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Attribute_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Role_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Connector_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Role_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Collaboration_Use =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Collaboration_Use_Role_Binding_A_Collaboration_Use then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_String_Expression =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Expression_Operand_A_Expression then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_String_Expression_Owning_Expression_String_Expression_Sub_Expression then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_String_Expression_Sub_Expression_String_Expression_Owning_Expression then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Information_Item =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Destruction_Occurrence_Specification =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Occurrence_Specification_Covered_A_Events then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Interaction_Fragment_Covered_Covered_By,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Interaction_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Operand_Interaction_Operand_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_General_Ordering_A_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Device =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Deployment_Target_Deployment_Deployment_Location then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Node_Nested_Node_A_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Owned_Attribute_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Attribute_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Role_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Connector_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Reception_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Role_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Super_Class_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_General_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Combined_Fragment =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Combined_Fragment_Cfragment_Gate_A_Combined_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Interaction_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Operand_Interaction_Operand_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_General_Ordering_A_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Combined_Fragment_Operand_A_Combined_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Initial_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Association_Class =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Association_End_Type_A_Association then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Association_Member_End_Property_Association then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Owned_Attribute_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Attribute_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Role_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Connector_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Reception_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Role_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Super_Class_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_General_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_Standard_Profile_L2_Library =>
         if Property = AMF.Internals.Tables.Standard_Profile_L2_Metamodel.MP_Standard_Profile_L2_Library_Base_Artifact_A_Extension_Library then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.Standard_Profile_L2_Metamodel.MA_Standard_Profile_L2_A_Extension_File_Base_Artifact,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Redefinable_Template_Signature =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Redefinable_Template_Signature_Classifier_Classifier_Owned_Template_Signature then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Redefinable_Template_Signature_Classifier_Classifier_Owned_Template_Signature then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Redefinable_Template_Signature_Extended_Signature_A_Redefinable_Template_Signature then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Signature_Owned_Parameter_Template_Parameter_Signature then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Template_Signature_Template_Templateable_Element_Owned_Template_Signature then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Duration =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Duration_Expr_A_Duration then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Manifestation =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Client_Named_Element_Client_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Abstraction_Mapping_A_Abstraction then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Supplier_A_Supplier_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Input_Pin =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Lower_Value_A_Owning_Lower then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Object_Node_Upper_Bound_A_Object_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Upper_Value_A_Owning_Upper then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Duration_Constraint =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Constraint_Context_Namespace_Owned_Rule then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Constraint_Specification_A_Owning_Constraint then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Duration_Constraint_Specification_A_Duration_Constraint then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Interval_Constraint_Specification_Interval_Constraint,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interval_Constraint_Specification_A_Interval_Constraint then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Constraint_Specification_Owning_Constraint,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Merge_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Value_Specification_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Value_Specification_Action_Result_A_Value_Specification_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Value_Specification_Action_Value_A_Value_Specification_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Instance_Specification =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Deployment_Target_Deployment_Deployment_Location then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Instance_Specification_Slot_Slot_Owning_Instance then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Instance_Specification_Specification_A_Owning_Instance_Spec then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Comment =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Operation =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Operation_Class_Class_Owned_Operation then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Operation_Datatype_Data_Type_Owned_Operation then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Operation_Interface_Interface_Owned_Operation then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavioral_Feature_Owned_Parameter_A_Owner_Formal_Param then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Operation_Owned_Parameter_Parameter_Operation then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Behavioral_Feature_Owned_Parameter_Owner_Formal_Param,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavioral_Feature_Owned_Parameter_Set_A_Behavioral_Feature then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Operation_Raised_Exception_A_Operation then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Behavioral_Feature_Raised_Exception_Behavioral_Feature,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Operation_Redefined_Operation_A_Operation then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Operation_Template_Parameter_Operation_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Duration_Interval =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Duration_Interval_Max_A_Duration_Interval then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Interval_Max_Interval,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Duration_Interval_Min_A_Duration_Interval then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Interval_Min_Interval,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Message =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Message_Argument_A_Message then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Message_Interaction_Interaction_Message then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Communication_Path =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Association_End_Type_A_Association then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Association_Member_End_Property_Association then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Duration_Observation =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_Standard_Profile_L2_Script =>
         if Property = AMF.Internals.Tables.Standard_Profile_L2_Metamodel.MP_Standard_Profile_L2_Script_Base_Artifact_A_Extension_Script then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.Standard_Profile_L2_Metamodel.MA_Standard_Profile_L2_A_Extension_File_Base_Artifact,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Variable =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Variable_Activity_Scope_Activity_Variable then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Lower_Value_A_Owning_Lower then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Variable_Scope_Structured_Activity_Node_Variable then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Connectable_Element_Template_Parameter_Connectable_Element_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Multiplicity_Element_Upper_Value_A_Owning_Upper then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Reduce_Action =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Reduce_Action_Collection_A_Reduce_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Reduce_Action_Result_A_Reduce_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Component =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Attribute_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Owned_Attribute_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Attribute_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Role_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Connector_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Reception_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Component_Packaged_Element_A_Component then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Role_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Super_Class_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_General_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Structured_Activity_Node =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Activity_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Activity_Activity_Structured_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_In_Activity,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Node_Activity,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Edge_Activity_Edge_In_Structured_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Edge_In_Group,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Executable_Node_Handler_Exception_Handler_Protected_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_In_Activity_Activity_Group then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Interruptible_Region_Interruptible_Activity_Region_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Partition_Activity_Partition_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_In_Structured_Node_Structured_Activity_Node_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Input_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Postcondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Local_Precondition_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Node_Activity_Node_In_Structured_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Activity_Group_Contained_Node_In_Group,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Action_Output_A_Action then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Node_Redefined_Node_A_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Structured_Node_Input_A_Structured_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Input_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Structured_Node_Output_A_Structured_Activity_Node then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Action_Output_Action,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_Subgroup_Activity_Group_Super_Group then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Activity_Group_Super_Group_Activity_Group_Subgroup then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Activity_Node_Variable_Variable_Scope then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Instance_Value =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_Standard_Profile_L2_Source =>
         if Property = AMF.Internals.Tables.Standard_Profile_L2_Metamodel.MP_Standard_Profile_L2_Source_Base_Artifact_A_Extension_Source then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.Standard_Profile_L2_Metamodel.MA_Standard_Profile_L2_A_Extension_File_Base_Artifact,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Interaction =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Action_A_Interaction then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Collaboration_Use_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Context_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Interaction_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Operand_Interaction_Operand_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Feature_Feature_Featuring_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Formal_Gate_A_Interaction then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Interaction_Fragment_Enclosing_Interaction then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_General_Ordering_A_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Inherited_Member_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Interface_Realization_Interface_Realization_Implementing_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Lifeline_Lifeline_Interaction then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Message_Message_Interaction then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Attribute_Property_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Owned_Attribute_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Attribute_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Attribute_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Structured_Classifier_Role_Structured_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behaviored_Classifier_Owned_Behavior_A_Behaviored_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Owned_Connector_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Owned_Parameter_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Behavior_Owned_Parameter_Set_A_Behavior then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Owned_Reception_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_Feature_Featuring_Classifier,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Template_Signature_Redefinable_Template_Signature_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Templateable_Element_Owned_Template_Signature_Template,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Owned_Template_Signature_Template_Signature_Template then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Owned_Use_Case_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Redefined_Classifier_A_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Structured_Classifier_Role_A_Structured_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Substitution_Substitution_Substituting_Classifier then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Class_Super_Class_A_Class then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Classifier_General_Classifier,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Templateable_Element_Template_Binding_Template_Binding_Bound_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Classifier_Template_Parameter_Classifier_Template_Parameter_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Template_Parameter_Parametered_Element_Template_Parameter,
              Opposite,
              Element,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Behavior_Execution_Specification =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Interaction_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Operand_Interaction_Operand_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_General_Ordering_A_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Region =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Element_Import_Element_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Region_Extended_Region_A_Region then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefined_Element_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Imported_Member_A_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Member_Named_Element_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Member_Member_Namespace,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Owned_Rule_Constraint_Context then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Namespace_Package_Import_Package_Import_Importing_Namespace then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Region_Redefinition_Context_A_Region then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Redefinable_Element_Redefinition_Context_Redefinable_Element,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Region_State_State_Region then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Region_State_Machine_State_Machine_Region then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Region_Subvertex_Vertex_Container then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Region_Transition_Transition_Container then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Interaction_Constraint =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Constraint_Context_Namespace_Owned_Rule then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Constraint_Maxint_A_Interaction_Constraint then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Constraint_Minint_A_Interaction_Constraint then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Constraint_Specification_A_Owning_Constraint then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Element_Import =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Import_Imported_Element_A_Element_Import then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Import_Importing_Namespace_Namespace_Element_Import then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Component_Realization =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Component_Realization_Abstraction_Component_Realization then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Client_Named_Element_Client_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Abstraction_Mapping_A_Abstraction then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Supplier_A_Supplier_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Substitution =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Client_Named_Element_Client_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Abstraction_Mapping_A_Abstraction then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Supplier_A_Supplier_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Message_Occurrence_Specification =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Occurrence_Specification_Covered_A_Events then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Interaction_Fragment_Covered_Covered_By,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Interaction_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_Enclosing_Operand_Interaction_Operand_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Namespace_Owned_Member_Namespace,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Interaction_Fragment_General_Ordering_A_Interaction_Fragment then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
         end if;

      when AMF.Internals.Tables.UML_Types.E_UML_Abstraction =>
         if Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Client_Named_Element_Client_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Source_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Abstraction_Mapping_A_Abstraction then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Named_Element_Name_Expression_A_Named_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Element_Owned_Comment_A_Owning_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Parameterable_Element_Owning_Template_Parameter_Template_Parameter_Owned_Parametered_Element then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Element_Owned_Element_Owner,
              Opposite,
              Element,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Source_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Dependency_Supplier_A_Supplier_Dependency then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Directed_Relationship_Target_Directed_Relationship,
              Element,
              Opposite,
              Link);

         elsif Property = AMF.Internals.Tables.UML_Metamodel.MP_UML_Directed_Relationship_Target_A_Directed_Relationship then
            AMF.Internals.Links.Create_Link
             (AMF.Internals.Tables.UML_Metamodel.MA_UML_Relationship_Related_Element_Relationship,
              Element,
              Opposite,
              Link);
         end if;

      when others =>
         null;
   end case;
end Construct_Union;
