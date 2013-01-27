------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Open Document Toolkit                           --
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
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

package body ODF.Internals.Parsers is

   use type League.Strings.Universal_String;

   GRDDL_URI  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://www.w3.org/2003/g/data-view#");
   Office_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:office:1.0");
   Style_URI  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:style:1.0");
   SVG_URI    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0");

   Accent_Height_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("accent-height");
   Alphabetic_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("alphabetic");
   Ascent_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ascent");
   Bbox_Name                    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("bbox");
   Cap_Height_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("cap-height");
   Descent_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("descent");
   Document_Style_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("document-styles");
   Font_Adornments_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-adornments");
   Font_Charset_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-charset");
   Font_Face_Decls_Name         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-face-decls");
   Font_Family_Generic_Name     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-family-generic");
   Font_Family_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-family");
   Font_Face_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-face");
   Font_Pitch_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-pitch");
   Font_Size_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-size");
   Font_Stretch_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-stretch");
   Font_Style_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-style");
   Font_Variant_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-variant");
   Font_Weight_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("font-weight");
   Hanging_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("hanging");
   Ideographic_Name             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ideographic");
   Mathematical_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("mathematical");
   Name_Name                    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("name");
   Overline_Position_Name       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("overline-position");
   Overline_Thickness_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("overline-thickness");
   Panose_1_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("panose-1");
   Slope_Name                   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("slope");
   Stemh_Name                   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stemh");
   Stemv_Name                   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("stemv");
   Strikethrough_Position_Name  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("strikethrough-position");
   Strikethrough_Thickness_Name : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("strikethrough-thickness");
   Styles_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("styles");
   Transformation_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("transformation");
   Underline_Position_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("underline-position");
   Underline_Thickness_Name     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("underline-thickness");
   Unicode_Range_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("unicode-range");
   Units_Per_Em_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("units-per-em");
   V_Alphabetic_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("v-alphabetic");
   V_Hanging_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("v-hanging");
   V_Ideographic_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("v-ideographic");
   V_Mathematical_Name          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("v-mathematical");
   Version_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("version");
   Widths_Name                  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("widths");
   X_Height_Name                : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("x-height");

   ODF_Version : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("1.2");

   procedure Push (Self : in out ODF_Parser'Class; Kind : State_Kinds);

   procedure Pop (Self : in out ODF_Parser'Class);

   package Office is

      procedure Start_Element
       (Self       : in out ODF_Parser'Class;
        Local_Name : League.Strings.Universal_String;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of element from 'office' namespace.

      procedure End_Element
       (Self       : in out ODF_Parser'Class;
        Local_Name : League.Strings.Universal_String;
        Success    : in out Boolean);
      --  Process end of element from 'office' namespace.

   end Office;

   package Style is

      procedure Start_Element
       (Self       : in out ODF_Parser'Class;
        Local_Name : League.Strings.Universal_String;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of element from 'style' namespace.

      procedure End_Element
       (Self       : in out ODF_Parser'Class;
        Local_Name : League.Strings.Universal_String;
        Success    : in out Boolean);
      --  Process end of element from 'style' namespace.

   end Style;

   -----------------
   -- End_Element --
   -----------------

   overriding procedure End_Element
    (Self           : in out ODF_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean) is
   begin
      if Namespace_URI = Office_URI then
         Put_Line ('{' & Namespace_URI.To_Wide_Wide_String & '}' & Local_Name.To_Wide_Wide_String);

         Office.End_Element (Self, Local_Name, Success);

      elsif Namespace_URI = Style_URI then
         Put_Line ('{' & Namespace_URI.To_Wide_Wide_String & '}' & Local_Name.To_Wide_Wide_String);

         Style.End_Element (Self, Local_Name, Success);

      else
         Put_Line ('{' & Namespace_URI.To_Wide_Wide_String & '}' & Local_Name.To_Wide_Wide_String);

         raise Program_Error;
      end if;
   end End_Element;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : ODF_Parser) return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   ------------
   -- Office --
   ------------

   package body Office is

      procedure Start_Document_Styles
       (Self       : in out ODF_Parser'Class;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of 'document-styles' element.

      procedure Start_Font_Face_Decls
       (Self    : in out ODF_Parser'Class;
        Success : in out Boolean);
      --  Process start of 'font-face-decls' element.

      procedure Start_Styles
       (Self    : in out ODF_Parser'Class;
        Success : in out Boolean);
      --  Process start of 'styles' element.

      -----------------
      -- End_Element --
      -----------------

      procedure End_Element
       (Self       : in out ODF_Parser'Class;
        Local_Name : League.Strings.Universal_String;
        Success    : in out Boolean) is
      begin
         if Local_Name = Document_Style_Name then
            case Self.Current.Kind is
               when Initial =>
                  Self.Pop;

               when others =>
                  raise Program_Error;
            end case;

         elsif Local_Name = Font_Face_Decls_Name then
            case Self.Current.Kind is
               when Office_Font_Face_Decls =>
                  Self.Pop;

               when others =>
                  raise Program_Error;
            end case;

         elsif Local_Name = Styles_Name then
            case Self.Current.Kind is
               when Office_Styles =>
                  Self.Pop;

               when others =>
                  raise Program_Error;
            end case;

         else
            raise Program_Error;
         end if;
      end End_Element;

      ---------------------------
      -- Start_Document_Styles --
      ---------------------------

      procedure Start_Document_Styles
       (Self       : in out ODF_Parser'Class;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean) is
      begin
         --  Process 'grddl:transformation' attribute.

         if Attributes.Is_Specified (GRDDL_URI, Transformation_Name) then
            --  XXX Not yet supported.

            raise Program_Error;
         end if;

         --  Process 'office:version' attribute.
         --
         --  [ODF12 19.386] office:version
         --
         --  "The office:version attribute shall be present in each and every
         --  <office:document>, <office:document-content>,
         --  <office:document-styles>, <office:document-meta>, and
         --  <office:document-settings> element in the XML documents that
         --  comprise an OpenDocument 1.2 document. The value of the
         --  office:version attribute shall be "1.2"."

         if not Attributes.Is_Specified (Office_URI, Version_Name) then
            --  'office:version' is required.

            raise Program_Error;

         elsif Attributes.Value (Office_URI, Version_Name) /= ODF_Version then
            --  Incorrect version of ODF.

            raise Program_Error;
         end if;
      end Start_Document_Styles;

      -------------------
      -- Start_Element --
      -------------------

      procedure Start_Element
       (Self       : in out ODF_Parser'Class;
        Local_Name : League.Strings.Universal_String;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean) is
      begin
         if Local_Name = Document_Style_Name then
            case Self.Current.Kind is
               when Initial =>
                  Self.Push (Office_Document_Style);
                  Start_Document_Styles (Self, Attributes, Success);

               when others =>
                  raise Program_Error;
            end case;

         elsif Local_Name = Font_Face_Decls_Name then
            case Self.Current.Kind is
               when Office_Document_Style =>
                  Self.Push (Office_Font_Face_Decls);
                  Start_Font_Face_Decls (Self, Success);

               when others =>
                  raise Program_Error;
            end case;

         elsif Local_Name = Styles_Name then
            case Self.Current.Kind is
               when Office_Document_Style =>
                  Self.Push (Office_Styles);
                  Start_Styles (Self, Success);

               when others =>
                  raise Program_Error;
            end case;

         else
            raise Program_Error;
         end if;
      end Start_Element;

      ---------------------------
      -- Start_Font_Face_Decls --
      ---------------------------

      procedure Start_Font_Face_Decls
       (Self    : in out ODF_Parser'Class;
        Success : in out Boolean) is
      begin
         null;
      end Start_Font_Face_Decls;

      ------------------
      -- Start_Styles --
      ------------------

      procedure Start_Styles
       (Self    : in out ODF_Parser'Class;
        Success : in out Boolean) is
      begin
         --  XXX Not yet implemented.

         null;
      end Start_Styles;

   end Office;

   ---------
   -- Pop --
   ---------

   procedure Pop (Self : in out ODF_Parser'Class) is
   begin
      Self.Current := Self.Previous;

      if not Self.Stack.Is_Empty then
         Self.Previous := Self.Stack.Last_Element;
         Self.Stack.Delete_Last;
      end if;
   end Pop;

   ----------
   -- Push --
   ----------

   procedure Push (Self : in out ODF_Parser'Class; Kind : State_Kinds) is
   begin
      Self.Stack.Append (Self.Previous);
      Self.Previous := Self.Current;
      Self.Current.Kind := Kind;
   end Push;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out ODF_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean) is
   begin
      if Namespace_URI = Office_URI then
         Put_Line ('{' & Namespace_URI.To_Wide_Wide_String & '}' & Local_Name.To_Wide_Wide_String);

         Office.Start_Element (Self, Local_Name, Attributes, Success);

      elsif Namespace_URI = Style_URI then
         Put_Line ('{' & Namespace_URI.To_Wide_Wide_String & '}' & Local_Name.To_Wide_Wide_String);

         Style.Start_Element (Self, Local_Name, Attributes, Success);

      else
         Put_Line ('{' & Namespace_URI.To_Wide_Wide_String & '}' & Local_Name.To_Wide_Wide_String);

         raise Program_Error;
      end if;
   end Start_Element;

   -----------
   -- Style --
   -----------

   package body Style is

      procedure Start_Font_Face
       (Self       : in out ODF_Parser'Class;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean);
      --  Process start of 'font-face' element.

      -----------------
      -- End_Element --
      -----------------

      procedure End_Element
       (Self       : in out ODF_Parser'Class;
        Local_Name : League.Strings.Universal_String;
        Success    : in out Boolean) is
      begin
         if Local_Name = Font_Face_Name then
            case Self.Current.Kind is
               when Style_Font_Face =>
                  Self.Pop;

               when others =>
                  raise Program_Error;
            end case;

         else
            raise Program_Error;
         end if;
      end End_Element;

      -------------------
      -- Start_Element --
      -------------------

      procedure Start_Element
       (Self       : in out ODF_Parser'Class;
        Local_Name : League.Strings.Universal_String;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean) is
      begin
         if Local_Name = Font_Face_Name then
            case Self.Current.Kind is
               when Office_Font_Face_Decls =>
                  Self.Push (Style_Font_Face);
                  Start_Font_Face (Self, Attributes, Success);

               when others =>
                  raise Program_Error;
            end case;

         else
            raise Program_Error;
         end if;
      end Start_Element;

      ---------------------
      -- Start_Font_Face --
      ---------------------

      procedure Start_Font_Face
       (Self       : in out ODF_Parser'Class;
        Attributes : XML.SAX.Attributes.SAX_Attributes;
        Success    : in out Boolean) is
      begin
         --  Process 'style:font-adornments' attribute.

         if Attributes.Is_Specified (Style_URI, Font_Adornments_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'style:font-charset' attribute.

         if Attributes.Is_Specified (Style_URI, Font_Charset_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'style:font-family-generic' attribute.

         if Attributes.Is_Specified (Style_URI, Font_Family_Generic_Name) then
            --  XXX Not yet implemented.

--            raise Program_Error;
            null;
         end if;

         --  Process 'style:font-pitch' attribute.

         if Attributes.Is_Specified (Style_URI, Font_Pitch_Name) then
            --  XXX Not yet implemented.

--            raise Program_Error;
            null;
         end if;

         --  Process 'style:name' attribute,

         if Attributes.Is_Specified (Style_URI, Name_Name) then
            --  XXX Not yet implemented.

--            raise Program_Error;
            null;
         end if;

         --  Process 'svg:accent-height' attribute.

         if Attributes.Is_Specified (SVG_URI, Accent_Height_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:alphabetic' attribute.

         if Attributes.Is_Specified (SVG_URI, Alphabetic_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:ascent' attribute.

         if Attributes.Is_Specified (SVG_URI, Ascent_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:bbox' attribute.

         if Attributes.Is_Specified (SVG_URI, Bbox_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:cap-height' attribute.

         if Attributes.Is_Specified (SVG_URI, Cap_Height_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:descent' attribute.

         if Attributes.Is_Specified (SVG_URI, Descent_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:font-family' attribute,

         if Attributes.Is_Specified (SVG_URI, Font_Family_Name) then
            --  XXX Not yet implemented.

--            raise Program_Error;
            null;
         end if;

         --  Process 'svg:font-size' attribute.

         if Attributes.Is_Specified (SVG_URI, Font_Size_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:font-stretch' attribute.

         if Attributes.Is_Specified (SVG_URI, Font_Stretch_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:font-style' attribute.

         if Attributes.Is_Specified (SVG_URI, Font_Style_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:font-variant' attribute.

         if Attributes.Is_Specified (SVG_URI, Font_Variant_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:font-weight' attribute.

         if Attributes.Is_Specified (SVG_URI, Font_Weight_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:hanging' attribute.

         if Attributes.Is_Specified (SVG_URI, Hanging_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:ideographic' attribute.

         if Attributes.Is_Specified (SVG_URI, Ideographic_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:mathematical' attribute.

         if Attributes.Is_Specified (SVG_URI, Mathematical_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:overline-position' attribute.

         if Attributes.Is_Specified (SVG_URI, Overline_Position_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:overline-thickness' attribute.

         if Attributes.Is_Specified (SVG_URI, Overline_Thickness_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:panose-1' attribute.

         if Attributes.Is_Specified (SVG_URI, Panose_1_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:slope' attribute.

         if Attributes.Is_Specified (SVG_URI, Slope_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:stemh' attribute.

         if Attributes.Is_Specified (SVG_URI, Stemh_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:stemv' attribute.

         if Attributes.Is_Specified (SVG_URI, Stemv_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:strikethrough-position' attribute.

         if Attributes.Is_Specified (SVG_URI, Strikethrough_Position_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:strikethrough-thickness' attribute.

         if Attributes.Is_Specified
             (SVG_URI, Strikethrough_Thickness_Name)
         then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:underline-position' attribute.

         if Attributes.Is_Specified (SVG_URI, Underline_Position_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:underline-thickness' attribute.

         if Attributes.Is_Specified (SVG_URI, Underline_Thickness_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:unicode-range' attribute.

         if Attributes.Is_Specified (SVG_URI, Unicode_Range_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:units-per-em' attribute.

         if Attributes.Is_Specified (SVG_URI, Units_Per_Em_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:v-alphabetic' attribute.

         if Attributes.Is_Specified (SVG_URI, V_Alphabetic_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:v-hanging' attribute.

         if Attributes.Is_Specified (SVG_URI, V_Hanging_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:v-ideographic' attribute.

         if Attributes.Is_Specified (SVG_URI, V_Ideographic_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:v-mathematical' attribute.

         if Attributes.Is_Specified (SVG_URI, V_Mathematical_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:widths' attribute.

         if Attributes.Is_Specified (SVG_URI, Widths_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  Process 'svg:x-height' attribute.

         if Attributes.Is_Specified (SVG_URI, X_Height_Name) then
            --  XXX Not yet implemented.

            raise Program_Error;
         end if;

         --  XXX Not yet implemented.
      end Start_Font_Face;

   end Style;

end ODF.Internals.Parsers;
