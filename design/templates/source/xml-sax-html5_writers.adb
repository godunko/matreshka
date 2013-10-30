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

   use type League.Strings.Universal_String;

   XHTML_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://www.w3.org/1999/xhtml");
   MathML_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://www.w3.org/1998/Math/MathML");
   SVG_URI    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://www.w3.org/2000/svg");

   Area_Tag   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("area");
   Base_Tag   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("base");
   Body_Tag   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("body");
   Br_Tag     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("br");
   Col_Tag    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("col");
   Embed_Tag  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("embed");
   Head_Tag   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("head");
   Hr_Tag     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hr");
   HTML_Tag   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("html");
   Img_Tag    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("img");
   Input_Tag  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("input");
   Keygen_Tag : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("keygen");
   Link_Tag   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("link");
   Meta_Tag   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("meta");
   Param_Tag  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("param");
   Source_Tag : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("source");
   Track_Tag  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("track");
   Wbr_Tag    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("wbr");

   function Is_Space (Item : League.Strings.Universal_String) return Boolean;
   --  Returns True when specified string contains only space characters as
   --  defined by HTML5 specification.
   --
   --  [HTML5] "The space characters, for the purposes of this specification,
   --  are U+0020 SPACE, "tab" (U+0009), "LF" (U+000A), "FF" (U+000C), and "CR"
   --  (U+000D)."

   procedure Write_DOCTYPE (Self : in out HTML5_Writer'Class);
   --  Outputs DOCTYPE declaration.

   function Is_Void_Element
    (Tag : League.Strings.Universal_String) return Boolean;
   --  Returns True when specified tag refernce to void element of HTML5.

   ----------------
   -- Characters --
   ----------------

   overriding procedure Characters
    (Self    : in out HTML5_Writer;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      if Self.No_Content then
         Self.Output.Put ('>');
         Self.No_Content := False;
      end if;

      if not Self.Document_Start or else not Is_Space (Text) then
         Self.Output.Put (Text);
         --  XXX Text MUST BE escaped.
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
      Self.Output.Put ("]]>");
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
      if Namespace_URI = XHTML_URI then
         if Is_Void_Element (Local_Name) then
            --  Don't generate close tag for void elements.
            --
            --  [HTML5] "Then, if the element is one of the void elements, or
            --  if the element is a foreign element, then there may be a single
            --  U+002F SOLIDUS character (/). This character has no effect on
            --  void elements, but on foreign elements it marks the start tag
            --  as self-closing."

            null;

         else
            Self.Output.Put ("</");
            Self.Output.Put (Local_Name);
            Self.Output.Put ('>');
         end if;

      elsif Namespace_URI = MathML_URI
        or Namespace_URI = SVG_URI
      then
         if Self.No_Content then
            Self.Output.Put ("/>");

         else
            Self.Output.Put ("</");
            Self.Output.Put (Local_Name);
            Self.Output.Put ('>');
         end if;

      else
         raise Program_Error;
      end if;

      Self.No_Content := False;
   end End_Element;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : HTML5_Writer) return League.Strings.Universal_String is
   begin
      return Self.Diagnosis;
   end Error_String;

   --------------
   -- Is_Space --
   --------------

   function Is_Space (Item : League.Strings.Universal_String) return Boolean is
      use type League.Characters.Universal_Character;

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
      Self.Output.Put ("<![CDATA[");
   end Start_CDATA;

   --------------------
   -- Start_Document --
   --------------------

   overriding procedure Start_Document
    (Self    : in out HTML5_Writer;
     Success : in out Boolean) is
   begin
      Self.Diagnosis.Clear;
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
      if not Self.DOCTYPE_Written then
         --  DOCTYPE is required by HTML5 but it is optional in XHTML5.

         Self.Write_DOCTYPE;
      end if;

      if Self.No_Content then
         Self.Output.Put ('>');
      end if;

      if Namespace_URI = XHTML_URI then
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
         Self.No_Content := True;

         Self.Output.Put ('<');
         Self.Output.Put (Local_Name);

      else
         --  Other namespaces can't be used in HTML5.

         Success        := False;
         Self.Diagnosis :=
           League.Strings.To_Universal_String
            ("namespace is not supported by HTML5");

         return;
      end if;

   end Start_Element;

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
