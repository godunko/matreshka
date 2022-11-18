------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2012-2013, Vadim Godunko <vgodunko@gmail.com>                --
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
with Matreshka.Atomics.Counters;
with Matreshka.File_Engines;
with Matreshka.File_System_Engines;
with Matreshka.File_System_Entries;

package Matreshka.Internals.Files is

   pragma Preelaborate;

   type Shared_File_Information is tagged limited record
      Counter            : Matreshka.Atomics.Counters.Counter;
      File_System_Entry  : Matreshka.File_System_Entries.File_System_Entry;
      File_System_Engine : Matreshka.File_System_Engines.File_System_Engine_Access;
      --  File system engine to be used as base engine.
      Relative_Segments  : League.String_Vectors.Universal_String_Vector;
      --  File system entry to store path relative to base file system engine.
      File_Engine        : Matreshka.File_Engines.File_Engine_Access;
--      Device   : League.Strings.Universal_String;
--      Has_Root : Boolean;
--      Segments : League.String_Vectors.Universal_String_Vector;
   end record;

   type Shared_File_Information_Access is access all Shared_File_Information'Class;

   procedure Reference (Self : Shared_File_Information_Access);
   pragma Inline (Reference);
   pragma Inline_Always (Reference);
   --  Increments reference counter of the shared object.

   procedure Dereference (Self : in out Shared_File_Information_Access);
   --  Decrements reference counter of the shared object and dellocates memory
   --  when reference counter reach zero. Sets Self to null always.

end Matreshka.Internals.Files;
