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
with Qt4.Graphics_Views.Constructors;
with Qt4.Mdi_Sub_Windows;

with AMF.UMLDI.UML_Class_Diagrams;

package body Modeler.Diagram_Managers is

   -------------------
   -- Attribute_Set --
   -------------------

   overriding procedure Attribute_Set
    (Self      : not null access Diagram_Manager;
     Element   : not null AMF.Elements.Element_Access;
     Property  : not null AMF.CMOF.Properties.CMOF_Property_Access;
     Position  : AMF.Optional_Integer;
     Old_Value : League.Holders.Holder;
     New_Value : League.Holders.Holder)
   is
      use type AMF.Optional_String;

      Diagram : AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access;

   begin
      if Element.all
           in AMF.UMLDI.UML_Class_Diagrams.UMLDI_UML_Class_Diagram'Class
      then
         Diagram := AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element);

         if Property.Get_Name = +"name" then
            Self.Diagram_Map.Element (Diagram).Set_Window_Title
             (+League.Holders.Element (New_Value));
         end if;
      end if;
   end Attribute_Set;

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
         AMF.Listeners.Register (AMF.Listeners.Listener_Access (Self));
      end Initialize;

   end Constructors;

   ---------------------
   -- Instance_Create --
   ---------------------

   overriding procedure Instance_Create
    (Self    : not null access Diagram_Manager;
     Element : not null AMF.Elements.Element_Access)
   is
      Sub_Window   : Qt4.Mdi_Sub_Windows.Q_Mdi_Sub_Window_Access;
      Diagram_View : Qt4.Graphics_Views.Q_Graphics_View_Access;

   begin
      --  Much better to use iterator/visitor here.

      if Element.all
           in AMF.UMLDI.UML_Class_Diagrams.UMLDI_UML_Class_Diagram'Class
      then
         --  Create diagram view.

         Diagram_View := Qt4.Graphics_Views.Constructors.Create;
         Sub_Window := Self.Central_Widget.Add_Sub_Window (Diagram_View);
         Diagram_View.Show;
         Self.Diagram_Map.Insert
          (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access (Element),
           Diagram_View);
      end if;
   end Instance_Create;

end Modeler.Diagram_Managers;
