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
with League.Objects.Impl;
with League.Strings;

with AWF.HTML_Writers;
with AWF.Internals.AWF_Layouts;
with AWF.Layouts;
with AWF.Widgets;

package AWF.Internals.AWF_Widgets is

   type AWF_Widget_Proxy is
     new League.Objects.Impl.Object_Impl
       and AWF.Widgets.AWF_Widget with private;

   type AWF_Widget_Proxy_Access is
     access all AWF_Widget_Proxy'Class;

   overriding function Id
    (Self : not null access constant AWF_Widget_Proxy) return Natural;

   overriding procedure Set_Layout
    (Self   : not null access AWF_Widget_Proxy;
     Layout : access AWF.Layouts.AWF_Layout'Class);

   not overriding procedure Render_Head
    (Self    : not null access AWF_Widget_Proxy;
     Context : in out AWF.HTML_Writers.HTML_Writer'Class) is null;

   not overriding procedure Render_Body
    (Self    : not null access AWF_Widget_Proxy;
     Context : in out AWF.HTML_Writers.HTML_Writer'Class);

   -- Payload

   not overriding procedure Append_Payload
    (Self    : not null access AWF_Widget_Proxy;
     Payload : League.Strings.Universal_String);

   not overriding function Get_Payload
    (Self : not null access AWF_Widget_Proxy)
       return League.Strings.Universal_String;

   --  Events

   not overriding procedure Key_Down_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Key_Press_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Key_Up_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Click_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Double_Click_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Drag_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Drag_End_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Drag_Enter_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Drag_Leave_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Drag_Over_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Drag_Start_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Drop_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Mouse_Down_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Mouse_Move_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Mouse_Out_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Mouse_Over_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Mouse_Up_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Mouse_Wheel_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   not overriding procedure Scroll_Event
    (Self : not null access AWF_Widget_Proxy) is null;

   package Constructors is

      procedure Initialize
       (Self   : not null access AWF_Widget_Proxy'Class;
        Parent : access AWF.Widgets.AWF_Widget'Class := null);

   end Constructors;

private

   type AWF_Widget_Proxy is
     new League.Objects.Impl.Object_Impl
       and AWF.Widgets.AWF_Widget with
   record
      Id      : Natural;
      Layout  : AWF.Internals.AWF_Layouts.AWF_Layout_Proxy_Access;
      Payload : League.Strings.Universal_String;
   end record;

end AWF.Internals.AWF_Widgets;
