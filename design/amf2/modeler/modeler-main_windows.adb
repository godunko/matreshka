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
with Qt4.Actions.Constructors;
with Qt4.File_Dialogs;
with Qt4.Mdi_Areas.Constructors;
with Qt4.Menu_Bars.Constructors;
with Qt4.Menus;
with Qt4.Settings.Constructors;
--with Qt4.Status_Bars.Constructors;
with Qt4.Variants;

with AMF.Facility;
with AMF.UML.Packageable_Elements.Collections;
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
with XMI.Reader;

with Modeler.Containment_Tree_Docks;
with Modeler.Diagram_Managers;

with Modeler.Main_Windows.Moc;
pragma Unreferenced (Modeler.Main_Windows.Moc);

package body Modeler.Main_Windows is

   -----------------
   -- Close_Event --
   -----------------

   overriding procedure Close_Event
    (Self  : not null access Main_Window;
     Event : not null access Qt4.Close_Events.Q_Close_Event'Class)
   is
      Settings : constant not null Qt4.Settings.Q_Settings_Access
        := Qt4.Settings.Constructors.Create;

   begin
      Settings.Begin_Group (+"MainWindow");
      Settings.Set_Value (+"size", Qt4.Variants.Create (Self.Size));
      Settings.End_Group;
      Settings.Sync;
      Settings.Delete_Later;
   end Close_Event;

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      procedure Initialize (Self : not null access Main_Window'Class);
      --  Initialize widget.

      ------------
      -- Create --
      ------------

      function Create return not null Main_Window_Access is
      begin
         return Self : constant not null Main_Window_Access
           := new Main_Window
         do
            Initialize (Self);
         end return;
      end Create;

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize (Self : not null access Main_Window'Class) is
         Settings          : constant not null Qt4.Settings.Q_Settings_Access
           := Qt4.Settings.Constructors.Create;
         Central_Widget    : Qt4.Mdi_Areas.Q_Mdi_Area_Access;
         Menu_Bar          : Qt4.Menu_Bars.Q_Menu_Bar_Access;
         Diagram_Menu      : Qt4.Menus.Q_Menu_Access;
         Diagram_Manager   : Modeler.Diagram_Managers.Diagram_Manager_Access;
--         Status_Bar : Qt4.Status_Bars.Q_Status_Bar_Access;
         Containment_Dock  :
           Modeler.Containment_Tree_Docks.Containment_Tree_Dock_Access;
         File_New_Action   : Qt4.Actions.Q_Action_Access;
         File_Open_Action  : Qt4.Actions.Q_Action_Access;

         New_Activity_Diagram_Action            : Qt4.Actions.Q_Action_Access;
         New_Class_Diagram_Action               : Qt4.Actions.Q_Action_Access;
         New_Component_Diagram_Action           : Qt4.Actions.Q_Action_Access;
         New_Composite_Structure_Diagram_Action : Qt4.Actions.Q_Action_Access;
         New_Deployment_Diagram_Action          : Qt4.Actions.Q_Action_Access;
         New_Interaction_Diagram_Action         : Qt4.Actions.Q_Action_Access;
         New_Object_Diagram_Action              : Qt4.Actions.Q_Action_Access;
         New_Package_Diagram_Action             : Qt4.Actions.Q_Action_Access;
         New_Profile_Diagram_Action             : Qt4.Actions.Q_Action_Access;
         New_State_Machine_Diagram_Action       : Qt4.Actions.Q_Action_Access;
         New_Use_Case_Diagram_Action            : Qt4.Actions.Q_Action_Access;

      begin
         Qt4.Main_Windows.Directors.Constructors.Initialize (Self);

         --  Create actions.

         File_New_Action := Qt4.Actions.Constructors.Create (+"New", Self);
         File_New_Action.Connect
          (Qt4.Signal ("triggered()"), Self, Qt4.Slot ("fileNew()"));

         File_Open_Action := Qt4.Actions.Constructors.Create (+"Open", Self);
         File_Open_Action.Connect
          (Qt4.Signal ("triggered()"), Self, Qt4.Slot ("fileOpen()"));

         New_Activity_Diagram_Action :=
           Qt4.Actions.Constructors.Create (+"New Activity Diagram", Self);
         New_Activity_Diagram_Action.Connect
          (Qt4.Signal ("triggered()"), Self, Qt4.Slot ("newActivityDiagram()"));

         New_Class_Diagram_Action :=
           Qt4.Actions.Constructors.Create (+"New Class Diagram", Self);
         New_Class_Diagram_Action.Connect
          (Qt4.Signal ("triggered()"), Self, Qt4.Slot ("newClassDiagram()"));

         New_Component_Diagram_Action :=
           Qt4.Actions.Constructors.Create (+"New Component Diagram", Self);
         New_Component_Diagram_Action.Connect
          (Qt4.Signal ("triggered()"),
           Self,
           Qt4.Slot ("newComponentDiagram()"));

         New_Composite_Structure_Diagram_Action :=
           Qt4.Actions.Constructors.Create
            (+"New Composite Structure Diagram", Self);
         New_Composite_Structure_Diagram_Action.Connect
          (Qt4.Signal ("triggered()"),
           Self,
           Qt4.Slot ("newCompositeStructureDiagram()"));

         New_Deployment_Diagram_Action :=
           Qt4.Actions.Constructors.Create (+"New Deployment Diagram", Self);
         New_Deployment_Diagram_Action.Connect
          (Qt4.Signal ("triggered()"),
           Self,
           Qt4.Slot ("newDeploymentDiagram()"));

         New_Interaction_Diagram_Action :=
           Qt4.Actions.Constructors.Create (+"New Interaction Diagram", Self);
         New_Interaction_Diagram_Action.Connect
          (Qt4.Signal ("triggered()"),
           Self,
           Qt4.Slot ("newInteractionDiagram()"));

         New_Object_Diagram_Action :=
           Qt4.Actions.Constructors.Create (+"New Object Diagram", Self);
         New_Object_Diagram_Action.Connect
          (Qt4.Signal ("triggered()"), Self, Qt4.Slot ("newObjectDiagram()"));

         New_Package_Diagram_Action :=
           Qt4.Actions.Constructors.Create (+"New Package Diagram", Self);
         New_Package_Diagram_Action.Connect
          (Qt4.Signal ("triggered()"), Self, Qt4.Slot ("newPackageDiagram()"));

         New_Profile_Diagram_Action :=
           Qt4.Actions.Constructors.Create (+"New Profile Diagram", Self);
         New_Profile_Diagram_Action.Connect
          (Qt4.Signal ("triggered()"), Self, Qt4.Slot ("newProfileDiagram()"));

         New_State_Machine_Diagram_Action :=
           Qt4.Actions.Constructors.Create (+"New State Machine Diagram", Self);
         New_State_Machine_Diagram_Action.Connect
          (Qt4.Signal ("triggered()"),
           Self,
           Qt4.Slot ("newStateMachineDiagram()"));

         New_Use_Case_Diagram_Action :=
           Qt4.Actions.Constructors.Create (+"New Use Case Diagram", Self);
         New_Use_Case_Diagram_Action.Connect
          (Qt4.Signal ("triggered()"), Self, Qt4.Slot ("newUseCaseDiagram()"));

         --  Create menu bar.

         Menu_Bar := Qt4.Menu_Bars.Constructors.Create (Self);
         Self.Set_Menu_Bar (Menu_Bar);

         Menu_Bar.Add_Action (File_New_Action);
         Menu_Bar.Add_Action (File_Open_Action);

         Diagram_Menu := Menu_Bar.Add_Menu (+"Diagram");
         Diagram_Menu.Add_Action (New_Activity_Diagram_Action);
         Diagram_Menu.Add_Action (New_Class_Diagram_Action);
         Diagram_Menu.Add_Action (New_Component_Diagram_Action);
         Diagram_Menu.Add_Action (New_Composite_Structure_Diagram_Action);
         Diagram_Menu.Add_Action (New_Deployment_Diagram_Action);
         Diagram_Menu.Add_Action (New_Interaction_Diagram_Action);
         Diagram_Menu.Add_Action (New_Object_Diagram_Action);
         Diagram_Menu.Add_Action (New_Package_Diagram_Action);
         Diagram_Menu.Add_Action (New_Profile_Diagram_Action);
         Diagram_Menu.Add_Action (New_State_Machine_Diagram_Action);
         Diagram_Menu.Add_Action (New_Use_Case_Diagram_Action);

         --  Create MDI area.

         Central_Widget := Qt4.Mdi_Areas.Constructors.Create (Self);
         Central_Widget.Set_View_Mode (Qt4.Mdi_Areas.Tabbed_View);
         Self.Set_Central_Widget (Central_Widget);

         --  Create docks.

         Containment_Dock :=
           Modeler.Containment_Tree_Docks.Constructors.Create (Self);
         Self.Add_Dock_Widget (Qt4.Left_Dock_Widget_Area, Containment_Dock);

         --  Create status bar.

--  XXX Qt4.Status_Bars.Constructors is not implemented.
--         Status_Bar := Qt4.Status_Bars.Constructors.Create (Self);
--         Self.Set_Status_Bar (Status_Bar);

         --  Restore size of the main window.

         Settings.Begin_Group (+"MainWindow");

         if Settings.Contains (+"size") then
            Self.Resize (Settings.Value (+"size").To_Size);
         end if;

         Settings.End_Group;
         Settings.Delete_Later;

         Diagram_Manager :=
           Modeler.Diagram_Managers.Constructors.Create (Central_Widget);
      end Initialize;

   end Constructors;

   --------------
   -- File_New --
   --------------

   procedure File_New (Self : not null access Main_Window'Class) is
   begin
      Self.Store := AMF.Facility.Create_URI_Store (+"file:///untitled.xmi");
      Self.UML_Factory :=
        AMF.Factories.UML_Factories.UML_Factory_Access
         (Self.Store.Get_Factory (+"http://www.omg.org/spec/UML/20100901"));
      Self.DI_Factory :=
        AMF.Factories.UMLDI_Factories.UMLDI_Factory_Access
         (Self.Store.Get_Factory
           (+"http://www.omg.org/spec/UML/20120801/UMLDI"));
      Self.Model := Self.UML_Factory.Create_Model;
      Self.Model.Set_Name ((False, +"UML Model"));
   end File_New;

   ---------------
   -- File_Open --
   ---------------

   procedure File_Open (Self : not null access Main_Window'Class) is
      Name : constant Qt4.Strings.Q_String
        := Qt4.File_Dialogs.Get_Open_File_Name (Self);

   begin
      if not Name.Is_Null then
         Self.Store := XMI.Reader.Read_URI (+Name.To_UCS_4);
      end if;
   end File_Open;

   --------------------------
   -- New_Activity_Diagram --
   --------------------------

   procedure New_Activity_Diagram (Self : not null access Main_Window'Class) is
      Diagram      :
        AMF.UMLDI.UML_Activity_Diagrams.UMLDI_UML_Activity_Diagram_Access;
      Elements     :
        AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element;

   begin
      --  Create new Activity diagram element.

      Diagram := Self.DI_Factory.Create_UML_Activity_Diagram;
      Diagram.Set_Name (+"Activity Diagram");
      Elements := Self.Model.Get_Packaged_Element;
      Elements.Add (Diagram);
   end New_Activity_Diagram;

   -----------------------
   -- New_Class_Diagram --
   -----------------------

   procedure New_Class_Diagram (Self : not null access Main_Window'Class) is
      Diagram      :
        AMF.UMLDI.UML_Class_Diagrams.UMLDI_UML_Class_Diagram_Access;
      Elements     :
        AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element;

   begin
      --  Create new class diagram element.

      Diagram := Self.DI_Factory.Create_UML_Class_Diagram;
      Diagram.Set_Name (+"Class Diagram");
      Elements := Self.Model.Get_Packaged_Element;
      Elements.Add (Diagram);
   end New_Class_Diagram;

   ---------------------------
   -- New_Component_Diagram --
   ---------------------------

   procedure New_Component_Diagram (Self : not null access Main_Window'Class) is
      Diagram      :
        AMF.UMLDI.UML_Component_Diagrams.UMLDI_UML_Component_Diagram_Access;
      Elements     :
        AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element;

   begin
      --  Create new Component diagram element.

      Diagram := Self.DI_Factory.Create_UML_Component_Diagram;
      Diagram.Set_Name (+"Component Diagram");
      Elements := Self.Model.Get_Packaged_Element;
      Elements.Add (Diagram);
   end New_Component_Diagram;

   -------------------------------------
   -- New_Composite_Structure_Diagram --
   -------------------------------------

   procedure New_Composite_Structure_Diagram (Self : not null access Main_Window'Class) is
      Diagram      :
        AMF.UMLDI.UML_Composite_Structure_Diagrams.UMLDI_UML_Composite_Structure_Diagram_Access;
      Elements     :
        AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element;

   begin
      --  Create new Composite_Structure diagram element.

      Diagram := Self.DI_Factory.Create_UML_Composite_Structure_Diagram;
      Diagram.Set_Name (+"Composite Structure Diagram");
      Elements := Self.Model.Get_Packaged_Element;
      Elements.Add (Diagram);
   end New_Composite_Structure_Diagram;

   ----------------------------
   -- New_Deployment_Diagram --
   ----------------------------

   procedure New_Deployment_Diagram (Self : not null access Main_Window'Class) is
      Diagram      :
        AMF.UMLDI.UML_Deployment_Diagrams.UMLDI_UML_Deployment_Diagram_Access;
      Elements     :
        AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element;

   begin
      --  Create new Deployment diagram element.

      Diagram := Self.DI_Factory.Create_UML_Deployment_Diagram;
      Diagram.Set_Name (+"Deployment Diagram");
      Elements := Self.Model.Get_Packaged_Element;
      Elements.Add (Diagram);
   end New_Deployment_Diagram;

   -----------------------------
   -- New_Interaction_Diagram --
   -----------------------------

   procedure New_Interaction_Diagram (Self : not null access Main_Window'Class) is
      Diagram      :
        AMF.UMLDI.UML_Interaction_Diagrams.UMLDI_UML_Interaction_Diagram_Access;
      Elements     :
        AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element;

   begin
      --  Create new Interaction diagram element.

      Diagram := Self.DI_Factory.Create_UML_Interaction_Diagram;
      Diagram.Set_Name (+"Interaction Diagram");
      Elements := Self.Model.Get_Packaged_Element;
      Elements.Add (Diagram);
   end New_Interaction_Diagram;

   ------------------------
   -- New_Object_Diagram --
   ------------------------

   procedure New_Object_Diagram (Self : not null access Main_Window'Class) is
      Diagram      :
        AMF.UMLDI.UML_Object_Diagrams.UMLDI_UML_Object_Diagram_Access;
      Elements     :
        AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element;

   begin
      --  Create new Object diagram element.

      Diagram := Self.DI_Factory.Create_UML_Object_Diagram;
      Diagram.Set_Name (+"Object Diagram");
      Elements := Self.Model.Get_Packaged_Element;
      Elements.Add (Diagram);
   end New_Object_Diagram;

   -------------------------
   -- New_Package_Diagram --
   -------------------------

   procedure New_Package_Diagram (Self : not null access Main_Window'Class) is
      Diagram      :
        AMF.UMLDI.UML_Package_Diagrams.UMLDI_UML_Package_Diagram_Access;
      Elements     :
        AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element;

   begin
      --  Create new Package diagram element.

      Diagram := Self.DI_Factory.Create_UML_Package_Diagram;
      Diagram.Set_Name (+"Package Diagram");
      Elements := Self.Model.Get_Packaged_Element;
      Elements.Add (Diagram);
   end New_Package_Diagram;

   -------------------------
   -- New_Profile_Diagram --
   -------------------------

   procedure New_Profile_Diagram (Self : not null access Main_Window'Class) is
      Diagram      :
        AMF.UMLDI.UML_Profile_Diagrams.UMLDI_UML_Profile_Diagram_Access;
      Elements     :
        AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element;

   begin
      --  Create new Profile diagram element.

      Diagram := Self.DI_Factory.Create_UML_Profile_Diagram;
      Diagram.Set_Name (+"Profile Diagram");
      Elements := Self.Model.Get_Packaged_Element;
      Elements.Add (Diagram);
   end New_Profile_Diagram;

   -------------------------------
   -- New_State_Machine_Diagram --
   -------------------------------

   procedure New_State_Machine_Diagram (Self : not null access Main_Window'Class) is
      Diagram      :
        AMF.UMLDI.UML_State_Machine_Diagrams.UMLDI_UML_State_Machine_Diagram_Access;
      Elements     :
        AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element;

   begin
      --  Create new State_Machine diagram element.

      Diagram := Self.DI_Factory.Create_UML_State_Machine_Diagram;
      Diagram.Set_Name (+"State Machine Diagram");
      Elements := Self.Model.Get_Packaged_Element;
      Elements.Add (Diagram);
   end New_State_Machine_Diagram;

   --------------------------
   -- New_Use_Case_Diagram --
   --------------------------

   procedure New_Use_Case_Diagram (Self : not null access Main_Window'Class) is
      Diagram      :
        AMF.UMLDI.UML_Use_Case_Diagrams.UMLDI_UML_Use_Case_Diagram_Access;
      Elements     :
        AMF.UML.Packageable_Elements.Collections.Set_Of_UML_Packageable_Element;

   begin
      --  Create new Use_Case diagram element.

      Diagram := Self.DI_Factory.Create_UML_Use_Case_Diagram;
      Diagram.Set_Name (+"Use Case Diagram");
      Elements := Self.Model.Get_Packaged_Element;
      Elements.Add (Diagram);
   end New_Use_Case_Diagram;

end Modeler.Main_Windows;
