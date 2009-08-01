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
-- Copyright © 2009 Vadim Godunko <vgodunko@gmail.com>                      --
--                                                                          --
-- Matreshka is free software;  you can  redistribute it  and/or modify  it --
-- under terms of the  GNU General Public License as published  by the Free --
-- Software  Foundation;  either version 2,  or (at your option)  any later --
-- version.  Matreshka  is distributed in the hope that it will be  useful, --
-- but   WITHOUT  ANY  WARRANTY;  without  even  the  implied  warranty  of --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General --
-- Public License for more details.  You should have received a copy of the --
-- GNU General Public License distributed with Matreshka; see file COPYING. --
-- If not, write  to  the  Free Software Foundation,  51  Franklin  Street, --
-- Fifth Floor, Boston, MA 02110-1301, USA.                                 --
--                                                                          --
-- As a special exception,  if other files  instantiate  generics from this --
-- unit, or you link  this unit with other files  to produce an executable, --
-- this  unit  does not  by itself cause  the resulting  executable  to  be --
-- covered  by the  GNU  General  Public  License.  This exception does not --
-- however invalidate  any other reasons why  the executable file  might be --
-- covered by the  GNU Public License.                                      --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------
with Matreshka.Internals.Unicode;

package Matreshka.Internals.Ucd is

   pragma Preelaborate;

   type First_Stage_Index is mod 16#1100#;
   type Second_Stage_Index is mod 16#100#;

   type Sequence_Count is range 0 .. 2 ** 16 - 1;
   for Sequence_Count'Size use 16;

   subtype Sequence_Index is Sequence_Count range 1 .. Sequence_Count'Last;

   type Code_Point_Sequence is
     array (Sequence_Index range <>) of Matreshka.Internals.Unicode.Code_Point;

   type Code_Point_Sequence_Access is access constant Code_Point_Sequence;

   ---------------------
   -- Core properties --
   ---------------------

   type General_Category is
    (Control,
     Format,
     Unassigned,
     Private_Use,
     Surrogate,

     Lowercase_Letter,
     Titlecase_Letter,
     Uppercase_Letter,
     Modifier_Letter,
     Other_Letter,

     Spacing_Mark,
     Enclosing_Mark,
     Nonspacing_Mark,

     Decimal_Number,
     Letter_Number,
     Other_Number,

     Connector_Punctuation,
     Dash_Punctuation,
     Close_Punctuation,
     Final_Punctuation,
     Initial_Punctuation,
     Other_Punctuation,
     Open_Punctuation,

     Currency_Symbol,
     Modifier_Symbol,
     Math_Symbol,
     Other_Symbol,

     Line_Separator,
     Paragraph_Separator,
     Space_Separator);
   for General_Category'Size use 8;

