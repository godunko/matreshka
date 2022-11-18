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
with Qt4.Graphics_Scenes.Constructors;
with Qt4.Graphics_Views.Constructors;
with Qt4.Mdi_Sub_Windows;

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

with Modeler.Diagram_Items;
with Modeler.Diagram_Views;

package body Modeler.Diagram_Managers is

   --  XXX It looks reasonable to move code of Update_Handler into diagram view
   --  component.

   type Create_Handler (Manager : not null access Diagram_Manager) is
     limited new AMF.Visitors.UMLDI_Iterators.UMLDI_Iterator
       and AMF.Visitors.UMLDI_Visitors.UMLDI_Visitor
         with null record;

   overriding procedure Enter_UML_Activity_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Activity_Diagrams.UMLDI_UML_Activity_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Class_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Class_Diagrams.UMLDI_UML_Class_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Component_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Component_Diagrams.UMLDI_UML_Component_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Composite_Structure_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Composite_Structure_Diagrams.UMLDI_UML_Composite_Structure_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Deployment_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Deployment_Diagrams.UMLDI_UML_Deployment_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Interaction_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Interaction_Diagrams.UMLDI_UML_Interaction_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Object_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Object_Diagrams.UMLDI_UML_Object_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Package_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Package_Diagrams.UMLDI_UML_Package_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Profile_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Profile_Diagrams.UMLDI_UML_Profile_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_State_Machine_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_State_Machine_Diagrams.UMLDI_UML_State_Machine_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Enter_UML_Use_Case_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Use_Case_Diagrams.UMLDI_UML_Use_Case_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control);

   procedure Create_View
    (Self    : not null access Diagram_Manager'Class;
     Diagram : AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access);
   --  Creates QGraphicsView for the given diagram and register created view.

   -----------------
   -- Create_View --
   -----------------

   procedure Create_View
    (Self    : not null access Diagram_Manager'Class;
     Diagram : AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access)
   is
      Sub_Window    : Qt4.Mdi_Sub_Windows.Q_Mdi_Sub_Window_Access;
      Diagram_View  : Qt4.Graphics_Views.Q_Graphics_View_Access;
      Diagram_Scene : Qt4.Graphics_Scenes.Q_Graphics_Scene_Access;
      Item          : Modeler.Diagram_Items.Diagram_Item_Access;

   begin
      --  Create scene.

      Diagram_Scene := Qt4.Graphics_Scenes.Constructors.Create;

      Item := Modeler.Diagram_Items.Constructors.Create (Diagram);
      Diagram_Scene.Add_Item (Item);

      --  Create diagram view.

      Diagram_View :=
        Qt4.Graphics_Views.Q_Graphics_View_Access
         (Modeler.Diagram_Views.Constructors.Create (Diagram_Scene, Diagram));
      Sub_Window := Self.Central_Widget.Add_Sub_Window (Diagram_View);
      Diagram_View.Show;
      Self.Diagram_Map.Insert
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Diagram),
        Diagram_View);
   end Create_View;

   --------------------------------
   -- Enter_UML_Activity_Diagram --
   --------------------------------

   overriding procedure Enter_UML_Activity_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Activity_Diagrams.UMLDI_UML_Activity_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Manager.Create_View
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Activity_Diagram;

   -----------------------------
   -- Enter_UML_Class_Diagram --
   -----------------------------

   overriding procedure Enter_UML_Class_Diagram
    (Self    : in out Create_Handler;
     Element :
       not null AMF.UMLDI.UML_Class_Diagrams.UMLDI_UML_Class_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Manager.Create_View
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Class_Diagram;

   ---------------------------------
   -- Enter_UML_Component_Diagram --
   ---------------------------------

   overriding procedure Enter_UML_Component_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Component_Diagrams.UMLDI_UML_Component_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Manager.Create_View
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Component_Diagram;

   -------------------------------------------
   -- Enter_UML_Composite_Structure_Diagram --
   -------------------------------------------

   overriding procedure Enter_UML_Composite_Structure_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Composite_Structure_Diagrams.UMLDI_UML_Composite_Structure_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Manager.Create_View
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Composite_Structure_Diagram;

   ----------------------------------
   -- Enter_UML_Deployment_Diagram --
   ----------------------------------

   overriding procedure Enter_UML_Deployment_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Deployment_Diagrams.UMLDI_UML_Deployment_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Manager.Create_View
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Deployment_Diagram;

   -----------------------------------
   -- Enter_UML_Interaction_Diagram --
   -----------------------------------

   overriding procedure Enter_UML_Interaction_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Interaction_Diagrams.UMLDI_UML_Interaction_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Manager.Create_View
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Interaction_Diagram;

   ------------------------------
   -- Enter_UML_Object_Diagram --
   ------------------------------

   overriding procedure Enter_UML_Object_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Object_Diagrams.UMLDI_UML_Object_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Manager.Create_View
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Object_Diagram;

   -------------------------------
   -- Enter_UML_Package_Diagram --
   -------------------------------

   overriding procedure Enter_UML_Package_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Package_Diagrams.UMLDI_UML_Package_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Manager.Create_View
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Package_Diagram;

   -------------------------------
   -- Enter_UML_Profile_Diagram --
   -------------------------------

   overriding procedure Enter_UML_Profile_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Profile_Diagrams.UMLDI_UML_Profile_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Manager.Create_View
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Profile_Diagram;

   -------------------------------------
   -- Enter_UML_State_Machine_Diagram --
   -------------------------------------

   overriding procedure Enter_UML_State_Machine_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_State_Machine_Diagrams.UMLDI_UML_State_Machine_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Manager.Create_View
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_State_Machine_Diagram;

   --------------------------------
   -- Enter_UML_Use_Case_Diagram --
   --------------------------------

   overriding procedure Enter_UML_Use_Case_Diagram
    (Self    : in out Create_Handler;
     Element : not null
       AMF.UMLDI.UML_Use_Case_Diagrams.UMLDI_UML_Use_Case_Diagram_Access;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      Self.Manager.Create_View
       (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element));
   end Enter_UML_Use_Case_Diagram;

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      procedure Initialize
       (Self : not null access Diagram_Manager'Class;
        Central_Widget : Qt4.Mdi_Areas.Q_Mdi_Area_Access);
      --  Initialize widget.

      ------------
      -- Create --
      ------------

      function Create
       (Central_Widget : Qt4.Mdi_Areas.Q_Mdi_Area_Access)
          return not null Diagram_Manager_Access is
      begin
         return Self : constant not null Diagram_Manager_Access
           := new Diagram_Manager
         do
            Initialize (Self, Central_Widget);
         end return;
      end Create;

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self           : not null access Diagram_Manager'Class;
        Central_Widget : Qt4.Mdi_Areas.Q_Mdi_Area_Access) is
      begin
         Self.Central_Widget := Central_Widget;
         AMF.Listeners.Register_Listener
          (AMF.Listeners.Listener_Access (Self));
         --  GNAT Pro 7.1w (20120405): explicit type conversion is needed to
         --  workaround compiler's bug.
      end Initialize;

   end Constructors;

   ---------------------
   -- Instance_Create --
   ---------------------

   overriding procedure Instance_Create
    (Self    : not null access Diagram_Manager;
     Element : not null AMF.Elements.Element_Access)
   is
      Handler : Create_Handler (Self);
      Control : AMF.Visitors.Traverse_Control := AMF.Visitors.Continue;

   begin
      AMF.Visitors.Visit (Handler, Handler, Element, Control);
   end Instance_Create;

end Modeler.Diagram_Managers;
