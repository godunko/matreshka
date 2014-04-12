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
--  Code related to Deflate compression method.

private with Ada.Streams;
private with Matreshka.Filters.Bit_Streams;
private with Matreshka.Filters.Huffman_Tables;

package Matreshka.Filters.Deflate is
   pragma Preelaborate;

private

   type Block_Kind is
     (Stored_Block,            --  Block stored without any compression
      Fixed_Huffman_Block,     --  Block with predefined codes
      Dynamic_Huffman_Block,   --  Block with codes saved in stream
      Reserved);               --  Not used value
   --  Kind of block inside of deflate stream

   type Literal is range 0..287;
   --  Literal used to encode byte values, end of block and length

   subtype Literal_Range is Literal range   0 .. 255;
   subtype End_Of_Block  is Literal range 256 .. 256;
   subtype Length_Range  is Literal range 257 .. 285;

   package Literal_Tables is new Huffman_Tables
     (Encoded_Element => Literal,
      Max_Length      => 15);

   type Length_Code is range 0..18;
   --  Length code used to encode length values
   subtype Direct_Length_Code     is Length_Code range 00 .. 15;
   subtype Copy_Length_Code       is Length_Code range 16 .. 16;
   subtype Zero_Length_Code       is Length_Code range 17 .. 17;
   subtype Long_Zero_Length_Code  is Length_Code range 18 .. 18;

   package Length_Tables is new Huffman_Tables
     (Encoded_Element => Length_Code,
      Max_Length      => 7);

   type Distance_Code is range 0..29;
   --  Distance code used to encode distance values

   package Distance_Tables is new Huffman_Tables
     (Encoded_Element => Distance_Code,
      Max_Length      => 15);

   Max_Distance   : constant := 2 ** 15;   --  32k
   Max_Length     : constant := 258;

   type Cycle_Index is mod Max_Distance;
   type Cycle_Buffer is array (Cycle_Index) of Ada.Streams.Stream_Element;

   Fixed_Literal_Table  : Literal_Tables.Huffman_Table;
   Fixed_Distance_Table : Distance_Tables.Huffman_Table;
   --  Predefined (fixed) Huffman tables for deflate method.

   type Extra_Bits is record
      Extra_Bits  : Bit_Streams.Bit_Count;
      Base_Length : Cycle_Index;
   end record;
   --  This record stores number of extra bits to read for some length code
   --  and corresponding length.

   Length_Codes : constant array (Length_Range) of Extra_Bits :=
     ((0, 3), (0, 4), (0, 5), (0, 6), (0, 7), (0, 8), (0, 9), (0, 10),
      (1, 11), (1, 13), (1, 15), (1, 17),
      (2, 19), (2, 23), (2, 27), (2, 31),
      (3, 35), (3, 43), (3, 51), (3, 59),
      (4, 67), (4, 83), (4, 99), (4, 115),
      (5, 131), (5, 163), (5, 195), (5, 227),
      (0, 258));
   --  This table stores number of extra bits to read for each length code
   --  and corresponding length.

   Distance_Codes : constant array (Distance_Code) of Extra_Bits :=
     ((0, 1),  (0, 2),  (0, 3),  (0, 4),  (1, 5),  (1, 7),  (2, 9),   (2, 13),
      (3, 17), (3, 25), (4, 33), (4, 49), (5, 65), (5, 97), (6, 129), (6, 193),
      (7, 257), (7, 385), (8, 513), (8, 769), (9, 1025), (9, 1537),
      (10, 2049), (10, 3073), (11, 4097), (11, 6145), (12, 8193), (12, 12289),
      (13, 16385), (13, 24577));
   --  This table stores number of extra bits to read for each length code
   --  and corresponding length.

end Matreshka.Filters.Deflate;
