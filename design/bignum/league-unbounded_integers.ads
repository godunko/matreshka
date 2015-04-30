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
--  This package provides type to operate on integer numbers with unbounded
--  range. Conventional operations and conversion to/from string and Integer
--  are provided.

private with Ada.Finalization;
private with Ada.Streams;

with League.Strings;

private with Matreshka.Atomics.Counters;
private with Matreshka.Unbounded_Naturals;

package League.Unbounded_Integers is
   pragma Preelaborate;
   pragma Remote_Types;

   type Unbounded_Integer is tagged private;
   --  Integer numbers with unbounded range

   subtype Allowed_Base is Positive range 2 .. 16;
   --  Base supported by conversions to/from strings

   function To_Universal_String
    (Item : Unbounded_Integer;
     Base : Allowed_Base := 10)
      return League.Strings.Universal_String;
   --  Convert Unbounded_Integer to string using given Base

   function From_Universal_String
    (Item : League.Strings.Universal_String;
     Base : Allowed_Base := 10) return Unbounded_Integer;
   --  Convert string to Unbounded_Integer using given Base.
   --  Characters not representing digits in given Base are silently ignored

   function Fit_Integer (Left : Unbounded_Integer) return Boolean;
   --  Check if Left in Integer'Range

   function To_Integer (Left : Unbounded_Integer) return Integer;
   --  Convert Unbounded_Integer to integer if Fit_Integer

   function From_Integer (Value : Integer) return Unbounded_Integer;
   --  Convert integer to Unbounded_Integer

   function "=" (Left, Right : Unbounded_Integer) return Boolean;
   function ">" (Left, Right : Unbounded_Integer) return Boolean;
   function "<" (Left, Right : Unbounded_Integer) return Boolean;
   function ">=" (Left, Right : Unbounded_Integer) return Boolean;
   function "<=" (Left, Right : Unbounded_Integer) return Boolean;

   function "-" (Left : Unbounded_Integer) return Unbounded_Integer;
   function "+" (Left, Right : Unbounded_Integer) return Unbounded_Integer;
   function "-" (Left, Right : Unbounded_Integer) return Unbounded_Integer;
   function "*" (Left, Right : Unbounded_Integer) return Unbounded_Integer;
   function "/" (Left, Right : Unbounded_Integer) return Unbounded_Integer;
   function "mod" (Left, Right : Unbounded_Integer) return Unbounded_Integer;
   function "rem" (Left, Right : Unbounded_Integer) return Unbounded_Integer;
   function "abs" (Left : Unbounded_Integer) return Unbounded_Integer;

   function "**"
     (Left : Unbounded_Integer; Right : Natural) return Unbounded_Integer;

private

   type Shared_Number (Size : Natural) is limited record
      Counter   : Matreshka.Atomics.Counters.Counter;
      --  Atomic reference counter.

      Value     : Matreshka.Unbounded_Naturals.Number (1 .. Size);
   end record;

   Shared_Zero : aliased Shared_Number :=
     (Size   => 0,
      Value  => (others => 0),
      others => <>);
   --  Globally defined zero shared number to be used as default value.
   --  Reference and Dereference subprograms known about this object and
   --  never change its reference counter for speed optimization (atomic
   --  increment/decrement operations have significant perfomance penalty)
   --  and allows to be used in Preelaborateable_Initialization types.

   type Shared_Number_Access is access all Shared_Number;

   procedure Read
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : out Unbounded_Integer);

   procedure Write
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : Unbounded_Integer);

   type Unbounded_Integer is new Ada.Finalization.Controlled with record
      Negative : Boolean := False;
      Data     : Shared_Number_Access := Shared_Zero'Access;
   end record;

   for Unbounded_Integer'Read use Read;
   for Unbounded_Integer'Write use Write;

   overriding procedure Adjust (Self : in out Unbounded_Integer)
     with Inline => True;

   overriding procedure Finalize (Self : in out Unbounded_Integer);

end League.Unbounded_Integers;
