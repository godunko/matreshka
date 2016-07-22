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
with WebAPI.DOM.Event_Targets;
with WebAPI.HTML.Elements;

package body UI.GL_Widgets is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self   : in out Abstract_GL_Widget'Class;
        Canvas :
          not null WebAPI.HTML.Canvas_Elements.HTML_Canvas_Element_Access) is
      begin
         UI.Widgets.Constructors.Initialize
          (Self, WebAPI.HTML.Elements.HTML_Element_Access (Canvas));

         Self.Canvas := Canvas;

         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Self.Canvas, +"webglcontextlost", Self.Lost'Access, False);
         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Self.Canvas, +"webglcontextrestored", Self.Lost'Access, False);

         Self.Context := new OpenGL.Contexts.OpenGL_Context;
         Self.Context.Create (Canvas);
         Self.Context.Make_Current;

--         Self.Update;
         --  XXX A2JS: Update must use requestAnimationFrame to draw content of
         --  GL_Widget.
      end Initialize;

   end Constructors;

   ---------------
   -- Functions --
   ---------------

   function Functions
    (Self : in out Abstract_GL_Widget'Class)
       return access OpenGL.Functions.OpenGL_Functions'Class is
   begin
      return Self.Context.Functions;
   end Functions;

   ------------------
   -- Handle_Event --
   ------------------

   overriding procedure Handle_Event
    (Self  : not null access Context_Lost_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class) is
   begin
      Self.Owner.Context_Lost;
   end Handle_Event;

   ------------------
   -- Handle_Event --
   ------------------

   overriding procedure Handle_Event
    (Self  : not null access Context_Restored_Dispatcher;
     Event : access WebAPI.DOM.Events.Event'Class) is
   begin
      Self.Owner.Context_Restored;
   end Handle_Event;

   ------------
   -- Update --
   ------------

   procedure Update (Self : in out Abstract_GL_Widget) is

      use type WebAPI.DOM_Long;

      Call_Resize : constant Boolean
        := not Self.Initialized
             or WebAPI.DOM_Long (Self.Canvas.Get_Width)
                  /= Self.Canvas.Get_Client_Width
             or WebAPI.DOM_Long (Self.Canvas.Get_Height)
                  /= Self.Canvas.Get_Client_Height;
      --  Whether Resize_GL should be called due to change of canvas size.

   begin
      Self.Context.Make_Current;

      if not Self.Initialized then
         Self.Initialized := True;
         Abstract_GL_Widget'Class (Self).Initialize_GL;
      end if;

      Self.Canvas.Set_Width
       (WebAPI.DOM_Unsigned_Long (Self.Canvas.Get_Client_Width));
      Self.Canvas.Set_Height
       (WebAPI.DOM_Unsigned_Long (Self.Canvas.Get_Client_Height));

      Self.Functions.Viewport
       (X      => 0,
        Y      => 0,
        Width  => OpenGL.GLsizei (Self.Canvas.Get_Width),
        Height => OpenGL.GLsizei (Self.Canvas.Get_Height));

      if Call_Resize then
         Abstract_GL_Widget'Class (Self).Resize_GL
          (Integer (Self.Canvas.Get_Width), Integer (Self.Canvas.Get_Height));
      end if;

      Abstract_GL_Widget'Class (Self).Paint_GL;

      Self.Functions.Flush;
   end Update;

end UI.GL_Widgets;
