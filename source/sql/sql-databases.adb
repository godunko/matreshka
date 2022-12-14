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
-- Copyright © 2011-2012, Vadim Godunko <vgodunko@gmail.com>                --
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
with League.Text_Codecs;
with SQL.Queries.Internals;

package body SQL.Databases is

   procedure Raise_SQL_Error
    (Self : in out SQL_Database'Class; Success : Boolean);
   --  Raises SQL_Error when Success is not equal to True. Constructs exception
   --  message from Error_Message of query.

--   ------------
--   -- Adjust --
--   ------------
--
--   overriding procedure Adjust (Self : in out SQL_Database) is
--   begin
--      Matreshka.Internals.SQL_Databases.Reference (Self.Data);
--   end Adjust;

   -----------
   -- Close --
   -----------

   procedure Close (Self : in out SQL_Database'Class) is
   begin
      null;
   end Close;

   ------------
   -- Commit --
   ------------

   procedure Commit (Self : in out SQL_Database'Class) is
   begin
      Self.Data.Commit;
   end Commit;

   ------------
   -- Create --
   ------------

   function Create
    (Driver  : League.Strings.Universal_String;
     Options : SQL.Options.SQL_Options) return SQL_Database is
   begin
      return
       (Ada.Finalization.Limited_Controlled with
          Matreshka.Internals.SQL_Drivers.Create (Driver),
          Options);
   end Create;

   -------------------
   -- Error_Message --
   -------------------

   function Error_Message
    (Self : SQL_Database'Class) return League.Strings.Universal_String is
   begin
      return Self.Data.Error_Message;
   end Error_Message;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out SQL_Database) is
      use type Matreshka.Internals.SQL_Drivers.Database_Access;

   begin
      --  Finalize must be idempotent according to language rules.

      if Self.Data /= null then
         Matreshka.Internals.SQL_Drivers.Dereference (Self.Data);
      end if;
   end Finalize;

   ----------
   -- Open --
   ----------

   function Open (Self : in out SQL_Database'Class) return Boolean is
   begin
      return Self.Data.Open (Self.Options);
   end Open;

   ----------
   -- Open --
   ----------

   procedure Open (Self : in out SQL_Database'Class) is
   begin
      Self.Raise_SQL_Error (Self.Data.Open (Self.Options));
   end Open;

   -----------
   -- Query --
   -----------

   function Query
    (Self : in out SQL_Database'Class) return SQL.Queries.SQL_Query is
   begin
      return SQL.Queries.Internals.Wrap (Self.Data.Query);
   end Query;

   -----------
   -- Query --
   -----------

   function Query
    (Self  : in out SQL_Database'Class;
     Query : League.Strings.Universal_String) return SQL.Queries.SQL_Query is
   begin
      return Aux : SQL.Queries.SQL_Query := Self.Query do
         Aux.Prepare (Query);
      end return;
   end Query;

   ---------------------
   -- Raise_SQL_Error --
   ---------------------

   procedure Raise_SQL_Error
    (Self : in out SQL_Database'Class; Success : Boolean) is
   begin
      if not Success then
         raise SQL_Error
           with League.Text_Codecs.To_Exception_Message (Self.Error_Message);
      end if;
   end Raise_SQL_Error;

   --------------
   -- Rollback --
   --------------

   procedure Rollback (Self : in out SQL_Database'Class) is
   begin
      null;
   end Rollback;

   -----------------
   -- Transaction --
   -----------------

   procedure Transaction (Self : in out SQL_Database'Class) is
   begin
      null;
   end Transaction;

end SQL.Databases;
