------------------------------------------------------------------------------
--                                                                          --
--                               Forge on Ada                               --
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
private with Ada.Containers.Vectors;

private with League.Regexps;
with League.Strings;

private with Forge.Wiki.Block_Parsers;

package Forge.Wiki.Parsers is

--   pragma Preelaborate;
--   type Parser_Handler (Found : Boolean) is record
--      case Found is
--         when False =>
--            null;
--
--         when True =>
--            Handler : 
--      end case;
--   end record;
--
--   type Block_Parser_Extension is limited interface;
--
--   not overriding function Parser (Self : Block_Parser_Extension) return Parser_Handler;
--
--   type Start_Pattern_Information is record
--      Expression   : League.Strings.Universal_String;
--      Offset_Group : Positive;
--      Total_Groups : Positive;
--   end record;
--
--   type Block_Parser_Extension is limited interface;
--
--   not overriding function Start_Pattern
--    (Self : Block_Parser_Extension) return Start_Pattern_Information
--       is abstract;

   -----------------
   -- Wiki_Parser --
   -----------------

   type Wiki_Parser is tagged limited private;

   procedure Parse
    (Self : in out Wiki_Parser'Class; Data : League.Strings.Universal_String);
   --  Parses given string.

private

--   type Initial_Block_Parser is new Abstract_Block_Parser with null record;

   type Block_Parser_Access is
     access all Forge.Wiki.Block_Parsers.Abstract_Block_Parser'Class;

   package Block_Parser_Vectors is
     new Ada.Containers.Vectors (Positive, Block_Parser_Access);

   type Wiki_Parser is tagged limited record
      Block_Regexp : League.Regexps.Regexp_Pattern;
      Block_State  : Block_Parser_Access;
      Block_Stack  : Block_Parser_Vectors.Vector;
   end record;

end Forge.Wiki.Parsers;
