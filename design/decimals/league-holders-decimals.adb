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

with Ada.Tags.Generic_Dispatching_Constructor;

package body League.Holders.Decimals is

   function Create is
     new Ada.Tags.Generic_Dispatching_Constructor
       (Abstract_Container, Boolean, Constructor);
   --  XXX We should reuse this function from League.Holders body

   -------------------------
   -- Is_Abstract_Decimal --
   -------------------------

   function Is_Abstract_Decimal (Self : Holder) return Boolean is
   begin
      return Self.Data.all in Abstract_Decimal_Container'Class;
   end Is_Abstract_Decimal;

   -------------
   -- Element --
   -------------

   function Element (Self : Holder) return Universal_Decimal is
   begin
      if Self.Data.all not in Abstract_Decimal_Container'Class then
         raise Constraint_Error with "invalid type of value";
      end if;

      if Self.Data.Is_Empty then
         raise Constraint_Error with "value is empty";
      end if;

      return Abstract_Decimal_Container'Class (Self.Data.all).Get;
   end Element;

   ---------------------
   -- Replace_Element --
   ---------------------

   procedure Replace_Element (Self : in out Holder; To : Universal_Decimal) is
      Tag      : constant Ada.Tags.Tag := Self.Data'Tag;
      Is_Empty : aliased Boolean := True;

   begin
      if Self.Data.all not in Abstract_Decimal_Container'Class then
         raise Constraint_Error with "invalid type of value";
      end if;

      --  Create new shared object when existing one can't be reused.

      if not Matreshka.Atomics.Counters.Is_One (Self.Data.Counter) then
         Dereference (Self.Data);
         Self.Data :=
           new Abstract_Container'Class'(Create (Tag, Is_Empty'Access));
      end if;

      --  Set value.

      Abstract_Decimal_Container'Class (Self.Data.all).Set (To);
   end Replace_Element;

   -----------------
   -- Constructor --
   -----------------

   overriding function Constructor
     (Is_Empty : not null access Boolean)
      return Universal_Decimal_Container
   is
      pragma Assert (Is_Empty.all);

   begin
      return
       (Counter  => <>,
        Is_Empty => Is_Empty.all,
        Value    => <>);
   end Constructor;

   ---------
   -- Get --
   ---------

   overriding function Get
     (Self : not null access constant Universal_Decimal_Container)
      return Universal_Decimal is
   begin
      return Self.Value;
   end Get;

   ---------
   -- Set --
   ---------

   overriding procedure Set
     (Self : not null access Universal_Decimal_Container;
      To   : Universal_Decimal) is
   begin
      Self.Is_Empty := False;
      Self.Value    := To;
   end Set;

end League.Holders.Decimals;
