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

package OpenGL.Functions is

   pragma Preelaborate;

   type OpenGL_Functions is limited interface;

   type OpenGL_Functions_Access is access all OpenGL_Functions'Class;

--        QOpenGLFunctions()
--                QOpenGLFunctions(QOpenGLContext * context)
--                        ~QOpenGLFunctions()
--                        void    glActiveTexture(GLenum texture)

   not overriding procedure gl_Attach_Shader
    (Self    : in out OpenGL_Functions;
     Program : OpenGL.GLuint;
     Shader  : OpenGL.GLuint) is abstract;
   --  Attaches a shader object to a program object.

--                        void    glBindAttribLocation(GLuint program, GLuint index, const char * name)

   not overriding procedure gl_Bind_Buffer
    (Self   : in out OpenGL_Functions;
     Target : OpenGL.GLenum;
     Buffer : OpenGL.GLuint) is abstract;
   --  Bind a named buffer object.

--                        void    glBindFramebuffer(GLenum target, GLuint framebuffer)
--                        void    glBindRenderbuffer(GLenum target, GLuint renderbuffer)
--                        void    glBindTexture(GLenum target, GLuint texture)
--                        void    glBlendColor(GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha)
--                        void    glBlendEquation(GLenum mode)
--                        void    glBlendEquationSeparate(GLenum modeRGB, GLenum modeAlpha)
--                        void    glBlendFunc(GLenum sfactor, GLenum dfactor)
--                        void    glBlendFuncSeparate(GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha)

   not overriding procedure gl_Buffer_Data
    (Self   : in out OpenGL_Functions;
     Target : OpenGL.GLenum;
     Size   : OpenGL.GLsizeiptr;
     Data   : System.Address;
     Usage  : OpenGL.GLenum) is abstract;

--                        void    glBufferSubData(GLenum target, qopengl_GLintptr offset, qopengl_GLsizeiptr size, const void * data)
--                        GLenum  glCheckFramebufferStatus(GLenum target)
--                        void    glClear(GLbitfield mask)

   not overriding procedure gl_Clear
    (Self : in out OpenGL_Functions;
     Mask : OpenGL.Clear_Buffer_Mask) is abstract;
   --  Clear buffers to preset values.

   not overriding procedure gl_Clear_Color
    (Self  : in out OpenGL_Functions;
     Red   : OpenGL.GLclampf;
     Green : OpenGL.GLclampf;
     Blue  : OpenGL.GLclampf;
     Alpha : OpenGL.GLclampf) is abstract;
   --  glClearColor specifies the red, green, blue, and alpha values used by
   --  glClear to clear the color buffers. Values specified by glClearColor
   --  are clamped to the range 0.0 .. 1.0.

--                        void    glClearDepthf(GLclampf depth)
--                        void    glClearStencil(GLint s)
--                        void    glColorMask(GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha)

   not overriding procedure gl_Compile_Shader
    (Self   : in out OpenGL_Functions;
     Shader : OpenGL.GLuint) is abstract;
   --  Compile a shader object.

--                        void    glCompressedTexImage2D(GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void * data)
--                        void    glCompressedTexSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void * data)
--                        void    glCopyTexImage2D(GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border)
--                        void    glCopyTexSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height)

--                        GLuint  glCreateProgram()

   not overriding function gl_Create_Program
    (Self : in out OpenGL_Functions) return OpenGL.GLuint is abstract;
   --  Creates a program object.

   not overriding function gl_Create_Shader
    (Self        : in out OpenGL_Functions;
     Shader_Type : OpenGL.GLenum) return OpenGL.GLuint is abstract;
   --  Creates a shader object.

--                        void    glCullFace(GLenum mode)

   not overriding procedure gl_Delete_Buffers
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
--                        void    glDisableVertexAttribArray(GLuint index)

   not overriding procedure gl_Draw_Arrays
    (Self  : in out OpenGL_Functions;
     Mode  : OpenGL.GLenum;
     First : OpenGL.GLint;
     Count : OpenGL.GLsizei) is abstract;
   --  Render primitives from array data.

--                        void    glDrawElements(GLenum mode, GLsizei count, GLenum type, const GLvoid * indices)

   not overriding procedure gl_Enable
    (Self : in out OpenGL_Functions;
     Cap  : OpenGL.GLenum) is abstract;
   --  glEnable and glDisable enable and disable various capabilities.

