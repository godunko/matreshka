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
--  This is inefficient but fully portable version of the package.
------------------------------------------------------------------------------
pragma Ada_2012;

package body Matreshka.Atomics.Counters is

   protected Guard is

      procedure Increment (Self : in out Counter);

      procedure Decrement (Self : in out Counter);

      procedure Decrement
       (Self    : in out Counter;
        Is_Zero : out Boolean);

      function Is_Zero (Self : in out Counter) return Boolean;

      function Is_One (Self : in out Counter) return Boolean;

   end Guard;

   ---------------
   -- Decrement --
   ---------------

   function Decrement (Self : in out Counter) return Boolean is
      Result : Boolean;

   begin
      Guard.Decrement (Self, Result);

      return Result;
   end Decrement;

   ---------------
   -- Decrement --
   ---------------

   procedure Decrement (Self : in out Counter) is
   begin
      Guard.Decrement (Self);
   end Decrement;

   -----------
   -- Guard --
   -----------

   protected body Guard is

      ---------------
      -- Decrement --
      ---------------

      procedure Decrement
       (Self    : in out Counter;
        Is_Zero : out Boolean)
      is
      begin
         Self.Value := Self.Value - 1;
         Is_Zero    := Self.Value = 0;
      end Decrement;

      ---------------
      -- Decrement --
      ---------------

      procedure Decrement (Self : in out Counter) is
      begin
         Self.Value := Self.Value - 1;
      end Decrement;

      ---------------
      -- Increment --
      ---------------

      procedure Increment (Self : in out Counter) is
      begin
         Self.Value := Self.Value + 1;
      end Increment;

      ------------
      -- Is_One --
      ------------

      function Is_One (Self : in out Counter) return Boolean is
      begin
         return Self.Value = 1;
      end Is_One;

      -------------
      -- Is_Zero --
      -------------

      function Is_Zero (Self : in out Counter) return Boolean is
      begin
         return Self.Value = 0;
      end Is_Zero;

   end Guard;

   ---------------
   -- Increment --
   ---------------

   procedure Increment (Self : in out Counter) is
   begin
      Guard.Increment (Self);
   end Increment;

   ------------
   -- Is_One --
   ------------

   function Is_One (Self : in out Counter) return Boolean is
   begin
      return Guard.Is_One (Self);
   end Is_One;

   -------------
   -- Is_Zero --
   -------------

   function Is_Zero (Self : in out Counter) return Boolean is
   begin
      return Guard.Is_Zero (Self);
   end Is_Zero;

   ---------
   -- One --
   ---------

   function One return Counter is
   begin
      return Counter'(Value => 1);
   end One;

   ----------
   -- Zero --
   ----------

   function Zero return Counter is
   begin
      return Counter'(Value => 0);
   end Zero;

end Matreshka.Atomics.Counters;
