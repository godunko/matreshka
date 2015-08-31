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
with League.String_Vectors;

with OpenGL.Contexts;

package body OpenGL.Shaders is

   type Shader_Shared_Data is limited record
--      Counter : Matreshka.Atomics.Counters.Counter;
      Context   : OpenGL.Contexts.OpenGL_Context_Access;
      Shader_Id : OpenGL.GLuint;
   end record;

   -------------------------
   -- Compile_Source_Code --
   -------------------------

   procedure Compile_Source_Code
    (Self : in out OpenGL_Shader'Class;
     Code : League.Strings.Universal_String)
   is
      Aux    : League.String_Vectors.Universal_String_Vector;
      Status : OpenGL.GLint;

   begin
      Aux.Append (Code);

      if Self.Data.Shader_Id = 0 then
         raise Program_Error;
      end if;

      Self.Data.Context.Functions.glShaderSource (Self.Data.Shader_Id, Aux);
      Self.Data.Context.Functions.glCompileShader (Self.Data.Shader_Id);
      Self.Data.Context.Functions.glGetShaderiv
       (Self.Data.Shader_Id, OpenGL.GL_COMPILE_STATUS, Status);

      if Status = GLint (GL_FALSE) then
         raise Program_Error;
      end if;
   end Compile_Source_Code;

   ------------
   -- Create --
   ------------

   procedure Create
    (Self        : in out OpenGL_Shader'Class;
     Shader_Type : OpenGL.Shader_Type)
   is
      use type OpenGL.Contexts.OpenGL_Context_Access;

      Shader_Id : OpenGL.GLuint;

   begin
      if OpenGL.Contexts.Current_Context = null then
         raise Program_Error;
      end if;

      Shader_Id :=
        OpenGL.Contexts.Current_Context.Functions.glCreateShader
         ((case Shader_Type is
             when OpenGL.Vertex_Shader   => OpenGL.GL_VERTEX_SHADER,
             when OpenGL.Fragment_Shader => OpenGL.GL_FRAGMENT_SHADER));
      Self.Data :=
        new Shader_Shared_Data'
--             (Counter      => <>,
             (Context   => OpenGL.Contexts.Current_Context,
              Shader_Id => Shader_Id);
   end Create;

   ---------------
   -- Shader_Id --
   ---------------

   function Shader_Id (Self : OpenGL_Shader'Class) return OpenGL.GLuint is
   begin
      return Self.Data.Shader_Id;
   end Shader_Id;

end OpenGL.Shaders;
