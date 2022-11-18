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

package body WUI.Widgets.Menu_Bars is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self   : in out Menu_Bar'Class;
        Parent : not null access WUI.Widgets.Abstract_Widget'Class)
      is
         Document : constant WebAPI.DOM.Documents.Document_Access
           := Parent.Element.Get_Owner_Document;
         Element  : constant not null WebAPI.DOM.Elements.Element_Access
           := Document.Create_Element (+"ul");

      begin
         WUI.Widgets.Constructors.Initialize
          (Self, WebAPI.HTML.Elements.HTML_Element_Access (Element));

         Element.Set_Class_Name (+"menu-bar");
         Parent.Element.Append_Child (Element);
      end Initialize;

   end Constructors;

   --------------
   -- Add_Menu --
   --------------

   not overriding procedure Add_Menu
    (Self : in out Menu_Bar;
     Item : WUI.Widgets.Menus.Menu_Access)
   is
      Widget    : access WUI.Widgets.Abstract_Widget'Class := Item;
      Document  : constant WebAPI.DOM.Documents.Document_Access
        := Self.Element.Get_Owner_Document;
      List_Item : constant not null WebAPI.DOM.Elements.Element_Access
        := Document.Create_Element (+"li");
      Link      : constant not null WebAPI.DOM.Elements.Element_Access
        := Document.Create_Element (+"a");

   begin
      Link.Set_Text_Content (Item.Title);
      Link.Set_Attribute (+"href", +"#");
      List_Item.Append_Child (Link);
      List_Item.Append_Child (Widget.Element);
      Self.Element.Append_Child (List_Item);
   end Add_Menu;

end WUI.Widgets.Menu_Bars;
