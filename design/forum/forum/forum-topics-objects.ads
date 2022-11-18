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
with League.Calendars;
with League.Strings;

with AWFC.Accounts.Users;

with Forum.Posts;
limited with Forum.Topics.Objects.Stores;
limited with Forum.Posts.References;

package Forum.Topics.Objects is

--   pragma Preelaborate;

   type Topic_Object (<>) is tagged limited private;

   function Get_Identifier
    (Self : Topic_Object'Class) return Topic_Identifier;

   function Get_Title
    (Self : Topic_Object'Class) return League.Strings.Universal_String;

   function Get_Description
    (Self : Topic_Object'Class) return League.Strings.Universal_String;

   function Get_Creation_Time
    (Self : Topic_Object'Class) return League.Calendars.Date_Time;

   function Get_Created_By
    (Self : Topic_Object'Class) return AWFC.Accounts.Users.User_Access;

   function Get_Last_Post
    (Self : Topic_Object'Class) return Forum.Posts.References.Post;

   function Get_Post_Count
    (Self : Topic_Object'Class) return Natural;

   function Get_Posts
    (Self : Topic_Object'Class;
     From : Positive;
     To   : Positive) return Forum.Posts.References.Post_Vector;

private

   type Topic_Object
         (Store :
            not null access Standard.Forum.Topics.Objects.Stores.Topic_Store'Class) is
     tagged limited record
      Identifier     : Topic_Identifier;
      Title          : League.Strings.Universal_String;
      Description    : League.Strings.Universal_String;
      Creation_Time  : League.Calendars.Date_Time;
      Created_By     : AWFC.Accounts.Users.User_Access;
      Last_Post      : Forum.Posts.Post_Identifier;
      Post_Count     : Natural;
   end record;

end Forum.Topics.Objects;
