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
with League.Holders.Integers;
with SQL.Queries;

with OPM.Engines;
with AWFC.Accounts.Users.User_Identifier_Holders;
with AWFC.Accounts.Users.Stores;

with Forum.Categories.Objects;
with Forum.Categories.References;
with Forum.Categories.Category_Identifier_Holders;
with Forum.Posts.References;
with Forum.Posts.Objects.Stores;
with Forum.Topics.References;

package body Forum.Topics.Objects.Stores is

   procedure Free is new Ada.Unchecked_Deallocation (Topic_Object'Class, Topic_Access);

   not overriding function Create
    (Self          : in out Topic_Store;
     User          : AWFC.Accounts.Users.User_Access;
     Category      : Forum.Categories.References.Category;
     Title         : League.Strings.Universal_String;
     Description   : League.Strings.Universal_String;
     Creation_Time : League.Calendars.Date_Time)
      return Forum.Topics.References.Topic
   is
      Q : SQL.Queries.SQL_Query
        := Self.Engine.Get_Database.Query
            (League.Strings.To_Universal_String
              ("INSERT INTO topics (category_identifier, title, description,"
                 & " creation_time, created_by)"
                 & " VALUES (:category, :title, :description, :creation_time,"
                 & " :created_by)"
                 & " RETURNING topic_identifier"));
      R : Forum.Topics.References.Topic;

   begin
      Q.Bind_Value
       (League.Strings.To_Universal_String (":category"),
        Forum.Categories.Category_Identifier_Holders.To_Holder
          (Category.Identifier));
      Q.Bind_Value
       (League.Strings.To_Universal_String (":title"),
        League.Holders.To_Holder (Title));
      Q.Bind_Value
       (League.Strings.To_Universal_String (":description"),
        League.Holders.To_Holder (Description));
      Q.Bind_Value
       (League.Strings.To_Universal_String (":creation_time"),
        League.Holders.To_Holder (Creation_Time));
      Q.Bind_Value
       (League.Strings.To_Universal_String (":created_by"),
        AWFC.Accounts.Users.User_Identifier_Holders.To_Holder
          (User.Get_User_Identifier));
      Q.Execute;

      if Q.Next then
         R.Initialize
          (Self'Unchecked_Access,
           Forum.Topics.Topic_Identifier_Holders.Element
            (Q.Value (1)));
      end if;

      return R;
   end Create;

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
              ("SELECT title, description, creation_time, post_count, "
                 & "lastpost, created_by "
                 & " FROM topics t, "
                 & " (select count(*) post_count,"
                 & " max(post_identifier) lastpost FROM posts p"
                 & " WHERE p.topic_identifier = :id) s"
                 & " WHERE topic_identifier = :id"));

      User_Store : AWFC.Accounts.Users.Stores.User_Store'Class
        renames AWFC.Accounts.Users.Stores.User_Store'Class
          (Self.Engine.Get_Store
             (AWFC.Accounts.Users.User'Tag).all);
   begin
      Q.Bind_Value
       (League.Strings.To_Universal_String (":id"),
        Topic_Identifier_Holders.To_Holder (Identifier));
      Q.Execute;

      if not Q.Next then
         return null;

      else
         return
           new Topic_Object'
                (Store          => Self'Unchecked_Access,
                 Identifier     => Identifier,
                 Title          => League.Holders.Element (Q.Value (1)),
                 Description    => League.Holders.Element (Q.Value (2)),
                 Creation_Time  => League.Holders.Element (Q.Value (3)),
                 Post_Count     => Natural'Wide_Wide_Value  --  FIXME after #425
                   (League.Holders.Element (Q.Value (4)).To_Wide_Wide_String),
                 Last_Post      => Forum.Posts.Post_Identifier_Holders.Element
                   (Q.Value (5)),
                 Created_By     => User_Store.Incarnate
                   (AWFC.Accounts.Users.User_Identifier_Holders.Element
                        (Q.Value (6))));
      end if;
   end Get;

   ---------------
   -- Get_Posts --
   ---------------

   function Get_Posts
     (Self       : in out Topic_Store;
      Identifier : Topic_Identifier;
      From       : Positive;
      To         : Positive) return Forum.Posts.References.Post_Vector
   is
      Q : SQL.Queries.SQL_Query
        := Self.Engine.Get_Database.Query
            (League.Strings.To_Universal_String
              ("SELECT post_identifier FROM posts"
                 & " WHERE topic_identifier = :topic_identifier"
                 & " ORDER BY creation_time ASC"
                 & " LIMIT :limit OFFSET :offset"));

      Result : Forum.Posts.References.Post_Vector;
      Limit  : Positive := To - From + 1;
      Offset : Natural := From - 1;

      X : OPM.Stores.Store_Access :=
        Self.Engine.Get_Store (Forum.Posts.Objects.Post_Object'Tag);

      Store  : not null access Forum.Posts.Objects.Stores.Post_Store'Class :=
          Forum.Posts.Objects.Stores.Post_Store'Class
            (X.all)
              'Unchecked_Access;
   begin
      Q.Bind_Value
       (League.Strings.To_Universal_String (":topic_identifier"),
        Topic_Identifier_Holders.To_Holder (Identifier));
      Q.Bind_Value
       (League.Strings.To_Universal_String (":limit"),
        League.Holders.Integers.To_Holder (Limit));
      Q.Bind_Value
       (League.Strings.To_Universal_String (":offset"),
        League.Holders.Integers.To_Holder (Offset));
      Q.Execute;

      for J in From .. To loop
         if Q.Next then
            declare
               Ref : Forum.Posts.References.Post;
            begin
               Ref.Initialize
                 (Store,
                  Posts.Post_Identifier_Holders.Element (Q.Value (1)));

               Result.Append (Ref);
            end;
         end if;
      end loop;

      return Result;
   end Get_Posts;

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
