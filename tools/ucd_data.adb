------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2009-2015, Vadim Godunko <vgodunko@gmail.com>                --
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
with Ada.Text_IO;
with Ada.Unchecked_Deallocation;

with Ucd_Input;
with Utils;

package body Ucd_Data is

   use Matreshka.Internals.Unicode;
   use Matreshka.Internals.Unicode.Ucd;
   use Utils;

   UnicodeData_Name                : constant String := "UnicodeData.txt";
   PropList_Name                   : constant String := "PropList.txt";
   DerivedCoreProperties_Name      : constant String
     := "DerivedCoreProperties.txt";
   EastAsianWidth_Name             : constant String
     := "EastAsianWidth.txt";
   GraphemeBreakProperty_Name      : constant String
     := "auxiliary/GraphemeBreakProperty.txt";
   WordBreakProperty_Name          : constant String
     := "auxiliary/WordBreakProperty.txt";
   SentenceBreakProperty_Name      : constant String
     := "auxiliary/SentenceBreakProperty.txt";
   LineBreak_Name                  : constant String := "LineBreak.txt";
   SpecialCasing_Name              : constant String := "SpecialCasing.txt";
   CaseFolding_Name                : constant String := "CaseFolding.txt";
   DerivedNormalizationProps_Name  : constant String
     := "DerivedNormalizationProps.txt";
   CompositionExclusions_Name      : constant String
     := "CompositionExclusions.txt";
   NormalizationCorrections_Name   : constant String
     := "NormalizationCorrections.txt";

   subtype Primary_Core_Boolean_Properties is Boolean_Properties
     range ASCII_Hex_Digit .. White_Space;

   subtype Derived_Core_Boolean_Properties is Boolean_Properties
     range Alphabetic .. XID_Start;

   procedure Load_UnicodeData (Unidata_Directory : String);
   --  Parse UnicodeData.txt file and fill internal data structures by the
   --  parsed values.

   procedure Load_PropList (Unidata_Directory : String);
   --  Parse PropList.txt file and fill internal data structurs by the parsed
   --  values.

   procedure Load_DerivedCoreProperties (Unidata_Directory : String);
   --  Parse DerivedCoreProperties.txt file and fill internal data structurs by
   --  the parsed values.

   procedure Load_EastAsianWidth (Unidata_Directory : String);
   --  Parse EastAsianWidth.txt file and fill internal data structurs by --
   --  the parsed values.

   procedure Load_GraphemeBreakProperty (Unidata_Directory : String);
   --  Parse GraphemeBreakProperty.txt file and fill internal data structurs by
   --  the parsed values.

   procedure Load_WordBreakProperty (Unidata_Directory : String);
   --  Parse WordBreakProperty.txt file and fill internal data structurs by the
   --  parsed values.

   procedure Load_SentenceBreakProperty (Unidata_Directory : String);
   --  Parse SentenceBreakProperty.txt file and fill internal data structurs by
   --  the parsed values.

   procedure Load_LineBreak (Unidata_Directory : String);
   --  Parse LineBreak.txt file and fill internal data structurs by the parsed
   --  values.

   procedure Load_SpecialCasing (Unidata_Directory : String);
   --  Parse SpecialCasing.txt file and fill internal data structurs by the
   --  parsed values.

   procedure Load_CaseFolding (Unidata_Directory : String);
   --  Parse CaseFolding.txt file and fill internal data structurs by the
   --  parsed values.

   procedure Load_CompositionExclusions (Unidata_Directory : String);
   --  Parse CompositionExclusions.txt file and fill internal data structures
   --  by the parsed values.

   procedure Load_DerivedNormalizationProps (Unidata_Directory : String);
   --  Parse DerivedNormalizationProps.txt file and fill internal data
   --  structures by the parsed values.

   procedure Load_NormalizationCorrections (Unidata_Directory : String);
   --  Parse NormalizationCorrections.txt file and fill internal data
   --  structures by the parsed values.

   procedure Compute_Full_Normalization_Data;
   --  Compute full normalization mapping for both normalization forms.

   procedure Parse_Code_Point
    (Text : String;
     Code : out Code_Point);

   function Value (Item : String) return General_Category;
   --  Converts two-character text representation of the General_Category
   --  property into the value.

   function Value (Item : String) return Grapheme_Cluster_Break;
   --  Converts text representation of the Grapheme_Cluster_Break into the
   --  value.

   function Value (Item : String) return East_Asian_Width;
   --  Converts text representation of the East_Asian_Width into value.

   function Value (Item : String) return Word_Break;
   --  Converts text representation of the Word_Break into the value.

   function Value (Item : String) return Sentence_Break;
   --  Converts text representation of the Sentence_Break into the value.

   function Value (Item : String) return Line_Break;
   --  Converts two-character text representation of the Line_Break into the
   --  value.

   function Value (Item : String) return Normalization_Quick_Check;
   --  Converts one character text representation of the normalization quick
   --  check into the value.

   function Value (Item : String) return Decomposition_Type;
   --  Converts text representation of the Decomposition_Type into the value.

   procedure Free is
     new Ada.Unchecked_Deallocation
          (Code_Point_Sequence, Code_Point_Sequence_Access);

   -------------------------------------
   -- Compute_Full_Normalization_Data --
   -------------------------------------

   procedure Compute_Full_Normalization_Data is

      procedure Expand (Kind : Normalization_Kinds);

      ------------
      -- Expand --
      ------------

      procedure Expand (Kind : Normalization_Kinds) is

         function Has_Mapping (Code : Code_Point) return Boolean;
         --  Returns True if code point has corresponding to Kind mapping.

         function Decompose (Code : Code_Point) return Code_Point_Sequence;
         --  Returns character's decomposition.

         subtype S_Hangul is Code_Point
           range Hangul_Syllable_First .. Hangul_Syllable_Last;

         ---------------
         -- Decompose --
         ---------------

         function Decompose (Code : Code_Point) return Code_Point_Sequence is
         begin
            if Code in S_Hangul then
               raise Program_Error
                 with "Decomposition of Hangul Syllables doesn't supported"
                        & " for now";

            else
               return Norms (Code).Values (Kind).all;
            end if;
         end Decompose;

         -----------------
         -- Has_Mapping --
         -----------------

         function Has_Mapping (Code : Code_Point) return Boolean is
         begin
            if Code in S_Hangul then
               return True;

            else
               case Kind is
                  when Canonical_Mapping =>
                     raise Program_Error;

                  when Canonical =>
                     return Norms (Code).DT = Canonical;

                  when Compatibility =>
                     return Norms (Code).DT /= None;
               end case;
            end if;
         end Has_Mapping;

         Expanded : Boolean;

      begin
         loop
            Expanded := False;

            for J in Norms'Range loop
               if Has_Mapping (J) and then J not in S_Hangul then
                  declare
                     M : Code_Point_Sequence_Access := null;
                     A : Code_Point_Sequence_Access;

                  begin
                     for K in Norms (J).Values (Kind)'Range loop
                        if Has_Mapping (Norms (J).Values (Kind) (K)) then
                           if M = null then
                              M :=
                                new Code_Point_Sequence'
                                     (Norms (J).Values (Kind) (1 .. K - 1)
                                        & Decompose
                                           (Norms (J).Values (Kind) (K)));

                           else
                              A := M;
                              M :=
                                new Code_Point_Sequence'
                                     (A.all
                                        & Decompose
                                           (Norms (J).Values (Kind) (K)));
                              Free (A);
                           end if;

                        elsif M /= null then
                           A := M;
                           M :=
                             new Code_Point_Sequence'
                                  (A.all & Norms (J).Values (Kind) (K));
                           Free (A);
                        end if;
                     end loop;

                     if M /= null then
                        Free (Norms (J).Values (Kind));
                        Norms (J).Values (Kind) := M;
                        Expanded := True;
                     end if;
                  end;
               end if;
            end loop;

            exit when not Expanded;
         end loop;
      end Expand;

   begin
      Expand (Canonical);
      Expand (Compatibility);
   end Compute_Full_Normalization_Data;

   ----------
   -- Load --
   ----------

   procedure Load (Unidata_Directory : String) is
   begin
      Ada.Text_IO.Put_Line
       (Ada.Text_IO.Standard_Error, "Initializing UCD ...");

      --  Initialize data structures to default values.

      Core :=
        new Core_Values_Array'
             (others =>
               (GC  => Unassigned,       --  see UCD.html
                GCB => Other,            --  see GraphemeBreakProperty.txt
                WB  => Other,            --  see WordBreakProperty.txt
                SB  => Other,            --  see SentenceBreakProperty.txt
                LB  => Unknown,          --  see LineBreak.txt
                EA  => Neutral,          --  see EastAsianWidth.txt
                B   => (others => False)));

      Cases :=
        new Case_Values_Array'
             (others =>
               (SUM | SLM | STM | SCF => (Present => False),
                FUM | FLM | FTM       =>
                 (Default => null, others => (others => null)),
                FCF                   => null));

      Norms :=
        new Normalization_Values_Array'
             (others => (CCC    => Not_Reordered,
                         NQC    => (others => Yes),
                         DT     => None,
                         B      => (others => False),
                         Values => (others => null)));

      --  Load UnicodeData.txt, PropList.txt.

      Ada.Text_IO.Put_Line
       (Ada.Text_IO.Standard_Error,
        "Loading UCD (" & Unidata_Directory & ") ...");

      Load_UnicodeData (Unidata_Directory);
      Load_PropList (Unidata_Directory);

      --  Load DerivedCoreProperties.txt.
      --  NOTE: Data in the file is derived from the other information, so
      --  it is possible to use it for verification purposes only.

      Load_DerivedCoreProperties (Unidata_Directory);

      --  Load EastAsianWidth.txt

      Load_EastAsianWidth (Unidata_Directory);

      --  Load GraphemeBreakProperty.txt, WordBreakProperty.txt.

      Load_GraphemeBreakProperty (Unidata_Directory);
      Load_WordBreakProperty (Unidata_Directory);
      Load_SentenceBreakProperty (Unidata_Directory);
      Load_LineBreak (Unidata_Directory);

      --  Load SpecialCasing.txt, CaseFolding.txt

      Load_SpecialCasing (Unidata_Directory);
      Load_CaseFolding (Unidata_Directory);

      --  Load CompositionExclusions.txt, DerivedNormalizationProps.txt,
      --  NormalizationCorrections.txt.

      Load_CompositionExclusions (Unidata_Directory);
      Load_DerivedNormalizationProps (Unidata_Directory);
      Load_NormalizationCorrections (Unidata_Directory);

      --  Compute derived properties.

      Compute_Full_Normalization_Data;

      --  Verify data:
      --    - DerivedGeneralCategory.txt
      --    - DerivedCombiningClass.txt
      --    - DerivedBinaryProperties.txt
      --    - DerivedDecompositionType.txt
      --    - DerivedLineBreak.txt

   end Load;

   ----------------------
   -- Load_CaseFolding --
   ----------------------

   procedure Load_CaseFolding (Unidata_Directory : String) is

      type Case_Folding_Status is (C, F, S, T);

      File   : Ucd_Input.File_Type;
      Code   : Code_Point;
      Status : Case_Folding_Status;

   begin
      Ada.Text_IO.Put_Line
       (Ada.Text_IO.Standard_Error, "   ... " & CaseFolding_Name);

      Ucd_Input.Open (File, Unidata_Directory & '/' & CaseFolding_Name);

      while not Ucd_Input.End_Of_Data (File) loop
         Code := Ucd_Input.First_Code_Point (File);

         --  Status

         Status := Case_Folding_Status'Value (Ucd_Input.Field (File));
         Ucd_Input.Next_Field (File);

         --  Mapping

         case Status is
            when C | S =>
               Cases (Code).SCF := (True, 0);
               Parse_Code_Point (Ucd_Input.Field (File), Cases (Code).SCF.C);

            when F =>
               Cases (Code).FCF :=
                 new Code_Point_Sequence'
                      (Parse_Code_Point_Sequence (Ucd_Input.Field (File)));

            when T =>
               Ada.Text_IO.Put_Line
                (Ada.Text_IO.Standard_Error, "         Ignore mapping: T");
         end case;

         Ucd_Input.Next_Record (File);
      end loop;

      Ucd_Input.Close (File);
   end Load_CaseFolding;

   --------------------------------
   -- Load_CompositionExclusions --
   --------------------------------

   procedure Load_CompositionExclusions (Unidata_Directory : String) is
      File  : Ucd_Input.File_Type;
      First : Code_Point;
      Last  : Code_Point;

   begin
      Ada.Text_IO.Put_Line
       (Ada.Text_IO.Standard_Error, "   ... " & CompositionExclusions_Name);

      Ucd_Input.Open
       (File, Unidata_Directory & '/' & CompositionExclusions_Name);

      while not Ucd_Input.End_Of_Data (File) loop
         First := Ucd_Input.First_Code_Point (File);
         Last  := Ucd_Input.Last_Code_Point (File);

         for J in First .. Last loop
            Norms (J).B (Composition_Exclusion) := True;
         end loop;

         Ucd_Input.Next_Record (File);
      end loop;

      Ucd_Input.Close (File);
   end Load_CompositionExclusions;

   --------------------------------
   -- Load_DerivedCoreProperties --
   --------------------------------

   procedure Load_DerivedCoreProperties (Unidata_Directory : String) is
      File  : Ucd_Input.File_Type;
      First : Code_Point;
      Last  : Code_Point;
      Prop  : Derived_Core_Boolean_Properties;

   begin
      Ada.Text_IO.Put_Line
       (Ada.Text_IO.Standard_Error, "   ... " & DerivedCoreProperties_Name);

      Ucd_Input.Open
       (File, Unidata_Directory & '/' & DerivedCoreProperties_Name);

      while not Ucd_Input.End_Of_Data (File) loop
         First := Ucd_Input.First_Code_Point (File);
         Last  := Ucd_Input.Last_Code_Point (File);
         Prop  :=
           Derived_Core_Boolean_Properties'Value (Ucd_Input.Field (File));

         for J in First .. Last loop
            Core (J).B (Prop) := True;
         end loop;

         Ucd_Input.Next_Record (File);
      end loop;

      Ucd_Input.Close (File);
   end Load_DerivedCoreProperties;

   ------------------------------------
   -- Load_DerivedNormalizationProps --
   ------------------------------------

   procedure Load_DerivedNormalizationProps (Unidata_Directory : String) is

      type Property is
       (FC_NFKC,                        --  + mapping
        Full_Composition_Exclusion,
        NFD_QC,                         --  + value
        NFC_QC,                         --  + value
        NFKD_QC,                        --  + value
        NFKC_QC,                        --  + value
        Expands_On_NFD,
        Expands_On_NFC,
        Expands_On_NFKD,
        Expands_On_NFKC,
        NFKC_CF,                        --  + mapping
        Changes_When_NFKC_Casefolded);

      File  : Ucd_Input.File_Type;
      First : Code_Point;
      Last  : Code_Point;
      Prop  : Property;
      FC_NFKC_Ignored : Boolean := False;
      NFKC_CF_Ignored : Boolean := False;

   begin
      Ada.Text_IO.Put_Line
       (Ada.Text_IO.Standard_Error,
        "   ... " & DerivedNormalizationProps_Name);

      Ucd_Input.Open
       (File, Unidata_Directory & '/' & DerivedNormalizationProps_Name);

      while not Ucd_Input.End_Of_Data (File) loop
         First := Ucd_Input.First_Code_Point (File);
         Last  := Ucd_Input.Last_Code_Point (File);
         Prop  := Property'Value (Ucd_Input.Field (File));
         Ucd_Input.Next_Field (File);

         for J in First .. Last loop
            case Prop is
               when FC_NFKC =>
                  if not FC_NFKC_Ignored then
                     Ada.Text_IO.Put_Line
                      (Ada.Text_IO.Standard_Error,
                       "         Ignore property: FC_NFKC");
                     FC_NFKC_Ignored := True;
                  end if;

               when Full_Composition_Exclusion =>
                  Norms (J).B (Full_Composition_Exclusion) := True;

               when NFD_QC =>
                  Norms (J).NQC (NFD) := Value (Ucd_Input.Field (File));

               when NFC_QC =>
                  Norms (J).NQC (NFC) := Value (Ucd_Input.Field (File));

               when NFKD_QC =>
                  Norms (J).NQC (NFKD) := Value (Ucd_Input.Field (File));

               when NFKC_QC =>
                  Norms (J).NQC (NFKC) := Value (Ucd_Input.Field (File));

               when Expands_On_NFD =>
                  Norms (J).B (Expands_On_NFD) := True;

               when Expands_On_NFC =>
                  Norms (J).B (Expands_On_NFC) := True;

               when Expands_On_NFKD =>
                  Norms (J).B (Expands_On_NFKD) := True;

               when Expands_On_NFKC =>
                  Norms (J).B (Expands_On_NFKD) := True;

               when NFKC_CF =>
                  if not NFKC_CF_Ignored then
                     Ada.Text_IO.Put_Line
                      (Ada.Text_IO.Standard_Error,
                       "         Ignore property: NFKC_CF");
                     NFKC_CF_Ignored := True;
                  end if;

               when Changes_When_NFKC_Casefolded =>
                  Core (J).B (Changes_When_NFKC_Casefolded) := True;
            end case;
         end loop;

         Ucd_Input.Next_Record (File);
      end loop;

      Ucd_Input.Close (File);
   end Load_DerivedNormalizationProps;

   -------------------------
   -- Load_EastAsianWidth --
   -------------------------

   procedure Load_EastAsianWidth (Unidata_Directory : String) is
      File  : Ucd_Input.File_Type;
      First : Code_Point;
      Last  : Code_Point;
      Prop  : East_Asian_Width;

   begin
      Ada.Text_IO.Put_Line
       (Ada.Text_IO.Standard_Error, "   ... " & EastAsianWidth_Name);

      Ucd_Input.Open
       (File, Unidata_Directory & '/' & EastAsianWidth_Name);

      while not Ucd_Input.End_Of_Data (File) loop
         First := Ucd_Input.First_Code_Point (File);
         Last  := Ucd_Input.Last_Code_Point (File);
         Prop  := Value (Ucd_Input.Field (File));

         for J in First .. Last loop
            Core (J).EA := Prop;
         end loop;

         Ucd_Input.Next_Record (File);
      end loop;

      Ucd_Input.Close (File);
   end Load_EastAsianWidth;

   --------------------------------
   -- Load_GraphemeBreakProperty --
   --------------------------------

   procedure Load_GraphemeBreakProperty (Unidata_Directory : String) is
      File  : Ucd_Input.File_Type;
      First : Code_Point;
      Last  : Code_Point;
      Prop  : Grapheme_Cluster_Break;

   begin
      Ada.Text_IO.Put_Line
       (Ada.Text_IO.Standard_Error,
        "   ... " & GraphemeBreakProperty_Name);

      Ucd_Input.Open
       (File, Unidata_Directory & '/' & GraphemeBreakProperty_Name);

      while not Ucd_Input.End_Of_Data (File) loop
         First := Ucd_Input.First_Code_Point (File);
         Last  := Ucd_Input.Last_Code_Point (File);
         Prop  := Value (Ucd_Input.Field (File));

         for J in First .. Last loop
            Core (J).GCB := Prop;
         end loop;

         Ucd_Input.Next_Record (File);
      end loop;

      Ucd_Input.Close (File);
   end Load_GraphemeBreakProperty;

   --------------------
   -- Load_LineBreak --
   --------------------

   procedure Load_LineBreak (Unidata_Directory : String) is
      File  : Ucd_Input.File_Type;
      First : Code_Point;
      Last  : Code_Point;
      Prop  : Line_Break;

   begin
      Ada.Text_IO.Put_Line
       (Ada.Text_IO.Standard_Error, "   ... " & LineBreak_Name);

      Ucd_Input.Open (File, Unidata_Directory & '/' & LineBreak_Name);

      while not Ucd_Input.End_Of_Data (File) loop
         First := Ucd_Input.First_Code_Point (File);
         Last  := Ucd_Input.Last_Code_Point (File);
         Prop  := Value (Ucd_Input.Field (File));

         for J in First .. Last loop
            Core (J).LB := Prop;
         end loop;

         Ucd_Input.Next_Record (File);
      end loop;

      Ucd_Input.Close (File);
   end Load_LineBreak;

   -----------------------------------
   -- Load_NormalizationCorrections --
   -----------------------------------

   procedure Load_NormalizationCorrections (Unidata_Directory : String) is
      File      : Ucd_Input.File_Type;
      Code      : Code_Point;
      Original  : Code_Point_Sequence_Access;
      Corrected : Code_Point_Sequence_Access;

   begin
      Ada.Text_IO.Put_Line
       (Ada.Text_IO.Standard_Error, "   ... " & NormalizationCorrections_Name);

      Ucd_Input.Open
       (File, Unidata_Directory & '/' & NormalizationCorrections_Name);

      while not Ucd_Input.End_Of_Data (File) loop
         Code := Ucd_Input.First_Code_Point (File);

         Original :=
           new Code_Point_Sequence'
                (Parse_Code_Point_Sequence (Ucd_Input.Field (File)));
         Ucd_Input.Next_Field (File);

         Corrected :=
           new Code_Point_Sequence'
                (Parse_Code_Point_Sequence (Ucd_Input.Field (File)));

         if Norms (Code).Values (Canonical).all /= Original.all then
            if Norms (Code).Values (Canonical).all /= Corrected.all then
               raise Program_Error with "Wrong original decomposition";

            else
               Free (Corrected);
            end if;

         else
            Free (Norms (Code).Values (Canonical));
            Norms (Code).Values (Canonical) := Corrected;

            if Norms (Code).DT /= Canonical then
               Free (Norms (Code).Values (Compatibility));
               Norms (Code).Values (Compatibility) :=
                 new Code_Point_Sequence'(Corrected.all);
            end if;
         end if;

         Free (Original);

         Ucd_Input.Next_Record (File);
      end loop;

      Ucd_Input.Close (File);
   end Load_NormalizationCorrections;

   -------------------
   -- Load_PropList --
   -------------------

   procedure Load_PropList (Unidata_Directory : String) is
      File  : Ucd_Input.File_Type;
      First : Code_Point;
      Last  : Code_Point;
      Prop  : Primary_Core_Boolean_Properties;

   begin
      Ada.Text_IO.Put_Line
       (Ada.Text_IO.Standard_Error, "   ... " & PropList_Name);

      Ucd_Input.Open (File, Unidata_Directory & '/' & PropList_Name);

      while not Ucd_Input.End_Of_Data (File) loop
         First := Ucd_Input.First_Code_Point (File);
         Last  := Ucd_Input.Last_Code_Point (File);
         Prop  :=
           Primary_Core_Boolean_Properties'Value (Ucd_Input.Field (File));

         for J in First .. Last loop
            Core (J).B (Prop) := True;
         end loop;

         Ucd_Input.Next_Record (File);
      end loop;

      Ucd_Input.Close (File);
   end Load_PropList;

   --------------------------------
   -- Load_SentenceBreakProperty --
   --------------------------------

   procedure Load_SentenceBreakProperty (Unidata_Directory : String) is
      File  : Ucd_Input.File_Type;
      First : Code_Point;
      Last  : Code_Point;
      Prop  : Sentence_Break;

   begin
      Ada.Text_IO.Put_Line
       (Ada.Text_IO.Standard_Error, "   ... " & SentenceBreakProperty_Name);

      Ucd_Input.Open
       (File, Unidata_Directory & '/' & SentenceBreakProperty_Name);

      while not Ucd_Input.End_Of_Data (File) loop
         First := Ucd_Input.First_Code_Point (File);
         Last  := Ucd_Input.Last_Code_Point (File);
         Prop  := Value (Ucd_Input.Field (File));

         for J in First .. Last loop
            Core (J).SB := Prop;
         end loop;

         Ucd_Input.Next_Record (File);
      end loop;

      Ucd_Input.Close (File);
   end Load_SentenceBreakProperty;

   ------------------------
   -- Load_SpecialCasing --
   ------------------------

   procedure Load_SpecialCasing (Unidata_Directory : String) is
      File     : Ucd_Input.File_Type;
      Code     : Code_Point;
      Lower    : Code_Point_Sequence_Access;
      Upper    : Code_Point_Sequence_Access;
      Title    : Code_Point_Sequence_Access;

   begin
      Ada.Text_IO.Put_Line
       (Ada.Text_IO.Standard_Error, "   ... " & SpecialCasing_Name);

      Ucd_Input.Open
       (File, Unidata_Directory & '/' & SpecialCasing_Name);

      while not Ucd_Input.End_Of_Data (File) loop
         Code := Ucd_Input.First_Code_Point (File);

         --  Lowercase mapping

         Lower :=
           new Code_Point_Sequence'
                (Parse_Code_Point_Sequence (Ucd_Input.Field (File)));
         Ucd_Input.Next_Field (File);

         --  Uppercase mapping

         Upper :=
           new Code_Point_Sequence'
                (Parse_Code_Point_Sequence (Ucd_Input.Field (File)));
         Ucd_Input.Next_Field (File);

         --  Titlecase mapping

         Title :=
           new Code_Point_Sequence'
                (Parse_Code_Point_Sequence (Ucd_Input.Field (File)));
         Ucd_Input.Next_Field (File);

         --  Conditions

         declare
            V : constant String := Ucd_Input.Field (File);

         begin
            if V = "Final_Sigma" then
               if Upper'Length /= 1
                 or else Upper (1) /= Code
               then
                  Cases (Code).FUM.Positive (Final_Sigma) := Upper;
               end if;

               if Lower'Length /= 1
                 or else Lower (1) /= Code
               then
                  Cases (Code).FLM.Positive (Final_Sigma) := Lower;
               end if;

               if Title'Length /= 1
                 or else Title (1) /= Code
               then
                  Cases (Code).FTM.Positive (Final_Sigma) := Title;
               end if;

            elsif V'Length = 0 then
               Cases (Code).FUM.Default := Upper;
               Cases (Code).FLM.Default := Lower;
               Cases (Code).FTM.Default := Title;

            else
               --  XXX Ignore more complex contexts for now.

               Ada.Text_IO.Put_Line
                (Ada.Text_IO.Standard_Error,
                 "         Ignore mapping: " & Ucd_Input.Field (File));
            end if;
         end;

         Ucd_Input.Next_Record (File);
      end loop;

      Ucd_Input.Close (File);
   end Load_SpecialCasing;

   ----------------------
   -- Load_UnicodeData --
   ----------------------

   procedure Load_UnicodeData (Unidata_Directory : String) is
      type String_Access is access String;

      procedure Process
       (Code : Code_Point;
        GC   : General_Category;
        CCC  : Canonical_Combining_Class;
        DT   : Decomposition_Type;
        DM   : Code_Point_Sequence;
        SUM  : Optional_Code_Point;
        SLM  : Optional_Code_Point;
        STM  : Optional_Code_Point);
      --  Process data for one code point.

      procedure Free is new Ada.Unchecked_Deallocation (String, String_Access);

      -------------
      -- Process --
      -------------

      procedure Process
       (Code : Code_Point;
        GC   : General_Category;
        CCC  : Canonical_Combining_Class;
        DT   : Decomposition_Type;
        DM   : Code_Point_Sequence;
        SUM  : Optional_Code_Point;
        SLM  : Optional_Code_Point;
        STM  : Optional_Code_Point) is
      begin
         Core (Code).GC  := GC;
         Norms (Code).CCC := CCC;
         Norms (Code).DT  := DT;

         --  Canonical and compatibility normalization.

         if DT /= None then
            Norms (Code).Values (Compatibility) :=
              new Code_Point_Sequence'(DM);

            if DT = Canonical then
               Norms (Code).Values (Canonical_Mapping)
                 := new Code_Point_Sequence'(DM);
               Norms (Code).Values (Canonical) := new Code_Point_Sequence'(DM);
            end if;
         end if;

         --  Simple uppercase mapping

         if SUM.Present and then SUM.C /= Code then
            Cases (Code).SUM := SUM;

         else
            Cases (Code).SUM := (Present => False);
         end if;

         --  Simple lowercase mapping

         if SLM.Present and then SLM.C /= Code then
            Cases (Code).SLM := SLM;

         else
            Cases (Code).SLM := (Present => False);
         end if;

         --  Simple titlecase mapping

         if STM.Present and then STM.C /= Code then
            Cases (Code).STM := STM;

         else
            Cases (Code).STM := (Present => False);
         end if;
      end Process;

      File       : Ucd_Input.File_Type;
      Code       : Code_Point;
      First_Code : Code_Point;
      Name       : String_Access;
      GC         : General_Category;
      CCC        : Canonical_Combining_Class;
      SUM        : Optional_Code_Point;
      SLM        : Optional_Code_Point;
      STM        : Optional_Code_Point;
      DT         : Decomposition_Type;
      DM         : Code_Point_Sequence_Access;

   begin
      Ada.Text_IO.Put_Line
       (Ada.Text_IO.Standard_Error, "   ... " & UnicodeData_Name);

      Ucd_Input.Open (File, Unidata_Directory & '/' & UnicodeData_Name);

      while not Ucd_Input.End_Of_Data (File) loop

         --  Parse code point

         Code := Ucd_Input.First_Code_Point (File);
         --  UnicodeData.txt uses only one code point for each record.

         --  Parse Name (1)

         Name := new String'(Ucd_Input.Field (File));
         Ucd_Input.Next_Field (File);

         --  Parse General_Category (2)

         GC := Value (Ucd_Input.Field (File));
         Ucd_Input.Next_Field (File);

         --  Parse Canonical_Combining_Class (3)

         CCC := Canonical_Combining_Class'Value (Ucd_Input.Field (File));
         Ucd_Input.Next_Field (File);

         --  Parse Bidi_Class (4)
         --  XXX Not implemented

         Ucd_Input.Next_Field (File);

         --  Parse Decomposition_Type and Decomposition_Mapping (5)

         declare
            Field : constant String := Ucd_Input.Field (File);
            First : Positive := Field'First;
            Last  : Natural  := 0;

         begin
            if Field'Length /= 0 then
               if Field (First) = '<' then
                  Last := First + 1;

                  while Field (Last) /= '>' loop
                     Last := Last + 1;
                  end loop;

                  DT := Value (Field (First + 1 .. Last - 1));
                  First := Last + 2;

               else
                  DT   := Canonical;
               end if;

               DM :=
                 new Code_Point_Sequence'
                      (Parse_Code_Point_Sequence
                        (Field (First .. Field'Last)));

            else
               DT := None;
               DM := new Code_Point_Sequence (1 .. 0);
            end if;
         end;

         Ucd_Input.Next_Field (File);

         --  Parse Numeric_Type and Numeric_Value (6), (7), (8)
         --  XXX Not implemented

         Ucd_Input.Next_Field (File);
         Ucd_Input.Next_Field (File);
         Ucd_Input.Next_Field (File);

         --  Parse Bidi_Mirrored (9)
         --  XXX Not implemented

         Ucd_Input.Next_Field (File);

         --  Parse Unicode_1_Name (10)
         --  XXX Not implemented

         Ucd_Input.Next_Field (File);

         --  Parse ISO_Comment (11)
         --  XXX Not implemented

         Ucd_Input.Next_Field (File);

         --  Parse Simple_Uppercase_Mapping (12)

         declare
            F : constant String := Ucd_Input.Field (File);

         begin
            if F'Length = 0 then
               SUM := (Present => False);

            else
               SUM := (True, 0);
               Parse_Code_Point (F, SUM.C);
            end if;
         end;

         Ucd_Input.Next_Field (File);

         --  Parse Simple_Lowercase_Mapping (13)

         declare
            F : constant String := Ucd_Input.Field (File);

         begin
            if F'Length = 0 then
               SLM := (Present => False);

            else
               SLM := (True, 0);
               Parse_Code_Point (F, SLM.C);
            end if;
         end;

         Ucd_Input.Next_Field (File);

         --  Parse Simple_Titlecase_Mapping (14)

         declare
            F : constant String := Ucd_Input.Field (File);

         begin
            if F'Length = 0 then
               STM := (Present => False);

            else
               STM := (True, 0);
               Parse_Code_Point (F, STM.C);
            end if;
         end;

	 --  Special exception: if Name end on ", First>" it means a start of
         --  range. Next line end of ", Last>" and means end of range.

         if Name'Length > 7
           and then Name (Name'Last - 7 .. Name'Last) = ", First>"
         then
            First_Code := Code;

         elsif Name'Length > 6
           and then Name (Name'Last - 6 .. Name'Last) = ", Last>"
         then
            if Name.all = "<Hangul Syllable, Last>" then
               --  Hangul Syllables are decomposed algorithmically and there
               --  are no Decomposition Type is defined in UnicodeData.txt
               --  for them. We set Decomposition_Type to Canonical by hand.

               DT := Canonical;
            end if;

            for J in First_Code .. Code loop
               Process (J, GC, CCC, DT, DM.all, SUM, SLM, STM);
            end loop;

         else
            Process (Code, GC, CCC, DT, DM.all, SUM, SLM, STM);
         end if;

         --  Cleanup.

         Free (Name);
         Free (DM);

         Ucd_Input.Next_Record (File);
      end loop;

      Ucd_Input.Close (File);
   end Load_UnicodeData;

   ----------------------------
   -- Load_WordBreakProperty --
   ----------------------------

   procedure Load_WordBreakProperty (Unidata_Directory : String) is
      File  : Ucd_Input.File_Type;
      First : Code_Point;
      Last  : Code_Point;
      Prop  : Word_Break;

   begin
      Ada.Text_IO.Put_Line
       (Ada.Text_IO.Standard_Error, "   ... " & WordBreakProperty_Name);

      Ucd_Input.Open (File, Unidata_Directory & '/' & WordBreakProperty_Name);

      while not Ucd_Input.End_Of_Data (File) loop
         First := Ucd_Input.First_Code_Point (File);
         Last  := Ucd_Input.Last_Code_Point (File);
         Prop  := Value (Ucd_Input.Field (File));

         for J in First .. Last loop
            Core (J).WB := Prop;
         end loop;

         Ucd_Input.Next_Record (File);
      end loop;

      Ucd_Input.Close (File);
   end Load_WordBreakProperty;

   ----------------------
   -- Parse_Code_Point --
   ----------------------

   procedure Parse_Code_Point
    (Text : String;
     Code : out Code_Point)
   is
      First : Positive := Text'First;
      Last  : Natural;

   begin
      Last := First - 1;

      while Last < Text'Last loop
         Last := Last + 1;

         if Text (Last) not in '0' .. '9'
           and then Text (Last) not in 'A' .. 'F'
         then
            Last := Last - 1;

            exit;
         end if;
      end loop;

      Code := Code_Point'Value ("16#" & Text (First .. Last) & "#");
   end Parse_Code_Point;

   -----------
   -- Value --
   -----------

   function Value (Item : String) return Decomposition_Type is

      type Constant_String_Access is access constant String;

      Compat_Image   : aliased constant String := "compat";
      Circle_Image   : aliased constant String := "circle";
      Final_Image    : aliased constant String := "final";
      Font_Image     : aliased constant String := "font";
      Fraction_Image : aliased constant String := "fraction";
      Initial_Image  : aliased constant String := "initial";
      Isolated_Image : aliased constant String := "isolated";
      Medial_Image   : aliased constant String := "medial";
      Narrow_Image   : aliased constant String := "narrow";
      Nobreak_Image  : aliased constant String := "noBreak";
      Small_Image    : aliased constant String := "small";
      Square_Image   : aliased constant String := "square";
      Sub_Image      : aliased constant String := "sub";
      Super_Image    : aliased constant String := "super";
      Vertical_Image : aliased constant String := "vertical";
      Wide_Image     : aliased constant String := "wide";

      Mapping : constant
        array (Decomposition_Type range Font .. Compat)
          of Constant_String_Access
            := (Compat   => Compat_Image'Access,
                Circle   => Circle_Image'Access,
                Final    => Final_Image'Access,
                Font     => font_Image'Access,
                Fraction => Fraction_Image'Access,
                Initial  => Initial_Image'Access,
                Isolated => Isolated_Image'Access,
                Medial   => Medial_Image'Access,
                Narrow   => Narrow_Image'Access,
                No_Break => Nobreak_Image'Access,
                Small    => Small_Image'Access,
                Square   => Square_Image'Access,
                Sub      => sub_Image'Access,
                Super    => Super_Image'Access,
                Vertical => Vertical_Image'Access,
                Wide     => wide_Image'Access);

   begin
      if Item'Length = 0 then
         return Canonical;
      end if;

      for J in Mapping'Range loop
         if Mapping (J).all = Item then
            return J;
         end if;
      end loop;

      raise Constraint_Error with "Invalid image of Decomposition_Type";
   end Value;

   -----------
   -- Value --
   -----------

   function Value (Item : String) return East_Asian_Width is

      type Constant_String_Access is access constant String;

      A_Image  : aliased constant String := "A";
      F_Image  : aliased constant String := "F";
      H_Image  : aliased constant String := "H";
      N_Image  : aliased constant String := "N";
      Na_Image : aliased constant String := "Na";
      W_Image  : aliased constant String := "W";

      Mapping : constant array (East_Asian_Width) of Constant_String_Access
        := (Ambiguous => A_Image'Access,
            Fullwidth => F_Image'Access,
            Halfwidth => H_Image'Access,
            Neutral   => N_Image'Access,
            Narrow    => Na_Image'Access,
            Wide      => W_Image'Access);

   begin
      for J in Mapping'Range loop
         if Mapping (J).all = Item then
            return J;
         end if;
      end loop;

      raise Constraint_Error with "Invalid image of General_Category";
   end Value;

   -----------
   -- Value --
   -----------

   function Value (Item : String) return General_Category is
      Mapping : constant array (General_Category) of String (1 .. 2)
        := (Control               => "Cc",
            Format                => "Cf",
            Unassigned            => "Cn",
            Private_Use           => "Co",
            Surrogate             => "Cs",
            Lowercase_Letter      => "Ll",
            Modifier_Letter       => "Lm",
            Other_Letter          => "Lo",
            Titlecase_Letter      => "Lt",
            Uppercase_Letter      => "Lu",
            Spacing_Mark          => "Mc",
            Enclosing_Mark        => "Me",
            Nonspacing_Mark       => "Mn",
            Decimal_Number        => "Nd",
            Letter_Number         => "Nl",
            Other_Number          => "No",
            Connector_Punctuation => "Pc",
            Dash_Punctuation      => "Pd",
            Close_Punctuation     => "Pe",
            Final_Punctuation     => "Pf",
            Initial_Punctuation   => "Pi",
            Other_Punctuation     => "Po",
            Open_Punctuation      => "Ps",
            Currency_Symbol       => "Sc",
            Modifier_Symbol       => "Sk",
            Math_Symbol           => "Sm",
            Other_Symbol          => "So",
            Line_Separator        => "Zl",
            Paragraph_Separator   => "Zp",
            Space_Separator       => "Zs");

   begin
      for J in Mapping'Range loop
         if Mapping (J) = Item then
            return J;
         end if;
      end loop;

      raise Constraint_Error with "Invalid image of General_Category";
   end Value;

   -----------
   -- Value --
   -----------

   function Value (Item : String) return Grapheme_Cluster_Break is

      type Constant_String_Access is access constant String;

      GCB_Control_Image     : aliased constant String := "Control";
      GCB_CR_Image          : aliased constant String := "CR";
      GCB_Extend_Image      : aliased constant String := "Extend";
      GCB_L_Image           : aliased constant String := "L";
      GCB_LF_Image          : aliased constant String := "LF";
      GCB_LV_Image          : aliased constant String := "LV";
      GCB_LVT_Image         : aliased constant String := "LVT";
      GCB_Prepend_Image     : aliased constant String := "Prepend";
      GCB_SpacingMark_Image : aliased constant String := "SpacingMark";
      GCB_T_Image           : aliased constant String := "T";
      GCB_V_Image           : aliased constant String := "V";
      GCB_Other_Image       : aliased constant String := "Other";
      GCB_Regional_Indicator_Image :
        aliased constant String := "Regional_Indicator";

      Mapping : constant
        array (Grapheme_Cluster_Break) of Constant_String_Access
          := (Control            => GCB_Control_Image'Access,
              CR                 => GCB_CR_Image'Access,
              Extend             => GCB_Extend_Image'Access,
              L                  => GCB_L_Image'Access,
              LF                 => GCB_LF_Image'Access,
              LV                 => GCB_LV_Image'Access,
              LVT                => GCB_LVT_Image'Access,
              Prepend            => GCB_Prepend_Image'Access,
              Spacing_Mark       => GCB_SpacingMark_Image'Access,
              T                  => GCB_T_Image'Access,
              V                  => GCB_V_Image'Access,
              Other              => GCB_Other_Image'Access,
              Regional_Indicator => GCB_Regional_Indicator_Image'Access);

   begin
      for J in Mapping'Range loop
         if Item = Mapping (J).all then
            return J;
         end if;
      end loop;

      raise Constraint_Error with "Invalid image of Grapheme_Cluster_Break";
   end Value;

   -----------
   -- Value --
   -----------

   function Value (Item : String) return Line_Break is
      Mapping : constant array (Line_Break) of String (1 .. 2)
        := (Ambiguous                    => "AI",
            Alphabetic                   => "AL",
            Break_Both                   => "B2",
            Break_After                  => "BA",
            Break_Before                 => "BB",
            Mandatory_Break              => "BK",
            Contingent_Break             => "CB",
            Conditional_Japanese_Starter => "CJ",
            Close_Punctuation            => "CL",
            Combining_Mark               => "CM",
            Close_Parenthesis            => "CP",
            Carriage_Return              => "CR",
            Exclamation                  => "EX",
            Glue                         => "GL",
            H2                           => "H2",
            H3                           => "H3",
            Hebrew_Letter                => "HL",
            Hyphen                       => "HY",
            Ideographic                  => "ID",
            Inseparable                  => "IN",
            Infix_Numeric                => "IS",
            JL                           => "JL",
            JT                           => "JT",
            JV                           => "JV",
            Line_Feed                    => "LF",
            Next_Line                    => "NL",
            Nonstarter                   => "NS",
            Numeric                      => "NU",
            Open_Punctuation             => "OP",
            Postfix_Numeric              => "PO",
            Prefix_Numeric               => "PR",
            Quotation                    => "QU",
            Complex_Context              => "SA",
            Surrogate                    => "SG",
            Space                        => "SP",
            Break_Symbols                => "SY",
            Word_Joiner                  => "WJ",
            Unknown                      => "XX",
            ZW_Space                     => "ZW",
            Regional_Indicator           => "RI");

   begin
      for J in Mapping'Range loop
         if Mapping (J) = Item then
            return J;
         end if;
      end loop;

      raise Constraint_Error with "Invalid image of Line_Break";
   end Value;

   -----------
   -- Value --
   -----------

   function Value (Item : String) return Normalization_Quick_Check is
      Mapping : constant array (Normalization_Quick_Check) of String (1 .. 1)
        := (No    => "N",
            Maybe => "M",
            Yes   => "Y");

   begin
      for J in Mapping'Range loop
         if Mapping (J) = Item then
            return J;
         end if;
      end loop;

      raise Constraint_Error with "Invalid image of Normalization_Quick_Check";
   end Value;

   -----------
   -- Value --
   -----------

   function Value (Item : String) return Sentence_Break is

      type Constant_String_Access is access constant String;

      SB_ATerm_Image     : aliased constant String := "ATerm";
      SB_Close_Image     : aliased constant String := "Close";
      SB_CR_Image        : aliased constant String := "CR";
      SB_Extend_Image    : aliased constant String := "Extend";
      SB_Format_Image    : aliased constant String := "Format";
      SB_OLetter_Image   : aliased constant String := "OLetter";
      SB_LF_Image        : aliased constant String := "LF";
      SB_Lower_Image     : aliased constant String := "Lower";
      SB_Numeric_Image   : aliased constant String := "Numeric";
      SB_SContinue_Image : aliased constant String := "SContinue";
      SB_Sep_Image       : aliased constant String := "Sep";
      SB_Sp_Image        : aliased constant String := "Sp";
      SB_STerm_Image     : aliased constant String := "STerm";
      SB_Upper_Image     : aliased constant String := "Upper";
      SB_Other_Image     : aliased constant String := "Other";

      Mapping : constant array (Sentence_Break) of Constant_String_Access :=
       (A_Term     => SB_ATerm_Image'Access,
        Close      => SB_Close_Image'Access,
        CR         => SB_CR_Image'Access,
        Extend     => SB_Extend_Image'Access,
        Format     => SB_Format_Image'Access,
        O_Letter   => SB_OLetter_Image'Access,
        LF         => SB_LF_Image'Access,
        Lower      => SB_Lower_Image'Access,
        Numeric    => SB_Numeric_Image'Access,
        S_Continue => SB_SContinue_Image'Access,
        Sep        => SB_Sep_Image'Access,
        Sp         => SB_Sp_Image'Access,
        S_Term     => SB_STerm_Image'Access,
        Upper      => SB_Upper_Image'Access,
        Other      => SB_Other_Image'Access);

   begin
      for J in Mapping'Range loop
         if Item = Mapping (J).all then
            return J;
         end if;
      end loop;

      raise Constraint_Error with "Invalid image of Sentence_Break";
   end Value;

   -----------
   -- Value --
   -----------

   function Value (Item : String) return Word_Break is

      type Constant_String_Access is access constant String;

      WB_CR_Image            : aliased constant String := "CR";
      WB_ExtendNumLet_Image  : aliased constant String := "ExtendNumLet";
      WB_Extend_Image        : aliased constant String := "Extend";
      WB_Format_Image        : aliased constant String := "Format";
      WB_Katakana_Image      : aliased constant String := "Katakana";
      WB_ALetter_Image       : aliased constant String := "ALetter";
      WB_LF_Image            : aliased constant String := "LF";
      WB_MidNumLet_Image     : aliased constant String := "MidNumLet";
      WB_MidLetter_Image     : aliased constant String := "MidLetter";
      WB_MidNum_Image        : aliased constant String := "MidNum";
      WB_Newline_Image       : aliased constant String := "Newline";
      WB_Numeric_Image       : aliased constant String := "Numeric";
      WB_Other_Image         : aliased constant String := "Other";
      WB_Regional_Indicator_Image :
        aliased constant String := "Regional_Indicator";
      WB_Hebrew_Letter_Image : aliased constant String := "Hebrew_Letter";
      WB_Single_Quote_Image  : aliased constant String := "Single_Quote";
      WB_Double_Quote_Image  : aliased constant String := "Double_Quote";

      Mapping : constant array (Word_Break) of Constant_String_Access :=
       (CR                 => WB_CR_Image'Access,
        Extend_Num_Let     => WB_ExtendNumLet_Image'Access,
        Extend             => WB_Extend_Image'Access,
        Format             => WB_Format_Image'Access,
        Katakana           => WB_Katakana_Image'Access,
        A_Letter           => WB_ALetter_Image'Access,
        LF                 => WB_LF_Image'Access,
        Mid_Num_Let        => WB_MidNumLet_Image'Access,
        Mid_Letter         => WB_MidLetter_Image'Access,
        Mid_Num            => WB_MidNum_Image'Access,
        Newline            => WB_Newline_Image'Access,
        Numeric            => WB_Numeric_Image'Access,
        Other              => WB_Other_Image'Access,
        Regional_Indicator => WB_Regional_Indicator_Image'Access,
        Hebrew_Letter      => WB_Hebrew_Letter_Image'Access,
        Single_Quote       => WB_Single_Quote_Image'Access,
        Double_Quote       => WB_Double_Quote_Image'Access);

   begin
      for J in Mapping'Range loop
         if Item = Mapping (J).all then
            return J;
         end if;
      end loop;

      raise Constraint_Error with "Invalid image of Word_Break";
   end Value;

end Ucd_Data;
