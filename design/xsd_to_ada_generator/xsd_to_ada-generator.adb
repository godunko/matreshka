------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
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
--  $Revision: 3559 $ $Date: 2012-12-07 13:08:31 +0200 (Пт., 07 дек. 2012) $
------------------------------------------------------------------------------

with Ada.Directories;
with Ada.Containers.Vectors;

with League.Strings;
with League.String_Vectors;

with XSD_To_Ada.Utils;
with XSD_To_Ada.Encoder;
with XSD_To_Ada.Mappings_XML;

package body XSD_To_Ada.Generator is

   Tab   : Natural := 0;

   ---------
   -- Dec --
   ---------

   procedure Dec is begin
      if Tab > 2 then
         Tab := Tab - 3;
      else
         Tab := 0;
      end if;
   end Dec;

   -----------------
   -- Delete_File --
   -----------------

   procedure Delete_File (Name : String) is
   begin
      if Ada.Directories.Exists (Name) then
         Ada.Directories.Delete_File (Name);
      end if;
   end Delete_File;

   --------------
   -- Generate --
   --------------

   procedure Generate
     (Model        : XML.Schema.Models.XS_Model;
      Mapping_Path : League.Strings.Universal_String) is
   begin
      XSD_To_Ada.Utils.Create_Complex_Type (Model, Mapping_Path);
      XSD_To_Ada.Encoder.Create_Complex_Type (Model, Mapping_Path);
   end Generate;

   ---------
   -- Inc --
   ---------

   procedure Inc is begin
      Tab := Tab + 3;
   end Inc;

   -------
   -- P --
   -------

   procedure P
     (Self : in out XSD_To_Ada.Writers.Writer; Txt : Wide_Wide_String) is
   begin
      Self.P (Txt);
   end P;

end XSD_To_Ada.Generator;
