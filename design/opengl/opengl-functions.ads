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
with League.Strings;

package OpenGL.Functions is

   pragma Preelaborate;

   type OpenGL_Functions is limited interface;

   type OpenGL_Functions_Access is access all OpenGL_Functions'Class;

--                        void    glActiveTexture(GLenum texture)

   not overriding procedure glAttachShader
    (Self    : in out OpenGL_Functions;
     Program : OpenGL.GLuint;
     Shader  : OpenGL.GLuint) is abstract;
   --  Attaches a shader object to a program object.

--                        void    glBindAttribLocation(GLuint program, GLuint index, const char * name)

   not overriding procedure glBindBuffer
    (Self   : in out OpenGL_Functions;
     Target : OpenGL.GLenum;
     Buffer : OpenGL.GLuint) is abstract;
   --  Bind a named buffer object.

   not overriding procedure glBindFramebuffer
    (Self        : in out OpenGL_Functions;
     Target      : OpenGL.GLenum;
     Framebuffer : OpenGL.GLuint) is abstract;
   --  Bind a framebuffer to a framebuffer target.

   not overriding procedure glBindRenderbuffer
    (Self         : in out OpenGL_Functions;
     Target       : OpenGL.GLenum;
     Renderbuffer : OpenGL.GLuint) is abstract;
   --  Bind a renderbuffer to a renderbuffer target.

   not overriding procedure glBindTexture
    (Self    : in out OpenGL_Functions;
     Target  : OpenGL.GLenum;
     Texture : OpenGL.GLuint) is abstract;
   --  Bind a named texture to a texturing target.

--                        void    glBlendColor(GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha)
--                        void    glBlendEquation(GLenum mode)
--                        void    glBlendEquationSeparate(GLenum modeRGB, GLenum modeAlpha)
--                        void    glBlendFunc(GLenum sfactor, GLenum dfactor)
--                        void    glBlendFuncSeparate(GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha)

   not overriding procedure glBufferData
    (Self   : in out OpenGL_Functions;
     Target : OpenGL.GLenum;
     Size   : OpenGL.GLsizeiptr;
     Data   : System.Address;
     Usage  : OpenGL.GLenum) is abstract;
   --  Creates and initializes a buffer object's data store.

--                        void    glBufferSubData(GLenum target, qopengl_GLintptr offset, qopengl_GLsizeiptr size, const void * data)
--                        GLenum  glCheckFramebufferStatus(GLenum target)

   not overriding procedure glClear
    (Self : in out OpenGL_Functions;
     Mask : OpenGL.Clear_Buffer_Mask) is abstract;
   --  Clear buffers to preset values.

   not overriding procedure glClearColor
    (Self  : in out OpenGL_Functions;
     Red   : OpenGL.GLclampf;
     Green : OpenGL.GLclampf;
     Blue  : OpenGL.GLclampf;
     Alpha : OpenGL.GLclampf) is abstract;
   --  Specify clear values for the color buffers.

--                        void    glClearDepthf(GLclampf depth)
--                        void    glClearStencil(GLint s)
--                        void    glColorMask(GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha)

   not overriding procedure glCompileShader
    (Self   : in out OpenGL_Functions;
     Shader : OpenGL.GLuint) is abstract;
   --  Compile a shader object.

--                        void    glCompressedTexImage2D(GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void * data)
--                        void    glCompressedTexSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void * data)
--                        void    glCopyTexImage2D(GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border)
--                        void    glCopyTexSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height)

--                        GLuint  glCreateProgram()

   not overriding function glCreateProgram
    (Self : in out OpenGL_Functions) return OpenGL.GLuint is abstract;
   --  Creates a program object.

   not overriding function glCreateShader
    (Self        : in out OpenGL_Functions;
     Shader_Type : OpenGL.GLenum) return OpenGL.GLuint is abstract;
   --  Creates a shader object.

--                        void    glCullFace(GLenum mode)

   not overriding procedure glDeleteBuffers
    (Self    : in out OpenGL_Functions;
     Buffers : in out OpenGL.GLuint_Array) is abstract;
   --  Delete named buffer objects.

