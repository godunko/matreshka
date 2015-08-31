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
with Interfaces;
with System.Storage_Elements;

package OpenGL is

   pragma Pure;

   type GLfloat is new Interfaces.IEEE_Float_32;

   type GLfloat_Matrix_2x2 is
     array (Positive range 1 .. 2, Positive range 1 .. 2) of aliased GLfloat
       with Convention => Fortran;

   type GLfloat_Matrix_3x3 is
     array (Positive range 1 .. 3, Positive range 1 .. 3) of aliased GLfloat
       with Convention => Fortran;

   type GLfloat_Matrix_4x4 is
     array (Positive range 1 .. 4, Positive range 1 .. 4) of aliased GLfloat
       with Convention => Fortran;

   type GLfloat_Matrix_2x2_Array is
     array (Positive range <>) of GLfloat_Matrix_2x2;

   type GLfloat_Matrix_3x3_Array is
     array (Positive range <>) of GLfloat_Matrix_3x3;

   type GLfloat_Matrix_4x4_Array is
     array (Positive range <>) of GLfloat_Matrix_4x4;

   subtype GLclampf is GLfloat range 0.0 .. 1.0;

   type GLboolean is private;

   type GLint is new Interfaces.Integer_32;

   type GLuint is new Interfaces.Unsigned_32;

   type GLsizei is
     new Interfaces.Integer_32 range 0 .. Interfaces.Integer_32'Last;

   type GLuint_Array is array (Positive range <>) of aliased GLuint;

   type GLsizeiptr is new System.Storage_Elements.Storage_Offset;

   type GLbitfield is private;

   type GLenum is private;

   --  AttribMask

   GL_COLOR_BUFFER_BIT   : constant GLbitfield;
   GL_DEPTH_BUFFER_BIT   : constant GLbitfield;
   GL_STENCIL_BUFFER_BIT : constant GLbitfield;

   --  Boolean

   GL_FALSE : constant GLboolean;
   GL_TRUE  : constant GLboolean;

   --  PrimitiveType

   GL_LINES          : constant GLenum;
   GL_LINE_LOOP      : constant GLenum;
   GL_LINE_STRIP     : constant GLenum;
   GL_POINTS         : constant GLenum;
   GL_TRIANGLES      : constant GLenum;
   GL_TRIANGLE_STRIP : constant GLenum;
   GL_TRIANGLE_FAN   : constant GLenum;

   GL_ACTIVE_ATTRIBUTE_MAX_LENGTH : constant GLenum;
   GL_ACTIVE_ATTRIBUTES           : constant GLenum;
   GL_ARRAY_BUFFER                : constant GLenum;
   GL_BYTE                        : constant Glenum;
   GL_CLAMP_TO_EDGE               : constant GLenum;
   GL_COMPILE_STATUS              : constant GLenum;
   GL_DELETE_STATUS               : constant GLenum;
   GL_DEPTH_COMPONENT             : constant GLenum;
   GL_DEPTH_TEST                  : constant GLenum;
   GL_DYNAMIC_DRAW                : constant GLenum;
   GL_ELEMENT_ARRAY_BUFFER        : constant GLenum;
   GL_FIXED                       : constant GLenum;
   GL_FLOAT                       : constant GLenum;
   GL_FRAGMENT_SHADER             : constant GLenum;
   GL_FRAMEBUFFER                 : constant GLenum;
   GL_INFO_LOG_LENGTH             : constant GLenum;
   GL_INT                         : constant GLenum;
   GL_LINEAR                      : constant GLenum;
   GL_LINEAR_MIPMAP_LINEAR        : constant GLenum;
   GL_LINEAR_MIPMAP_NEAREST       : constant GLenum;
   GL_LINK_STATUS                 : constant GLenum;
   GL_MIRRORED_REPEAT             : constant GLenum;
   GL_NEAREST                     : constant GLenum;
   GL_NEAREST_MIPMAP_LINEAR       : constant GLenum;
   GL_NEAREST_MIPMAP_NEAREST      : constant GLenum;
   GL_REPEAT                      : constant GLenum;
   GL_RENDERBUFFER                : constant GLenum;
   GL_RGB                         : constant GLenum;
   GL_RGBA                        : constant GLenum;
   GL_SHADER_SOURCE_LENGTH        : constant GLenum;
   GL_SHADER_TYPE                 : constant GLenum;
   GL_SHORT                       : constant GLenum;
   GL_STATIC_DRAW                 : constant GLenum;
   GL_STREAM_DRAW                 : constant GLenum;
   GL_TEXTURE_2D                  : constant GLenum;
   GL_TEXTURE_CUBE_MAP            : constant GLenum;
   GL_TEXTURE_CUBE_MAP_NEGATIVE_X : constant GLenum;
   GL_TEXTURE_CUBE_MAP_NEGATIVE_Y : constant GLenum;
   GL_TEXTURE_CUBE_MAP_NEGATIVE_Z : constant GLenum;
   GL_TEXTURE_CUBE_MAP_POSITIVE_X : constant GLenum;
   GL_TEXTURE_CUBE_MAP_POSITIVE_Y : constant GLenum;
   GL_TEXTURE_CUBE_MAP_POSITIVE_Z : constant GLenum;
   GL_TEXTURE_MAG_FILTER          : constant GLenum;
   GL_TEXTURE_MIN_FILTER          : constant GLenum;
   GL_TEXTURE_WRAP_S              : constant GLenum;
   GL_TEXTURE_WRAP_T              : constant GLenum;
   GL_UNSIGNED_BYTE               : constant GLenum;
   GL_UNSIGNED_INT                : constant GLenum;
   GL_UNSIGNED_SHORT              : constant GLenum;
   GL_VALIDATE_STATUS             : constant GLenum;
   GL_VERTEX_SHADER               : constant GLenum;

   subtype Clear_Buffer_Mask_Bits is GLbitfield
     with Static_Predicate =>
            Clear_Buffer_Mask_Bits in GL_COLOR_BUFFER_BIT
                                       | GL_DEPTH_BUFFER_BIT
                                       | GL_STENCIL_BUFFER_BIT;

   type Clear_Buffer_Mask is private;

   function "+"
    (Left  : Clear_Buffer_Mask_Bits;
     Right : Clear_Buffer_Mask_Bits) return Clear_Buffer_Mask;

   --   <feature api="gles2" name="GL_ES_VERSION_2_0" number="2.0">
   --     <require comment="Not used by the API, for compatibility with old gl2.h">
   --       <type name="GLbyte"/>
   --       <type name="GLclampf"/>
   --       <type name="GLfixed"/>
   --       <type name="GLshort"/>
   --       <type name="GLushort"/>
   --       <type name="GLvoid" comment="No longer used in headers"/>
   --     </require>
   --     <require comment="Not used by the API; put here so this type doesn't need to be declared in gl2ext.h">
   --       <type name="GLsync"/>
   --       <type name="GLint64"/>
   --       <type name="GLuint64"/>
   --     </require>
   --     <require>
   --       <enum name="GL_ZERO"/>
   --       <enum name="GL_ONE"/>
   --       <enum name="GL_SRC_COLOR"/>
   --       <enum name="GL_ONE_MINUS_SRC_COLOR"/>
   --       <enum name="GL_SRC_ALPHA"/>
   --       <enum name="GL_ONE_MINUS_SRC_ALPHA"/>
   --       <enum name="GL_DST_ALPHA"/>
   --       <enum name="GL_ONE_MINUS_DST_ALPHA"/>
   --       <enum name="GL_DST_COLOR"/>
   --       <enum name="GL_ONE_MINUS_DST_COLOR"/>
   --       <enum name="GL_SRC_ALPHA_SATURATE"/>
   --       <enum name="GL_FUNC_ADD"/>
   --       <enum name="GL_BLEND_EQUATION"/>
   --       <enum name="GL_BLEND_EQUATION_RGB"/>
   --       <enum name="GL_BLEND_EQUATION_ALPHA"/>
   --       <enum name="GL_FUNC_SUBTRACT"/>
   --       <enum name="GL_FUNC_REVERSE_SUBTRACT"/>
   --       <enum name="GL_BLEND_DST_RGB"/>
   --       <enum name="GL_BLEND_SRC_RGB"/>
   --       <enum name="GL_BLEND_DST_ALPHA"/>
   --       <enum name="GL_BLEND_SRC_ALPHA"/>
   --       <enum name="GL_CONSTANT_COLOR"/>
   --       <enum name="GL_ONE_MINUS_CONSTANT_COLOR"/>
   --       <enum name="GL_CONSTANT_ALPHA"/>
   --       <enum name="GL_ONE_MINUS_CONSTANT_ALPHA"/>
   --       <enum name="GL_BLEND_COLOR"/>
   --       <enum name="GL_ARRAY_BUFFER_BINDING"/>
   --       <enum name="GL_ELEMENT_ARRAY_BUFFER_BINDING"/>
   --       <enum name="GL_BUFFER_SIZE"/>
   --       <enum name="GL_BUFFER_USAGE"/>
   --       <enum name="GL_CURRENT_VERTEX_ATTRIB"/>
   --       <enum name="GL_FRONT"/>
   --       <enum name="GL_BACK"/>
   --       <enum name="GL_FRONT_AND_BACK"/>
   --       <enum name="GL_CULL_FACE"/>
   --       <enum name="GL_BLEND"/>
   --       <enum name="GL_DITHER"/>
   --       <enum name="GL_STENCIL_TEST"/>
   --       <enum name="GL_SCISSOR_TEST"/>
   --       <enum name="GL_POLYGON_OFFSET_FILL"/>
   --       <enum name="GL_SAMPLE_ALPHA_TO_COVERAGE"/>
   --       <enum name="GL_SAMPLE_COVERAGE"/>
   --       <enum name="GL_NO_ERROR"/>
   --       <enum name="GL_INVALID_ENUM"/>
   --       <enum name="GL_INVALID_VALUE"/>
   --       <enum name="GL_INVALID_OPERATION"/>
   --       <enum name="GL_OUT_OF_MEMORY"/>
   --       <enum name="GL_CW"/>
   --       <enum name="GL_CCW"/>
   --       <enum name="GL_LINE_WIDTH"/>
   --       <enum name="GL_ALIASED_POINT_SIZE_RANGE"/>
   --       <enum name="GL_ALIASED_LINE_WIDTH_RANGE"/>
   --       <enum name="GL_CULL_FACE_MODE"/>
   --       <enum name="GL_FRONT_FACE"/>
   --       <enum name="GL_DEPTH_RANGE"/>
   --       <enum name="GL_DEPTH_WRITEMASK"/>
   --       <enum name="GL_DEPTH_CLEAR_VALUE"/>
   --       <enum name="GL_DEPTH_FUNC"/>
   --       <enum name="GL_STENCIL_CLEAR_VALUE"/>
   --       <enum name="GL_STENCIL_FUNC"/>
   --       <enum name="GL_STENCIL_FAIL"/>
   --       <enum name="GL_STENCIL_PASS_DEPTH_FAIL"/>
   --       <enum name="GL_STENCIL_PASS_DEPTH_PASS"/>
   --       <enum name="GL_STENCIL_REF"/>
   --       <enum name="GL_STENCIL_VALUE_MASK"/>
   --       <enum name="GL_STENCIL_WRITEMASK"/>
   --       <enum name="GL_STENCIL_BACK_FUNC"/>
   --       <enum name="GL_STENCIL_BACK_FAIL"/>
   --       <enum name="GL_STENCIL_BACK_PASS_DEPTH_FAIL"/>
   --       <enum name="GL_STENCIL_BACK_PASS_DEPTH_PASS"/>
   --       <enum name="GL_STENCIL_BACK_REF"/>
   --       <enum name="GL_STENCIL_BACK_VALUE_MASK"/>
   --       <enum name="GL_STENCIL_BACK_WRITEMASK"/>
   --       <enum name="GL_VIEWPORT"/>
   --       <enum name="GL_SCISSOR_BOX"/>
   --       <enum name="GL_COLOR_CLEAR_VALUE"/>
   --       <enum name="GL_COLOR_WRITEMASK"/>
   --       <enum name="GL_UNPACK_ALIGNMENT"/>
   --       <enum name="GL_PACK_ALIGNMENT"/>
   --       <enum name="GL_MAX_TEXTURE_SIZE"/>
   --       <enum name="GL_MAX_VIEWPORT_DIMS"/>
   --       <enum name="GL_SUBPIXEL_BITS"/>
   --       <enum name="GL_RED_BITS"/>
   --       <enum name="GL_GREEN_BITS"/>
   --       <enum name="GL_BLUE_BITS"/>
   --       <enum name="GL_ALPHA_BITS"/>
   --       <enum name="GL_DEPTH_BITS"/>
   --       <enum name="GL_STENCIL_BITS"/>
   --       <enum name="GL_POLYGON_OFFSET_UNITS"/>
   --       <enum name="GL_POLYGON_OFFSET_FACTOR"/>
   --       <enum name="GL_TEXTURE_BINDING_2D"/>
   --       <enum name="GL_SAMPLE_BUFFERS"/>
   --       <enum name="GL_SAMPLES"/>
   --       <enum name="GL_SAMPLE_COVERAGE_VALUE"/>
   --       <enum name="GL_SAMPLE_COVERAGE_INVERT"/>
   --       <enum name="GL_NUM_COMPRESSED_TEXTURE_FORMATS"/>
   --       <enum name="GL_COMPRESSED_TEXTURE_FORMATS"/>
   --       <enum name="GL_DONT_CARE"/>
   --       <enum name="GL_FASTEST"/>
   --       <enum name="GL_NICEST"/>
   --       <enum name="GL_GENERATE_MIPMAP_HINT"/>
   --       <enum name="GL_ALPHA"/>
   --       <enum name="GL_LUMINANCE"/>
   --       <enum name="GL_LUMINANCE_ALPHA"/>
   --       <enum name="GL_UNSIGNED_SHORT_4_4_4_4"/>
   --       <enum name="GL_UNSIGNED_SHORT_5_5_5_1"/>
   --       <enum name="GL_UNSIGNED_SHORT_5_6_5"/>
   --       <enum name="GL_MAX_VERTEX_ATTRIBS"/>
   --       <enum name="GL_MAX_VERTEX_UNIFORM_VECTORS"/>
   --       <enum name="GL_MAX_VARYING_VECTORS"/>
   --       <enum name="GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS"/>
   --       <enum name="GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS"/>
   --       <enum name="GL_MAX_TEXTURE_IMAGE_UNITS"/>
   --       <enum name="GL_MAX_FRAGMENT_UNIFORM_VECTORS"/>
   --       <enum name="GL_SHADING_LANGUAGE_VERSION"/>
   --       <enum name="GL_CURRENT_PROGRAM"/>
   --       <enum name="GL_NEVER"/>
   --       <enum name="GL_LESS"/>
   --       <enum name="GL_EQUAL"/>
   --       <enum name="GL_LEQUAL"/>
   --       <enum name="GL_GREATER"/>
   --       <enum name="GL_NOTEQUAL"/>
   --       <enum name="GL_GEQUAL"/>
   --       <enum name="GL_ALWAYS"/>
   --       <enum name="GL_KEEP"/>
   --       <enum name="GL_REPLACE"/>
   --       <enum name="GL_INCR"/>
   --       <enum name="GL_DECR"/>
   --       <enum name="GL_INVERT"/>
   --       <enum name="GL_INCR_WRAP"/>
   --       <enum name="GL_DECR_WRAP"/>
   --       <enum name="GL_VENDOR"/>
   --       <enum name="GL_RENDERER"/>
   --       <enum name="GL_VERSION"/>
   --       <enum name="GL_EXTENSIONS"/>
   --       <enum name="GL_TEXTURE"/>
   --       <enum name="GL_TEXTURE_BINDING_CUBE_MAP"/>
   --       <enum name="GL_MAX_CUBE_MAP_TEXTURE_SIZE"/>
   --       <enum name="GL_TEXTURE0"/>
   --       <enum name="GL_TEXTURE1"/>
   --       <enum name="GL_TEXTURE2"/>
   --       <enum name="GL_TEXTURE3"/>
   --       <enum name="GL_TEXTURE4"/>
   --       <enum name="GL_TEXTURE5"/>
   --       <enum name="GL_TEXTURE6"/>
   --       <enum name="GL_TEXTURE7"/>
   --       <enum name="GL_TEXTURE8"/>
   --       <enum name="GL_TEXTURE9"/>
   --       <enum name="GL_TEXTURE10"/>
   --       <enum name="GL_TEXTURE11"/>
   --       <enum name="GL_TEXTURE12"/>
   --       <enum name="GL_TEXTURE13"/>
   --       <enum name="GL_TEXTURE14"/>
   --       <enum name="GL_TEXTURE15"/>
   --       <enum name="GL_TEXTURE16"/>
   --       <enum name="GL_TEXTURE17"/>
   --       <enum name="GL_TEXTURE18"/>
   --       <enum name="GL_TEXTURE19"/>
   --       <enum name="GL_TEXTURE20"/>
   --       <enum name="GL_TEXTURE21"/>
   --       <enum name="GL_TEXTURE22"/>
   --       <enum name="GL_TEXTURE23"/>
   --       <enum name="GL_TEXTURE24"/>
   --       <enum name="GL_TEXTURE25"/>
   --       <enum name="GL_TEXTURE26"/>
   --       <enum name="GL_TEXTURE27"/>
   --       <enum name="GL_TEXTURE28"/>
   --       <enum name="GL_TEXTURE29"/>
   --       <enum name="GL_TEXTURE30"/>
   --       <enum name="GL_TEXTURE31"/>
   --       <enum name="GL_ACTIVE_TEXTURE"/>
   --       <enum name="GL_FLOAT_VEC2"/>
   --       <enum name="GL_FLOAT_VEC3"/>
   --       <enum name="GL_FLOAT_VEC4"/>
   --       <enum name="GL_INT_VEC2"/>
   --       <enum name="GL_INT_VEC3"/>
   --       <enum name="GL_INT_VEC4"/>
   --       <enum name="GL_BOOL"/>
   --       <enum name="GL_BOOL_VEC2"/>
   --       <enum name="GL_BOOL_VEC3"/>
   --       <enum name="GL_BOOL_VEC4"/>
   --       <enum name="GL_FLOAT_MAT2"/>
   --       <enum name="GL_FLOAT_MAT3"/>
   --       <enum name="GL_FLOAT_MAT4"/>
   --       <enum name="GL_SAMPLER_2D"/>
   --       <enum name="GL_SAMPLER_CUBE"/>
   --       <enum name="GL_VERTEX_ATTRIB_ARRAY_ENABLED"/>
   --       <enum name="GL_VERTEX_ATTRIB_ARRAY_SIZE"/>
   --       <enum name="GL_VERTEX_ATTRIB_ARRAY_STRIDE"/>
   --       <enum name="GL_VERTEX_ATTRIB_ARRAY_TYPE"/>
   --       <enum name="GL_VERTEX_ATTRIB_ARRAY_NORMALIZED"/>
   --       <enum name="GL_VERTEX_ATTRIB_ARRAY_POINTER"/>
   --       <enum name="GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING"/>
   --       <enum name="GL_IMPLEMENTATION_COLOR_READ_TYPE"/>
   --       <enum name="GL_IMPLEMENTATION_COLOR_READ_FORMAT"/>
   --       <enum name="GL_SHADER_COMPILER"/>
   --       <enum name="GL_SHADER_BINARY_FORMATS"/>
   --       <enum name="GL_NUM_SHADER_BINARY_FORMATS"/>
   --       <enum name="GL_LOW_FLOAT"/>
   --       <enum name="GL_MEDIUM_FLOAT"/>
   --       <enum name="GL_HIGH_FLOAT"/>
   --       <enum name="GL_LOW_INT"/>
   --       <enum name="GL_MEDIUM_INT"/>
   --       <enum name="GL_HIGH_INT"/>
   --       <enum name="GL_RGBA4"/>
   --       <enum name="GL_RGB5_A1"/>
   --       <enum name="GL_RGB565"/>
   --       <enum name="GL_DEPTH_COMPONENT16"/>
   --       <enum name="GL_STENCIL_INDEX8"/>
   --       <enum name="GL_RENDERBUFFER_WIDTH"/>
   --       <enum name="GL_RENDERBUFFER_HEIGHT"/>
   --       <enum name="GL_RENDERBUFFER_INTERNAL_FORMAT"/>
   --       <enum name="GL_RENDERBUFFER_RED_SIZE"/>
   --       <enum name="GL_RENDERBUFFER_GREEN_SIZE"/>
   --       <enum name="GL_RENDERBUFFER_BLUE_SIZE"/>
   --       <enum name="GL_RENDERBUFFER_ALPHA_SIZE"/>
   --       <enum name="GL_RENDERBUFFER_DEPTH_SIZE"/>
   --       <enum name="GL_RENDERBUFFER_STENCIL_SIZE"/>
   --       <enum name="GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE"/>
   --       <enum name="GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME"/>
   --       <enum name="GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL"/>
   --       <enum name="GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE"/>
   --       <enum name="GL_COLOR_ATTACHMENT0"/>
   --       <enum name="GL_DEPTH_ATTACHMENT"/>
   --       <enum name="GL_STENCIL_ATTACHMENT"/>
   --       <enum name="GL_NONE"/>
   --       <enum name="GL_FRAMEBUFFER_COMPLETE"/>
   --       <enum name="GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT"/>
   --       <enum name="GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT"/>
   --       <enum name="GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS"/>
   --       <enum name="GL_FRAMEBUFFER_UNSUPPORTED"/>
   --       <enum name="GL_FRAMEBUFFER_BINDING"/>
   --       <enum name="GL_RENDERBUFFER_BINDING"/>
   --       <enum name="GL_MAX_RENDERBUFFER_SIZE"/>
   --       <enum name="GL_INVALID_FRAMEBUFFER_OPERATION"/>
   --       <command name="glActiveTexture"/>
   --       <command name="glBindAttribLocation"/>
   --       <command name="glBlendColor"/>
   --       <command name="glBlendEquation"/>
   --       <command name="glBlendEquationSeparate"/>
   --       <command name="glBlendFunc"/>
   --       <command name="glBlendFuncSeparate"/>
   --       <command name="glBufferSubData"/>
   --       <command name="glCheckFramebufferStatus"/>
   --       <command name="glClearDepthf"/>
   --       <command name="glClearStencil"/>
   --       <command name="glColorMask"/>
   --       <command name="glCompressedTexImage2D"/>
   --       <command name="glCompressedTexSubImage2D"/>
   --       <command name="glCopyTexImage2D"/>
   --       <command name="glCopyTexSubImage2D"/>
   --       <command name="glCullFace"/>
   --       <command name="glDeleteFramebuffers"/>
   --       <command name="glDeleteProgram"/>
   --       <command name="glDeleteRenderbuffers"/>
   --       <command name="glDeleteShader"/>
   --       <command name="glDeleteTextures"/>
   --       <command name="glDepthFunc"/>
   --       <command name="glDepthMask"/>
   --       <command name="glDepthRangef"/>
   --       <command name="glDetachShader"/>
   --       <command name="glDisable"/>
   --       <command name="glDisableVertexAttribArray"/>
   --       <command name="glDrawElements"/>
   --       <command name="glFinish"/>
   --       <command name="glFlush"/>
   --       <command name="glFramebufferRenderbuffer"/>
   --       <command name="glFramebufferTexture2D"/>
   --       <command name="glFrontFace"/>
   --       <command name="glGenerateMipmap"/>
   --       <command name="glGetActiveAttrib"/>
   --       <command name="glGetActiveUniform"/>
   --       <command name="glGetAttachedShaders"/>
   --       <command name="glGetBooleanv"/>
   --       <command name="glGetBufferParameteriv"/>
   --       <command name="glGetError"/>
   --       <command name="glGetFloatv"/>
   --       <command name="glGetFramebufferAttachmentParameteriv"/>
   --       <command name="glGetIntegerv"/>
   --       <command name="glGetProgramInfoLog"/>
   --       <command name="glGetRenderbufferParameteriv"/>
   --       <command name="glGetShaderInfoLog"/>
   --       <command name="glGetShaderPrecisionFormat"/>
   --       <command name="glGetShaderSource"/>
   --       <command name="glGetString"/>
   --       <command name="glGetTexParameterfv"/>
   --       <command name="glGetTexParameteriv"/>
   --       <command name="glGetUniformfv"/>
   --       <command name="glGetUniformiv"/>
   --       <command name="glGetVertexAttribfv"/>
   --       <command name="glGetVertexAttribiv"/>
   --       <command name="glGetVertexAttribPointerv"/>
   --       <command name="glHint"/>
   --       <command name="glIsBuffer"/>
   --       <command name="glIsEnabled"/>
   --       <command name="glIsFramebuffer"/>
   --       <command name="glIsProgram"/>
   --       <command name="glIsRenderbuffer"/>
   --       <command name="glIsShader"/>
   --       <command name="glIsTexture"/>
   --       <command name="glLineWidth"/>
   --       <command name="glPixelStorei"/>
   --       <command name="glPolygonOffset"/>
   --       <command name="glReadPixels"/>
   --       <command name="glReleaseShaderCompiler"/>
   --       <command name="glRenderbufferStorage"/>
   --       <command name="glSampleCoverage"/>
   --       <command name="glScissor"/>
   --       <command name="glShaderBinary"/>
   --       <command name="glStencilFunc"/>
   --       <command name="glStencilFuncSeparate"/>
   --       <command name="glStencilMask"/>
   --       <command name="glStencilMaskSeparate"/>
   --       <command name="glStencilOp"/>
   --       <command name="glStencilOpSeparate"/>
   --       <command name="glTexImage2D"/>
   --       <command name="glTexParameterf"/>
   --       <command name="glTexParameterfv"/>
   --       <command name="glTexParameteri"/>
   --       <command name="glTexParameteriv"/>
   --       <command name="glTexSubImage2D"/>
   --       <command name="glUniform1f"/>
   --       <command name="glUniform1fv"/>
   --       <command name="glUniform1i"/>
   --       <command name="glUniform1iv"/>
   --       <command name="glUniform2f"/>
   --       <command name="glUniform2fv"/>
   --       <command name="glUniform2i"/>
   --       <command name="glUniform2iv"/>
   --       <command name="glUniform3f"/>
   --       <command name="glUniform3fv"/>
   --       <command name="glUniform3i"/>
   --       <command name="glUniform3iv"/>
   --       <command name="glUniform4f"/>
   --       <command name="glUniform4fv"/>
   --       <command name="glUniform4i"/>
   --       <command name="glUniform4iv"/>
   --       <command name="glValidateProgram"/>
   --       <command name="glVertexAttrib1f"/>
   --       <command name="glVertexAttrib1fv"/>
   --       <command name="glVertexAttrib2f"/>
   --       <command name="glVertexAttrib2fv"/>
   --       <command name="glVertexAttrib3f"/>
   --       <command name="glVertexAttrib3fv"/>
   --       <command name="glVertexAttrib4f"/>
   --       <command name="glVertexAttrib4fv"/>
   --     </require>
   --   </feature>

   type Buffer_Type is (Vertex_Buffer, Index_Buffer);

   type Shader_Type is (Vertex_Shader, Fragment_Shader);

