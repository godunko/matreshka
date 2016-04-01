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

private with Ada.Containers.Bounded_Hashed_Maps;
private with SQL.Options.Hash;

package SQL.Databases.Pools is

   type SQL_Database (<>) is new SQL.Databases.SQL_Database with private;
   --  Database connection from some connection pool

   type SQL_Connection_Pool (<>) is tagged limited private;
   --  Connection pool aggregates several DB connection

   function Get
     (Self    : aliased in out SQL_Connection_Pool'Class;
      Options : SQL.Options.SQL_Options)
     return SQL_Database;
   --  Open new database connection or reuse some if it's already in the pool.
   --  If connection fails return not empty Error message

   function Options
     (Self : SQL_Connection_Pool'Class) return SQL.Options.SQL_Options;
   --  Return Default option set - see Create function

   package Constructors is

      function Create
        (Driver   : League.Strings.Universal_String;
         Options  : SQL.Options.SQL_Options;
         Max_Size : Positive) return SQL_Connection_Pool;
      --  Create new connection pool of given size
   end Constructors;

private

   subtype Idem_Index is
     Ada.Containers.Count_Type range 1 .. Ada.Containers.Count_Type'Last;

   use type Idem_Index;

   package Hashed_Maps is new Ada.Containers.Bounded_Hashed_Maps
     (Key_Type        => SQL.Options.SQL_Options,
      Element_Type    => Idem_Index,
      Hash            => SQL.Options.Hash,
      Equivalent_Keys => SQL.Options."=",
      "="             => "=");

   --  Representation of double linked list link of Idem_Index
   type Free_List_Item is record
      Prev : Idem_Index;
      Next : Idem_Index;
   end record;

   type Free_List_Array is array (Idem_Index range <>) of Free_List_Item;
   type Boolean_Array is array (Idem_Index range <>) of Boolean;
   type Natural_Array is array (Idem_Index range <>) of Natural;
   type Options_Array is
     array (Idem_Index range <>) of SQL.Options.SQL_Options;

   --  Protected map from options to item index
   protected type Locked_Hashed_Map
     (Max_Size : Idem_Index;
      Modulus  : Ada.Containers.Hash_Type) is

      procedure Initialize;

      entry Get_Index
        (Value : SQL.Options.SQL_Options;
         Index : out Idem_Index);
      --  Reserve some Index in 1 .. Max_Size for use with given option set

      entry Get_Free_Index
        (Value : SQL.Options.SQL_Options;
         Index : out Idem_Index);
      --  Reserve some Index as it is beeing released

      procedure Release_Index (Index : Idem_Index);
      --  Given Index not used by this task any more

      procedure Release_Unused_Index
        (Value : SQL.Options.SQL_Options;
         Index : Idem_Index);
      --  Return Index back when it was not used. Assign given options to it

   private
      Map       : Hashed_Maps.Map (Max_Size, Modulus);
      --  Mapping from Options to corresponding index
      Free      : Idem_Index'Base := 0;
      --  First element in Free_List
      Free_List : Free_List_Array (1 .. Max_Size);
      --  List of Options with Count=0 in LRU order
      Count     : Natural_Array (1 .. Max_Size) := (others => 0);
      --  Count of allocated indexes
      Option    : Options_Array (1 .. Max_Size);
      --  Map from index to Options if Used = True
      Used      : Boolean_Array (1 .. Max_Size) := (others => False);
      --  Flag if given index was assigned to Options at least once.
      --  Valid only for indexes with Count=0
   end Locked_Hashed_Map;

   protected type Pool_Item is

      entry Get_Connection
        (Value   : out Matreshka.Internals.SQL_Drivers.Database_Access;
         Options : out SQL.Options.SQL_Options);
      --  Get database and corresponding option set

      procedure Release_Connection
        (Value   : Matreshka.Internals.SQL_Drivers.Database_Access;
         Options : SQL.Options.SQL_Options);
      --  Return database to the item
   private
      Connect : Matreshka.Internals.SQL_Drivers.Database_Access;
      Options : SQL.Options.SQL_Options;
      Busy    : Boolean := False;
   end Pool_Item;

   type Pool_Item_Array is array (Idem_Index range <>) of Pool_Item;

   type SQL_Connection_Pool
     (Max_Size : Idem_Index;
      Modulus  : Ada.Containers.Hash_Type) is tagged limited
   record
      Driver    : League.Strings.Universal_String;
      Options   : SQL.Options.SQL_Options;
      Index_Map : Locked_Hashed_Map (Max_Size, Modulus);
      Items     : Pool_Item_Array (1 .. Max_Size);
   end record;

   type SQL_Database (Pool : not null access SQL_Connection_Pool'Class) is
     new SQL.Databases.SQL_Database with
   record
      Index : Idem_Index'Base := 0;
   end record;

   overriding procedure Finalize (Self : in out SQL_Database);

   overriding function Create
    (Driver  : League.Strings.Universal_String;
     Options : SQL.Options.SQL_Options) return SQL_Database;

end SQL.Databases.Pools;
