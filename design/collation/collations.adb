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
with Ada.Unchecked_Deallocation;

package body Collations is

   procedure Free is
     new Ada.Unchecked_Deallocation
          (AllKeys_Reader.Collation_Record,
           AllKeys_Reader.Collation_Record_Access);

   ---------------------------
   -- Suppress_Contractions --
   ---------------------------

   procedure Suppress_Contractions
    (Data : in out AllKeys_Reader.Collation_Information;
     Code : Matreshka.Internals.Unicode.Code_Point)
   is
      use type AllKeys_Reader.Collation_Record_Access;

      Current : AllKeys_Reader.Collation_Record_Access;
      Next    : AllKeys_Reader.Collation_Record_Access;

   begin
      Current := Data.Collations (Code);

      while Current /= null loop
         Next := Current.Next;

         if Current.Contractors'Length = 1 then
            --  Only one collation record can be provides for single code
            --  point by construction. Left this collation record.

            Data.Collations (Code) := Current;

         else
            --  Remove all other collation records.

            if Data.Lower_Record = Current then
               Data.Lower_Record := Current.Greater_Or_Equal;
            end if;

            if Data.Greater_Record = Current then
               Data.Greater_Record := Current.Less_Or_Equal;
            end if;

            if Current.Less_Or_Equal /= null then
               Current.Less_Or_Equal.Greater_Or_Equal :=
                 Current.Greater_Or_Equal;
            end if;

            if Current.Greater_Or_Equal /= null then
               Current.Greater_Or_Equal.Less_Or_Equal := Current.Less_Or_Equal;
            end if;

            Free (Current);
         end if;

         Current := Next;
      end loop;
   end Suppress_Contractions;

end Collations;