--                        void    glDeleteFramebuffers(GLsizei n, const GLuint * framebuffers)
--                        void    glDeleteProgram(GLuint program)
--                        void    glDeleteRenderbuffers(GLsizei n, const GLuint * renderbuffers)
--                        void    glDeleteShader(GLuint shader)
--                        void    glDeleteTextures(GLsizei n, const GLuint * textures)
--                        void    glDepthFunc(GLenum func)
--                        void    glDepthMask(GLboolean flag)
--                        void    glDepthRangef(GLclampf zNear, GLclampf zFar)
--                        void    glDetachShader(GLuint program, GLuint shader)
--                        void    glDisable(GLenum cap)

   not overriding procedure glDisableVertexAttribArray
    (Self  : in out OpenGL_Functions;
     Index : OpenGL.GLuint) is abstract;
   --  Disable a generic vertex attribute array.

   not overriding procedure glDrawArrays
    (Self  : in out OpenGL_Functions;
     Mode  : OpenGL.GLenum;
     First : OpenGL.GLint;
     Count : OpenGL.GLsizei) is abstract;
   --  Render primitives from array data.

--                        void    glDrawElements(GLenum mode, GLsizei count, GLenum type, const GLvoid * indices)

   not overriding procedure glEnable
    (Self : in out OpenGL_Functions;
     Cap  : OpenGL.GLenum) is abstract;
   --  glEnable and glDisable enable and disable various capabilities.

   not overriding procedure glEnableVertexAttribArray
    (Self  : in out OpenGL_Functions;
     Index : OpenGL.GLuint) is abstract;
   --  Enable a generic vertex attribute array.

--                        void    glFinish()
--                        void    glFlush()
--                        void    glFramebufferRenderbuffer(GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer)
--                        void    glFramebufferTexture2D(GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level)
--                        void    glFrontFace(GLenum mode)

   not overriding procedure glGenBuffers
    (Self    : in out OpenGL_Functions;
     Buffers : in out OpenGL.GLuint_Array) is abstract;
   --  Generate buffer object names.

   not overriding procedure glGenFramebuffers
    (Self         : in out OpenGL_Functions;
     Framebuffers : in out OpenGL.GLuint_Array) is abstract;
   --  Generate framebuffer object names.

   not overriding procedure glGenRenderbuffers
    (Self          : in out OpenGL_Functions;
     Renderbuffers : in out OpenGL.GLuint_Array) is abstract;
   --  Generate renderbuffer object names.

   not overriding procedure glGenTextures
    (Self     : in out OpenGL_Functions;
     Textures : in out OpenGL.GLuint_Array) is abstract;
   --  Generate texture names.

--                        void    glGenerateMipmap(GLenum target)
--                        void    glGetActiveAttrib(GLuint program, GLuint index, GLsizei bufsize, GLsizei * length, GLint * size, GLenum * type, char * name)
--                        void    glGetActiveUniform(GLuint program, GLuint index, GLsizei bufsize, GLsizei * length, GLint * size, GLenum * type, char * name)
--                        void    glGetAttachedShaders(GLuint program, GLsizei maxcount, GLsizei * count, GLuint * shaders)

   not overriding function glGetAttribLocation
    (Self    : in out OpenGL_Functions;
     Program : OpenGL.GLuint;
     Name    : League.Strings.Universal_String)
       return OpenGL.GLint is abstract;
   --  Returns the location of an attribute variable.

--                        void    glGetBooleanv(GLenum pname, GLboolean * params)
--                        void    glGetBufferParameteriv(GLenum target, GLenum pname, GLint * params)
--                        GLenum  glGetError()
--                        void    glGetFloatv(GLenum pname, GLfloat * params)
--                        void    glGetFramebufferAttachmentParameteriv(GLenum target, GLenum attachment, GLenum pname, GLint * params)
--                        void    glGetIntegerv(GLenum pname, GLint * params)
--                        void    glGetProgramInfoLog(GLuint program, GLsizei bufsize, GLsizei * length, char * infolog)

   not overriding procedure glGetProgramiv
    (Self    : in out OpenGL_Functions;
     Program : OpenGL.GLuint;
     Pname   : OpenGL.GLenum;
     Param   : out OpenGL.GLint) is abstract;
   --  Return a parameter from a program object.

