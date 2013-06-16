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
with League.String_Vectors;
with Matreshka.Zip_File_Engines;
with Zip.IO;
with Zip.Metadata;

package body Matreshka.Zip_File_System_Engines is

   function Create
    (Path : League.Strings.Universal_String)
       return not null Matreshka.File_System_Engines.File_System_Engine_Access;

   procedure Initialize
    (Self : in out Zip_File_System_Engine'Class;
     Path : League.Strings.Universal_String);

   ------------
   -- Create --
   ------------

   function Create
    (Path : League.Strings.Universal_String)
       return not null Matreshka.File_System_Engines.File_System_Engine_Access
   is
   begin
      return Result :
        not null Matreshka.File_System_Engines.File_System_Engine_Access
          := new Zip_File_System_Engine
      do
         Initialize (Zip_File_System_Engine'Class (Result.all), Path);
      end return;
   end Create;

   ------------------------
   -- Create_File_Engine --
   ------------------------

   overriding function Create_File_Engine
    (Self : not null access Zip_File_System_Engine;
     Path : League.Strings.Universal_String)
       return Matreshka.File_Engines.File_Engine_Access is
   begin
      return Result : Matreshka.File_Engines.File_Engine_Access
        := new Matreshka.Zip_File_Engines.Zip_File_Engine
      do
         Matreshka.Zip_File_Engines.Initialize
          (Matreshka.Zip_File_Engines.Zip_File_Engine'Class (Result.all),
           Self,
           League.String_Vectors.Empty_Universal_String_Vector,
           0);
--           Matreshka.File_Engines.File_Engine_Access (Self));
      end return;
   end Create_File_Engine;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self : in out Zip_File_System_Engine'Class;
     Path : League.Strings.Universal_String) is
   begin
      Zip.IO.Open (Self.File, Path.To_UTF_8_String);
      Self.Central_Directory := Zip.Metadata.Read (Self.File);
      Zip.IO.Close (Self.File);
   end Initialize;

begin
   Matreshka.File_System_Engines.Create := Create'Access;
end Matreshka.Zip_File_System_Engines;
