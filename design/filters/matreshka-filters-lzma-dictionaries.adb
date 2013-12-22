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

package body Matreshka.Filters.LZMA.Dictionaries is

   ---------
   -- Get --
   ---------

   function Get
     (Self  : Dictionary;
      Index : Ada.Streams.Stream_Element_Count)
      return Ada.Streams.Stream_Element is
   begin
      if Index = 0 and Self.Data.Is_Empty then
         return 0;
      else
         return Self.Data.Element (Self.Data.Length - Index);
      end if;
   end Get;

   --------------
   -- Set_Size --
   --------------

   procedure Set_Size
     (Self  : in out Dictionary;
      Value : Ada.Streams.Stream_Element_Count)
   is
   begin
      null;
   end Set_Size;

   -----------
   -- Reset --
   -----------

   procedure Reset (Self : in out Dictionary) is
   begin
      Self.Position := 0;
   end Reset;

   --------------
   -- Position --
   --------------

   function Position (Self : Dictionary) return Position_State_Index is
   begin
      return Self.Position;
   end Position;

   ---------
   -- Put --
   ---------

   procedure Put
     (Self  : in out Dictionary;
      Value : Ada.Streams.Stream_Element_Array)
   is
   begin
      Self.Data.Append (Value);
      Self.Position := Self.Position + Value'Length;
   end Put;

   ------------
   -- Repeat --
   ------------

   procedure Repeat
     (Self   : in out Dictionary;
      Index  : Ada.Streams.Stream_Element_Count;
      Length : Ada.Streams.Stream_Element_Count;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector)
   is
      Data : Ada.Streams.Stream_Element_Array (1 .. Length);
   begin
      for J in Data'Range loop
         Data (J) := Self.Get (Index);
         Self.Put (Data (J .. J));
      end loop;

      Output.Append (Data);
   end Repeat;

end Matreshka.Filters.LZMA.Dictionaries;
