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
-- Copyright © 2017, Vadim Godunko <vgodunko@gmail.com>                     --
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
with WebAPI.DOM.Nodes;
with WebAPI.DOM.Texts;
with WebAPI.HTML.Globals;

package body WUI.Widgets.Labels is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      type Label_Internal_Access is access all Label'Class;

      ------------
      -- Create --
      ------------

      function Create
       (Element : not null WebAPI.HTML.Elements.HTML_Element_Access)
          return not null Label_Access
      is
         Result : not null Label_Internal_Access := new Label;

      begin
         Initialize (Result.all, Element);

         return Label_Access (Result);
      end Create;

      ------------
      -- Create --
      ------------

      function Create
       (Id : League.Strings.Universal_String) return not null Label_Access is
      begin
         return
           Create
            (WebAPI.HTML.Elements.HTML_Element_Access
              (WebAPI.HTML.Globals.Window.Get_Document.Get_Element_By_Id
                (Id)));
      end Create;

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self    : in out Label'Class;
        Element : not null WebAPI.HTML.Elements.HTML_Element_Access) is
      begin
         WUI.Widgets.Constructors.Initialize (Self, Element);
      end Initialize;

   end Constructors;

   --------------
   -- Set_Text --
   --------------

   procedure Set_Text
    (Self : in out Label'Class;
     To   : League.Strings.Universal_String)
   is
      use type WebAPI.DOM.Nodes.Node_Access;

      Text : WebAPI.DOM.Texts.Text_Access;

   begin
      --  Remove all children nodes.

      while Self.Element.Get_First_Child /= null loop
         Self.Element.Remove_Child (Self.Element.Get_First_Child);
      end loop;

      --  Create new text node and insert it.

      Text := Self.Element.Get_Owner_Document.Create_Text_Node (To);
      Self.Element.Append_Child (Text);
   end Set_Text;

end WUI.Widgets.Labels;
