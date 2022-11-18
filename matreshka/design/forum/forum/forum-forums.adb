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
with League.Holders;
with SQL.Queries;

with OPM.Stores;
with AWFC.Accounts.Users.Stores;

with Forum.Categories.Objects.Stores;
with Forum.Categories.Category_Identifier_Holders;
with Forum.Topics.Objects.Stores;
with Forum.Posts.Objects.Stores;

package body Forum.Forums is

   function Get_Category_Store is new OPM.Engines.Generic_Get_Store
     (Object => Standard.Forum.Categories.Objects.Category_Object,
      Store  => Standard.Forum.Categories.Objects.Stores.Category_Store);

   function Get_Topic_Store is new OPM.Engines.Generic_Get_Store
     (Object => Standard.Forum.Topics.Objects.Topic_Object,
      Store  => Standard.Forum.Topics.Objects.Stores.Topic_Store);

   function Get_Post_Store is new OPM.Engines.Generic_Get_Store
     (Object => Standard.Forum.Posts.Objects.Post_Object,
      Store  => Standard.Forum.Posts.Objects.Stores.Post_Store);

   ---------------------
   -- Create_Category --
   ---------------------

   function Create_Category
    (Self        : in out Forum'Class;
     Title       : League.Strings.Universal_String;
     Description : League.Strings.Universal_String)
       return Standard.Forum.Categories.References.Category is
   begin
      return Get_Category_Store (Self.Engine).Create (Title, Description);
   end Create_Category;

   -----------------
   -- Create_Post --
   -----------------

   function Create_Post
    (Self          : in out Forum'Class;
     User          : AWFC.Accounts.Users.User_Access;
     Topic         : Standard.Forum.Topics.References.Topic;
     Text          : League.Strings.Universal_String;
     Creation_Time : League.Calendars.Date_Time := League.Calendars.Clock)
      return Standard.Forum.Posts.References.Post is
   begin
      return Get_Post_Store (Self.Engine).Create
        (User, Topic, Text, Creation_Time);
   end Create_Post;

   ------------------
   -- Create_Topic --
   ------------------

   function Create_Topic
    (Self          : in out Forum'Class;
     User          : AWFC.Accounts.Users.User_Access;
     Category      : Standard.Forum.Categories.References.Category;
     Title         : League.Strings.Universal_String;
     Description   : League.Strings.Universal_String;
     Creation_Time : League.Calendars.Date_Time := League.Calendars.Clock)
      return Standard.Forum.Topics.References.Topic is
   begin
      return Get_Topic_Store (Self.Engine).Create
        (User, Category, Title, Description, Creation_Time);
   end Create_Topic;

   --------------------
   -- Get_Categories --
   --------------------

   function Get_Categories
    (Self : in out Forum'Class)
       return Standard.Forum.Categories.References.Category_Vector
   is
      Q : SQL.Queries.SQL_Query
        := Self.Engine.Get_Database.Query
            (League.Strings.To_Universal_String
              ("SELECT category_identifier FROM categories"));
      X : Standard.Forum.Categories.References.Category;
      R : Standard.Forum.Categories.References.Category_Vector;

   begin
      Q.Execute;

      while Q.Next loop
         X.Initialize
          (Get_Category_Store (Self.Engine),
           Categories.Category_Identifier_Holders.Element (Q.Value (1)));
         R.Append (X);
      end loop;

      return R;
   end Get_Categories;

   ------------------
   -- Get_Category --
   ------------------

   procedure Get_Category
    (Self       : in out Forum'Class;
     Identifier : Standard.Forum.Categories.Category_Identifier;
     Value      : out Standard.Forum.Categories.References.Category;
     Found      : out Boolean)
   is
      H : constant League.Holders.Holder :=
        Standard.Forum.Categories.Category_Identifier_Holders.To_Holder
          (Identifier);

      Q : SQL.Queries.SQL_Query
        := Self.Engine.Get_Database.Query
            (League.Strings.To_Universal_String
              ("SELECT 1 FROM categories WHERE"
                 & " category_identifier=:category_identifier"));

   begin
      Q.Bind_Value
        (League.Strings.To_Universal_String (":category_identifier"), H);
      Q.Execute;

      if Q.Next then
         Value.Initialize (Get_Category_Store (Self.Engine), Identifier);
         Found := True;
      else
         Found := False;
      end if;
   end Get_Category;

   ---------------
   -- Get_Topic --
   ---------------

   procedure Get_Topic
    (Self        : in out Forum'Class;
     Category    : Standard.Forum.Categories.Category_Identifier;
     Identifier  : Standard.Forum.Topics.Topic_Identifier;
     Value       : out Standard.Forum.Topics.References.Topic;
     Found       : out Boolean)
   is
      C : constant League.Holders.Holder :=
        Standard.Forum.Categories.Category_Identifier_Holders.To_Holder
          (Category);

      T : constant League.Holders.Holder :=
        Standard.Forum.Topics.Topic_Identifier_Holders.To_Holder
          (Identifier);

      Q : SQL.Queries.SQL_Query
        := Self.Engine.Get_Database.Query
            (League.Strings.To_Universal_String
              ("SELECT 1 FROM topics WHERE"
                 & " category_identifier=:category_identifier"
                 & " and topic_identifier=:topic_identifier"));

   begin
      Q.Bind_Value
        (League.Strings.To_Universal_String (":category_identifier"), C);
      Q.Bind_Value
        (League.Strings.To_Universal_String (":topic_identifier"), T);
      Q.Execute;

      if Q.Next then
         Value.Initialize (Get_Topic_Store (Self.Engine), Identifier);
         Found := True;
      else
         Found := False;
      end if;
   end Get_Topic;
   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self    : in out Forum'Class;
     Driver  : League.Strings.Universal_String;
     Options : SQL.Options.SQL_Options)
   is
      Aux : OPM.Stores.Store_Access;

   begin
      Self.Engine.Initialize (Driver, Options);
      Aux := new Standard.Forum.Categories.Objects.Stores.Category_Store (Self.Engine'Unchecked_Access);
      Aux.Initialize;
      Aux := new Standard.Forum.Topics.Objects.Stores.Topic_Store (Self.Engine'Unchecked_Access);
      Aux.Initialize;
      Aux := new Standard.Forum.Posts.Objects.Stores.Post_Store (Self.Engine'Unchecked_Access);
      Aux.Initialize;
   end Initialize;

end Forum.Forums;
