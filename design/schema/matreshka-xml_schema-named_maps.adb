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
-- Copyright © 2012, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Matreshka.XML_Schema.AST.Objects;
with Ada.Containers.Hashed_Maps;
with Ada.Unchecked_Deallocation;

package body Matreshka.XML_Schema.Named_Maps is

   ------------
   -- Append --
   ------------

   procedure Append
     (Self : in out Named_Map;
      Item : Matreshka.XML_Schema.AST.Object_Access)
   is
      use type League.Strings.Universal_String;
      Key : constant League.Strings.Universal_String :=
        Item.Get_Name & Item.Get_Target_Namespace;
   begin
      Self.Map.Insert (Key => Key, New_Item =>  Item);
   end Append;

   -----------------
   -- Dereference --
   -----------------

   procedure Dereference (Self : in out Named_Map_Access) is
      procedure Free is new Ada.Unchecked_Deallocation
        (Named_Map'Class, Named_Map_Access);
   begin
      if Matreshka.Atomics.Counters.Decrement (Self.Counter) then
         Free (Self);
      end if;
   end Dereference;

   ----------
   -- Item --
   ----------

   function Item
     (Self  : in out Named_Map;
      Index : Positive) return Matreshka.XML_Schema.AST.Object_Access is
   begin
      if Self.Last_Cursor = 0 or Self.Last_Cursor + 1 /= Index then
         Self.Cursor := Self.Map.First;
         Self.Last_Cursor := 1;

         for J in 2 .. Index loop
            Object_Maps.Next (Self.Cursor);
            Self.Last_Cursor := Self.Last_Cursor + 1;
         end loop;
      else
         Object_Maps.Next (Self.Cursor);
         Self.Last_Cursor := Self.Last_Cursor + 1;
      end if;

      return Object_Maps.Element (Self.Cursor);
   end Item;

   ------------------
   -- Item_By_Name --
   ------------------

   function Item_By_Name
    (Self      : Named_Map;
     Name      : League.Strings.Universal_String;
     Namespace : League.Strings.Universal_String)
     return Matreshka.XML_Schema.AST.Object_Access
   is
      use type League.Strings.Universal_String;
      Key    : constant League.Strings.Universal_String := Name & Namespace;
      Cursor : Object_Maps.Cursor;
   begin
      Cursor := Self.Map.Find (Key => Key);

      if Object_Maps.Has_Element (Position => Cursor) then
         return Object_Maps.Element (Cursor);
      else
         return null;
      end if;

   end Item_By_Name;

   ------------
   -- Length --
   ------------

   function Length (Self : Named_Map) return Natural is
   begin
      return Natural (Self.Map.Length);
   end Length;

   ---------------
   -- Reference --
   ---------------

   procedure Reference (Self : Named_Map_Access) is
   begin
      Matreshka.Atomics.Counters.Increment (Self.Counter);
   end Reference;

end Matreshka.XML_Schema.Named_Maps;
