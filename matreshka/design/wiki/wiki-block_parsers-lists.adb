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
with Wiki.Block_Parsers.Paragraphs;
with Wiki.Parsers;

package body Wiki.Block_Parsers.Lists is

   HTML5_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://www.w3.org/1999/xhtml");
   UL_Tag    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ul");
   LI_Tag    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("li");

   ------------
   -- Create --
   ------------

   overriding function Create
    (Parameters : not null access Constructor_Parameters)
       return List_Block_Parser is
   begin
      return
        List_Block_Parser'
         (Writer      => Parameters.Writer,
          Offset      => Parameters.Markup_Offset,
          Text_Offset => Parameters.Text_Offset);
   end Create;

   ---------------
   -- End_Block --
   ---------------

   overriding function End_Block
    (Self : not null access List_Block_Parser;
     Next : access Abstract_Block_Parser'Class) return End_Block_Action is
   begin
      Self.Writer.End_Element
       (Local_Name    => LI_Tag,
        Namespace_URI => HTML5_URI);

      case Wiki.Block_Parsers.Nestables.Nestable_Block_Parser
            (Self.all).End_Block (Next)
      is
         when Continue =>
            return Continue;

         when Unwind =>
            Self.Writer.End_Element
             (Local_Name    => UL_Tag,
              Namespace_URI => HTML5_URI);

            return Unwind;
      end case;
   end End_Block;

   ----------
   -- Line --
   ----------

   overriding procedure Line
    (Self : not null access List_Block_Parser;
     Text : League.Strings.Universal_String) is
   begin
      --  List block element parser never receives text information, it creates
      --  nested paragraph block element parser to handle text.

      raise Program_Error;
   end Line;

   --------------
   -- Register --
   --------------

   procedure Register is
   begin
      Wiki.Parsers.Register_Block_Parser
       (League.Strings.To_Universal_String
         ("^\p{White_Space}* (\-) \p{White_Space}*"
            & " (\P{White_Space}.*) \p{White_Space}*$"),
        2,
        1,
        2,
        List_Block_Parser'Tag);
   end Register;

   -----------------
   -- Start_Block --
   -----------------

   overriding function Start_Block
    (Self     : not null access List_Block_Parser;
     Previous : access Abstract_Block_Parser'Class) return Block_Parser_Access
   is
      Parameters : aliased Constructor_Parameters
        := (Writer        => Self.Writer,
            Markup        => League.Strings.Empty_Universal_String,
            Markup_Offset => 0,
            Text_Offset   => Self.Text_Offset);

   begin
      if Previous /= null
        and then Previous.all not in List_Block_Parser'Class
      then
         Self.Writer.Start_Element
          (Local_Name    => UL_Tag,
           Namespace_URI => HTML5_URI);
      end if;

      Self.Writer.Start_Element
       (Local_Name    => LI_Tag,
        Namespace_URI => HTML5_URI);

      return
        new Wiki.Block_Parsers.Paragraphs.Paragraph_Block_Parser'
             (Wiki.Block_Parsers.Paragraphs.Create (Parameters'Access));
   end Start_Block;

end Wiki.Block_Parsers.Lists;
