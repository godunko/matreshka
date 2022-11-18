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
-- Copyright © 2014, Vadim Godunko <vgodunko@gmail.com>                     --
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
--  User_Identifier is private type, thus Holders.Generic_Integers can't be
--  instantiated with this type. This package provides equivalent
--  implementation.
------------------------------------------------------------------------------
with League.Holders;
private with League.Holders.Generic_Integers;

package ESAPI.Users.User_Identifier_Holders is

   Value_Tag : constant League.Holders.Tag;

   function Element
    (Self : League.Holders.Holder) return ESAPI.Users.User_Identifier;
   --  Returns internal value.

   procedure Replace_Element
    (Self : in out League.Holders.Holder; To : ESAPI.Users.User_Identifier);
   --  Set value. Tag of the value must be set before this call.

   function To_Holder
    (Item : ESAPI.Users.User_Identifier) return League.Holders.Holder;
   --  Creates new Value from specified value.

private

   package User_Identifier_Holders is
     new League.Holders.Generic_Integers (ESAPI.Users.User_Identifier);

   Value_Tag : constant League.Holders.Tag
     := User_Identifier_Holders.Value_Tag;

   function Element
    (Self : League.Holders.Holder) return ESAPI.Users.User_Identifier
       renames User_Identifier_Holders.Element;

   procedure Replace_Element
    (Self : in out League.Holders.Holder; To : ESAPI.Users.User_Identifier)
       renames User_Identifier_Holders.Replace_Element;

   function To_Holder
    (Item : ESAPI.Users.User_Identifier) return League.Holders.Holder
       renames User_Identifier_Holders.To_Holder;

end ESAPI.Users.User_Identifier_Holders;
