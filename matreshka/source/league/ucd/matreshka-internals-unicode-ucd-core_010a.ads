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

package Matreshka.Internals.Unicode.Ucd.Core_010A is

   pragma Preelaborate;

   Group_010A : aliased constant Core_Second_Stage
     := (16#00#           =>  --  010A00
          (Other_Letter, Neutral,
           Other, A_Letter, O_Letter, Alphabetic,
           None,
           (Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)),
         16#01# .. 16#03# =>  --  010A01 .. 010A03
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
         16#05# .. 16#06# =>  --  010A05 .. 010A06
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
         16#0C# .. 16#0F# =>  --  010A0C .. 010A0F
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
         16#10# .. 16#13# =>  --  010A10 .. 010A13
          (Other_Letter, Neutral,
           Other, A_Letter, O_Letter, Alphabetic,
           None,
           (Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)),
         16#15# .. 16#17# =>  --  010A15 .. 010A17
          (Other_Letter, Neutral,
           Other, A_Letter, O_Letter, Alphabetic,
           None,
           (Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)),
         16#19# .. 16#33# =>  --  010A19 .. 010A33
          (Other_Letter, Neutral,
           Other, A_Letter, O_Letter, Alphabetic,
           None,
           (Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)),
         16#38# .. 16#3A# =>  --  010A38 .. 010A3A
          (Nonspacing_Mark, Neutral,
           Extend, Extend, Extend, Combining_Mark,
           None,
           (Case_Ignorable
              | Grapheme_Extend
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#3F#           =>  --  010A3F
          (Nonspacing_Mark, Neutral,
           Extend, Extend, Extend, Combining_Mark,
           None,
           (Case_Ignorable
              | Grapheme_Extend
              | Grapheme_Link
              | ID_Continue
              | XID_Continue => True,
            others => False)),
         16#40# .. 16#47# =>  --  010A40 .. 010A47
          (Other_Number, Neutral,
           Other, Other, Other, Alphabetic,
           None,
           (Grapheme_Base => True,
            others => False)),
         16#50# .. 16#55# =>  --  010A50 .. 010A55
          (Other_Punctuation, Neutral,
           Other, Other, Other, Break_After,
           None,
           (Grapheme_Base => True,
            others => False)),
         16#56# .. 16#57# =>  --  010A56 .. 010A57
          (Other_Punctuation, Neutral,
           Other, Other, S_Term, Break_After,
           None,
           (STerm
              | Grapheme_Base => True,
            others => False)),
         16#58#           =>  --  010A58
          (Other_Punctuation, Neutral,
           Other, Other, Other, Alphabetic,
           None,
           (Grapheme_Base => True,
            others => False)),
         16#60# .. 16#7C# =>  --  010A60 .. 010A7C
          (Other_Letter, Neutral,
           Other, A_Letter, O_Letter, Alphabetic,
           None,
           (Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)),
         16#7D# .. 16#7E# =>  --  010A7D .. 010A7E
          (Other_Number, Neutral,
           Other, Other, Other, Alphabetic,
           None,
           (Grapheme_Base => True,
            others => False)),
         16#7F#           =>  --  010A7F
          (Other_Punctuation, Neutral,
           Other, Other, Other, Alphabetic,
           None,
           (Grapheme_Base => True,
            others => False)),
         others           =>
          (Unassigned, Neutral,
           Other, Other, Other, Unknown,
           None,
           (others => False)));

end Matreshka.Internals.Unicode.Ucd.Core_010A;
