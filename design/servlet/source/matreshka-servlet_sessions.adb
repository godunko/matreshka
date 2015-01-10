------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Ada.Streams;

with League.Base_64;
with League.Stream_Element_Vectors;

package body Matreshka.Servlet_Sessions is

   use type Ada.Streams.Stream_Element_Offset;

   ---------------------------
   -- To_Session_Identifier --
   ---------------------------

   function To_Session_Identifier
    (Item : League.Strings.Universal_String) return Session_Identifier
   is
      Decoded : constant League.Stream_Element_Vectors.Stream_Element_Vector
        := League.Base_64.From_Base_64 (Item);

   begin
      if Decoded.Length /= Session_Identifier'Max_Size_In_Storage_Elements then
         raise Constraint_Error with "Mailformed SID";
      end if;

      declare
         Raw    : constant Ada.Streams.Stream_Element_Array
           := Decoded.To_Stream_Element_Array;
         for Raw'Alignment use Interfaces.Unsigned_64'Alignment;
         Result : constant Session_Identifier
           with Import     => True,
                Convention => Ada,
                Address    => Raw'Address;

      begin
         return Result;
      end;
   end To_Session_Identifier;

   ---------------------------
   -- To_Session_Identifier --
   ---------------------------

   procedure To_Session_Identifier
    (Item       : League.Strings.Universal_String;
     Identifier : out Session_Identifier;
     Success    : out Boolean)
   is
      Raw     : Ada.Streams.Stream_Element_Array
                 (1 .. Session_Identifier'Max_Size_In_Storage_Elements)
                    with Import     => True,
                         Convention => Ada,
                         Address    => Identifier'Address;
      Decoded : League.Stream_Element_Vectors.Stream_Element_Vector;

   begin
      League.Base_64.From_Base_64 (Item, Decoded, Success);

      if not Success then
         return;
      end if;

      if Decoded.Length /= Session_Identifier'Max_Size_In_Storage_Elements then
         Success := False;

         return;
      end if;

      Raw := Decoded.To_Stream_Element_Array;
      Success := True;
   end To_Session_Identifier;

   -------------------------
   -- To_Universal_String --
   -------------------------

   function To_Universal_String
    (Item : Session_Identifier) return League.Strings.Universal_String
   is
      Aux : constant Ada.Streams.Stream_Element_Array
                      (1 .. Session_Identifier'Max_Size_In_Storage_Elements)
        with Import     => True,
             Convention => Ada,
             Address    => Item'Address;

   begin
      return
        League.Base_64.To_Base_64
         (League.Stream_Element_Vectors.To_Stream_Element_Vector (Aux));
   end To_Universal_String;

end Matreshka.Servlet_Sessions;
