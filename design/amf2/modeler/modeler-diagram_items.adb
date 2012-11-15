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
with Qt4.Styles;

package body Modeler.Diagram_Items is

   use type Qt4.Q_Real;

   -------------------
   -- Bounding_Rect --
   -------------------

   overriding function Bounding_Rect
    (Self : not null access constant Diagram_Item)
       return Qt4.Rect_Fs.Q_Rect_F is
   begin
      return Qt4.Rect_Fs.Create (-10.0, -10.0, 3527.0, 2500.0);
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
            Self.Set_Flag (Qt4.Graphics_Items.Item_Is_Selectable);
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
     Widget  : access Qt4.Widgets.Q_Widget'Class := null)
   is
      State : constant Qt4.Styles.State := Option.State;

      --------------------
      -- Draw_Selection --
      --------------------

      procedure Draw_Selection (X, Y, Width, Height, Scale : Qt4.Q_Real) is
         Offset   : constant Qt4.Q_Real := 2.0 / Scale;
         Offset_2 : constant Qt4.Q_Real := 2.0 * Offset;
         Offset_3 : constant Qt4.Q_Real := 3.0 / Scale;
         One      : constant Qt4.Q_Real := 1.0 / Scale;
         Size     : constant Qt4.Q_Real := 4.0 / Scale;
         X2       : constant Qt4.Q_Real := (X + Width) / 2.0;
         Y2       : constant Qt4.Q_Real := (Y + Height) / 2.0;
         Size2    : constant Qt4.Q_Real := Size / 2.0;

      begin
         Painter.Draw_Rect
          (Qt4.Rect_Fs.Create
            (X - Offset, Y - Offset, Width + Offset_2, Height + Offset_2));
         Painter.Fill_Rect
          (Qt4.Rect_Fs.Create
            (X - Offset - Size + One + One,
             Y - Offset - Size + One + One,
             Size,
             Size),
           Qt4.Solid_Pattern);
         Painter.Fill_Rect
          (Qt4.Rect_Fs.Create (X + Width, Y + Height + One, Size, Size),
           Qt4.Solid_Pattern);
         Painter.Fill_Rect
          (Qt4.Rect_Fs.Create
            (X + Width, Y - Offset - Size + One + One, Size, Size),
           Qt4.Solid_Pattern);
         Painter.Fill_Rect
          (Qt4.Rect_Fs.Create
            (X - Offset - Size + One + One, Y + Height + One, Size, Size),
           Qt4.Solid_Pattern);

         Painter.Fill_Rect
          (Qt4.Rect_Fs.Create
            (X2 - Size2, Y - Offset - Size + One + One, Size, Size),
           Qt4.Solid_Pattern);
         Painter.Fill_Rect
          (Qt4.Rect_Fs.Create (X + Width, Y2 - Size2, Size, Size),
           Qt4.Solid_Pattern);
         Painter.Fill_Rect
          (Qt4.Rect_Fs.Create (X2 - Size2, Y + Height + One, Size, Size),
           Qt4.Solid_Pattern);
         Painter.Fill_Rect
          (Qt4.Rect_Fs.Create
            (X - Offset - Size + One + One, Y2 - Size2, Size, Size),
           Qt4.Solid_Pattern);
      end Draw_Selection;

   begin
      Painter.Draw_Rect (Qt4.Rect_Fs.Create (0.0, 0.0, 3507.0, 2480.0));
--      Painter.Draw_Rect (Qt4.Rect_Fs.Create (0.0, 0.0, 150.0, 100.0));

      --  Draw selection rectangle.

      if Qt4.Styles.Is_Set (State, Qt4.Styles.State_Selected) then
         Draw_Selection
          (0.0,
           0.0,
           3507.0,
           2480.0,
           Qt4.Style_Option_Graphics_Items.Level_Of_Detail_From_Transform
            (Painter.World_Transform));
         null;
      end if;
   end Paint;

end Modeler.Diagram_Items;
