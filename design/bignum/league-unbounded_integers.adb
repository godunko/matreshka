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

with Ada.Unchecked_Deallocation;

with League.JSON.Streams;
with League.JSON.Values;

package body League.Unbounded_Integers is

   procedure Reference (Self : not null Shared_Number_Access);
   --  Increment reference counter. Change of reference counter of Shared_Zero
   --  object is prevented to provide speedup and to allow to use it to
   --  initialize components of Preelaborateable_Initialization types.

   procedure Dereference (Self : in out Shared_Number_Access);
   --  Decrement reference counter and free resources if it reach zero value.
   --  Self is setted to null. Decrement of reference counter and deallocation
   --  of Shared_Zero object is prevented to provide minor speedup and to
   --  allow use it to initialize components of Preelaborateable_Initialization
   --  types.

   function Allocate
    (Data     : Matreshka.Unbounded_Naturals.Number)
       return not null Shared_Number_Access;
   --  Allocates new instance of shared number.

   function Wrap
    (Data     : Shared_Number_Access;
     Negative : Boolean)
       return Unbounded_Integer;
   --  Creates instance of Unbounded_Integer as wrapper for the specified
   --  shared number. Reference counter is untouched, thus once instance will
   --  be finalized it will be decremented and shared number freed.

   function Create
    (Data     : Shared_Number_Access;
     Negative : Boolean)
       return Unbounded_Integer;
   --  Creates instance of Unbounded_Integer by reusing specified shared number
   --  Reference counter is incremented.

   procedure Free is
     new Ada.Unchecked_Deallocation (Shared_Number, Shared_Number_Access);

   ---------
   -- "*" --
   ---------

   function "*" (Left, Right : Unbounded_Integer) return Unbounded_Integer is
      Length : constant Natural := Left.Data.Size + Right.Data.Size + 1;
      Result : Matreshka.Unbounded_Naturals.Number (1 .. Length);
      Last   : Natural;
   begin
      Matreshka.Unbounded_Naturals.Multiply
        (Left.Data.Value, Right.Data.Value, Result, Last);

      return Wrap (Allocate (Result (1 .. Last)),
                   Left.Negative xor Right.Negative);
   end "*";

   ----------
   -- "**" --
   ----------

   function "**"
     (Left : Unbounded_Integer; Right : Natural) return Unbounded_Integer
   is
      use type Matreshka.Unbounded_Naturals.Digit;

      Power       : Matreshka.Unbounded_Naturals.Digit :=
        Matreshka.Unbounded_Naturals.Digit (Right);
      Max         : constant Positive :=
        Natural'Max (Left.Data.Size * Right, 1);
      Mult_Last   : Natural range 0 .. Max := Left.Data.Size;
      Result_Last : Natural range 0 .. Max := 1;
      Mult        : Matreshka.Unbounded_Naturals.Number (1 .. Max);
      Result      : Matreshka.Unbounded_Naturals.Number (1 .. Max);

   begin
      Result (1) := 1;
      Mult (1 .. Mult_Last) := Left.Data.Value;

      while Power > 0 loop
         if (Power and 1) /= 0 then

            declare
               Temp_Text : constant Matreshka.Unbounded_Naturals.Number :=
                 Result (1 .. Result_Last);
            begin

               Matreshka.Unbounded_Naturals.Multiply
                 (Left   => Temp_Text,
                  Right  => Mult (1 .. Mult_Last),
                  Result => Result,
                  Last   => Result_Last);

               Power := Power - 1;
            end;
         else

            declare
               Temp_Text : constant Matreshka.Unbounded_Naturals.Number :=
                 Mult (1 .. Mult_Last);
            begin

               Matreshka.Unbounded_Naturals.Multiply
                 (Left   => Temp_Text,
                  Right  => Temp_Text,
                  Result => Mult,
                  Last   => Mult_Last);

               Power := Power / 2;
            end;
         end if;
      end loop;

      return Wrap (Allocate (Result (1 .. Result_Last)),
                   Left.Negative and (Power and 1) /= 0);
   end "**";

   ---------
   -- "+" --
   ---------

   function "+" (Left, Right : Unbounded_Integer) return Unbounded_Integer is
      Length : constant Natural :=
        Natural'Max (Left.Data.Size, Right.Data.Size) + 1;
      Result : Matreshka.Unbounded_Naturals.Number (1 .. Length);
      Last   : Natural;
   begin
      if Left.Data = Shared_Zero'Access then

         return Right;

      elsif Right.Data = Shared_Zero'Access then

         return Left;

      elsif Left.Negative = Right.Negative then

         Matreshka.Unbounded_Naturals.Add
           (Left.Data.Value, Right.Data.Value, Result, Last);

         return Wrap (Allocate (Result (1 .. Last)), Left.Negative);

      elsif Matreshka.Unbounded_Naturals.Less
        (Left.Data.Value, Right.Data.Value)
      then

         Matreshka.Unbounded_Naturals.Subtract
           (Right.Data.Value, Left.Data.Value, Result, Last);

         return Wrap (Allocate (Result (1 .. Last)), Right.Negative);

      else

         Matreshka.Unbounded_Naturals.Subtract
           (Left.Data.Value, Right.Data.Value, Result, Last);

         return Wrap (Allocate (Result (1 .. Last)), Left.Negative);

      end if;
   end "+";

   ---------
   -- "-" --
   ---------

   function "-" (Left : Unbounded_Integer) return Unbounded_Integer is
   begin
      if Left.Data = Shared_Zero'Access then
         return Left;
      end if;

      return Create (Left.Data, not Left.Negative);
   end "-";

   ---------
   -- "-" --
   ---------

   function "-" (Left, Right : Unbounded_Integer) return Unbounded_Integer is
      Length : constant Natural :=
        Natural'Max (Left.Data.Size, Right.Data.Size) + 1;
      Result : Matreshka.Unbounded_Naturals.Number (1 .. Length);
      Last   : Natural;
   begin
      if Left.Data = Shared_Zero'Access then

         return -Right;

      elsif Right.Data = Shared_Zero'Access then

         return Left;

      elsif Left.Negative /= Right.Negative then

         Matreshka.Unbounded_Naturals.Add
           (Left.Data.Value, Right.Data.Value, Result, Last);

         return Wrap (Allocate (Result (1 .. Last)), Left.Negative);

      elsif Matreshka.Unbounded_Naturals.Less
        (Left.Data.Value, Right.Data.Value)
      then

         Matreshka.Unbounded_Naturals.Subtract
           (Right.Data.Value, Left.Data.Value, Result, Last);

         return Wrap (Allocate (Result (1 .. Last)), not Left.Negative);

      else

         Matreshka.Unbounded_Naturals.Subtract
           (Left.Data.Value, Right.Data.Value, Result, Last);

         return Wrap (Allocate (Result (1 .. Last)), Left.Negative);

      end if;
   end "-";

   ---------
   -- "/" --
   ---------

   function "/" (Left, Right : Unbounded_Integer) return Unbounded_Integer is
      use Matreshka.Unbounded_Naturals;

      Sign : constant Boolean := Left.Negative /= Right.Negative;
      Last : Natural := 0;
      Temp : Digit;
   begin
      if Right.Data = Shared_Zero'Access then

         raise Constraint_Error;
      elsif Right.Data.Size = 1 then

         declare
            Result : Number (1 .. Left.Data.Size);
         begin
            Fast_Devide
              (Left   => Left.Data.Value,
               Right  => Right.Data.Value (1),
               Result => Result,
               Last   => Last,
               Rest   => Temp);

            return Wrap (Allocate (Result (1 .. Last)), Sign);
         end;
      end if;

      declare
         --  Reserve one digit as space needed for normalization, then
         --  Make copy of Left and ensure Copy_L'Length > Right'Length
         Copy_Length : constant Natural :=
           Natural'Max (Left.Data.Size + 1, Right.Data.Size + 1);
         Copy_L      : Number (1 .. Copy_Length);
         Copy_R      : Number := Right.Data.Value;
         Index       : Natural := Copy_L'Last - Right.Data.Size;
         Mult        : Digit;
         Result      : Number (1 .. Index);
      begin
         Copy_L (1 .. Left.Data.Size) := Left.Data.Value;
         Copy_L (Left.Data.Size + 1 .. Copy_L'Last) := (others => 0);

         Normalize_For_Devide
           (Left   => Copy_L,
            Right  => Copy_R,
            Mult   => Mult);

         while Index >= 1 loop
            Devide
              (Left   => Copy_L (Index .. Index + Right.Data.Size),
               Right  => Copy_R,
               Result => Temp);

            if Last = 0 and Temp /= 0 then
               Last := Index;
            end if;

            Result (Index) := Temp;
            Index := Index - 1;
         end loop;

         return Wrap (Allocate (Result (1 .. Last)), Sign);
      end;
   end "/";

   ---------
   -- "=" --
   ---------

   function "=" (Left, Right : Unbounded_Integer) return Boolean is
      use type Matreshka.Unbounded_Naturals.Number;
   begin
      return Left.Negative = Right.Negative
        and then Left.Data.Value = Right.Data.Value;
   end "=";

   ---------
   -- ">" --
   ---------

   function ">" (Left, Right : Unbounded_Integer) return Boolean is
   begin
      return Right < Left;
   end ">";

   ---------
   -- "<" --
   ---------

   function "<" (Left, Right : Unbounded_Integer) return Boolean is
   begin
      if Left.Negative and Right.Negative then
         return not Matreshka.Unbounded_Naturals.Less
           (Left.Data.Value, Right.Data.Value);
      elsif not Left.Negative and not Right.Negative then
         return Matreshka.Unbounded_Naturals.Less
           (Left.Data.Value, Right.Data.Value);
      else
         return Left.Negative < Right.Negative;
      end if;
   end "<";

   ----------
   -- ">=" --
   ----------

   function ">=" (Left, Right : Unbounded_Integer) return Boolean is
   begin
      return not (Left < Right);
   end ">=";

   ----------
   -- "<=" --
   ----------

   function "<=" (Left, Right : Unbounded_Integer) return Boolean is
   begin
      return not (Right < Left);
   end "<=";

   -----------
   -- "abs" --
   -----------

   function "abs" (Left : Unbounded_Integer) return Unbounded_Integer is
   begin
      if Left.Negative then
         return Create (Left.Data, False);
      else
         return Left;
      end if;
   end "abs";

   -----------
   -- "mod" --
   -----------

   function "mod" (Left, Right : Unbounded_Integer) return Unbounded_Integer is
      Result : constant Unbounded_Integer := Left rem Right;
   begin
      if Left.Negative = Right.Negative
        or Result.Data = Shared_Zero'Access
      then
         return Result;
      else
         return Result + Right;
      end if;
   end "mod";

   -----------
   -- "rem" --
   -----------

   function "rem" (Left, Right : Unbounded_Integer) return Unbounded_Integer is
      use Matreshka.Unbounded_Naturals;

      Last : Natural;
      Temp : Digit;
   begin
      if Right.Data = Shared_Zero'Access then

         raise Constraint_Error;
      elsif Right.Data.Size = 1 then

         declare
            Result : Number (1 .. Left.Data.Size);
         begin
            Fast_Devide
              (Left   => Left.Data.Value,
               Right  => Right.Data.Value (1),
               Result => Result,
               Last   => Last,
               Rest   => Temp);

            return Wrap (Allocate ((1 => Temp)), Left.Negative);
         end;
      end if;

      declare
         --  Reserve one digit as space needed for normalization, then
         --  Make copy of Left and ensure Copy_L'Length > Right'Length
         Copy_Length : constant Natural :=
           Natural'Max (Left.Data.Size + 1, Right.Data.Size + 1);
         Copy_L      : Number (1 .. Copy_Length);
         Copy_R      : Number := Right.Data.Value;
         Index       : Natural := Copy_L'Last - Right.Data.Size;
         Mult        : Digit;
      begin
         Copy_L (1 .. Left.Data.Size) := Left.Data.Value;
         Copy_L (Left.Data.Size + 1 .. Copy_L'Last) := (others => 0);

         Normalize_For_Devide
           (Left   => Copy_L,
            Right  => Copy_R,
            Mult   => Mult);

         while Index >= 1 loop
            Devide
              (Left   => Copy_L (Index .. Index + Right.Data.Size),
               Right  => Copy_R,
               Result => Temp);

            Index := Index - 1;
         end loop;

         Fast_Devide
           (Left   => Copy_L (1 .. Right.Data.Size + 1),
            Right  => Mult,
            Result => Copy_L,
            Last   => Last,
            Rest   => Temp);

         return Wrap (Allocate (Copy_L (1 .. Last)), Left.Negative);
      end;
   end "rem";

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust
     (Self : in out Unbounded_Integer)
   is
      --  Data component is non-null by convention, this allows to suppress
      --  access check to improve performance.

      pragma Assert (Self.Data /= null);
      pragma Suppress (Access_Check);

   begin
      Reference (Self.Data);
   end Adjust;

   --------------
   -- Allocate --
   --------------

   function Allocate
     (Data     : Matreshka.Unbounded_Naturals.Number)
      return not null Shared_Number_Access is
   begin
      if Data'Length = 0 then

         return Shared_Zero'Access;
      end if;

      return new Shared_Number'(Size     => Data'Length,
                                Value    => Data,
                                others => <>);
   end Allocate;

   ------------
   -- Create --
   ------------

   function Create
    (Data     : Shared_Number_Access;
     Negative : Boolean)
       return Unbounded_Integer is
   begin
      Reference (Data);

      return Wrap (Data, Negative);
   end Create;

   -----------------
   -- Dereference --
   -----------------

   procedure Dereference (Self : in out Shared_Number_Access) is
      pragma Assert (Self /= null);
      pragma Suppress (Access_Check);

   begin
      if Self /= Shared_Zero'Access
        and then Matreshka.Atomics.Counters.Decrement (Self.Counter)
      then
         Free (Self);
      end if;

      Self := null;
   end Dereference;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Unbounded_Integer) is
      --  Finalize can be called more than once (as specified by language
      --  standard), thus implementation should provide protection from
      --  multiple finalization.
   begin
      if Self.Data /= null then
         Dereference (Self.Data);
      end if;
   end Finalize;

   -----------------
   -- Fit_Integer --
   -----------------

   function Fit_Integer (Left : Unbounded_Integer) return Boolean is
   begin
      return Matreshka.Unbounded_Naturals.Fit_Integer
        (Left.Data.Value, Left.Negative);
   end Fit_Integer;

   ------------------
   -- From_Integer --
   ------------------

   function From_Integer (Value : Integer) return Unbounded_Integer is
   begin
      return Wrap
        (Allocate ((1 => Matreshka.Unbounded_Naturals.Digit (abs Value))),
         Value < 0);
   end From_Integer;

   ---------------------------
   -- From_Universal_String --
   ---------------------------

   function From_Universal_String
     (Item : League.Strings.Universal_String;
      Base : Allowed_Base := 10) return Unbounded_Integer
   is
      Max_Size : constant Positive :=
        1 + Item.Length * 4 / Matreshka.Unbounded_Naturals.Digit'Size;
      Temp : Matreshka.Unbounded_Naturals.Number (1 .. Max_Size);
      Last : Natural;
   begin
      Matreshka.Unbounded_Naturals.Value
        (Item, Temp, Last, Matreshka.Unbounded_Naturals.Digit (Base));

      if Last = 0 then
         return Wrap (Shared_Zero'Access, Negative => False);
      end if;

      return Wrap (Allocate (Temp (1 .. Last)), Item.Starts_With ("-"));
   end From_Universal_String;

   ----------
   -- Read --
   ----------

   procedure Read
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : out Unbounded_Integer)
   is
      Length : Natural;

   begin
      if Stream.all in League.JSON.Streams.JSON_Stream'Class then
         declare
            Text : constant League.Strings.Universal_String :=
              League.Strings.Universal_String'Input (Stream);
         begin
            Item := From_Universal_String (Text);
         end;
      else
         --  Read length of the string.

         Natural'Read (Stream, Length);

         Dereference (Item.Data);

         if Length = 0 then
            --  Empty number, resuse shared zero object.

            Item.Data := Shared_Zero'Access;

         else

            Item.Data := new Shared_Number (Length);
            Boolean'Read (Stream, Item.Negative);
            Matreshka.Unbounded_Naturals.Number'Read (Stream, Item.Data.Value);
         end if;
      end if;
   end Read;

   ---------------
   -- Reference --
   ---------------

   procedure Reference (Self : not null Shared_Number_Access) is
   begin
      if Self /= Shared_Zero'Access then
         Matreshka.Atomics.Counters.Increment (Self.Counter);
      end if;
   end Reference;

   ----------------
   -- To_Integer --
   ----------------

   function To_Integer (Left : Unbounded_Integer) return Integer is
   begin
      return Matreshka.Unbounded_Naturals.To_Integer
        (Left.Data.Value, Left.Negative);
   end To_Integer;

   -------------------------
   -- To_Universal_String --
   -------------------------

   function To_Universal_String
     (Item : Unbounded_Integer;
      Base : Allowed_Base := 10)
        return League.Strings.Universal_String
   is
      Temp   : Matreshka.Unbounded_Naturals.Number := Item.Data.Value;
      Result : League.Strings.Universal_String;
   begin
      if Item.Negative then
         Result.Prepend ("-");
      end if;

      Matreshka.Unbounded_Naturals.Append_Image
        (Result, Temp, Matreshka.Unbounded_Naturals.Digit (Base));

      return Result;
   end To_Universal_String;

   ----------
   -- Wrap --
   ----------

   function Wrap
    (Data     : Shared_Number_Access;
     Negative : Boolean) return Unbounded_Integer is
   begin
      return (Ada.Finalization.Controlled with
                Data => Data, Negative => Negative);
   end Wrap;

   -----------
   -- Write --
   -----------

   procedure Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Unbounded_Integer) is
   begin
      if Stream.all in League.JSON.Streams.JSON_Stream'Class then
         League.JSON.Streams.JSON_Stream'Class (Stream.all).Write
          (League.JSON.Values.To_JSON_Value (Item.To_Universal_String));

      else
         --  Write length of the string into the stream.

         Natural'Write (Stream, Item.Data.Size);

         if Item.Data.Size /= 0 then
            Boolean'Write (Stream, Item.Negative);
            Matreshka.Unbounded_Naturals.Number'Write
             (Stream, Item.Data.Value);
         end if;
      end if;
   end Write;

end League.Unbounded_Integers;
