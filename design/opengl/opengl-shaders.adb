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

      Self.Data.Context.Functions.gl_Shader_Source (Self.Data.Shader_Id, Aux);
      Self.Data.Context.Functions.gl_Compile_Shader (Self.Data.Shader_Id);
      Self.Data.Context.Functions.gl_Get_Shaderiv
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
        OpenGL.Contexts.Current_Context.Functions.gl_Create_Shader
         ((case Shader_Type is
             when OpenGL.Vertex_Shader   => OpenGL.GL_VERTEX_SHADER,
             when OpenGL.Fragment_Shader => OpenGL.GL_FRAGMENT_SHADER));
      Self.Data :=
        new Shader_Shared_Data'
--             (Counter      => <>,
             (Context   => OpenGL.Contexts.Current_Context,
              Shader_Id => Shader_Id);
   end Create;

end OpenGL.Shaders;
