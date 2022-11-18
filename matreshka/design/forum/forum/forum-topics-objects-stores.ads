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
with SQL.Databases;
with OPM.Stores;
with AWFC.Accounts.Users;

limited with Forum.Categories.References;
limited with Forum.Topics.References;

package Forum.Topics.Objects.Stores is

   type Topic_Access is access all Topic_Object'Class; --  with Storage_Size => 0;

   type Topic_Store is new OPM.Stores.Abstract_Store with private;

   not overriding function Get
    (Self       : in out Topic_Store;
     Identifier : Topic_Identifier) return Topic_Access;

   function Get_Posts
     (Self       : in out Topic_Store;
      Identifier : Topic_Identifier;
      From       : Positive;
      To         : Positive) return Forum.Posts.References.Post_Vector;

   not overriding procedure Release
    (Self   : in out Topic_Store;
     Object : not null Topic_Access);

   not overriding function Create
    (Self          : in out Topic_Store;
     User          : AWFC.Accounts.Users.User_Access;
     Category      : Forum.Categories.References.Category;
     Title         : League.Strings.Universal_String;
     Description   : League.Strings.Universal_String;
     Creation_Time : League.Calendars.Date_Time)
       return Forum.Topics.References.Topic;

   overriding procedure Initialize (Self : in out Topic_Store);

private

   type Topic_Store is new OPM.Stores.Abstract_Store with null record;

end Forum.Topics.Objects.Stores;
