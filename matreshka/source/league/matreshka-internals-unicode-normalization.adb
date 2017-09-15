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
-- Copyright © 2009-2017, Vadim Godunko <vgodunko@gmail.com>                --
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
with Matreshka.Internals.Strings.Configuration;
with Matreshka.Internals.Strings.Operations;
with Matreshka.Internals.Unicode.Ucd.Norms;
with Matreshka.Internals.Unicode.Ucd.Properties;
with Matreshka.Internals.Utf16;

package body Matreshka.Internals.Unicode.Normalization is

   use Matreshka.Internals.Strings;
   use Matreshka.Internals.Strings.Configuration;
   use Matreshka.Internals.Strings.Operations;
   use Matreshka.Internals.Unicode.Ucd;
   use Matreshka.Internals.Unicode.Ucd.Properties;
   use Matreshka.Internals.Utf16;

   generic
      Form          : Normalization_Form;
      Decomposition : Decomposition_Kinds;

   procedure Generic_Decomposition
    (Source      : not null Matreshka.Internals.Strings.Shared_String_Access;
     Destination : in out Matreshka.Internals.Strings.Shared_String_Access);

   generic
      Form          : Normalization_Form;
      Decomposition : Decomposition_Kinds;

   procedure Generic_Decomposition_Composition
    (Source      : not null Matreshka.Internals.Strings.Shared_String_Access;
     Destination : in out Matreshka.Internals.Strings.Shared_String_Access);

   procedure Reorder_Last_Character
    (Destination : Shared_String_Access;
     First       : Utf16_String_Index;
     Unused      : Utf16_String_Index);
   --  Move last character in the string to follow Canonical Ordering.

   procedure Compose
    (Destination          : Shared_String_Access;
     Starter_Index        : Utf16_String_Index;
     Next_Starter_Index   : in out Utf16_String_Index;
     New_Starter_Composed : out Boolean);
   --  Do composition of one combined character starting from Starter_Index
   --  and up to end of string. Last character in the string must be last
   --  character in the data or next starting character. For Hangul Syllables
   --  this means the L, V pair composed to LV jamo, and on the next call,
   --  LV jamo composed to LVT jamo.

   -------------
   -- Compose --
   -------------

   procedure Compose
    (Destination          : Shared_String_Access;
     Starter_Index        : Utf16_String_Index;
     Next_Starter_Index   : in out Utf16_String_Index;
     New_Starter_Composed : out Boolean)
   is
      Index           : Utf16_String_Index := Starter_Index;
      Current         : Utf16_String_Index;
      Before          : Utf16_String_Index;
      Starter_Code    : Code_Point;
      Starter_Mapping : Sequence_Count;
      Starter_L       : Boolean;
      Starter_LV      : Boolean;
      New_Starter     : Code_Point;
      Current_Code    : Code_Point;
      Current_Mapping : Sequence_Count;
      Last_Class      : Canonical_Combining_Class := 0;
      Class           : Canonical_Combining_Class;

      procedure Replace_Starter_And_Pack;
      --  Replace starter character by new character and pack string data.

      ------------------------------
      -- Replace_Starter_And_Pack --
      ------------------------------

      procedure Replace_Starter_And_Pack is
         pragma Assert (Starter_Code <= 16#FFFF# xor Current_Code > 16#FFFF#);
         --  Change of the size of starter character in UTF-16 form is not
         --  supported.

      begin
         --  Save new starter.

         Index := Starter_Index;
         Unchecked_Store (Destination.Value, Index, New_Starter);

         --  Copy tail of the string.

         Destination.Value
          (Before .. Destination.Unused - 1 - (Current - Before)) :=
             Destination.Value (Current .. Destination.Unused - 1);

         --  Correct string's length and last index.

         if Current_Code <= 16#FFFF# then
            Destination.Unused := Destination.Unused - 1;
            Next_Starter_Index := Next_Starter_Index - 1;

         else
            Destination.Unused := Destination.Unused - 2;
            Next_Starter_Index := Next_Starter_Index - 2;
         end if;

         Destination.Length := Destination.Length - 1;

         Starter_Code := New_Starter;
      end Replace_Starter_And_Pack;

   begin
      New_Starter_Composed := False;

      Unchecked_Next (Destination.Value, Index, Starter_Code);
      Starter_Mapping :=
        Norms.Mapping
         (First_Stage_Index (Starter_Code / 16#100#))
         (Second_Stage_Index (Starter_Code mod 16#100#)).Composition.First;
      Starter_L := Starter_Code in L_Base .. L_Base + L_Count - 1;
      Starter_LV :=
        Starter_Code in Hangul_Syllable_First .. Hangul_Syllable_Last
          and then (Starter_Code - S_Base) mod T_Count = 0;

      Current := Index;

      if Starter_Mapping = 0 then
         if Current = Destination.Unused then
            return;

         elsif Starter_L then
            Before := Current;
            Unchecked_Next (Destination.Value, Current, Current_Code);

            if Current_Code not in V_Base .. V_Base + V_Count - 1 then
               return;
            end if;

            New_Starter :=
              S_Base
                + ((Starter_Code - L_Base) * V_Count + Current_Code - V_Base)
                    * T_Count;

            Replace_Starter_And_Pack;

            Current := Before;
            New_Starter_Composed := True;

         elsif Starter_LV then
            Before := Current;
            Unchecked_Next (Destination.Value, Current, Current_Code);

            if Current_Code not in T_Base .. T_Base + T_Count - 1 then
               return;
            end if;

            New_Starter := Starter_Code + Current_Code - T_Base;

            Replace_Starter_And_Pack;
            Current := Before;
            New_Starter_Composed := True;
         end if;

         return;
      end if;

      while Current < Destination.Unused loop
         Before := Current;
         Unchecked_Next (Destination.Value, Current, Current_Code);
         Current_Mapping :=
           Norms.Mapping
            (First_Stage_Index (Current_Code / 16#100#))
            (Second_Stage_Index (Current_Code mod 16#100#)).
               Composition.Last;
         Class := Get_CCC (Current_Code);

         if Current_Mapping /= 0
           and then ((Class = 0 and then Last_Class = 0)
                        or else (Last_Class < Class))
         then
            New_Starter :=
              Norms.Composition_Data (Starter_Mapping, Current_Mapping);

            if New_Starter /= 16#FFFF# then
               Replace_Starter_And_Pack;

               Current := Before;
               Starter_Mapping :=
                 Norms.Mapping
                  (First_Stage_Index (Starter_Code / 16#100#))
                  (Second_Stage_Index (Starter_Code mod 16#100#)).
                     Composition.First;

               if Class = 0 then
                  New_Starter_Composed := True;
               end if;

               exit when Starter_Mapping = 0;

            else
               Last_Class := Class;
            end if;

         else
            Last_Class := Class;
         end if;
      end loop;
   end Compose;

   ---------------------------
   -- Generic_Decomposition --
   ---------------------------

   procedure Generic_Decomposition
    (Source      : not null Matreshka.Internals.Strings.Shared_String_Access;
     Destination : in out Matreshka.Internals.Strings.Shared_String_Access)
   is
      type Starter_State is record
         D_Next : Utf16_String_Index := 0;
      end record;

      S_Index    : Utf16_String_Index := 0;
      Code       : Code_Point;
      Length     : Natural  := 0;
      Last_Class : Canonical_Combining_Class := 0;
      Class      : Canonical_Combining_Class;
      Starter    : Starter_State;

   begin
      if Source.Unused = 0 then
         Destination := Shared_Empty'Access;

         return;
      end if;

      --  Try to do Normalization Form quick check.

      declare
         S_Previous : Utf16_String_Index;

      begin
         while S_Index < Source.Unused loop
            S_Previous := S_Index;

            Unchecked_Next (Source.Value, S_Index, Code);
            Class := Get_CCC (Code);

            case Get_NQC (Code) (Form) is
               when No | Maybe =>
                  S_Index := S_Previous;

                  exit;

               when Yes =>
                  null;
            end case;

            if Class /= 0 then
               if Last_Class > Class then
                  --  Canonical Ordering is violated.

                  S_Index := S_Previous;

                  exit;
               end if;

            else
               Starter := (D_Next => S_Index);
            end if;

            Last_Class := Class;
            Length := Length + 1;
         end loop;
      end;

      if S_Index = Source.Unused then
         Destination := Source;
         Reference (Destination);

         return;
      end if;

      --  Source is not in Normalization Form probably, so start more complex
      --  algorithm.

      Destination := Allocate (Source.Capacity);

      if S_Index /= 0 then
         Destination.Value (0 .. S_Index - 1) :=
           Source.Value (0 .. S_Index - 1);
      end if;

      Destination.Unused := S_Index;
      Destination.Length := Length;

      while S_Index < Source.Unused loop
         Unchecked_Next (Source.Value, S_Index, Code);

         declare

            procedure Common_Append (Code : Code_Point);
            --  Common algorithm to append character exclude Hangul Syllable,
            --  decomposition and appending of which are done using special
            --  algorithm.

            -------------------
            -- Common_Append --
            -------------------

            procedure Common_Append (Code : Code_Point) is
            begin
               Class := Get_CCC (Code);
               Append (Destination, Code);

               if Class /= 0 then
                  if Last_Class > Class then
                     --  Canonical Ordering is violated, reorder result.

                     Reorder_Last_Character
                      (Destination, Starter.D_Next, Destination.Unused);

                  else
                     Last_Class := Class;
                  end if;

               else
                  Starter := (D_Next => Destination.Unused);
                  Last_Class := Class;
               end if;
            end Common_Append;

            M_First : constant Sequence_Count
              := Norms.Mapping
                  (First_Stage_Index (Code / 16#100#))
                  (Second_Stage_Index (Code mod 16#100#)).Decomposition
                    (Decomposition).First;
            M_Last  : constant Sequence_Count
              := Norms.Mapping
                  (First_Stage_Index (Code / 16#100#))
                  (Second_Stage_Index (Code mod 16#100#)).Decomposition
                    (Decomposition).Last;

         begin
            if M_First = 0 then
               if Code in Hangul_Syllable_First .. Hangul_Syllable_Last then
                  --  Special processing of precomposed Hangul Syllables

                  declare
                     C_Index : constant Code_Point := Code - S_Base;
                     L       : constant Code_Point
                       := L_Base + C_Index / N_Count;
                     V       : constant Code_Point
                       := V_Base + (C_Index mod N_Count) / T_Count;
                     T       : constant Code_Point
                       := T_Base + C_Index mod T_Count;

                  begin
                     Append (Destination, L);
                     Append (Destination, V);

                     if T /= T_Base then
                        Append (Destination, T);
                     end if;
                  end;

                  Starter := (D_Next => Destination.Unused);
                  Last_Class := 0;

               else
                  Common_Append (Code);
               end if;

            else
               for J in M_First .. M_Last loop
                  Common_Append (Norms.Decomposition_Data (J));
               end loop;
            end if;
         end;
      end loop;

      String_Handler.Fill_Null_Terminator (Destination);
   end Generic_Decomposition;

   ---------------------------------------
   -- Generic_Decomposition_Composition --
   ---------------------------------------

   procedure Generic_Decomposition_Composition
    (Source      : not null Matreshka.Internals.Strings.Shared_String_Access;
     Destination : in out Matreshka.Internals.Strings.Shared_String_Access)
   is

      type Starter_State is record
         D_Index  : Utf16_String_Index := 0;
         D_Next   : Utf16_String_Index := 0;
         D_Length : Natural            := 0;
      end record;

      S_Index         : Utf16_String_Index := 0;
      S_Previous      : Utf16_String_Index;
      Code            : Code_Point;
      Length          : Natural  := 0;
      Last_Class      : Canonical_Combining_Class := 0;
      Class           : Canonical_Combining_Class;
      Starter         : Starter_State;
      S_Starter       : Starter_State;
      C_Starter       : Starter_State;
      Composed        : Boolean := True;
      Fast            : Boolean := False;
      Starter_S_Index : Utf16_String_Index := 0;

   begin
      if Source.Unused = 0 then
         Destination := Shared_Empty'Access;

         return;
      end if;

      --  Try to do Normalization Form quick check.

      while S_Index < Source.Unused loop
         S_Previous := S_Index;

         Unchecked_Next (Source.Value, S_Index, Code);

         case Get_NQC (Code) (Form) is
            when No | Maybe =>
               S_Index := Starter_S_Index;
               Length  := Starter.D_Length;

               exit;

            when Yes =>
               null;
         end case;

         Class := Get_CCC (Code);

         if Class /= 0 then
            if Last_Class > Class then
               --  Canonical Ordering is violated.

               S_Index := Starter_S_Index;
               Length  := Starter.D_Length;

               exit;
            end if;

         else
            Starter_S_Index := S_Previous;
            Starter :=
             (D_Index  => S_Previous,
              D_Next   => S_Index,
              D_Length => Length);
         end if;

         Last_Class := Class;
         Length := Length + 1;
      end loop;

      if S_Index = Source.Unused then
         Destination := Source;
         Reference (Destination);

         return;
      end if;

      --  Source is not in Normalization Form probably, so start more complex
      --  algorithm.

      Destination := Allocate (Source.Capacity);

      if S_Index /= 0 then
         Destination.Value (0 .. S_Index - 1) :=
           Source.Value (0 .. S_Index - 1);
      end if;

      Destination.Unused := S_Index;
      Destination.Length := Length;

      while S_Index < Source.Unused loop
         S_Previous := S_Index;
         Unchecked_Next (Source.Value, S_Index, Code);

         declare

            procedure Common_Append (Code : Code_Point);
            --  Common algorithm to append character exclude Hangul Syllable,
            --  decomposition and appending of which are done using special
            --  algorithm.

            -------------------
            -- Common_Append --
            -------------------

            procedure Common_Append (Code : Code_Point) is
               D_Index : Utf16_String_Index := Destination.Unused;

            begin
               Class := Get_CCC (Code);
               Append (Destination, Code);

               if Class /= 0 then
                  if Composed then
                     Starter := C_Starter;
                     Last_Class := Class;
                     Composed := False;

                  elsif Last_Class > Class then
                     --  Canonical Ordering is violated, reorder result, but
                     --  only when previous starter was not composed, otherwise
                     --  reordering will break normalization.

                     Reorder_Last_Character
                      (Destination, Starter.D_Next, Destination.Unused);

                  else
                     Last_Class := Class;
                  end if;

               else
                  Compose (Destination, Starter.D_Index, D_Index, Composed);

                  if Composed then
                     C_Starter :=
                      (D_Index  => D_Index,
                       D_Next   => Destination.Unused,
                       D_Length => Destination.Length - 1);

                  else
                     Starter :=
                      (D_Index  => D_Index,
                       D_Next   => Destination.Unused,
                       D_Length => Destination.Length - 1);
                     Last_Class := Class;
                  end if;
               end if;
            end Common_Append;

            M_First : constant Sequence_Count
              := Norms.Mapping
                  (First_Stage_Index (Code / 16#100#))
                  (Second_Stage_Index (Code mod 16#100#)).Decomposition
                    (Decomposition).First;
            M_Last  : constant Sequence_Count
              := Norms.Mapping
                  (First_Stage_Index (Code / 16#100#))
                  (Second_Stage_Index (Code mod 16#100#)).Decomposition
                    (Decomposition).Last;

         begin
            --  Check does the current character not affected by current
            --  normalization form?

            if Fast then
               --  Fast mode: try to avoid decomposition and composition.

               if Get_NQC (Code) (Form) = Yes then
                  Common_Append (Code);

                  if Starter_S_Index /= S_Previous
                    and then Class = 0
                    and then not Composed
                  then
                     --  Just processed character is starter and never compose
                     --  with previous characters, thus we need to store
                     --  current position.

                     Starter_S_Index := S_Previous;
                     S_Starter := Starter;
                  end if;

               else
                  S_Index := Starter_S_Index;
                  Starter := S_Starter;
                  Fast := False;
                  Destination.Unused := Starter.D_Index;
                  Destination.Length := Starter.D_Length;
               end if;

            else
               if M_First = 0 then
                  --  There is no special processing for Hangul Syllables here:
                  --  they will be composed into the same character; and never
                  --  compose with the previous or following characters.

                  Common_Append (Code);

               else
                  for J in M_First .. M_Last loop
                     Common_Append (Norms.Decomposition_Data (J));
                  end loop;
               end if;

               if Starter_S_Index /= S_Previous
                 and then Code
                           not in Hangul_Syllable_First .. Hangul_Syllable_Last
                 and then Get_CCC (Code) = 0
                 and then Get_NQC (Code) (Form) = Yes
               then
                  --  Just processed character is starter and never compose
                  --  with previous characters, thus we can switch back to fast
                  --  mode.

                  Fast := True;
                  Starter_S_Index := S_Previous;
                  S_Starter := Starter;
               end if;
            end if;
         end;
      end loop;

      declare
         D_Index : Utf16_String_Index := Destination.Unused;

      begin
         Compose (Destination, Starter.D_Index, D_Index, Composed);
      end;

      String_Handler.Fill_Null_Terminator (Destination);
   end Generic_Decomposition_Composition;

   ---------
   -- NFC --
   ---------

   procedure NFC
    (Source      : not null Matreshka.Internals.Strings.Shared_String_Access;
     Destination : in out Matreshka.Internals.Strings.Shared_String_Access)
   is
      procedure Convert is
        new Generic_Decomposition_Composition (NFC, Canonical);

   begin
      Convert (Source, Destination);
   end NFC;

   ---------
   -- NFD --
   ---------

   procedure NFD
    (Source      : not null Matreshka.Internals.Strings.Shared_String_Access;
     Destination : in out Matreshka.Internals.Strings.Shared_String_Access)
   is
      procedure Convert is new Generic_Decomposition (NFD, Canonical);

   begin
      Convert (Source, Destination);
   end NFD;

   ----------
   -- NFKC --
   ----------

   procedure NFKC
    (Source      : not null Matreshka.Internals.Strings.Shared_String_Access;
     Destination : in out Matreshka.Internals.Strings.Shared_String_Access)
   is
      procedure Convert is
        new Generic_Decomposition_Composition (NFKC, Compatibility);

   begin
      Convert (Source, Destination);
   end NFKC;

   ----------
   -- NFKD --
   ----------

   procedure NFKD
    (Source      : not null Matreshka.Internals.Strings.Shared_String_Access;
     Destination : in out Matreshka.Internals.Strings.Shared_String_Access)
   is
      procedure Convert is new Generic_Decomposition (NFKD, Compatibility);

   begin
      Convert (Source, Destination);
   end NFKD;

   ----------------------------
   -- Reorder_Last_Character --
   ----------------------------

   procedure Reorder_Last_Character
    (Destination : Shared_String_Access;
     First       : Utf16_String_Index;
     Unused      : Utf16_String_Index)
   is
      Previous_Class : Canonical_Combining_Class;
      Class          : Canonical_Combining_Class;
      Previous       : Utf16_String_Index;
      Aux            : Utf16_String_Index;
      Current        : Utf16_String_Index;
      Code_A         : Code_Point;
      Code_B         : Code_Point;
      Restart        : Boolean;

   begin
      --  XXX It is more efficient to use backward bulk sort: all characters
      --  in the substring always sorted, so we need just to move last
      --  character to appropriate position.

      loop
         Restart := False;

         Current := First;
         Previous := Current;
         Unchecked_Next (Destination.Value, Current, Code_A);
         Previous_Class := Get_CCC (Code_A);

         while Current < Unused loop
            Aux := Current;
            Unchecked_Next (Destination.Value, Current, Code_B);
            Class := Get_CCC (Code_B);

            if Previous_Class > Class then
               Unchecked_Store (Destination.Value, Previous, Code_B);
               Current := Previous;
               Unchecked_Store (Destination.Value, Current, Code_A);
               Restart := True;

            else
               Previous_Class := Class;
               Previous := Aux;
               Code_A := Code_B;
            end if;
         end loop;

         exit when not Restart;
      end loop;
   end Reorder_Last_Character;

end Matreshka.Internals.Unicode.Normalization;
