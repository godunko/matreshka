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

package Matreshka.Internals.Unicode.Ucd.Core_00FA is

   pragma Preelaborate;

   Group_00FA : aliased constant Core_Second_Stage
     := (16#0E# .. 16#0F# =>  --  FA0E .. FA0F
          (Other_Letter, Wide,
           Other, Other, O_Letter, Ideographic,
           None,
           (Ideographic
              | Unified_Ideograph
              | Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)),
         16#11#           =>  --  FA11
          (Other_Letter, Wide,
           Other, Other, O_Letter, Ideographic,
           None,
           (Ideographic
              | Unified_Ideograph
              | Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)),
         16#13# .. 16#14# =>  --  FA13 .. FA14
          (Other_Letter, Wide,
           Other, Other, O_Letter, Ideographic,
           None,
           (Ideographic
              | Unified_Ideograph
              | Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)),
         16#1F#           =>  --  FA1F
          (Other_Letter, Wide,
           Other, Other, O_Letter, Ideographic,
           None,
           (Ideographic
              | Unified_Ideograph
              | Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)),
         16#21#           =>  --  FA21
          (Other_Letter, Wide,
           Other, Other, O_Letter, Ideographic,
           None,
           (Ideographic
              | Unified_Ideograph
              | Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)),
         16#23# .. 16#24# =>  --  FA23 .. FA24
          (Other_Letter, Wide,
           Other, Other, O_Letter, Ideographic,
           None,
           (Ideographic
              | Unified_Ideograph
              | Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)),
         16#27# .. 16#29# =>  --  FA27 .. FA29
          (Other_Letter, Wide,
           Other, Other, O_Letter, Ideographic,
           None,
           (Ideographic
              | Unified_Ideograph
              | Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start => True,
            others => False)),
         16#6E# .. 16#6F# =>  --  FA6E .. FA6F
          (Unassigned, Wide,
           Other, Other, Other, Ideographic,
           None,
           (others => False)),
         16#DA# .. 16#FF# =>  --  FADA .. FAFF
          (Unassigned, Wide,
           Other, Other, Other, Ideographic,
           None,
           (others => False)),
         others           =>
          (Other_Letter, Wide,
           Other, Other, O_Letter, Ideographic,
           Canonical,
           (Ideographic
              | Alphabetic
              | Grapheme_Base
              | ID_Continue
              | ID_Start
              | XID_Continue
              | XID_Start
              | Full_Composition_Exclusion
              | Changes_When_NFKC_Casefolded => True,
            others => False)));

end Matreshka.Internals.Unicode.Ucd.Core_00FA;
