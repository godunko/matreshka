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
private with Ada.Finalization;

generic
   type Element is private;
   type Index is range <>;
   type Element_Array is array (Index range <>) of Element;

package OpenGL.Generic_Buffers is

   pragma Preelaborate;

   type OpenGL_Buffer is tagged private;

--   procedure Allocate
--    (Self : in out OpenGL_Buffer'Class; Data : Element_Array);
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

   procedure Create (Self : in out OpenGL_Buffer'Class);

   procedure Initialize
    (Self        : in out OpenGL_Buffer'Class;
     Buffer_Type : OpenGL.Buffer_Type);

private

   type Buffer_Shared_Data;

   type Buffer_Shared_Data_Access is access all Buffer_Shared_Data;

   type OpenGL_Buffer is new Ada.Finalization.Controlled with record
      Data : Buffer_Shared_Data_Access;
   end record;

   overriding procedure Adjust (Self : in out OpenGL_Buffer);

   overriding procedure Finalize (Self : in out OpenGL_Buffer);

end OpenGL.Generic_Buffers;
