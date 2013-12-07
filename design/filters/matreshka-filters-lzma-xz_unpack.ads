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

   procedure Initialize;
   --  Initialize fixed tables. Should be executed before other code.

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
      Read_Uncompressed_Chunk);
   --  The filter can leave Read function in one of these stages.

   type LZMA_Property is record
      LC : Natural range 0 .. 8;
      --  lc is the number of high bits of the previous byte to use as
      --  a context for literal encoding (the default value used by
      --  the LZMA SDK is 3)
      LP : Natural;
      --  lp is the number of low bits of the dictionary position to include
      --  in literal_pos_state (the default value used by the LZMA SDK is 0)
      PB : Natural range 0 .. POS_STATES_BITS - 1;
      --  pb is the number of low bits of the dictionary position to include
      --  in pos_state (the default value used by the LZMA SDK is 2)
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
   type Literal_Array  is array
     (Position_State_Index, Ada.Streams.Stream_Element) of Probability;

   type LZMA_Decoder is record
      State            : LZMA.State;
      Property         : LZMA_Property;
      Range_Decoder    : XZ_Unpack.Range_Decoder;
      Is_Match         : Is_Match_Array;
      Literal          : Literal_Array;
      Index            : Position_State_Index;
   end record;

   procedure Reset (Self : in out LZMA_Decoder);
   --  Reset the LZMA decoder and range decoder state.

   procedure Set_Property
     (Self     : in out LZMA_Decoder;
      Value    : Natural);

   type Filter is new Matreshka.Filters.Filter with record
      Last_Stage       : Stage := Read_Stream_Header;
      Count            : Ada.Streams.Stream_Element_Count := 1;

      Stream_Header    : XZ_Stream_Header;
      Block_Header     : XZ_Block_Header;
      Packet_Header    : XZ_Packet_Header;

      Dictionary       : Matreshka.Filters.LZMA.Dictionaries.Dictionary;
      Last_Block       : Boolean := False;

      Decoder          : LZMA_Decoder;
   end record;

   not overriding function Read_Stream_Header_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count) return Boolean;

   not overriding function Read_Block_Header_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count) return Boolean;

   not overriding function Read_Packet_Header_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count) return Boolean;

   not overriding function Read_Compressed_Size_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count) return Boolean;

   not overriding function Read_Compressed_Chunk_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector)
      return Boolean;

   not overriding function Read_Uncompressed_Size_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count) return Boolean;

   not overriding function Read_Uncompressed_Chunk_Bytes
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector)
      return Boolean;

   not overriding function Range_Coder_Bit
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Prob   : in out Probability) return Boolean;

   not overriding function Range_Coder_Bit_Tree
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Prob   : in out Probability;
      Bits   : Positive) return Interfaces.Unsigned_8;

   not overriding procedure Normalize_Range_Coder
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count);

   not overriding procedure Read_Literal
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index  : in out Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector);

end Matreshka.Filters.LZMA.XZ_Unpack;
