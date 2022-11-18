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

with League.Strings;

with Matreshka.XML_Schema.AST;
with Ada.Containers.Hashed_Maps;
with League.Strings.Hash;
with Matreshka.Atomics.Counters;

package Matreshka.XML_Schema.Named_Maps is

   pragma Preelaborate;

   type Named_Map is tagged limited private;
   type Named_Map_Access is access all Named_Map'Class;

   function Length (Self : Named_Map) return Natural;

   function Item
     (Self  : in out Named_Map;
      Index : Positive) return Matreshka.XML_Schema.AST.Object_Access;

   function Item_By_Name
    (Self      : Named_Map;
     Name      : League.Strings.Universal_String;
     Namespace : League.Strings.Universal_String)
     return Matreshka.XML_Schema.AST.Object_Access;

   procedure Append
    (Self      : in out Named_Map;
     Item      : Matreshka.XML_Schema.AST.Object_Access);

   procedure Reference (Self : Named_Map_Access);
   procedure Dereference (Self : in out Named_Map_Access);

private

   package Object_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           Matreshka.XML_Schema.AST.Object_Access,
           League.Strings.Hash,
           League.Strings."=",
           Matreshka.XML_Schema.AST."=");

   type Named_Map is tagged limited record
      Counter    : Matreshka.Atomics.Counters.Counter;
      --  Atomic reference counter.
      Map         : Object_Maps.Map;
      Cursor      : Object_Maps.Cursor;
      Last_Cursor : Natural := 0;
   end record;

end Matreshka.XML_Schema.Named_Maps;
