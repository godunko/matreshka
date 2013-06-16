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
-- Copyright © 2013, Vadim Godunko <vgodunko@gmail.com>                     --
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
private with League.Strings;
private with League.String_Vectors;
private with Matreshka.File_Engines;
with Matreshka.File_System_Engines;
private with Zip.IO;
private with Zip.Metadata;

package Matreshka.Zip_File_System_Engines is

   type Zip_File_System_Engine is
     new Matreshka.File_System_Engines.Abstract_File_System_Engine
       with private;

private

   type Zip_File_System_Engine is
     new Matreshka.File_System_Engines.Abstract_File_System_Engine with record
      File              : Zip.IO.File_Type;
      Central_Directory : Zip.Metadata.Central_Directory;
   end record;

   overriding function Create_File_Engine
    (Self : not null access Zip_File_System_Engine;
     Path : League.Strings.Universal_String)
       return Matreshka.File_Engines.File_Engine_Access;
   --  Creates file engine object to handle specified path. Path is relative to
   --  file system engine.

   overriding function Entry_List
    (Self        : not null access Zip_File_System_Engine;
     File_Engine : Matreshka.File_Engines.File_Engine_Access)
       return League.String_Vectors.Universal_String_Vector;
   --  Returns a list of the names of all files and directories when
   --  File_Engine represents directory.

end Matreshka.Zip_File_System_Engines;
