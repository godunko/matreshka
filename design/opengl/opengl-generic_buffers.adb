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
with Ada.Unchecked_Deallocation;

with Matreshka.Atomics.Counters;

with OpenGL.Contexts;
with OpenGL.Functions;

package body OpenGL.Generic_Buffers is

   use type OpenGL.Contexts.OpenGL_Context_Access;

   type Buffer_Shared_Data is record
      Counter     : Matreshka.Atomics.Counters.Counter;
      Context     : OpenGL.Contexts.OpenGL_Context_Access;
      Buffer_Type : OpenGL.GLenum;
      Buffer_Id   : OpenGL.GLuint;
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

      Self.Data.Context.Functions.gl_Bind_Buffer
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

   procedure Create (Self : in out OpenGL_Buffer'Class) is
      Buffers : OpenGL.GLuint_Array (1 .. 1);

   begin
      if Self.Data = null then
         --  Initialize buffer as vertex buffer when it was not be initialized.

         Self.Initialize (OpenGL.Vertex_Buffer);
      end if;

      Self.Data.Context.Functions.gl_Gen_Buffers (Buffers);
      Self.Data.Buffer_Id := Buffers (Buffers'First);
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

--      Functions := OpenGL.Contexts.Current_Context.Functions;
      Self.Data :=
        new Buffer_Shared_Data'
             (Counter     => <>,
              Context     => OpenGL.Contexts.Current_Context,
              Buffer_Type =>
               (if Buffer_Type = Vertex_Buffer
                  then GL_ARRAY_BUFFER
                  else GL_ELEMENT_ARRAY_BUFFER),
              Buffer_Id   => 0);
   end Initialize;

   ---------------
   -- Reference --
   ---------------

   procedure Reference (Self : in out not null Buffer_Shared_Data_Access) is
   begin
      Matreshka.Atomics.Counters.Increment (Self.Counter);
   end Reference;

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
            Self.Context.Functions.gl_Delete_Buffers (Buffers);
            Free (Self);
         end;
      end if;

      Self := null;
   end Unreference;

end OpenGL.Generic_Buffers;
