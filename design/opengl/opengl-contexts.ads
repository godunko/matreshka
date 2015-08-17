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
with OpenGL.Functions;

package OpenGL.Contexts is

   pragma Preelaborate;

   type OpenGL_Context is limited interface;

   type OpenGL_Context_Access is access all OpenGL_Context'Class;

   not overriding function Functions
    (Self : OpenGL_Context)
       return access OpenGL.Functions.OpenGL_Functions'Class is abstract;

end OpenGL.Contexts;
