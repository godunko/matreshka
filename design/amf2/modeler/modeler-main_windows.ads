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
private with Qt4.Close_Events;
with Qt4.Main_Windows;
private with Qt4.Main_Windows.Directors;

private with AMF.Factories.UML_Factories;
private with AMF.Factories.UMLDI_Factories;
private with AMF.UML.Models;
private with AMF.URI_Stores;

package Modeler.Main_Windows is

   type Main_Window is
     limited new Qt4.Main_Windows.Q_Main_Window with private;

   type Main_Window_Access is access all Main_Window'Class;

   procedure File_New (Self : not null access Main_Window'Class);
   pragma Q_Slot (File_New);

   procedure File_Open (Self : not null access Main_Window'Class);
   pragma Q_Slot (File_Open);

   procedure New_Activity_Diagram (Self : not null access Main_Window'Class);
   pragma Q_Slot (New_Activity_Diagram);

   procedure New_Class_Diagram (Self : not null access Main_Window'Class);
   pragma Q_Slot (New_Class_Diagram);

   procedure New_Component_Diagram (Self : not null access Main_Window'Class);
   pragma Q_Slot (New_Component_Diagram);

   procedure New_Composite_Structure_Diagram (Self : not null access Main_Window'Class);
   pragma Q_Slot (New_Composite_Structure_Diagram);

   procedure New_Deployment_Diagram (Self : not null access Main_Window'Class);
   pragma Q_Slot (New_Deployment_Diagram);

   procedure New_Interaction_Diagram (Self : not null access Main_Window'Class);
   pragma Q_Slot (New_Interaction_Diagram);

   procedure New_Object_Diagram (Self : not null access Main_Window'Class);
   pragma Q_Slot (New_Object_Diagram);

   procedure New_Package_Diagram (Self : not null access Main_Window'Class);
   pragma Q_Slot (New_Package_Diagram);

   procedure New_Profile_Diagram (Self : not null access Main_Window'Class);
   pragma Q_Slot (New_Profile_Diagram);

   procedure New_State_Machine_Diagram (Self : not null access Main_Window'Class);
   pragma Q_Slot (New_State_Machine_Diagram);

   procedure New_Use_Case_Diagram (Self : not null access Main_Window'Class);
   pragma Q_Slot (New_Use_Case_Diagram);

   package Constructors is

      function Create return not null Main_Window_Access;

   end Constructors;

private

   type Main_Window is
     limited new Qt4.Main_Windows.Directors.Q_Main_Window_Director with
   record
      Store          : AMF.URI_Stores.URI_Store_Access;
      --  URI Store of the opened model.

      UML_Factory    : AMF.Factories.UML_Factories.UML_Factory_Access;
      DI_Factory     : AMF.Factories.UMLDI_Factories.UMLDI_Factory_Access;
      --  Factories to create new elements in store.

      Model          : AMF.UML.Models.UML_Model_Access;
      --  Root model element.
   end record;

   overriding procedure Close_Event
    (Self  : not null access Main_Window;
     Event : not null access Qt4.Close_Events.Q_Close_Event'Class);

end Modeler.Main_Windows;
