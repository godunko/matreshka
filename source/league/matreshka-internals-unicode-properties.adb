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
-- Copyright © 2010-2015, Vadim Godunko <vgodunko@gmail.com>                --
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
with Matreshka.Internals.Unicode.Ucd.Cases;
with Matreshka.Internals.Unicode.Ucd.Core;

package body Matreshka.Internals.Unicode.Properties is

   function Element is
     new Matreshka.Internals.Unicode.Ucd.Generic_Element
          (Matreshka.Internals.Unicode.Ucd.Core_Values,
           Matreshka.Internals.Unicode.Ucd.Core_Second_Stage,
           Matreshka.Internals.Unicode.Ucd.Core_Second_Stage_Access,
           Matreshka.Internals.Unicode.Ucd.Core_First_Stage);

   function Element is
     new Matreshka.Internals.Unicode.Ucd.Generic_Element
          (Matreshka.Internals.Unicode.Ucd.Case_Mapping,
           Matreshka.Internals.Unicode.Ucd.Case_Mapping_Second_Stage,
           Matreshka.Internals.Unicode.Ucd.Case_Mapping_Second_Stage_Access,
           Matreshka.Internals.Unicode.Ucd.Case_Mapping_First_Stage);

   pragma Inline (Element);

   ----------------------
   -- East_Asian_Width --
   ----------------------

   function East_Asian_Width
    (Code : Code_Point) return League.Characters.East_Asian_Width_Values
   is
      use all type League.Characters.East_Asian_Width_Values;
      use all type Matreshka.Internals.Unicode.Ucd.East_Asian_Width;

      To : constant array (Matreshka.Internals.Unicode.Ucd.East_Asian_Width)
             of League.Characters.East_Asian_Width_Values
        := (Ambiguous => Ambiguous,
            Fullwidth => Fullwidth,
            Halfwidth => Halfwidth,
            Neutral   => Neutral,
            Narrow    => Narrow,
            Wide      => Wide);

   begin
      return
        To (Element (Matreshka.Internals.Unicode.Ucd.Core.Property, Code).EA);
   end East_Asian_Width;

   ----------------------
   -- General_Category --
   ----------------------

   function General_Category
    (Code : Code_Point)
       return League.Characters.General_Category_Values
   is
      use all type League.Characters.General_Category_Values;
      use all type Matreshka.Internals.Unicode.UCD.General_Category;

      To : constant array (Matreshka.Internals.Unicode.UCD.General_Category)
             of League.Characters.General_Category_Values
        := (Uppercase_Letter      => Uppercase_Letter,
            Lowercase_Letter      => Lowercase_Letter,
            Titlecase_Letter      => Titlecase_Letter,
            Modifier_Letter       => Modifier_Letter,
            Other_Letter          => Other_Letter,
            Nonspacing_Mark       => Nonspacing_Mark,
            Spacing_Mark          => Spacing_Mark,
            Enclosing_Mark        => Enclosing_Mark,
            Decimal_Number        => Decimal_Number,
            Letter_Number         => Letter_Number,
            Other_Number          => Other_Number,
            Connector_Punctuation => Connector_Punctuation,
            Dash_Punctuation      => Dash_Punctuation,
            Open_Punctuation      => Open_Punctuation,
            Close_Punctuation     => Close_Punctuation,
            Initial_Punctuation   => Initial_Punctuation,
            Final_Punctuation     => Final_Punctuation,
            Other_Punctuation     => Other_Punctuation,
            Math_Symbol           => Math_Symbol,
            Currency_Symbol       => Currency_Symbol,
            Modifier_Symbol       => Modifier_Symbol,
            Other_Symbol          => Other_Symbol,
            Space_Separator       => Space_Separator,
            Line_Separator        => Line_Separator,
            Paragraph_Separator   => Paragraph_Separator,
            Control               => Control,
            Format                => Format,
            Surrogate             => Surrogate,
            Private_Use           => Private_Use,
            Unassigned            => Unassigned);
   begin
      return
        To
         (Element
           (Matreshka.Internals.Unicode.Ucd.Core.Property, Code).GC);
   end General_Category;

   --------------------
   -- Is_ID_Continue --
   --------------------

   function Is_ID_Continue (Code : Code_Point) return Boolean is
   begin
      return
        Element
         (Matreshka.Internals.Unicode.Ucd.Core.Property, Code).B
           (Matreshka.Internals.Unicode.Ucd.ID_Continue);
   end Is_ID_Continue;

   -----------------
   -- Is_ID_Start --
   -----------------

   function Is_ID_Start (Code : Code_Point) return Boolean is
   begin
      return
        Element
         (Matreshka.Internals.Unicode.Ucd.Core.Property, Code).B
           (Matreshka.Internals.Unicode.Ucd.ID_Start);
   end Is_ID_Start;

   --------------------------------
   -- Is_Noncharacter_Code_Point --
   --------------------------------

   function Is_Noncharacter_Code_Point (Code : Code_Point) return Boolean is
   begin
      return
        Element
         (Matreshka.Internals.Unicode.Ucd.Core.Property, Code).B
           (Matreshka.Internals.Unicode.Ucd.Noncharacter_Code_Point);
   end Is_Noncharacter_Code_Point;

   --------------------------
   -- Is_Unified_Ideograph --
   --------------------------

   function Is_Unified_Ideograph (Code : Code_Point) return Boolean is
   begin
      return
        Element
         (Matreshka.Internals.Unicode.Ucd.Core.Property, Code).B
           (Matreshka.Internals.Unicode.Ucd.Unified_Ideograph);
   end Is_Unified_Ideograph;

   --------------------
   -- Is_White_Space --
   --------------------

   function Is_White_Space (Code : Code_Point) return Boolean is
   begin
      return
        Element
         (Matreshka.Internals.Unicode.Ucd.Core.Property, Code).B
           (Matreshka.Internals.Unicode.Ucd.White_Space);
   end Is_White_Space;

   ---------------
   -- Lowercase --
   ---------------

   function Lowercase (Code : Code_Point) return Boolean is
   begin
      return
        Element
         (Matreshka.Internals.Unicode.Ucd.Core.Property, Code).B
           (Matreshka.Internals.Unicode.Ucd.Lowercase);
   end Lowercase;

   -----------------------------
   -- Simple_Casefold_Mapping --
   -----------------------------

   function Simple_Casefold_Mapping (Code : Code_Point) return Code_Point is
      C : constant Code_Point
        := Element
            (Matreshka.Internals.Unicode.Ucd.Cases.Mapping, Code).Simple
              (Matreshka.Internals.Unicode.Ucd.Folding);

   begin
      if C /= 0 then
         return C;

      else
         return Code;
      end if;
   end Simple_Casefold_Mapping;

   ------------------------------
   -- Simple_Lowercase_Mapping --
   ------------------------------

   function Simple_Lowercase_Mapping (Code : Code_Point) return Code_Point is
      C : constant Code_Point
        := Element
            (Matreshka.Internals.Unicode.Ucd.Cases.Mapping, Code).Simple
              (Matreshka.Internals.Unicode.Ucd.Lower);

   begin
      if C /= 0 then
         return C;

      else
         return Code;
      end if;
   end Simple_Lowercase_Mapping;

   ------------------------------
   -- Simple_Titlecase_Mapping --
   ------------------------------

   function Simple_Titlecase_Mapping (Code : Code_Point) return Code_Point is
      C : constant Code_Point
        := Element
            (Matreshka.Internals.Unicode.Ucd.Cases.Mapping, Code).Simple
              (Matreshka.Internals.Unicode.Ucd.Title);

   begin
      if C /= 0 then
         return C;

      else
         --  [UAX #44]
         --
         --  "Note: If this field is null, then the Simple_Titlecase_Mapping is
         --  the same as the Simple_Uppercase_Mapping for this character."

         return Simple_Uppercase_Mapping (Code);
      end if;
   end Simple_Titlecase_Mapping;

   ------------------------------
   -- Simple_Uppercase_Mapping --
   ------------------------------

   function Simple_Uppercase_Mapping (Code : Code_Point) return Code_Point is
      C : constant Code_Point
        := Element
            (Matreshka.Internals.Unicode.Ucd.Cases.Mapping, Code).Simple
              (Matreshka.Internals.Unicode.Ucd.Upper);

   begin
      if C /= 0 then
         return C;

      else
         return Code;
      end if;
   end Simple_Uppercase_Mapping;

   ---------------
   -- Uppercase --
   ---------------

   function Uppercase (Code : Code_Point) return Boolean is
   begin
      return
        Element
         (Matreshka.Internals.Unicode.Ucd.Core.Property, Code).B
           (Matreshka.Internals.Unicode.Ucd.Uppercase);
   end Uppercase;

end Matreshka.Internals.Unicode.Properties;
