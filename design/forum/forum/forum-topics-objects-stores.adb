------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
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
with Ada.Unchecked_Deallocation;

with League.Holders.Generic_Integers;
with SQL.Queries;

with OPM.Engines;

with Forum.Categories.Objects;

package body Forum.Topics.Objects.Stores is

   procedure Free is new Ada.Unchecked_Deallocation (Topic_Object'Class, Topic_Access);

   ---------
   -- Get --
   ---------

   not overriding function Get
    (Self       : in out Topic_Store;
     Identifier : Topic_Identifier) return Topic_Access
   is
      Q : SQL.Queries.SQL_Query
        := Self.Engine.Get_Database.Query
            (League.Strings.To_Universal_String
              ("SELECT title, description FROM topics"
                 & " WHERE topic_identifier = :forum_identifier"));

   begin
      Q.Bind_Value
       (League.Strings.To_Universal_String (":topic_identifier"),
        Topic_Identifier_Holders.To_Holder (Identifier));
      Q.Execute;

      if not Q.Next then
         return null;

      else
         return
           new Topic_Object'
                (Store       => Self'Unchecked_Access,
                 Identifier  => Identifier,
                 Title       => League.Holders.Element (Q.Value (1)),
                 Description => League.Holders.Element (Q.Value (2)));
      end if;
   end Get;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out Topic_Store) is
   begin
      Self.Engine.Register_Store
       (Forum.Topics.Objects.Topic_Object'Tag,
        Self'Unchecked_Access);
   end Initialize;

   -------------
   -- Release --
   -------------

   not overriding procedure Release
    (Self   : in out Topic_Store;
     Object : not null Topic_Access)
   is
      Aux : Topic_Access;

   begin
      if Object /= null then
         Aux := Object;
         Free (Aux);
      end if;
   end Release;

end Forum.Topics.Objects.Stores;
