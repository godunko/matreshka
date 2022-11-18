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
with Ada.Unchecked_Conversion;

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

      Self.Data.Context.Functions.glAttachShader
       (Self.Data.Program_Id, Shader.Shader_Id);
   end Add_Shader;

   ------------------------
   -- Attribute_Location --
   ------------------------

   function Attribute_Location
    (Self : OpenGL_Shader_Program'Class;
     Name : League.Strings.Universal_String) return OpenGL.GLuint
   is
      Aux : constant OpenGL.GLint
        := Self.Data.Context.Functions.glGetAttribLocation
            (Self.Data.Program_Id, Name);

   begin
      if Aux = -1 then
         raise Program_Error;
      end if;

      return OpenGL.GLuint (Aux);
   end Attribute_Location;

   ----------
   -- Bind --
   ----------

   procedure Bind (Self : in out OpenGL_Shader_Program'Class) is
   begin
      Self.Data.Context.Functions.glUseProgram (Self.Data.Program_Id);
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

      Program := OpenGL.Contexts.Current_Context.Functions.glCreateProgram;

      if Program = 0 then
         raise Program_Error;
      end if;

      Self.Data :=
        new Program_Shared_Data'
             (Context    => OpenGL.Contexts.Current_Context,
              Program_Id => Program);
   end Create;

   ----------------------------
   -- Enable_Attribute_Array --
   ----------------------------

   procedure Enable_Attribute_Array
    (Self     : OpenGL_Shader_Program'Class;
     Location : OpenGL.GLuint) is
   begin
      Self.Data.Context.Functions.glEnableVertexAttribArray (Location);
   end Enable_Attribute_Array;

   ----------------------------
   -- Enable_Attribute_Array --
   ----------------------------

   procedure Enable_Attribute_Array
    (Self : OpenGL_Shader_Program'Class;
     Name : League.Strings.Universal_String) is
   begin
      Self.Enable_Attribute_Array (Self.Attribute_Location (Name));
   end Enable_Attribute_Array;

   ----------
   -- Link --
   ----------

   procedure Link (Self : in out OpenGL_Shader_Program'Class) is
      Status : GLint;

   begin
      Self.Data.Context.Functions.glLinkProgram (Self.Data.Program_Id);
      Self.Data.Context.Functions.glGetProgramiv
       (Self.Data.Program_Id, GL_LINK_STATUS, Status);

      if GLboolean (Status) = GL_FALSE then
         raise Program_Error;
      end if;
   end Link;

   --------------------------
   -- Set_Attribute_Buffer --
   --------------------------

   procedure Set_Attribute_Buffer
    (Self       : in out OpenGL_Shader_Program'Class;
     Location   : OpenGL.GLuint;
     Tuple_Size : OpenGL.GLint;
     Item_Type  : OpenGL.GLenum;
     Normalized : Boolean        := False;
     Stride     : OpenGL.GLsizei := 0;
     Offset     : Natural        := 0)
   is
      function Convert is
        new Ada.Unchecked_Conversion (Natural, System.Address);

   begin
      Self.Data.Context.Functions.glVertexAttribPointer
       (Location, Tuple_Size, Item_Type, Normalized, Stride, Convert (Offset));
   end Set_Attribute_Buffer;

   --------------------------
   -- Set_Attribute_Buffer --
   --------------------------

   procedure Set_Attribute_Buffer
    (Self       : in out OpenGL_Shader_Program'Class;
     Name       : League.Strings.Universal_String;
     Tuple_Size : OpenGL.GLint;
     Item_Type  : OpenGL.GLenum;
     Normalized : Boolean        := False;
     Stride     : OpenGL.GLsizei := 0;
     Offset     : Natural        := 0) is
   begin
      Self.Set_Attribute_Buffer
       (Self.Attribute_Location (Name),
        Tuple_Size,
        Item_Type,
        Normalized,
        Stride,
        Offset);
   end Set_Attribute_Buffer;

   -----------------------
   -- Set_Uniform_Value --
   -----------------------

   procedure Set_Uniform_Value
    (Self     : in out OpenGL_Shader_Program'Class;
     Location : OpenGL.GLuint;
     Value    : OpenGL.GLfloat_Matrix_2x2) is
   begin
      Self.Data.Context.Functions.glUniformMatrix2fv
       (Location, False, (1 => Value));
   end Set_Uniform_Value;

   -----------------------
   -- Set_Uniform_Value --
   -----------------------

   procedure Set_Uniform_Value
    (Self  : in out OpenGL_Shader_Program'Class;
     Name  : League.Strings.Universal_String;
     Value : OpenGL.GLfloat_Matrix_2x2) is
   begin
      Self.Set_Uniform_Value (Self.Uniform_Location (Name), Value);
   end Set_Uniform_Value;

   -----------------------
   -- Set_Uniform_Value --
   -----------------------

   procedure Set_Uniform_Value
    (Self     : in out OpenGL_Shader_Program'Class;
     Location : OpenGL.GLuint;
     Value    : OpenGL.GLfloat_Matrix_3x3) is
   begin
      Self.Data.Context.Functions.glUniformMatrix3fv
       (Location, False, (1 => Value));
   end Set_Uniform_Value;

   -----------------------
   -- Set_Uniform_Value --
   -----------------------

   procedure Set_Uniform_Value
    (Self  : in out OpenGL_Shader_Program'Class;
     Name  : League.Strings.Universal_String;
     Value : OpenGL.GLfloat_Matrix_3x3) is
   begin
      Self.Set_Uniform_Value (Self.Uniform_Location (Name), Value);
   end Set_Uniform_Value;

   -----------------------
   -- Set_Uniform_Value --
   -----------------------

   procedure Set_Uniform_Value
    (Self     : in out OpenGL_Shader_Program'Class;
     Location : OpenGL.GLuint;
     Value    : OpenGL.GLfloat_Matrix_4x4) is
   begin
      Self.Data.Context.Functions.glUniformMatrix4fv
       (Location, False, (1 => Value));
   end Set_Uniform_Value;

   -----------------------
   -- Set_Uniform_Value --
   -----------------------

   procedure Set_Uniform_Value
    (Self  : in out OpenGL_Shader_Program'Class;
     Name  : League.Strings.Universal_String;
     Value : OpenGL.GLfloat_Matrix_4x4) is
   begin
      Self.Set_Uniform_Value (Self.Uniform_Location (Name), Value);
   end Set_Uniform_Value;

   ----------------------
   -- Uniform_Location --
   ----------------------

   function Uniform_Location
    (Self : OpenGL_Shader_Program'Class;
     Name : League.Strings.Universal_String) return OpenGL.GLuint
   is
      Aux : constant OpenGL.GLint
        := Self.Data.Context.Functions.glGetUniformLocation
            (Self.Data.Program_Id, Name);

   begin
      if Aux = -1 then
         raise Program_Error;
      end if;

      return OpenGL.GLuint (Aux);
   end Uniform_Location;

end OpenGL.Shaders.Programs;
