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
--  Diagram Manager handles creation/modification/destruction of diagrams in
--  model and reflect these changes in GUI components.
------------------------------------------------------------------------------
private with Ada.Containers.Hashed_Maps;

private with Qt4.Graphics_Views;
with Qt4.Mdi_Areas;

private with AMF.CMOF.Properties;
private with AMF.Elements;
with AMF.Listeners;
private with AMF.UMLDI.UML_Diagrams.Hash;
private with League.Holders;

package Modeler.Diagram_Managers is

   type Diagram_Manager is
      limited new AMF.Listeners.Abstract_Listener with private;

   type Diagram_Manager_Access is access all Diagram_Manager'Class;

   package Constructors is

      function Create
       (Central_Widget : Qt4.Mdi_Areas.Q_Mdi_Area_Access)
          return not null Diagram_Manager_Access;

   end Constructors;

private

   package Diagram_Maps is
     new Ada.Containers.Hashed_Maps
          (AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram_Access,
           Qt4.Graphics_Views.Q_Graphics_View_Access,
           AMF.UMLDI.UML_Diagrams.Hash,
           AMF.UMLDI.UML_Diagrams."=",
           Qt4.Graphics_Views."=");

   type Diagram_Manager is
     limited new AMF.Listeners.Abstract_Listener with
   record
      Central_Widget : Qt4.Mdi_Areas.Q_Mdi_Area_Access;
      --  Central widget of main window.

      Diagram_Map    : Diagram_Maps.Map;
      --  Map from UMLDiagram to QGraphivsView.
   end record;

   overriding procedure Instance_Create
    (Self    : not null access Diagram_Manager;
     Element : not null AMF.Elements.Element_Access);

   overriding procedure Attribute_Set
    (Self      : not null access Diagram_Manager;
     Element   : not null AMF.Elements.Element_Access;
     Property  : not null AMF.CMOF.Properties.CMOF_Property_Access;
     Position  : AMF.Optional_Integer;
     Old_Value : League.Holders.Holder;
     New_Value : League.Holders.Holder);

end Modeler.Diagram_Managers;
