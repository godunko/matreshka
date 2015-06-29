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
with Forum.Categories.Objects.Stores;
with Forum.Topics.References;

package body Forum.Categories.Objects is

   ---------------------
   -- Get_Description --
   ---------------------

   function Get_Description
    (Self : Category_Object'Class) return League.Strings.Universal_String is
   begin
      return Self.Description;
   end Get_Description;

   --------------------
   -- Get_Identifier --
   --------------------

   function Get_Identifier
    (Self : Category_Object'Class) return Category_Identifier is
   begin
      return Self.Identifier;
   end Get_Identifier;

   ---------------
   -- Get_Title --
   ---------------

   function Get_Title
    (Self : Category_Object'Class) return League.Strings.Universal_String is
   begin
      return Self.Title;
   end Get_Title;

   ---------------
   -- Get_Topic --
   ---------------

   procedure Get_Topic
    (Self        : Category_Object'Class;
     Identifier  : Forum.Topics.Topic_Identifier;
     Category    : out Forum.Topics.References.Topic;
     Found       : out Boolean) is
   begin
      null;
   end Get_Topic;

   ---------------------
   -- Get_Topic_Count --
   ---------------------

   function Get_Topic_Count
    (Self : Category_Object'Class) return Natural is
   begin
      return Self.Topic_Count;
   end Get_Topic_Count;

   ----------------
   -- Get_Topics --
   ----------------

   function Get_Topics
    (Self : Category_Object'Class;
     From : Positive;
     To   : Positive) return Forum.Topics.References.Topic_Vector is
   begin
      return Self.Store.Get_Topics (Self.Identifier, From, To);
   end Get_Topics;

end Forum.Categories.Objects;
