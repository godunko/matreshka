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
with Ada.Unchecked_Deallocation;
with System;

with Matreshka.Atomics.Counters;

with OpenGL.Contexts;
with OpenGL.Functions;

package body OpenGL.Generic_Buffers is

   use type OpenGL.Contexts.OpenGL_Context_Access;

   type Buffer_Shared_Data is record
      Counter      : Matreshka.Atomics.Counters.Counter;
      Context      : OpenGL.Contexts.OpenGL_Context_Access;
      Buffer_Type  : OpenGL.GLenum;
      Buffer_Usage : OpenGL.GLenum;
      Buffer_Id    : OpenGL.GLuint;
   end record;

   procedure Reference (Self : in out not null Buffer_Shared_Data_Access);

   procedure Unreference (Self : in out Buffer_Shared_Data_Access);

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out OpenGL_Buffer) is
   begin
      if Self.Data /= null then
         Reference (Self.Data);
      end if;
   end Adjust;

   --------------
   -- Allocate --
   --------------

   procedure Allocate
    (Self : in out OpenGL_Buffer'Class; Data : Element_Array) is
   begin
      Self.Data.Context.Functions.glBufferData
       (Self.Data.Buffer_Type,
        Data'Size / System.Storage_Unit,
        Data (Data'First)'Address,
        Self.Data.Buffer_Usage);
   end Allocate;

   ----------
   -- Bind --
   ----------

   function Bind (Self : in out OpenGL_Buffer'Class) return Boolean is
      use type OpenGL.Contexts.OpenGL_Context_Access;

   begin
      if Self.Data = null
        or else Self.Data.Context /= OpenGL.Contexts.Current_Context
      then
         --  Buffer was not created or created for another context.

         return False;
      end if;

      Self.Data.Context.Functions.glBindBuffer
       (Self.Data.Buffer_Type, Self.Data.Buffer_Id);

      return True;
   end Bind;

   ----------
   -- Bind --
   ----------

   procedure Bind (Self : in out OpenGL_Buffer'Class) is
   begin
      if not Self.Bind then
         raise Program_Error;
      end if;
   end Bind;

   ------------
   -- Create --
   ------------

   procedure Create
    (Self        : in out OpenGL_Buffer'Class;
     Buffer_Type : OpenGL.Buffer_Type)
   is
      Buffers : OpenGL.GLuint_Array (1 .. 1);

   begin
      if OpenGL.Contexts.Current_Context = null then
         raise Program_Error;
      end if;

      OpenGL.Contexts.Current_Context.Functions.glGenBuffers (Buffers);
      Self.Data :=
        new Buffer_Shared_Data'
             (Counter      => <>,
              Context      => OpenGL.Contexts.Current_Context,
              Buffer_Type  =>
               (if Buffer_Type = Vertex_Buffer
                  then GL_ARRAY_BUFFER
                  else GL_ELEMENT_ARRAY_BUFFER),
              Buffer_Usage => GL_STATIC_DRAW,
              Buffer_Id    => Buffers (Buffers'First));
   end Create;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out OpenGL_Buffer) is
   begin
      if Self.Data /= null then
         Unreference (Self.Data);
      end if;
   end Finalize;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self        : in out OpenGL_Buffer'Class;
     Buffer_Type : OpenGL.Buffer_Type) is
   begin
      if OpenGL.Contexts.Current_Context = null then
         raise Program_Error;
      end if;

      Self.Data :=
        new Buffer_Shared_Data'
             (Counter      => <>,
              Context      => OpenGL.Contexts.Current_Context,
              Buffer_Type  =>
               (if Buffer_Type = Vertex_Buffer
                  then GL_ARRAY_BUFFER
                  else GL_ELEMENT_ARRAY_BUFFER),
              Buffer_Usage => GL_STATIC_DRAW,
              Buffer_Id    => 0);
   end Initialize;

   ---------------
   -- Reference --
   ---------------

   procedure Reference (Self : in out not null Buffer_Shared_Data_Access) is
   begin
      Matreshka.Atomics.Counters.Increment (Self.Counter);
   end Reference;

   ------------
   -- Stride --
   ------------

   function Stride return OpenGL.GLsizei is
   begin
      return Element_Array'Component_Size / System.Storage_Unit;
   end Stride;

   -----------------
   -- Unreference --
   -----------------

   procedure Unreference (Self : in out Buffer_Shared_Data_Access) is

      procedure Free is
        new Ada.Unchecked_Deallocation
             (Buffer_Shared_Data, Buffer_Shared_Data_Access);

   begin
      if Matreshka.Atomics.Counters.Decrement (Self.Counter) then
         declare
            Buffers : OpenGL.GLuint_Array (1 .. 1) := (1 => Self.Buffer_Id);

         begin
            Self.Context.Functions.glDeleteBuffers (Buffers);
            Free (Self);
         end;
      end if;

      Self := null;
   end Unreference;

end OpenGL.Generic_Buffers;
