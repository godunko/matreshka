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
with Wiki.Parsers;

package body Wiki.Block_Parsers.Paragraphs is

   HTML5_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://www.w3.org/1999/xhtml");
   P_Tag     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("p");

   ------------
   -- Create --
   ------------

   overriding function Create
    (Parameters : not null access Constructor_Parameters)
       return Paragraph_Block_Parser is
   begin
      return Paragraph_Block_Parser'
              (Offset       => Parameters.Text_Offset,
               Writer       => Parameters.Writer,
               Space_Needed => False);
   end Create;

   ---------------
   -- End_Block --
   ---------------

   overriding function End_Block
    (Self : not null access Paragraph_Block_Parser;
     Next : access Abstract_Block_Parser'Class) return End_Block_Action is
   begin
      Self.Writer.End_Element
       (Local_Name    => P_Tag,
        Namespace_URI => HTML5_URI);

      return
        Wiki.Block_Parsers.Nestables.Nestable_Block_Parser
         (Self.all).End_Block (Next);
   end End_Block;

   ----------
   -- Line --
   ----------

   overriding procedure Line
    (Self : not null access Paragraph_Block_Parser;
     Text : League.Strings.Universal_String) is
   begin
      if Self.Space_Needed then
         Self.Writer.Characters (' ');

      else
         Self.Space_Needed := True;
      end if;

      Self.Writer.Characters (Text);
   end Line;

   --------------
   -- Register --
   --------------

   procedure Register is
   begin
      Wiki.Parsers.Register_Paragraph_Block_Parser
       (League.Strings.To_Universal_String
         ("^\p{White_Space}* (\P{White_Space}.*) \p{White_Space}*$"),
        1,
        1,
        Paragraph_Block_Parser'Tag);
   end Register;

   -----------------
   -- Start_Block --
   -----------------

   overriding function Start_Block
    (Self     : not null access Paragraph_Block_Parser;
     Previous : access Abstract_Block_Parser'Class)
       return Block_Parser_Access is
   begin
      Self.Writer.Start_Element
       (Local_Name    => P_Tag,
        Namespace_URI => HTML5_URI);

      return null;
   end Start_Block;

end Wiki.Block_Parsers.Paragraphs;
