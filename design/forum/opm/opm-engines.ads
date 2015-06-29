------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                      Orthogonal Persistence Manager                      --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
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
--  Engine is entry point of persistance manager. It manages stores that
--  manages instances of object classes.
------------------------------------------------------------------------------
private with Ada.Containers.Hashed_Maps;
with Ada.Tags;

with League.Strings;
with SQL.Databases;
with SQL.Options;

with OPM.Factories;
with OPM.Stores;

package OPM.Engines is

   type Engine is tagged limited private;

   procedure Register_Store
    (Self  : in out Engine;
     Tag   : Ada.Tags.Tag;
     Store : not null OPM.Stores.Store_Access);

   function Get_Store
    (Self : Engine; Tag : Ada.Tags.Tag) return OPM.Stores.Store_Access;

   procedure Register_Factory
    (Self    : in out Engine;
     Tag     : Ada.Tags.Tag;
     Factory : not null OPM.Factories.Factory_Access);

   function Get_Factory
    (Self : Engine; Tag : Ada.Tags.Tag) return OPM.Factories.Factory_Access;

   function Get_Database
    (Self : Engine) return not null access SQL.Databases.SQL_Database;
   --  Returns access to database connection object.

   procedure Initialize
    (Self    : in out Engine;
     Driver  : League.Strings.Universal_String;
     Options : SQL.Options.SQL_Options);
   --  Initialize engine.

   generic
      type Object (<>) is tagged limited private;
      type Store is new OPM.Stores.Abstract_Store with private;
   function Generic_Get_Store
     (Self : Engine'Class) return not null access Store'Class;

private

   function Hash (Item : Ada.Tags.Tag) return Ada.Containers.Hash_Type;

   package Tag_Store_Maps is
     new Ada.Containers.Hashed_Maps
          (Ada.Tags.Tag,
           OPM.Stores.Store_Access,
           Hash,
           Ada.Tags."=",
           OPM.Stores."=");

   package Tag_Factory_Maps is
     new Ada.Containers.Hashed_Maps
          (Ada.Tags.Tag,
           OPM.Factories.Factory_Access,
           Hash,
           Ada.Tags."=",
           OPM.Factories."=");

   type Database_Access is access all SQL.Databases.SQL_Database;

   type Engine is tagged limited record
      Stores    : Tag_Store_Maps.Map;
      Factories : Tag_Factory_Maps.Map;
      Database  : Database_Access;
   end record;

end OPM.Engines;
