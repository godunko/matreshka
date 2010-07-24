------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
--                                                                          --
--                            Testsuite Component                           --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2010, Vadim Godunko <vgodunko@gmail.com>                     --
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
--  This subprogram incorporates test for known problems of Universal_String
--  manipulation subprograms.
with League.Strings;

procedure String_Operations is
   use League.Strings;

begin
   --  Initial implementation of concatenation of character with empty string
   --  raises exception and incorrectly compute size of the internal data
   --  representation.

   declare
      S : Universal_String;
      E : Universal_String := To_Universal_String ("A");

   begin
      S := 'A' & S;

      if S /= E then
         raise Program_Error;
      end if;
   end;

   --  Initial implementation of concatenation of character with empty string
   --  raises exception and incorrectly compute size of the internal data
   --  representation.

   declare
      S : Universal_String;
      E : Universal_String := To_Universal_String ("A");

   begin
      S := S & 'A';

      if S /= E then
         raise Program_Error;
      end if;
   end;

   --  Initial implementation of slice replace operation uses incorrect length
   --  to allocate new shared string.

   declare
      S : Universal_String := To_Universal_String ("A0Z");
      R : Universal_String
        := To_Universal_String ("abcdefghigklmnopqrstuvwxyz");
      E : Universal_String
        := To_Universal_String ("Aabcdefghigklmnopqrstuvwxyz");

   begin
      S.Replace (2, 2, R);

      if S /= E then
         raise Program_Error;
      end if;
   end;
end String_Operations;
