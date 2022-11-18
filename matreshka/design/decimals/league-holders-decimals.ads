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
-- Copyright © 2013, Vadim Godunko <vgodunko@gmail.com>                     --
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
--  This package provides type to represent fixed point decimal numbers of
--  arbitrary precision and conversion subprogram to/from Holder type.
------------------------------------------------------------------------------
private with Ada.Decimal;

package League.Holders.Decimals is

   pragma Preelaborate;

   Universal_Decimal_Tag : constant Tag;

   type Universal_Decimal is private;

   function Is_Abstract_Decimal (Self : Holder) return Boolean;
   --  Returns True if contained value has any decimal type.

   function Element (Self : Holder) return Universal_Decimal;
   --  Returns internal value as a longest supported decimal.

   procedure Replace_Element (Self : in out Holder; To : Universal_Decimal);
   --  Set value from a longest supported decimal. Raises Contraint_Error if
   --  value is outside of the range of valid values for actual decimal type.

private

   type Mantissa is delta 1.0 digits Ada.Decimal.Max_Decimal_Digits;

   type Universal_Decimal is record
      Value : Mantissa;
      Small : Integer;
      --  Small = T'Small if T'Small >= 1.0 and -1/T'Small otherwise
   end record;

   --------------------------------
   -- Abstract_Decimal_Container --
   --------------------------------

   --  Abstract_Decimal_Container is root container type to store decimal
   --  values. There are two types which is derived from it: one to store
   --  "universal" decimal, and other one to store value of named decimal type.

   type Abstract_Decimal_Container is
     abstract new Abstract_Container with null record;

   not overriding function Get
    (Self : not null access constant Abstract_Decimal_Container)
       return Universal_Decimal is abstract;

   not overriding procedure Set
    (Self : not null access Abstract_Decimal_Container;
     To   : Universal_Decimal) is abstract;

   ---------------------------------
   -- Universal_Decimal_Container --
   ---------------------------------

   --  Universal_Decimal_Container is container for value of "universal"
   --  decimal type. This type is compatible with any decimal types and used
   --  when there are no additional information is available.

   type Universal_Decimal_Container is
     new Abstract_Decimal_Container with
   record
      Value : Universal_Decimal;
   end record;

   overriding function Constructor
    (Is_Empty : not null access Boolean) return Universal_Decimal_Container;

   overriding function Get
    (Self : not null access constant Universal_Decimal_Container)
       return Universal_Decimal;

   overriding procedure Set
    (Self : not null access Universal_Decimal_Container;
     To   : Universal_Decimal);

   Universal_Decimal_Tag : constant Tag
     := Tag (Universal_Decimal_Container'Tag);

end League.Holders.Decimals;
