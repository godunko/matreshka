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
-- Copyright © 2014, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Ada.Text_IO; use Ada.Text_IO;

package body Collations.Debug is

   ----------
   -- Dump --
   ----------

   procedure Dump (Item : AllKeys_Reader.Collation_Record) is
   begin
      null;
   end Dump;

   procedure Put_Line (Item : Matreshka.Internals.Unicode.Ucd.Contractor_Record);

   procedure Put (Item : Matreshka.Internals.Unicode.Code_Point) is
      use type Matreshka.Internals.Unicode.Code_Point;

      Hex : constant array (Matreshka.Internals.Unicode.Code_Point range 0 .. 15) of Character := "0123456789ABCDEF";

   begin
      Put ("16#");
      Put (Hex ((Item / 2 ** 20) mod 2 ** 4));
      Put (Hex ((Item / 2 ** 16) mod 2 ** 4));
      Put (Hex ((Item / 2 ** 12) mod 2 ** 4));
      Put (Hex ((Item / 2 ** 8) mod 2 ** 4));
      Put (Hex ((Item / 2 ** 4) mod 2 ** 4));
      Put (Hex ((Item) mod 2 ** 4));
      Put ('#');
   end Put;

   procedure Put_Line (Item : Matreshka.Internals.Unicode.Ucd.Contractor_Record) is
   begin
      Put (Item.Code);
      Put (Matreshka.Internals.Unicode.Ucd.Sequence_Count'Image (Item.Contractor_First));
      Put (Matreshka.Internals.Unicode.Ucd.Sequence_Count'Image (Item.Contractor_Last));
      Put (Matreshka.Internals.Unicode.Ucd.Sequence_Count'Image (Item.Expansion_First));
      Put (Matreshka.Internals.Unicode.Ucd.Sequence_Count'Image (Item.Expansion_Last));
      New_Line;
   end Put_Line;

end Collations.Debug;
