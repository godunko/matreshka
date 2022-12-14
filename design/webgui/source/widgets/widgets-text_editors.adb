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
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
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
with WebAPI.HTML.Globals;

package body Widgets.Text_Editors is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self : in out Text_Editor'Class;
        Id   : League.Strings.Universal_String) is
      begin
         Widgets.Constructors.Initialize
          (Self,
           WebAPI.HTML.Globals.Window.Get_Document.Get_Element_By_Id (Id));
--         Self.Root :=
----           WebAPI.HTML.Elements.HTML_Element_Access
--            (WebAPI.HTML.Globals.Window.Get_Document.Get_Element_By_Id (Id));

--         Self.Root.Set_Content_Editable
--          (League.Strings.To_Universal_String ("true"));
      end Initialize;

   end Constructors;

   ------------------------
   -- On_Key_Press_Event --
   ------------------------

   overriding procedure On_Key_Press_Event
    (Self  : in out Text_Editor;
     Event : in out WebAPI.UI_Events.Keyboard.Keyboard_Event'Class) is
   begin
      if Event.Get_Key_Code = 38 then
         raise Program_Error;
      end if;
   end On_Key_Press_Event;

end Widgets.Text_Editors;
