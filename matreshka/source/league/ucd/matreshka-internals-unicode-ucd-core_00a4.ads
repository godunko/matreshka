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

package Matreshka.Internals.Unicode.Ucd.Core_00A4 is

   pragma Preelaborate;

   Group_00A4 : aliased constant Core_Second_Stage
     := (16#8D# .. 16#8F# =>  --  A48D .. A48F
          (Unassigned, Neutral,
           Other, Other, Other, Unknown,
           None,
           (others => False)),
         16#90# .. 16#C6# =>  --  A490 .. A4C6
          (Other_Symbol, Wide,
           Other, Other, Other, Ideographic,
           None,
           (Grapheme_Base => True,
            others => False)),
         16#C7# .. 16#CF# =>  --  A4C7 .. A4CF
          (Unassigned, Neutral,
           Other, Other, Other, Unknown,
           None,
           (others => False)),
         16#D0# .. 16#F7# =>  --  A4D0 .. A4F7
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
         16#F8# .. 16#FD# =>  --  A4F8 .. A4FD
          (Modifier_Letter, Neutral,
           Other, A_Letter, O_Letter, Alphabetic,
           None,
           (Alphabetic
              | Case_Ignorable
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)),
         16#FE#           =>  --  A4FE
          (Other_Punctuation, Neutral,
           Other, Other, Other, Break_After,
           None,
           (Terminal_Punctuation
              | Grapheme_Base => True,
            others => False)),
         16#FF#           =>  --  A4FF
          (Other_Punctuation, Neutral,
           Other, Other, S_Term, Break_After,
           None,
           (STerm
              | Terminal_Punctuation
              | Grapheme_Base => True,
            others => False)),
         others           =>
          (Other_Letter, Wide,
           Other, A_Letter, O_Letter, Ideographic,
           None,
           (Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)));

end Matreshka.Internals.Unicode.Ucd.Core_00A4;
