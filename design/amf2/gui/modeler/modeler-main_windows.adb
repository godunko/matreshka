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
-- Copyright © 2011, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Qt4.Actions;
with Qt4.Dock_Widgets.Constructors;
with Qt4.Menu_Bars.Constructors;
with Qt4.Menus;
with Qt4.Objects;
with Qt4.Settings.Constructors;
with Qt4.Strings;
with Qt4.Tree_Views.Constructors;
with Qt4.Variants;

with Modeler.Containment_Tree_Models;
with Modeler.Diagram_Scenes;
with Modeler.Diagram_Views;
with Modeler.Main_Windows.MOC;
pragma Unreferenced (Modeler.Main_Windows.MOC);

package body Modeler.Main_Windows is

   function "+" (Item : String) return Qt4.Strings.Q_String
     renames Qt4.Strings.From_Utf_8;

   -----------------
   -- Close_Event --
   -----------------

   overriding procedure Close_Event
     (Self  : not null access Main_Window;
      Event : not null access Qt4.Close_Events.Q_Close_Event'Class)
   is
      Settings : constant not null Qt4.Settings.Q_Settings_Access :=
        Qt4.Settings.Constructors.Create;

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
         Settings     : constant not null Qt4.Settings.Q_Settings_Access
           := Qt4.Settings.Constructors.Create;
         Menu_Bar     : Qt4.Menu_Bars.Q_Menu_Bar_Access;
         Menu         : Qt4.Menus.Q_Menu_Access;
         Action       : Qt4.Actions.Q_Action_Access;
         Dock         : Qt4.Dock_Widgets.Q_Dock_Widget_Access;
         Tree_View    : Qt4.Tree_Views.Q_Tree_View_Access;
         Tree_Model   :
           Modeler.Containment_Tree_Models.Containment_Tree_Model_Access;
         Scene        : Modeler.Diagram_Scenes.Diagram_Scene_Access;
         Diagram_View : Modeler.Diagram_Views.Diagram_View_Access;

      begin
         Qt4.Main_Windows.Directors.Constructors.Initialize (Self);

         --  Create components of main window.

         Menu_Bar := Qt4.Menu_Bars.Constructors.Create (Self);
         Menu := Menu_Bar.Add_Menu (+"&File");
         Action := Menu.Add_Action (+"&Quit");
         Qt4.Objects.Connect
          (Action, Qt4.Signal ("triggered(bool)"),
           Self, Qt4.Slot ("quit()"));

         Dock := Qt4.Dock_Widgets.Constructors.Create (Self);
         Tree_Model := Modeler.Containment_Tree_Models.Constructors.Create;
         Tree_View := Qt4.Tree_Views.Constructors.Create (Dock);
         Tree_View.Set_Model (Tree_Model);
         Tree_View.Set_Drag_Enabled (True);
         Dock.Set_Widget (Tree_View);
         Dock.Set_Window_Title (+"Containment");

         Scene := Modeler.Diagram_Scenes.Constructors.Create;
         Diagram_View := Modeler.Diagram_Views.Constructors.Create (Self);
         Diagram_View.Set_Scene (Scene);

         --  Set components of main window.

         Self.Set_Menu_Bar (Menu_Bar);
         Self.Set_Central_Widget (Diagram_View);
         Self.Add_Dock_Widget (Qt4.Left_Dock_Widget_Area, Dock);

         --  Restore size of the window.

         Settings.Begin_Group (+"MainWindow");

         if Settings.Contains (+"size") then
            Self.Resize (Settings.Value (+"size").To_Size);
         end if;

         Settings.End_Group;
         Settings.Delete_Later;
      end Initialize;

   end Constructors;

   ----------
   -- Quit --
   ----------

   procedure Quit (Self : not null access Main_Window'Class) is
   begin
      null;
   end Quit;

end Modeler.Main_Windows;
