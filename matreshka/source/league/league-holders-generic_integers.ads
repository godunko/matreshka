------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2009-2011, Vadim Godunko <vgodunko@gmail.com>                --
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
--  This generic package allows to store value of arbitrary integer type in
--  the Value.
------------------------------------------------------------------------------

generic
   type Num is range <>;

package League.Holders.Generic_Integers is

   pragma Preelaborate;

   Integer_Tag : constant Tag;

   function Is_Integer (Self : Holder) return Boolean;
   --  Returns True when holder contains object of the integer type.

   function Element (Self : Holder) return Num;
   --  Returns internal value.

   procedure Replace_Element (Self : in out Holder; To : Num);
   --  Set value. Tag of the value must be set before this call.

   function To_Holder (Item : Num) return Holder;
   --  Creates new Value from specified value.

private

   type Integer_Container is new Abstract_Integer_Container with record
      Value : Num;
   end record;

   overriding function Constructor
    (Is_Empty : not null access Boolean) return Integer_Container;

   overriding function Get
    (Self : not null access constant Integer_Container)
       return Universal_Integer;

   overriding procedure Set
    (Self : not null access Integer_Container; To : Universal_Integer);

   overriding function First
    (Self : not null access constant Integer_Container)
       return Universal_Integer;

   overriding function Last
    (Self : not null access constant Integer_Container)
       return Universal_Integer;

   Integer_Tag : constant Tag := Tag (Integer_Container'Tag);

end League.Holders.Generic_Integers;
