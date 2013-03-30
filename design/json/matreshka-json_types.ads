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
with League.Holders;
with Matreshka.Atomics.Counters;
with Matreshka.Internals.Strings;
with Matreshka.JSON_Arrays;

package Matreshka.JSON_Types is

   pragma Preelaborate;

   type Value_Kinds is
    (Empty_Value,
     Boolean_Value,
     Integer_Value,
     Float_Value,
     String_Value,
     Array_Value,
     Object_Value,
     Null_Value);
   --  JSON doesn't distinguish integer and float numbers, but we distinguish
   --  them to avoid potential loss of precision on conversions.

   type Shared_JSON_Value;

   type Shared_JSON_Value_Access is access all Shared_JSON_Value;

   ------------------------
   -- Shared_JSON_Object --
   ------------------------

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

   -----------------------
   -- Shared_JSON_Value --
   -----------------------

   type Internal_Value (Kind : Value_Kinds := Empty_Value) is record
      case Kind is
         when Empty_Value =>
            null;

         when Boolean_Value =>
            Boolean_Value : Boolean;

         when Integer_Value =>
            Integer_Value : League.Holders.Universal_Integer;

         when Float_Value =>
            Float_Value   : League.Holders.Universal_Float;

         when String_Value =>
            String_Value  : Matreshka.Internals.Strings.Shared_String_Access;

         when Array_Value =>
            Array_Value   : Matreshka.JSON_Arrays.Shared_JSON_Array_Access;

         when Object_Value =>
            Object_Value  : Shared_JSON_Object_Access;

         when Null_Value =>
            null;
      end case;
   end record;

   type Shared_JSON_Value is limited record
      Counter : Matreshka.Atomics.Counters.Counter;
      Value   : Internal_Value;
   end record;

   Empty_Shared_JSON_Value : aliased Shared_JSON_Value
     := (Counter => <>, Value => (Kind => Empty_Value));

   procedure Reference (Self : not null Shared_JSON_Value_Access);
   --  Increments internal reference counter.

   procedure Dereference (Self : in out Shared_JSON_Value_Access);
   --  Decrements internal reference counter and deallocates shared object when
   --  counter reach zero. Sets Self to null.

   procedure Mutate (Self : in out not null Shared_JSON_Value_Access);
   --  Mutate object: new shared object is allocated when reference counter is
   --  greater than one, reference counter of original object is decremented
   --  and original value is copied. Otherwise, shared object is unchanged.

   procedure Mutate
    (Self : in out not null Shared_JSON_Value_Access;
     Kind : Value_Kinds);
   --  Mutate object: allocate new shared then reference counter is greater
   --  than one, and decrement reference counter of original object. Value of
   --  the object is reset to default value of specifid kind.

end Matreshka.JSON_Types;
