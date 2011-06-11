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
with Ada.Unchecked_Conversion;
with System;

with League.Text_Codecs;
with Matreshka.Internals.SQL_Parameter_Rewriters.PostgreSQL;

package body Matreshka.Internals.SQL_Drivers.PostgreSQL.Queries is

   use type Interfaces.C.int;

   Codec    : constant League.Text_Codecs.Text_Codec
     := League.Text_Codecs.Codec
         (League.Strings.To_Universal_String ("UTF-8"));
   --  It is used everywhere to convert text data, PostgreSQL_Database is
   --  responsible to set client encodings to UTF-8.
   Rewriter : SQL_Parameter_Rewriters.PostgreSQL.PostgreSQL_Parameter_Rewriter;
   --  SQL statement parameter rewriter.

   ----------------
   -- Bind_Value --
   ----------------

   overriding procedure Bind_Value
    (Self      : not null access PostgreSQL_Query;
     Name      : League.Strings.Universal_String;
     Value     : League.Holders.Holder;
     Direction : SQL.Parameter_Directions) is
   begin
      Self.Parameters.Set_Value (Name, Value);
   end Bind_Value;

   -----------------
   -- Bound_Value --
   -----------------

   overriding function Bound_Value
    (Self : not null access PostgreSQL_Query;
     Name : League.Strings.Universal_String)
       return League.Holders.Holder is
   begin
      return League.Holders.Empty_Holder;
   end Bound_Value;

   -------------------
   -- Error_Message --
   -------------------

   overriding function Error_Message
    (Self : not null access PostgreSQL_Query)
       return League.Strings.Universal_String is
   begin
      return Self.Error;
   end Error_Message;

   -------------
   -- Execute --
   -------------

   overriding function Execute
    (Self : not null access PostgreSQL_Query) return Boolean
   is
      Value  : League.Holders.Holder;
      Params : Interfaces.C.Strings.chars_ptr_array
                (1 .. Interfaces.C.size_t
                       (Self.Parameters.Number_Of_Positional));

   begin
      --  Prepare parameter values.

      for J in Params'Range loop
         Value := Self.Parameters.Value (Positive (J));

         if League.Holders.Is_Empty (Value) then
            Params (J) := Interfaces.C.Strings.Null_Ptr;

         elsif League.Holders.Is_Universal_String (Value) then
            Params (J) :=
              Databases.New_String (League.Holders.Element (Value));

         elsif League.Holders.Is_Abstract_Integer (Value) then
            Params (J) :=
              Interfaces.C.Strings.New_String
               (League.Holders.Universal_Integer'Image
                 (League.Holders.Element (Value)));

         elsif League.Hilders.Is_Abstract_Float (Value) then
            Params (J) :=
              Interfaces.C.Strings.New_String
               (League.Holders.Universal_Float'Image
                 (League.Holders.Element (Value)));
         end if;
      end loop;

      --  Execute statement with prepared parameters.

      Self.Result :=
        PQexecPrepared
         (Databases.PostgreSQL_Database'Class (Self.Database.all).Handle,
          Self.Name,
          Params'Length,
          Params,
          null,
          null,
          0);

      --  Release parameter values.

      for J in Params'Range loop
         Interfaces.C.Strings.Free (Params (J));
      end loop;

      --  "The result is a PGresult pointer or possibly a null pointer. A
      --  non-null pointer will generally be returned except in out-of-memory
      --  conditions or serious errors such as inability to send the command to
      --  the server. If a null pointer is returned, it should be treated like
      --  a PGRES_FATAL_ERROR result. Use PQerrorMessage to get more
      --  information about such errors."

      --  Handle fatal error.

      if Self.Result = null then
         --  Obtain current error message.

         Self.Error :=
           Databases.PostgreSQL_Database'Class
            (Self.Database.all).Get_Error_Message;

         return False;
      end if;

      --  Handle non-fatal errors.

      case PQresultStatus (Self.Result) is
         when PGRES_COMMAND_OK
           | PGRES_TUPLES_OK
         =>
            Self.Row := -1;

         when others =>
            --  Obtain error message.

            Self.Error :=
              Databases.PostgreSQL_Database'Class
               (Self.Database.all).Get_Error_Message;

            --  Cleanup.

            PQclear (Self.Result);
            Self.Result := null;

            return False;
      end case;

      return True;
   end Execute;

   ------------
   -- Finish --
   ------------

   overriding procedure Finish (Self : not null access PostgreSQL_Query) is
   begin
      raise Program_Error;
   end Finish;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self     : not null access PostgreSQL_Query'Class;
     Database : not null access Databases.PostgreSQL_Database'Class) is
   begin
      SQL_Drivers.Initialize (Self, Database_Access (Database));
   end Initialize;

   ----------------
   -- Invalidate --
   ----------------

   overriding procedure Invalidate (Self : not null access PostgreSQL_Query) is
   begin
      if Self.Database /= null then
         Interfaces.C.Strings.Free (Self.Name);

         if Self.Result /= null then
            PQclear (Self.Result);
            Self.Result := null;
         end if;
      end if;

      --  Call Invalidate of parent tagged type.

      Abstract_Query (Self.all).Invalidate;
   end Invalidate;

   ---------------
   -- Is_Active --
   ---------------

   overriding function Is_Active
    (Self : not null access PostgreSQL_Query) return Boolean is
   begin
      return Self.Result /= null;
   end Is_Active;

   ----------
   -- Next --
   ----------

   overriding function Next
    (Self : not null access PostgreSQL_Query) return Boolean is
   begin
      if Self.Row + 1 < PQntuples (Self.Result) then
         Self.Row := Self.Row + 1;

         return True;

      else
         return False;
      end if;
   end Next;

   -------------
   -- Prepare --
   -------------

   overriding function Prepare
    (Self  : not null access PostgreSQL_Query;
     Query : League.Strings.Universal_String) return Boolean
   is
      use type Interfaces.C.Strings.chars_ptr;

      Rewritten : League.Strings.Universal_String;
      C_Query   : Interfaces.C.Strings.chars_ptr;
      Result    : PGresult_Access;

   begin
      --  Clear existing result set.

      if Self.Result /= null then
         PQclear (Self.Result);
         Self.Result := null;
      end if;

      --  Rewrite statement and prepare set of parameters.

      Rewriter.Rewrite (Query, Rewritten, Self.Parameters);

      --  Convert rewrittent statement into string in client library format.

      C_Query := Databases.New_String (Rewritten);

      --  Allocates name for the statement when it is not allocated.

      if Self.Name = Interfaces.C.Strings.Null_Ptr then
         Self.Name :=
           Databases.PostgreSQL_Database'Class
            (Self.Database.all).Allocate_Statement_Name;
      end if;

      --  Prepare statement and let server to handle parameters' types.

      Result :=
        PQprepare
         (Databases.PostgreSQL_Database'Class (Self.Database.all).Handle,
          Self.Name,
          C_Query,
          0,
          null);

      --  Cleanup.

      Interfaces.C.Strings.Free (C_Query);

      --  "The result is normally a PGresult object whose contents indicate
      --  server-side success or failure. A null result indicates out-of-memory
      --  or inability to send the command at all. Use PQerrorMessage to get
      --  more information about such errors."

      --  Handle fatal error.

      if Result = null then
         --  Obtain error message.

         Self.Error :=
           Databases.PostgreSQL_Database'Class
            (Self.Database.all).Get_Error_Message;

         --  Cleanup.

         Interfaces.C.Strings.Free (Self.Name);

         return False;
      end if;

      --  Handle non-fatal errors.

      if PQresultStatus (Result) /= PGRES_COMMAND_OK then
         --  Obtain error message.

         Self.Error :=
           Databases.PostgreSQL_Database'Class
            (Self.Database.all).Get_Error_Message;

         --  Cleanup.

         Interfaces.C.Strings.Free (Self.Name);
         PQclear (Result);

         return False;
      end if;

      --  Local cleanup.

      PQclear (Result);

      return True;
   end Prepare;

   -----------
   -- Value --
   -----------

   overriding function Value
    (Self  : not null access PostgreSQL_Query;
     Index : Positive) return League.Holders.Holder
   is
      Column : constant Interfaces.C.int := Interfaces.C.int (Index - 1);
      Value  : League.Holders.Holder;

   begin
      case Databases.PostgreSQL_Database'Class
            (Self.Database.all).Get_Type (PQftype (Self.Result, Column))
      is
         when Databases.Text_Data =>
            --  Process text data.

            League.Holders.Set_Tag
             (Value, League.Holders.Universal_String_Tag);

            if PQgetisnull (Self.Result, Self.Row, Column) = 0 then
               declare
                  function To_Address is
                    new Ada.Unchecked_Conversion
                         (Interfaces.C.Strings.chars_ptr, System.Address);

                  S : Ada.Streams.Stream_Element_Array
                       (1 .. Ada.Streams.Stream_Element_Offset
                              (PQgetlength (Self.Result, Self.Row, Column)));
                  for S'Address use
                    To_Address (PQgetvalue (Self.Result, Self.Row, Column));
                  pragma Import (Ada, S);

               begin
                  League.Holders.Replace_Element (Value, Codec.Decode (S));
               end;
            end if;

         when Databases.Integer_Data =>
            --  Process integer data.

            League.Holders.Set_Tag
             (Value, League.Holders.Universal_Integer_Tag);

            if PQgetisnull (Self.Result, Self.Row, Column) = 0 then
               declare
                  Image : constant String
                    := Interfaces.C.Strings.Value
                        (PQgetvalue (Self.Result, Self.Row, Column));

               begin
                  League.Holders.Set
                   (Value, League.Holders.Universal_Integer'Value (Image));
               end;
            end if;

         when Databases.Float_Data =>
            --  Process float data.

            League.Holders.Set_Tag (Value, League.Holders.Universal_Float_Tag);

            if PQgetisnull (Self.Result, Self.Row, Column) = 0 then
               declare
                  Image : constant String
                    := Interfaces.C.Strings.Value
                        (PQgetvalue (Self.Result, Self.Row, Column));

               begin
                  League.Holders.Replace_Element
                   (Value, League.Holders.Universal_Float'Value (Image));
               end;
            end if;
      end case;

      return Value;
   end Value;

end Matreshka.Internals.SQL_Drivers.PostgreSQL.Queries;
