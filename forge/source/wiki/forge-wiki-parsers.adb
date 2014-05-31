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

with Ada.Tags.Generic_Dispatching_Constructor;
with Ada.Unchecked_Deallocation;

with League.Characters.Latin;
with League.String_Vectors;

package body Forge.Wiki.Parsers is

   procedure Initialize_Block_Regexp (Self : in out Wiki_Parser'Class);
   --  Build and compile block detection regexp.

   procedure Free is
     new Ada.Unchecked_Deallocation
          (Forge.Wiki.Block_Parsers.Abstract_Block_Parser'Class,
           Block_Parser_Access);

   function Create_Block_Parser
    (Tag : Ada.Tags.Tag) return not null Block_Parser_Access;
   --  Constructor to create block parser.

   type Block_Parser_Information is record
      Regexp_String : League.Strings.Universal_String;
      Total_Groups  : Positive;
      Offset_Group  : Positive;
--      Match_Index   : Positive;
      Parser_Tag    : Ada.Tags.Tag;
   end record;

   package Block_Parser_Information_Vectors is
     new Ada.Containers.Vectors (Positive, Block_Parser_Information);

   Block_Registry     : Block_Parser_Information_Vectors.Vector;
   Paragraph_Registry : Block_Parser_Information;

   Base_Expression       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("(^\p{White_Space}*(\P{White_Space}))"  --  Regular paragraph
            & "|(^\p{White_Space}*$)");           --  Separator ('empty') line
   Para_Block_Match      : constant Positive := 1;
   Para_Offset_Match     : constant Positive := 2;
   Separator_Block_Match : constant Positive := 3;
   --  Base regular expression to handle paragraph's start line, block's
   --  continuation line and block separator line.

   -------------------------
   -- Create_Block_Parser --
   -------------------------

   function Create_Block_Parser
    (Tag : Ada.Tags.Tag) return not null Block_Parser_Access
   is
      function Create is
        new Ada.Tags.Generic_Dispatching_Constructor
             (Forge.Wiki.Block_Parsers.Abstract_Block_Parser,
              Forge.Wiki.Block_Parsers.Constructor_Parameters,
              Forge.Wiki.Block_Parsers.Create);

      Parameters : aliased Forge.Wiki.Block_Parsers.Constructor_Parameters;

   begin
      return
        new Forge.Wiki.Block_Parsers.Abstract_Block_Parser'Class'
             (Create (Tag, Parameters'Access));
   end Create_Block_Parser;

   -----------------------------
   -- Initialize_Block_Regexp --
   -----------------------------

   procedure Initialize_Block_Regexp (Self : in out Wiki_Parser'Class) is
   begin
      Self.Block_Regexp := League.Regexps.Compile (Base_Expression);
   end Initialize_Block_Regexp;

   -----------
   -- Parse --
   -----------

   procedure Parse
    (Self : in out Wiki_Parser'Class; Data : League.Strings.Universal_String)
   is
      Lines  : constant League.String_Vectors.Universal_String_Vector
        := Data.Split (League.Characters.Latin.Line_Feed);
      Line   : Positive := 1;
      Match  : League.Regexps.Regexp_Match;
      Offset : Natural;

   begin
      Self.Initialize_Block_Regexp;
      Self.Block_State := null;

      while Line <= Lines.Length loop
         Match := Self.Block_Regexp.Find_Match (Lines (Line));

--         Put_Line (Integer'Image (Match.Capture_Count) & ' ' & Boolean'Image (Match.Is_Matched));
--
--         for C in 1 .. Match.Capture_Count loop
--            Put_Line (Integer'Image (Match.First_Index (C)) & " .." & Integer'Image (Match.Last_Index (C)));
--         end loop;

         if Match.First_Index (Para_Block_Match)
              <= Match.Last_Index (Para_Block_Match)
         then
            Offset := Match.First_Index (Para_Offset_Match);

            if Self.Block_State = null then
--               Put_Line ("  paragraph started");

               Self.Block_State :=
                 Create_Block_Parser (Paragraph_Registry.Parser_Tag);
               Self.Block_State.Start_Block;
               Self.Block_State.Line (Lines (Line).Tail_From (Offset));

            else
--               Put_Line ("  paragraph matched");
               Self.Block_State.Line (Lines (Line).Tail_From (Offset));
            end if;

         else
--            Put_Line ("  block separator matched");
            Self.Block_State.End_Block;
            Free (Self.Block_State);

            if not Self.Block_Stack.Is_Empty then
               Self.Block_State := Self.Block_Stack.Last_Element;
               Self.Block_Stack.Delete_Last;
            end if;
         end if;

         Line := Line + 1;
      end loop;
   end Parse;

   -------------------------------------
   -- Register_Paragraph_Block_Parser --
   -------------------------------------

   procedure Register_Paragraph_Block_Parser
    (Regexp_String : League.Strings.Universal_String;
     Total_Groups  : Positive;
     Offset_Group  : Positive;
     Tag           : Ada.Tags.Tag) is
   begin
      Paragraph_Registry := (Regexp_String, Total_Groups, Offset_Group, Tag);
   end Register_Paragraph_Block_Parser;

   ---------------------------
   -- Register_Block_Parser --
   ---------------------------

   procedure Register_Block_Parser
    (Regexp_String : League.Strings.Universal_String;
     Total_Groups  : Positive;
     Offset_Group  : Positive;
     Tag           : Ada.Tags.Tag) is
   begin
      Block_Registry.Append ((Regexp_String, Total_Groups, Offset_Group, Tag));
      Put_Line ("Register: " & Ada.Tags.External_Tag (Tag));
   end Register_Block_Parser;

end Forge.Wiki.Parsers;
