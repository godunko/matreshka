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
-- Copyright © 2016-2020, Vadim Godunko <vgodunko@gmail.com>                --
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
with WebAPI.DOM.Elements;
with WebAPI.DOM.Rects;

package body WUI.Events.Mouse is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self  : in out Abstract_Mouse_Event'Class;
        Event : not null access WebAPI.UI_Events.Mouse.Mouse_Event'Class) is
      begin
         WUI.Events.Constructors.Initialize (Self, Event);
      end Initialize;

   end Constructors;

--   -------------
--   -- Buttons --
--   -------------
--
--   function Buttons
--    (Self : Abstract_Mouse_Event'Class) return Mouse_Buttons
--   is
--      use type WebAPI.DOM_Unsigned_Short;
--
--      Buttons : constant WebAPI.DOM_Unsigned_Short
--        := WebAPI.UI_Events.Mouse.Mouse_Event'Class
--            (Self.Event.all).Get_Buttons;
--      Result  : Mouse_Buttons := (others => False);
--
--   begin
--      if (Buttons and 2#0001#) /= 0 then
--         Result (Button_1) := True;
--      end if;
--
--      if (Buttons and 2#0010#) /= 0 then
--         Result (Button_2) := True;
--      end if;
--
--      if (Buttons and 2#0100#) /= 0 then
--         Result (Button_3) := True;
--      end if;
--
--      return Result;
--   end Buttons;

   -------
   -- X --
   -------

   function X (Self : Abstract_Mouse_Event'Class) return Long_Float is
      E : WebAPI.UI_Events.Mouse.Mouse_Event'Class
        renames WebAPI.UI_Events.Mouse.Mouse_Event'Class (Self.Event.all);
      R : constant WebAPI.DOM.Rects.DOM_Rect_Access
        := WebAPI.DOM.Elements.Element'Class
            (E.Get_Target.all).Get_Bounding_Client_Rect;

   begin
      return Long_Float (E.Get_Client_X) - Long_Float (R.Get_Left);
   end X;

   -------
   -- Y --
   -------

   function Y (Self : Abstract_Mouse_Event'Class) return Long_Float is
      E : WebAPI.UI_Events.Mouse.Mouse_Event'Class
        renames WebAPI.UI_Events.Mouse.Mouse_Event'Class (Self.Event.all);
      R : constant WebAPI.DOM.Rects.DOM_Rect_Access
        := WebAPI.DOM.Elements.Element'Class
            (E.Get_Target.all).Get_Bounding_Client_Rect;

   begin
      return Long_Float (E.Get_Client_Y) - Long_Float (R.Get_Top);
   end Y;

end WUI.Events.Mouse;
