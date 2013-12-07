------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
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
--  Code related to LZMA compression method.

with Interfaces;
with Ada.Streams;

package Matreshka.Filters.LZMA is
   pragma Preelaborate;

   type XZ_Magic_Bytes is
     array (Ada.Streams.Stream_Element_Offset range 1 .. 6)
       of Ada.Streams.Stream_Element;

   type XZ_Stream_Header is record
      Magic : XZ_Magic_Bytes;
      Flags : Interfaces.Unsigned_16;
      CRC32 : Interfaces.Unsigned_32;
   end record;

   type XZ_Block_Header is record
      Header_Size       : Ada.Streams.Stream_Element_Offset;
      Flags             : Interfaces.Unsigned_8;
      Compressed_Size   : Interfaces.Unsigned_64;
      Uncompressed_Size : Interfaces.Unsigned_64;
      Filter_Id         : Interfaces.Unsigned_8;
      Filter_Prop       : Interfaces.Unsigned_8;
      Padding_1         : Interfaces.Unsigned_8;
      Padding_2         : Interfaces.Unsigned_8;
      Padding_3         : Interfaces.Unsigned_8;
      CRC32             : Interfaces.Unsigned_32;
      Dictionary_Size   : Ada.Streams.Stream_Element_Offset;
   end record;

--     function Has_Compressed_Size (Self : XZ_Block_Header) return Boolean;
--     function Has_Uncompressed_Size (Self : XZ_Block_Header) return Boolean;

   type XZ_Packet_Header is record
      Control_Byte       : Interfaces.Unsigned_8;
      Last_Packet        : Boolean;
      Dictionary_Reset   : Boolean;
      Compressed_Chunk   : Boolean;
      State_Reset        : Boolean;
      Properties_Reset   : Boolean;
      Compressed_Size    : Ada.Streams.Stream_Element_Offset;
      Uncompressed_Size  : Ada.Streams.Stream_Element_Offset;
   end record;

  --  This enum is used to track which LZMA symbols have occurred most recently
   --  and in which order. This information is used to predict the next symbol.
   --
   --   Symbols:
   --    - Literal: One 8-bit byte
   --    - Match: Repeat a chunk of data at some distance
   --    - Long repeat: Multi-byte match at a recently seen distance
   --    - Short repeat: One-byte repeat at a recently seen distance
   --
   --  The symbol names are in from STATE_oldest_older_previous. REP means
   --  either short or long repeated match, and NONLIT means any non-literal.

   type State is
     (STATE_LIT_LIT,
      STATE_MATCH_LIT_LIT,
      STATE_REP_LIT_LIT,
      STATE_SHORTREP_LIT_LIT,
      STATE_MATCH_LIT,
      STATE_REP_LIT,
      STATE_SHORTREP_LIT,
      STATE_LIT_MATCH,
      STATE_LIT_LONGREP,
      STATE_LIT_SHORTREP,
      STATE_NONLIT_MATCH,
      STATE_NONLIT_REP);

   subtype Literal_State is State range STATE_LIT_LIT .. STATE_SHORTREP_LIT;

   type Packet_Name is (Lit, Match, Short_Rep, Long_Rep);

   --  Maximum number of position states. A position state is the lowest pb
   --  number of bits of the current uncompressed offset. In some places there
   --  are different sets of probabilities for different position states.
   POS_STATES_BITS : constant := 4;
   POS_STATES_MAX  : constant := 2 ** POS_STATES_BITS;  --  (1 << 4)

   use type Ada.Streams.Stream_Element_Count;

   subtype Position_State_Index is Ada.Streams.Stream_Element_Count
     range 0 .. (POS_STATES_MAX - 1);

end Matreshka.Filters.LZMA;
