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

package body OpenGL.Contexts is

   Global_Current_Context : OpenGL_Context_Access;

   ---------------------
   -- Current_Context --
   ---------------------

   function Current_Context return OpenGL_Context_Access is
   begin
      return Global_Current_Context;
   end Current_Context;

   -------------------------
   -- Set_Current_Context --
   -------------------------

   procedure Set_Current_Context (Context : OpenGL_Context_Access) is
   begin
      Global_Current_Context := Context;
   end Set_Current_Context;

end OpenGL.Contexts;
