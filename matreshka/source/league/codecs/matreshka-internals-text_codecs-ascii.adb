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
-- Copyright © 2012-2017, Vadim Godunko <vgodunko@gmail.com>                --
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
with Matreshka.Internals.Strings.Configuration;
with Matreshka.Internals.Unicode.Characters.Latin;
with Matreshka.Internals.Utf16;

package body Matreshka.Internals.Text_Codecs.ASCII is

   use Matreshka.Internals.Strings.Configuration;
   use Matreshka.Internals.Unicode.Characters.Latin;
   use type Matreshka.Internals.Utf16.Utf16_String_Index;

   -------------------
   -- Decode_Append --
   -------------------

   overriding procedure Decode_Append
    (Self   : in out ASCII_Decoder;
     Data   : Ada.Streams.Stream_Element_Array;
     String : in out Matreshka.Internals.Strings.Shared_String_Access) is
   begin
      Matreshka.Internals.Strings.Mutate (String, String.Unused + Data'Length);

      for J in Data'Range loop
         if Data (J) in 16#00# .. 16#7F# then
            Self.Unchecked_Append
             (Self,
              String,
              Matreshka.Internals.Unicode.Code_Point (Data (J)));

         else
            Self.Error := True;

            exit;
         end if;
      end loop;

      String_Handler.Fill_Null_Terminator (String);
   end Decode_Append;

   -------------
   -- Decoder --
   -------------

   function Decoder (Mode : Decoder_Mode) return Abstract_Decoder'Class is
   begin
      case Mode is
         when Raw =>
            return
              ASCII_Decoder'
               (Skip_LF          => False,
                Unchecked_Append => Unchecked_Append_Raw'Access,
                Error            => False);

         when XML_1_0 =>
            return
              ASCII_Decoder'
               (Skip_LF          => False,
                Unchecked_Append => Unchecked_Append_XML10'Access,
                Error            => False);

         when XML_1_1 =>
            return
              ASCII_Decoder'
               (Skip_LF          => False,
                Unchecked_Append => Unchecked_Append_XML11'Access,
                Error            => False);
      end case;
   end Decoder;

   ------------
   -- Encode --
   ------------

   overriding procedure Encode
    (Self   : in out ASCII_Encoder;
     String : not null Matreshka.Internals.Strings.Shared_String_Access;
     Buffer : out MISEV.Shared_Stream_Element_Vector_Access)
   is
      pragma Unreferenced (Self);

      use Matreshka.Internals.Stream_Element_Vectors;
      use Ada.Streams;

      Code     : Matreshka.Internals.Unicode.Code_Point;
      Position : Matreshka.Internals.Utf16.Utf16_String_Index := 0;
      Element  : Ada.Streams.Stream_Element;

   begin
      null;
      if String.Unused = 0 then
         Buffer := Empty_Shared_Stream_Element_Vector'Access;

      else
         Buffer :=
           Allocate (Ada.Streams.Stream_Element_Offset (String.Unused));

         while Position < String.Unused loop
            Matreshka.Internals.Utf16.Unchecked_Next
             (String.Value, Position, Code);

            if Code in 16#0000# .. 16#007F# then
               --  Direct mapping.

               Element := Stream_Element (Code);

            else
               Element := Question_Mark;
            end if;

            Buffer.Value (Buffer.Length) := Element;
            Buffer.Length := Buffer.Length + 1;
         end loop;
      end if;
   end Encode;

   -------------
   -- Encoder --
   -------------

   function Encoder return Abstract_Encoder'Class is
   begin
      return ASCII_Encoder'(null record);
   end Encoder;

   --------------
   -- Is_Error --
   --------------

   overriding function Is_Error (Self : ASCII_Decoder) return Boolean is
   begin
      return Self.Error;
   end Is_Error;

   -------------------
   -- Is_Mailformed --
   -------------------

   overriding function Is_Mailformed (Self : ASCII_Decoder) return Boolean is
   begin
      return Self.Error;
   end Is_Mailformed;

end Matreshka.Internals.Text_Codecs.ASCII;
