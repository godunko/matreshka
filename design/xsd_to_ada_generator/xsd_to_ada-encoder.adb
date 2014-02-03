------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                              Tools Component                             --
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
with Ada.Characters.Wide_Wide_Latin_1;

with League.Characters;

package body XSD_To_Ada.Encoder is

   use XSD_To_Ada.Writers;
   use type League.Strings.Universal_String;

   LF : constant Wide_Wide_Character := Ada.Characters.Wide_Wide_Latin_1.LF;

   -------------------
   -- Add_Separator --
   -------------------

   function Add_Separator
     (Text : Wide_Wide_String) return Wide_Wide_String
   is
      subtype Upper_Char_List  is Wide_Wide_Character range 'A' .. 'Z';
      subtype Lower_Char_List is Wide_Wide_Character range 'a' .. 'z';

      US_Text    : League.Strings.Universal_String;
      Uper_Count : Natural := 0;
   begin

      if Text = "" then
         return "Add_Separator ERROR";
         --         raise Constraint_Error with "Add_Separator ERROR";
      end if;

      US_Text.Append (Text (Text'First));

      for J in 2 .. Text'Length - 1 loop

         if Text (J) in Upper_Char_List
           and then Text (J - 1) in Upper_Char_List
         then
            Uper_Count := Uper_Count + 1;
         end if;

         if Text (J) in Lower_Char_List
           and then Text (J - 1) in Lower_Char_List
         then
            Uper_Count := 0;
         end if;

         if Text (J) in Lower_Char_List
           and then Text (J + 1) in Upper_Char_List
         then
            US_Text.Append (Text (J));
            US_Text.Append ("_");
            Uper_Count := 0;

         elsif Uper_Count > 1
           and then J + 2 <= Text'Last
           and then Text (J) in Upper_Char_List
           and then Text (J + 2) in Lower_Char_List
         then
            US_Text.Append (Text (J));

            US_Text.Append ("_");
            Uper_Count := 0;
         else
            US_Text.Append (Text (J));
         end if;
      end loop;

      US_Text.Append (Text (Text'Last));

      return US_Text.To_Wide_Wide_String;

   end Add_Separator;

   function Add_Separator
     (Text : League.Strings.Universal_String) return Wide_Wide_String is
   begin
      return Add_Separator (Text.To_Wide_Wide_String);
   end Add_Separator;

   -------------------
   -- Gen_Type_Line --
   -------------------

   function Gen_Type_Line
     (Str : Wide_Wide_String := "";
      Tab : Natural := 0)
      return Wide_Wide_String
   is

      US      : League.Strings.Universal_String
        := League.Strings.To_Universal_String (Str);
      US_New : League.Strings.Universal_String;

      Tab_Count : Natural := Tab;

      procedure Trim
        (US        : in out League.Strings.Universal_String;
         US_New    : in out League.Strings.Universal_String;
         Tab_Count : in out Natural);

      procedure Trim
        (US        : in out League.Strings.Universal_String;
         US_New    : in out League.Strings.Universal_String;
         Tab_Count : in out Natural)
      is
         use type League.Characters.Universal_Character;

         Temp_US : constant League.Strings.Universal_String
           := US.Slice (1, 79 - Tab_Count);
      begin

         for J in reverse 1 .. Temp_US.Length loop
            if (Temp_US.Element (J) = ':'
                and then J /= 1)
              or (Temp_US.Element (J) = '('
                  and then J /= 1)
              or (J + 3 < Temp_US.Length
                  and then Temp_US.Element (J) = ' '
                  and then Temp_US.Element (J + 1) = 'i'
                  and then Temp_US.Element (J + 2) = 's'
                  and then Temp_US.Element (J + 3) = ' ')
              or (J + 2 < Temp_US.Length
                  and then Temp_US.Element (J) = ' '
                  and then Temp_US.Element (J + 1) = '/'
                  and then Temp_US.Element (J + 2) = '=')
              or (J /= 1
                  and then J + 1 < Temp_US.Length
                  and then Temp_US.Element (J) = '.'
                  and then Temp_US.Element (J + 1) /= '.')
            then
               Tab_Count := Tab_Count + 2;
               US_New.Append (Temp_US.Slice (1, J - 1));
               US_New.Append (LF);

               for Count in 1 .. Tab_Count loop
                  US_New.Append (" ");
               end loop;

               US := US.Slice (J, US.Length);
               exit;
            end if;
         end loop;
      end Trim;

   begin
      for Count in 1 .. Tab_Count loop
         US_New.Append (" ");
      end loop;

      if US.Length + Tab_Count < 80 then
         US_New.Append (US);
         return US_New.To_Wide_Wide_String;
      end if;

      loop
         if US.Length + Tab > 80 then
            Trim (US, US_New, Tab_Count);
         else
            US_New.Append (US);
            return US_New.To_Wide_Wide_String;
         end if;
      end loop;
   end Gen_Type_Line;

end XSD_To_Ada.Encoder;
