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
with OpenGL.Contexts;

package body OpenGL.Shaders.Programs is

   type Program_Shared_Data is limited record
--      Counter : Matreshka.Atomics.Counters.Counter;
      Context    : OpenGL.Contexts.OpenGL_Context_Access;
      Program_Id : OpenGL.GLuint;
   end record;

   ----------------
   -- Add_Shader --
   ----------------

   procedure Add_Shader
    (Self   : in out OpenGL_Shader_Program'Class;
     Shader : OpenGL_Shader) is
   begin
      --  Self.Context /= Shader.Context => error

      Self.Data.Context.Functions.gl_Attach_Shader
       (Self.Data.Program_Id, Shader.Shader_Id);
   end Add_Shader;

   ----------
   -- Bind --
   ----------

   procedure Bind (Self : in out OpenGL_Shader_Program'Class) is
   begin
      Self.Data.Context.Functions.gl_Use_Program (Self.Data.Program_Id);
   end Bind;

   ------------
   -- Create --
   ------------

   procedure Create (Self : in out OpenGL_Shader_Program'Class) is
      use type OpenGL.Contexts.OpenGL_Context_Access;

      Program : GLuint;

   begin
      if OpenGL.Contexts.Current_Context = null then
         raise Program_Error;
      end if;

      Program := OpenGL.Contexts.Current_Context.Functions.gl_Create_Program;

      if Program = 0 then
         raise Program_Error;
      end if;

      Self.Data :=
        new Program_Shared_Data'
             (Context    => OpenGL.Contexts.Current_Context,
              Program_Id => Program);
   end Create;

   ----------
   -- Link --
   ----------

   procedure Link (Self : in out OpenGL_Shader_Program'Class) is
      Status : GLint;

   begin
      Self.Data.Context.Functions.gl_Link_Program (Self.Data.Program_Id);
      Self.Data.Context.Functions.gl_Get_Programiv
       (Self.Data.Program_Id, GL_LINK_STATUS, Status);

      if GLenum (Status) = GL_FALSE then
         raise Program_Error;
      end if;
   end Link;

end OpenGL.Shaders.Programs;
