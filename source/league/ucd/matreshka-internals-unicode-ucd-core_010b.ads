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

package Matreshka.Internals.Unicode.Ucd.Core_010B is

   pragma Preelaborate;

   Group_010B : aliased constant Core_Second_Stage
     := (16#36# .. 16#38# =>  --  010B36 .. 010B38
          (Unassigned, Neutral,
           Other, Other, Other, Unknown,
           (others => False)),
         16#39#           =>  --  010B39
          (Other_Punctuation, Neutral,
           Other, Other, Other, Break_After,
           (Grapheme_Base => True,
            others => False)),
         16#3A# .. 16#3F# =>  --  010B3A .. 010B3F
          (Other_Punctuation, Neutral,
           Other, Other, Other, Break_After,
           (Terminal_Punctuation
              | Grapheme_Base => True,
            others => False)),
         16#56# .. 16#57# =>  --  010B56 .. 010B57
          (Unassigned, Neutral,
           Other, Other, Other, Unknown,
           (others => False)),
         16#58# .. 16#5F# =>  --  010B58 .. 010B5F
          (Other_Number, Neutral,
           Other, Other, Other, Alphabetic,
           (Grapheme_Base => True,
            others => False)),
         16#73# .. 16#77# =>  --  010B73 .. 010B77
          (Unassigned, Neutral,
           Other, Other, Other, Unknown,
           (others => False)),
         16#78# .. 16#7F# =>  --  010B78 .. 010B7F
          (Other_Number, Neutral,
           Other, Other, Other, Alphabetic,
           (Grapheme_Base => True,
            others => False)),
         16#92# .. 16#98# =>  --  010B92 .. 010B98
          (Unassigned, Neutral,
           Other, Other, Other, Unknown,
           (others => False)),
         16#99# .. 16#9C# =>  --  010B99 .. 010B9C
          (Other_Punctuation, Neutral,
           Other, Other, Other, Alphabetic,
           (Terminal_Punctuation
              | Grapheme_Base => True,
            others => False)),
         16#9D# .. 16#A8# =>  --  010B9D .. 010BA8
          (Unassigned, Neutral,
           Other, Other, Other, Unknown,
           (others => False)),
         16#A9# .. 16#AF# =>  --  010BA9 .. 010BAF
          (Other_Number, Neutral,
           Other, Other, Other, Alphabetic,
           (Grapheme_Base => True,
            others => False)),
         16#B0# .. 16#FF# =>  --  010BB0 .. 010BFF
          (Unassigned, Neutral,
           Other, Other, Other, Unknown,
           (others => False)),
         others           =>
          (Other_Letter, Neutral,
           Other, A_Letter, O_Letter, Alphabetic,
           (Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)));

end Matreshka.Internals.Unicode.Ucd.Core_010B;
