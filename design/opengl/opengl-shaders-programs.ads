------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                             OpenGL Framework                             --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
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

   procedure Bind (Self : in out OpenGL_Shader_Program'Class);
   --  Binds this shader program to the active OpenGL_Context and makes it the
   --  current shader program. Any previously bound shader program is released.

private

   type Program_Shared_Data;
   type Program_Shared_Data_Access is access all Program_Shared_Data;

   type OpenGL_Shader_Program is new Ada.Finalization.Controlled with record
      Data : Program_Shared_Data_Access;
   end record;

end OpenGL.Shaders.Programs;
