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
