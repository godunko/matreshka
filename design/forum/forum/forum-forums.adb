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
with SQL.Queries;

with OPM.Stores;

with Forum.Categories.Objects.Stores;
with Forum.Categories.Category_Identifier_Holders;
with Forum.Topics.Objects.Stores;

package body Forum.Forums is

   function Get_Category_Store
    (Self : OPM.Engines.Engine'Class)
      return not null access
        Standard.Forum.Categories.Objects.Stores.Category_Store'Class;

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

   ------------------------
   -- Get_Category_Store --
   ------------------------

   function Get_Category_Store
    (Self : OPM.Engines.Engine'Class)
      return not null access
        Standard.Forum.Categories.Objects.Stores.Category_Store'Class is
   begin
      return
        Standard.Forum.Categories.Objects.Stores.Category_Store'Class
         (Self.Get_Store
           (Standard.Forum.Categories.Objects.Category_Object'Tag).all)
              'Unchecked_Access;
   end Get_Category_Store;

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
   end Initialize;

end Forum.Forums;
