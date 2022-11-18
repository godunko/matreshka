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
with WebAPI.DOM.Event_Targets;
with WebAPI.HTML.Globals;
with WebAPI.HTML.Elements;

package body WUI.Widgets.GL_Widgets is

   procedure Animation_Frame (Self : in out Abstract_GL_Widget'Class);
   --  Handles animation frame and requests next animation frame. Animation
   --  frames is used to do most of GL related processing, including:
   --   - finish of initialization of widget's GL code;
   --   - detection of resize of canvas;
   --   - redrawing after finish of initialization, on detected resize of the
   --     canvas and on request.

   ---------------------
   -- Animation_Frame --
   ---------------------

   procedure Animation_Frame (Self : in out Abstract_GL_Widget'Class) is

      use type WebAPI.DOM_Double;
      use type WebAPI.DOM_Unsigned_Long;

      Ratio          : constant WebAPI.DOM_Double
        := WebAPI.HTML.Globals.Window.Get_Device_Pixel_Ratio;
      Display_Width  : constant WebAPI.DOM_Unsigned_Long
        := WebAPI.DOM_Unsigned_Long
            (WebAPI.DOM_Double'Floor
              (WebAPI.DOM_Double (Self.Canvas.Get_Client_Width) * Ratio));
      Display_Height : constant WebAPI.DOM_Unsigned_Long
        := WebAPI.DOM_Unsigned_Long
            (WebAPI.DOM_Double'Floor
              (WebAPI.DOM_Double (Self.Canvas.Get_Client_Height) * Ratio));

      Resize_Needed : constant Boolean
        := not Self.Initialized
             or Self.Canvas.Get_Width /= Display_Width
             or Self.Canvas.Get_Height /= Display_Height;
      --  Whether Resize_GL should be called due to change of canvas size.

   begin
      Self.Context.Make_Current;

      --  Finish initialization of the widget's GL code.

      if not Self.Initialized then
         Self.Initialized := True;
         Abstract_GL_Widget'Class (Self).Initialize_GL;
      end if;

      --  Complete resize of canvas and notify widget.

      if Resize_Needed then
         Self.Canvas.Set_Width (Display_Width);
         Self.Canvas.Set_Height (Display_Height);

         Self.Functions.Viewport
          (X      => 0,
           Y      => 0,
           Width  => OpenGL.GLsizei (Self.Canvas.Get_Width),
           Height => OpenGL.GLsizei (Self.Canvas.Get_Height));

         Abstract_GL_Widget'Class (Self).Resize_GL
          (Integer (Self.Canvas.Get_Width), Integer (Self.Canvas.Get_Height));
      end if;

      --  Redraw content of canvas when necessary.

      if Resize_Needed or Self.Redraw_Needed then
         Self.Redraw_Needed := False;
         Abstract_GL_Widget'Class (Self).Paint_GL;
         Self.Functions.Flush;
      end if;

      WebAPI.HTML.Globals.Window.Request_Animation_Frame
       (Self.Animation'Access);
      --  Request next animation frame.
   end Animation_Frame;

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
         WUI.Widgets.Constructors.Initialize
          (Self, WebAPI.HTML.Elements.HTML_Element_Access (Canvas));

         Self.Canvas := Canvas;

         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Self.Canvas, +"webglcontextlost", Self.Lost'Access, False);
         WebAPI.DOM.Event_Targets.Add_Event_Listener
          (Self.Canvas, +"webglcontextrestored", Self.Lost'Access, False);

         Self.Context := new OpenGL.Contexts.OpenGL_Context;
         Self.Context.Create (Canvas);
         Self.Context.Make_Current;

         WebAPI.HTML.Globals.Window.Request_Animation_Frame
          (Self.Animation'Access);
         --  Register request of animation frame. Initialization of the GL
         --  related features will be continued durin handling of the
         --  requested animation frame.
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

   ----------------------------
   -- Handle_Animation_Frame --
   ----------------------------

   overriding procedure Handle_Animation_Frame
    (Self : in out Frame_Request_Dispatcher;
     Time : WebAPI.DOM_High_Res_Time_Stamp) is
   begin
      Self.Owner.Animation_Frame;
   end Handle_Animation_Frame;

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
   begin
      --  Request redraw on processing of next animation frame.

      Self.Redraw_Needed := True;
   end Update;

end WUI.Widgets.GL_Widgets;
