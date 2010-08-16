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
--  Abstract API for text decoders/encoders.
--
--  Decoder's states and decoders implementation are separate objects.
------------------------------------------------------------------------------
with Ada.Streams;

with League.Strings;
with Matreshka.Internals.Strings;
private with Matreshka.Internals.Unicode;

package Matreshka.Internals.Text_Codecs is

   pragma Preelaborate;

   type Character_Set is range 0 .. 2999;
   --  IANA MIB code of the character set.

   MIB_UTF8    : constant Character_Set := 106;
   MIB_UTF16   : constant Character_Set := 1012;
   MIB_UTF16BE : constant Character_Set := 1013;
   MIB_UTF16LE : constant Character_Set := 1014;
   MIB_UTF32   : constant Character_Set := 1017;
   MIB_UTF32BE : constant Character_Set := 1018;
   MIB_UTF32LE : constant Character_Set := 1019;

   function To_Character_Set
    (Item : League.Strings.Universal_String) return Character_Set;
   --  Converts name of character encoding into internal representation.

   ----------------------
   -- Abstract_Decoder --
   ----------------------

   type Decoder_Mode is (Raw, XML_1_0, XML_1_1);
   --  Mode of text postprocessing after decoding.
   --
   --  Decoder is responsible for XML1.0/XML1.1 end-of-line handling when
   --  its state created with corresponding mode.

   type Abstract_Decoder_State is abstract tagged private;
   --  Abstract root tagged type for decoder's states.

   type Decoder_State_Access is access all Abstract_Decoder_State'Class;

   not overriding function Is_Error
    (Self : Abstract_Decoder_State) return Boolean is abstract;
   --  Returns True when error is occured during decoding.

   not overriding function Is_Mailformed
    (Self : Abstract_Decoder_State) return Boolean is abstract;
   --  Returns True when error is occured during decoding or decoding is
   --  incomplete.

   type Abstract_Decoder is abstract tagged limited null record;
   --  Abstract root tagged type for decoders.

   type Decoder_Access is access all Abstract_Decoder'Class;
   for Decoder_Access'Storage_Size use 0;

   not overriding function Create_State
    (Self : Abstract_Decoder;
     Mode : Decoder_Mode) return Abstract_Decoder_State'Class is abstract;
   --  Creates new decoder's state.

   not overriding procedure Decode
    (Self   : Abstract_Decoder;
     Data   : Ada.Streams.Stream_Element_Array;
     State  : in out Abstract_Decoder_State'Class;
     String : out Matreshka.Internals.Strings.Shared_String_Access)
       is abstract;
   --  Decodes data and save results in new allocated string.

   not overriding procedure Decode_Append
    (Self   : Abstract_Decoder;
     Data   : Ada.Streams.Stream_Element_Array;
     State  : in out Abstract_Decoder_State'Class;
     String : in out Matreshka.Internals.Strings.Shared_String_Access)
       is abstract;
   --  Decodes data and appends them to specified string. String can be
   --  reallocated when necessary.

   ----------------------
   -- Abstract_Encoder --
   ----------------------

   type Abstract_Encoder is abstract tagged limited null record;
   --  Abstract root tagged type for encoders.

   function Decoder (Set : Character_Set) return Decoder_Access;
   --  Returns decoder for the specified character set. Decoder is global
   --  object and must not be deallocated.

private

   type Abstract_Decoder_State is abstract tagged record
      Mode    : Decoder_Mode;
      Skip_LF : Boolean;
   end record;

   procedure Unterminated_Append
    (Buffer : in out Matreshka.Internals.Strings.Shared_String_Access;
     State  : in out Abstract_Decoder_State'Class;
     Code   : Matreshka.Internals.Unicode.Code_Point);
   --  Internal implementation of unterminated append, which stores Code into
   --  the buffer and handle line termination conventions.

end Matreshka.Internals.Text_Codecs;
