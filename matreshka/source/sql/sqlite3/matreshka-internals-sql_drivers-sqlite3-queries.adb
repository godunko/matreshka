------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                           SQL Database Access                            --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2011, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Ada.Streams;
with Interfaces.C;

with League.Strings.Internals;
with League.Text_Codecs;
with Matreshka.Internals.Strings;
with Matreshka.Internals.Unicode;
with Matreshka.Internals.Strings.C;

package body Matreshka.Internals.SQL_Drivers.SQLite3.Queries is

   use type Interfaces.C.int;
   use type Matreshka.Internals.Utf16.Utf16_String_Index;

   procedure Call
    (Self : not null access SQLite3_Query'Class;
     Code : Interfaces.C.int);
   --  Process return code, constructs error message when code is error.

   function To_Universal_String
    (Text   : Matreshka.Internals.Strings.C.Utf16_Code_Unit_Access;
     Length : Matreshka.Internals.Utf16.Utf16_String_Index)
       return League.Strings.Universal_String;
   --  Converts text starting at specified position with specified length into
   --  Universal_String.

   Codec : constant League.Text_Codecs.Text_Codec
     := League.Text_Codecs.Codec
         (League.Strings.To_Universal_String ("utf-8"));
   --  Codec to convert Universal_String into UTF-8 encoding. It is used to
   --  convert parameter name. Unfortunately, SQLite3 doesn't provide relevant
   --  UTF-16 version of function.

   ----------------
   -- Bind_Value --
   ----------------

   overriding procedure Bind_Value
    (Self      : not null access SQLite3_Query;
     Name      : League.Strings.Universal_String;
     Value     : League.Values.Value;
     Direction : SQL.Parameter_Directions)
   is
      use type Ada.Streams.Stream_Element_Array;

      U_Name : constant Ada.Streams.Stream_Element_Array
        := Codec.Encode (Name).To_Stream_Element_Array & 0;
      C_Name : Interfaces.C.char_array (1 .. U_Name'Length);
      for C_Name'Address use U_Name'Address;
      pragma Import (Ada, C_Name);
      Index  : Interfaces.C.int;

   begin
      if Self.Handle = null then
         --  Statement was not prepared.

         return;
      end if;

      Index := sqlite3_bind_parameter_index (Self.Handle, C_Name);

      if Index = 0 then
         --  There is no parameter with specified name.

         return;
      end if;

      Self.Parameters.Include (Name, Value);

      if League.Values.Is_Empty (Value) then
         --  Bind NULL value of any type (SQLite3 doesn't distinguish type of
         --  NULL value).

         Self.Call (sqlite3_bind_null (Self.Handle, Index));

      elsif League.Values.Is_Universal_String (Value) then
         --  Bind text value.

         Self.Call
          (sqlite3_bind_text16
            (Self.Handle,
             Index,
             League.Strings.Internals.Internal
              (League.Values.Get (Value)).Value (0)'Access,
             Interfaces.C.int
              (League.Strings.Internals.Internal
                (League.Values.Get (Value)).Unused * 2),
             null));
         --  Copy of string value is stored in the parameters map, so provides
	 --  warranty that it will not be deallocated/modified till another
         --  value will be bind. As result, copy of string data is not needed.

      elsif League.Values.Is_Abstract_Integer (Value) then
         --  Bind integer value.

         Self.Call
          (sqlite3_bind_int64 (Self.Handle, Index, League.Values.Get (Value)));

      elsif League.Values.Is_Abstract_Float (Value) then
         --  Bind float value.

         Self.Call
          (sqlite3_bind_double
            (Self.Handle,
             Index,
             Interfaces.C.double
              (League.Values.Universal_Float'(League.Values.Get (Value)))));
      end if;
   end Bind_Value;

   ----------
   -- Call --
   ----------

   procedure Call
    (Self : not null access SQLite3_Query'Class;
     Code : Interfaces.C.int) is
   begin
      --  Clear previous error state.

      Self.Success := True;
      Self.Error.Clear;

      case Code is
         when SQLITE_OK =>
            --  Operation executed successfully.

            null;

         when SQLITE_DONE =>
            --  When operation can retrieve row this reasult means that there
            --  is no row retrived.

            Self.Has_Row := False;

         when SQLITE_ROW =>
            --  When operation can retrieve row this reasult means that there
            --  is row retrived.

            Self.Has_Row := True;

         when others =>
            --  All others return codes are errors.

            Self.Success := False;
            Self.Error :=
              Matreshka.Internals.Strings.C.To_Valid_Universal_String
               (sqlite3_errmsg16
                 (Databases.SQLite3_Database'Class
                   (Self.Database.all).Database_Handle));
      end case;
   end Call;

   -------------------
   -- Error_Message --
   -------------------

   overriding function Error_Message
    (Self : not null access SQLite3_Query)
       return League.Strings.Universal_String is
   begin
      return Self.Error;
   end Error_Message;

   -------------
   -- Execute --
   -------------

   overriding function Execute
    (Self : not null access SQLite3_Query) return Boolean is
   begin
      if Self.Handle = null then
         --  Statement was not prepared.

         return False;
      end if;

      if Self.Is_Active then
         --  Finish execution of the current statement when it is active.

         Self.Finish;
      end if;

      Self.Call (sqlite3_step (Self.Handle));
      Self.Skip_Step := Self.Has_Row;

      if Self.Success then
         Self.Is_Active := True;
      end if;

      return Self.Success;
   end Execute;

   ------------
   -- Finish --
   ------------

   overriding procedure Finish (Self : not null access SQLite3_Query) is
   begin
      if not Self.Is_Active then
         --  Returns when query is not active.

         return;
      end if;

      Self.Call (sqlite3_reset (Self.Handle));
      Self.Is_Active := False;
   end Finish;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self     : not null access SQLite3_Query'Class;
     Database : not null access Databases.SQLite3_Database'Class) is
   begin
      SQL_Drivers.Initialize (Self, Database_Access (Database));
   end Initialize;

   ----------------
   -- Invalidate --
   ----------------

   overriding procedure Invalidate (Self : not null access SQLite3_Query) is
   begin
      if Self.Database /= null then
         if Self.Handle /= null then
            Self.Call (sqlite3_finalize (Self.Handle));
            Self.Handle := null;
         end if;
      end if;

      --  Call Invalidate of parent tagged type.

      Abstract_Query (Self.all).Invalidate;
   end Invalidate;

   ---------------
   -- Is_Active --
   ---------------

   overriding function Is_Active
    (Self : not null access SQLite3_Query) return Boolean is
   begin
      return Self.Is_Active;
   end Is_Active;

   ----------
   -- Next --
   ----------

   overriding function Next
    (Self : not null access SQLite3_Query) return Boolean is
   begin
      if not Self.Is_Active then
         --  Returns immidiatly when statement is not active.

         return False;
      end if;

      if Self.Skip_Step then
         Self.Skip_Step := False;

      elsif Self.Has_Row then
         Self.Call (sqlite3_step (Self.Handle));
      end if;

      return Self.Has_Row;
   end Next;

   -------------
   -- Prepare --
   -------------

   overriding function Prepare
    (Self  : not null access SQLite3_Query;
     Query : League.Strings.Universal_String) return Boolean
   is
      Aux : aliased Matreshka.Internals.Strings.C.Utf16_Code_Unit_Access;

   begin
      if Self.Handle /= null then
         --  Release existing handle.

         Self.Call (sqlite3_finalize (Self.Handle));
         Self.Handle := null;
      end if;

      --  Note: http://www.sqlite.org/c3ref/prepare.html
      --
      --  "If the caller knows that the supplied string is nul-terminated, then
      --  there is a small performance advantage to be gained by passing an
      --  nByte parameter that is equal to the number of bytes in the input
      --  string including the nul-terminator bytes."
      --
      --  And it's exactly our case.

      Self.Call
       (sqlite3_prepare16_v2
         (Databases.SQLite3_Database'Class (Self.Database.all).Database_Handle,
          League.Strings.Internals.Internal (Query).Value,
          Interfaces.C.int
           ((League.Strings.Internals.Internal (Query).Unused + 1) * 2),
          Self.Handle'Unchecked_Access,
          Aux'Unchecked_Access));
      Self.Is_Active := False;

      return Self.Success;
   end Prepare;

   -------------------------
   -- To_Universal_String --
   -------------------------

   function To_Universal_String
    (Text   : Matreshka.Internals.Strings.C.Utf16_Code_Unit_Access;
     Length : Matreshka.Internals.Utf16.Utf16_String_Index)
       return League.Strings.Universal_String
   is
      Source   :
        Matreshka.Internals.Utf16.Unaligned_Utf16_String (0 .. Length - 1);
      for Source'Address use Text.all'Address;
      pragma Import (Ada, Source);
      Position : Matreshka.Internals.Utf16.Utf16_String_Index := 0;
      Code     : Matreshka.Internals.Unicode.Code_Point;
      Aux      : Matreshka.Internals.Strings.Shared_String_Access
        := Matreshka.Internals.Strings.Allocate (Length);

   begin
      while Position <= Source'Last loop
         Matreshka.Internals.Utf16.Unchecked_Next (Source, Position, Code);
         Matreshka.Internals.Utf16.Unchecked_Store
          (Aux.Value, Aux.Unused, Code);
         Aux.Length := Aux.Length + 1;
      end loop;

      return League.Strings.Internals.Wrap (Aux);
   end To_Universal_String;

   -----------
   -- Value --
   -----------

   overriding function Value
    (Self  : not null access SQLite3_Query;
     Index : Positive) return League.Values.Value
   is
      Text   : Matreshka.Internals.Strings.C.Utf16_Code_Unit_Access;
      Length : Matreshka.Internals.Utf16.Utf16_String_Index;
      Value  : League.Values.Value;

   begin
      case sqlite3_column_type (Self.Handle, Interfaces.C.int (Index - 1)) is
         when SQLITE_INTEGER =>
            --  Create universal integer value.

            League.Values.Set_Tag (Value, League.Values.Universal_Integer_Tag);
            League.Values.Set
             (Value,
              sqlite3_column_int64
               (Self.Handle, Interfaces.C.int (Index - 1)));

         when SQLITE_FLOAT =>
            --  Create universal float value.

            League.Values.Set_Tag (Value, League.Values.Universal_Float_Tag);
            League.Values.Set
             (Value,
              League.Values.Universal_Float
               (sqlite3_column_double
                 (Self.Handle, Interfaces.C.int (Index - 1))));

         when SQLITE_TEXT =>
            --  Create universal string value.

            Text :=
              sqlite3_column_text16
               (Self.Handle, Interfaces.C.int (Index - 1));
            Length :=
              Matreshka.Internals.Utf16.Utf16_String_Index
               (sqlite3_column_bytes16
                 (Self.Handle, Interfaces.C.int (Index - 1)));

            League.Values.Set_Tag (Value, League.Values.Universal_String_Tag);
            League.Values.Set (Value, To_Universal_String (Text, Length / 2));

         when SQLITE_BLOB =>
            --  Not supported yet.

            null;

         when SQLITE_NULL =>
            --  Value is initialized to be empty by default.

            null;

         when others =>
            null;
      end case;

      return Value;
   end Value;

end Matreshka.Internals.SQL_Drivers.SQLite3.Queries;
