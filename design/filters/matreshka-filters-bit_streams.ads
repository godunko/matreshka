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
--  This package provides reading Stream_Element_Vector as stream of bits.

private with Ada.Streams;
private with Interfaces;

package Matreshka.Filters.Bit_Streams is
   pragma Preelaborate;

   Max_Bits : constant := 16;
   --  Max size of reading piece of data

   type Bit_Count is range 0 .. Max_Bits;
   type Bits is mod 2 ** Max_Bits;

   type Bit_Stream is tagged private;
   pragma Preelaborable_Initialization (Bit_Stream);

   not overriding procedure Reset (Self : out Bit_Stream);
   --  Clean given bit stream

   not overriding procedure Append
     (Self  : out Bit_Stream;
      Input : League.Stream_Element_Vectors.Stream_Element_Vector);
   --  Append given data to bit stream

   not overriding function Has_Bits
     (Self  : Bit_Stream;
      Count : Bit_Count) return Boolean;
   --  Check if stream has given Count of bits

   not overriding procedure Read
     (Self  : in out Bit_Stream;
      Count : Bit_Count;
      Value : in out Bits);
   --  Read from stream given Count of bits.
   --  Precondition: Self.Has_Bits (Count)

   not overriding function Read
     (Self  : in out Bit_Stream;
      Count : Bit_Count;
      Value : in out Bits) return Boolean;
   --  Check if stream has given Count of bits, read them and return True.
   --  Return False if not.

   not overriding procedure Read_Ahead
     (Self  : in out Bit_Stream;
      Count : Bit_Count;
      Got   : in out Bit_Count;
      Value : in out Bits);
   --  If stream has given Count of bits, put them to Value and Count to Got.
   --  Otherwise put avaliable count of bitd to Got and bits to Value.
   --  Don't proceed to next position of stream in both cases.

   not overriding procedure Skip
     (Self  : in out Bit_Stream;
      Count : Bit_Count);
   --  Rewind stream to Count bits forward.
   --  Precondition: Self.Has_Bits (Count)

   not overriding procedure Write
     (Self   : in out Bit_Stream;
      Count  : Bit_Count;
      Value  : Bits);
   --  Write bits to internal Data buffer

   not overriding procedure Get_Data
     (Self   : in out Bit_Stream;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector);
   --  Append internal buffer of completed data to Output and flush it

private

   type Word is new Interfaces.Unsigned_32;
   subtype Word_Bit_Count is Integer range 0 .. 32;

   type Bit_Stream is tagged record
      Left  : Natural := 0;  --  Count of bits in stream to read
      Head  : Word := 0;     --  Next available piece of bits to read
      Ready : Word_Bit_Count := 0;  --  Number of valid bits in Head
      Data  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index : Ada.Streams.Stream_Element_Offset := 1;  --  Next item in Data
                                                       --  to move it to Head
   end record;

   not overriding procedure Fill_Head (Self : in out Bit_Stream);
   --  Put bits from Data to Head

   pragma Inline (Fill_Head);
   pragma Inline (Has_Bits);
   pragma Inline (Read);
   pragma Inline (Read_Ahead);
   pragma Inline (Skip);

end Matreshka.Filters.Bit_Streams;