private

   type GLbitfield is new Interfaces.Unsigned_32;

   type GLboolean is new Interfaces.Unsigned_8;

   type GLenum is new Interfaces.Unsigned_32;

   GL_DEPTH_BUFFER_BIT   : constant GLbitfield := 16#0000_0100#;
   GL_STENCIL_BUFFER_BIT : constant GLbitfield := 16#0000_0400#;
   GL_COLOR_BUFFER_BIT   : constant GLbitfield := 16#0000_4000#;

   GL_FALSE : constant GLboolean := 0;
   GL_TRUE  : constant GLboolean := 1;

   GL_POINTS         : constant GLenum := 16#0000#;
   GL_LINES          : constant GLenum := 16#0001#;
   GL_LINE_LOOP      : constant GLenum := 16#0002#;
   GL_LINE_STRIP     : constant GLenum := 16#0003#;
   GL_TRIANGLES      : constant GLenum := 16#0004#;
   GL_TRIANGLE_STRIP : constant GLenum := 16#0005#;
   GL_TRIANGLE_FAN   : constant GLenum := 16#0006#;

   GL_DEPTH_TEST                  : constant GLenum := 16#0B71#;

   GL_TEXTURE_2D                  : constant GLenum := 16#0DE1#;

   GL_BYTE                        : constant Glenum := 16#1400#;
   GL_UNSIGNED_BYTE               : constant GLenum := 16#1401#;
   GL_SHORT                       : constant GLenum := 16#1402#;
   GL_UNSIGNED_SHORT              : constant GLenum := 16#1403#;
   GL_INT                         : constant GLenum := 16#1404#;
   GL_UNSIGNED_INT                : constant GLenum := 16#1405#;
   GL_FLOAT                       : constant GLenum := 16#1406#;
   GL_FIXED                       : constant GLenum := 16#140C#;

   GL_DEPTH_COMPONENT             : constant GLenum := 16#1902#;
   GL_RGB                         : constant GLenum := 16#1907#;
   GL_RGBA                        : constant GLenum := 16#1908#;

   GL_NEAREST                     : constant GLenum := 16#2600#;
   GL_LINEAR                      : constant GLenum := 16#2601#;

   GL_NEAREST_MIPMAP_NEAREST      : constant GLenum := 16#2700#;
   GL_LINEAR_MIPMAP_NEAREST       : constant GLenum := 16#2701#;
   GL_NEAREST_MIPMAP_LINEAR       : constant GLenum := 16#2702#;
   GL_LINEAR_MIPMAP_LINEAR        : constant GLenum := 16#2703#;

   GL_TEXTURE_MAG_FILTER          : constant GLenum := 16#2800#;
   GL_TEXTURE_MIN_FILTER          : constant GLenum := 16#2801#;
   GL_TEXTURE_WRAP_S              : constant GLenum := 16#2802#;
   GL_TEXTURE_WRAP_T              : constant GLenum := 16#2803#;

   GL_REPEAT                      : constant GLenum := 16#2901#;

   GL_CLAMP_TO_EDGE               : constant GLenum := 16#812F#;

   GL_MIRRORED_REPEAT             : constant GLenum := 16#8370#;

   GL_TEXTURE_CUBE_MAP            : constant GLenum := 16#8513#;
   GL_TEXTURE_CUBE_MAP_POSITIVE_X : constant GLenum := 16#8515#;
   GL_TEXTURE_CUBE_MAP_NEGATIVE_X : constant GLenum := 16#8516#;
   GL_TEXTURE_CUBE_MAP_POSITIVE_Y : constant GLenum := 16#8517#;
   GL_TEXTURE_CUBE_MAP_NEGATIVE_Y : constant GLenum := 16#8518#;
   GL_TEXTURE_CUBE_MAP_POSITIVE_Z : constant GLenum := 16#8519#;
   GL_TEXTURE_CUBE_MAP_NEGATIVE_Z : constant GLenum := 16#851A#;

   GL_ARRAY_BUFFER                : constant GLenum := 16#8892#;
   GL_ELEMENT_ARRAY_BUFFER        : constant GLenum := 16#8893#;

   GL_STREAM_DRAW                 : constant GLenum := 16#88E0#;
   GL_STATIC_DRAW                 : constant GLenum := 16#88E4#;
   GL_DYNAMIC_DRAW                : constant GLenum := 16#88E8#;

   GL_FRAGMENT_SHADER             : constant GLenum := 16#8B30#;
   GL_VERTEX_SHADER               : constant GLenum := 16#8B31#;
   GL_SHADER_TYPE                 : constant GLenum := 16#8B4F#;
   GL_DELETE_STATUS               : constant GLenum := 16#8B80#;
   GL_COMPILE_STATUS              : constant GLenum := 16#8B81#;
   GL_LINK_STATUS                 : constant GLenum := 16#8B82#;
   GL_VALIDATE_STATUS             : constant GLenum := 16#8B83#;
   GL_INFO_LOG_LENGTH             : constant GLenum := 16#8B84#;
   GL_SHADER_SOURCE_LENGTH        : constant GLenum := 16#8B88#;
   GL_ACTIVE_ATTRIBUTES           : constant GLenum := 16#8B89#;
   GL_ACTIVE_ATTRIBUTE_MAX_LENGTH : constant GLenum := 16#8B8A#;

   GL_FRAMEBUFFER                 : constant GLenum := 16#8D40#;
   GL_RENDERBUFFER                : constant GLenum := 16#8D41#;

   type Clear_Buffer_Mask is new GLbitfield;

end OpenGL;
