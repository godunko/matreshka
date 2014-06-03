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
with Ada.Text_IO; use Ada.Text_IO;

with Forge.Wiki.Block_Parsers.Paragraphs;
with Forge.Wiki.Parsers;

package body Forge.Wiki.Block_Parsers.Lists is

   ------------
   -- Create --
   ------------

   overriding function Create
    (Parameters : not null access Constructor_Parameters)
       return List_Block_Parser is
   begin
      return
        List_Block_Parser'
         (Offset      => Parameters.Markup_Offset,
          Text_Offset => Parameters.Text_Offset);
   end Create;

   ---------------
   -- End_Block --
   ---------------

   overriding function End_Block
    (Self : not null access List_Block_Parser;
     Next : access Abstract_Block_Parser'Class) return End_Block_Action is
   begin
      Put_Line (" </li>");

      if Next /= null then
         if Next.Offset < Self.Offset then
            Put_Line ("</ul>");

            return Unwind;

         elsif Next.Offset = Self.Offset
           and Next.all in List_Block_Parser'Class
         then
            return Continue;
         end if;

      else
         Put_Line ("</ul>");

         return Unwind;
      end if;

      return Continue;
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
      Forge.Wiki.Parsers.Register_Block_Parser
       (League.Strings.To_Universal_String
         ("^\p{White_Space}*(\-)\p{White_Space}*(\P{White_Space})"),
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
        := (Markup        => League.Strings.Empty_Universal_String,
            Markup_Offset => 0,
            Text_Offset   => Self.Text_Offset);

   begin
      if Previous /= null
        and then Previous.all not in List_Block_Parser'Class
      then
         Put_Line ("<ul>");
      end if;

      Put_Line ("  <li>");

      return
        new Forge.Wiki.Block_Parsers.Paragraphs.Paragraph_Block_Parser'
             (Forge.Wiki.Block_Parsers.Paragraphs.Create (Parameters'Access));
   end Start_Block;

end Forge.Wiki.Block_Parsers.Lists;
