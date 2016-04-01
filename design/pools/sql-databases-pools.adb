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
-- Copyright © 2016, Vadim Godunko <vgodunko@gmail.com>                     --
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

package body SQL.Databases.Pools is

   package body Constructors is

      ------------
      -- Create --
      ------------

      function Create
        (Driver   : League.Strings.Universal_String;
         Options  : SQL.Options.SQL_Options;
         Max_Size : Positive)
      return SQL_Connection_Pool
      is
         Size    : constant Idem_Index := Idem_Index (Max_Size);
         Modulus : constant Ada.Containers.Hash_Type :=
           Hashed_Maps.Default_Modulus (Size);
      begin
         return Value : SQL_Connection_Pool (Size, Modulus) do
            Value.Driver := Driver;
            Value.Options := Options;
            Value.Index_Map.Initialize;
         end return;
      end Create;

   end Constructors;

   ------------
   -- Create --
   ------------

   overriding function Create
     (Driver  : League.Strings.Universal_String;
      Options : SQL.Options.SQL_Options)
      return SQL_Database is
   begin
      raise Program_Error;
      return Create (Driver, Options);
   end Create;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out SQL_Database) is
   begin
      if Self.Index /= 0 then
         Self.Pool.Items (Self.Index).Release_Connection
           (Self.Data, Self.Options);
         Self.Pool.Index_Map.Release_Index (Self.Index);
         Self.Data := null;
         Self.Index := 0;
      else
         SQL.Databases.SQL_Database (Self).Finalize;
      end if;
   end Finalize;

   ---------
   -- Get --
   ---------

   function Get
     (Self    : aliased in out SQL_Connection_Pool'Class;
      Options : SQL.Options.SQL_Options)
      return SQL_Database
   is
      use type SQL.Options.SQL_Options;
      use type Matreshka.Internals.SQL_Drivers.Database_Access;

      Result  : Matreshka.Internals.SQL_Drivers.Database_Access;
      Index   : Idem_Index;
      Present : SQL.Options.SQL_Options;
   begin
      Self.Index_Map.Get_Index (Options, Index);
      Self.Items (Index).Get_Connection (Result, Present);

      if Present /= Options then
         declare
            Be : constant Matreshka.Internals.SQL_Drivers.Database_Access :=
              Matreshka.Internals.SQL_Drivers.Create (Self.Driver);
         begin
            if not Be.Open (Options) then
               Self.Items (Index).Release_Connection (Result, Present);
               Self.Index_Map.Release_Unused_Index (Present, Index);

               return
                 (Ada.Finalization.Limited_Controlled with
                  Self'Access,
                  Be,
                  Options,
                  Index => 0);
            end if;

            if Result /= null then
               Result.Close;
               Matreshka.Internals.SQL_Drivers.Dereference (Result);
            end if;

            Result := Be;
         end;
      end if;

      return
        (Ada.Finalization.Limited_Controlled with
           Pool    => Self'Access,
           Data    => Result,
           Options => Options,
           Index   => Index);
   end Get;

   -------------
   -- Options --
   -------------

   function Options
     (Self : SQL_Connection_Pool'Class) return SQL.Options.SQL_Options is
   begin
      return Self.Options;
   end Options;

   -----------------------
   -- Locked_Hashed_Map --
   -----------------------

   protected body Locked_Hashed_Map is

      procedure Append_Free_Item (Index : Idem_Index);
      procedure Drop_Free_Item (Index : Idem_Index);

      ----------------------
      -- Append_Free_Item --
      ----------------------

      procedure Append_Free_Item (Index : Idem_Index) is
         Last : Idem_Index;
      begin
         if Free = 0 then
            Free_List (Index) := (Prev => Index, Next => Index);
            Free := Index;
         else
            Last := Free_List (Free).Prev;

            Free_List (Index).Prev := Last;
            Free_List (Last).Next := Index;

            Free_List (Index).Next := Free;
            Free_List (Free).Prev := Index;
         end if;
      end Append_Free_Item;

      --------------------
      -- Drop_Free_Item --
      --------------------

      procedure Drop_Free_Item (Index : Idem_Index) is
         X : Free_List_Item renames Free_List (Index);
      begin
         if X.Next = Index then
            Free := 0;

         else
            Free_List (X.Prev).Next := X.Next;
            Free_List (X.Next).Prev := X.Prev;

            if Free = Index then
               Free := X.Next;
            end if;
         end if;
      end Drop_Free_Item;

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize is
      begin
         for J in 1 .. Max_Size loop
            Append_Free_Item (J);
         end loop;
      end Initialize;

      ---------------
      -- Get_Index --
      ---------------

      entry Get_Index
        (Value : SQL.Options.SQL_Options;
         Index : out Idem_Index) when True
      is
         Cursor : constant Hashed_Maps.Cursor := Map.Find (Value);
      begin
         if Hashed_Maps.Has_Element (Cursor) then
            Index := Hashed_Maps.Element (Cursor);

            if Count (Index) = 0 then
               Drop_Free_Item (Index);
            end if;

            Count (Index) := Count (Index) + 1;
         else
            requeue Get_Free_Index;
         end if;
      end Get_Index;

      --------------------
      -- Get_Free_Index --
      --------------------

      entry Get_Free_Index
        (Value : SQL.Options.SQL_Options;
         Index : out Idem_Index) when Free /= 0
      is
      begin
         Index := Free;
         Drop_Free_Item (Index);
         Count (Index) := 1;

         if Used (Index) then
            Map.Delete (Option (Index));
         end if;

         Map.Insert (Value, Index);
         Option (Index) := Value;
      end Get_Free_Index;

      -------------------
      -- Release_Index --
      -------------------

      procedure Release_Index (Index : Idem_Index) is
         Value  : constant SQL.Options.SQL_Options := Option (Index);
      begin
         Count (Index) := Count (Index) - 1;

         if Count (Index) = 0 then
            Append_Free_Item (Index);
            Used (Index) := True;
         end if;
      end Release_Index;

      --------------------------
      -- Release_Unused_Index --
      --------------------------

      procedure Release_Unused_Index
        (Value : SQL.Options.SQL_Options;
         Index : Idem_Index) is
      begin
         pragma Assert (Count (Index) = 1);

         Count (Index) := Count (Index) - 1;
         Append_Free_Item (Index);
         Free := Index;
         Map.Delete (Option (Index));

         if Used (Index) then
            Option (Index) := Value;
            Map.Insert (Value, Index);
         end if;
      end Release_Unused_Index;

   end Locked_Hashed_Map;

   ---------------
   -- Pool_Item --
   ---------------

   protected body Pool_Item is

      --------------------
      -- Get_Connection --
      --------------------

      entry Get_Connection
        (Value   : out Matreshka.Internals.SQL_Drivers.Database_Access;
         Options : out SQL.Options.SQL_Options)
         when not Busy
      is
      begin
         Busy := True;
         Value := Connect;
         Options := Pool_Item.Options;
      end Get_Connection;

      ------------------------
      -- Release_Connection --
      ------------------------

      procedure Release_Connection
        (Value   : Matreshka.Internals.SQL_Drivers.Database_Access;
         Options : SQL.Options.SQL_Options)
      is
      begin
         Busy := False;
         Pool_Item.Options := Options;
         Connect := Value;
      end Release_Connection;

   end Pool_Item;

end SQL.Databases.Pools;
