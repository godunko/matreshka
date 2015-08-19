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
with League.Strings;

package OpenGL.Shaders is

   pragma Preelaborate;

   type OpenGL_Shader is tagged private;

   procedure Create
    (Self        : in out OpenGL_Shader'Class;
     Shader_Type : OpenGL.Shader_Type);
   --  Creates shader of specified type.

   procedure Compile_Source_Code
    (Self : in out OpenGL_Shader'Class;
     Code : League.Strings.Universal_String);
   --  Sets the source code for this shader and compiles it. Returns True if
   --  the source was successfully compiled, False otherwise.

private

   type Shader_Shared_Data;
   type Shader_Shared_Data_Access is access all Shader_Shared_Data;

   type OpenGL_Shader is tagged record
      Data : Shader_Shared_Data_Access;
   end record;

end OpenGL.Shaders;
