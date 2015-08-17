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
with Interfaces;

package OpenGL is

   pragma Pure;

   type GLclampf is new Interfaces.IEEE_Float_32 range 0.0 .. 1.0;

   type GLint is new Interfaces.Integer_32;

   type GLsizei is
     new Interfaces.Integer_32 range 0 .. Interfaces.Integer_32'Last;

   type GLenum is private;

   GL_DEPTH_TEST : constant GLenum;

private

   type GLenum is new Interfaces.Unsigned_32;

   GL_DEPTH_TEST : constant GLenum := 16#0B71#;

end OpenGL;
