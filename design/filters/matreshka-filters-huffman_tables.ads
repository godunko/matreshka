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
--  Huffman table is able to read from bit stream elements encoded with
--  bit-pieces of variable size.

with Matreshka.Filters.Bit_Streams;

generic
   type Encoded_Element is range <>;

   Max_Length : Bit_Streams.Bit_Count;
package Matreshka.Filters.Huffman_Tables is
   pragma Preelaborate;

   subtype Length is Bit_Streams.Bit_Count range 0 .. Max_Length;

   type Length_Map is array (Encoded_Element) of Length;
   --  Map each encoded element to its length

   type Huffman_Table is tagged private;
   pragma Preelaborable_Initialization (Huffman_Table);

   procedure Initialize
     (Self : in out Huffman_Table;
      Map  : Length_Map);
   --  Create Huffman table for given length Map

   function Read
     (Self  : Huffman_Table;
      Input : in out Matreshka.Filters.Bit_Streams.Bit_Stream;
      Value : in out Encoded_Element)
      return Boolean;
   --  Read encoded Value from Input stream if it has enought bits

   procedure Write
     (Self   : Huffman_Table;
      Value  : Encoded_Element;
      Output : in out Matreshka.Filters.Bit_Streams.Bit_Stream);
   --  Encode value and write in to Output

private

   use type Matreshka.Filters.Bit_Streams.Bits;

   subtype Bits is Bit_Streams.Bits range 0 .. 2 ** Natural (Max_Length) - 1;

   type Value_Table  is array (Bits) of Encoded_Element;
   --  This table maps any value of length Max_Length to Encoded_Element.
   --  Prefix of value is equal code of Encoded_Element.

   type Bits_Array is array (Encoded_Element) of Bits;

   type Huffman_Table is tagged record
      Mask       : Bits;
      Max_Length : Length;
      Values     : Value_Table;
      Length     : Length_Map;
      Bits       : Bits_Array;
   end record;

end Matreshka.Filters.Huffman_Tables;
