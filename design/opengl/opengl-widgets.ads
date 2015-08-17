------------------------------------------------------------------------------
--                                                                          --
--                      House Designer's Smart Studio                       --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
-- All rights reserved.                                                     --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------
with OpenGL.Contexts;

package OpenGL.Widgets is

   pragma Preelaborate;

   type OpenGL_Widget_Interface is limited interface;

   not overriding procedure Initialize_GL
    (Self    : in out OpenGL_Widget_Interface;
     Context : not null OpenGL.Contexts.OpenGL_Context_Access) is null;

   not overriding procedure Resize_GL
    (Self   : in out OpenGL_Widget_Interface;
     Width  : Integer;
     Height : Integer) is null;

   not overriding procedure Paint_GL
    (Self   : in out OpenGL_Widget_Interface) is null;

end OpenGL.Widgets;