--                        void    glEnableVertexAttribArray(GLuint index)
--                        void    glFinish()
--                        void    glFlush()
--                        void    glFramebufferRenderbuffer(GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer)
--                        void    glFramebufferTexture2D(GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level)
--                        void    glFrontFace(GLenum mode)

   not overriding procedure gl_Gen_Buffers
    (Self    : in out OpenGL_Functions;
     Buffers : in out OpenGL.GLuint_Array) is abstract;
   --  Generate buffer object names.

--                        void    glGenFramebuffers(GLsizei n, GLuint * framebuffers)
--                        void    glGenRenderbuffers(GLsizei n, GLuint * renderbuffers)
--                        void    glGenTextures(GLsizei n, GLuint * textures)
--                        void    glGenerateMipmap(GLenum target)
--                        void    glGetActiveAttrib(GLuint program, GLuint index, GLsizei bufsize, GLsizei * length, GLint * size, GLenum * type, char * name)
--                        void    glGetActiveUniform(GLuint program, GLuint index, GLsizei bufsize, GLsizei * length, GLint * size, GLenum * type, char * name)
--                        void    glGetAttachedShaders(GLuint program, GLsizei maxcount, GLsizei * count, GLuint * shaders)
--                        GLint   glGetAttribLocation(GLuint program, const char * name)
--                        void    glGetBooleanv(GLenum pname, GLboolean * params)
--                        void    glGetBufferParameteriv(GLenum target, GLenum pname, GLint * params)
--                        GLenum  glGetError()
--                        void    glGetFloatv(GLenum pname, GLfloat * params)
--                        void    glGetFramebufferAttachmentParameteriv(GLenum target, GLenum attachment, GLenum pname, GLint * params)
--                        void    glGetIntegerv(GLenum pname, GLint * params)
--                        void    glGetProgramInfoLog(GLuint program, GLsizei bufsize, GLsizei * length, char * infolog)

   not overriding procedure gl_Get_Programiv
    (Self    : in out OpenGL_Functions;
     Program : OpenGL.GLuint;
     Pname   : OpenGL.GLenum;
     Param   : out OpenGL.GLint) is abstract;
   --  Return a parameter from a program object.

--                        void    glGetRenderbufferParameteriv(GLenum target, GLenum pname, GLint * params)
--                        void    glGetShaderInfoLog(GLuint shader, GLsizei bufsize, GLsizei * length, char * infolog)
--                        void    glGetShaderPrecisionFormat(GLenum shadertype, GLenum precisiontype, GLint * range, GLint * precision)
--                        void    glGetShaderSource(GLuint shader, GLsizei bufsize, GLsizei * length, char * source)

   not overriding procedure gl_Get_Shaderiv
    (Self   : in out OpenGL_Functions;
     Shader : OpenGL.GLuint;
     Pname  : OpenGL.GLenum;
     Param  : out OpenGL.GLint) is abstract;
   --  Return a parameter from a shader object.

--                        const GLubyte *         glGetString(GLenum name)
--                        void    glGetTexParameterfv(GLenum target, GLenum pname, GLfloat * params)
--                        void    glGetTexParameteriv(GLenum target, GLenum pname, GLint * params)
--                        GLint   glGetUniformLocation(GLuint program, const char * name)
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

   not overriding procedure gl_Link_Program
    (Self    : in out OpenGL_Functions;
     Program : OpenGL.GLuint) is abstract;

--                        void    glPixelStorei(GLenum pname, GLint param)
--                        void    glPolygonOffset(GLfloat factor, GLfloat units)
--                        void    glReadPixels(GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid * pixels)
--                        void    glReleaseShaderCompiler()
--                        void    glRenderbufferStorage(GLenum target, GLenum internalformat, GLsizei width, GLsizei height)
--                        void    glSampleCoverage(GLclampf value, GLboolean invert)
--                        void    glScissor(GLint x, GLint y, GLsizei width, GLsizei height)
--                        void    glShaderBinary(GLint n, const GLuint * shaders, GLenum binaryformat, const void * binary, GLint length)

   not overriding procedure gl_Shader_Source
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
--                        void    glUniformMatrix2fv(GLint location, GLsizei count, GLboolean transpose, const GLfloat * value)
--                        void    glUniformMatrix3fv(GLint location, GLsizei count, GLboolean transpose, const GLfloat * value)
--                        void    glUniformMatrix4fv(GLint location, GLsizei count, GLboolean transpose, const GLfloat * value)

   not overriding procedure gl_Use_Program
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
--                        void    glVertexAttribPointer(GLuint indx, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const void * ptr)

   not overriding procedure gl_Viewport
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
