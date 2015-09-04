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
private with Ada.Finalization;

generic
   type Element is private;
   type Index is range <>;
   type Element_Array is array (Index range <>) of Element;

package OpenGL.Generic_Buffers is

   pragma Preelaborate;

   type OpenGL_Buffer is tagged private;

   procedure Allocate
    (Self : in out OpenGL_Buffer'Class; Data : Element_Array);
   --  Allocates necessary space to the buffer, initialized to the contents of
   --  data. Any previous contents will be removed.
   --
   --  It is assumed that Create has been called on this buffer and that it has
   --  been bound to the current context.

   function Bind (Self : in out OpenGL_Buffer'Class) return Boolean;
   --  Binds the buffer associated with this object to the current OpenGL
   --  context. Returns False if binding was not possible.

   procedure Bind (Self : in out OpenGL_Buffer'Class);
   --  Binds the buffer associated with this object to the current OpenGL
   --  context. Raises Program_Error when error occurs.

   procedure Create
    (Self        : in out OpenGL_Buffer'Class;
     Buffer_Type : OpenGL.Buffer_Type);
   --  Creates the buffer object in the OpenGL server. Returns True if the
   --  object was created; False otherwise.

   function Stride return OpenGL.GLsizei;
   --  Returns offset between two elements in element array in storage units.

private

   type Buffer_Shared_Data;

   type Buffer_Shared_Data_Access is access all Buffer_Shared_Data;

   type OpenGL_Buffer is new Ada.Finalization.Controlled with record
      Data : Buffer_Shared_Data_Access;
   end record;

   overriding procedure Adjust (Self : in out OpenGL_Buffer);

   overriding procedure Finalize (Self : in out OpenGL_Buffer);

end OpenGL.Generic_Buffers;
