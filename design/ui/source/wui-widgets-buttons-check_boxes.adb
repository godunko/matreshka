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
with WebAPI.DOM.Event_Targets;
with WebAPI.HTML.Globals;

package body WUI.Widgets.Buttons.Check_Boxes is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      type Check_Box_Internal_Access is access all Check_Box'Class;

      ------------
      -- Create --
      ------------

      function Create
       (Element :
          not null WebAPI.HTML.Input_Elements.HTML_Input_Element_Access)
            return not null Check_Box_Access
      is
         Result : constant not null Check_Box_Internal_Access
           := new Check_Box;

      begin
         Initialize (Result.all, Element);

         return Check_Box_Access (Result);
      end Create;

      ------------
      -- Create --
      ------------

      function Create
       (Id : League.Strings.Universal_String)
          return not null Check_Box_Access is
      begin
         return
           Create
            (WebAPI.HTML.Input_Elements.HTML_Input_Element_Access
              (WebAPI.HTML.Globals.Window.Get_Document.Get_Element_By_Id
                (Id)));
      end Create;

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self    : in out Check_Box'Class;
        Element :
          not null WebAPI.HTML.Input_Elements.HTML_Input_Element_Access) is
      begin
         WUI.Widgets.Buttons.Constructors.Initialize
          (Self, WebAPI.HTML.Elements.HTML_Element_Access (Element));
      end Initialize;

   end Constructors;

   ------------------
   -- Change_Event --
   ------------------

   overriding procedure Change_Event (Self  : in out Check_Box) is
   begin
      Self.State_Changed.Emit
       (WebAPI.HTML.Input_Elements.HTML_Input_Element_Access
         (Self.Element).Get_Checked);
   end Change_Event;

   -----------------
   -- Set_Enabled --
   -----------------

   overriding procedure Set_Enabled
    (Self    : in out Check_Box;
     Enabled : Boolean) is
   begin
      WebAPI.HTML.Input_Elements.HTML_Input_Element_Access
       (Self.Element).Set_Disabled (not Enabled);
   end Set_Enabled;

   --------------------------
   -- State_Changed_Signal --
   --------------------------

   not overriding function State_Changed_Signal
    (Self : in out Check_Box)
       return not null access WUI.Boolean_Slots.Signal'Class is
   begin
      return Self.State_Changed'Unchecked_Access;
   end State_Changed_Signal;

end WUI.Widgets.Buttons.Check_Boxes;
