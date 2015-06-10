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

with League.Holders;
with SQL.Queries;

with OPM.Engines;

with Forum.Categories.Category_Identifier_Holders;
with Forum.Categories.References;
with Forum.Topics.References;
with Forum.Topics.Objects.Stores;

package body Forum.Categories.Objects.Stores is

   procedure Free is
     new Ada.Unchecked_Deallocation (Category_Object'Class, Category_Access);

   ------------
   -- Create --
   ------------

   not overriding function Create
    (Self        : in out Category_Store;
     Title       : League.Strings.Universal_String;
     Description : League.Strings.Universal_String)
       return Forum.Categories.References.Category
   is
      Q : SQL.Queries.SQL_Query
        := Self.Engine.Get_Database.Query
            (League.Strings.To_Universal_String
              ("INSERT INTO categories (title, description)"
                 & " VALUES (:title, :description)"
                 & " RETURNING category_identifier"));
      R : Forum.Categories.References.Category;

   begin
      Q.Bind_Value
       (League.Strings.To_Universal_String (":title"),
        League.Holders.To_Holder (Title));
      Q.Bind_Value
       (League.Strings.To_Universal_String (":description"),
        League.Holders.To_Holder (Description));
      Q.Execute;

      if Q.Next then
         R.Initialize
          (Self'Unchecked_Access,
           Forum.Categories.Category_Identifier_Holders.Element
            (Q.Value (1)));
      end if;

      return R;
   end Create;

   ---------
   -- Get --
   ---------

   not overriding function Get
    (Self       : in out Category_Store;
     Identifier : Category_Identifier) return Category_Access
   is
      Q : SQL.Queries.SQL_Query
        := Self.Engine.Get_Database.Query
            (League.Strings.To_Universal_String
              ("SELECT title, description FROM categories"
                 & " WHERE category_identifier = :category_identifier"));

   begin
      Q.Bind_Value
       (League.Strings.To_Universal_String (":category_identifier"),
        Category_Identifier_Holders.To_Holder (Identifier));
      Q.Execute;

      if not Q.Next then
         return null;

      else
         return
           new Category_Object'
                (Store       => Self'Unchecked_Access,
                 Identifier  => Identifier,
                 Title       => League.Holders.Element (Q.Value (1)),
                 Description => League.Holders.Element (Q.Value (2)));
      end if;
   end Get;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out Category_Store) is
   begin
      Self.Engine.Register_Store
       (Forum.Categories.Objects.Category_Object'Tag,
        Self'Unchecked_Access);
   end Initialize;

   ---------------------
   -- Get_Topic_Count --
   ---------------------

   function Get_Topic_Count
    (Self       : in out Category_Store;
     Identifier : Category_Identifier) return Natural
   is
      Q : SQL.Queries.SQL_Query
        := Self.Engine.Get_Database.Query
            (League.Strings.To_Universal_String
              ("SELECT count(*) FROM topics"
                 & " WHERE category_identifier = :category_identifier"));

      Result : League.Holders.Universal_Integer;
   begin
      Q.Bind_Value
       (League.Strings.To_Universal_String (":category_identifier"),
        Category_Identifier_Holders.To_Holder (Identifier));
      Q.Execute;

      if not Q.Next then
         Result := 0;

      else
         Result := League.Holders.Element (Q.Value (1));
      end if;

      return Natural (Result);
   end Get_Topic_Count;

   function Get_Topic_Store
    (Self : OPM.Engines.Engine'Class)
      return not null access
        Forum.Topics.Objects.Stores.Topic_Store'Class is
   begin
      return
        Standard.Forum.Topics.Objects.Stores.Topic_Store'Class
         (Self.Get_Store
           (Standard.Forum.Topics.Objects.Topic_Object'Tag).all)
              'Unchecked_Access;
   end Get_Topic_Store;

   ----------------
   -- Get_Topics --
   ----------------

   function Get_Topics
     (Self       : in out Category_Store;
      Identifier : Category_Identifier;
      From       : Positive;
      To         : Positive) return Forum.Topics.References.Topic_Vector
   is
      Q : SQL.Queries.SQL_Query
        := Self.Engine.Get_Database.Query
            (League.Strings.To_Universal_String
              ("SELECT topic_identifier FROM topics"
                 & " WHERE category_identifier = :category_identifier"));

      Result : Forum.Topics.References.Topic_Vector;
      X : OPM.Stores.Store_Access :=
        Self.Engine.Get_Store (Forum.Topics.Objects.Topic_Object'Tag);

      Store  : not null access Forum.Topics.Objects.Stores.Topic_Store'Class :=
          Forum.Topics.Objects.Stores.Topic_Store'Class
            (X.all)
              'Unchecked_Access;
   begin
      Q.Bind_Value
       (League.Strings.To_Universal_String (":category_identifier"),
        Category_Identifier_Holders.To_Holder (Identifier));
      Q.Execute;

      for J in From .. To loop
         if Q.Next then
            declare
               Ref : Forum.Topics.References.Topic;
            begin
               Ref.Initialize
                 (Get_Topic_Store (Self.Engine.all),
                  Topics.Topic_Identifier_Holders.Element (Q.Value (1)));

               Result.Append (Ref);
            end;
         end if;
      end loop;

      return Result;
   end Get_Topics;

   -------------
   -- Release --
   -------------

   not overriding procedure Release
    (Self   : in out Category_Store;
     Object : not null Category_Access)
   is
      Aux : Category_Access;

   begin
      if Object /= null then
         Aux := Object;
         Free (Aux);
      end if;
   end Release;

end Forum.Categories.Objects.Stores;