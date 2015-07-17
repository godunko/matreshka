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

with AWFC.Accounts.Users.User_Identifier_Holders;
with AWFC.Accounts.Users.Stores;

with Forum.Categories.Objects;
with Forum.Posts.References;
with Forum.Topics.References;

package body Forum.Posts.Objects.Stores is

   procedure Free is new Ada.Unchecked_Deallocation (Post_Object'Class, Post_Access);

   ------------
   -- Create --
   ------------

   not overriding function Create
    (Self          : in out Post_Store;
     User          : AWFC.Accounts.Users.User_Access;
     Topic         : Forum.Topics.References.Topic;
     Text          : League.Strings.Universal_String;
     Creation_Time : League.Calendars.Date_Time)
      return Forum.Posts.References.Post
   is
      Q : SQL.Queries.SQL_Query
        := Self.Engine.Get_Database.Query
            (League.Strings.To_Universal_String
              ("INSERT INTO posts (topic_identifier, text, creation_time,"
                 & " author)"
                 & " VALUES (:topic, :text, :creation_time, :author)"
                 & " RETURNING post_identifier"));
      R : Forum.Posts.References.Post;

   begin
      Q.Bind_Value
       (League.Strings.To_Universal_String (":topic"),
        Forum.Topics.Topic_Identifier_Holders.To_Holder
          (Topic.Identifier));
      Q.Bind_Value
       (League.Strings.To_Universal_String (":text"),
        League.Holders.To_Holder (Text));
      Q.Bind_Value
       (League.Strings.To_Universal_String (":creation_time"),
        League.Holders.To_Holder (Creation_Time));
      Q.Bind_Value
       (League.Strings.To_Universal_String (":author"),
        AWFC.Accounts.Users.User_Identifier_Holders.To_Holder
          (User.Get_User_Identifier));
      Q.Execute;

      if Q.Next then
         R.Initialize
          (Self'Unchecked_Access,
           Forum.Posts.Post_Identifier_Holders.Element
            (Q.Value (1)));
      end if;

      return R;
   end Create;

   ---------
   -- Get --
   ---------

   not overriding function Get
    (Self       : in out Post_Store;
     Identifier : Post_Identifier) return Post_Access
   is
      Q : SQL.Queries.SQL_Query
        := Self.Engine.Get_Database.Query
            (League.Strings.To_Universal_String
              ("SELECT text, creation_time, author"
                 & " FROM posts WHERE post_identifier = :id"));

      User_Store : AWFC.Accounts.Users.Stores.User_Store'Class
        renames AWFC.Accounts.Users.Stores.User_Store'Class
          (Self.Engine.Get_Store
             (AWFC.Accounts.Users.User'Tag).all);
   begin
      Q.Bind_Value
       (League.Strings.To_Universal_String (":id"),
        Post_Identifier_Holders.To_Holder (Identifier));
      Q.Execute;

      if not Q.Next then
         return null;

      else
         return
           new Post_Object'
                (Store         => Self'Unchecked_Access,
                 Identifier    => Identifier,
                 Text          => League.Holders.Element (Q.Value (1)),
                 Creation_Time => League.Holders.Element (Q.Value (2)),
                 Author        => User_Store.Incarnate
                   (AWFC.Accounts.Users.User_Identifier_Holders.Element
                        (Q.Value (3))));
      end if;
   end Get;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out Post_Store) is
   begin
      Self.Engine.Register_Store
       (Forum.Posts.Objects.Post_Object'Tag,
        Self'Unchecked_Access);
   end Initialize;

   -------------
   -- Release --
   -------------

   not overriding procedure Release
    (Self   : in out Post_Store;
     Object : not null Post_Access)
   is
      Aux : Post_Access;

   begin
      if Object /= null then
         Aux := Object;
         Free (Aux);
      end if;
   end Release;

end Forum.Posts.Objects.Stores;
