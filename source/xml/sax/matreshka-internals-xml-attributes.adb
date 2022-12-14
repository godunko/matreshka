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
-- Copyright © 2010-2011, Vadim Godunko <vgodunko@gmail.com>                --
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

package body Matreshka.Internals.XML.Attributes is

   procedure Free is
     new Ada.Unchecked_Deallocation (Attribute_Array, Attribute_Array_Access);

   -----------
   -- Clear --
   -----------

   procedure Clear (Self : in out Attribute_Set) is
   begin
      for J in Self.Attributes'First .. Self.Last loop
         Matreshka.Internals.Strings.Dereference (Self.Attributes (J).Value);
      end loop;

      Self.Last := 0;
   end Clear;

   --------------
   -- Finalize --
   --------------

   procedure Finalize (Self : in out Attribute_Set) is
   begin
      Clear (Self);
      Free (Self.Attributes);
   end Finalize;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out Attribute_Set) is
   begin
      Self.Attributes := new Attribute_Array (1 .. 16);
      Self.Last := 0;
   end Initialize;

   ------------
   -- Insert --
   ------------

   procedure Insert
    (Self           : in out Attribute_Set;
     Qualified_Name : Symbol_Identifier;
     Value          :
       not null Matreshka.Internals.Strings.Shared_String_Access;
     Type_Name      : Symbol_Identifier;
     Is_Specified   : Boolean;
     Inserted       : out Boolean) is
   begin
      for J in Self.Attributes'First .. Self.Last loop
         if Self.Attributes (J).Qualified_Name = Qualified_Name then
            Inserted := False;

            return;
         end if;
      end loop;

      Matreshka.Internals.Strings.Reference (Value);
      Inserted := True;
      Self.Last := Self.Last + 1;

      if Self.Last > Self.Attributes'Last then
         declare
            Old : Attribute_Array_Access := Self.Attributes;

         begin
            Self.Attributes := new Attribute_Array (1 .. Old'Last + 16);
            Self.Attributes (Old'Range) := Old.all;
            Free (Old);
         end;
      end if;

      Self.Attributes (Self.Last) :=
       (Namespace_URI  => No_Symbol,
        Qualified_Name => Qualified_Name,
        Value          => Value,
        Type_Name      => Type_Name,
        Is_Declared    => False,
        Is_Specified   => Is_Specified);
   end Insert;

   -----------------
   -- Is_Declared --
   -----------------

   function Is_Declared
    (Self  : Attribute_Set;
     Index : Positive) return Boolean is
   begin
      return Self.Attributes (Index).Is_Declared;
   end Is_Declared;

   ------------------
   -- Is_Specified --
   ------------------

   function Is_Specified
    (Self  : Attribute_Set;
     Index : Positive) return Boolean is
   begin
      return Self.Attributes (Index).Is_Specified;
   end Is_Specified;

   ------------
   -- Length --
   ------------

   function Length (Self : Attribute_Set) return Natural is
   begin
      return Self.Last;
   end Length;

   -------------------
   -- Namespace_URI --
   -------------------

   function Namespace_URI
    (Self  : Attribute_Set;
     Index : Positive) return Symbol_Identifier is
   begin
      return Self.Attributes (Index).Namespace_URI;
   end Namespace_URI;

   --------------------
   -- Qualified_Name --
   --------------------

   function Qualified_Name
    (Self  : Attribute_Set;
     Index : Positive) return Symbol_Identifier is
   begin
      return Self.Attributes (Index).Qualified_Name;
   end Qualified_Name;

   ---------------------
   -- Set_Is_Declared --
   ---------------------

   procedure Set_Is_Declared
    (Self  : in out Attribute_Set;
     Index : Positive) is
   begin
      Self.Attributes (Index).Is_Declared := True;
   end Set_Is_Declared;

   -----------------------
   -- Set_Namespace_URI --
   -----------------------

   procedure Set_Namespace_URI
    (Self          : Attribute_Set;
     Index         : Positive;
     Namespace_URI : Symbol_Identifier) is
   begin
      Self.Attributes (Index).Namespace_URI := Namespace_URI;
   end Set_Namespace_URI;

   ---------------
   -- Type_Name --
   ---------------

   function Type_Name
    (Self  : Attribute_Set;
     Index : Positive) return Symbol_Identifier is
   begin
      return Self.Attributes (Index).Type_Name;
   end Type_Name;

   -----------
   -- Value --
   -----------

   function Value
    (Self  : Attribute_Set;
     Index : Positive)
       return not null Matreshka.Internals.Strings.Shared_String_Access is
   begin
      return Self.Attributes (Index).Value;
   end Value;

end Matreshka.Internals.XML.Attributes;