--                        void    glGetRenderbufferParameteriv(GLenum target, GLenum pname, GLint * params)
--                        void    glGetShaderInfoLog(GLuint shader, GLsizei bufsize, GLsizei * length, char * infolog)
--                        void    glGetShaderPrecisionFormat(GLenum shadertype, GLenum precisiontype, GLint * range, GLint * precision)
--                        void    glGetShaderSource(GLuint shader, GLsizei bufsize, GLsizei * length, char * source)

   not overriding procedure glGetShaderiv
    (Self   : in out OpenGL_Functions;
     Shader : OpenGL.GLuint;
     Pname  : OpenGL.GLenum;
     Param  : out OpenGL.GLint) is abstract;
   --  Return a parameter from a shader object.

--                        const GLubyte *         glGetString(GLenum name)
--                        void    glGetTexParameterfv(GLenum target, GLenum pname, GLfloat * params)
--                        void    glGetTexParameteriv(GLenum target, GLenum pname, GLint * params)

   not overriding function glGetUniformLocation
    (Self    : in out OpenGL_Functions;
     Program : OpenGL.GLuint;
     Name    : League.Strings.Universal_String)
       return OpenGL.GLint is abstract;
   --  Return the location of a uniform variable.

--                        void    glGetUniformfv(GLuint program, GLint location, GLfloat * params)
--                        void    glGetUniformiv(GLuint program, GLint location, GLint * params)
--                        void    glGetVertexAttribPointerv(GLuint index, GLenum pname, void ** pointer)
--                        void    glGetVertexAttribfv(GLuint index, GLenum pname, GLfloat * params)
--                        void    glGetVertexAttribiv(GLuint index, GLenum pname, GLint * params)
--                        void    glHint(GLenum target, GLenum mode)
--                        GLboolean       glIsBuffer(GLuint buffer)
--                        GLboolean       glIsEnabled(GLenum cap)
--                        GLboolean       glIsFramebuffer(GLuint framebuffer)
--                        GLboolean       glIsProgram(GLuint program)
--                        GLboolean       glIsRenderbuffer(GLuint renderbuffer)
--                        GLboolean       glIsShader(GLuint shader)
--                        GLboolean       glIsTexture(GLuint texture)
--                        void    glLineWidth(GLfloat width)

   not overriding procedure glLinkProgram
    (Self    : in out OpenGL_Functions;
     Program : OpenGL.GLuint) is abstract;
   --  Links a program object.

--                        void    glPixelStorei(GLenum pname, GLint param)
--                        void    glPolygonOffset(GLfloat factor, GLfloat units)
--                        void    glReadPixels(GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid * pixels)
--                        void    glReleaseShaderCompiler()
--                        void    glRenderbufferStorage(GLenum target, GLenum internalformat, GLsizei width, GLsizei height)
--                        void    glSampleCoverage(GLclampf value, GLboolean invert)
--                        void    glScissor(GLint x, GLint y, GLsizei width, GLsizei height)
--                        void    glShaderBinary(GLint n, const GLuint * shaders, GLenum binaryformat, const void * binary, GLint length)

   not overriding procedure glShaderSource
    (Self   : in out OpenGL_Functions;
     Shader : OpenGL.GLuint;
     Code   : League.String_Vectors.Universal_String_Vector) is abstract;
   --  Replace the source code in a shader object.

