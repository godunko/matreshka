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

package OpenGL.Shaders.Programs is

   pragma Preelaborate;

   type OpenGL_Shader_Program is tagged private;

   procedure Add_Shader
    (Self   : in out OpenGL_Shader_Program'Class;
     Shader : OpenGL_Shader);
   --  Adds a compiled shader to this shader program. Returns True if the
   --  shader could be added, or False otherwise.

   procedure Create (Self : in out OpenGL_Shader_Program'Class);
   --  Requests the shader program's id to be created immediately. Returns True
   --  if successful; False otherwise.

   procedure Link (Self : in out OpenGL_Shader_Program'Class);
   --  Links together the shaders that were added to this program with
   --  Add_Shader. Returns True if the link was successful or False otherwise.
   --  If the link failed, the error messages can be retrieved with Log.

private

   type Program_Shared_Data;
   type Program_Shared_Data_Access is access all Program_Shared_Data;

   type OpenGL_Shader_Program is new Ada.Finalization.Controlled with record
      Data : Program_Shared_Data_Access;
   end record;

end OpenGL.Shaders.Programs;
