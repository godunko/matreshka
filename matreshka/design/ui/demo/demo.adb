------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2016, Vadim Godunko <vgodunko@gmail.com>                     --
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

with League.Strings;

with WebAPI.HTML.Elements;
with WebAPI.HTML.Globals;

with UI.Actions;
with UI.Widgets.Grid_Views;
with UI.Widgets.Menu_Bars;
with UI.Widgets.Menus;
with UI.Widgets.Windows;

with Demo_Actions;
with Grid;

procedure Demo is

   procedure Create_Menu (Top  : UI.Widgets.Windows.Window_Access);
   procedure Create_Grid (Top  : UI.Widgets.Windows.Window_Access);

   procedure Create_Grid (Top  : UI.Widgets.Windows.Window_Access) is
      Grid_View : UI.Widgets.Grid_Views.Grid_View_Access :=
        new UI.Widgets.Grid_Views.Grid_View;
   begin
      Grid.Initialize (Grid.Model);
      UI.Widgets.Grid_Views.Constructors.Initialize (Grid_View.all, Top);
      Grid_View.Set_Model (Grid.Header'Access, Grid.Model'Access);
   end Create_Grid;

   procedure Create_Menu (Top  : UI.Widgets.Windows.Window_Access) is

      procedure Add_Menu_Item
        (Top  : UI.Widgets.Windows.Window_Access;
         Menu : UI.Widgets.Menus.Menu_Access;
         Text : Wide_Wide_String);

      procedure Add_Menu_Item
        (Top  : UI.Widgets.Windows.Window_Access;
         Menu : UI.Widgets.Menus.Menu_Access;
         Text : Wide_Wide_String)
      is
         Action : Demo_Actions.Demo_Action_Access :=
           new Demo_Actions.Demo_Action;
      begin
         Action.Window := Top;
         UI.Actions.Constructors.Initialize
           (Action.all, League.Strings.To_Universal_String (Text));
         Menu.Add_Action (UI.Actions.Action_Access (Action));
      end Add_Menu_Item;

      Menu_Bar : UI.Widgets.Menu_Bars.Menu_Bar_Access :=
        new UI.Widgets.Menu_Bars.Menu_Bar;
      Menu_1 : UI.Widgets.Menus.Menu_Access :=
        new UI.Widgets.Menus.Menu;
      Menu_2 : UI.Widgets.Menus.Menu_Access :=
        new UI.Widgets.Menus.Menu;
   begin
      UI.Widgets.Menu_Bars.Constructors.Initialize
        (Menu_Bar.all, Top);
      UI.Widgets.Menus.Constructors.Initialize
        (Menu_1.all, Menu_Bar, League.Strings.To_Universal_String ("test"));
      UI.Widgets.Menus.Constructors.Initialize
        (Menu_2.all, Menu_Bar, League.Strings.To_Universal_String ("test 2"));

      Add_Menu_Item (Top, Menu_1, "Item 1");
      Add_Menu_Item (Top, Menu_1, "Item 2");
      Add_Menu_Item (Top, Menu_1, "Item 3");

      Add_Menu_Item (Top, Menu_2, "Item 21");
      Add_Menu_Item (Top, Menu_2, "Item 22");
      Add_Menu_Item (Top, Menu_2, "Item 23");

      Menu_Bar.Add_Menu (Menu_1);
      Menu_Bar.Add_Menu (Menu_2);
   end Create_Menu;

   Element : constant WebAPI.HTML.Elements.HTML_Element_Access
     := WebAPI.HTML.Elements.HTML_Element_Access
       (WebAPI.HTML.Globals.Window.Get_Document.Get_Element_By_Id
          (League.Strings.To_Universal_String ("top")));
   Top : UI.Widgets.Windows.Window_Access :=
     new UI.Widgets.Windows.Window;
   Win_1 : UI.Widgets.Windows.Window_Access :=
     new UI.Widgets.Windows.Window;
begin
   UI.Widgets.Windows.Constructors.Initialize
     (Top.all, Element);

   Create_Menu (Top);

   UI.Widgets.Windows.Constructors.Initialize
     (Win_1.all, Top, League.Strings.To_Universal_String ("Window one"));

   Create_Grid (Win_1);
   Create_Menu (Win_1);
end Demo;
