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
-- Copyright © 2009 Vadim Godunko <vgodunko@gmail.com>                      --
--                                                                          --
-- Matreshka is free software;  you can  redistribute it  and/or modify  it --
-- under terms of the  GNU General Public License as published  by the Free --
-- Software  Foundation;  either version 2,  or (at your option)  any later --
-- version.  Matreshka  is distributed in the hope that it will be  useful, --
-- but   WITHOUT  ANY  WARRANTY;  without  even  the  implied  warranty  of --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General --
-- Public License for more details.  You should have received a copy of the --
-- GNU General Public License distributed with Matreshka; see file COPYING. --
-- If not, write  to  the  Free Software Foundation,  51  Franklin  Street, --
-- Fifth Floor, Boston, MA 02110-1301, USA.                                 --
--                                                                          --
-- As a special exception,  if other files  instantiate  generics from this --
-- unit, or you link  this unit with other files  to produce an executable, --
-- this  unit  does not  by itself cause  the resulting  executable  to  be --
-- covered  by the  GNU  General  Public  License.  This exception does not --
-- however invalidate  any other reasons why  the executable file  might be --
-- covered by the  GNU Public License.                                      --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------
with Matreshka.Internals.Atomics.Counters;
with Matreshka.Internals.Locales;
with Matreshka.Internals.Ucd;
with Matreshka.Internals.Unicode.Casing;
with Matreshka.Internals.Unicode.Normalization;
with Matreshka.Internals.Utf16;

