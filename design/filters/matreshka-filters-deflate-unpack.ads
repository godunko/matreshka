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
--  Unpack Deflate binary stream

private with Matreshka.Filters.Bit_Streams;

package Matreshka.Filters.Deflate.Unpack is
   pragma Preelaborate;

   procedure Initialize;
   --  Initialize fixed tables. Should be executed before other code.

   type Filter is new Matreshka.Filters.Filter with private;
   pragma Preelaborable_Initialization (Filter);
   --  Unpacker for stream compressed with Deflate method

   overriding procedure Read
     (Self   : in out Filter;
      Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector);

   overriding procedure Flush
     (Self   : in out Filter;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector);

private

   type Stage is
     (Read_Block,
      Dynamic_Huffman_Block,
      Read_Length_Codes,
      Read_Literal_Codes,
      Read_Distance_Codes,
      Read_Literal,
      Read_Length_Extra,
      Read_Distance,
      Read_Distance_Extra,
      Read_Fixed_Literal,
      Read_Fixed_Length_Extra,
      Read_Fixed_Distance,
      Read_Fixed_Distance_Extra);
   --  Deflate filter can leave Read function in one of these stages.

   type Filter is new Matreshka.Filters.Filter with record
      Input            : Matreshka.Filters.Bit_Streams.Bit_Stream;
      Last_Stage       : Stage := Read_Block;
      Last_Block       : Boolean := False;
      Block_Kind       : Deflate.Block_Kind;
      Index            : Cycle_Index := 0;
      Buffer           : Cycle_Buffer;
      Length           : Cycle_Index;

      Max_Length_Code  : Length_Code;
      Next_Length_Code : Length_Code;
      Length_Codes     : Length_Tables.Length_Map;
      Length_Table     : Length_Tables.Huffman_Table;

      Max_Literal      : Literal;
      Next_Literal     : Literal;
      Literal_Length   : Literal_Tables.Length_Map;
      Literal_Table    : Literal_Tables.Huffman_Table;

      Max_Distance     : Distance_Code;
      Next_Distance    : Distance_Code;
      Distance_Length  : Distance_Tables.Length_Map;
      Distance_Table   : Distance_Tables.Huffman_Table;

   end record;

end Matreshka.Filters.Deflate.Unpack;
