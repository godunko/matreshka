------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2010-2012, Vadim Godunko <vgodunko@gmail.com>                --
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

package body Matreshka.Internals.XML.Element_Tables is

   procedure Free is
     new Ada.Unchecked_Deallocation (Element_Array, Element_Array_Access);

   ----------------
   -- Attributes --
   ----------------

   function Attributes
    (Self    : Element_Table;
     Element : Element_Identifier) return Attribute_Identifier is
   begin
      return Self.Table (Element).Attributes;
   end Attributes;

   --------------
   -- Finalize --
   --------------

   procedure Finalize (Self : in out Element_Table) is
   begin
      Free (Self.Table);
   end Finalize;

   -------------------
   -- First_Element --
   -------------------

   function First_Element (Self : Element_Table) return Element_Identifier is
   begin
      if Self.Last /= No_Element then
         return No_Element + 1;
         --  First element of Self.Table has index No_Element + 1 by
         --  convention.

      else
         return No_Element;
      end if;
   end First_Element;

   ------------------
   -- Has_Children --
   ------------------

   function Has_Children
    (Self    : Element_Table;
     Element : Element_Identifier) return Boolean is
   begin
      return Self.Table (Element).Has_Children;
   end Has_Children;

   ------------
   -- Is_Any --
   ------------

   function Is_Any
    (Self    : Element_Table;
     Element : Element_Identifier) return Boolean is
   begin
      return Self.Table (Element).Is_Any;
   end Is_Any;

   ----------------------------
   -- Is_Attributes_Declared --
   ----------------------------

   function Is_Attributes_Declared
    (Self    : Element_Table;
     Element : Element_Identifier) return Boolean is
   begin
      return Self.Table (Element).Is_Attributes_Declared;
   end Is_Attributes_Declared;

   -----------------
   -- Is_Declared --
   -----------------

   function Is_Declared
    (Self    : Element_Table;
     Element : Element_Identifier) return Boolean is
   begin
      return Self.Table (Element).Is_Declared;
   end Is_Declared;

   --------------
   -- Is_Empty --
   --------------

   function Is_Empty
    (Self    : Element_Table;
     Element : Element_Identifier) return Boolean is
   begin
      return Self.Table (Element).Is_Empty;
   end Is_Empty;

   ----------------------
   -- Is_Mixed_Content --
   ----------------------

   function Is_Mixed_Content
    (Self    : Element_Table;
     Element : Element_Identifier) return Boolean is
   begin
      return Self.Table (Element).Is_Mixed_Content;
   end Is_Mixed_Content;

   -----------------
   -- New_Element --
   -----------------

   procedure New_Element
    (Self    : in out Element_Table;
     Element : out Element_Identifier) is
   begin
      Self.Last := Self.Last + 1;

      if Self.Last > Self.Table'Last then
         declare
            Old : Element_Array_Access := Self.Table;

         begin
            Self.Table := new Element_Array (1 .. Old'Last + 16);
            Self.Table (Old'Range) := Old.all;
            Free (Old);
         end;
      end if;

      Element := Self.Last;
      Self.Table (Element) :=
       (Attributes             => No_Attribute,
        Is_Declared            => False,
        Is_Attributes_Declared => False,
        Is_Empty               => False,
        Is_Any                 => False,
        Is_Mixed_Content       => False,
        Has_Children           => False);
   end New_Element;

   ------------------
   -- Next_Element --
   ------------------

   procedure Next_Element
    (Self    : Element_Table;
     Element : in out Element_Identifier) is
   begin
      if Element = Self.Last then
         Element := No_Element;

      else
         Element := Element + 1;
      end if;
   end Next_Element;

   -----------
   -- Reset --
   -----------

   procedure Reset (Self : in out Element_Table) is
   begin
      Self.Last := No_Element;
   end Reset;

   --------------------
   -- Set_Attributes --
   --------------------

   procedure Set_Attributes
    (Self      : in out Element_Table;
     Element   : Element_Identifier;
     Attribute : Attribute_Identifier) is
   begin
      Self.Table (Element).Attributes := Attribute;
   end Set_Attributes;

   ----------------------
   -- Set_Has_Children --
   ----------------------

   procedure Set_Has_Children
    (Self    : in out Element_Table;
     Element : Element_Identifier;
     Value   : Boolean) is
   begin
      Self.Table (Element).Has_Children := Value;
   end Set_Has_Children;

   ----------------
   -- Set_Is_Any --
   ----------------

   procedure Set_Is_Any
    (Self    : in out Element_Table;
     Element : Element_Identifier;
     Value   : Boolean) is
   begin
      Self.Table (Element).Is_Any := Value;
   end Set_Is_Any;

   --------------------------------
   -- Set_Is_Attributes_Declared --
   --------------------------------

   procedure Set_Is_Attributes_Declared
    (Self     : in out Element_Table;
     Element  : Element_Identifier;
     Declared : Boolean) is
   begin
      Self.Table (Element).Is_Attributes_Declared := Declared;
   end Set_Is_Attributes_Declared;

   ---------------------
   -- Set_Is_Declared --
   ---------------------

   procedure Set_Is_Declared
    (Self     : in out Element_Table;
     Element  : Element_Identifier;
     Declared : Boolean) is
   begin
      Self.Table (Element).Is_Declared := Declared;
   end Set_Is_Declared;

   ------------------
   -- Set_Is_Empty --
   ------------------

   procedure Set_Is_Empty
    (Self    : in out Element_Table;
     Element : Element_Identifier;
     Value   : Boolean) is
   begin
      Self.Table (Element).Is_Empty := Value;
   end Set_Is_Empty;

   --------------------------
   -- Set_Is_Mixed_Content --
   --------------------------

   procedure Set_Is_Mixed_Content
    (Self    : in out Element_Table;
     Element : Element_Identifier;
     Value   : Boolean) is
   begin
      Self.Table (Element).Is_Mixed_Content := Value;
   end Set_Is_Mixed_Content;

end Matreshka.Internals.XML.Element_Tables;