package body Matreshka.Strings is

   use Matreshka.Internals.Strings;
   use Matreshka.Internals.Unicode;
   use Matreshka.Internals.Utf16;

   procedure To_Utf16_String
    (Source      : Wide_Wide_String;
     Destination : out Internal_String_Access);

   procedure Unchecked_Append
    (Data : in out Internal_String;
     Item : Wide_Wide_Character);

   procedure Attach (Self : in out Abstract_Cursor'Class);
   --  Attaches cursor to the list of cursors of Universal_String.

   procedure Detach (Self : in out Abstract_Cursor'Class);
   --  Detaches cursor from the list of cursors of Universal_String. Also
   --  reset associated object to null.

   Index_Mode_After_Concatenation : constant
     array (Index_Modes, Index_Modes) of Index_Modes
       := (Undefined    => (Single_Units => Single_Units,
                            Double_Units => Double_Units,
                            Mixed_Units  => Mixed_Units,
                            others       => Undefined),
           Single_Units => (Undefined    => Single_Units,
                            Single_Units => Single_Units,
                            others       => Mixed_Units),
           Double_Units => (Undefined    => Double_Units,
                            Double_Units => Double_Units,
                            others       => Mixed_Units),
           Mixed_Units  => (Undefined    => Mixed_Units,
                            others       => Mixed_Units));
   --  String indexing mode after concatenation. Each dimension is a valid
   --  string indexing mode for each concatenated string.

   ---------
   -- "&" --
   ---------

   function "&"
    (Left  : Universal_String'Class;
     Right : Universal_Character'Class)
       return Universal_String
   is
   begin
      return Left & Right.To_Wide_Wide_Character;
   end "&";

   ---------
   -- "&" --
   ---------

   function "&"
    (Left  : Universal_String'Class;
     Right : Universal_String'Class)
       return Universal_String
   is
      L_D : constant not null Internal_String_Access := Left.Data;
      R_D : constant not null Internal_String_Access := Right.Data;

   begin
      if L_D.Length = 0 then
         return Universal_String (Right);

      elsif R_D.Length = 0 then
         return Universal_String (Left);

      else
         declare
            D : constant Internal_String_Access
              := new Internal_String (L_D.Last + R_D.Last);

         begin
            D.Value (1 .. L_D.Last) := L_D.Value (1 .. L_D.Last);
            D.Value (L_D.Last + 1 .. L_D.Last + R_D.Last) :=
              R_D.Value (1 .. R_D.Last);
            D.Last := L_D.Last + R_D.Last;
            D.Length := L_D.Length + R_D.Length;
            D.Index_Mode :=
              Index_Mode_After_Concatenation (L_D.Index_Mode, R_D.Index_Mode);

            return Constructors.Create (D);
         end;
      end if;
   end "&";

   ---------
   -- "&" --
   ---------

   function "&"
    (Left  : Universal_String'Class;
     Right : Wide_Wide_Character)
       return Universal_String
   is
      L_D : constant not null Internal_String_Access := Left.Data;

   begin
      if not Is_Valid_Unicode_Code_Point (Wide_Wide_Character'Pos (Right)) then
         raise Constraint_Error with "Invalid Wide_Wide_Character";
      end if;

      declare
         D : constant not null Internal_String_Access
           := new Internal_String (L_D.Last + 2);

      begin
         D.Value (1 .. L_D.Last) := L_D.Value (1 .. L_D.Last);
         D.Last                  := L_D.Last;
         D.Index_Mode            := L_D.Index_Mode;
         Unchecked_Append (D.all, Right);

         return Constructors.Create (D);
      end;
   end "&";

   ---------
   -- "=" --
   ---------

   overriding function "="
    (Left  : Universal_String;
     Right : Universal_String)
       return Boolean
   is
   begin
      raise Program_Error;
      return False;
   end "=";

   ---------
   -- "=" --
   ---------

   function "="
    (Left  : Universal_String'Class;
     Right : Universal_String'Class)
       return Boolean
   is
   begin
      raise Program_Error;
      return False;
   end "=";

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

   overriding procedure Adjust (Self : in out Universal_String) is
   begin
      Matreshka.Internals.Atomics.Counters.Increment
       (Self.Data.Counter'Access);
      Self.List    := (Head => null);
      Self.Cursors := Self.List'Unchecked_Access;
   end Adjust;

   ------------
   -- Append --
   ------------

   procedure Append
    (Self : in out Universal_String'Class;
     Item : Universal_String'Class)
   is
      F : constant Natural := Self.Data.Last + 1;

   begin
      Append (Self.Data, Item.Data);
      Emit_Changed (Self, F, 0, Self.Data.Last);
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
    (Self : in out Abstract_Cursor'Class;
     Item : in out Universal_String'Class)
   is
   begin
      if Self.Object /= Item'Unchecked_Access then
         Detach (Self);
         Self.Object := Item'Unchecked_Access;
         Attach (Self);
      end if;
   end Attach;

   --------------------
   -- Binary_Compare --
   --------------------

   function Binary_Compare
    (Self : Universal_String'Class;
     To   : Universal_String'Class)
       return Relationship
   is
      LD    : constant not null Internal_String_Access := Self.Data;
      RD    : constant not null Internal_String_Access := To.Data;
      Fixup : constant array (Utf16_Code_Unit range 0 .. 31) of Utf16_Code_Unit
        := (0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 16#2000#, 16#F800#, 16#F800#, 16#F800#, 16#F800#);

   begin
      if LD = RD then
         return Equal;
      end if;

      for J in 1 .. Natural'Min (LD.Last, RD.Last) loop
         if LD.Value (J) /= RD.Value (J) then
            if LD.Value (J) + Fixup (LD.Value (J) / 16#800#)
                 < RD.Value (J) + Fixup (RD.Value (J) / 16#800#)
            then
               return Less;

            else
               return Greater;
            end if;
         end if;
      end loop;

      if LD.Last < RD.Last then
         return Less;

      elsif LD.Last > RD.Last then
         return Greater;

      else
         return Equal;
      end if;
   end Binary_Compare;

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ------------
      -- Create --
      ------------

      function Create (Data : not null Internal_String_Access)
        return Universal_String
      is
      begin
         return Result : Universal_String
           := Universal_String'
               (Ada.Finalization.Controlled with
                  Data    => Data,
                  List    => (Head => null),
                  Cursors => null)
         do
            Result.Cursors := Result.List'Unchecked_Access;
         end return;
      end Create;

   end Constructors;

   ----------
   -- Copy --
   ----------

--   function Copy (Source : not null String_Private_Data_Access)
--     return not null String_Private_Data_Access
--   is
--   begin
--      return Result : not null String_Private_Data_Access
--        := Constructors.Create
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
     Index : Positive)
       return Universal_Character
   is
   begin
      return To_Universal_Character (Self.Element (Index));
   end Element;

   -------------
   -- Element --
   -------------

   function Element
    (Self  : Universal_String'Class;
     Index : Positive)
       return Wide_Wide_Character
   is
      D : constant Internal_String_Access := Self.Data;

   begin
      if Index > D.Length then
         raise Constraint_Error with "Index is out of range";
      end if;

      case D.Index_Mode is
         when Undefined =>
            raise Program_Error;

         when Single_Units =>
            return Wide_Wide_Character'Val (D.Value (Index));

         when Double_Units =>
            return
              Wide_Wide_Character'Val
               (Unchecked_To_Code_Point (D.Value, Index * 2 - 1));

         when Mixed_Units =>
            declare
               M : Index_Map_Access := D.Index_Map;

            begin
               --  Calculate index map if it is unavailable for now.

               if M = null then
                  Compute_Index_Map (D.all);
                  M := D.Index_Map;
               end if;

               return
                 Wide_Wide_Character'Val
                  (Unchecked_To_Code_Point (D.Value, M.Map (Index)));
            end;
      end case;
   end Element;

   ------------------
   -- Emit_Changed --
   ------------------

   procedure Emit_Changed
    (Self          : Universal_String'Class;
     Changed_First : Positive;
     Removed_Last  : Natural;
     Inserted_Last : Natural)
   is
      Current : Cursor_Access := Self.Cursors.Head;
      Next    : Cursor_Access;

   begin
      while Current /= null loop
         Next := Current.Next;
         Current.On_Changed (Changed_First, Removed_Last, Inserted_Last);
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

   overriding procedure Finalize (Self : in out Universal_String) is
      Current : Cursor_Access := Self.Cursors.Head;
      Next    : Cursor_Access;

   begin
      while Current /= null loop
         Next := Current.Next;
         Detach (Current.all);
         Current := Next;
      end loop;

      Dereference (Self.Data);
   end Finalize;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out Universal_String) is
   begin
      Self.Data := Shared_Empty'Access;
      Matreshka.Internals.Atomics.Counters.Increment
       (Self.Data.Counter'Access);
      Self.List := (Head => null);
      Self.Cursors := Self.List'Unchecked_Access;
   end Initialize;

   ---------------------
   -- Is_Binary_Equal --
   ---------------------

   function Is_Binary_Equal
    (Self : Universal_String'Class;
     To   : Universal_String'Class)
       return Boolean
   is
   begin
      return
        Self.Data = To.Data
          or else (Self.Data.Last = To.Data.Last
                     and then Self.Data.Value (1 .. Self.Data.Last)
                                = To.Data.Value (1 .. To.Data.Last));
   end Is_Binary_Equal;

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

   ----------
   -- Read --
   ----------

   procedure Read
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : out Universal_String)
   is
      Length : Natural;
      Last   : Natural;

   begin
      Natural'Read (Stream, Length);
      Natural'Read (Stream, Last);

      --  XXX Value validation must be done before any other operations.
      --  XXX Object mutation can be used here.

      Dereference (Item.Data);

      Item.Data := new Internal_String (Last);
      Utf16_String'Read (Stream, Item.Data.Value);
      Item.Data.Last := Last;
      Item.Data.Length := Length;
      Item.Data.Index_Mode := Undefined;
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
      D      : constant not null Internal_String_Access := Self.Data;
      Length : Natural;
      First  : Positive;
      Last   : Natural;

   begin
      if Low > D.Last + 1 or else High > D.Last then
         raise Constraint_Error with "Index is out of range";
      end if;

      Length := Natural'Max (High - Low + 1, 0);

      case D.Index_Mode is
         when Undefined =>
            raise Program_Error;

         when Single_Units =>
            First := Low;
            Last  := High;

         when Double_Units =>
            First := Low * 2 - 1;
            Last  := High * 2;

         when Mixed_Units =>
            declare
               M : Index_Map_Access := D.Index_Map;

            begin
               if M = null then
                  Compute_Index_Map (D.all);
                  M := D.Index_Map;
               end if;

               First := M.Map (Low);

               if High = D.Length then
                  Last := D.Last;

               else
                  Last := M.Map (High + 1) - 1;
               end if;
            end;
      end case;

      Replace (Self.Data, First, Last, Length, By.Data);
   end Replace;

   -----------
   -- Slice --
   -----------

   function Slice
    (Self : Universal_String'Class;
     Low  : Positive;
     High : Natural)
       return Universal_String
   is
      D      : constant not null Internal_String_Access := Self.Data;
      Length : Natural;
      First  : Positive;
      Last   : Natural;

   begin
      if Low <= High and then (Low > D.Length or else High > D.Length) then
         raise Constraint_Error with "Index is out of range";
      end if;

      Length := Natural'Max (High - Low + 1, 0);

      case D.Index_Mode is
         when Undefined =>
            raise Program_Error;

         when Single_Units =>
            First := Low;
            Last  := High;

         when Double_Units =>
            First := Low * 2 - 1;
            Last  := High * 2;

         when Mixed_Units =>
            declare
               M : Index_Map_Access := D.Index_Map;

            begin
               if M = null then
                  Compute_Index_Map (D.all);
                  M := D.Index_Map;
               end if;

               First := M.Map (Low);

               if High = D.Length then
                  Last := D.Last;

               else
                  Last := M.Map (High + 1) - 1;
               end if;
            end;
      end case;

      return Constructors.Create (Slice (D, First, Last, Length));
   end Slice;

   -----------------
   -- To_Casefold --
   -----------------

   function To_Casefold (Self : Universal_String'Class)
     return Universal_String
   is
   begin
      if Self.Data.Length = 0 then
         return Universal_String (Self);
      end if;

      declare
         Locale : Matreshka.Internals.Locales.Locale_Data_Access
           := Matreshka.Internals.Locales.Get_Locale;
         Data   : not null Internal_String_Access
           := new Internal_String (Self.Data.Last);

      begin
         Matreshka.Internals.Unicode.Casing.Convert_Case
          (Locale,
           Self.Data,
           Matreshka.Internals.Ucd.Folding,
           Matreshka.Internals.Ucd.Has_Case_Folding,
           Data);
         Matreshka.Internals.Locales.Dereference (Locale);

         return Constructors.Create (Data);
      end;
   end To_Casefold;

   ------------------
   -- To_Lowercase --
   ------------------

   function To_Lowercase (Self : Universal_String'Class)
     return Universal_String
   is
   begin
      if Self.Data.Length = 0 then
         return Universal_String (Self);
      end if;

      declare
         Locale : Matreshka.Internals.Locales.Locale_Data_Access
           := Matreshka.Internals.Locales.Get_Locale;
         Data   : not null Internal_String_Access
           := new Internal_String (Self.Data.Last);

      begin
         Matreshka.Internals.Unicode.Casing.Convert_Case
          (Locale,
           Self.Data,
           Matreshka.Internals.Ucd.Lower,
           Matreshka.Internals.Ucd.Has_Lowercase_Mapping,
           Data);
         Matreshka.Internals.Locales.Dereference (Locale);

         return Constructors.Create (Data);
      end;
   end To_Lowercase;

   ------------
   -- To_NFD --
   ------------

   function To_NFD (Self : Universal_String'Class)
     return Universal_String
   is
      Data : Internal_String_Access;

   begin
      Matreshka.Internals.Unicode.Normalization.NFD (Self.Data, Data);

      return Constructors.Create (Data);
   end To_NFD;

   ----------------------------
   -- To_Universal_Character --
   ----------------------------

   function To_Universal_Character
    (Self : Wide_Wide_Character)
       return Universal_Character
   is
   begin
      if Is_Valid_Unicode_Code_Point (Wide_Wide_Character'Pos (Self)) then
         return Universal_Character'(C => Wide_Wide_Character'Pos (Self));

      else
         raise Constraint_Error
           with "Wide_Wide_Character is not a valid Unicode code point";
      end if;
   end To_Universal_Character;

   -------------------------
   -- To_Universal_String --
   -------------------------

   function To_Universal_String (Item : Wide_Wide_String)
     return Universal_String
   is
      Data : Internal_String_Access;

   begin
      if Item'Length = 0 then
         Matreshka.Internals.Atomics.Counters.Increment
          (Shared_Empty.Counter'Access);

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

      return Constructors.Create (Data);
   end To_Universal_String;

   ------------------
   -- To_Uppercase --
   ------------------

   function To_Uppercase (Self : Universal_String'Class)
     return Universal_String
   is
   begin
      if Self.Data.Length = 0 then
         return Universal_String (Self);
      end if;

      declare
         Locale : Matreshka.Internals.Locales.Locale_Data_Access
           := Matreshka.Internals.Locales.Get_Locale;
         Data   : not null Internal_String_Access
           := new Internal_String (Self.Data.Last);

      begin
         Matreshka.Internals.Unicode.Casing.Convert_Case
          (Locale,
           Self.Data,
           Matreshka.Internals.Ucd.Upper,
           Matreshka.Internals.Ucd.Has_Uppercase_Mapping,
           Data);
         Matreshka.Internals.Locales.Dereference (Locale);

         return Constructors.Create (Data);
      end;
   end To_Uppercase;

   ---------------------
   -- To_Utf16_String --
   ---------------------

   procedure To_Utf16_String
    (Source      : Wide_Wide_String;
     Destination : out Internal_String_Access)
   is
      Has_BMP       : Boolean := False;
      Has_Non_BMP   : Boolean := False;

      Double_Length : Boolean := False;
      --  True if Destination reserve space for double code unit representation
      --  of the source code points.

   begin
      Destination := new Internal_String (Source'Length);
      Destination.Length := Source'Length;

      for J in Source'Range loop
         if Is_Valid_Unicode_Code_Point
             (Wide_Wide_Character'Pos (Source (J)))
         then
            declare
               C : Code_Point := Wide_Wide_Character'Pos (Source (J));

            begin
               if C <= 16#FFFF# then
                  Destination.Last := Destination.Last + 1;
                  Destination.Value (Destination.Last) := Utf16_Code_Unit (C);
                  Has_BMP := True;

               else
                  if not Double_Length then
                     --  Reallocate buffer.

                     declare
                        Aux : constant not null Internal_String_Access
                          := new Internal_String (Source'Length * 2);

                     begin
                        Aux.Value (1 .. Destination.Last) :=
                          Destination.Value (1 .. Destination.Last);
                        Aux.Last := Destination.Last;
                        Aux.Length := Destination.Length;
                        Dereference (Destination);
                        Destination := Aux;

                        Double_Length := True;
                     end;
                  end if;

                  C := C - 16#1_0000#;

                  Destination.Last := Destination.Last + 1;
                  Destination.Value (Destination.Last) :=
                    Utf16_Code_Unit (High_Surrogate_First + C / 16#400#);

                  Destination.Last := Destination.Last + 1;
                  Destination.Value (Destination.Last) :=
                    Utf16_Code_Unit (Low_Surrogate_First + C mod 16#400#);

                  Has_Non_BMP := True;
               end if;
            end;

         else
            raise Constraint_Error
              with "Wide_Wide_Character is not a valid Unicode code point";
         end if;
      end loop;

      Destination.Index_Mode := To_Index_Mode (Has_BMP, Has_Non_BMP);

   exception
      when others =>
         Dereference (Destination);

         raise;
   end To_Utf16_String;

   ----------------------------
   -- To_Wide_Wide_Character --
   ----------------------------

   function To_Wide_Wide_Character
    (Self : Universal_Character)
       return Wide_Wide_Character
   is
   begin
      return Wide_Wide_Character'Val (Self.C);
   end To_Wide_Wide_Character;

   -------------------------
   -- To_Wide_Wide_String --
   -------------------------

   function To_Wide_Wide_String (Self : Universal_String'Class)
     return Wide_Wide_String
   is
      Result  : Wide_Wide_String (1 .. Self.Data.Length);
      Current : Positive := 1;
      Code    : Code_Point;

   begin
      for J in Result'Range loop
         Unchecked_Next (Self.Data.Value, Current, Code);
         Result (J) := Wide_Wide_Character'Val (Code);
      end loop;

      return Result;
   end To_Wide_Wide_String;

   ----------------------
   -- Unchecked_Append --
   ----------------------

   procedure Unchecked_Append
    (Data : in out Internal_String;
     Item : Wide_Wide_Character)
   is
      C             : Code_Point := Wide_Wide_Character'Pos (Item);
      Has_BMP       : Boolean    := False;
      Has_Non_BMP   : Boolean    := False;

   begin
      if C <= 16#FFFF# then
         Data.Last := Data.Last + 1;

      else
         Data.Last := Data.Last + 2;
      end if;

--      if Last > Value'Last then
--         declare
--            Aux : constant not null Utf16_String_Access
--              := new Utf16_String (1 .. Last);
--
--         begin
--            Aux (Value'Range) := Value.all;
--            Free (Value);
--            Value := Aux;
--         end;
--      end if;

      if C <= 16#FFFF# then
         Has_BMP      := True;
         Data.Value (Data.Last) := Utf16_Code_Unit (C);

      else
         Has_Non_BMP      := True;
         C                := C - 16#1_0000#;
         Data.Value (Data.Last - 1) :=
           Utf16_Code_Unit (High_Surrogate_First + C / 16#400#);
         Data.Value (Data.Last)     :=
           Utf16_Code_Unit (Low_Surrogate_First + C mod 16#400#);
      end if;

      Data.Index_Mode :=
        Index_Mode_After_Concatenation
         (Data.Index_Mode, To_Index_Mode (Has_BMP, Has_Non_BMP));
   end Unchecked_Append;

   -----------
   -- Write --
   -----------

   procedure Write
    (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
     Item   : Universal_String)
   is
   begin
      Integer'Write (Stream, Item.Data.Length);
      Integer'Write (Stream, Item.Data.Last);
      Matreshka.Internals.Utf16.Utf16_String'Write
       (Stream, Item.Data.Value (1 .. Item.Data.Last));
   end Write;

end Matreshka.Strings;
