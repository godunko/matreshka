------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
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

with Ada.Unchecked_Deallocation;

package body Matreshka.XML_Schema.Object_Lists is

   ------------
   -- Append --
   ------------

   procedure Append
     (Self : in out Object_List;
      Item : Matreshka.XML_Schema.AST.Object_Access) is
   begin
      Self.Vector.Append (Item);
   end Append;

   -----------------
   -- Dereference --
   -----------------

   procedure Dereference (Self : in out Object_List_Access) is
      procedure Free is new Ada.Unchecked_Deallocation
        (Object_List'Class, Object_List_Access);
   begin
      if Matreshka.Atomics.Counters.Decrement (Self.Counter) then
         Self.Vector.Clear;
         Free (Self);
      end if;
   end Dereference;

   ----------
   -- Item --
   ----------

   function Item
     (Self  : in out Object_List;
      Index : Positive) return Matreshka.XML_Schema.AST.Object_Access is
   begin
      if Index in Self.Vector.First_Index .. Self.Vector.Last_Index then
         return Self.Vector.Element (Index);
      end if;

      return null;
   end Item;

   ------------
   -- Length --
   ------------

   function Length (Self : Object_List) return Natural is
   begin
      return Natural (Self.Vector.Length);
   end Length;

   ---------------
   -- Reference --
   ---------------

   procedure Reference (Self : Object_List_Access) is
   begin
      Matreshka.Atomics.Counters.Increment (Self.Counter);
   end Reference;

end Matreshka.XML_Schema.Object_Lists;
