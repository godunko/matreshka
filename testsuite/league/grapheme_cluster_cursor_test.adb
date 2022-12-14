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
-- Copyright © 2010-2012, Vadim Godunko <vgodunko@gmail.com>                --
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
with Ada.Command_Line;
with Ada.Unchecked_Deallocation;
with Ada.Wide_Wide_Text_IO;

with League.Application;
with League.Characters;
with League.Strings.Cursors.Grapheme_Clusters;

procedure Grapheme_Cluster_Cursor_Test is

   use League.Strings;
   use League.Strings.Cursors.Grapheme_Clusters;

   Break_Character    : constant Wide_Wide_Character := '÷';
   No_Break_Character : constant Wide_Wide_Character := '×';

   type Wide_Wide_String_Access is access all Wide_Wide_String;

   type Test_Data is array (Positive range <>) of Wide_Wide_String_Access;

   type Test_Data_Access is access all Test_Data;

   procedure Free is
     new Ada.Unchecked_Deallocation
          (Wide_Wide_String, Wide_Wide_String_Access);

   procedure Free is
     new Ada.Unchecked_Deallocation (Test_Data, Test_Data_Access);

   procedure Read_Test_Data
    (File_Name : String;
     Process   : not null access procedure
      (Item : in out Universal_String;
       Data : Test_Data));

   procedure Deep_Free (X : in out Test_Data_Access);

   procedure Do_Test (Item : in out Universal_String; Data : Test_Data);

   ---------------
   -- Deep_Free --
   ---------------

   procedure Deep_Free (X : in out Test_Data_Access) is
   begin
      for J in X'Range loop
         Free (X (J));
      end loop;

      Free (X);
   end Deep_Free;

   -------------
   -- Do_Test --
   -------------

   procedure Do_Test (Item : in out Universal_String; Data : Test_Data) is
      J : Grapheme_Cluster_Cursor;
      N : Natural := 1;

   begin
      --  Test forward-backward iterator

      J.First (Item);

      while J.Has_Element loop
         if J.Element.To_Wide_Wide_String /= Data (N).all then
            raise Program_Error;
         end if;

         J.Next;
         N := N + 1;
      end loop;

      J.Previous;
      N := N - 1;

      while J.Has_Element loop
         if J.Element.To_Wide_Wide_String /= Data (N).all then
            raise Program_Error;
         end if;

         J.Previous;
         N := N - 1;
      end loop;

      --  Test backward-forward iterator

      J.Last (Item);
      N := Data'Last;

      while J.Has_Element loop
         if J.Element.To_Wide_Wide_String /= Data (N).all then
            raise Program_Error;
         end if;

         J.Previous;
         N := N - 1;
      end loop;

      J.Next;
      N := N + 1;

      while J.Has_Element loop
         if J.Element.To_Wide_Wide_String /= Data (N).all then
            raise Program_Error;
         end if;

         J.Next;
         N := N + 1;
      end loop;
   end Do_Test;

   --------------------
   -- Read_Test_Data --
   --------------------

   procedure Read_Test_Data
    (File_Name : String;
     Process   : not null access procedure
      (Item : in out Universal_String;
       Data : Test_Data))
   is
      File : Ada.Wide_Wide_Text_IO.File_Type;
      Line : Wide_Wide_String (1 .. 1_024);
      Last : Natural;

   begin
      Ada.Wide_Wide_Text_IO.Open
       (File, Ada.Wide_Wide_Text_IO.In_File, File_Name, "wcem=8");

      while not Ada.Wide_Wide_Text_IO.End_Of_File (File) loop
         Ada.Wide_Wide_Text_IO.Get_Line (File, Line, Last);

         --  Remove comment

         for J in 1 .. Last loop
            if Line (J) = '#' then
               Last := J - 1;
               exit;
            end if;
         end loop;

         --  Remove trailing spaces

         for J in reverse 1 .. Last loop
            if Line (J) /= ' ' then
               Last := J - 1;
               exit;
            end if;
         end loop;

         if Last /= 0 then
            declare
               Token_First : Positive := 1;
               Item        : Wide_Wide_String_Access;
               Data        : Test_Data_Access;
               Source      : Wide_Wide_String_Access;
               X           : Universal_String;

               procedure Skip_Spaces;

               procedure Parse_Break_Indicator;

               procedure Parse_Code_Point;

               ---------------------------
               -- Parse_Break_Indicator --
               ---------------------------

               procedure Parse_Break_Indicator is
                  Aux : Test_Data_Access := Data;

               begin
                  Skip_Spaces;

                  case Line (Token_First) is
                     when Break_Character =>
                        if Item /= null then
                           if Data = null then
                              Data := new Test_Data (1 .. 1);

                           else
                              Data := new Test_Data (1 .. Aux'Last + 1);
                              Data (Aux'Range) := Aux.all;
                              Free (Aux);
                           end if;

                           Data (Data'Last) := Item;
                           Item := null;
                        end if;

                     when No_Break_Character =>
                        null;

                     when others =>
                        raise Constraint_Error with "Wrong format of the file";
                  end case;

                  Token_First := Token_First + 1;
               end Parse_Break_Indicator;

               ----------------------
               -- Parse_Code_Point --
               ----------------------

               procedure Parse_Code_Point is
                  Token_Last : Positive;
                  Aux        : Wide_Wide_String_Access := Item;

               begin
                  Skip_Spaces;
                  Token_Last := Token_First;

                  while Token_Last <= Last loop
                     case Line (Token_Last) is
                        when '0' .. '9' | 'A' .. 'F' =>
                           null;

                        when ' ' =>
                           Token_Last := Token_Last - 1;

                           exit;

                        when others =>
                           raise Constraint_Error
                             with "Wrong format of the file";
                     end case;

                     Token_Last := Token_Last + 1;
                  end loop;

                  if Item = null then
                     Item := new Wide_Wide_String (1 .. 1);

                  else
                     Item := new Wide_Wide_String (1 .. Aux'Last + 1);
                     Item (Aux'Range) := Aux.all;
                     Free (Aux);
                  end if;

                  Item (Item'Last) :=
                    Wide_Wide_Character'Val
                     (Integer'Wide_Wide_Value
                       ("16#" & Line (Token_First .. Token_Last) & '#'));

                  if Source = null then
                     Source := new Wide_Wide_String (1 .. 1);

                  else
                     Aux    := Source;
                     Source := new Wide_Wide_String (1 .. Aux'Last + 1);
                     Source (Aux'Range) := Aux.all;
                     Free (Aux);
                  end if;

                  Source (Source'Last) :=
                    Wide_Wide_Character'Val
                     (Integer'Wide_Wide_Value
                       ("16#" & Line (Token_First .. Token_Last) & '#'));

                  Token_First := Token_Last + 1;
               end Parse_Code_Point;

               -----------------
               -- Skip_Spaces --
               -----------------

               procedure Skip_Spaces is
               begin
                  for J in Token_First .. Last loop
                     if Line (J) /= ' ' then
                        Token_First := J;
                        exit;
                     end if;
                  end loop;
               end Skip_Spaces;

               OK : Boolean := True;

            begin
               Parse_Break_Indicator;

               while Token_First <= Last loop
                  Parse_Code_Point;
                  Parse_Break_Indicator;
               end loop;

               --  Check whether all source characters are valid Unicode
               --  characters. Unicode 6.1.0 introduce use of surrogate code
               --  points in test data, these tests can't be used to check
               --  Matreshka, because such data is invalid.

               for J in Source'Range loop
                  if not League.Characters.To_Universal_Character
                          (Source (J)).Is_Valid
                  then
                     OK := False;

                     exit;
                  end if;
               end loop;

               if OK then
                  X := To_Universal_String (Source.all);
                  Process (X, Data.all);
               end if;

               Deep_Free (Data);
               Free (Source);
            end;
         end if;
      end loop;

      Ada.Wide_Wide_Text_IO.Close (File);
   end Read_Test_Data;

begin
   Read_Test_Data
    (Ada.Command_Line.Argument (1) & '/' & "auxiliary/GraphemeBreakTest.txt",
     Do_Test'Access);
end Grapheme_Cluster_Cursor_Test;
