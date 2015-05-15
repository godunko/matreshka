------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--        Localization, Internationalization, Globalization for Ada         --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2012-2015, Vadim Godunko <vgodunko@gmail.com>                --
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

pragma Restrictions (No_Elaboration_Code);
--  GNAT: enforce generation of preinitialized data section instead of
--  generation of elaboration code.

package Matreshka.Internals.Unicode.Ucd.Core_0110 is

   pragma Preelaborate;

   Group_0110 : aliased constant Core_Second_Stage
     := (16#00#           =>  --  011000
          (Spacing_Mark, Neutral,
           Spacing_Mark, Extend, Extend, Combining_Mark,
           None,
           (Other_Alphabetic
              | Alphabetic
              | Grapheme_Base
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#01#           =>  --  011001
          (Nonspacing_Mark, Neutral,
           Extend, Extend, Extend, Combining_Mark,
           None,
           (Other_Alphabetic
              | Alphabetic
              | Case_Ignorable
              | Grapheme_Extend
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#02#           =>  --  011002
          (Spacing_Mark, Neutral,
           Spacing_Mark, Extend, Extend, Combining_Mark,
           None,
           (Other_Alphabetic
              | Alphabetic
              | Grapheme_Base
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#38# .. 16#45# =>  --  011038 .. 011045
          (Nonspacing_Mark, Neutral,
           Extend, Extend, Extend, Combining_Mark,
           None,
           (Other_Alphabetic
              | Alphabetic
              | Case_Ignorable
              | Grapheme_Extend
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#46#           =>  --  011046
          (Nonspacing_Mark, Neutral,
           Extend, Extend, Extend, Combining_Mark,
           None,
           (Case_Ignorable
              | Grapheme_Extend
              | Grapheme_Link
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#47# .. 16#48# =>  --  011047 .. 011048
          (Other_Punctuation, Neutral,
           Other, Other, S_Term, Break_After,
           None,
           (STerm
              | Terminal_Punctuation
              | Grapheme_Base => True,
            others => False)),
         16#49# .. 16#4D# =>  --  011049 .. 01104D
          (Other_Punctuation, Neutral,
           Other, Other, Other, Alphabetic,
           None,
           (Terminal_Punctuation
              | Grapheme_Base => True,
            others => False)),
         16#4E# .. 16#51# =>  --  01104E .. 011051
          (Unassigned, Neutral,
           Other, Other, Other, Unknown,
           None,
           (others => False)),
         16#52# .. 16#65# =>  --  011052 .. 011065
          (Other_Number, Neutral,
           Other, Other, Other, Alphabetic,
           None,
           (Grapheme_Base => True,
            others => False)),
         16#66# .. 16#6F# =>  --  011066 .. 01106F
          (Decimal_Number, Neutral,
           Other, Numeric, Numeric, Numeric,
           None,
           (Grapheme_Base
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#70# .. 16#7F# =>  --  011070 .. 01107F
          (Unassigned, Neutral,
           Other, Other, Other, Unknown,
           None,
           (others => False)),
         16#80# .. 16#81# =>  --  011080 .. 011081
          (Nonspacing_Mark, Neutral,
           Extend, Extend, Extend, Combining_Mark,
           None,
           (Case_Ignorable
              | Grapheme_Extend
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#82#           =>  --  011082
          (Spacing_Mark, Neutral,
           Spacing_Mark, Extend, Extend, Combining_Mark,
           None,
           (Other_Alphabetic
              | Alphabetic
              | Grapheme_Base
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#9A#           =>  --  01109A
          (Other_Letter, Neutral,
           Other, A_Letter, O_Letter, Alphabetic,
           Canonical,
           (Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start
              | Expands_On_NFD
              | Expands_On_NFKD => True,
            others => False)),
         16#9C#           =>  --  01109C
          (Other_Letter, Neutral,
           Other, A_Letter, O_Letter, Alphabetic,
           Canonical,
           (Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start
              | Expands_On_NFD
              | Expands_On_NFKD => True,
            others => False)),
         16#AB#           =>  --  0110AB
          (Other_Letter, Neutral,
           Other, A_Letter, O_Letter, Alphabetic,
           Canonical,
           (Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start
              | Expands_On_NFD
              | Expands_On_NFKD => True,
            others => False)),
         16#B0# .. 16#B2# =>  --  0110B0 .. 0110B2
          (Spacing_Mark, Neutral,
           Spacing_Mark, Extend, Extend, Combining_Mark,
           None,
           (Other_Alphabetic
              | Alphabetic
              | Grapheme_Base
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#B3# .. 16#B6# =>  --  0110B3 .. 0110B6
          (Nonspacing_Mark, Neutral,
           Extend, Extend, Extend, Combining_Mark,
           None,
           (Other_Alphabetic
              | Alphabetic
              | Case_Ignorable
              | Grapheme_Extend
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#B7# .. 16#B8# =>  --  0110B7 .. 0110B8
          (Spacing_Mark, Neutral,
           Spacing_Mark, Extend, Extend, Combining_Mark,
           None,
           (Other_Alphabetic
              | Alphabetic
              | Grapheme_Base
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#B9#           =>  --  0110B9
          (Nonspacing_Mark, Neutral,
           Extend, Extend, Extend, Combining_Mark,
           None,
           (Diacritic
              | Case_Ignorable
              | Grapheme_Extend
              | Grapheme_Link
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#BA#           =>  --  0110BA
          (Nonspacing_Mark, Neutral,
           Extend, Extend, Extend, Combining_Mark,
           None,
           (Diacritic
              | Case_Ignorable
              | Grapheme_Extend
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#BB# .. 16#BC# =>  --  0110BB .. 0110BC
          (Other_Punctuation, Neutral,
           Other, Other, Other, Alphabetic,
           None,
           (Grapheme_Base => True,
            others => False)),
         16#BD#           =>  --  0110BD
          (Format, Neutral,
           Control, Format, Format, Alphabetic,
           None,
           (Case_Ignorable => True,
            others => False)),
         16#BE# .. 16#C1# =>  --  0110BE .. 0110C1
          (Other_Punctuation, Neutral,
           Other, Other, S_Term, Break_After,
           None,
           (STerm
              | Terminal_Punctuation
              | Grapheme_Base => True,
            others => False)),
         16#C2# .. 16#CF# =>  --  0110C2 .. 0110CF
          (Unassigned, Neutral,
           Other, Other, Other, Unknown,
           None,
           (others => False)),
         16#E9# .. 16#EF# =>  --  0110E9 .. 0110EF
          (Unassigned, Neutral,
           Other, Other, Other, Unknown,
           None,
           (others => False)),
         16#F0# .. 16#F9# =>  --  0110F0 .. 0110F9
          (Decimal_Number, Neutral,
           Other, Numeric, Numeric, Numeric,
           None,
           (Grapheme_Base
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#FA# .. 16#FF# =>  --  0110FA .. 0110FF
          (Unassigned, Neutral,
           Other, Other, Other, Unknown,
           None,
           (others => False)),
         others           =>
          (Other_Letter, Neutral,
           Other, A_Letter, O_Letter, Alphabetic,
           None,
           (Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)));

end Matreshka.Internals.Unicode.Ucd.Core_0110;
