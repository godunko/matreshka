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

with League.Strings.Internals;

package body Matreshka.Internals.XML.Entity_Tables is

   procedure Free is
     new Ada.Unchecked_Deallocation (Entity_Array, Entity_Array_Access);

   procedure New_Entity
    (Self   : in out Entity_Table;
     Entity : out Entity_Identifier);
   --  Allocates new entity and returns its identifier. Reallocates internal
   --  memory when needed.

   ------------------------
   -- Enclosing_Base_URI --
   ------------------------

   function Enclosing_Base_URI
    (Self   : Entity_Table;
     Entity : Entity_Identifier)
       return not null Matreshka.Internals.Strings.Shared_String_Access is
   begin
      return Self.Data (Entity).Enclosing_Base_URI;
   end Enclosing_Base_URI;

   ----------------------
   -- Enclosing_Entity --
   ----------------------

   function Enclosing_Entity
    (Self   : Entity_Table;
     Entity : Entity_Identifier)
       return Matreshka.Internals.XML.Entity_Identifier is
   begin
      return Self.Data (Entity).Enclosing;
   end Enclosing_Entity;

   ---------------------
   -- Entity_Base_URI --
   ---------------------

   function Entity_Base_URI
    (Self   : Entity_Table;
     Entity : Entity_Identifier)
       return not null Matreshka.Internals.Strings.Shared_String_Access is
   begin
      return Self.Data (Entity).Entity_Base_URI;
   end Entity_Base_URI;

   --------------
   -- Finalize --
   --------------

   procedure Finalize (Self : in out Entity_Table) is
   begin
      for J in Self.Data'First .. Self.Last loop
         Matreshka.Internals.Strings.Dereference
          (Self.Data (J).Replacement_Text);
         Matreshka.Internals.Strings.Dereference (Self.Data (J).Public_Id);
         Matreshka.Internals.Strings.Dereference (Self.Data (J).System_Id);
         Matreshka.Internals.Strings.Dereference (Self.Data (J).Enclosing_Base_URI);
         Matreshka.Internals.Strings.Dereference (Self.Data (J).Entity_Base_URI);
      end loop;

      Free (Self.Data);
   end Finalize;

   ------------------
   -- First_Entity --
   ------------------

   function First_Entity (Self : Entity_Table) return Entity_Identifier is
      pragma Unreferenced (Self);

   begin
      return No_Entity + 1;
   end First_Entity;

   --------------------
   -- First_Position --
   --------------------

   function First_Position
    (Self   : Entity_Table;
     Entity : Entity_Identifier)
       return Matreshka.Internals.Utf16.Utf16_String_Index is
   begin
      return Self.Data (Entity).First_Position;
   end First_Position;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out Entity_Table) is

      procedure Register_Predefined_Entity
       (Name : Matreshka.Internals.XML.Symbol_Identifier;
        Text : League.Strings.Universal_String);
      --  Creates predefined entity.

      --------------------------------
      -- Register_Predefined_Entity --
      --------------------------------

      procedure Register_Predefined_Entity
       (Name : Matreshka.Internals.XML.Symbol_Identifier;
        Text : League.Strings.Universal_String)
      is
         T : constant Matreshka.Internals.Strings.Shared_String_Access
           := League.Strings.Internals.Internal (Text);
         E : Entity_Identifier;

      begin
         Matreshka.Internals.Strings.Reference (T);
         New_Internal_General_Entity (Self, No_Entity, Name, T, E);
      end Register_Predefined_Entity;

   begin
      Self.Data := new Entity_Array (1 .. 16);
      Self.Last := 0;

      Register_Predefined_Entity
       (Symbol_lt, League.Strings.To_Universal_String ("&#60;"));
      Register_Predefined_Entity
       (Symbol_gt, League.Strings.To_Universal_String (">"));
      Register_Predefined_Entity
       (Symbol_amp, League.Strings.To_Universal_String ("&#38;"));
      Register_Predefined_Entity
       (Symbol_apos, League.Strings.To_Universal_String ("'"));
      Register_Predefined_Entity
       (Symbol_quot, League.Strings.To_Universal_String (""""));
   end Initialize;

   ------------------------
   -- Is_Document_Entity --
   ------------------------

   function Is_Document_Entity
    (Self   : Entity_Table;
     Entity : Entity_Identifier) return Boolean is
   begin
      return Self.Data (Entity).Kind = Document_Entity;
   end Is_Document_Entity;

   ---------------------------------------
   -- Is_External_Parsed_General_Entity --
   ---------------------------------------

   function Is_External_Parsed_General_Entity
    (Self   : Entity_Table;
     Entity : Entity_Identifier) return Boolean is
   begin
      return Self.Data (Entity).Kind = External_Parsed_General_Entity;
   end Is_External_Parsed_General_Entity;

   ------------------------
   -- Is_External_Subset --
   ------------------------

   function Is_External_Subset
    (Self   : Entity_Table;
     Entity : Entity_Identifier) return Boolean is
   begin
      return Self.Data (Entity).Kind = External_Subset_Entity;
   end Is_External_Subset;

   -----------------------------------------
   -- Is_External_Unparsed_General_Entity --
   -----------------------------------------

   function Is_External_Unparsed_General_Entity
    (Self   : Entity_Table;
     Entity : Entity_Identifier) return Boolean is
   begin
      return Self.Data (Entity).Kind = External_Unparsed_General_Entity;
   end Is_External_Unparsed_General_Entity;

   --------------------------------
   -- Is_Internal_General_Entity --
   --------------------------------

   function Is_Internal_General_Entity
    (Self   : Entity_Table;
     Entity : Entity_Identifier) return Boolean is
   begin
      return Self.Data (Entity).Kind = Internal_General_Entity;
   end Is_Internal_General_Entity;

   -------------------------
   -- Is_Parameter_Entity --
   -------------------------

   function Is_Parameter_Entity
    (Self   : Entity_Table;
     Entity : Entity_Identifier) return Boolean is
   begin
      return
        Self.Data (Entity).Kind = Internal_Parameter_Entity
          or Self.Data (Entity).Kind = External_Parameter_Entity;
   end Is_Parameter_Entity;

   ------------------------------
   -- Is_Parsed_General_Entity --
   ------------------------------

   function Is_Parsed_General_Entity
    (Self   : Entity_Table;
     Entity : Entity_Identifier) return Boolean is
   begin
      return
        Self.Data (Entity).Kind = Internal_General_Entity
          or Self.Data (Entity).Kind = External_Parsed_General_Entity;
   end Is_Parsed_General_Entity;

   -----------------
   -- Is_Resolved --
   -----------------

   function Is_Resolved
    (Self   : Entity_Table;
     Entity : Entity_Identifier) return Boolean is
   begin
      return Self.Data (Entity).Is_Resolved;
   end Is_Resolved;

   ----------
   -- Name --
   ----------

   function Name
    (Self   : Entity_Table;
     Entity : Entity_Identifier)
       return Matreshka.Internals.XML.Symbol_Identifier is
   begin
      return Self.Data (Entity).Name;
   end Name;

   -------------------------
   -- New_Document_Entity --
   -------------------------

   procedure New_Document_Entity
    (Self            : in out Entity_Table;
     Public_Id       : League.Strings.Universal_String;
     System_Id       : League.Strings.Universal_String;
     Entity_Base_URI : League.Strings.Universal_String;
     Entity          : out Entity_Identifier)
   is
      P : constant Matreshka.Internals.Strings.Shared_String_Access
        := League.Strings.Internals.Internal (Public_Id);
      S : constant Matreshka.Internals.Strings.Shared_String_Access
        := League.Strings.Internals.Internal (System_Id);
      B : constant Matreshka.Internals.Strings.Shared_String_Access
        := League.Strings.Internals.Internal (Entity_Base_URI);

   begin
      New_Entity (Self, Entity);

      Matreshka.Internals.Strings.Reference (P);
      Matreshka.Internals.Strings.Reference (S);
      Matreshka.Internals.Strings.Reference (B);

      Self.Data (Entity) :=
       (Kind               => Document_Entity,
        Enclosing          => No_Entity,
        Name               => No_Symbol,
        Notation           => No_Symbol,
        Public_Id          => P,
        System_Id          => S,
        Enclosing_Base_URI => Matreshka.Internals.Strings.Shared_Empty'Access,
        Entity_Base_URI    => B,
        Is_Resolved        => False,
        Replacement_Text   => Matreshka.Internals.Strings.Shared_Empty'Access,
        First_Position     => 0);
   end New_Document_Entity;

   ----------------
   -- New_Entity --
   ----------------

   procedure New_Entity
    (Self   : in out Entity_Table;
     Entity : out Entity_Identifier)
   is
      Aux : Entity_Array_Access := Self.Data;

   begin
      Self.Last := Self.Last + 1;
      Entity := Self.Last;

      if Self.Last > Self.Data'Last then
         Self.Data :=
           new Entity_Array (Self.Data'First .. Self.Data'Last + 16);
         Self.Data (Aux'Range) := Aux.all;
         Free (Aux);
      end if;
   end New_Entity;

   -----------------------------------
   -- New_External_Parameter_Entity --
   -----------------------------------

   procedure New_External_Parameter_Entity
    (Self               : in out Entity_Table;
     Enclosing_Entity   : Entity_Identifier;
     Name               : Matreshka.Internals.XML.Symbol_Identifier;
     Public_Id          : League.Strings.Universal_String;
     System_Id          : League.Strings.Universal_String;
     Enclosing_Base_URI : League.Strings.Universal_String;
     Entity             : out Entity_Identifier)
   is
      P : constant Matreshka.Internals.Strings.Shared_String_Access
        := League.Strings.Internals.Internal (Public_Id);
      S : constant Matreshka.Internals.Strings.Shared_String_Access
        := League.Strings.Internals.Internal (System_Id);
      B : constant Matreshka.Internals.Strings.Shared_String_Access
        := League.Strings.Internals.Internal (Enclosing_Base_URI);

   begin
      New_Entity (Self, Entity);

      Matreshka.Internals.Strings.Reference (P);
      Matreshka.Internals.Strings.Reference (S);
      Matreshka.Internals.Strings.Reference (B);

      Self.Data (Entity) :=
       (Kind               => External_Parameter_Entity,
        Enclosing          => Enclosing_Entity,
        Name               => Name,
        Notation           => No_Symbol,
        Public_Id          => P,
        System_Id          => S,
        Enclosing_Base_URI => B,
        Entity_Base_URI    => Matreshka.Internals.Strings.Shared_Empty'Access,
        Is_Resolved        => False,
        Replacement_Text   => Matreshka.Internals.Strings.Shared_Empty'Access,
        First_Position     => 0);
   end New_External_Parameter_Entity;

   ----------------------------------------
   -- New_External_Parsed_General_Entity --
   ----------------------------------------

   procedure New_External_Parsed_General_Entity
    (Self               : in out Entity_Table;
     Enclosing_Entity   : Entity_Identifier;
     Name               : Matreshka.Internals.XML.Symbol_Identifier;
     Public_Id          : League.Strings.Universal_String;
     System_Id          : League.Strings.Universal_String;
     Enclosing_Base_URI : League.Strings.Universal_String;
     Entity             : out Entity_Identifier)
   is
      P : constant Matreshka.Internals.Strings.Shared_String_Access
        := League.Strings.Internals.Internal (Public_Id);
      S : constant Matreshka.Internals.Strings.Shared_String_Access
        := League.Strings.Internals.Internal (System_Id);
      B : constant Matreshka.Internals.Strings.Shared_String_Access
        := League.Strings.Internals.Internal (Enclosing_Base_URI);

   begin
      New_Entity (Self, Entity);

      Matreshka.Internals.Strings.Reference (P);
      Matreshka.Internals.Strings.Reference (S);
      Matreshka.Internals.Strings.Reference (B);

      Self.Data (Entity) :=
       (Kind               => External_Parsed_General_Entity,
        Enclosing          => Enclosing_Entity,
        Name               => Name,
        Notation           => No_Symbol,
        Public_Id          => P,
        System_Id          => S,
        Enclosing_Base_URI => B,
        Entity_Base_URI    => Matreshka.Internals.Strings.Shared_Empty'Access,
        Is_Resolved        => False,
        Replacement_Text   => Matreshka.Internals.Strings.Shared_Empty'Access,
        First_Position     => 0);
   end New_External_Parsed_General_Entity;

   --------------------------------
   -- New_External_Subset_Entity --
   --------------------------------

   procedure New_External_Subset_Entity
    (Self               : in out Entity_Table;
     Enclosing_Entity   : Entity_Identifier;
     Public_Id          : League.Strings.Universal_String;
     System_Id          : League.Strings.Universal_String;
     Enclosing_Base_URI : League.Strings.Universal_String;
     Entity             : out Entity_Identifier)
   is
      P : constant Matreshka.Internals.Strings.Shared_String_Access
        := League.Strings.Internals.Internal (Public_Id);
      S : constant Matreshka.Internals.Strings.Shared_String_Access
        := League.Strings.Internals.Internal (System_Id);
      B : constant Matreshka.Internals.Strings.Shared_String_Access
        := League.Strings.Internals.Internal (Enclosing_Base_URI);

   begin
      New_Entity (Self, Entity);

      Matreshka.Internals.Strings.Reference (P);
      Matreshka.Internals.Strings.Reference (S);
      Matreshka.Internals.Strings.Reference (B);

      Self.Data (Entity) :=
       (Kind               => External_Subset_Entity,
        Enclosing          => Enclosing_Entity,
        Name               => No_Symbol,
        Notation           => No_Symbol,
        Public_Id          => P,
        System_Id          => S,
        Enclosing_Base_URI => B,
        Entity_Base_URI    => Matreshka.Internals.Strings.Shared_Empty'Access,
        Is_Resolved        => False,
        Replacement_Text   => Matreshka.Internals.Strings.Shared_Empty'Access,
        First_Position     => 0);
   end New_External_Subset_Entity;

   ------------------------------------------
   -- New_External_Unparsed_General_Entity --
   ------------------------------------------

   procedure New_External_Unparsed_General_Entity
    (Self             : in out Entity_Table;
     Enclosing_Entity : Entity_Identifier;
     Name             : Matreshka.Internals.XML.Symbol_Identifier;
     Notation         : Symbol_Identifier;
     Entity           : out Entity_Identifier) is
   begin
      New_Entity (Self, Entity);

      Self.Data (Entity) :=
       (Kind               => External_Unparsed_General_Entity,
        Enclosing          => Enclosing_Entity,
        Name               => Name,
        Notation           => Notation,
        Public_Id          => Matreshka.Internals.Strings.Shared_Empty'Access,
        System_Id          => Matreshka.Internals.Strings.Shared_Empty'Access,
        Enclosing_Base_URI => Matreshka.Internals.Strings.Shared_Empty'Access,
        Entity_Base_URI    => Matreshka.Internals.Strings.Shared_Empty'Access,
        Is_Resolved        => False,
        Replacement_Text   => Matreshka.Internals.Strings.Shared_Empty'Access,
        First_Position     => 0);
   end New_External_Unparsed_General_Entity;

   ---------------------------------
   -- New_Internal_General_Entity --
   ---------------------------------

   procedure New_Internal_General_Entity
    (Self             : in out Entity_Table;
     Enclosing_Entity : Entity_Identifier;
     Name             : Matreshka.Internals.XML.Symbol_Identifier;
     Replacement_Text :
       not null Matreshka.Internals.Strings.Shared_String_Access;
     Entity           : out Entity_Identifier) is
   begin
      New_Entity (Self, Entity);

      Self.Data (Entity) :=
       (Kind               => Internal_General_Entity,
        Enclosing          => Enclosing_Entity,
        Name               => Name,
        Notation           => No_Symbol,
        Public_Id          => Matreshka.Internals.Strings.Shared_Empty'Access,
        System_Id          => Matreshka.Internals.Strings.Shared_Empty'Access,
        Enclosing_Base_URI => Matreshka.Internals.Strings.Shared_Empty'Access,
        Entity_Base_URI    => Matreshka.Internals.Strings.Shared_Empty'Access,
        Is_Resolved        => True,
        Replacement_Text   => Replacement_Text,
        First_Position     => 0);
   end New_Internal_General_Entity;

   -----------------------------------
   -- New_Internal_Parameter_Entity --
   -----------------------------------

   procedure New_Internal_Parameter_Entity
    (Self             : in out Entity_Table;
     Enclosing_Entity : Entity_Identifier;
     Name             : Matreshka.Internals.XML.Symbol_Identifier;
     Replacement_Text :
       not null Matreshka.Internals.Strings.Shared_String_Access;
     Entity           : out Entity_Identifier) is
   begin
      New_Entity (Self, Entity);

      Self.Data (Entity) :=
       (Kind               => Internal_Parameter_Entity,
        Enclosing          => Enclosing_Entity,
        Name               => Name,
        Notation           => No_Symbol,
        Public_Id          => Matreshka.Internals.Strings.Shared_Empty'Access,
        System_Id          => Matreshka.Internals.Strings.Shared_Empty'Access,
        Enclosing_Base_URI => Matreshka.Internals.Strings.Shared_Empty'Access,
        Entity_Base_URI    => Matreshka.Internals.Strings.Shared_Empty'Access,
        Is_Resolved        => True,
        Replacement_Text   => Replacement_Text,
        First_Position     => 0);
   end New_Internal_Parameter_Entity;

   -----------------
   -- Next_Entity --
   -----------------

   procedure Next_Entity
    (Self   : Entity_Table;
     Entity : in out Entity_Identifier) is
   begin
      if Entity = Self.Last then
         Entity := No_Entity;

      else
         Entity := Entity + 1;
      end if;
   end Next_Entity;

   --------------
   -- Notation --
   --------------

   function Notation
    (Self   : Entity_Table;
     Entity : Entity_Identifier)
       return Matreshka.Internals.XML.Symbol_Identifier is
   begin
      return Self.Data (Entity).Notation;
   end Notation;

   ---------------
   -- Public_Id --
   ---------------

   function Public_Id
    (Self   : Entity_Table;
     Entity : Entity_Identifier)
       return not null Matreshka.Internals.Strings.Shared_String_Access is
   begin
      return Self.Data (Entity).Public_Id;
   end Public_Id;

   ----------------------
   -- Replacement_Text --
   ----------------------

   function Replacement_Text
    (Self   : Entity_Table;
     Entity : Entity_Identifier)
       return Matreshka.Internals.Strings.Shared_String_Access is
   begin
      return Self.Data (Entity).Replacement_Text;
   end Replacement_Text;

   -----------
   -- Reset --
   -----------

   procedure Reset (Self : in out Entity_Table) is
   begin
      Finalize (Self);
      Initialize (Self);
   end Reset;

   -------------------------
   -- Set_Entity_Base_URI --
   -------------------------

   procedure Set_Entity_Base_URI
    (Self            : in out Entity_Table;
     Entity          : Entity_Identifier;
     Entity_Base_URI : League.Strings.Universal_String)
   is
      B : constant Matreshka.Internals.Strings.Shared_String_Access
        := League.Strings.Internals.Internal (Entity_Base_URI);

   begin
      Matreshka.Internals.Strings.Dereference
       (Self.Data (Entity).Entity_Base_URI);
      Self.Data (Entity).Entity_Base_URI := B;
      Matreshka.Internals.Strings.Reference
       (Self.Data (Entity).Entity_Base_URI);
   end Set_Entity_Base_URI;

   ------------------------
   -- Set_First_Position --
   ------------------------

   procedure Set_First_Position
    (Self     : in out Entity_Table;
     Entity   : Entity_Identifier;
     Position : Matreshka.Internals.Utf16.Utf16_String_Index) is
   begin
      Self.Data (Entity).First_Position := Position;
   end Set_First_Position;

   ---------------------
   -- Set_Is_Resolved --
   ---------------------

   procedure Set_Is_Resolved
    (Self   : in out Entity_Table;
     Entity : Entity_Identifier;
     To     : Boolean) is
   begin
      Self.Data (Entity).Is_Resolved := To;
   end Set_Is_Resolved;

   --------------------------
   -- Set_Replacement_Text --
   --------------------------

   procedure Set_Replacement_Text
    (Self             : in out Entity_Table;
     Entity           : Entity_Identifier;
     Replacement_Text :
       not null Matreshka.Internals.Strings.Shared_String_Access) is
   begin
      Self.Data (Entity).Replacement_Text := Replacement_Text;
   end Set_Replacement_Text;

   ---------------
   -- System_Id --
   ---------------

   function System_Id
    (Self   : Entity_Table;
     Entity : Entity_Identifier)
       return not null Matreshka.Internals.Strings.Shared_String_Access is
   begin
      return Self.Data (Entity).System_Id;
   end System_Id;

end Matreshka.Internals.XML.Entity_Tables;
