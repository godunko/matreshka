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
with Ada.Text_IO; use Ada.Text_IO;
with Matreshka.Internals.Unicode.Ucd;

package body Builder is

   type Collation_Element_Sequence_Access is
     access all Matreshka.Internals.Unicode.Ucd.Collation_Element_Sequence;

   type Collation_Second_Stage_Access is
     access Matreshka.Internals.Unicode.Ucd.Collation_Second_Stage;

   type Collation_First_Stage is
     array (Matreshka.Internals.Unicode.Ucd.First_Stage_Index)
       of Collation_Second_Stage_Access;

   type Collation_First_Stage_Access is access all Collation_First_Stage;

   type Contractor_Array_Access is
     access all Matreshka.Internals.Unicode.Ucd.Contractor_Array;

   procedure Put_Line (Item : Matreshka.Internals.Unicode.Ucd.Contractor_Record);

   procedure Put (Item : Matreshka.Internals.Unicode.Code_Point) is
      use type Matreshka.Internals.Unicode.Code_Point;

      Hex : constant array (Matreshka.Internals.Unicode.Code_Point range 0 .. 15) of Character := "0123456789ABCDEF";

   begin
      Put ("16#");
      Put (Hex ((Item / 2 ** 20) mod 2 ** 4));
      Put (Hex ((Item / 2 ** 16) mod 2 ** 4));
      Put (Hex ((Item / 2 ** 12) mod 2 ** 4));
      Put (Hex ((Item / 2 ** 8) mod 2 ** 4));
      Put (Hex ((Item / 2 ** 4) mod 2 ** 4));
      Put (Hex ((Item) mod 2 ** 4));
      Put ('#');
   end Put;

   procedure Put_Line (Item : Matreshka.Internals.Unicode.Ucd.Contractor_Record) is
   begin
      Put (Item.Code);
      Put (Matreshka.Internals.Unicode.Ucd.Sequence_Count'Image (Item.Contractor_First));
      Put (Matreshka.Internals.Unicode.Ucd.Sequence_Count'Image (Item.Contractor_Last));
      Put (Matreshka.Internals.Unicode.Ucd.Sequence_Count'Image (Item.Expansion_First));
      Put (Matreshka.Internals.Unicode.Ucd.Sequence_Count'Image (Item.Expansion_Last));
      New_Line;
   end Put_Line;

   -----------
   -- Build --
   -----------

   function Build
    (Data : AllKeys_Reader.Collation_Information)
       return Matreshka.Internals.Locales.Collation_Data
   is
      use type AllKeys_Reader.Collation_Record_Access;
      use type Matreshka.Internals.Unicode.Code_Point;
      use type Matreshka.Internals.Unicode.Ucd.Sequence_Index;

      Expansion        : Collation_Element_Sequence_Access;
      Expansion_Last   : Matreshka.Internals.Unicode.Ucd.Sequence_Index;
      Contraction      : Contractor_Array_Access;
      Contraction_Last : Matreshka.Internals.Unicode.Ucd.Sequence_Index;
      Mapping          : Collation_First_Stage := (others => null);
      Last_Variable    : Matreshka.Internals.Unicode.Ucd.Collation_Weight := 0;
      Backwards        : Boolean;

      Current_Record : AllKeys_Reader.Collation_Record_Access;

      procedure Append_Expansion
       (Sequence : AllKeys_Reader.Collation_Element_Array;
        First    : out Matreshka.Internals.Unicode.Ucd.Sequence_Index;
        Last     : out Matreshka.Internals.Unicode.Ucd.Sequence_Index);
      --  Appends specified expansion sequence to collectd set of expansion
      --  sequences.

      procedure Process_Contractors
       (Start  : AllKeys_Reader.Collation_Record_Access;
        Prefix : AllKeys_Reader.Code_Point_Array;
        First  : out Matreshka.Internals.Unicode.Ucd.Sequence_Count;
        Last   : out Matreshka.Internals.Unicode.Ucd.Sequence_Count);
      --  Process contractors recursively.

      ----------------------
      -- Append_Expansion --
      ----------------------

      procedure Append_Expansion
       (Sequence : AllKeys_Reader.Collation_Element_Array;
        First    : out Matreshka.Internals.Unicode.Ucd.Sequence_Index;
        Last     : out Matreshka.Internals.Unicode.Ucd.Sequence_Index)
      is
         use type Matreshka.Internals.Unicode.Ucd.Collation_Element_Sequence;

         Internal        : Matreshka.Internals.Unicode.Ucd.Collation_Element_Sequence
                     (1 .. Sequence'Length);
         Internal_Last   : Matreshka.Internals.Unicode.Ucd.Sequence_Index
           := Internal'First;
         Expansion_First : Matreshka.Internals.Unicode.Ucd.Sequence_Index;

      begin
         --  Convert sequence of collation elements into format used by
         --  internal database and update greatest weight of variable
         --  character.

         for Element of Sequence loop
            Internal (Internal_Last) :=
             (Primary   => Element.Primary,
              Secondary => Element.Secondary,
              Trinary   => Element.Trinary);
            Internal_Last := Internal_Last + 1;

            if Element.Is_Variable then
               Last_Variable :=
                 Matreshka.Internals.Unicode.Ucd.Collation_Weight'Max
                  (Last_Variable, Element.Primary);
            end if;
         end loop;

         if Expansion = null then
            Expansion :=
              new Matreshka.Internals.Unicode.Ucd.Collation_Element_Sequence
                   (Matreshka.Internals.Unicode.Ucd.Sequence_Index'Range);
            Expansion_First := Expansion'First;
            Expansion_Last := Expansion'First + Internal'Length - 1;
            Expansion (Expansion'First .. Expansion_Last) := Internal;

         else
            --  Lookup to reuse of existent sequences in the table is not time
            --  efficient, thus it is not used here.

            Expansion_First := Expansion_Last + 1;
            Expansion_Last  := Expansion_Last + Internal'Length;
            Expansion (Expansion_First .. Expansion_Last) := Internal;
         end if;

         First := Expansion_First;
         Last  := Expansion_Last;
      end Append_Expansion;

      ------------------------------
      -- Process_Code_Point_Chain --
      ------------------------------

      procedure Process_Code_Point_Chain
       (Starter : Matreshka.Internals.Unicode.Code_Point)
      is
         Starter_First_Stage  : constant Matreshka.Internals.Unicode.Ucd.First_Stage_Index
           := Matreshka.Internals.Unicode.Ucd.First_Stage_Index
               (Starter
                  / Matreshka.Internals.Unicode.Ucd.Second_Stage_Index'Modulus);
         Starter_Second_Stage : constant Matreshka.Internals.Unicode.Ucd.Second_Stage_Index
           := Matreshka.Internals.Unicode.Ucd.Second_Stage_Index
               (Starter
                  mod Matreshka.Internals.Unicode.Ucd.Second_Stage_Index'Modulus);
         Current_Record       : AllKeys_Reader.Collation_Record_Access
           := Data.Collations (Starter);

      begin
         --  Allocate block when it wasn't allocated.

         if Mapping (Starter_First_Stage) = null then
            Mapping (Starter_First_Stage) :=
              new Matreshka.Internals.Unicode.Ucd.Collation_Second_Stage'
                   (others => (0, 0, 0, 0));
--            Put ("Group created for ");
--            Put (Matreshka.Internals.Unicode.Code_Point (Starter));
--            New_Line;
         end if;

         --  Lookup for collation record of code point itself (without
         --  contractors) and process it.

         while Current_Record /= null loop
            if Current_Record.Contractors'Length = 1 then
               Append_Expansion
                (Current_Record.Collations.all,
               Mapping (Starter_First_Stage) (Starter_Second_Stage).Expansion_First,
               Mapping (Starter_First_Stage) (Starter_Second_Stage).Expansion_Last);

               exit;
            end if;

            Current_Record := Current_Record.Next;
         end loop;

         Process_Contractors
          (Data.Collations (Starter),
           (1 => Starter),
           Mapping (Starter_First_Stage) (Starter_Second_Stage).Contractor_First,
           Mapping (Starter_First_Stage) (Starter_Second_Stage).Contractor_Last);
      end Process_Code_Point_Chain;

      -------------------------
      -- Process_Contractors --
      -------------------------

      procedure Process_Contractors
       (Start  : AllKeys_Reader.Collation_Record_Access;
        Prefix : AllKeys_Reader.Code_Point_Array;
        First  : out Matreshka.Internals.Unicode.Ucd.Sequence_Count;
        Last   : out Matreshka.Internals.Unicode.Ucd.Sequence_Count)
      is
         use type AllKeys_Reader.Code_Point_Array;

         Current_Record : AllKeys_Reader.Collation_Record_Access := Start;

      begin
         First := 0;
         Last  := 0;

         --  Process all contractors with currently processed length and
         --  started from given prefix.

         while Current_Record /= null loop
            if Current_Record.Contractors'Length = Prefix'Length + 1
              and Current_Record.Contractors
                   (Current_Record.Contractors'First
                      .. Current_Record.Contractors'Last - 1) = Prefix
            then
               if Contraction = null then
                  Contraction :=
                    new Matreshka.Internals.Unicode.Ucd.Contractor_Array
                         (Matreshka.Internals.Unicode.Ucd.Sequence_Index);
                  Contraction_Last := Contraction'First;

               else
                  Contraction_Last := Contraction_Last + 1;
               end if;

               if First = 0 then
                  First := Contraction_Last;
               end if;

               Last := Contraction_Last;

--               Put ("Add contractor for");
--
--               for J in Prefix'Range loop
--                  Put (' ');
--                  Put (Prefix (J));
--               end loop;
--
--               Put (" new contractor ");
--               Put (Current_Record.Contractors (Current_Record.Contractors'Last));
--
--               New_Line;

               Contraction (Contraction_Last).Code :=
                 Current_Record.Contractors (Current_Record.Contractors'Last);

               Append_Expansion
                (Current_Record.Collations.all,
                 Contraction (Contraction_Last).Expansion_First,
                 Contraction (Contraction_Last).Expansion_Last);
            end if;

            Current_Record := Current_Record.Next;
         end loop;

         if First /= 0 then
            for C in First .. Last loop
               Process_Contractors
                (Start,
                 Prefix & Contraction (C).Code,
                 Contraction (C).Contractor_First,
                 Contraction (C).Contractor_Last);
            end loop;
         end if;
      end Process_Contractors;

      First : Matreshka.Internals.Unicode.Ucd.Sequence_Index;
      Last  : Matreshka.Internals.Unicode.Ucd.Sequence_Index;
      Starter_First_Stage  : Matreshka.Internals.Unicode.Ucd.First_Stage_Index;
      Starter_Second_Stage : Matreshka.Internals.Unicode.Ucd.Second_Stage_Index;
      Contractors_Found    : Boolean;
      Contractors_Level    : Natural;

      use type Matreshka.Internals.Unicode.Ucd.First_Stage_Index;
      use type Matreshka.Internals.Unicode.Ucd.Collation_Second_Stage;

      Replaced :
        array (Matreshka.Internals.Unicode.Ucd.First_Stage_Index) of Boolean
          := (others => False);

   begin
      --  Collect expansion and constraction information.

      for Starting_Code in Data.Collations'Range loop
         Process_Code_Point_Chain (Starting_Code);
      end loop;

      Put_Line (Matreshka.Internals.Unicode.Ucd.Sequence_Index'Image (Expansion_Last));
      Put_Line (Matreshka.Internals.Unicode.Ucd.Sequence_Index'Image (Contraction_Last));

--      for J in Contraction'First .. Contraction_Last loop
--         Put (Matreshka.Internals.Unicode.Ucd.Sequence_Index'Image (J));
--         Put (" => ");
--         Put_Line (Contraction (J));
--      end loop;

      for J in Mapping'Range loop
         if not Replaced (J) then
            for K in J + 1 .. Mapping'Last loop
               if Mapping (J).all = Mapping (K).all then
--                  Free (Mapping (K));
                  Mapping (K) := Mapping (J);
                  Replaced (K) := True;
--            Put ("Group ");
--            Put (Matreshka.Internals.Unicode.Code_Point (J));
--            Put (" is equal to ");
--            Put (Matreshka.Internals.Unicode.Code_Point (K));
--            New_Line;
               end if;
           end loop;
         end if;
      end loop;

      return
       (Expansion     =>
          new Matreshka.Internals.Unicode.Ucd.Collation_Element_Sequence'
               (Expansion (Expansion'First .. Expansion_Last)),
        Contraction   =>
          new Matreshka.Internals.Unicode.Ucd.Contractor_Array'
               (Contraction (Contraction'First .. Contraction_Last)),
        Mapping       => null,
--          Matreshka.Internals.Unicode.Ucd.Collation_First_Stage_Access
--           (Mapping),
        Last_Variable => Last_Variable,
        Backwards     => Backwards);
   end Build;

end Builder;
