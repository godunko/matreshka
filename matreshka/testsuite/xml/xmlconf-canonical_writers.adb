------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
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
private with Ada.Containers.Ordered_Maps;

package body XMLConf.Canonical_Writers is

   use type League.Strings.Universal_String;

   package Universal_String_Integer_Maps is
     new Ada.Containers.Ordered_Maps
          (League.Strings.Universal_String, Positive);

   function Escape_Character_Data
    (Item : League.Strings.Universal_String)
       return League.Strings.Universal_String;
   --  Escape character data according to canonical form representation.
   --  '&', '<', '>' and '"' characters are replaced by general entity
   --  reference; TAB, CR and LF characters are replaced by character
   --  reference in hexadecimal format.

   ----------------
   -- Characters --
   ----------------

   overriding procedure Characters
    (Self    : in out Canonical_Writer;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      Self.Result.Append (Escape_Character_Data (Text));
   end Characters;

   -----------------
   -- End_Element --
   -----------------

   overriding procedure End_Element
    (Self           : in out Canonical_Writer;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean) is
   begin
      Self.Result.Append ("</" & Qualified_Name & ">");
   end End_Element;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : Canonical_Writer) return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   ---------------------------
   -- Escape_Character_Data --
   ---------------------------

   function Escape_Character_Data
    (Item : League.Strings.Universal_String)
       return League.Strings.Universal_String
   is
      Result : League.Strings.Universal_String := Item;
      C      : Wide_Wide_Character;

   begin
      for J in reverse 1 .. Item.Length loop
         C := Result.Element (J);

         if C = '&' then
            Result.Replace (J, J, "&amp;");

         elsif C = '<' then
            Result.Replace (J, J, "&lt;");

         elsif C = '>' then
            Result.Replace (J, J, "&gt;");

         elsif C = '"' then
            Result.Replace (J, J, "&quot;");

         elsif C = Wide_Wide_Character'Val (9) then
            Result.Replace (J, J, "&#9;");

         elsif C = Wide_Wide_Character'Val (10) then
            Result.Replace (J, J, "&#10;");

         elsif C = Wide_Wide_Character'Val (13) then
            Result.Replace (J, J, "&#13;");
         end if;
      end loop;

      return Result;
   end Escape_Character_Data;

   --------------------------
   -- Ignorable_Whitespace --
   --------------------------

   overriding procedure Ignorable_Whitespace
    (Self    : in out Canonical_Writer;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      Self.Result.Append (Escape_Character_Data (Text));
   end Ignorable_Whitespace;

   ----------------------------
   -- Processing_Instruction --
   ----------------------------

   overriding procedure Processing_Instruction
    (Self    : in out Canonical_Writer;
     Target  : League.Strings.Universal_String;
     Data    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      Self.Result.Append ("<?" & Target & " " & Data & "?>");
   end Processing_Instruction;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out Canonical_Writer;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean)
   is
      use Universal_String_Integer_Maps;

      Map      : Universal_String_Integer_Maps.Map;
      Position : Universal_String_Integer_Maps.Cursor;
      Index    : Positive;

   begin
      Self.Result.Append ("<" & Qualified_Name);

      for J in 1 .. Attributes.Length loop
         Map.Insert (Attributes.Qualified_Name (J), J);
      end loop;

      Position := Map.First;

      while Has_Element (Position) loop
         Index := Element (Position);
         Self.Result.Append
          (" "
             & Attributes.Qualified_Name (Index)
             & "="""
             & Escape_Character_Data (Attributes.Value (Index))
             & '"');
         Next (Position);
      end loop;

      Self.Result.Append ('>');
   end Start_Element;

   ----------
   -- Text --
   ----------

   function Text
    (Self : Canonical_Writer) return League.Strings.Universal_String is
   begin
      return Self.Result;
   end Text;

end XMLConf.Canonical_Writers;
