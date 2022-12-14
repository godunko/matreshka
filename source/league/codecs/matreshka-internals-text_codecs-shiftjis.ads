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
-- Copyright © 2010-2011, Vadim Godunko <vgodunko@gmail.com>                --
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

package Matreshka.Internals.Text_Codecs.SHIFTJIS is

   pragma Preelaborate;

   type SHIFTJIS_Decoder is new Abstract_Decoder with private;

   overriding function Is_Error (Self : SHIFTJIS_Decoder) return Boolean;

   overriding function Is_Mailformed (Self : SHIFTJIS_Decoder) return Boolean;

   overriding procedure Decode_Append
    (Self   : in out SHIFTJIS_Decoder;
     Data   : Ada.Streams.Stream_Element_Array;
     String : in out Matreshka.Internals.Strings.Shared_String_Access);

   function Decoder (Mode : Decoder_Mode) return Abstract_Decoder'Class;

private

   type SHIFTJIS_Meta_Class is mod 2 ** 8;
   type SHIFTJIS_DFA_State is mod 2 ** 8;

   type SHIFTJIS_Decoder is new Abstract_Decoder with record
      State : SHIFTJIS_DFA_State;
      First : Ada.Streams.Stream_Element;
   end record;

   type SHIFTJIS_Code_Point_Array is
     array (Ada.Streams.Stream_Element)
       of Matreshka.Internals.Unicode.Code_Point;

   type SHIFTJIS_Code_Point_Array_Access is
     access constant SHIFTJIS_Code_Point_Array;

   type SHIFTJIS_Expansion_Pair is record
      First  : Matreshka.Internals.Unicode.Code_Point;
      Second : Matreshka.Internals.Unicode.Code_Point;
   end record;

end Matreshka.Internals.Text_Codecs.SHIFTJIS;
