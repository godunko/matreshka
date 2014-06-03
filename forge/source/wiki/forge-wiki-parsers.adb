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
    (Tag           : Ada.Tags.Tag;
     Markup        : League.Strings.Universal_String;
     Markup_Offset : Natural;
     Text_Offset   : Positive) return not null Block_Parser_Access;
   --  Constructor to create block parser.

   type Block_Parser_Information is record
      Regexp_String : League.Strings.Universal_String;
      Total_Groups  : Positive;
      Markup_Group  : Natural;
      Offset_Group  : Positive;
      Parser_Tag    : Ada.Tags.Tag;
   end record;

   package Block_Parser_Information_Vectors is
     new Ada.Containers.Vectors (Positive, Block_Parser_Information);

   Block_Registry     : Block_Parser_Information_Vectors.Vector;
   Paragraph_Registry : Block_Parser_Information;

   Separator_Expression  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("|(^\p{White_Space}*$)");
   --  Regular expression for separator ('empty') line

   -------------------------
   -- Create_Block_Parser --
   -------------------------

   function Create_Block_Parser
    (Tag           : Ada.Tags.Tag;
     Markup        : League.Strings.Universal_String;
     Markup_Offset : Natural;
     Text_Offset   : Positive) return not null Block_Parser_Access
   is
      function Create is
        new Ada.Tags.Generic_Dispatching_Constructor
             (Forge.Wiki.Block_Parsers.Abstract_Block_Parser,
              Forge.Wiki.Block_Parsers.Constructor_Parameters,
              Forge.Wiki.Block_Parsers.Create);

      Parameters : aliased Forge.Wiki.Block_Parsers.Constructor_Parameters
        := (Markup, Markup_Offset, Text_Offset);

   begin
      return
        new Forge.Wiki.Block_Parsers.Abstract_Block_Parser'Class'
             (Create (Tag, Parameters'Access));
   end Create_Block_Parser;

   -----------------------------
   -- Initialize_Block_Regexp --
   -----------------------------

   procedure Initialize_Block_Regexp (Self : in out Wiki_Parser'Class) is
      use type League.Strings.Universal_String;

      Expression : League.Strings.Universal_String;
      Group      : Positive := 1;

      procedure Append
       (Block    : Block_Parser_Information;
        Is_Start : Boolean);
      --  Appends regular expression of the specified block to the result block
      --  detection regular expression, compute absolute position of
      --  significant groups of result expression, and add this data into
      --  internal information.

      ------------
      -- Append --
      ------------

      procedure Append
       (Block    : Block_Parser_Information;
        Is_Start : Boolean) is
      begin
         if not Expression.Is_Empty then
            Expression.Append ('|');
         end if;

         Expression.Append ('(' & Block.Regexp_String & ')');
         Self.Block_Info.Append
          ((Match_Group  => Group,
            Markup_Group =>
              (if Block.Markup_Group = 0 then 0
                 else Group + Block.Offset_Group),
            Offset_Group => Group + Block.Offset_Group,
            Is_Start     => Is_Start,
            Parser_Tag   => Block.Parser_Tag));
         Group := Group + Block.Total_Groups + 1;
      end Append;

   begin
      for Block of Block_Registry loop
         Append (Block, True);
      end loop;

      Append (Paragraph_Registry, False);
      Expression.Append (Separator_Expression);
      Self.Separator_Group := Group;

      Self.Block_Regexp := League.Regexps.Compile (Expression);
   end Initialize_Block_Regexp;

   -----------
   -- Parse --
   -----------

   procedure Parse
    (Self : in out Wiki_Parser'Class; Data : League.Strings.Universal_String)
   is
      Lines       : constant League.String_Vectors.Universal_String_Vector
        := Data.Split (League.Characters.Latin.Line_Feed);
      Line        : Positive := 1;
      Match       : League.Regexps.Regexp_Match;
      Text_Offset : Natural;
      Found       : Boolean;
      Next_Block  : Block_Parser_Access;

   begin
      Self.Initialize_Block_Regexp;
      Self.Is_Separated := True;
      Self.Block_State := null;

      while Line <= Lines.Length loop
         Match := Self.Block_Regexp.Find_Match (Lines (Line));

         Found := False;

         for Item of Self.Block_Info loop
            if Match.First_Index (Item.Match_Group)
                 <= Match.Last_Index (Item.Match_Group)
            then
               Text_Offset := Match.First_Index (Item.Offset_Group);

               if Item.Is_Start
                 or else Self.Is_Separated
               then
                  Self.Is_Separated := False;
                  Put_Line (Standard_Error, ">>> new block parser created <<<");
                  Put_Line (Standard_Error, Ada.Tags.External_Tag (Item.Parser_Tag));
                  Next_Block :=
                    Create_Block_Parser
                     (Item.Parser_Tag,
                      (if Item.Markup_Group = 0
                         then League.Strings.Empty_Universal_String
                         else Match.Capture (Item.Markup_Group)),
                      (if Item.Markup_Group = 0
                         then 0 else Match.First_Index (Item.Markup_Group)),
                      Text_Offset);

                  if Self.Block_State /= null then
                     Self.Block_State.End_Block (Next_Block);
                  end if;

                  Free (Self.Block_State);
                  Self.Block_State := Next_Block;
                  Next_Block := null;

                  Self.Block_State.Start_Block;
               end if;

               Self.Block_State.Line (Lines (Line).Tail_From (Text_Offset));

               Found := True;

               exit;
            end if;
         end loop;

         if not Found then
            --  It means that separator line's regular expression was matched,
            --  mark last block as explicitly separated.

            Self.Is_Separated := True;
         end if;

         Line := Line + 1;
      end loop;

      if Self.Block_State /= null then
         Self.Block_State.End_Block (null);
      end if;
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
      Paragraph_Registry :=
       (Regexp_String, Total_Groups, 0, Offset_Group, Tag);
   end Register_Paragraph_Block_Parser;

   ---------------------------
   -- Register_Block_Parser --
   ---------------------------

   procedure Register_Block_Parser
    (Regexp_String : League.Strings.Universal_String;
     Total_Groups  : Positive;
     Markup_Group  : Natural;
     Offset_Group  : Positive;
     Tag           : Ada.Tags.Tag) is
   begin
      Block_Registry.Append
       ((Regexp_String, Total_Groups, Markup_Group, Offset_Group, Tag));
   end Register_Block_Parser;

end Forge.Wiki.Parsers;
