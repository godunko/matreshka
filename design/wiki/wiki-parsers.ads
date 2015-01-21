------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2014-2015, Vadim Godunko <vgodunko@gmail.com>                --
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
with Ada.Tags;

private with League.Regexps;
with League.Strings;
with XML.SAX.Writers;

private with Wiki.Block_Parsers;

package Wiki.Parsers is

   -----------------
   -- Wiki_Parser --
   -----------------

   type Wiki_Parser is tagged limited private;

   procedure Parse
    (Self   : in out Wiki_Parser'Class;
     Data   : League.Strings.Universal_String;
     Writer : in out XML.SAX.Writers.SAX_Writer'Class);
   --  Parses given string. Generated stream contains only events for parsed
   --  text, and need to be wrapped by <HTML><BODY>/etc tags. Caller is
   --  responsible to map default prefix (or some other prefix) to XHTML
   --  namespace URI.

   procedure Register_Block_Parser
    (Regexp_String : League.Strings.Universal_String;
     Total_Groups  : Positive;
     Markup_Group  : Natural;
     Text_Group    : Positive;
     Tag           : Ada.Tags.Tag);
   --  Registers custom block parser. Regexp_String is regular expression to
   --  detect start of custom block. Text_Group is number of group in regular
   --  expression which is used to detect position of first significant
   --  character of text on block's start line. Total_Groups is total number of
   --  groups used in regular expression. Tag is tag of the custom block parser
   --  to create its instance.

   procedure Register_Paragraph_Block_Parser
    (Regexp_String : League.Strings.Universal_String;
     Total_Groups  : Positive;
     Text_Group    : Positive;
     Tag           : Ada.Tags.Tag);
   --  Register custom block parser for base paragraph block. Only one parser
   --  can be registered in this way.

private

   type Block_Expression_Item is record
      Match_Group  : Positive;
      Markup_Group : Natural;
      Text_Group   : Positive;
      --  Regular expression's groups to extract:
      --   - matching of block element's regular expression
      --   - markup part of block element (it is optional part)
      --   - text part of block element
      Is_Start     : Boolean;
      --  Regular expression detects start of new block element of this kind.
      --  Note, ordinary paragraph has same expression for both start and
      --  continuation, so it is not set for it till another way to distinguish
      --  this case will be found.
      Parser_Tag   : Ada.Tags.Tag;
   end record;

   package Block_Expression_Vectors is
     new Ada.Containers.Vectors (Positive, Block_Expression_Item);

   package Block_Parser_Vectors is
     new Ada.Containers.Vectors
          (Positive,
           Wiki.Block_Parsers.Block_Parser_Access,
           Wiki.Block_Parsers."=");

   type Wiki_Parser is tagged limited record
      Block_Regexp    : League.Regexps.Regexp_Pattern;
      Block_Info      : Block_Expression_Vectors.Vector;
      Separator_Group : Positive;
      Block_State     : Wiki.Block_Parsers.Block_Parser_Access;
      Block_Stack     : Block_Parser_Vectors.Vector;
      Is_Separated    : Boolean;
   end record;

end Wiki.Parsers;
