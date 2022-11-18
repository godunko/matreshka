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
with SQL.Options;

with OPM.Engines;

with AWFC.Accounts.Users;

with Forum.Categories.References;
with Forum.Topics.References;
with Forum.Posts.References;

package Forum.Forums is

   type Forum is tagged limited record
      Engine : aliased OPM.Engines.Engine;
   end record;

   procedure Initialize
    (Self    : in out Forum'Class;
     Driver  : League.Strings.Universal_String;
     Options : SQL.Options.SQL_Options);

   function Get_Categories
    (Self : in out Forum'Class)
       return Standard.Forum.Categories.References.Category_Vector;

   procedure Get_Category
    (Self       : in out Forum'Class;
     Identifier : Standard.Forum.Categories.Category_Identifier;
     Value      : out Standard.Forum.Categories.References.Category;
     Found      : out Boolean);

   function Create_Category
    (Self        : in out Forum'Class;
     Title       : League.Strings.Universal_String;
     Description : League.Strings.Universal_String)
       return Standard.Forum.Categories.References.Category;

   procedure Get_Topic
    (Self        : in out Forum'Class;
     Category    : Standard.Forum.Categories.Category_Identifier;
     Identifier  : Standard.Forum.Topics.Topic_Identifier;
     Value       : out Standard.Forum.Topics.References.Topic;
     Found       : out Boolean);

   function Create_Topic
    (Self          : in out Forum'Class;
     User          : AWFC.Accounts.Users.User_Access;
     Category      : Standard.Forum.Categories.References.Category;
     Title         : League.Strings.Universal_String;
     Description   : League.Strings.Universal_String;
     Creation_Time : League.Calendars.Date_Time := League.Calendars.Clock)
       return Standard.Forum.Topics.References.Topic;

   function Create_Post
    (Self          : in out Forum'Class;
     User          : AWFC.Accounts.Users.User_Access;
     Topic         : Standard.Forum.Topics.References.Topic;
     Text          : League.Strings.Universal_String;
     Creation_Time : League.Calendars.Date_Time := League.Calendars.Clock)
       return Standard.Forum.Posts.References.Post;

end Forum.Forums;
