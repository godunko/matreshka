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
-- Copyright © 2013-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
with League.Holders.Booleans;
with League.Holders.JSON_Arrays;
with League.Holders.JSON_Objects;
with League.JSON.Documents.Internals;
with League.JSON.Values.Internals;
with Matreshka.JSON_Documents;

package body League.JSON.Arrays is

   package Array_Iterable_Holder_Cursors is
      type Cursor is new League.Holders.Iterable_Holder_Cursors.Cursor
      with record
         Data  : JSON_Array;
         Index : Natural := 0;
      end record;

      overriding function Next (Self : in out Cursor) return Boolean;

      overriding function Element (Self : Cursor) return League.Holders.Holder;

   end Array_Iterable_Holder_Cursors;

   procedure To_Holder
    (Value   : League.JSON.Values.JSON_Value;
     Holder  : out League.Holders.Holder;
     Success : in out Boolean);
   --  Converts JSON_Value object to holder of corresponding type. Supported
   --  types are booleans, strings, numbers, arrays, and objects. For
   --  unsupported kinds of JSON_Value (empty and null) is resets Holder to
   --  empty state and sets Success to False.

   package body Array_Iterable_Holder_Cursors is

      -------------
      -- Element --
      -------------

      overriding function Element
       (Self : Cursor) return League.Holders.Holder
      is
         Result  : League.Holders.Holder;
         Success : Boolean := True;
      begin
         To_Holder (Self.Data.Element (Self.Index), Result, Success);

         return Result;
      end Element;

      ----------
      -- Next --
      ----------

      overriding function Next (Self : in out Cursor) return Boolean is
      begin
         Self.Index := Self.Index + 1;

         --  There is no corresponding value for 'null' JSON value, so stop
         --  iteration if we found a such value.
         return Self.Index <= Self.Data.Length
           and then Self.Data.Element (Self.Index).Kind not in
                      League.JSON.Values.Null_Value;
      end Next;

   end Array_Iterable_Holder_Cursors;

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out JSON_Array) is
   begin
      Matreshka.JSON_Types.Reference (Self.Data);
   end Adjust;

   ------------
   -- Append --
   ------------

   procedure Append
    (Self : in out JSON_Array'Class; Value : League.JSON.Values.JSON_Value)
   is
      Aux : constant Matreshka.JSON_Types.Shared_JSON_Value_Access
        := League.JSON.Values.Internals.Internal (Value);

   begin
      Matreshka.JSON_Types.Mutate (Self.Data);
      Matreshka.JSON_Types.Reference (Aux);
      Self.Data.Values.Append (Aux);
   end Append;

   ------------
   -- Delete --
   ------------

   procedure Delete (Self : in out JSON_Array'Class; Index : Positive) is
      Aux : Matreshka.JSON_Types.Shared_JSON_Value_Access;

   begin
      if Index
           in Self.Data.Values.First_Index .. Self.Data.Values.Last_Index
      then
         Matreshka.JSON_Types.Mutate (Self.Data);
         Aux := Self.Data.Values.Element (Index);
         Self.Data.Values.Delete (Index);
         Matreshka.JSON_Types.Dereference (Aux);
      end if;
   end Delete;

   ------------------
   -- Delete_First --
   ------------------

   procedure Delete_First (Self : in out JSON_Array'Class) is
      Aux : Matreshka.JSON_Types.Shared_JSON_Value_Access;

   begin
      if not Self.Data.Values.Is_Empty then
         Matreshka.JSON_Types.Mutate (Self.Data);
         Aux := Self.Data.Values.First_Element;
         Self.Data.Values.Delete_First;
         Matreshka.JSON_Types.Dereference (Aux);
      end if;
   end Delete_First;

   -----------------
   -- Delete_Last --
   -----------------

   procedure Delete_Last (Self : in out JSON_Array'Class) is
      Aux : Matreshka.JSON_Types.Shared_JSON_Value_Access;

   begin
      if not Self.Data.Values.Is_Empty then
         Matreshka.JSON_Types.Mutate (Self.Data);
         Aux := Self.Data.Values.Last_Element;
         Self.Data.Values.Delete_Last;
         Matreshka.JSON_Types.Dereference (Aux);
      end if;
   end Delete_Last;

   -------------
   -- Element --
   -------------

   function Element
    (Self  : JSON_Array'Class;
     Index : Positive) return League.JSON.Values.JSON_Value is
   begin
      if Index
           in Self.Data.Values.First_Index .. Self.Data.Values.Last_Index
      then
         return
           League.JSON.Values.Internals.Create
            (Self.Data.Values.Element (Index));

      else
         return League.JSON.Values.Empty_JSON_Value;
      end if;
   end Element;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out JSON_Array) is
      use type Matreshka.JSON_Types.Shared_JSON_Array_Access;

   begin
      if Self.Data /= null then
         Matreshka.JSON_Types.Dereference (Self.Data);
      end if;
   end Finalize;

   -----------
   -- First --
   -----------

   function First
    (Self : aliased JSON_Array)
       return League.Holders.Iterable_Holder_Cursors.Cursor'Class is
   begin
      return Array_Iterable_Holder_Cursors.Cursor'(Self, 0);
   end First;

   -------------------
   -- First_Element --
   -------------------

   function First_Element
    (Self : JSON_Array'Class) return League.JSON.Values.JSON_Value is
   begin
      if not Self.Data.Values.Is_Empty then
         return
           League.JSON.Values.Internals.Create
            (Self.Data.Values.First_Element);

      else
         return League.JSON.Values.Empty_JSON_Value;
      end if;
   end First_Element;

   ------------
   -- Insert --
   ------------

   procedure Insert
    (Self  : in out JSON_Array'Class;
     Index : Positive;
     Value : League.JSON.Values.JSON_Value)
   is
      Aux : constant Matreshka.JSON_Types.Shared_JSON_Value_Access
        := League.JSON.Values.Internals.Internal (Value);

   begin
      if Index
           in Self.Data.Values.First_Index .. Self.Data.Values.Last_Index
      then
         Matreshka.JSON_Types.Mutate (Self.Data);
         Matreshka.JSON_Types.Reference (Aux);
         Self.Data.Values.Insert (Index, Aux);
      end if;
   end Insert;

   --------------
   -- Is_Empty --
   --------------

   function Is_Empty (Self : JSON_Array'Class) return Boolean is
   begin
      return Self.Data.Values.Is_Empty;
   end Is_Empty;

   ------------------
   -- Last_Element --
   ------------------

   function Last_Element
    (Self : JSON_Array'Class) return League.JSON.Values.JSON_Value is
   begin
      if not Self.Data.Values.Is_Empty then
         return
           League.JSON.Values.Internals.Create (Self.Data.Values.Last_Element);

      else
         return League.JSON.Values.Empty_JSON_Value;
      end if;
   end Last_Element;

   ------------
   -- Length --
   ------------

   function Length (Self : JSON_Array'Class) return Natural is
   begin
      return Natural (Self.Data.Values.Length);
   end Length;

   -------------
   -- Prepend --
   -------------

   procedure Prepend
    (Self : in out JSON_Array'Class; Value : League.JSON.Values.JSON_Value)
   is
      Aux : constant Matreshka.JSON_Types.Shared_JSON_Value_Access
        := League.JSON.Values.Internals.Internal (Value);

   begin
      Matreshka.JSON_Types.Mutate (Self.Data);
      Matreshka.JSON_Types.Reference (Aux);
      Self.Data.Values.Prepend (Aux);
   end Prepend;

   -------------
   -- Replace --
   -------------

   procedure Replace
    (Self  : in out JSON_Array'Class;
     Index : Positive;
     Value : League.JSON.Values.JSON_Value)
   is
      New_Value : constant Matreshka.JSON_Types.Shared_JSON_Value_Access
        := League.JSON.Values.Internals.Internal (Value);
      Old_Value : Matreshka.JSON_Types.Shared_JSON_Value_Access;

   begin
      if Index
           in Self.Data.Values.First_Index .. Self.Data.Values.Last_Index
      then
         Matreshka.JSON_Types.Mutate (Self.Data);
         Matreshka.JSON_Types.Reference (New_Value);
         Old_Value := Self.Data.Values.Element (Index);
         Self.Data.Values.Replace_Element (Index, New_Value);
         Matreshka.JSON_Types.Dereference (Old_Value);
      end if;
   end Replace;

   ----------
   -- Take --
   ----------

   function Take
    (Self  : in out JSON_Array'Class;
     Index : Positive) return League.JSON.Values.JSON_Value
   is
      Old_Value : Matreshka.JSON_Types.Shared_JSON_Value_Access;

   begin
      if Index
           in Self.Data.Values.First_Index .. Self.Data.Values.Last_Index
      then
         Matreshka.JSON_Types.Mutate (Self.Data);
         Old_Value := Self.Data.Values.Element (Index);
         Self.Data.Values.Delete (Index);

         return League.JSON.Values.Internals.Wrap (Old_Value);

      else
         return League.JSON.Values.Empty_JSON_Value;
      end if;
   end Take;

   ---------------
   -- To_Holder --
   ---------------

   procedure To_Holder
    (Value   : League.JSON.Values.JSON_Value;
     Holder  : out League.Holders.Holder;
     Success : in out Boolean) is
   begin
      case Value.Kind is
         when League.JSON.Values.Empty_Value =>
            League.Holders.Clear (Holder);
            Success := False;

            return;

         when League.JSON.Values.Boolean_Value =>
            Holder := League.Holders.Booleans.To_Holder (Value.To_Boolean);

         when League.JSON.Values.Number_Value =>
            if Value.Is_Integer_Number then
               League.Holders.Set_Tag
                (Holder, League.Holders.Universal_Integer_Tag);
               League.Holders.Replace_Element (Holder, Value.To_Integer);

            else
               League.Holders.Set_Tag
                (Holder, League.Holders.Universal_Float_Tag);
               League.Holders.Replace_Element (Holder, Value.To_Float);
            end if;

         when League.JSON.Values.String_Value =>
            Holder := League.Holders.To_Holder (Value.To_String);

         when League.JSON.Values.Array_Value =>
            Holder := League.Holders.JSON_Arrays.To_Holder (Value.To_Array);

         when League.JSON.Values.Object_Value =>
            Holder := League.Holders.JSON_Objects.To_Holder (Value.To_Object);

         when League.JSON.Values.Null_Value =>
            League.Holders.Clear (Holder);
            Success := False;

            return;
      end case;
   end To_Holder;

   ----------------------
   -- To_JSON_Document --
   ----------------------

   function To_JSON_Document
    (Self : JSON_Array'Class) return League.JSON.Documents.JSON_Document is
   begin
      Matreshka.JSON_Types.Reference (Self.Data);

      return
        League.JSON.Documents.Internals.Wrap
         (new Matreshka.JSON_Documents.Shared_JSON_Document'
               (Counter      => <>,
                Array_Value  => Self.Data,
                Object_Value => null));
   end To_JSON_Document;

   -------------------
   -- To_JSON_Value --
   -------------------

   function To_JSON_Value
    (Self : JSON_Array'Class) return League.JSON.Values.JSON_Value is
   begin
      Matreshka.JSON_Types.Reference (Self.Data);

      return
        League.JSON.Values.Internals.Wrap
         (new Matreshka.JSON_Types.Shared_JSON_Value'
               (Counter => <>,
                Value   =>
                 (Kind        => Matreshka.JSON_Types.Array_Value,
                  Array_Value => Self.Data)));
   end To_JSON_Value;

end League.JSON.Arrays;
