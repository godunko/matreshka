------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
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
with Ada.Containers.Hashed_Maps;

--with League.JSON.Values;
with League.Strings.Hash;
with Matreshka.Atomics.Counters;

package Matreshka.JSON_Objects is

   pragma Preelaborate;

--   package Value_Maps is
--     new Ada.Containers.Hashed_Maps
--          (League.Strings.Universal_String,
--           League.JSON.Values.JSON_Value,
--           League.Strings.Hash,
--           League.Strings."=",
--           League.JSON.Values."=");

   type Shared_JSON_Object is limited record
      Counter : Matreshka.Atomics.Counters.Counter;
--      Values  : Value_Maps.Map;
   end record;

   type Shared_JSON_Object_Access is access all Shared_JSON_Object;

   Empty_Shared_JSON_Object : aliased Shared_JSON_Object
     := (Counter => <>);
--     := (Counter => <>, Values => <>);

   procedure Reference (Self : not null Shared_JSON_Object_Access);
   --  Increments internal reference counter.

   procedure Dereference (Self : in out Shared_JSON_Object_Access);
   --  Decrements internal reference counter and deallocates shared object when
   --  counter reach zero. Sets Self to null.

   procedure Mutate (Self : in out not null Shared_JSON_Object_Access);
   --  Mutate object: new shared object is allocated when reference counter is
   --  greater than one, reference counter of original object is decremented
   --  and original value is copied. Otherwise, shared object is unchanged.

end Matreshka.JSON_Objects;
