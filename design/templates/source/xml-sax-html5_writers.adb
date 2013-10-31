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
--  $Revision$ $Date$
------------------------------------------------------------------------------
with League.Characters.Latin;

package body XML.SAX.HTML5_Writers is

   use type League.Characters.Universal_Character;
   use type League.Strings.Universal_String;

   HTML_URI   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://www.w3.org/1999/xhtml");
   MathML_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://www.w3.org/1998/Math/MathML");
   SVG_URI    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://www.w3.org/2000/svg");
   XLink_URI  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://www.w3.org/1999/xlink");
   XML_URI    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://www.w3.org/XML/1998/namespace");
   XMLNS_URI  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://www.w3.org/2000/xmlns/");

   Area_Tag     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("area");
   Base_Tag     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("base");
   Body_Tag     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("body");
   Br_Tag       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("br");
   Col_Tag      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("col");
   Embed_Tag    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("embed");
   Head_Tag     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("head");
   Hr_Tag       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hr");
   HTML_Tag     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("html");
   Img_Tag      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("img");
   Input_Tag    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("input");
   Keygen_Tag   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("keygen");
   Link_Tag     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("link");
   Meta_Tag     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("meta");
   Param_Tag    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("param");
   Script_Tag   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("script");
   Source_Tag   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("source");
   Style_Tag    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("style");
   Textarea_Tag : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("textarea");
   Title_Tag    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("title");
   Track_Tag    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("track");
   Wbr_Tag      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("wbr");

   Actuate_Attribute        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("actuate");
   Arcrole_Attribute        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("arcrole");
   Async_Attribute          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("async");
   Autofocus_Attribute      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("autofocus");
   Autoplay_Attribute       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("autoplay");
   Base_Attribute           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("base");
   Checked_Attribute        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("checked");
   Controls_Attribute       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("controls");
   Default_Attribute        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("default");
   Defer_Attribute          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("defer");
   Disabled_Attribute       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("disabled");
   Formnovalidate_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("formnovalidate");
   Hidden_Attribute         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hidden");
   Href_Attribute           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("href");
   Ismap_Attribute          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ismap");
   Lang_Attribute           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("lang");
   Loop_Attribute           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("loop");
   Multiple_Attribute       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("multiple");
   Muted_Attribute          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("muted");
   Novalidate_Attribute     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("novalidate");
   Open_Attribute           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("open");
   Readonly_Attribute       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("readonly");
   Required_Attribute       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("required");
   Reversed_Attribute       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("reversed");
   Role_Attribute           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("role");
   Scoped_Attribute         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("scoped");
   Seamless_Attribute       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("seamless");
   Selected_Attribute       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("selected");
   Show_Attribute           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("show");
   Space_Attribute          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("space");
   Title_Attribute          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("title");
   Type_Attribute           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("type");
   Typemustmatch_Attribute  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("typemustmatch");
   XLink_Attribute          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xlink");
   XLink_Actuate_Attribute  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xlink:actuate");
   XLink_Arcrole_Attribute  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xlink:arcrole");
   XLink_Href_Attribute     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xlink:href");
   XLink_Role_Attribute     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xlink:role");
   XLink_Show_Attribute     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xlink:show");
   XLink_Title_Attribute    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xlink:title");
   XLink_Type_Attribute     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xlink:type");
   XML_Base_Attribute       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xml:base");
   XML_Lang_Attribute       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xml:lang");
   XML_Space_Attribute      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xml:space");
   XMLNS_Attribute          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xmlns");
   XMLNS_XLink_Attribute    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xmlns:xlink");

   type Attribute_Value_Syntax is
     (Empty, Unquoted, Single_Quoted, Double_Quoted);

   function Is_Space (Item : League.Strings.Universal_String) return Boolean;
   --  Returns True when specified string contains only space characters as
   --  defined by HTML5 specification.
   --
   --  [HTML5] "The space characters, for the purposes of this specification,
   --  are U+0020 SPACE, "tab" (U+0009), "LF" (U+000A), "FF" (U+000C), and "CR"
   --  (U+000D)."

   procedure Write_DOCTYPE (Self : in out HTML5_Writer'Class);
   --  Outputs DOCTYPE declaration.

   procedure Write_Attributes
    (Self       : in out HTML5_Writer'Class;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean);
   --  Output attributes.

   function Is_Boolean_Attribute
    (Name : League.Strings.Universal_String) return Boolean;
   --  Returns True when attribute is boolean attribute in HTML5.

   function Is_Void_Element
    (Tag : League.Strings.Universal_String) return Boolean;
   --  Returns True when specified tag refernce to void element of HTML5.

   function Is_Raw_Text_Element
    (Tag : League.Strings.Universal_String) return Boolean;
   --  Returns True when specified tag refernce to raw text element of HTML5.

   function Is_Escapable_Raw_Text_Element
    (Tag : League.Strings.Universal_String) return Boolean;
   --  Returns True when specified tag refernce to escapable raw text element
   --  of HTML5.

   procedure Escape_Attribute_Value
    (Value  : League.Strings.Universal_String;
     Text   : out League.Strings.Universal_String;
     Syntax : out Attribute_Value_Syntax);
   --  Detects optimal attribute value syntax and escape attribute value.

   ----------------
   -- Characters --
   ----------------

   overriding procedure Characters
    (Self    : in out HTML5_Writer;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean)
   is
      Escaped_Text : League.Strings.Universal_String;
      C            : League.Characters.Universal_Character;

   begin
      if Self.No_Content then
         Self.Output.Put ('>');
         Self.No_Content := False;
      end if;

      if not Self.Document_Start or else not Is_Space (Text) then
         case Self.State.Element_Kind is
            when Void =>
               --  [HTML5] "Void elements can't have any contents (since
               --  there's no end tag, no content can be put between the start
               --  tag and the end tag)."

               Self.Diagnosis :=
                 League.Strings.To_Universal_String
                  ("void element can't have any contents");
               Success        := False;

               return;

            when Raw_Text =>
               --  XXX Verification of the text content can be done here.
               --
               --  [HTML5] "The text in raw text and escapable raw text
               --  elements must not contain any occurrences of the string "</"
               --  (U+003C LESS-THAN SIGN, U+002F SOLIDUS) followed by
               --  characters that case-insensitively match the tag name of the
               --  element followed by one of "tab" (U+0009), "LF" (U+000A),
               --  "FF" (U+000C), "CR" (U+000D), U+0020 SPACE, ">" (U+003E), or
               --  "/" (U+002F)."

               Self.Output.Put (Text);

            when Escapable_Raw_Text =>
               for J in 1 .. Text.Length loop
                  C := Text (J);

                  if C = League.Characters.Latin.Less_Than_Sign
                    and then J < Text.Length
                    and then Text (J + 1) = League.Characters.Latin.Solidus
                  then
                     --  XXX This check can be even more improved:
                     --
                     --  [HTML5] "The text in raw text and escapable raw text
                     --  elements must not contain any occurrences of the
                     --  string "</" (U+003C LESS-THAN SIGN, U+002F SOLIDUS)
                     --  followed by characters that case-insensitively match
                     --  the tag name of the element followed by one of "tab"
                     --  (U+0009), "LF" (U+000A), "FF" (U+000C), "CR" (U+000D),
                     --  U+0020 SPACE, ">" (U+003E), or "/" (U+002F)."

                     Escaped_Text.Append ("&lt;");

                  elsif C = League.Characters.Latin.Ampersand then
                     Escaped_Text.Append ("&amp;");

                  else
                     Escaped_Text.Append (C);
                  end if;
               end loop;

               Self.Output.Put (Escaped_Text);

            when Normal | Foreign =>
               if Self.State.Element_Kind = Foreign and Self.CDATA_Mode then
                  Self.Output.Put (Text);

               else
                  for J in 1 .. Text.Length loop
                     C := Text (J);

                     if C = League.Characters.Latin.Less_Than_Sign then
                        Escaped_Text.Append ("&lt;");

                     elsif C = League.Characters.Latin.Ampersand then
                        Escaped_Text.Append ("&amp;");

                     else
                        Escaped_Text.Append (C);
                     end if;
                  end loop;

                  Self.Output.Put (Escaped_Text);
               end if;
         end case;
      end if;
   end Characters;

   -------------
   -- Comment --
   -------------

   overriding procedure Comment
    (Self    : in out HTML5_Writer;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      --  XXX Content of Text must be checked here to be conformant to HTML5
      --  definition of comment.
      --
      --  [HTML5] "Comments must start with the four character sequence U+003C
      --  LESS-THAN SIGN, U+0021 EXCLAMATION MARK, U+002D HYPHEN-MINUS, U+002D
      --  HYPHEN-MINUS (<!--). Following this sequence, the comment may have
      --  text, with the additional restriction that the text must not start
      --  with a single ">" (U+003E) character, nor start with a "-" (U+002D)
      --  character followed by a ">" (U+003E) character, nor contain two
      --  consecutive U+002D HYPHEN-MINUS characters (--), nor end with a "-"
      --  (U+002D) character. Finally, the comment must be ended by the three
      --  character sequence U+002D HYPHEN-MINUS, U+002D HYPHEN-MINUS, U+003E
      --  GREATER-THAN SIGN (-->)."

      if Self.No_Content then
         Self.Output.Put ('>');
         Self.No_Content := False;
      end if;

      Self.Output.Put ("<!--");
      Self.Output.Put (Text);
      Self.Output.Put ("-->");

      if Self.Document_Start then
         --  [HTML5] "It is suggested that newlines be inserted after the
         --  DOCTYPE, after any comments that are before the root element,
         --  after the html element's start tag (if it is not omitted), and
         --  after any comments that are inside the html element but before the
         --  head element."

         Self.Output.Put (League.Characters.Latin.Line_Feed);
      end if;
   end Comment;

   ---------------
   -- End_CDATA --
   ---------------

   overriding procedure End_CDATA
    (Self    : in out HTML5_Writer;
     Success : in out Boolean) is
   begin
      Self.CDATA_Mode := False;

      if Self.State.Element_Kind = Foreign then
         --  [HTML5] "CDATA sections can only be used in foreign content
         --  (MathML or SVG)."

         Self.Output.Put ("]]>");
      end if;
   end End_CDATA;

   -----------------
   -- End_Element --
   -----------------

   overriding procedure End_Element
    (Self           : in out HTML5_Writer;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean) is
   begin
      case Self.State.Element_Kind is
         when Normal | Raw_Text | Escapable_Raw_Text =>
            Self.Output.Put ("</");
            Self.Output.Put (Local_Name);
            Self.Output.Put ('>');

         when Void =>
            --  Don't generate close tag for void elements.
            --
            --  [HTML5] "Then, if the element is one of the void elements, or
            --  if the element is a foreign element, then there may be a single
            --  U+002F SOLIDUS character (/). This character has no effect on
            --  void elements, but on foreign elements it marks the start tag
            --  as self-closing."

            null;

         when Foreign =>
            if Self.No_Content then
               Self.Output.Put ("/>");

            else
               Self.Output.Put ("</");
               Self.Output.Put (Local_Name);
               Self.Output.Put ('>');
            end if;
      end case;

      Self.No_Content := False;
      Self.State := Self.Stack.Last_Element;
      Self.Stack.Delete_Last;
   end End_Element;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : HTML5_Writer) return League.Strings.Universal_String is
   begin
      return Self.Diagnosis;
   end Error_String;

   ----------------------------
   -- Escape_Attribute_Value --
   ----------------------------

   procedure Escape_Attribute_Value
    (Value  : League.Strings.Universal_String;
     Text   : out League.Strings.Universal_String;
     Syntax : out Attribute_Value_Syntax)
   is
      C               : League.Characters.Universal_Character;
      Unquoted_Syntax : Boolean := True;
      Apostrophes     : Natural := 0;
      Quotation_Marks : Natural := 0;
      Aux             : League.Strings.Universal_String;
      First           : Positive := 1;
      Index           : Natural;

   begin
      Text.Clear;

      if Value.Is_Empty then
         Syntax := Empty;

      else
         for J in 1 .. Value.Length loop
            C := Value (J);

            if C = League.Characters.Latin.Space
              or C = League.Characters.Latin.Character_Tabulation
              or C = League.Characters.Latin.Line_Feed
              or C = League.Characters.Latin.Form_Feed
              or C = League.Characters.Latin.Carriage_Return
              or C = League.Characters.Latin.Equals_Sign
              or C = League.Characters.Latin.Less_Than_Sign
              or C = League.Characters.Latin.Greater_Than_Sign
              or C = League.Characters.Latin.Grave_Accent
            then
               --  Space characters, '=', '<', '>', '`' are prohibited in
               --  unquoted attribute value syntax.

               Unquoted_Syntax := False;

            elsif C = League.Characters.Latin.Apostrophe then
               --  ''' is prohibited in unquoted attribute value syntax.

               Unquoted_Syntax := False;
               Apostrophes := Apostrophes + 1;

            elsif C = League.Characters.Latin.Quotation_Mark then
               --  '"' is prohibited in unquoted attribute value syntax.

               Unquoted_Syntax := False;
               Quotation_Marks := Quotation_Marks + 1;
            end if;

            if C = League.Characters.Latin.Ampersand then
               --  Replace '&' by character reference in result string.

               Text.Append ("&amp;");

            else
               --  Copy other characters to result string.

               Text.Append (C);
            end if;
         end loop;

         if Unquoted_Syntax then
            --  Use unquoted attribute value syntax then actual attribute value
            --  doesn't violate its restrictions.

            Syntax := Unquoted;

         elsif Apostrophes <= Quotation_Marks then
            --  Number of apostrophes is less than number of quotation marks,
            --  use single-quoted attribute value syntax.

            Syntax := Single_Quoted;

            --  Escape ''' characters

            Aux := Text;
            Text.Clear;

            while First <= Aux.Length loop
               Index := Aux.Index (First, ''');

               if Index = 0 then
                  Text.Append (Aux.Slice (First, Aux.Length));
                  First := Aux.Length + 1;

               else
                  Text.Append (Aux.Slice (First, Index - 1));
                  Text.Append ("&apos;");
                  First := Index + 1;
               end if;
            end loop;

         else
            --  Number of apostrophes is greater than number of quotation
            --  marks, use single-quoted attribute value syntax.

            Syntax := Double_Quoted;

            --  Escape '"' characters

            Aux := Text;
            Text.Clear;

            while First <= Aux.Length loop
               Index := Aux.Index (First, '"');

               if Index = 0 then
                  Text.Append (Aux.Slice (First, Aux.Length));
                  First := Aux.Length + 1;

               else
                  Text.Append (Aux.Slice (First, Index - 1));
                  Text.Append ("&quot;");
                  First := Index + 1;
               end if;
            end loop;
         end if;
      end if;
   end Escape_Attribute_Value;

   --------------------------
   -- Is_Boolean_Attribute --
   --------------------------

   function Is_Boolean_Attribute
    (Name : League.Strings.Universal_String) return Boolean is
   begin
      return
        Name = Async_Attribute
          or Name = Autofocus_Attribute
          or Name = Autoplay_Attribute
          or Name = Checked_Attribute
          or Name = Controls_Attribute
          or Name = Default_Attribute
          or Name = Defer_Attribute
          or Name = Disabled_Attribute
          or Name = Formnovalidate_Attribute
          or Name = Hidden_Attribute
          or Name = Ismap_Attribute
          or Name = Loop_Attribute
          or Name = Multiple_Attribute
          or Name = Muted_Attribute
          or Name = Novalidate_Attribute
          or Name = Open_Attribute
          or Name = Readonly_Attribute
          or Name = Required_Attribute
          or Name = Reversed_Attribute
          or Name = Scoped_Attribute
          or Name = Seamless_Attribute
          or Name = Selected_Attribute
          or Name = Typemustmatch_Attribute;
   end Is_Boolean_Attribute;

   -----------------------------------
   -- Is_Escapable_Raw_Text_Element --
   -----------------------------------

   function Is_Escapable_Raw_Text_Element
    (Tag : League.Strings.Universal_String) return Boolean is
   begin
      return Tag = Textarea_Tag or Tag = Title_Tag;
   end Is_Escapable_Raw_Text_Element;

   -------------------------
   -- Is_Raw_Text_Element --
   -------------------------

   function Is_Raw_Text_Element
    (Tag : League.Strings.Universal_String) return Boolean is
   begin
      return Tag = Script_Tag or Tag = Style_Tag;
   end Is_Raw_Text_Element;

   --------------
   -- Is_Space --
   --------------

   function Is_Space (Item : League.Strings.Universal_String) return Boolean is
      C : League.Characters.Universal_Character;

   begin
      --  [HTML5] "The space characters, for the purposes of this
      --  specification, are U+0020 SPACE, "tab" (U+0009), "LF" (U+000A), "FF"
      --  (U+000C), and "CR" (U+000D)."

      for J in 1 .. Item.Length loop
         C := Item (J);

         if C /= League.Characters.Latin.Space
           and C /= League.Characters.Latin.Character_Tabulation
           and C /= League.Characters.Latin.Line_Feed
           and C /= League.Characters.Latin.Form_Feed
           and C /= League.Characters.Latin.Carriage_Return
         then
            return False;
         end if;
      end loop;

      return True;
   end Is_Space;

   ---------------------
   -- Is_Void_Element --
   ---------------------

   function Is_Void_Element
    (Tag : League.Strings.Universal_String) return Boolean is
   begin
      return
        Tag = Area_Tag
          or Tag = Base_Tag
          or Tag = Br_Tag
          or Tag = Col_Tag
          or Tag = Embed_Tag
          or Tag = Hr_Tag
          or Tag = Img_Tag
          or Tag = Input_Tag
          or Tag = Keygen_Tag
          or Tag = Link_Tag
          or Tag = Meta_Tag
          or Tag = Param_Tag
          or Tag = Source_Tag
          or Tag = Track_Tag
          or Tag = Wbr_Tag;
   end Is_Void_Element;

   ----------------
   -- Set_Output --
   ----------------

   overriding procedure Set_Output
    (Self   : in out HTML5_Writer;
     Output : not null XML.SAX.Writers.SAX_Output_Destination_Access) is
   begin
      Self.Output := Output;
   end Set_Output;

   -----------------
   -- Start_CDATA --
   -----------------

   overriding procedure Start_CDATA
    (Self    : in out HTML5_Writer;
     Success : in out Boolean) is
   begin
      if Self.No_Content then
         Self.Output.Put ('>');
         Self.No_Content := False;
      end if;

      Self.CDATA_Mode := True;

      if Self.State.Element_Kind = Foreign then
         --  [HTML5] "CDATA sections can only be used in foreign content
         --  (MathML or SVG)."

         Self.Output.Put ("<![CDATA[");
      end if;
   end Start_CDATA;

   --------------------
   -- Start_Document --
   --------------------

   overriding procedure Start_Document
    (Self    : in out HTML5_Writer;
     Success : in out Boolean) is
   begin
      Self.Diagnosis.Clear;
      Self.State := (Element_Kind => Normal);
      Self.Stack.Clear;
      Self.DOCTYPE_Written := False;
      Self.Document_Start  := True;
      Self.No_Content      := False;
      Self.CDATA_Mode      := False;
   end Start_Document;

   ---------------
   -- Start_DTD --
   ---------------

   overriding procedure Start_DTD
    (Self      : in out HTML5_Writer;
     Name      : League.Strings.Universal_String;
     Public_Id : League.Strings.Universal_String;
     System_Id : League.Strings.Universal_String;
     Success   : in out Boolean) is
   begin
      Self.Write_DOCTYPE;
   end Start_DTD;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out HTML5_Writer;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean) is
   begin
      Self.Stack.Append (Self.State);

      if not Self.DOCTYPE_Written then
         --  DOCTYPE is required by HTML5 but it is optional in XHTML5.

         Self.Write_DOCTYPE;
      end if;

      if Self.No_Content then
         Self.Output.Put ('>');
      end if;

      if Namespace_URI = HTML_URI then
         if Is_Void_Element (Local_Name) then
            Self.State.Element_Kind := Void;

         elsif Is_Raw_Text_Element (Local_Name) then
            Self.State.Element_Kind := Raw_Text;

         elsif Is_Escapable_Raw_Text_Element (Local_Name) then
            Self.State.Element_Kind := Escapable_Raw_Text;

         else
            Self.State.Element_Kind := Normal;
         end if;

         if Local_Name = Head_Tag then
            Self.Document_Start := False;

         elsif Local_Name = Body_Tag then
            --  For convinience recognize <body> tag as start of the document's
            --  content.

            Self.Document_Start := False;
         end if;

         Self.No_Content := False;
         Self.Output.Put ('<');
         Self.Output.Put (Local_Name);
         Self.Write_Attributes (Attributes, Success);

         if not Success then
            return;
         end if;

         Self.Output.Put ('>');

         if Local_Name = HTML_Tag then
            --  [HTML5] "It is suggested that newlines be inserted after the
            --  DOCTYPE, after any comments that are before the root element,
            --  after the html element's start tag (if it is not omitted), and
            --  after any comments that are inside the html element but before
            --  the head element."

            Self.Output.Put (League.Characters.Latin.Line_Feed);
         end if;

      elsif Namespace_URI = MathML_URI
        or Namespace_URI = SVG_URI
      then
         Self.State.Element_Kind := Foreign;
         Self.No_Content := True;

         Self.Output.Put ('<');
         Self.Output.Put (Local_Name);
         Self.Write_Attributes (Attributes, Success);

         if not Success then
            return;
         end if;

      else
         --  Other namespaces can't be used in HTML5.

         Success        := False;
         Self.Diagnosis :=
           League.Strings.To_Universal_String
            ("namespace is not supported by HTML5");
      end if;
   end Start_Element;

   ----------------------
   -- Write_Attributes --
   ----------------------

   procedure Write_Attributes
    (Self       : in out HTML5_Writer'Class;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean)
   is

      procedure Write_Attribute
       (Qualified_Name : League.Strings.Universal_String;
        Value          : League.Strings.Universal_String);

      ---------------------
      -- Write_Attribute --
      ---------------------

      procedure Write_Attribute
       (Qualified_Name : League.Strings.Universal_String;
        Value          : League.Strings.Universal_String)
      is
         Escaped_Value : League.Strings.Universal_String;
         Syntax        : Attribute_Value_Syntax;

      begin
         Escape_Attribute_Value (Value, Escaped_Value, Syntax);

         if Syntax = Empty
           or else (Self.State.Element_Kind /= Foreign
                      and then Is_Boolean_Attribute (Qualified_Name))
         then
            Self.Output.Put (' ');
            Self.Output.Put (Qualified_Name);

         elsif Syntax = Unquoted then
            Self.Output.Put (' ');
            Self.Output.Put (Qualified_Name);
            Self.Output.Put ('=');
            Self.Output.Put (Escaped_Value);

         elsif Syntax = Single_Quoted then
            Self.Output.Put (' ');
            Self.Output.Put (Qualified_Name);
            Self.Output.Put ('=');
            Self.Output.Put (''');
            Self.Output.Put (Escaped_Value);
            Self.Output.Put (''');

         else
            Self.Output.Put (' ');
            Self.Output.Put (Qualified_Name);
            Self.Output.Put ('=');
            Self.Output.Put ('"');
            Self.Output.Put (Escaped_Value);
            Self.Output.Put ('"');
         end if;
      end Write_Attribute;

      Namespace_URI  : League.Strings.Universal_String;
      Local_Name     : League.Strings.Universal_String;
      Qualified_Name : League.Strings.Universal_String;
      Value          : League.Strings.Universal_String;

   begin
      for J in 1 .. Attributes.Length loop
         Namespace_URI  := Attributes.Namespace_URI (J);
         Local_Name     := Attributes.Local_Name (J);
         Qualified_Name := Attributes.Qualified_Name (J);
         Value          := Attributes (J);

         if Namespace_URI.Is_Empty then
            Write_Attribute (Qualified_Name, Value);

         elsif Self.State.Element_Kind = Foreign
           and Namespace_URI = XLink_URI
           and Local_Name = Actuate_Attribute
         then
            Write_Attribute (XLink_Actuate_Attribute, Value);

         elsif Self.State.Element_Kind = Foreign
           and Namespace_URI = XLink_URI
           and Local_Name = Arcrole_Attribute
         then
            Write_Attribute (XLink_Arcrole_Attribute, Value);

         elsif Self.State.Element_Kind = Foreign
              and Namespace_URI = XLink_URI
              and Local_Name = Href_Attribute
         then
            Write_Attribute (XLink_Href_Attribute, Value);

         elsif Self.State.Element_Kind = Foreign
           and Namespace_URI = XLink_URI
           and Local_Name = Role_Attribute
         then
            Write_Attribute (XLink_Role_Attribute, Value);

         elsif Self.State.Element_Kind = Foreign
           and Namespace_URI = XLink_URI
           and Local_Name = Show_Attribute
         then
            Write_Attribute (XLink_Show_Attribute, Value);

         elsif Self.State.Element_Kind = Foreign
           and Namespace_URI = XLink_URI
           and Local_Name = Title_Attribute
         then
            Write_Attribute (XLink_Title_Attribute, Value);

         elsif Self.State.Element_Kind = Foreign
           and Namespace_URI = XLink_URI
           and Local_Name = Type_Attribute
         then
            Write_Attribute (XLink_Type_Attribute, Value);

         elsif Self.State.Element_Kind = Foreign
           and Namespace_URI = XML_URI
           and Local_Name = Base_Attribute
         then
            Write_Attribute (XML_Base_Attribute, Value);

         elsif Self.State.Element_Kind = Foreign
           and Namespace_URI = XML_URI
           and Local_Name = Lang_Attribute
         then
            Write_Attribute (XML_Lang_Attribute, Value);

         elsif Self.State.Element_Kind = Foreign
           and Namespace_URI = XML_URI
           and Local_Name = Space_Attribute
         then
            Write_Attribute (XML_Space_Attribute, Value);

         elsif Self.State.Element_Kind = Foreign
           and Namespace_URI = XMLNS_URI
           and Local_Name = XMLNS_Attribute
         then
            Write_Attribute (XMLNS_Attribute, Value);

         elsif Self.State.Element_Kind = Foreign
           and Namespace_URI = XMLNS_URI
           and Local_Name = XLink_Attribute
         then
            Write_Attribute (XMLNS_XLink_Attribute, Value);

         else
            --  Other namespaces can't be expressed in HTML5.

            Success        := False;
            Self.Diagnosis :=
              League.Strings.To_Universal_String
               ("namespaced attribute can't be expressed in HTML5");

            return;
         end if;
      end loop;
   end Write_Attributes;

   -------------------
   -- Write_DOCTYPE --
   -------------------

   procedure Write_DOCTYPE (Self : in out HTML5_Writer'Class) is
   begin
      Self.DOCTYPE_Written := True;
      Self.Output.Put ("<!DOCTYPE html>");

      --  [HTML5] "It is suggested that newlines be inserted after the DOCTYPE,
      --  after any comments that are before the root element, after the html
      --  element's start tag (if it is not omitted), and after any comments
      --  that are inside the html element but before the head element."

      Self.Output.Put (League.Characters.Latin.Line_Feed);
   end Write_DOCTYPE;

end XML.SAX.HTML5_Writers;