--   subtype Other is General_Category range Control .. Surrogate;
--   subtype Letter is General_Category range Lowercase_Letter .. Other_Letter;
--   subtype Cased_Letter is Letter range Lowercase_Letter .. Uppercase_Letter;
--   subtype Mark is General_Category range Spacing_Mark .. Nonspacing_Mark;
--   subtype Number is General_Category range Decimal_Number .. Other_Number;
--   subtype Punctuation is General_Category
--     range Connector_Punctuation .. Open_Punctuation;
--   subtype Symbol is General_Category range Currency_Symbol .. Other_Symbol;
--   subtype Separator is General_Category
--     range Line_Separator .. Space_Separator;

   type Canonical_Combining_Class is mod 256;

   Not_Reordered        : constant Canonical_Combining_Class := 0;
   Overlay              : constant Canonical_Combining_Class := 1;
   Nukta                : constant Canonical_Combining_Class := 7;
   Kana_Voicing         : constant Canonical_Combining_Class := 8;
   Virama               : constant Canonical_Combining_Class := 9;
   Attached_Below_Left  : constant Canonical_Combining_Class := 200;
   Attached_Below       : constant Canonical_Combining_Class := 202;
   Attached_Above_Right : constant Canonical_Combining_Class := 216;
   Below_Left           : constant Canonical_Combining_Class := 218;
   Below                : constant Canonical_Combining_Class := 220;
   Below_Right          : constant Canonical_Combining_Class := 222;
   Left                 : constant Canonical_Combining_Class := 224;
   Right                : constant Canonical_Combining_Class := 226;
   Above_Left           : constant Canonical_Combining_Class := 228;
   Above                : constant Canonical_Combining_Class := 230;
   Above_Right          : constant Canonical_Combining_Class := 232;
   Double_Below         : constant Canonical_Combining_Class := 233;
   Double_Above         : constant Canonical_Combining_Class := 234;
   Iota_Subscript       : constant Canonical_Combining_Class := 240;

   type Boolean_Properties is
    (ASCII_Hex_Digit,
     Bidi_Control,
     Dash,
     Deprecated,
     Diacritic,
     Extender,
     Hex_Digit,
     Hyphen,
     Ideographic,
     IDS_Binary_Operator,
     IDS_Trinary_Operator,
     Join_Control,
     Logical_Order_Exception,
     Noncharacter_Code_Point,
     Other_Alphabetic,
     Other_Default_Ignorable_Code_Point,
     Other_Grapheme_Extend,
     Other_ID_Continue,
     Other_ID_Start,
     Other_Lowercase,
     Other_Math,
     Other_Uppercase,
     Pattern_Syntax,
     Pattern_White_Space,
     Quotation_Mark,
     Radical,
     Soft_Dotted,
     STerm,
     Terminal_Punctuation,
     Unified_Ideograph,
     Variation_Selector,
     White_Space,

--     Bidi_Mirrored,                 --  XXX

     --  Derived core properties. This list must include only properties
     --  from DerivedCoreProperties.txt file.

     Alphabetic,                    --  Derived
     Default_Ignorable_Code_Point,  --  Derived
     Grapheme_Base,                 --  Derived
     Grapheme_Extend,               --  Derived
     Grapheme_Link,                 --  Deprecated, derived
     ID_Continue,                   --  Derived
     ID_Start,                      --  Derived
     Lowercase,                     --  Derived
     Math,                          --  Derived
     Uppercase,                     --  Derived
     XID_Continue,                  --  Derived
     XID_Start,                     --  Derived

     --  Composition exclusion property.

     Composition_Exclusion,         --  XXX

     --  Derived normalization properties.

     Full_Composition_Exclusion,    --  Derived
     Expands_On_NFC,                --  Derived
     Expands_On_NFD,                --  Derived
     Expands_On_NFKC,               --  Derived
     Expands_On_NFKD,               --  Derived

     --  Following are used by case conversion subprograms.

     Cased,
     Case_Ignorable,

     Has_Lowercase_Mapping,
     Has_Uppercase_Mapping,
     Has_Titlecase_Mapping,
     Has_Case_Folding);

   type Boolean_Values is array (Boolean_Properties) of Boolean;
   for Boolean_Values'Component_Size use 1;
   for Boolean_Values'Size use 64;  --  52 bits used for now

   type Grapheme_Cluster_Break is
    (Other,
     CR,
     LF,
     Control,
     Prepend,
     Extend,
     Spacing_Mark,
     L,
     V,
     T,
     LV,
     LVT);
   for Grapheme_Cluster_Break'Size use 8;

   type Word_Break is
    (Other,
     CR,
     LF,
     Newline,
     Katakana,
     A_Letter,
     Mid_Letter,
     Mid_Num,
     Mid_Num_Let,
     Numeric,
     Extend_Num_Let,
     Format,
     Extend);
   for Word_Break'Size use 8;

   type Sentence_Break is
    (Other,
     CR,
     LF,
     Sep,
     Sp,
     Lower,
     Upper,
     O_Letter,
     Numeric,
     A_Term,
     S_Term,
     Close,
     S_Continue,
     Format,
     Extend);
   for Sentence_Break'Size use 8;

   type Line_Break is
    (Ambiguous,
     Alphabetic,
     Break_Both,
     Break_After,
     Break_Before,
     Mandatory_Break,
     Contingent_Break,
     Close_Punctuation,
     Combining_Mark,
     Carriage_Return,
     Exclamation,
     Glue,
     H2,
     H3,
     Hyphen,
     Ideographic,
     Inseparable,
     Infix_Numeric,
     JL,
     JT,
     JV,
     Line_Feed,
     Next_Line,
     Nonstarter,
     Numeric,
     Open_Punctuation,
     Postfix_Numeric,
     Prefix_Numeric,
     Quotation,
     Complex_Context,
     Surrogate,
     Space,
     Break_Symbols,
     Word_Joiner,
     Unknown,
     ZW_Space);
   for Line_Break'Size use 8;

   type Decomposition_Type is
    (None,
     Canonical,
     Font,
     No_Break,
     Initial,
     Medial,
     Final,
     Isolated,
     Circle,
     Super,
     Sub,
     Vertical,
     Wide,
     Narrow,
     Small,
     Square,
     Fraction,
     Compat);

   for Decomposition_Type'Size use 8;

   type Normalization_Quick_Check is (No, Maybe, Yes);
   for Normalization_Quick_Check'Size use 2;

   type Core_Values is record
      GC      : General_Category;           --   8  (5) bits
      CCC     : Canonical_Combining_Class;  --   8      bits
      GCB     : Grapheme_Cluster_Break;     --   8  (4) bits
      WB      : Word_Break;                 --   8  (4) bits
      SB      : Sentence_Break;             --   8  (4) bits
      LB      : Line_Break;                 --   8  (6) bits
      NFC_QC  : Normalization_Quick_Check;  --   2      bits
      NFD_QC  : Normalization_Quick_Check;  --   2  (1) bits
      NFKC_QC : Normalization_Quick_Check;  --   2      bits
      NFKD_QC : Normalization_Quick_Check;  --   2  (1) bits
      DT      : Decomposition_Type;         --   8  (5) bits
      B       : Boolean_Values;             --  64 (52) bits
   end record;
   for Core_Values'Size use 128;
   for Core_Values use record
      B       at 0 range   0 ..  63;
      GC      at 0 range  64 ..  71;
      CCC     at 0 range  72 ..  79;
      GCB     at 0 range  80 ..  87;
      WB      at 0 range  88 ..  95;
      SB      at 0 range  96 .. 103;
      LB      at 0 range 104 .. 111;
      NFC_QC  at 0 range 112 .. 113;
      NFD_QC  at 0 range 114 .. 115;
      NFKC_QC at 0 range 116 .. 117;
      NFKD_QC at 0 range 118 .. 119;
      DT      at 0 range 120 .. 127;
   end record;

   type Core_Second_Stage is array (Second_Stage_Index) of Core_Values;

   type Core_Second_Stage_Access is access constant Core_Second_Stage;

   type Core_First_Stage is
     array (First_Stage_Index) of Core_Second_Stage_Access;

   type Core_First_Stage_Access is access constant Core_First_Stage;

   ------------
   -- Casing --
   ------------

   type Casing_Context is
    (Final_Sigma,
     After_Soft_Dotted,
     More_Above,
     Before_Dot,
     After_I);

   type Case_Mapping_Range is record
      First : Sequence_Count;
      Last  : Sequence_Count;
   end record;

   type Case_Mapping_Kinds is (Lower, Upper, Title, Folding);

   type Case_Mapping_Ranges is
     array (Case_Mapping_Kinds) of Case_Mapping_Range;

   type Casing_Context_Mapping_Ranges is
     array (Case_Mapping_Kinds range Lower .. Title) of Case_Mapping_Range;

   type Case_Mapping is record
      Ranges        : Case_Mapping_Ranges;
      Context_First : Sequence_Count;
      Context_Last  : Sequence_Count;
   end record;

   type Casing_Context_Mapping is record
      Context  : Casing_Context;
      Negative : Boolean;
      Ranges   : Casing_Context_Mapping_Ranges;
   end record;

   type Case_Mapping_Second_Stage is
     array (Second_Stage_Index) of Case_Mapping;

   type Case_Mapping_Second_Stage_Access is
     access constant Case_Mapping_Second_Stage;

   type Case_Mapping_First_Stage is
     array (First_Stage_Index) of Case_Mapping_Second_Stage_Access;

   type Case_Mapping_First_Stage_Access is
     access constant Case_Mapping_First_Stage;

   type Casing_Context_Mapping_Sequence is
     array (Sequence_Index range <>) of Casing_Context_Mapping;

   type Casing_Context_Mapping_Sequence_Access is
     access constant Casing_Context_Mapping_Sequence;

   -------------------
   -- Normalization --
   -------------------

   type Normalization_Mapping_Range is record
      First : Sequence_Count;
      Last  : Sequence_Count;
   end record;

   type Normalization_Kinds is (Canonical, Compatibility);

   type Normalization_Mapping_Ranges is
     array (Normalization_Kinds) of Normalization_Mapping_Range;

end Matreshka.Internals.Ucd;
