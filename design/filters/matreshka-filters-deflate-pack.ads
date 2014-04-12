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
--  $Revision: 3946 $ $Date: 2013-06-16 21:48:41 +0300 (Вс., 16 июня 2013) $
------------------------------------------------------------------------------
--  Code related to Deflate compression method.

private with Matreshka.Filters.Bit_Streams;

package Matreshka.Filters.Deflate.Pack is
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

   type Stage is (Empty, Completed_Search, Incomplete_Search);

   type Buffer is tagged record
      Data     : Cycle_Buffer;
      Index    : Cycle_Index;  --  Current byte in Data
      Last     : Cycle_Index;  --  Last read element in buffer
      Filled   : Boolean;      --  If buffer has been filled once
   end record;

   Max_Look_Ahead_Count : constant := 64;
   --  Max count of look ahead searches
   Max_Look_Ahead : constant := 1 + Max_Length * Max_Look_Ahead_Count;
   --  We could skip a byte then make Look_Ahead searches of Max_Length each,
   --  so Max bytes of look ahead searches is here.

   type Look_Ahead_Count is range 1 .. Max_Look_Ahead_Count;
   --  Count of look ahead searches
   type Look_Ahead_Position is range 0 .. Max_Look_Ahead;
   --  Bytes of look ahead searches

   type Look_Ahead_Kinds is (Use_Current, Skip_Current);
   --  We search for best of:
   --  * Skip_Current - skip one byte and search for back references then
   --  * Use_Current - search for back references from current byte

   subtype Length_Step is Cycle_Index range 0 .. Max_Length;
   --  Length of back reference

   type Look_Ahead_Data is record
      Length : Length_Step;  --  Length of back reference
      Where  : Cycle_Index;  --  Where back reference found
   end record;

   type Look_Ahead_Data_Array is
     array (Look_Ahead_Count, Look_Ahead_Kinds) of Look_Ahead_Data;

   type Look_Ahead_Context is record
      Skipped    : Ada.Streams.Stream_Element;  --  Skipped literal
      A          : Look_Ahead_Position := 0;
      B          : Look_Ahead_Position := 1;
      M          : Look_Ahead_Count'Base;
      K          : Look_Ahead_Kinds;
      LA         : Look_Ahead_Data_Array;  --  Lookahead data
   end record;
   --  Lookahead data

   type Filter is new Matreshka.Filters.Filter with record
      Last_Stage : Stage := Empty;
      Output     : Matreshka.Filters.Bit_Streams.Bit_Stream;
      Context    : Look_Ahead_Context;
      Buf        : Buffer;
   end record;

end Matreshka.Filters.Deflate.Pack;
