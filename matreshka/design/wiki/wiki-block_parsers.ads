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
with League.Strings;
with XML.SAX.Writers;

private package Wiki.Block_Parsers is

   pragma Preelaborate;

   type Constructor_Parameters is record
      Markup        : League.Strings.Universal_String;
      Markup_Offset : Natural;
      Text_Offset   : Positive;
      Writer        : not null access XML.SAX.Writers.SAX_Writer'Class;
   end record;

   type End_Block_Action is
    (Continue, --  Replace current block parser by new one.
     Unwind);  --  Unwind block parsers stack and check with next block parser.

   type Abstract_Block_Parser is abstract tagged limited record
      Writer : access XML.SAX.Writers.SAX_Writer'Class;
   end record;

   type Block_Parser_Access is access all Abstract_Block_Parser'Class;

   not overriding function Start_Block
    (Self     : not null access Abstract_Block_Parser;
     Previous : access Abstract_Block_Parser'Class)
       return Block_Parser_Access is abstract;
   --  Called when start of block element is detected.

   not overriding function End_Block
    (Self : not null access Abstract_Block_Parser;
     Next : access Abstract_Block_Parser'Class)
       return End_Block_Action is abstract;
   --  Called when end of block element is detected.

   not overriding procedure Line
    (Self : not null access Abstract_Block_Parser;
     Text : League.Strings.Universal_String) is abstract;
   --  Called to process single line of text in processed block element.

   not overriding function Create
    (Parameters : not null access Constructor_Parameters)
       return Abstract_Block_Parser is abstract;
   --  Dispatching constructor to create instance of block element parser.

   not overriding function Can_Be_Continued
    (Self : not null access constant Abstract_Block_Parser) return Boolean;
   --  Returns True when block element can be continued on next line. Default
   --  implementation returns True always.

end Wiki.Block_Parsers;
