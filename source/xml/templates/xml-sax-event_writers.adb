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
-- Copyright © 2014-2015, Vadim Godunko <vgodunko@gmail.com>                --
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

package body XML.SAX.Event_Writers is

   ----------------
   -- Characters --
   ----------------

   overriding procedure Characters
    (Self    : in out Event_Writer;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      Self.Stream.Append
       ((Kind     => XML.Templates.Streams.Text,
         Location => (System_Id => Self.Locator.System_Id,
                      Line      => Self.Locator.Line,
                      Column    => Self.Locator.Column),
         Text     => Text));
   end Characters;

   -------------
   -- Comment --
   -------------

   overriding procedure Comment
    (Self    : in out Event_Writer;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      Self.Stream.Append
       ((Kind     => XML.Templates.Streams.Comment,
         Location => (System_Id => Self.Locator.System_Id,
                      Line      => Self.Locator.Line,
                      Column    => Self.Locator.Column),
         Text     => Text));
   end Comment;

   ---------------
   -- End_CDATA --
   ---------------

   overriding procedure End_CDATA
    (Self    : in out Event_Writer;
     Success : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      Self.Stream.Append
       ((Kind     => XML.Templates.Streams.End_CDATA,
         Location => (System_Id => Self.Locator.System_Id,
                      Line      => Self.Locator.Line,
                      Column    => Self.Locator.Column)));
   end End_CDATA;

   -------------
   -- End_DTD --
   -------------

   overriding procedure End_DTD
    (Self    : in out Event_Writer;
     Success : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      Self.Stream.Append
       ((Kind     => XML.Templates.Streams.End_DTD,
         Location => (System_Id => Self.Locator.System_Id,
                      Line      => Self.Locator.Line,
                      Column    => Self.Locator.Column)));
   end End_DTD;

   -----------------
   -- End_Element --
   -----------------

   overriding procedure End_Element
    (Self           : in out Event_Writer;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      Self.Stream.Append
       ((Kind           => XML.Templates.Streams.End_Element,
         Location       => (System_Id => Self.Locator.System_Id,
                            Line      => Self.Locator.Line,
                            Column    => Self.Locator.Column),
         Namespace_URI  => Namespace_URI,
         Local_Name     => Local_Name,
         Qualified_Name => Qualified_Name));
   end End_Element;

   ------------------------
   -- End_Prefix_Mapping --
   ------------------------

   overriding procedure End_Prefix_Mapping
    (Self    : in out Event_Writer;
     Prefix  : League.Strings.Universal_String;
     Success : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      Self.Stream.Append
       ((Kind     => XML.Templates.Streams.End_Prefix_Mapping,
         Location => (System_Id => Self.Locator.System_Id,
                      Line      => Self.Locator.Line,
                      Column    => Self.Locator.Column),
         Prefix   => Prefix));
   end End_Prefix_Mapping;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : Event_Writer) return League.Strings.Universal_String
   is
      pragma Unreferenced (Self);

   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   ----------------
   -- Get_Stream --
   ----------------

   function Get_Stream
    (Self : Event_Writer'Class)
       return XML.Templates.Streams.XML_Stream_Element_Vectors.Vector is
   begin
      return Self.Stream;
   end Get_Stream;

   --------------------------
   -- Ignorable_Whitespace --
   --------------------------

   overriding procedure Ignorable_Whitespace
    (Self    : in out Event_Writer;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      Self.Stream.Append
       ((Kind     => XML.Templates.Streams.Text,
         Location => (System_Id => Self.Locator.System_Id,
                      Line      => Self.Locator.Line,
                      Column    => Self.Locator.Column),
         Text     => Text));
   end Ignorable_Whitespace;

   ----------------------------
   -- Processing_Instruction --
   ----------------------------

   overriding procedure Processing_Instruction
    (Self    : in out Event_Writer;
     Target  : League.Strings.Universal_String;
     Data    : League.Strings.Universal_String;
     Success : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      Self.Stream.Append
       ((Kind     => XML.Templates.Streams.Processing_Instruction,
         Location => (System_Id => Self.Locator.System_Id,
                      Line      => Self.Locator.Line,
                      Column    => Self.Locator.Column),
         Target   => Target,
         Data     => Data));
   end Processing_Instruction;

   -----------------
   -- Start_CDATA --
   -----------------

   overriding procedure Start_CDATA
    (Self    : in out Event_Writer;
     Success : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      Self.Stream.Append
       ((Kind     => XML.Templates.Streams.Start_CDATA,
         Location => (System_Id => Self.Locator.System_Id,
                      Line      => Self.Locator.Line,
                      Column    => Self.Locator.Column)));
   end Start_CDATA;

   --------------------------
   -- Set_Document_Locator --
   --------------------------

   overriding procedure Set_Document_Locator
    (Self    : in out Event_Writer;
     Locator : XML.SAX.Locators.SAX_Locator) is
   begin
      Self.Locator := Locator;
   end Set_Document_Locator;

   ---------------
   -- Start_DTD --
   ---------------

   overriding procedure Start_DTD
    (Self      : in out Event_Writer;
     Name      : League.Strings.Universal_String;
     Public_Id : League.Strings.Universal_String;
     System_Id : League.Strings.Universal_String;
     Success   : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      Self.Stream.Append
       ((Kind      => XML.Templates.Streams.Start_DTD,
         Location  => (System_Id => Self.Locator.System_Id,
                       Line      => Self.Locator.Line,
                       Column    => Self.Locator.Column),
         Name      => Name,
         Public_Id => Public_Id,
         System_Id => System_Id));
   end Start_DTD;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out Event_Writer;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      Self.Stream.Append
       ((Kind           => XML.Templates.Streams.Start_Element,
         Location       => (System_Id => Self.Locator.System_Id,
                            Line      => Self.Locator.Line,
                            Column    => Self.Locator.Column),
         Namespace_URI  => Namespace_URI,
         Local_Name     => Local_Name,
         Qualified_Name => Qualified_Name,
         Attributes     => Attributes));
   end Start_Element;

   --------------------------
   -- Start_Prefix_Mapping --
   --------------------------

   overriding procedure Start_Prefix_Mapping
    (Self          : in out Event_Writer;
     Prefix        : League.Strings.Universal_String;
     Namespace_URI : League.Strings.Universal_String;
     Success       : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      Self.Stream.Append
       ((Kind                 => XML.Templates.Streams.Start_Prefix_Mapping,
         Location             => (System_Id => Self.Locator.System_Id,
                                  Line      => Self.Locator.Line,
                                  Column    => Self.Locator.Column),
         Prefix               => Prefix,
         Mapped_Namespace_URI => Namespace_URI));
   end Start_Prefix_Mapping;

end XML.SAX.Event_Writers;
