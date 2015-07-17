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
with OPM.Engines;

with Forum.Topics.Objects.Stores;
with Forum.Posts.References;
with Forum.Posts.Objects.Stores;

package body Forum.Topics.Objects is

   --------------------
   -- Get_Created_By --
   --------------------

   function Get_Created_By
    (Self : Topic_Object'Class) return AWFC.Accounts.Users.User_Access is
   begin
      return Self.Created_By;
   end Get_Created_By;

   -----------------------
   -- Get_Creation_Time --
   -----------------------

   function Get_Creation_Time
    (Self : Topic_Object'Class) return League.Calendars.Date_Time is
   begin
      return Self.Creation_Time;
   end Get_Creation_Time;

   ---------------------
   -- Get_Description --
   ---------------------

   function Get_Description
     (Self : Topic_Object'Class) return League.Strings.Universal_String is
   begin
      return Self.Description;
   end Get_Description;

   --------------------
   -- Get_Identifier --
   --------------------

   function Get_Identifier
    (Self : Topic_Object'Class) return Topic_Identifier is
   begin
      return Self.Identifier;
   end Get_Identifier;

   -------------------
   -- Get_Last_Post --
   -------------------

   function Get_Last_Post
    (Self : Topic_Object'Class) return Forum.Posts.References.Post
   is
      Post_Store : Forum.Posts.Objects.Stores.Post_Store'Class
        renames Forum.Posts.Objects.Stores.Post_Store'Class
          (Self.Store.Engine.Get_Store
             (Forum.Posts.Objects.Post_Object'Tag).all);
   begin
      return Result : Forum.Posts.References.Post do
         Result.Initialize (Post_Store'Unchecked_Access, Self.Last_Post);
      end return;
   end Get_Last_Post;

   --------------------
   -- Get_Post_Count --
   --------------------

   function Get_Post_Count
    (Self : Topic_Object'Class) return Natural is
   begin
      return Self.Post_Count;
   end Get_Post_Count;

   ---------------
   -- Get_Posts --
   ---------------

   function Get_Posts
    (Self : Topic_Object'Class;
     From : Positive;
     To   : Positive) return Forum.Posts.References.Post_Vector is
   begin
      return Self.Store.Get_Posts (Self.Identifier, From, To);
   end Get_Posts;

   ---------------
   -- Get_Title --
   ---------------

   function Get_Title
     (Self : Topic_Object'Class) return League.Strings.Universal_String is
   begin
      return Self.Title;
   end Get_Title;

end Forum.Topics.Objects;
