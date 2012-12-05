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
-- Copyright © 2012, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Matreshka.Internals.SQL_Drivers.MySQL.Databases;

package body Matreshka.Internals.SQL_Drivers.MySQL.Queries is

   use type Interfaces.C.int;

   procedure Set_MySQL_Stmt_Error (Self : not null access MySQL_Query'Class);
   --  Sets error message to reported by database.

--   procedure Set_MySQL_Error (Self : not null access MySQL_Database'Class);
   --  Sets error message to reported by database.

   ----------------
   -- Bind_Value --
   ----------------

   overriding procedure Bind_Value
    (Self      : not null access MySQL_Query;
     Name      : League.Strings.Universal_String;
     Value     : League.Holders.Holder;
     Direction : SQL.Parameter_Directions) is
   begin
      raise Program_Error;
   end Bind_Value;

   -----------------
   -- Bound_Value --
   -----------------

   overriding function Bound_Value
    (Self : not null access MySQL_Query;
     Name : League.Strings.Universal_String)
       return League.Holders.Holder is
   begin
      raise Program_Error;
      return League.Holders.Empty_Holder;
   end Bound_Value;

   -------------------
   -- Error_Message --
   -------------------

   overriding function Error_Message
    (Self : not null access MySQL_Query)
       return League.Strings.Universal_String is
   begin
      return Self.Error;
   end Error_Message;

   -------------
   -- Execute --
   -------------

   overriding function Execute
    (Self : not null access MySQL_Query) return Boolean is
   begin
      if mysql_stmt_execute (Self.Handle) /= 0 then
         Self.Set_MySQL_Stmt_Error;

         return False;
      end if;

      return True;
   end Execute;

   ------------
   -- Finish --
   ------------

   overriding procedure Finish (Self : not null access MySQL_Query) is
   begin
      raise Program_Error;
   end Finish;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self     : not null access MySQL_Query'Class;
     Database : not null access Databases.MySQL_Database'Class) is
   begin
      SQL_Drivers.Initialize (Self, Database_Access (Database));
   end Initialize;

   ----------------
   -- Invalidate --
   ----------------

   overriding procedure Invalidate (Self : not null access MySQL_Query) is
   begin
      if Self.Database /= null and Self.Handle /= null then
         if mysql_stmt_close (Self.Handle) /= 0 then
            Self.Set_MySQL_Stmt_Error;
         end if;
      end if;

      --  Call Invalidate of parent tagged type.

      Abstract_Query (Self.all).Invalidate;
   end Invalidate;

   ---------------
   -- Is_Active --
   ---------------

   overriding function Is_Active
    (Self : not null access MySQL_Query) return Boolean is
   begin
      raise Program_Error;
      return False;
   end Is_Active;

   ----------
   -- Next --
   ----------

   overriding function Next
    (Self : not null access MySQL_Query) return Boolean is
   begin
      raise Program_Error;
      return False;
   end Next;

   -------------
   -- Prepare --
   -------------

   overriding function Prepare
    (Self  : not null access MySQL_Query;
     Query : League.Strings.Universal_String) return Boolean
   is
      C_Query : Interfaces.C.Strings.chars_ptr
        := Interfaces.C.Strings.New_String (Query.To_UTF_8_String);

   begin
      --  Allocate statement.

      Self.Handle :=
        mysql_stmt_init
         (Databases.MySQL_Database'Class (Self.Database.all).Database_Handle);

      if Self.Handle = null then
         Self.Error := League.Strings.To_Universal_String ("out of memory");

         return False;
      end if;

      --  Prepare statement.

      if mysql_stmt_prepare
          (Self.Handle,
           C_Query,
           Interfaces.C.unsigned_long
            (Interfaces.C.Strings.Strlen (C_Query))) /= 0
      then
         Interfaces.C.Strings.Free (C_Query);
         Self.Set_MySQL_Stmt_Error;

         return False;
      end if;

      Interfaces.C.Strings.Free (C_Query);

      return True;
   end Prepare;

--   ---------------------
--   -- Set_MySQL_Error --
--   ---------------------
--
--   procedure Set_MySQL_Error (Self : not null access MySQL_Query'Class) is
--      Error : constant String
--        := Interfaces.C.Strings.Value (mysql_error (Self.Database.Handle));
--
--   begin
--      Self.Error := League.Strings.From_UTF_8_String (Error);
--   end Set_MySQL_Error;

   --------------------------
   -- Set_MySQL_Stmt_Error --
   --------------------------

   procedure Set_MySQL_Stmt_Error (Self : not null access MySQL_Query'Class) is
      Error : constant String
        := Interfaces.C.Strings.Value (mysql_stmt_error (Self.Handle));

   begin
      Self.Error := League.Strings.From_UTF_8_String (Error);
   end Set_MySQL_Stmt_Error;

   -----------
   -- Value --
   -----------

   overriding function Value
    (Self  : not null access MySQL_Query;
     Index : Positive) return League.Holders.Holder is
   begin
      raise Program_Error;
      return League.Holders.Empty_Holder;
   end Value;

end Matreshka.Internals.SQL_Drivers.MySQL.Queries;
