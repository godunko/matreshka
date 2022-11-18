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

package body Matreshka.Filters.Bit_Streams is

   Byte : constant := Ada.Streams.Stream_Element'Size;
   --  Size of one Stream_Element

   ------------
   -- Append --
   ------------

   not overriding procedure Append
     (Self  : out Bit_Stream;
      Input : League.Stream_Element_Vectors.Stream_Element_Vector)
   is
      use type Ada.Streams.Stream_Element_Offset;
   begin
      if Self.Index > Self.Data.Length then
         --  Strip old data
         Self.Data.Clear;
         Self.Index := 1;
      end if;

      Self.Data.Append (Input);
      Self.Left := Self.Left + Natural (Byte * Input.Length);
   end Append;

   ----------
   -- Data --
   ----------

   not overriding procedure Get_Data
     (Self   : in out Bit_Stream;
      Output : in out League.Stream_Element_Vectors.Stream_Element_Vector) is
   begin
      Output.Append (Self.Data);
      Self.Data.Clear;
   end Get_Data;

   ---------------
   -- Fill_Head --
   ---------------

   not overriding procedure Fill_Head (Self : in out Bit_Stream) is
      use type Ada.Streams.Stream_Element_Offset;
      Next : Word;
   begin
      while Self.Ready + Byte <= Word_Bit_Count'Last
        and Self.Index <= Self.Data.Length
      loop
         Next := Word (Self.Data.Element (Self.Index));
         Self.Index := Self.Index + 1;
         Next := Shift_Left (Next, Self.Ready);
         Self.Head := Self.Head or Next;
         Self.Ready := Self.Ready + Byte;
      end loop;
   end Fill_Head;

   --------------
   -- Has_Bits --
   --------------

   not overriding function Has_Bits
     (Self  : Bit_Stream;
      Count : Bit_Count) return Boolean is
   begin
      return Self.Left >= Natural (Count);
   end Has_Bits;

   -----------
   -- Reset --
   -----------

   not overriding procedure Reset (Self : out Bit_Stream) is
   begin
      Self.Left := 0;
      Self.Head := 0;
      Self.Ready := 0;
      Self.Data.Clear;
      Self.Index := 1;
   end Reset;

   ----------
   -- Read --
   ----------

   not overriding procedure Read
     (Self  : in out Bit_Stream;
      Count : Bit_Count;
      Value : in out Bits)
   is
      Mask : constant Word := Shift_Left (1, Natural (Count)) - 1;
   begin
      Fill_Head (Self);
      Value := Bits (Self.Head and Mask);
      Self.Skip (Count);
   end Read;

   ----------
   -- Read --
   ----------

   not overriding function Read
     (Self  : in out Bit_Stream;
      Count : Bit_Count;
      Value : in out Bits) return Boolean is
   begin
      if Self.Has_Bits (Count) then
         Self.Read (Count, Value);
         return True;
      else
         return False;
      end if;
   end Read;

   ----------------
   -- Read_Ahead --
   ----------------

   not overriding procedure Read_Ahead
     (Self  : in out Bit_Stream;
      Count : Bit_Count;
      Got   : in out Bit_Count;
      Value : in out Bits)
   is
      Mask : Word;
   begin
      Fill_Head (Self);
      Got := Bit_Count (Integer'Min (Max_Bits, Self.Ready));
      Got := Bit_Count'Min (Got, Count);
      Mask := Shift_Left (1, Natural (Got)) - 1;
      Value := Bits (Self.Head and Mask);
   end Read_Ahead;

   ----------
   -- Skip --
   ----------

   not overriding procedure Skip
     (Self  : in out Bit_Stream;
      Count : Bit_Count) is
   begin
      Self.Left := Self.Left - Natural (Count);
      Self.Ready := Self.Ready - Word_Bit_Count (Count);
      Self.Head := Shift_Right (Self.Head, Natural (Count));
   end Skip;

   -----------
   -- Write --
   -----------

   not overriding procedure Write
     (Self   : in out Bit_Stream;
      Count  : Bit_Count;
      Value  : Bits)
   is
      Next : Word;
   begin
      Self.Head := Shift_Left (Word (Value), Self.Left) + Self.Head;
      Self.Left := Self.Left + Natural (Count);

      while Self.Left >= Byte loop
         Next := Self.Head and (2 ** Byte - 1);  --  last byte
         Self.Data.Append (Ada.Streams.Stream_Element (Next));
         Self.Head := Shift_Right (Self.Head, Byte);
         Self.Left := Self.Left - Byte;
      end loop;
   end Write;

end Matreshka.Filters.Bit_Streams;
