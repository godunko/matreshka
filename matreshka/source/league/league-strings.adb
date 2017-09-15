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
with System;

with League.Characters.Internals;
with League.JSON.Streams;
with League.JSON.Values;
with League.Strings.Internals;
with League.String_Vectors.Internals;
with Matreshka.Internals.Locales;
with Matreshka.Internals.Strings.Configuration;
with Matreshka.Internals.Strings.Operations;
with Matreshka.Internals.String_Vectors;
with Matreshka.Internals.Stream_Element_Vectors;
with Matreshka.Internals.Text_Codecs.UTF16;
with Matreshka.Internals.Text_Codecs.UTF8;
with Matreshka.Internals.Unicode.Casing;
with Matreshka.Internals.Unicode.Collation;
with Matreshka.Internals.Unicode.Normalization;
with Matreshka.Internals.Unicode.Ucd;

package body League.Strings is

   use League.Strings.Internals;
   use Matreshka.Internals.String_Vectors;
   use Matreshka.Internals.Strings;
   use Matreshka.Internals.Strings.Configuration;
   use Matreshka.Internals.Strings.Operations;
   use Matreshka.Internals.Unicode;
   use Matreshka.Internals.Utf16;

   procedure To_Utf16_String
    (Source      : Wide_Wide_String;
     Destination : out Shared_String_Access);

   procedure Attach (Self : in out Abstract_Cursor'Class);
   --  Attaches cursor to the list of cursors of Universal_String.

   procedure Detach (Self : in out Abstract_Cursor'Class);
   --  Detaches cursor from the list of cursors of Universal_String. Also
   --  reset associated object to null.

   function From_Position
    (Item  : not null Matreshka.Internals.Strings.Shared_String_Access;
     Index : Positive) return Utf16_String_Index;
   --  Computes position of the character with given index in internal data.
   --  Returned position point to the first code unit of the character. Raises
   --  Constraint_Error when Index is out of range.

   function To_Position
    (Item  : not null Matreshka.Internals.Strings.Shared_String_Access;
     Index : Positive) return Utf16_String_Index;
   --  Computes position of the next character after given index in internal
   --  data. Raises Constraint_Error when Index is out of range.

   function Index
    (Item : not null Matreshka.Internals.Strings.Shared_String_Access;
     Code : Matreshka.Internals.Unicode.Code_Unit_32) return Natural;
   function Index
    (Item : not null Matreshka.Internals.Strings.Shared_String_Access;
     From : Positive;
     Code : Matreshka.Internals.Unicode.Code_Unit_32) return Natural;
   function Index
    (Item : not null Matreshka.Internals.Strings.Shared_String_Access;
     From : Positive;
     To   : Natural;
     Code : Matreshka.Internals.Unicode.Code_Unit_32) return Natural;
   --  Internal implementations to share common code.

   function Index
    (Item    : not null Matreshka.Internals.Strings.Shared_String_Access;
     Pattern : not null Matreshka.Internals.Strings.Shared_String_Access)
       return Natural;
   function Index
    (Item    : not null Matreshka.Internals.Strings.Shared_String_Access;
     From    : Positive;
     Pattern : not null Matreshka.Internals.Strings.Shared_String_Access)
       return Natural;
   function Index
    (Item    : not null Matreshka.Internals.Strings.Shared_String_Access;
     From    : Positive;
     To      : Natural;
     Pattern : not null Matreshka.Internals.Strings.Shared_String_Access)
       return Natural;
   --  Internal implementations to share common code.

   function Last_Index
    (Item : not null Matreshka.Internals.Strings.Shared_String_Access;
     Code : Matreshka.Internals.Unicode.Code_Unit_32) return Natural;
   function Last_Index
    (Item : not null Matreshka.Internals.Strings.Shared_String_Access;
     To   : Natural;
     Code : Matreshka.Internals.Unicode.Code_Unit_32) return Natural;
   function Last_Index
    (Item : not null Matreshka.Internals.Strings.Shared_String_Access;
     From : Positive;
     To   : Natural;
     Code : Matreshka.Internals.Unicode.Code_Unit_32) return Natural;
   --  Internal implementations to share common code.

   ---------
   -- "&" --
   ---------

   function "&"
    (Left  : Universal_String'Class;
     Right : Universal_String'Class) return Universal_String
   is
      L_D : constant not null Shared_String_Access := Left.Data;
      R_D : constant not null Shared_String_Access := Right.Data;

   begin
      if L_D.Length = 0 then
         return Universal_String (Right);

      elsif R_D.Length = 0 then
         return Universal_String (Left);

      else
         declare
            D : constant not null Shared_String_Access
              := Allocate (L_D.Unused + R_D.Unused);

         begin
            D.Value (0 .. L_D.Unused - 1) := L_D.Value (0 .. L_D.Unused - 1);
            D.Value (L_D.Unused .. L_D.Unused + R_D.Unused - 1) :=
              R_D.Value (0 .. R_D.Unused - 1);
            D.Unused := L_D.Unused + R_D.Unused;
            D.Length := L_D.Length + R_D.Length;
            String_Handler.Fill_Null_Terminator (D);

            return Wrap (D);
         end;
      end if;
   end "&";

   ---------
   -- "&" --
   ---------

   function "&"
    (Left  : Universal_String'Class;
     Right : League.Characters.Universal_Character'Class)
       return Universal_String is
   begin
      return Left & Right.To_Wide_Wide_Character;
   end "&";

   ---------
   -- "&" --
   ---------

   function "&"
    (Left  : League.Characters.Universal_Character'Class;
     Right : Universal_String'Class) return Universal_String is
   begin
      return Left.To_Wide_Wide_Character & Right;
   end "&";

   ---------
   -- "&" --
   ---------

   function "&"
    (Left  : Universal_String'Class;
     Right : Wide_Wide_Character) return Universal_String
   is
      L_D : constant not null Shared_String_Access := Left.Data;

   begin
      if not Is_Valid (Wide_Wide_Character'Pos (Right)) then
         raise Constraint_Error with "Illegal Unicode code point";
      end if;

      declare
         D : constant not null Shared_String_Access
           := Allocate (L_D.Unused + 1);
         P : Utf16_String_Index := L_D.Unused;

      begin
         if L_D.Unused /= 0 then
            D.Value (0 .. L_D.Unused - 1) := L_D.Value (0 .. L_D.Unused - 1);
         end if;

         Unchecked_Store (D.Value, P, Wide_Wide_Character'Pos (Right));
         D.Unused := P;
         D.Length := L_D.Length + 1;
         String_Handler.Fill_Null_Terminator (D);

         return Wrap (D);
      end;
   end "&";

   ---------
   -- "&" --
   ---------

   function "&"
    (Left  : Wide_Wide_Character;
     Right : Universal_String'Class) return Universal_String
   is
      R_D : constant not null Shared_String_Access := Right.Data;

   begin
      if not Is_Valid (Wide_Wide_Character'Pos (Left)) then
         raise Constraint_Error with "Illegal Unicode code point";
      end if;

      declare
         D : constant not null Shared_String_Access
           := Allocate (R_D.Unused + 1);
         P : Utf16_String_Index := 0;

      begin
         Unchecked_Store (D.Value, P, Wide_Wide_Character'Pos (Left));

         if R_D.Unused /= 0 then
            D.Value (P .. P + R_D.Unused - 1) :=
              R_D.Value (0 .. R_D.Unused - 1);
         end if;

         D.Unused := P + R_D.Unused;
         D.Length := R_D.Length + 1;
         String_Handler.Fill_Null_Terminator (D);

         return Wrap (D);
      end;
   end "&";

   ---------
   -- "&" --
   ---------

   function "&"
    (Left  : Universal_String'Class;
     Right : Wide_Wide_String) return Universal_String is
   begin
      return Left & To_Universal_String (Right);
   end "&";

   ---------
   -- "&" --
   ---------

   function "&"
    (Left  : Wide_Wide_String;
     Right : Universal_String'Class) return Universal_String is
   begin
      return To_Universal_String (Left) & Right;
   end "&";

   ---------
   -- "<" --
   ---------

   function "<"
    (Left : Universal_String; Right : Universal_String) return Boolean
   is
      L_D : constant not null Shared_String_Access := Left.Data;
      R_D : constant not null Shared_String_Access := Right.Data;

   begin
      return String_Handler.Is_Less (L_D, R_D);
   end "<";

   ---------
   -- "<" --
   ---------

   function "<" (Left : Sort_Key; Right : Sort_Key) return Boolean is
      L_D : constant Shared_Sort_Key_Access := Left.Data;
      R_D : constant Shared_Sort_Key_Access := Right.Data;

   begin
      return
        L_D /= R_D
          and then L_D.Data (1 .. L_D.Last) < R_D.Data (1 .. R_D.Last);
   end "<";

   ----------
   -- "<=" --
   ----------

   function "<="
    (Left : Universal_String; Right : Universal_String) return Boolean
   is
      L_D : constant not null Shared_String_Access := Left.Data;
      R_D : constant not null Shared_String_Access := Right.Data;

   begin
      return String_Handler.Is_Less_Or_Equal (L_D, R_D);
   end "<=";

   ----------
   -- "<=" --
   ----------

   function "<=" (Left : Sort_Key; Right : Sort_Key) return Boolean is
      L_D : constant Shared_Sort_Key_Access := Left.Data;
      R_D : constant Shared_Sort_Key_Access := Right.Data;

   begin
      return
        L_D = R_D
          or else L_D.Data (1 .. L_D.Last) <= R_D.Data (1 .. R_D.Last);
   end "<=";

   ---------
   -- "=" --
   ---------

   overriding function "="
    (Left : Universal_String; Right : Universal_String) return Boolean
   is
      --  Data component of Universal_String as well as String_Handler are
      --  non-null always by convention. Access check is suppressed to improve
      --  performance and replaced by corresponding assertions.

      pragma Assert (Left.Data /= null);
      pragma Assert (Right.Data /= null);
      pragma Assert (String_Handler /= null);

      pragma Suppress (Access_Check);

      L_D : constant not null Shared_String_Access := Left.Data;
      R_D : constant not null Shared_String_Access := Right.Data;

   begin
      return String_Handler.Is_Equal (L_D, R_D);
   end "=";

   ---------
   -- "=" --
   ---------

   overriding function "="
    (Left : Sort_Key; Right : Sort_Key) return Boolean
   is
      L_D : constant Shared_Sort_Key_Access := Left.Data;
      R_D : constant Shared_Sort_Key_Access := Right.Data;

   begin
      return
        L_D = R_D
          or else L_D.Data (1 .. L_D.Last) = R_D.Data (1 .. R_D.Last);
   end "=";

   ---------
   -- ">" --
   ---------

   function ">"
    (Left : Universal_String; Right : Universal_String) return Boolean
   is
      L_D : constant not null Shared_String_Access := Left.Data;
      R_D : constant not null Shared_String_Access := Right.Data;

   begin
      return String_Handler.Is_Greater (L_D, R_D);
   end ">";

   ---------
   -- ">" --
   ---------

   function ">" (Left : Sort_Key; Right : Sort_Key) return Boolean is
      L_D : constant Shared_Sort_Key_Access := Left.Data;
      R_D : constant Shared_Sort_Key_Access := Right.Data;

   begin
      return
        L_D /= R_D
          and then L_D.Data (1 .. L_D.Last) > R_D.Data (1 .. R_D.Last);
   end ">";

   ----------
   -- ">=" --
   ----------

   function ">="
    (Left : Universal_String; Right : Universal_String) return Boolean
   is
      L_D : constant not null Shared_String_Access := Left.Data;
      R_D : constant not null Shared_String_Access := Right.Data;

   begin
      return String_Handler.Is_Greater_Or_Equal (L_D, R_D);
   end ">=";

   ----------
   -- ">=" --
   ----------

   function ">=" (Left : Sort_Key; Right : Sort_Key) return Boolean is
      L_D : constant Shared_Sort_Key_Access := Left.Data;
      R_D : constant Shared_Sort_Key_Access := Right.Data;

   begin
      return
        L_D = R_D
          or else L_D.Data (1 .. L_D.Last) >= R_D.Data (1 .. R_D.Last);
   end ">=";

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Abstract_Cursor) is
   begin
      Self.Next     := null;
      Self.Previous := null;

      if Self.Object /= null then
         Attach (Self);
      end if;
   end Adjust;

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Sort_Key) is
   begin
      Reference (Self.Data);
   end Adjust;

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Universal_String) is
      --  Data component is non-null by convention, this allows to suppress
      --  access check to improve performance.

      pragma Assert (Self.Data /= null);
      pragma Suppress (Access_Check);

   begin
      Reference (Self.Data);
      Self.List    := (Head => null);
      Self.Cursors := Self.List'Unchecked_Access;
   end Adjust;

   ------------
   -- Append --
   ------------

   procedure Append
    (Self : in out Universal_String'Class; Item : Universal_String'Class)
   is
      P : constant Utf16_String_Index := Self.Data.Unused;

   begin
      Append (Self.Data, Item.Data);
      Emit_Changed (Self, P, Utf16_String_Index'Last, Self.Data.Unused - 1);
   end Append;

   ------------
   -- Append --
   ------------

   procedure Append
    (Self : in out Universal_String'Class;
     Item : League.Characters.Universal_Character'Class)
   is
      P : constant Utf16_String_Index := Self.Data.Unused;
      C : constant Matreshka.Internals.Unicode.Code_Unit_32
        := League.Characters.Internals.Internal (Item);

   begin
      if not Is_Valid (C) then
         raise Constraint_Error with "Illegal Unicode code point";
      end if;

      Append (Self.Data, C);
      Emit_Changed (Self, P, Utf16_String_Index'Last, Self.Data.Unused - 1);
   end Append;

   ------------
   -- Append --
   ------------

   procedure Append
    (Self : in out Universal_String'Class; Item : Wide_Wide_String) is
   begin
      Self.Append (To_Universal_String (Item));
   end Append;

   ------------
   -- Append --
   ------------

   procedure Append
    (Self : in out Universal_String'Class; Item : Wide_Wide_Character)
   is
      P : constant Utf16_String_Index := Self.Data.Unused;

   begin
      if not Is_Valid (Wide_Wide_Character'Pos (Item)) then
         raise Constraint_Error with "Illegal Unicode code point";
      end if;

      Append (Self.Data, Wide_Wide_Character'Pos (Item));
      Emit_Changed (Self, P, Utf16_String_Index'Last, Self.Data.Unused - 1);
   end Append;

   ------------
   -- Attach --
   ------------

   procedure Attach (Self : in out Abstract_Cursor'Class) is
   begin
      Self.Next                := Self.Object.Cursors.Head;
      Self.Object.Cursors.Head := Self'Unchecked_Access;

      if Self.Next /= null then
         Self.Next.Previous := Self'Unchecked_Access;
      end if;
   end Attach;

   ------------
   -- Attach --
   ------------

   procedure Attach
    (Self : in out Abstract_Cursor'Class; Item : in out Universal_String'Class)
   is
   begin
      if Self.Object /= Item'Unchecked_Access then
         Detach (Self);
         Self.Object := Item'Unchecked_Access;
         Attach (Self);
      end if;
   end Attach;

   -----------
   -- Clear --
   -----------

   procedure Clear (Self : in out Universal_String'Class) is
   begin
      Matreshka.Internals.Strings.Dereference (Self.Data);
      Self.Data := Matreshka.Internals.Strings.Shared_Empty'Access;
   end Clear;

   ---------------
   -- Collation --
   ---------------

   function Collation (Self : Universal_String'Class) return Sort_Key is
      Data   : Shared_String_Access;
      Locale : Matreshka.Internals.Locales.Locale_Data_Access;

   begin
      Matreshka.Internals.Unicode.Normalization.NFD (Self.Data, Data);
      Locale := Matreshka.Internals.Locales.Get_Locale;

      return Result : constant Sort_Key
        := (Ada.Finalization.Controlled
              with Data =>
                     Matreshka.Internals.Unicode.Collation.Construct_Sort_Key
                      (Locale, Data))
      do
         Dereference (Data);
         Matreshka.Internals.Locales.Dereference (Locale);
      end return;
   end Collation;

   ----------
   -- Copy --
   ----------

--   function Copy (Source : not null String_Private_Data_Access)
--     return not null String_Private_Data_Access
--   is
--   begin
--      return Result : not null String_Private_Data_Access
--        := Create
--            (new Utf16_String'(Source.Value.all),
--             Source.Last,
--             Source.Length,
--             Source.Index_Mode)
--      do
--         if Source.Index_Map /= null then
--            Result.Index_Map := new Index_Map'(Source.Index_Map.all);
--         end if;
--      end return;
--   end Copy;

   -----------
   -- Count --
   -----------

   function Count
    (Self      : Universal_String'Class;
     Character : League.Characters.Universal_Character'Class) return Natural
   is
      C : constant Matreshka.Internals.Unicode.Code_Unit_32
        := League.Characters.Internals.Internal (Character);

   begin
      if not Is_Valid (C) then
         raise Constraint_Error with "Illegal Unicode code point";
      end if;

      return String_Handler.Count (Self.Data, C);
   end Count;

   -----------
   -- Count --
   -----------

   function Count
    (Self      : Universal_String'Class;
     Character : Wide_Wide_Character) return Natural
   is
      Code : constant Code_Unit_32 := Wide_Wide_Character'Pos (Character);

   begin
      if not Is_Valid (Code) then
         raise Constraint_Error with "Illegal Unicode code point";
      end if;

      return String_Handler.Count (Self.Data, Code);
   end Count;

   ------------
   -- Detach --
   ------------

   procedure Detach (Self : in out Abstract_Cursor'Class) is
   begin
      if Self.Object /= null then
         if Self.Next /= null then
            Self.Next.Previous := Self.Previous;
         end if;

         if Self.Previous /= null then
            Self.Previous.Next := Self.Next;

         elsif Self.Object.Cursors.Head = Self'Unchecked_Access then
            Self.Object.Cursors.Head := Self.Next;
         end if;
      end if;

      Self.Next     := null;
      Self.Previous := null;
      Self.Object   := null;
   end Detach;

   -------------
   -- Element --
   -------------

   function Element
    (Self  : Universal_String'Class;
     Index : Positive) return League.Characters.Universal_Character
   is
      D : constant Shared_String_Access := Self.Data;

   begin
      if Index > D.Length then
         raise Constraint_Error with "Index is out of range";
      end if;

      if D.Unused = Utf16_String_Index (D.Length) then
         return
           League.Characters.Internals.Create
            (Code_Unit_32 (D.Value (Utf16_String_Index (Index - 1))));

      else
         return
           League.Characters.Internals.Create
            (Unchecked_To_Code_Point (D.Value, From_Position (D, Index)));
      end if;
   end Element;

   ------------------
   -- Emit_Changed --
   ------------------

   procedure Emit_Changed
    (Self          : Universal_String'Class;
     Changed_First : Matreshka.Internals.Utf16.Utf16_String_Index;
     Removed_Last  : Matreshka.Internals.Utf16.Utf16_String_Index;
     Inserted_Last : Matreshka.Internals.Utf16.Utf16_String_Index)
   is
      Current : Cursor_Access := Self.Cursors.Head;
      Next    : Cursor_Access;

   begin
      while Current /= null loop
         Next := Current.Next;
--         Current.On_Changed (Changed_First, Removed_Last, Inserted_Last);
         Current := Next;
      end loop;
   end Emit_Changed;

--   procedure Emit_Changed
--    (Self          : not null String_Private_Data_Access;
--     Cursor        : not null Modify_Cursor_Access;
--     Changed_First : Positive;
--     Removed_Last  : Natural;
--     Inserted_Last : Natural)
--   is
--      Current : Modify_Cursor_Access := Self.Cursors;
--      Next    : Modify_Cursor_Access := Current.Next;
--
--   begin
--      loop
--         if Current /= Cursor then
--            Current.On_Changed (Changed_First, Removed_Last, Inserted_Last);
--         end if;
--
--         exit when Next = null;
--
--         Current := Next;
--         Next    := Current.Next;
--      end loop;
--   end Emit_Changed;

   ---------------
   -- Ends_With --
   ---------------

   function Ends_With
    (Self    : Universal_String'Class;
     Pattern : Universal_String'Class) return Boolean is
   begin
      return
        Self.Length >= Pattern.Length
          and then Self.Slice (Self.Length - Pattern.Length + 1, Self.Length)
                     = Universal_String (Pattern);
   end Ends_With;

   ---------------
   -- Ends_With --
   ---------------

   function Ends_With
    (Self    : Universal_String'Class;
     Pattern : Wide_Wide_String) return Boolean is
   begin
      return Self.Ends_With (To_Universal_String (Pattern));
   end Ends_With;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Abstract_Cursor) is
   begin
      Detach (Self);
   end Finalize;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Sort_Key) is
   begin
      --  Finalize can be called more than once (as specified by language
      --  standard), thus implementation should provide protection from
      --  multiple finalization.

      if Self.Data /= null then
         Dereference (Self.Data);
      end if;
   end Finalize;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Universal_String) is

      pragma Suppress (Access_Check);
      --  Compiler generates access check for Self.Cursor which is known to be
      --  non-null by convention.

      Current : Cursor_Access;
      Next    : Cursor_Access;

   begin
      --  Finalize can be called more than once (as specified by language
      --  standard), thus implementation should provide protection from
      --  multiple finalization.

      if Self.Data /= null then
         Current := Self.Cursors.Head;

         while Current /= null loop
            Next := Current.Next;
            Detach (Current.all);
            Current := Next;
         end loop;

         Dereference (Self.Data);
      end if;
   end Finalize;

   -------------------
   -- From_Position --
   -------------------

   function From_Position
    (Item  : not null Matreshka.Internals.Strings.Shared_String_Access;
     Index : Positive) return Utf16_String_Index
   is
      Map : Index_Map_Access;

   begin
      if Index > Item.Length then
         raise Constraint_Error with "Index is out of range";
      end if;

      if Index = 1 then
         return 0;
      end if;

      if Item.Unused = Utf16_String_Index (Item.Length) then
         return Utf16_String_Index (Index - 1);

      elsif Item.Unused = Utf16_String_Index (Item.Length) * 2 then
         return Utf16_String_Index (Index - 1) * 2;

      else
         Map := Item.Index_Map;

         --  Calculate index map if it is unavailable for now.

         if Map = null then
            Compute_Index_Map (Item.all);
            Map := Item.Index_Map;
         end if;

         return Map.Map (Utf16_String_Index (Index - 1));
      end if;
   end From_Position;

   -----------------------------
   -- From_UTF_16_Wide_String --
   -----------------------------

   function From_UTF_16_Wide_String
    (Item : Ada.Strings.UTF_Encoding.UTF_16_Wide_String)
       return Universal_String
   is
      use type Ada.Streams.Stream_Element_Offset;
      use System;

      Data    : constant
        Ada.Streams.Stream_Element_Array (1 .. Item'Length * 2);
      for Data'Address use Item'Address;
      pragma Import (Ada, Data);
      Aux     : Shared_String_Access;

   begin
      if Default_Bit_Order = High_Order_First then
         declare
            Decoder : Matreshka.Internals.Text_Codecs.UTF16.UTF16BE_Decoder;

         begin
            Decoder.Decode (Data, Aux);

            if Decoder.Is_Mailformed then
               Dereference (Aux);

               raise Constraint_Error with "Illegal UTF16BE data";
            end if;
         end;

      else
         declare
            Decoder : Matreshka.Internals.Text_Codecs.UTF16.UTF16LE_Decoder;

         begin
            Decoder.Decode (Data, Aux);

            if Decoder.Is_Mailformed then
               Dereference (Aux);

               raise Constraint_Error with "Illegal UTF16LE data";
            end if;
         end;
      end if;

      return Wrap (Aux);
   end From_UTF_16_Wide_String;

   -----------------------
   -- From_UTF_8_String --
   -----------------------

   function From_UTF_8_String
    (Item : Ada.Strings.UTF_Encoding.UTF_8_String) return Universal_String
   is
      Data    : constant Ada.Streams.Stream_Element_Array (1 .. Item'Length);
      for Data'Address use Item'Address;
      pragma Import (Ada, Data);
      Decoder : Matreshka.Internals.Text_Codecs.UTF8.UTF8_Decoder;
      Aux     : Shared_String_Access;

   begin
      Decoder.Decode (Data, Aux);

      if Decoder.Is_Mailformed then
         Dereference (Aux);

         raise Constraint_Error with "Illegal UTF8 data";
      end if;

      return Wrap (Aux);
   end From_UTF_8_String;

   ----------
   -- Hash --
   ----------

   function Hash (Self : Universal_String'Class) return League.Hash_Type is
   begin
      return Hash (Self.Data);
   end Hash;

   ----------
   -- Head --
   ----------

   function Head
    (Self  : Universal_String'Class;
     Count : Natural) return Universal_String is
   begin
      if Count > Self.Length then
         raise Constraint_Error with "String is too small";

      elsif Count = 0 then
         return Empty_Universal_String;

      else
         return Self.Slice (1, Count);
      end if;
   end Head;

   -----------
   -- Index --
   -----------

   function Index
    (Item : not null Matreshka.Internals.Strings.Shared_String_Access;
     Code : Matreshka.Internals.Unicode.Code_Unit_32) return Natural
   is
      --  String_Handler is not null by convention, access check can be
      --  suppressed.
      pragma Assert (String_Handler /= null);
      pragma Suppress (Access_Check);

      --  Code is tested to be in range, range check can be suppressed.
      pragma Suppress (Range_Check);

   begin
      if not Is_Valid (Code) then
         raise Constraint_Error with "Illegal Unicode code point";
      end if;

      if Item.Length = 0 then
         --  Empty string doesn't contains any character.

         return 0;
      end if;

      return String_Handler.Index (Item, 1, 0, Item.Unused, Code);
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Item : not null Matreshka.Internals.Strings.Shared_String_Access;
     From : Positive;
     Code : Matreshka.Internals.Unicode.Code_Unit_32) return Natural
   is
      --  String_Handler is not null by convention, access check can be
      --  suppressed.
      pragma Assert (String_Handler /= null);
      pragma Suppress (Access_Check);

      --  Code is tested to be in range, range check can be suppressed.
      pragma Suppress (Range_Check);

   begin
      if not Is_Valid (Code) then
         raise Constraint_Error with "Illegal Unicode code point";
      end if;

      if From > Item.Length then
         --  Empty slice, there are no characters in it.

         return 0;
      end if;

      return
        String_Handler.Index
         (Item, From, From_Position (Item, From), Item.Unused, Code);
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Item : not null Matreshka.Internals.Strings.Shared_String_Access;
     From : Positive;
     To   : Natural;
     Code : Matreshka.Internals.Unicode.Code_Unit_32) return Natural
   is
      --  String_Handler is not null by convention, access check can be
      --  suppressed.
      pragma Assert (String_Handler /= null);
      pragma Suppress (Access_Check);

      --  Code is tested to be in range, range check can be suppressed.
      pragma Suppress (Range_Check);

   begin
      if not Is_Valid (Code) then
         raise Constraint_Error with "Illegal Unicode code point";
      end if;

      if From > To then
         --  Empty slice specified.

         return 0;
      end if;

      return
        String_Handler.Index
         (Item,
          From,
          From_Position (Item, From),
          To_Position (Item, To),
          Code);
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Item    : not null Matreshka.Internals.Strings.Shared_String_Access;
     Pattern : not null Matreshka.Internals.Strings.Shared_String_Access)
       return Natural
   is
      --  String_Handler is not null by convention, access check can be
      --  suppressed.
      pragma Assert (String_Handler /= null);
      pragma Suppress (Access_Check);

      --  Everything is tested to be in range, range check can be suppressed.
      pragma Suppress (Range_Check);


   begin
      if Item.Length = 0 then
         --  Empty string doesn't match any pattern.

         return 0;
      end if;

      return String_Handler.Index (Item, 1, 0, Item.Unused, Pattern);
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Item    : not null Matreshka.Internals.Strings.Shared_String_Access;
     From    : Positive;
     Pattern : not null Matreshka.Internals.Strings.Shared_String_Access)
       return Natural
   is
      --  String_Handler is not null by convention, access check can be
      --  suppressed.
      pragma Assert (String_Handler /= null);
      pragma Suppress (Access_Check);

      --  Everything is tested to be in range, range check can be suppressed.
      pragma Suppress (Range_Check);

   begin
      if From > Item.Length then
         --  Empty slice specified.

         return 0;
      end if;

      return
        String_Handler.Index
         (Item, From, From_Position (Item, From), Item.Unused, Pattern);
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Item    : not null Matreshka.Internals.Strings.Shared_String_Access;
     From    : Positive;
     To      : Natural;
     Pattern : not null Matreshka.Internals.Strings.Shared_String_Access)
       return Natural
   is
      --  String_Handler is not null by convention, access check can be
      --  suppressed.
      pragma Assert (String_Handler /= null);
      pragma Suppress (Access_Check);

      --  Everything is tested to be in range, range check can be suppressed.
      pragma Suppress (Range_Check);

   begin
      if Item.Length = 0 then
         --  Empty string doesn't match any pattern.

         return 0;

      elsif From > To then
         --  Empty slice specified.

         return 0;
      end if;

      return
        String_Handler.Index
         (Item,
          From,
          From_Position (Item, From),
          To_Position (Item, To),
          Pattern);
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Self      : Universal_String'Class;
     Character : League.Characters.Universal_Character'Class) return Natural
   is
      --  Data component is non-null by convention, this allows to suppress
      --  access check to improve performance.

      pragma Assert (Self.Data /= null);
      pragma Suppress (Access_Check);

   begin
      return
        Index (Self.Data, League.Characters.Internals.Internal (Character));
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Self      : Universal_String'Class;
     Character : Wide_Wide_Character) return Natural
   is
      --  Data component is non-null by convention, this allows to suppress
      --  access check to improve performance.

      pragma Assert (Self.Data /= null);
      pragma Suppress (Access_Check);

   begin
      return Index (Self.Data, Wide_Wide_Character'Pos (Character));
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Self      : Universal_String'Class;
     From      : Positive;
     Character : League.Characters.Universal_Character'Class) return Natural
   is
      --  Data component is non-null by convention, this allows to suppress
      --  access check to improve performance.

      pragma Assert (Self.Data /= null);
      pragma Suppress (Access_Check);

   begin
      return
        Index
         (Self.Data, From, League.Characters.Internals.Internal (Character));
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Self      : Universal_String'Class;
     From      : Positive;
     Character : Wide_Wide_Character) return Natural
   is
      --  Data component is non-null by convention, this allows to suppress
      --  access check to improve performance.

      pragma Assert (Self.Data /= null);
      pragma Suppress (Access_Check);

   begin
      return Index (Self.Data, From, Wide_Wide_Character'Pos (Character));
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Self      : Universal_String'Class;
     From      : Positive;
     To        : Natural;
     Character : League.Characters.Universal_Character'Class) return Natural
   is
      --  Data component is non-null by convention, this allows to suppress
      --  access check to improve performance.

      pragma Assert (Self.Data /= null);
      pragma Suppress (Access_Check);

   begin
      return
        Index
         (Self.Data,
          From,
          To,
          League.Characters.Internals.Internal (Character));
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Self      : Universal_String'Class;
     From      : Positive;
     To        : Natural;
     Character : Wide_Wide_Character) return Natural
   is
      --  Data component is non-null by convention, this allows to suppress
      --  access check to improve performance.

      pragma Assert (Self.Data /= null);
      pragma Suppress (Access_Check);

   begin
      return Index (Self.Data, From, To, Wide_Wide_Character'Pos (Character));
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Self    : Universal_String'Class;
     Pattern : Universal_String'Class) return Natural is
   begin
      return Index (Self.Data, Pattern.Data);
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Self    : Universal_String'Class;
     Pattern : Wide_Wide_String) return Natural
   is
      Aux : constant Universal_String := To_Universal_String (Pattern);

   begin
      return Index (Self.Data, Aux.Data);
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Self    : Universal_String'Class;
     From    : Positive;
     Pattern : Universal_String'Class) return Natural is
   begin
      return Index (Self.Data, From, Pattern.Data);
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Self    : Universal_String'Class;
     From    : Positive;
     Pattern : Wide_Wide_String) return Natural
   is
      Aux : constant Universal_String := To_Universal_String (Pattern);

   begin
      return Index (Self.Data, From, Aux.Data);
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Self    : Universal_String'Class;
     From    : Positive;
     To      : Natural;
     Pattern : Universal_String'Class) return Natural is
   begin
      return Index (Self.Data, From, To, Pattern.Data);
   end Index;

   -----------
   -- Index --
   -----------

   function Index
    (Self    : Universal_String'Class;
     From    : Positive;
     To      : Natural;
     Pattern : Wide_Wide_String) return Natural
   is
      Aux : constant Universal_String := To_Universal_String (Pattern);

   begin
      return Index (Self.Data, From, To, Aux.Data);
   end Index;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out Universal_String) is
   begin
      Self.List := (Head => null);
      Self.Cursors := Self.List'Unchecked_Access;
   end Initialize;

   --------------
   -- Is_Empty --
   --------------

   function Is_Empty (Self : Universal_String'Class) return Boolean is
   begin
      return Self.Data.Length = 0;
   end Is_Empty;

   ----------------
   -- Last_Index --
   ----------------

   function Last_Index
    (Item : not null Matreshka.Internals.Strings.Shared_String_Access;
     Code : Matreshka.Internals.Unicode.Code_Unit_32) return Natural
   is
      --  String_Handler is not null by convention, access check can be
      --  suppressed.
      pragma Assert (String_Handler /= null);
      pragma Suppress (Access_Check);

      --  Code is tested to be in range, range check can be suppressed.
      pragma Suppress (Range_Check);

   begin
      if not Is_Valid (Code) then
         raise Constraint_Error with "Illegal Unicode code point";
      end if;

      if Item.Length = 0 then
         --  Empty string doesn't contains any character.

         return 0;
      end if;

      return
        String_Handler.Last_Index (Item, 0, Item.Length, Item.Unused, Code);
   end Last_Index;

   ----------------
   -- Last_Index --
   ----------------

   function Last_Index
    (Item : not null Matreshka.Internals.Strings.Shared_String_Access;
     To   : Natural;
     Code : Matreshka.Internals.Unicode.Code_Unit_32) return Natural
   is
      --  String_Handler is not null by convention, access check can be
      --  suppressed.
      pragma Assert (String_Handler /= null);
      pragma Suppress (Access_Check);

      --  Code is tested to be in range, range check can be suppressed.
      pragma Suppress (Range_Check);

   begin
      if not Is_Valid (Code) then
         raise Constraint_Error with "Illegal Unicode code point";
      end if;

      return
        String_Handler.Last_Index (Item, 0, To, To_Position (Item, To), Code);
   end Last_Index;

   ----------------
   -- Last_Index --
   ----------------

   function Last_Index
    (Item : not null Matreshka.Internals.Strings.Shared_String_Access;
     From : Positive;
     To   : Natural;
     Code : Matreshka.Internals.Unicode.Code_Unit_32) return Natural
   is
      --  String_Handler is not null by convention, access check can be
      --  suppressed.
      pragma Assert (String_Handler /= null);
      pragma Suppress (Access_Check);

      --  Code is tested to be in range, range check can be suppressed.
      pragma Suppress (Range_Check);

   begin
      if not Is_Valid (Code) then
         raise Constraint_Error with "Illegal Unicode code point";
      end if;

      if From > To then
         --  Empty slice selected.

         return 0;
      end if;

      return
        String_Handler.Last_Index
         (Item, From_Position (Item, From), To, To_Position (Item, To), Code);
   end Last_Index;

   ----------------
   -- Last_Index --
   ----------------

   function Last_Index
    (Self      : Universal_String'Class;
     Character : League.Characters.Universal_Character'Class) return Natural is
   begin
      return
        Last_Index
         (Self.Data, League.Characters.Internals.Internal (Character));
   end Last_Index;

   ----------------
   -- Last_Index --
   ----------------

   function Last_Index
    (Self      : Universal_String'Class;
     Character : Wide_Wide_Character) return Natural is
   begin
      return Last_Index (Self.Data, Wide_Wide_Character'Pos (Character));
   end Last_Index;

   ----------------
   -- Last_Index --
   ----------------

   function Last_Index
    (Self      : Universal_String'Class;
     To        : Natural;
     Character : League.Characters.Universal_Character'Class) return Natural is
   begin
      return
        Last_Index
         (Self.Data, To, League.Characters.Internals.Internal (Character));
   end Last_Index;

   ----------------
   -- Last_Index --
   ----------------

   function Last_Index
    (Self      : Universal_String'Class;
     To        : Natural;
     Character : Wide_Wide_Character) return Natural is
   begin
      return Last_Index (Self.Data, To, Wide_Wide_Character'Pos (Character));
   end Last_Index;

   ----------------
   -- Last_Index --
   ----------------

   function Last_Index
    (Self      : Universal_String'Class;
     From      : Positive;
     To        : Natural;
     Character : League.Characters.Universal_Character'Class) return Natural is
   begin
      return
        Last_Index
         (Self.Data,
          From,
          To,
          League.Characters.Internals.Internal (Character));
   end Last_Index;

   ----------------
   -- Last_Index --
   ----------------

   function Last_Index
    (Self      : Universal_String'Class;
     From      : Positive;
     To        : Natural;
     Character : Wide_Wide_Character) return Natural is
   begin
      return
        Last_Index (Self.Data, From, To, Wide_Wide_Character'Pos (Character));
   end Last_Index;

   ------------
   -- Length --
   ------------

   function Length (Self : Universal_String'Class) return Natural is
   begin
      return Self.Data.Length;
   end Length;

   ----------------
   -- On_Changed --
   ----------------

   not overriding procedure On_Changed
    (Self           : not null access Abstract_Cursor;
     Changed_First  : Positive;
     Removed_Last   : Natural;
     Inserted_Last  : Natural)
   is
      pragma Unreferenced (Changed_First, Removed_Last, Inserted_Last);

   begin
      Detach (Self.all);
   end On_Changed;

   -------------
   -- Prepend --
   -------------

   procedure Prepend
    (Self : in out Universal_String'Class;
     Item : Universal_String'Class)
   is
      P : constant Utf16_String_Index := Self.Data.Unused;

   begin
      Prepend (Self.Data, Item.Data);
      Emit_Changed (Self, 0, Utf16_String_Index'Last, Self.Data.Unused - P);
   end Prepend;

   -------------
   -- Prepend --
   -------------

   procedure Prepend
    (Self : in out Universal_String'Class;
     Item : League.Characters.Universal_Character'Class)
   is
      P : constant Utf16_String_Index := Self.Data.Unused;
      C : constant Matreshka.Internals.Unicode.Code_Unit_32
        := League.Characters.Internals.Internal (Item);

   begin
      if not Is_Valid (C) then
         raise Constraint_Error with "Illegal Unicode code point";
      end if;

      Prepend (Self.Data, C);
      Emit_Changed (Self, 0, Utf16_String_Index'Last, Self.Data.Unused - P);
   end Prepend;

   -------------
   -- Prepend --
   -------------

   procedure Prepend
    (Self : in out Universal_String'Class;
     Item : Wide_Wide_String) is
   begin
      Self.Prepend (To_Universal_String (Item));
   end Prepend;

   -------------
   -- Prepend --
   -------------

   procedure Prepend
    (Self : in out Universal_String'Class;
     Item : Wide_Wide_Character)
   is
      P : constant Utf16_String_Index := Self.Data.Unused;

   begin
      if not Is_Valid (Wide_Wide_Character'Pos (Item)) then
         raise Constraint_Error with "Illegal Unicode code point";
      end if;

      Prepend (Self.Data, Wide_Wide_Character'Pos (Item));
      Emit_Changed (Self, 0, Utf16_String_Index'Last, Self.Data.Unused - P);
   end Prepend;

   ----------
   -- Read --
   ----------

   procedure Read
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : out Sort_Key)
   is
      Last : Natural;

   begin
      --  Read length of the data.

      Natural'Read (Stream, Last);

      --  XXX Object mutation can be used here.

      Dereference (Item.Data);

      if Last = 0 then
         --  Empty sort key, reuse shared empty object.

         Item.Data := Matreshka.Internals.Strings.Shared_Empty_Key'Access;

      else
         --  Non-empty sort key, allocate array and receive data.

         Item.Data := new Matreshka.Internals.Strings.Shared_Sort_Key (Last);
         Matreshka.Internals.Strings.Sort_Key_Array'Read
          (Stream, Item.Data.Data);
      end if;
   end Read;

   ----------
   -- Read --
   ----------

   procedure Read
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : out Universal_String)
   is
      Length : Natural;
      Unused : Utf16_String_Index;

   begin
      if Stream.all in League.JSON.Streams.JSON_Stream'Class then
         Item :=
           League.JSON.Streams.JSON_Stream'Class (Stream.all).Read.To_String;

      else
         --  Read length of the string.

         Natural'Read (Stream, Length);

         --  XXX Value validation must be done before any other operations.
         --  XXX Object mutation can be used here.

         Dereference (Item.Data);

         if Length = 0 then
            --  Empty string, resuse shared empty object.

            Item.Data := Matreshka.Internals.Strings.Shared_Empty'Access;

         else
            --  Non-empty string, receive index of first unused code unit,
            --  allocate new shared object and receive actual data.

            Utf16_String_Index'Read (Stream, Unused);
            Item.Data := Allocate (Unused);
            Item.Data.Unused := Unused;
            Item.Data.Length := Length;
            Utf16_String'Read
             (Stream, Item.Data.Value (0 .. Item.Data.Unused - 1));
            String_Handler.Fill_Null_Terminator (Item.Data);
         end if;
      end if;
   end Read;

   -------------
   -- Replace --
   -------------

   procedure Replace
    (Self : in out Universal_String'Class;
     Low  : Positive;
     High : Natural;
     By   : Universal_String'Class)
   is
      D      : constant not null Shared_String_Access := Self.Data;
      Length : Natural;
      First  : Utf16_String_Index;
      Size   : Utf16_String_Index;

   begin
      if Low > D.Length + 1 or else High > D.Length then
         raise Constraint_Error with "Index is out of range";
      end if;

      Length := Natural'Max (High - Low + 1, 0);

      if Integer (D.Unused) = D.Length then
         First := Utf16_String_Index (Low - 1);
         Size  := Utf16_String_Index (High - Low + 1);

      elsif Integer (D.Unused) = D.Length * 2 then
         First := Utf16_String_Index ((Low - 1) * 2);
         Size  := Utf16_String_Index (High - Low + 1) * 2;

      else
         declare
            M : Index_Map_Access := D.Index_Map;

         begin
            if M = null then
               Compute_Index_Map (D.all);
               M := D.Index_Map;
            end if;

            First := M.Map (Utf16_String_Index (Low - 1));

            if High = D.Length then
               Size := D.Unused - First;

            else
               Size := M.Map (Utf16_String_Index (High - 1)) - First + 1;
            end if;
         end;
      end if;

      Replace (Self.Data, First, Size, Length, By.Data);
   end Replace;

   -------------
   -- Replace --
   -------------

   procedure Replace
    (Self : in out Universal_String'Class;
     Low  : Positive;
     High : Natural;
     By   : Wide_Wide_String) is
   begin
      Self.Replace (Low, High, To_Universal_String (By));
   end Replace;

   -----------
   -- Slice --
   -----------

   function Slice
     (Self : Universal_String'Class;
      Low  : Positive;
      High : Natural) return Universal_String
   is
      D      : constant not null Shared_String_Access := Self.Data;
      Length : Natural;
      First  : Utf16_String_Index;
      Size   : Utf16_String_Index;

   begin
      if Low > High then
         --  By Ada conventions, slice is empty when Low is greater than High.
         --  Actual values of Low and High is not important here.

         return Empty_Universal_String;

      elsif Low > D.Length or else High > D.Length then
         --  Otherwise, both Low and High should be less or equal to Length.

         raise Constraint_Error with "Index is out of range";
      end if;

      Length := Natural'Max (High - Low + 1, 0);

      if Integer (D.Unused) = D.Length then
         First := Utf16_String_Index (Low - 1);
         Size  := Utf16_String_Index (High - Low + 1);

      elsif Integer (D.Unused) = D.Length * 2 then
         First := Utf16_String_Index ((Low - 1) * 2);
         Size  := Utf16_String_Index (High - Low + 1) * 2;

      else
         declare
            M : Index_Map_Access := D.Index_Map;

         begin
            if M = null then
               Compute_Index_Map (D.all);
               M := D.Index_Map;
            end if;

            First := M.Map (Utf16_String_Index (Low - 1));

            if High = D.Length then
               Size := D.Unused - First;

            else
               Size := M.Map (Utf16_String_Index (High - 1)) - First + 1;
            end if;
         end;
      end if;

      return Wrap (Slice (D, First, Size, Length));
   end Slice;

   -----------
   -- Slice --
   -----------

   procedure Slice
    (Self : in out Universal_String'Class; Low : Positive; High : Natural)
   is
      D      : Shared_String_Access := Self.Data;
      Length : Natural;
      First  : Utf16_String_Index;
      Size   : Utf16_String_Index;

   begin
      if Low > High then
         --  By Ada conventions, slice is empty when Low is greater than High.
         --  Actual values of Low and High is not important here.

         Dereference (D);
         Self.Data := Matreshka.Internals.Strings.Shared_Empty'Access;

      elsif Low > D.Length or else High > D.Length then
         --  Otherwise, both Low and High should be less or equal to Length.

         raise Constraint_Error with "Index is out of range";
      end if;

      Length := Natural'Max (High - Low + 1, 0);

      if Integer (D.Unused) = D.Length then
         First := Utf16_String_Index (Low - 1);
         Size  := Utf16_String_Index (High - Low + 1);

      elsif Integer (D.Unused) = D.Length * 2 then
         First := Utf16_String_Index ((Low - 1) * 2);
         Size  := Utf16_String_Index (High - Low + 1) * 2;

      else
         declare
            M : Index_Map_Access := D.Index_Map;

         begin
            if M = null then
               Compute_Index_Map (D.all);
               M := D.Index_Map;
            end if;

            First := M.Map (Utf16_String_Index (Low - 1));

            if High = D.Length then
               Size := D.Unused - First;

            else
               Size := M.Map (Utf16_String_Index (High - 1)) - First + 1;
            end if;
         end;
      end if;

      --  XXX This operation can be optimized in case of modification in place,
      --  so, then reference counter is equal to one.

      Self.Data := Slice (D, First, Size, Length);
      Dereference (D);
   end Slice;

   -----------
   -- Split --
   -----------

   function Split
    (Self      : Universal_String'Class;
     Separator : Wide_Wide_Character;
     Behavior  : Split_Behavior := Keep_Empty)
       return League.String_Vectors.Universal_String_Vector is
   begin
      return
        Split
         (Self,
          League.Characters.To_Universal_Character (Separator),
          Behavior);
   end Split;

   -----------
   -- Split --
   -----------

   function Split
    (Self      : Universal_String'Class;
     Separator : League.Characters.Universal_Character'Class;
     Behavior  : Split_Behavior := Keep_Empty)
       return League.String_Vectors.Universal_String_Vector
   is
      D : constant not null Shared_String_Access := Self.Data;
      C : constant Matreshka.Internals.Unicode.Code_Unit_32
        := League.Characters.Internals.Internal (Separator);

      First_Position   : Utf16_String_Index := 0;
      First_Index      : Positive := 1;
      Current_Position : Utf16_String_Index := 0;
      Current_Index    : Positive := 1;
      Last_Position    : Utf16_String_Index;
      Last_Index       : Natural;
      Code             : Code_Point;
      S                : Shared_String_Access;
      R                : Shared_String_Vector_Access
        := Empty_Shared_String_Vector'Access;

   begin
      if not Is_Valid (C) then
         raise Constraint_Error with "Illegal Unicode code point";
      end if;

      if D.Length = 0 then
         return League.String_Vectors.Empty_Universal_String_Vector;
      end if;

      while Current_Position < D.Unused loop
         Last_Position := Current_Position;
         Last_Index    := Current_Index;
         Unchecked_Next (D.Value, Current_Position, Code);
         Current_Index := Current_Index + 1;

         if Code = C then
            if Behavior = Keep_Empty or Last_Index - First_Index /= 0 then
               S :=
                 Slice
                  (D,
                   First_Position,
                   Last_Position - First_Position,
                   Last_Index - First_Index);
               Append (R, S);
            end if;

            First_Position := Current_Position;
            First_Index    := Current_Index;
         end if;
      end loop;

      if First_Position <= D.Unused then
         if Behavior = Keep_Empty or D.Length - First_Index + 1 /= 0 then
            S :=
              Slice
               (D,
                First_Position,
                D.Unused - First_Position,
                D.Length - First_Index + 1);
            Append (R, S);
         end if;
      end if;

      return League.String_Vectors.Internals.Wrap (R);
   end Split;

   -----------------
   -- Starts_With --
   -----------------

   function Starts_With
    (Self    : Universal_String'Class;
     Pattern : Universal_String'Class) return Boolean is
   begin
      return String_Handler.Starts_With (Self.Data, Pattern.Data);
   end Starts_With;

   -----------------
   -- Starts_With --
   -----------------

   function Starts_With
    (Self    : Universal_String'Class;
     Pattern : Wide_Wide_String) return Boolean is
   begin
      return Self.Starts_With (To_Universal_String (Pattern));
   end Starts_With;

   ----------
   -- Tail --
   ----------

   function Tail
    (Self  : Universal_String'Class;
     Count : Natural) return Universal_String is
   begin
      if Count > Self.Length then
         raise Constraint_Error with "String is too small";

      elsif Count = 0 then
         return Empty_Universal_String;

      else
         return Self.Slice (Self.Length - Count + 1, Self.Length);
      end if;
   end Tail;

   ---------------
   -- Tail_From --
   ---------------

   function Tail_From
    (Self : Universal_String'Class;
     From : Positive) return Universal_String is
   begin
      if From > Self.Length then
         return Empty_Universal_String;

      else
         return Self.Slice (From, Self.Length);
      end if;
   end Tail_From;

   -----------------
   -- To_Casefold --
   -----------------

   function To_Casefold
    (Self : Universal_String'Class) return Universal_String is
   begin
      if Self.Data.Length = 0 then
         return Universal_String (Self);
      end if;

      declare
         Locale : Matreshka.Internals.Locales.Locale_Data_Access
           := Matreshka.Internals.Locales.Get_Locale;
         Data   : not null Shared_String_Access := Allocate (Self.Data.Unused);

      begin
         Matreshka.Internals.Unicode.Casing.Convert_Case
          (Locale,
           Self.Data,
           Matreshka.Internals.Unicode.Ucd.Folding,
           Matreshka.Internals.Unicode.Ucd.Changes_When_Casefolded,
           Data);
         Matreshka.Internals.Locales.Dereference (Locale);

         return Wrap (Data);
      end;
   end To_Casefold;

   ------------------
   -- To_Lowercase --
   ------------------

   function To_Lowercase
    (Self : Universal_String'Class) return Universal_String is
   begin
      if Self.Data.Length = 0 then
         return Universal_String (Self);
      end if;

      declare
         Locale : Matreshka.Internals.Locales.Locale_Data_Access
           := Matreshka.Internals.Locales.Get_Locale;
         Data   : not null Shared_String_Access := Allocate (Self.Data.Unused);

      begin
         Matreshka.Internals.Unicode.Casing.Convert_Case
          (Locale,
           Self.Data,
           Matreshka.Internals.Unicode.Ucd.Lower,
           Matreshka.Internals.Unicode.Ucd.Changes_When_Lowercased,
           Data);
         Matreshka.Internals.Locales.Dereference (Locale);

         return Wrap (Data);
      end;
   end To_Lowercase;

   ------------
   -- To_NFC --
   ------------

   function To_NFC (Self : Universal_String'Class) return Universal_String is
      Data : Shared_String_Access;

   begin
      Matreshka.Internals.Unicode.Normalization.NFC (Self.Data, Data);

      return Wrap (Data);
   end To_NFC;

   ------------
   -- To_NFD --
   ------------

   function To_NFD (Self : Universal_String'Class) return Universal_String is
      Data : Shared_String_Access;

   begin
      Matreshka.Internals.Unicode.Normalization.NFD (Self.Data, Data);

      return Wrap (Data);
   end To_NFD;

   -------------
   -- To_NFKC --
   -------------

   function To_NFKC (Self : Universal_String'Class) return Universal_String is
      Data : Shared_String_Access;

   begin
      Matreshka.Internals.Unicode.Normalization.NFKC (Self.Data, Data);

      return Wrap (Data);
   end To_NFKC;

   -------------
   -- To_NFKD --
   -------------

   function To_NFKD (Self : Universal_String'Class) return Universal_String is
      Data : Shared_String_Access;

   begin
      Matreshka.Internals.Unicode.Normalization.NFKD (Self.Data, Data);

      return Wrap (Data);
   end To_NFKD;

   -----------------
   -- To_Position --
   -----------------

   function To_Position
    (Item  : not null Matreshka.Internals.Strings.Shared_String_Access;
     Index : Positive) return Utf16_String_Index
   is
      Map : Index_Map_Access;

   begin
      if Index > Item.Length then
         raise Constraint_Error with "Index is out of range";
      end if;

      if Index = Item.Length then
         return Item.Unused;
      end if;

      if Item.Unused = Utf16_String_Index (Item.Length) then
         return Utf16_String_Index (Index);

      elsif Item.Unused = Utf16_String_Index (Item.Length) * 2 then
         return Utf16_String_Index (Index) * 2;

      else
         Map := Item.Index_Map;

         --  Calculate index map if it is unavailable for now.

         if Map = null then
            Compute_Index_Map (Item.all);
            Map := Item.Index_Map;
         end if;

         return Map.Map (Utf16_String_Index (Index));
      end if;
   end To_Position;

   ------------------------
   -- To_Simple_Casefold --
   ------------------------

   function To_Simple_Casefold
    (Self : Universal_String'Class) return Universal_String is
   begin
      if Self.Data.Length = 0 then
         return Empty_Universal_String;
      end if;

      declare
         Locale : Matreshka.Internals.Locales.Locale_Data_Access
           := Matreshka.Internals.Locales.Get_Locale;
         Data   : not null Shared_String_Access := Allocate (Self.Data.Unused);

      begin
         Matreshka.Internals.Unicode.Casing.Simple_Convert_Case
          (Locale,
           Self.Data,
           Matreshka.Internals.Unicode.Ucd.Folding,
           Matreshka.Internals.Unicode.Ucd.Changes_When_Casefolded,
           Data);
         Matreshka.Internals.Locales.Dereference (Locale);

         return Wrap (Data);
      end;
   end To_Simple_Casefold;

   -------------------------
   -- To_Simple_Lowercase --
   -------------------------

   function To_Simple_Lowercase
    (Self : Universal_String'Class) return Universal_String is
   begin
      if Self.Data.Length = 0 then
         return Empty_Universal_String;
      end if;

      declare
         Locale : Matreshka.Internals.Locales.Locale_Data_Access
           := Matreshka.Internals.Locales.Get_Locale;
         Data   : not null Shared_String_Access := Allocate (Self.Data.Unused);

      begin
         Matreshka.Internals.Unicode.Casing.Simple_Convert_Case
          (Locale,
           Self.Data,
           Matreshka.Internals.Unicode.Ucd.Lower,
           Matreshka.Internals.Unicode.Ucd.Changes_When_Lowercased,
           Data);
         Matreshka.Internals.Locales.Dereference (Locale);

         return Wrap (Data);
      end;
   end To_Simple_Lowercase;

   -------------------------
   -- To_Simple_Titlecase --
   -------------------------

   function To_Simple_Titlecase
    (Self : Universal_String'Class) return Universal_String is
   begin
      if Self.Data.Length = 0 then
         return Empty_Universal_String;
      end if;

      declare
         Locale : Matreshka.Internals.Locales.Locale_Data_Access
           := Matreshka.Internals.Locales.Get_Locale;
         Data   : not null Shared_String_Access := Allocate (Self.Data.Unused);

      begin
         Matreshka.Internals.Unicode.Casing.Simple_Convert_Case
          (Locale,
           Self.Data,
           Matreshka.Internals.Unicode.Ucd.Title,
           Matreshka.Internals.Unicode.Ucd.Changes_When_Titlecased,
           Data);
         Matreshka.Internals.Locales.Dereference (Locale);

         return Wrap (Data);
      end;
   end To_Simple_Titlecase;

   -------------------------
   -- To_Simple_Uppercase --
   -------------------------

   function To_Simple_Uppercase
    (Self : Universal_String'Class) return Universal_String is
   begin
      if Self.Data.Length = 0 then
         return Empty_Universal_String;
      end if;

      declare
         Locale : Matreshka.Internals.Locales.Locale_Data_Access
           := Matreshka.Internals.Locales.Get_Locale;
         Data   : not null Shared_String_Access := Allocate (Self.Data.Unused);

      begin
         Matreshka.Internals.Unicode.Casing.Simple_Convert_Case
          (Locale,
           Self.Data,
           Matreshka.Internals.Unicode.Ucd.Upper,
           Matreshka.Internals.Unicode.Ucd.Changes_When_Uppercased,
           Data);
         Matreshka.Internals.Locales.Dereference (Locale);

         return Wrap (Data);
      end;
   end To_Simple_Uppercase;

   ------------------
   -- To_Titlecase --
   ------------------

   function To_Titlecase
    (Self : Universal_String'Class) return Universal_String is
   begin
      if Self.Data.Length = 0 then
         return Empty_Universal_String;
      end if;

      declare
         Locale : Matreshka.Internals.Locales.Locale_Data_Access
           := Matreshka.Internals.Locales.Get_Locale;
         Data   : not null Shared_String_Access := Allocate (Self.Data.Unused);

      begin
         Matreshka.Internals.Unicode.Casing.Convert_Case
          (Locale,
           Self.Data,
           Matreshka.Internals.Unicode.Ucd.Title,
           Matreshka.Internals.Unicode.Ucd.Changes_When_Titlecased,
           Data);
         Matreshka.Internals.Locales.Dereference (Locale);

         return Wrap (Data);
      end;
   end To_Titlecase;

   -------------------------
   -- To_Universal_String --
   -------------------------

   function To_Universal_String
    (Item : Wide_Wide_String) return Universal_String
   is
      Data : Shared_String_Access;

   begin
      if Item'Length = 0 then
         return Result : Universal_String
           := Universal_String'
               (Ada.Finalization.Controlled with
                  Data    => Shared_Empty'Access,
                  List    => (Head => null),
                  Cursors => null)
         do
            Result.Cursors := Result.List'Unchecked_Access;
         end return;
      end if;

      To_Utf16_String (Item, Data);

      return Wrap (Data);
   end To_Universal_String;

   ------------------
   -- To_Uppercase --
   ------------------

   function To_Uppercase
    (Self : Universal_String'Class) return Universal_String is
   begin
      if Self.Data.Length = 0 then
         return Universal_String (Self);
      end if;

      declare
         Locale : Matreshka.Internals.Locales.Locale_Data_Access
           := Matreshka.Internals.Locales.Get_Locale;
         Data   : not null Shared_String_Access := Allocate (Self.Data.Unused);

      begin
         Matreshka.Internals.Unicode.Casing.Convert_Case
          (Locale,
           Self.Data,
           Matreshka.Internals.Unicode.Ucd.Upper,
           Matreshka.Internals.Unicode.Ucd.Changes_When_Uppercased,
           Data);
         Matreshka.Internals.Locales.Dereference (Locale);

         return Wrap (Data);
      end;
   end To_Uppercase;

   ---------------------------
   -- To_UTF_16_Wide_String --
   ---------------------------

   function To_UTF_16_Wide_String
    (Self : Universal_String'Class)
       return Ada.Strings.UTF_Encoding.UTF_16_Wide_String
   is
      --  Universal_String use UTF-16 encoding for internal data, thus no
      --  encoder is needed to do host-endian encoding.

      Result : constant Wide_String (1 .. Natural (Self.Data.Unused));
      for Result'Address use Self.Data.Value'Address;
      pragma Import (Ada, Result);

   begin
      return Result;
   end To_UTF_16_Wide_String;

   ---------------------
   -- To_UTF_8_String --
   ---------------------

   function To_UTF_8_String
    (Self : Universal_String'Class)
       return Ada.Strings.UTF_Encoding.UTF_8_String
   is
      use Matreshka.Internals.Stream_Element_Vectors;

      Encoder : Matreshka.Internals.Text_Codecs.UTF8.UTF8_Encoder;
      Buffer  : Shared_Stream_Element_Vector_Access;

   begin
      Encoder.Encode (Self.Data, Buffer);

      declare
         Aux    : String (1 .. Natural (Buffer.Length));
         for Aux'Address use Buffer.Value'Address;
         pragma Import (Ada, Aux);
         Result : constant String (Aux'Range) := Aux;

      begin
         Dereference (Buffer);

         return Result;
      end;
   end To_UTF_8_String;

   ---------------------
   -- To_Utf16_String --
   ---------------------

   procedure To_Utf16_String
    (Source : Wide_Wide_String; Destination : out Shared_String_Access) is
   begin
      if Source'Length = 0 then
         Destination := Shared_Empty'Access;

      else
         Destination := Allocate (Source'Length + 1);
         --  Check for string reallocation below doesn't take in sence size of
         --  encoded character and assumes that it occupy two code unit always.
         --  One additional code unit is allocated to prevent from reallocation
         --  of shared data in corner case.

         Destination.Length := Source'Length;

         for J in Source'Range loop
            if not Is_Valid
                (Wide_Wide_Character'Pos (Source (J)))
            then
               raise Constraint_Error with "Illegal Unicode code point";
            end if;

            if Destination.Capacity < Destination.Unused + 2 then
               --  For some improvement of performance this check ignores
               --  actual number of code units which are occupied by encoded
               --  code point. Additional code unit is allocated to prevent
               --  from reallocation of shared data in corner case.

               declare
                  Old : not null Shared_String_Access := Destination;

               begin
                  Destination := Allocate (Destination.Unused + 2);
                  Destination.Value (Old.Value'Range) := Old.Value;
                  Destination.Unused := Old.Unused;
                  Destination.Length := Old.Length;

                  Dereference (Old);
               end;
            end if;

            Unchecked_Store
             (Destination.Value,
              Destination.Unused,
              Wide_Wide_Character'Pos (Source (J)));
         end loop;

         String_Handler.Fill_Null_Terminator (Destination);
      end if;

   exception
      when others =>
         Dereference (Destination);

         raise;
   end To_Utf16_String;

   -------------------------
   -- To_Wide_Wide_String --
   -------------------------

   function To_Wide_Wide_String
    (Self : Universal_String'Class) return Wide_Wide_String
   is
      Result  : Wide_Wide_String (1 .. Self.Data.Length);
      Current : Utf16_String_Index := 0;
      Code    : Code_Point;

   begin
      for J in Result'Range loop
         Unchecked_Next (Self.Data.Value, Current, Code);
         Result (J) := Wide_Wide_Character'Val (Code);
      end loop;

      return Result;
   end To_Wide_Wide_String;

   -----------
   -- Write --
   -----------

   procedure Write
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : Sort_Key) is
   begin
      Natural'Write (Stream, Item.Data.Last);
      Matreshka.Internals.Strings.Sort_Key_Array'Write
       (Stream, Item.Data.Data (1 .. Item.Data.Last));
   end Write;

   -----------
   -- Write --
   -----------

   procedure Write
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : Universal_String) is
   begin
      if Stream.all in League.JSON.Streams.JSON_Stream'Class then
         League.JSON.Streams.JSON_Stream'Class (Stream.all).Write
          (League.JSON.Values.To_JSON_Value (Item));

      else
         --  Write length of the string into the stream.

         Natural'Write (Stream, Item.Data.Length);

         --  For non-empty string writes index of first unused code unit and data
         --  iteself.

         if Item.Data.Length /= 0 then
            Utf16_String_Index'Write (Stream, Item.Data.Unused);
            Matreshka.Internals.Utf16.Utf16_String'Write
             (Stream, Item.Data.Value (0 .. Item.Data.Unused - 1));
         end if;
      end if;
   end Write;

end League.Strings;
