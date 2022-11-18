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
-- Copyright © 2016-2017, Vadim Godunko <vgodunko@gmail.com>                --
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
with WebAPI.DOM.Documents;
with WebAPI.DOM.Elements;
with WebAPI.DOM.Nodes;

package body WUI.Widgets.Menus is

   package Menu_Items is

      type Menu_Item is new WUI.Widgets.Abstract_Widget with record
         Title  : League.Strings.Universal_String;
         Action : WUI.Actions.Action_Access;
      end record;

      type Menu_Item_Access is access all Menu_Item'Class;
      --     with Storage_Size => 0;

      overriding procedure Click_Event
       (Self  : in out Menu_Item;
        Event : in out WUI.Events.Mouse.Click.Click_Event'Class);

      procedure Initialize
       (Self    : in out Menu_Item'Class;
        Parent  : in out Menu'Class;
        Action  : WUI.Actions.Action_Access);

   end Menu_Items;

   ----------------
   -- Menu_Items --
   ----------------

   package body Menu_Items is

      -----------------
      -- Click_Event --
      -----------------

      overriding procedure Click_Event
       (Self  : in out Menu_Item;
        Event : in out WUI.Events.Mouse.Click.Click_Event'Class) is
      begin
         Self.Action.Triggered_Event (Event);
      end Click_Event;

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self   : in out Menu_Item'Class;
        Parent : in out Menu'Class;
        Action : WUI.Actions.Action_Access)
      is
         Document  : constant WebAPI.DOM.Documents.Document_Access
           := Parent.Element.Get_Owner_Document;
         List_item : constant not null WebAPI.DOM.Elements.Element_Access
           := Document.Create_Element (+"li");
         Link      : constant not null WebAPI.DOM.Elements.Element_Access
           := Document.Create_Element (+"a");

      begin
         WUI.Widgets.Constructors.Initialize
          (Self, WebAPI.HTML.Elements.HTML_Element_Access (List_item));

         Self.Title := Action.Text;
         Self.Action := Action;

         Link.Set_Text_Content (Self.Title);
         Link.Set_Attribute (+"href", +"#");
         List_Item.Append_Child (Link);
         Parent.Element.Append_Child (List_Item);
      end Initialize;

   end Menu_Items;

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self    : in out Menu'Class;
        Parent  : not null access WUI.Widgets.Abstract_Widget'Class;
        Title   : League.Strings.Universal_String)
      is
         Document : constant WebAPI.DOM.Documents.Document_Access
           := Parent.Element.Get_Owner_Document;
         Element  : constant not null WebAPI.DOM.Elements.Element_Access
           := Document.Create_Element (+"ul");

      begin
         WUI.Widgets.Constructors.Initialize
          (Self, WebAPI.HTML.Elements.HTML_Element_Access (Element));

         Self.Menu_Title := Title;
         Element.Set_Class_Name (+"menu");
         Parent.Element.Append_Child (Element);
      end Initialize;

   end Constructors;

   ----------------
   -- Add_Action --
   ----------------

   not overriding procedure Add_Action
    (Self : in out Menu;
     Item : WUI.Actions.Action_Access)
   is
      Menu_Item : Menu_Items.Menu_Item_Access := new Menu_Items.Menu_Item;

   begin
      Menu_Items.Initialize (Menu_Item.all, Self, Item);
   end Add_Action;

   --------------
   -- Add_Menu --
   --------------

   not overriding procedure Add_Menu
    (Self : in out Menu;
     Item : WUI.Widgets.Menus.Menu_Access) is
   begin
      null;
   end Add_Menu;

   -----------
   -- Title --
   -----------

   not overriding function Title (Self : Menu)
     return League.Strings.Universal_String is
   begin
      return Self.Menu_Title;
   end Title;

end WUI.Widgets.Menus;
