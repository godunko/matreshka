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

   use type League.Strings.Universal_String;

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
       procedure puts (Item : String);
       pragma Import (C, puts);
       Index : Natural := 0;

   begin
      return Result : Matreshka.File_Engines.File_Engine_Access
        := new Matreshka.Zip_File_Engines.Zip_File_Engine
      do
         for J in 1 .. Integer (Self.Central_Directory.Files.Length) loop
            if Self.Central_Directory.Files (J).File_Name = Path then
               Index := J;

               exit;
            end if;
         end loop;

         Matreshka.Zip_File_Engines.Initialize
          (Matreshka.Zip_File_Engines.Zip_File_Engine'Class (Result.all),
           Self,
           League.String_Vectors.Empty_Universal_String_Vector,
           Index);
      end return;
   end Create_File_Engine;

   ----------------
   -- Entry_List --
   ----------------

   overriding function Entry_List
    (Self        : not null access Zip_File_System_Engine;
     File_Engine : Matreshka.File_Engines.File_Engine_Access)
       return League.String_Vectors.Universal_String_Vector
   is
      File  : Matreshka.Zip_File_Engines.Zip_File_Engine
        renames Matreshka.Zip_File_Engines.Zip_File_Engine (File_Engine.all);
      Path  : League.Strings.Universal_String;
      Aux   : League.String_Vectors.Universal_String_Vector;
      Found : Boolean;

   begin
      if File.Index /= 0 then
         --  File_Engine points to file.

         return League.String_Vectors.Empty_Universal_String_Vector;

      else
         --  Construct full path name as used in archive.

         Path := File.Path.Join ('/');

         if not Path.Is_Empty then
            Path.Append ('/');
         end if;

         return Result : League.String_Vectors.Universal_String_Vector do
            for F of Self.Central_Directory.Files loop
               --  If file name starts with path and doesn't equal to path
               --  (that means an empty directory) then obtain first segment
               --  after path and add it to the list of entries.

               if F.File_Name.Starts_With (Path)
                 and then F.File_Name /= Path
               then
                  Aux :=
                    F.File_Name.Slice
                     (Path.Length + 1, F.File_Name.Length).Split ('/');
                  Found := False;

                  for J in 1 .. Result.Length loop
                     if Result (J) = Aux (1) then
                        Found := True;

                        exit;
                     end if;
                  end loop;

                  if not Found then
                     Result.Append (Aux (1));
                  end if;
               end if;
            end loop;
         end return;
      end if;
   end Entry_List;

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