--                        void    glStencilFunc(GLenum func, GLint ref, GLuint mask)
--                        void    glStencilFuncSeparate(GLenum face, GLenum func, GLint ref, GLuint mask)
--                        void    glStencilMask(GLuint mask)
--                        void    glStencilMaskSeparate(GLenum face, GLuint mask)
--                        void    glStencilOp(GLenum fail, GLenum zfail, GLenum zpass)
--                        void    glStencilOpSeparate(GLenum face, GLenum fail, GLenum zfail, GLenum zpass)
--                        void    glTexImage2D(GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid * pixels)
--                        void    glTexParameterf(GLenum target, GLenum pname, GLfloat param)
--                        void    glTexParameterfv(GLenum target, GLenum pname, const GLfloat * params)
--                        void    glTexParameteri(GLenum target, GLenum pname, GLint param)
--                        void    glTexParameteriv(GLenum target, GLenum pname, const GLint * params)
--                        void    glTexSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid * pixels)
--                        void    glUniform1f(GLint location, GLfloat x)
--                        void    glUniform1fv(GLint location, GLsizei count, const GLfloat * v)
--                        void    glUniform1i(GLint location, GLint x)
--                        void    glUniform1iv(GLint location, GLsizei count, const GLint * v)
--                        void    glUniform2f(GLint location, GLfloat x, GLfloat y)
--                        void    glUniform2fv(GLint location, GLsizei count, const GLfloat * v)
--                        void    glUniform2i(GLint location, GLint x, GLint y)
--                        void    glUniform2iv(GLint location, GLsizei count, const GLint * v)
--                        void    glUniform3f(GLint location, GLfloat x, GLfloat y, GLfloat z)
--                        void    glUniform3fv(GLint location, GLsizei count, const GLfloat * v)
--                        void    glUniform3i(GLint location, GLint x, GLint y, GLint z)
--                        void    glUniform3iv(GLint location, GLsizei count, const GLint * v)
--                        void    glUniform4f(GLint location, GLfloat x, GLfloat y, GLfloat z, GLfloat w)
--                        void    glUniform4fv(GLint location, GLsizei count, const GLfloat * v)
--                        void    glUniform4i(GLint location, GLint x, GLint y, GLint z, GLint w)
--                        void    glUniform4iv(GLint location, GLsizei count, const GLint * v)

   not overriding procedure glUniformMatrix2fv
    (Self      : in out OpenGL_Functions;
     Location  : OpenGL.GLuint;
     Transpose : Boolean;
     Value     : OpenGL.GLfloat_Matrix_2x2_Array) is abstract;
   --  Specify the value of a uniform variable for the current program object.

   not overriding procedure glUniformMatrix3fv
    (Self      : in out OpenGL_Functions;
     Location  : OpenGL.GLuint;
     Transpose : Boolean;
     Value     : OpenGL.GLfloat_Matrix_3x3_Array) is abstract;
   --  Specify the value of a uniform variable for the current program object.

   not overriding procedure glUniformMatrix4fv
    (Self      : in out OpenGL_Functions;
     Location  : OpenGL.GLuint;
     Transpose : Boolean;
     Value     : OpenGL.GLfloat_Matrix_4x4_Array) is abstract;
   --  Specify the value of a uniform variable for the current program object.

   not overriding procedure glUseProgram
    (Self    : in out OpenGL_Functions;
     Program : OpenGL.GLuint) is abstract;
   --  Install a program object as part of current rendering state.

--                        void    glValidateProgram(GLuint program)
--                        void    glVertexAttrib1f(GLuint indx, GLfloat x)
--                        void    glVertexAttrib1fv(GLuint indx, const GLfloat * values)
--                        void    glVertexAttrib2f(GLuint indx, GLfloat x, GLfloat y)
--                        void    glVertexAttrib2fv(GLuint indx, const GLfloat * values)
--                        void    glVertexAttrib3f(GLuint indx, GLfloat x, GLfloat y, GLfloat z)
--                        void    glVertexAttrib3fv(GLuint indx, const GLfloat * values)
--                        void    glVertexAttrib4f(GLuint indx, GLfloat x, GLfloat y, GLfloat z, GLfloat w)
--                        void    glVertexAttrib4fv(GLuint indx, const GLfloat * values)

   not overriding procedure glVertexAttribPointer
    (Self       : in out OpenGL_Functions;
     Index      : OpenGL.GLuint;
     Size       : OpenGL.GLint;
     Data_Type  : OpenGL.GLenum;
     Normalized : Boolean;
     Stride     : OpenGL.GLsizei;
     Pointer    : System.Address) is abstract;
   --  Define an array of generic vertex attribute data.

   not overriding procedure glViewport
    (Self   : in out OpenGL_Functions;
     X      : OpenGL.GLint;
     Y      : OpenGL.GLint;
     Width  : OpenGL.GLsizei;
     Height : OpenGL.GLsizei) is abstract;
   --  glViewport specifies the affine transformation of x and y from
   --  normalized device coordinates to window coordinates.

--                        bool    hasOpenGLFeature(QOpenGLFunctions::OpenGLFeature feature) const
--                        void    initializeOpenGLFunctions()
--                        QOpenGLFunctions::OpenGLFeatures        openGLFeatures() const
end OpenGL.Functions;
