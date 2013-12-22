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
--  Unpack .xz (LZMA2) binary stream

private with Ada.Streams;
private with Matreshka.Filters.LZMA.Dictionaries;

package Matreshka.Filters.LZMA.XZ_Unpack is
   pragma Preelaborate;

   type Filter is new Matreshka.Filters.Filter with private;
   pragma Preelaborable_Initialization (Filter);
   --  Unpacker for stream compressed with LZMA2 method

   overriding procedure Read
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector);

   overriding procedure Flush
     (Self   : in out Filter;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector);

private

   type Stage is
     (Read_Stream_Header,
      Read_Block,
      Read_Packet,
      Read_Compressed_Size,
      Read_Compressed_Chunk,
      Read_Uncompressed_Size,
      Read_Uncompressed_Chunk,
      Read_Completed);
   --  The filter can leave Read function in one of these stages.

   type LZMA_Property is record
      LC : Natural range 0 .. 4;
      --  lc is the number of high bits of the previous byte to use as
      --  a context for literal encoding (the default value used by
      --  the LZMA SDK is 3)
      LP : Natural range 0 .. 4;
      --  lp is the number of low bits of the dictionary position to include
      --  in literal_pos_state (the default value used by the LZMA SDK is 0)
      PB : Natural range 0 .. POS_STATES_BITS;
      --  pb is the number of low bits of the dictionary position to include
      --  in pos_state (the default value used by the LZMA SDK is 2)
      Pos_Mask : Position_State_Index;  --  2 ** PB - 1;
      Literal_Pos_Mask : Position_State_Index;  --  2 ** LP - 1;
      --  Invariant: LC + LP in 0 .. 4
   end record;

   type Range_Decoder is record
      Bound : Interfaces.Unsigned_32;  --  Range
      Code  : Interfaces.Unsigned_32;
   end record;

   procedure Reset (Self : in out Range_Decoder);
   --  Reset the range decoder

   --  Minimum number of usable input buffer to safely decode one LZMA symbol.
   --  The worst case is that we decode 22 bits using probabilities and 26
   --  direct bits. This may decode at maximum of 20 bytes of input. However,
   --  lzma_main() does an extra normalization before returning, thus we
   --  need to put 21 here.

   LZMA_IN_REQUIRED : constant := 21;

   RC_BIT_MODEL_TOTAL_BITS : constant := 11;
   RC_MOVE_BITS            : constant := 5;

   type Probability is mod 2 ** RC_BIT_MODEL_TOTAL_BITS;

   Half : constant Probability := Probability'Last / 2 + 1;  --  16#400#

   type Is_Match_Array is array (State, Position_State_Index) of Probability;

   type Probability_Index is range 1 .. 256;
   type Probability_Array is array (Probability_Index) of Probability;

   type Codec_Index is range 0 .. 15;
   type Codec_Kind is (Lit, One, Zero);

   type Literal_Array is array (Codec_Index, Codec_Kind) of Probability_Array;

   type Is_Rep_Array is array (State) of Probability;

   type Length_Index_8 is range 1 .. 8;
   type Length_Array_8 is array (Length_Index_8) of Probability;

   type Length_Probability_Array is
     array (Position_State_Index) of Length_Array_8;

   --  Match length is encoded with 4, 5, or 10 bits.
   --
   --  Length   Bits
   --   2-9      4 = Choice=0 + 3 bits
   --  10-17     5 = Choice=1 + Choice2=0 + 3 bits
   --  18-273   10 = Choice=1 + Choice2=1 + 8 bits

   -- Minimum length of a match is two bytes.
   MATCH_LEN_MIN   : constant := 2;
   LEN_LOW_SYMBOLS : constant := 8;
   LEN_MID_SYMBOLS : constant := 8;

   type Length_Decoder is record
      Choice   : Probability;  -- Choice between Low and others lengths
      Choice_2 : Probability;  -- Choice between Middle and High lengths
      Low      : Length_Probability_Array;
      Middle   : Length_Probability_Array;
      High     : Probability_Array;
   end record;

   --  Different sets of probabilities are used for match distances that have
   --  very short match length: Lengths of 2, 3, and 4 bytes have a separate
   --  set of probabilities for each length. The matches with longer length
   --  use a shared set of probabilities.

   DIST_STATES : constant := 4;

   type Distance_State is range 2 .. 5;
   Other_Distance_State : constant := 5;

   --  The highest two bits of a 32-bit match distance are encoded using six.
   --  This six-bit value is called a distance slot. This way encoding a 32-bit
   --  value takes 6-36 bits, larger values taking more bits.

   DIST_SLOT_BITS : constant := 6;
   DIST_SLOTS     : constant := 2 ** DIST_SLOT_BITS;  --  (1 << DIST_SLOT_BITS)

   --  Match distances up to 127 are fully encoded using probabilities. Since
   --  the highest two bits (distance slot) are always encoded using six bits,
   --  the distances 0-3 don't need any additional bits to encode, since the
   --  distance slot itself is the same as the actual distance.DIST_MODEL_START
   --  indicates the first distance slot where at least one additional bit is
   --  needed.

   DIST_MODEL_START : constant := 4;

   --  Match distances greater than 127 are encoded in three pieces:
   --    - distance slot: the highest two bits
   --    - direct bits: 2-26 bits below the highest two bits
   --    - alignment bits: four lowest bits
   --
   --  Direct bits don't use any probabilities.
   --
   --  The distance slot value of 14 is for distances 128-191.

   DIST_MODEL_END : constant  := 14;

   type Slot is range 1 .. DIST_SLOTS;
   type Slot_Probability_Array is array (Slot) of Probability;
   type Slot_Array is array (Distance_State) of Slot_Probability_Array;

   type Distance_Array is array (1 .. 4) of Ada.Streams.Stream_Element_Count;
   type Rep_Array is array (1 .. 3, State) of Probability;

   --  Probility trees for additional bits for match distance
   --  when the distance is in the range [4, 127].

   --  For match distances greater than 127, only the highest two bits and the
   --  lowest four bits (alignment) is encoded using probabilities.
   ALIGN_BITS : constant := 4;

   ALIGN_SIZE : constant := 2 ** ALIGN_BITS;

   Special_Distance_Last : constant := 114 + ALIGN_SIZE;
   Allign_Offset : constant := 115;

   type Special_Distance_Array is array
     (Interfaces.Unsigned_8 range 1 .. Special_Distance_Last) of Probability;

   --  x: limit = (dist_slot >> 1) - 1
   --  y: s->lzma.rep0 = 2 + (dist_slot & 1);
   --  z: s->lzma.rep0 <<= limit
   --  p: s->lzma.rep0 - dist_slot
   --
   --  ds  x  y  z  p
   --  4   1  2  4  0
   --  5   1  3  6  1
   --  6   2  2  8  2
   --  7   2  3 12  5
   --  8   3  2 16  8
   --  9   3  3 24  15
   --  10  4  2 32  22
   --  11  4  3 48  37
   --  12  5  2 64  52
   --  13  5  3 96  83

   subtype Dist_Offset is
     Interfaces.Unsigned_8 range 0 .. Allign_Offset;

   Special_Offset : constant array
     (Interfaces.Unsigned_8 range 4 .. 13) of Dist_Offset :=
     (4 => 0, 5 => 1, 6 => 2, 7 => 5, 8 => 8,
      9 => 15, 10 => 22, 11 => 37, 12 => 52, 13 => 83);

   type LZMA_Decoder is record
      State            : LZMA.State;
      Property         : LZMA_Property;
      Range_Decoder    : XZ_Unpack.Range_Decoder;
      Rep              : Distance_Array;
      --  If 1, it's a match. Otherwise it's a single 8-bit literal.
      Is_Match         : Is_Match_Array;
      --  If 1, it's a repeated match. The distance is one of rep0 .. rep3.
      Is_Rep           : Is_Rep_Array;
      Literal          : Literal_Array;
      Length           : Length_Decoder;
      Rep_Length       : Length_Decoder;
      Dist_Slot        : Slot_Array;
      Special_Dist     : Special_Distance_Array;
      Is_Rep_Prob      : Rep_Array;
      Is_Rep0_Long     : Is_Match_Array;
   end record;

   procedure Reset (Self : in out LZMA_Decoder);
   --  Reset the LZMA decoder and range decoder state.

   procedure Set_Property
     (Self     : in out LZMA_Decoder;
      Value    : Natural);

   type Filter is new Matreshka.Filters.Filter with record
      Last_Stage       : Stage := Read_Stream_Header;
      Count            : Ada.Streams.Stream_Element_Count := 1;
      To_Write         : Ada.Streams.Stream_Element_Count;

      Stream_Header    : XZ_Stream_Header;
      Block_Header     : XZ_Block_Header;
      Packet_Header    : XZ_Packet_Header;

      Dictionary       : Matreshka.Filters.LZMA.Dictionaries.Dictionary;
      Last_Block       : Boolean := False;

      Decoder          : LZMA_Decoder;
      Saved            : League.Stream_Element_Vectors.Stream_Element_Vector;
   end record;

   not overriding procedure Read_Stream_Header_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Ok     : out Boolean);

   not overriding procedure Read_Block_Header_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Ok : out Boolean);

   not overriding procedure Read_Packet_Header_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Ok : out Boolean);

   not overriding procedure Read_Compressed_Size_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Ok : out Boolean);

   not overriding procedure Read_Compressed_Chunk_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector;
      Ok     : out Boolean);

   not overriding procedure Read_Uncompressed_Size_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Ok     : out Boolean);

   not overriding procedure Read_Uncompressed_Chunk_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector;
      Ok     : out Boolean);

   procedure Range_Coder_Bit
     (Self   : in out Range_Decoder;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Prob   : in out Probability;
      Result : out Boolean);

   procedure Range_Coder_Bit_Tree_Reverse
     (Self   : in out Range_Decoder;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Prob   : in out Special_Distance_Array;
      Bits   : Positive;
      Offset : Dist_Offset;
      Result : out Interfaces.Unsigned_8);

   procedure Range_Coder_Direct
     (Self   : in out Range_Decoder;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Bits   : Positive;
      Result : in out Ada.Streams.Stream_Element_Count);

   procedure Normalize_Range_Coder
     (Self   : in out Range_Decoder;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count);

   not overriding procedure Read_Literal
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector);

   not overriding procedure Read_Match
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector);

   not overriding procedure Read_Rep_Match
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector);

   not overriding procedure Read_Length
     (Self   : Filter;
      RD     : in out Range_Decoder;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      LD     : in out Length_Decoder;
      Length : out Ada.Streams.Stream_Element_Count);

end Matreshka.Filters.LZMA.XZ_Unpack;
