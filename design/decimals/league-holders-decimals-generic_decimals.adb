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
-- Copyright © 2009-2011, Vadim Godunko <vgodunko@gmail.com>                --
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

package body League.Holders.Decimals.Generic_Decimals is

   Max_Mantissa : constant Mantissa := Mantissa (10 ** Num'Digits);

   function To_Num (Value : Universal_Decimal) return Num;
   function To_Universal (Value : Num) return Universal_Decimal;

   -----------------
   -- Constructor --
   -----------------

   overriding function Constructor
     (Is_Empty : not null access Boolean)
      return Decimal_Container
   is
      pragma Assert (Is_Empty.all);

   begin
      return
       (Counter  => <>,
        Is_Empty => Is_Empty.all,
        Value    => <>);
   end Constructor;

   -------------
   -- Element --
   -------------

   function Element (Self : Holder) return Num is
   begin
      if Self.Data.all not in Abstract_Decimal_Container'Class then
         raise Constraint_Error with "invalid type of value";
      end if;

      if Self.Data.Is_Empty then
         raise Constraint_Error with "value is empty";
      end if;

      if Self.Data.all in Decimal_Container'Class then
         return Decimal_Container'Class (Self.Data.all).Value;
      else
         return To_Num (Abstract_Decimal_Container'Class (Self.Data.all).Get);
      end if;
   end Element;

   ---------
   -- Get --
   ---------

   overriding function Get
     (Self : not null access constant Decimal_Container)
      return Universal_Decimal is
   begin
      return To_Universal (Self.Value);
   end Get;

   ---------------------
   -- Replace_Element --
   ---------------------

   procedure Replace_Element (Self : in out Holder; To : Num) is
   begin
      if Self.Data.all not in Decimal_Container
        and Self.Data.all not in Universal_Decimal_Container
      then
         raise Constraint_Error with "invalid type of value";
      end if;

      --  XXX This subprogram can be improved to reuse shared segment when
      --  possible.

      if Self.Data.all in Universal_Decimal_Container then
         Dereference (Self.Data);
         Self.Data :=
           new Universal_Decimal_Container'
                (Counter  => <>,
                 Is_Empty => False,
                 Value    => To_Universal (To));

      else
         Dereference (Self.Data);
         Self.Data :=
           new Decimal_Container'
                (Counter => <>, Is_Empty => False, Value => To);
      end if;
   end Replace_Element;

   ---------
   -- Set --
   ---------

   overriding procedure Set
     (Self : not null access Decimal_Container;
      To : Universal_Decimal)
   is
   begin
      Self.Is_Empty := False;
      Self.Value    := To_Num (To);
   end Set;

   ---------------
   -- To_Holder --
   ---------------

   function To_Holder (Item : Num) return Holder is
   begin
      return
       (Ada.Finalization.Controlled with
          new Decimal_Container'
               (Counter => <>, Is_Empty => False, Value => Item));
   end To_Holder;

   ------------
   -- To_Num --
   ------------

   function To_Num (Value : Universal_Decimal) return Num is
   begin
      if abs Value.Value >= Max_Mantissa then
         raise Constraint_Error with "lost precision";
      end if;

      if Value.Small >= 0 then
         return Value.Value * Value.Small * Num'Small;
      else
         return Value.Value / abs Value.Small * Num'Small;
      end if;
   end To_Num;

   ------------------
   -- To_Universal --
   ------------------

   function To_Universal (Value : Num) return Universal_Decimal is
   begin
      if Num'Small > 0.0 then
         return (Value => Value / Num'Small,
                 Small => Integer (Num'Small));
      else
         return (Value => Value * Num'Small,
                 Small => -Integer (10.0 / Num'Small));
      end if;
   end To_Universal;

end League.Holders.Decimals.Generic_Decimals;
