------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Ada Modeling Framework                          --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2012, Vadim Godunko <vgodunko@gmail.com>                     --
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
with AMF.UMLDI.UML_Activity_Diagrams;
with AMF.UMLDI.UML_Class_Diagrams;
with AMF.UMLDI.UML_Component_Diagrams;
with AMF.UMLDI.UML_Composite_Structure_Diagrams;
with AMF.UMLDI.UML_Deployment_Diagrams;
with AMF.UMLDI.UML_Interaction_Diagrams;
with AMF.UMLDI.UML_Object_Diagrams;
with AMF.UMLDI.UML_Package_Diagrams;
with AMF.UMLDI.UML_Profile_Diagrams;
with AMF.UMLDI.UML_State_Machine_Diagrams;
with AMF.UMLDI.UML_Use_Case_Diagrams;
with AMF.Visitors.UMLDI_Iterators;
with AMF.Visitors.UMLDI_Visitors;

with Modeler.Diagram_Views.Moc;
pragma Unreferenced (Modeler.Diagram_Views.Moc);

package body Modeler.Diagram_Views is

   type Update_Handler (Manager : not null access Diagram_View'Class) is
     limited new AMF.Visitors.UMLDI_Iterators.UMLDI_Iterator
       and AMF.Visitors.UMLDI_Visitors.UMLDI_Visitor with
   record
     Property  : not null AMF.CMOF.Properties.CMOF_Property_Access;
     New_Value : League.Holders.Holder;
   end record;

   overriding procedure Enter_UML_Activity_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Activity_Diagrams.UMLDI_UML_Activity_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Class_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Class_Diagrams.UMLDI_UML_Class_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Component_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Component_Diagrams.UMLDI_UML_Component_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Composite_Structure_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Composite_Structure_Diagrams.UMLDI_UML_Composite_Structure_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Deployment_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Deployment_Diagrams.UMLDI_UML_Deployment_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Interaction_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Interaction_Diagrams.UMLDI_UML_Interaction_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Object_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Object_Diagrams.UMLDI_UML_Object_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Package_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Package_Diagrams.UMLDI_UML_Package_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Profile_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Profile_Diagrams.UMLDI_UML_Profile_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_State_Machine_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_State_Machine_Diagrams.UMLDI_UML_State_Machine_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Use_Case_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Use_Case_Diagrams.UMLDI_UML_Use_Case_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   procedure Enter_UML_Diagram
    (Self    : in out Update_Handler'Class;
     Element : not null AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access);
   --  Updates diagram.

   --------------------------------
   -- Enter_UML_Activity_Diagram --
   --------------------------------

   overriding procedure Enter_UML_Activity_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Activity_Diagrams.UMLDI_UML_Activity_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Enter_UML_Diagram
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Activity_Diagram;

   -----------------------------
   -- Enter_UML_Class_Diagram --
   -----------------------------

   overriding procedure Enter_UML_Class_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Class_Diagrams.UMLDI_UML_Class_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Enter_UML_Diagram
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Class_Diagram;

   ---------------------------------
   -- Enter_UML_Component_Diagram --
   ---------------------------------

   overriding procedure Enter_UML_Component_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Component_Diagrams.UMLDI_UML_Component_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Enter_UML_Diagram
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Component_Diagram;

   -------------------------------------------
   -- Enter_UML_Composite_Structure_Diagram --
   -------------------------------------------

   overriding procedure Enter_UML_Composite_Structure_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Composite_Structure_Diagrams.UMLDI_UML_Composite_Structure_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Enter_UML_Diagram
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Composite_Structure_Diagram;

   ----------------------------------
   -- Enter_UML_Deployment_Diagram --
   ----------------------------------

   overriding procedure Enter_UML_Deployment_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Deployment_Diagrams.UMLDI_UML_Deployment_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Enter_UML_Diagram
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Deployment_Diagram;

   -----------------------------------
   -- Enter_UML_Interaction_Diagram --
   -----------------------------------

   overriding procedure Enter_UML_Interaction_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Interaction_Diagrams.UMLDI_UML_Interaction_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Enter_UML_Diagram
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Interaction_Diagram;

   ------------------------------
   -- Enter_UML_Object_Diagram --
   ------------------------------

   overriding procedure Enter_UML_Object_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Object_Diagrams.UMLDI_UML_Object_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Enter_UML_Diagram
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Object_Diagram;

   -------------------------------
   -- Enter_UML_Package_Diagram --
   -------------------------------

   overriding procedure Enter_UML_Package_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Package_Diagrams.UMLDI_UML_Package_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Enter_UML_Diagram
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Package_Diagram;

   -------------------------------
   -- Enter_UML_Profile_Diagram --
   -------------------------------

   overriding procedure Enter_UML_Profile_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Profile_Diagrams.UMLDI_UML_Profile_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Enter_UML_Diagram
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Profile_Diagram;

   -------------------------------------
   -- Enter_UML_State_Machine_Diagram --
   -------------------------------------

   overriding procedure Enter_UML_State_Machine_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_State_Machine_Diagrams.UMLDI_UML_State_Machine_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Enter_UML_Diagram
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_State_Machine_Diagram;

   --------------------------------
   -- Enter_UML_Use_Case_Diagram --
   --------------------------------

   overriding procedure Enter_UML_Use_Case_Diagram
    (Self    : in out Update_Handler;
     Element : not null
       AMF.UMLDI.UML_Use_Case_Diagrams.UMLDI_UML_Use_Case_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Enter_UML_Diagram
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Use_Case_Diagram;

   -----------------------
   -- Enter_UML_Diagram --
   -----------------------

   procedure Enter_UML_Diagram
    (Self    : in out Update_Handler'Class;
     Element : not null AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access)
   is
      use type AMF.Optional_String;

   begin
      if Self.Property.Get_Name = +"name" then
         Self.Manager.Set_Window_Title
          (+League.Holders.Element (Self.New_Value));
      end if;
   end Enter_UML_Diagram;

   -------------------
   -- Attribute_Set --
   -------------------

   overriding procedure Attribute_Set
    (Self      : not null access Diagram_View;
     Element   : not null AMF.Elements.Element_Access;
     Property  : not null AMF.CMOF.Properties.CMOF_Property_Access;
     Position  : AMF.Optional_Integer;
     Old_Value : League.Holders.Holder;
     New_Value : League.Holders.Holder)
   is
      Handler : Update_Handler := (Self, Property, New_Value);
      Control : AMF.Visitors.Traverse_Control := AMF.Visitors.Continue;

   begin
      AMF.Visitors.Visit (Handler, Handler, Element, Control);
   end Attribute_Set;

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      procedure Initialize
       (Self    : not null access Diagram_View'Class;
        Scene   : not null Qt4.Graphics_Scenes.Q_Graphics_Scene_Access;
        Diagram : not null AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access;
        Parent  : access Qt4.Widgets.Q_Widget'Class);

      ------------
      -- Create --
      ------------

      function Create
       (Scene   : not null Qt4.Graphics_Scenes.Q_Graphics_Scene_Access;
        Diagram : not null AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access;
        Parent  : access Qt4.Widgets.Q_Widget'Class := null)
          return not null Diagram_View_Access is
      begin
         return Self : constant not null Diagram_View_Access
           := new Diagram_View
         do
            Initialize (Self, Scene, Diagram, Parent);
         end return;
      end Create;

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self    : not null access Diagram_View'Class;
        Scene   : not null Qt4.Graphics_Scenes.Q_Graphics_Scene_Access;
        Diagram : not null AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access;
        Parent  : access Qt4.Widgets.Q_Widget'Class)
      is
         use type AMF.Real;

      begin
         Qt4.Graphics_Views.Directors.Constructors.Initialize (Self, Scene, Parent);

         AMF.Listeners.Register_Instance_Listener
          (AMF.Listeners.Listener_Access (Self),
           AMF.Elements.Element_Access (Diagram));

         --  Scale view to map diagram elements to physical size correctly.

         Self.Scale
          (Qt4.Q_Real
            (AMF.Real (Self.Physical_Dpi_X) / Diagram.Get_Resolution),
           Qt4.Q_Real
            (AMF.Real (Self.Physical_Dpi_Y) / Diagram.Get_Resolution));
      end Initialize;

   end Constructors;

end Modeler.Diagram_Views;
