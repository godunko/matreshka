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
with Matreshka.CLDR.Collation_Rules_Parser;

package body Matreshka.CLDR.LDML_Parsers is

   use type League.Strings.Universal_String;

   Collation_Tag             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("collation");
   Collations_Tag            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("collations");
   Cr_Tag                    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cr");
   Generation_Tag            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("generation");
   Identity_Tag              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("identity");
   Language_Tag              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("language");
   LDML_Tag                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ldml");
   Settings_Tag              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("settings");
   Suppress_Contractions_Tag : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("suppress_contractions");
   Version_Tag               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("version");

   Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("type");

   Standard_Image : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("standard");

   ----------------
   -- Characters --
   ----------------

   overriding procedure Characters
    (Self    : in out LDML_Parser;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      Self.Text.Append (Text);
   end Characters;

   -----------------
   -- End_Element --
   -----------------

   overriding procedure End_Element
    (Self           : in out LDML_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean) is
   begin
      if Self.Ignore_Depth /= 0 then
         Self.Ignore_Depth := Self.Ignore_Depth - 1;

      elsif Qualified_Name = Cr_Tag then
         Collation_Rules_Parser.Parse_Collation_Rules
          (Self.Collations.all, Self.Text.To_Wide_Wide_String);
         Self.Collect_Text := False;

      elsif Qualified_Name = Suppress_Contractions_Tag then
         for J in 2 .. Self.Text.Length - 1 loop
            --  XXX This field must be parsed as Unicode Set.

            Matreshka.CLDR.Collation_Data.Suppress_Contractions
             (Self.Collations.all,
              Wide_Wide_Character'Pos (Self.Text (J).To_Wide_Wide_Character));
         end loop;

         Self.Collect_Text := False;
      end if;
   end End_Element;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : LDML_Parser) return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out LDML_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean) is
   begin
      if Self.Ignore_Depth /= 0 then
         Self.Ignore_Depth := Self.Ignore_Depth + 1;

      elsif Qualified_Name = Collations_Tag then
         null;

      elsif Qualified_Name = Collation_Tag then
         if Attributes.Value (Type_Attribute) /= Standard_Image then
            --  Ignore all collations except 'standard'.

            Self.Ignore_Depth := 1;
         end if;

      elsif Qualified_Name = Cr_Tag then
         Self.Collect_Text := True;
         Self.Text.Clear;

      elsif Qualified_Name = Generation_Tag then
         null;

      elsif Qualified_Name = Identity_Tag then
         null;

      elsif Qualified_Name = Language_Tag then
         null;

      elsif Qualified_Name = LDML_Tag then
         null;

      elsif Qualified_Name = Settings_Tag then
         null;

      elsif Qualified_Name = Suppress_Contractions_Tag then
         Self.Collect_Text := True;
         Self.Text.Clear;

      elsif Qualified_Name = Version_Tag then
         null;

      else
         raise Program_Error;
      end if;
   end Start_Element;

end Matreshka.CLDR.LDML_Parsers;
