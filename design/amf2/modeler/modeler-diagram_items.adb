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
with Qt4.Actions;
with Qt4.Menus.Constructors;

package body Modeler.Diagram_Items is

   -------------------
   -- Bounding_Rect --
   -------------------

   overriding function Bounding_Rect
    (Self : not null access constant Diagram_Item) return Qt4.Rect_Fs.Q_Rect_F is
   begin
      return Qt4.Rect_Fs.Create (0.0, 0.0, 3507.0, 2480.0);
--      return Qt4.Rect_Fs.Create (0.0, 0.0, 150.0, 100.0);
   end Bounding_Rect;

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      procedure Initialize
       (Self    : not null access Diagram_Item'Class;
        Diagram :
         not null access AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram'Class;
        Parent  : access Qt4.Graphics_Items.Q_Graphics_Item'Class);

      ------------
      -- Create --
      ------------

      function Create
       (Diagram :
         not null access AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram'Class;
        Parent  : access Qt4.Graphics_Items.Q_Graphics_Item'Class := null)
          return not null Diagram_Item_Access is
      begin
         return Self : constant not null Diagram_Item_Access
           := new Diagram_Item
         do
            Initialize (Self, Diagram, Parent);
         end return;
      end Create;

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self    : not null access Diagram_Item'Class;
        Diagram :
         not null access AMF.UMLDI.UML_Diagrams.UMLDI_UML_Diagram'Class;
        Parent  : access Qt4.Graphics_Items.Q_Graphics_Item'Class) is
      begin
         Qt4.Graphics_Items.Directors.Constructors.Initialize (Self, Parent);
      end Initialize;

   end Constructors;

   ------------------------
   -- Context_Menu_Event --
   ------------------------

   overriding procedure Context_Menu_Event
    (Self  : not null access Diagram_Item;
     Event : not null access
       Qt4.Graphics_Scene_Context_Menu_Events.Q_Graphics_Scene_Context_Menu_Event'Class)
   is
      Action : Qt4.Actions.Q_Action_Access;
      Menu   : Qt4.Menus.Q_Menu_Access;

   begin
      Event.Set_Accepted (True);
      Menu := Qt4.Menus.Constructors.Create;
      Action := Menu.Add_Action (+"Create");
      Action := Menu.Exec (Event.Screen_Pos);
      Menu.Delete_Later;
   end Context_Menu_Event;

   -----------
   -- Paint --
   -----------

   overriding procedure Paint
    (Self    : not null access Diagram_Item;
     Painter : in out Qt4.Painters.Q_Painter'Class;
     Option  :
       Qt4.Style_Option_Graphics_Items.Q_Style_Option_Graphics_Item'Class;
     Widget  : access Qt4.Widgets.Q_Widget'Class := null) is
   begin
      Painter.Draw_Rect (Qt4.Rect_Fs.Create (0.0, 0.0, 3507.0, 2480.0));
--      Painter.Draw_Rect (Qt4.Rect_Fs.Create (0.0, 0.0, 150.0, 100.0));
   end Paint;

end Modeler.Diagram_Items;
