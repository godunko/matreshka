-- Copyright (c) 1990 Regents of the University of California.
-- All rights reserved.
--
-- This software was developed by John Self of the Arcadia project
-- at the University of California, Irvine.
--
-- Redistribution and use in source and binary forms are permitted
-- provided that the above copyright notice and this paragraph are
-- duplicated in all such forms and that any documentation,
-- advertising materials, and other materials related to such
-- distribution and use acknowledge that the software was developed
-- by the University of California, Irvine.  The name of the
-- University may not be used to endorse or promote products derived
-- from this software without specific prior written permission.
-- THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
-- IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
-- WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

-- TITLE skeleton manager
-- AUTHOR: John Self (UCI)
-- DESCRIPTION outputs skeleton sections when called by gen.
-- NOTES allows use of internal or external skeleton
-- $Header: /dc/uc/self/arcadia/aflex/ada/src/RCS/skeleton_managerB.a,v 1.19 1992/12/29 22:46:15 self Exp self $
with Ada.Strings.Wide_Wide_Unbounded.Wide_Wide_Text_IO;
with Ada.Wide_Wide_Text_IO;

with MISC_DEFS;

package body Skeleton_Manager is

   use Ada.Strings.Wide_Wide_Unbounded;
   use Ada.Strings.Wide_Wide_Unbounded.Wide_Wide_Text_IO;
   use Ada.Wide_Wide_Text_IO;

   function "+" (Item : Wide_Wide_String) return Unbounded_Wide_Wide_String
     renames To_Unbounded_Wide_Wide_String;

   Use_External_Skeleton : Boolean := False;
   -- are we using an external skelfile?
   Current_Line          : Integer := 1;

   type File_Array is array (Positive range <>) of Unbounded_Wide_Wide_String;

   Skel_Template : constant File_Array := (
  -- START OF SKELETON
  -- START OF S1
+"-- A lexical scanner generated by aflex",
+"%% user's code up to the double pound goes right here",
+"%% user's code up to the double pound goes right here",
-- BEGIN S2
+"   function YYLex return Token is",
+"",
+"      subtype short is Integer range -32768..32767;",
+"",
+"      yy_act : Integer;",
+"      yy_c   : short;",
+"",
+"      --  returned upon end-of-file",
+"      YY_END_TOK : constant Integer := 0;",
+"%% tables get generated here.",
-- BEGIN S3
+"",
+"         --  copy whatever the last rule matched to the standard output",
+"",
+"         procedure ECHO is",
+"         begin",
+"            if Ada.Wide_Wide_Text_IO.Is_Open (User_Output_File) then",
+"               Ada.Wide_Wide_Text_IO.Put (User_Output_File, YYText);",
+"",
+"            else",
+"               Ada.Wide_Wide_Text_IO.Put (YYText);",
+"            end if;",
+"         end ECHO;",
+"",
+"         --  enter a start condition.",
+"         --  Using procedure requires a () after the ENTER, but makes",
+"         --  everything much neater.",
+"",
+"         procedure ENTER (State : Integer) is",
+"         begin",
+"            YY_Start := 1 + 2 * State;",
+"         end ENTER;",
+"         pragma Inline (ENTER);",
+"",
+"         --  action number for EOF rule of a given start state",
+"function YY_STATE_EOF(state : Integer) return Integer is",
+"begin",
+"     return YY_END_OF_BUFFER + state + 1;",
+"end YY_STATE_EOF;",
+"pragma Inline (YY_STATE_EOF);",
+"",
+"-- return all but the first 'n' matched characters back to the input stream",
+"procedure yyless(n : Integer) is",
+"begin",
+"        yy_cp := yy_bp + n;",
+"        yy_c_buf_p := yy_cp;",
+"        YY_DO_BEFORE_ACTION; -- set up yytext again",
+"end yyless;",
+"pragma Inline (yyless);",
+"",
+"-- redefine this if you have something you want each time.",
+"procedure YY_USER_ACTION is",
+"begin",
+"        null;",
+"end;",
+"pragma Inline (YY_USER_ACTION);",
+"",
+"         --  yy_get_previous_state - get the state just before the EOB char",
+"         --  was reached",
+"",
+"         function YY_Get_Previous_State return YY_State_Type is",
+"            YY_Current_State : YY_State_Type;",
+"            YY_C             : Short;",
+"            Index            : Integer;",
+"            Code             : Wide_Wide_Character;",
+"%% a local declaration of yy_bp goes here if bol_needed",
+"begin",
+"%% code to get the start state into yy_current_state goes here",
-- BEGIN S3A
+"",
--+"    for yy_cp in yytext_ptr..yy_c_buf_p - 1 loop",
+"   declare",
+"      yy_cp : integer := yytext_ptr;",
+"",
+"   begin",
+"      while yy_cp < yy_c_buf_p loop",
+"         Index := yy_cp;",
+"",
+"%% code to find the next state goes here",
-- BEGIN S4
+"         yy_cp := Index;",
+"      end loop;",
+"   end;",
+"",
+"    return yy_current_state;",
+"end yy_get_previous_state;",
+"",
+"         procedure YYRestart (Input_File : Ada.Wide_Wide_Text_IO.File_Type) is",
+"         begin",
+"            Open_Input (Ada.Wide_Wide_Text_IO.Name (Input_File));",
+"         end YYRestart;",
+"",
+"         Index : Integer;",
+"         Code  : Wide_Wide_Character;",
+"",
+"      begin -- of YYLex",
+"<<new_file>>",
+"         --  This is where we enter upon encountering an end-of-file and",
+"         --  yywrap() indicating that we should continue processing",
+"",
+"    if ( yy_init ) then",
+"        if ( yy_start = 0 ) then",
+"            yy_start := 1;      -- first start state",
+"        end if;",
+"",
+"        -- we put in the '\n' and start reading from [1] so that an",
+"        -- initial match-at-newline will be true.",
+"",
+"        yy_ch_buf.data (0) := Ada.Characters.Wide_Wide_Latin_1.LF;",
+"        yy_n_chars := 1;",
+"",
+"        -- we always need two end-of-buffer characters.  The first causes",
+"        -- a transition to the end-of-buffer state.  The second causes",
+"        -- a jam in that state.",
+"",
+"        yy_ch_buf.data (yy_n_chars) := YY_END_OF_BUFFER_CHAR;",
+"        yy_ch_buf.data (yy_n_chars + 1) := YY_END_OF_BUFFER_CHAR;",
+"",
+"        yy_eof_has_been_seen := false;",
+"",
+"        yytext_ptr := 1;",
+"        yy_c_buf_p := yytext_ptr;",
+"        yy_init := false;",
+"-- UMASS CODES :",
+"--   Initialization",
+"        tok_begin_line := 1;",
+"        tok_end_line := 1;",
+"        tok_begin_col := 0;",
+"        tok_end_col := 0;",
+"        token_at_end_of_line := false;",
+"        line_number_of_saved_tok_line1 := 0;",
+"        line_number_of_saved_tok_line2 := 0;",
+"-- END OF UMASS CODES.",
+"    end if; -- yy_init",
+"",
+"    loop                -- loops until end-of-file is reached",
+"",
+"-- UMASS CODES :",
+"--    if last matched token is end_of_line, we must",
+"--    update the token_end_line and reset tok_end_col.",
+"    if Token_At_End_Of_Line then",
+"      Tok_End_Line := Tok_End_Line + 1;",
+"      Tok_End_Col := 0;",
+"      Token_At_End_Of_Line := False;",
+"    end if;",
+"-- END OF UMASS CODES.",
+"",
+"        yy_cp := yy_c_buf_p;",
+"",
+"        -- yy_bp points to the position in yy_ch_buf of the start of the",
+"        -- current run.",
+"%%",
-- BEGIN S5
+"",
+"<<next_action>>",
+"%% call to gen_find_action goes here",
-- BEGIN S6
+"            YY_DO_BEFORE_ACTION;",
+"            YY_USER_ACTION;",
+"",
+"            if Aflex_Debug then",
+"               --  output acceptance info. for (-d) debug mode",
+"",
+"               Ada.Wide_Wide_Text_IO.Put",
+"                 (Ada.Wide_Wide_Text_IO.Standard_Error,",
+"                  ""--accepting rule #"" );",
+"               Ada.Wide_Wide_Text_IO.Put",
+"                 (Ada.Wide_Wide_Text_IO.Standard_Error,",
+"                  Integer'Wide_Wide_Image (YY_Act));",
+"               Ada.Wide_Wide_Text_IO.Put_Line",
+"                 (Ada.Wide_Wide_Text_IO.Standard_Error,",
+"                  ""("""""" & yytext & """""")"");",
+"            end if;",
+"",
+"-- UMASS CODES :",
+"--   Update tok_begin_line, tok_end_line, tok_begin_col and tok_end_col",
+"--   after matching the token.",
+"        if yy_act /= YY_END_OF_BUFFER and then yy_act /= 0 then",
+"-- Token are matched only when yy_act is not yy_end_of_buffer or 0.",
+"          Tok_Begin_Line := Tok_End_Line;",
+"          Tok_Begin_Col := Tok_End_Col + 1;",
+"          Tok_End_Col := Tok_Begin_Col + yy_cp - yy_bp - 1;",
+"          if Current (yy_ch_buf, yy_bp) = Ada.Characters.Wide_Wide_Latin_1.LF then",
+"            Token_At_End_Of_Line := True;",
+"          end if;",
+"        end if;",
+"-- END OF UMASS CODES.",
+"",
+"<<do_action>>   -- this label is used only to access EOF actions",
+"            case yy_act is",
+"%% actions go here",
-- BEGIN S7
+"",
+"            when YY_END_OF_BUFFER =>",
+"               yytext_ptr := yy_bp;",
+"",
+"               case yy_get_next_buffer is",
+"                  when EOB_ACT_END_OF_FILE =>",
+"                     begin",
+"                        if yywrap then",
+"                           --  note: because we've taken care in",
+"                           --  yy_get_next_buffer() to have set up yytext,",
+"                           --  we can now set up yy_c_buf_p so that if some",
+"                           --  total hoser (like aflex itself) wants",
+"                           --  to call the scanner after we return the",
+"                           --  End_Of_Input, it'll still work - another",
+"                           --  End_Of_Input will get returned.",
+"",
+"                           yy_c_buf_p := yytext_ptr;",
+"                           yy_act := YY_STATE_EOF ((yy_start - 1) / 2);",
+"",
+"                           goto do_action;",
+"",
+"                        else",
+"                           --  start processing a new file",
+"",
+"                           yy_init := true;",
+"",
+"                           goto new_file;",
+"                        end if;",
+"                     end;",
+"",
+"                  when EOB_ACT_RESTART_SCAN =>",
+"                     yy_c_buf_p := yytext_ptr;",
+"",
+"                  when EOB_ACT_LAST_MATCH =>",
+"                     yy_c_buf_p := yy_n_chars;",
+"                     yy_current_state := yy_get_previous_state;",
+"",
+"                     yy_cp := yy_c_buf_p;",
+"                     yy_bp := yytext_ptr;",
+"",
+"                     goto next_action;",
+"               end case; -- case yy_get_next_buffer()",
+"",
+"            when others =>",
+"               Ada.Wide_Wide_Text_IO.Put (""action # "");",
+"               Ada.Wide_Wide_Text_IO.Put (Integer'Wide_Wide_Image (yy_act));",
+"               Ada.Wide_Wide_Text_IO.New_Line;",
+"",
+"               raise AFLEX_INTERNAL_ERROR;",
+"         end case; -- case (yy_act)",
+"      end loop; -- end of loop waiting for end of file",
+"   end YYLex;",
+"%%",
+"ERROR tried to output beyond end of skeleton file"
-- END OF SKELETON
);

  -- set_external_skeleton
  --
  -- DESCRIPTION
  -- sets flag so we know to use an external skelfile

  procedure SET_EXTERNAL_SKELETON is
  begin
    USE_EXTERNAL_SKELETON := TRUE;
  end SET_EXTERNAL_SKELETON;

   ------------------
   -- Get_Internal --
   ------------------

   procedure Get_Internal (Buffer : in out Unbounded_Wide_Wide_String) is
   begin
      Buffer := Skel_Template (Current_Line);
      Current_Line := Current_Line + 1;
   end Get_Internal;

   ------------------
   -- Get_External --
   ------------------

   procedure Get_External (Buffer : in out Unbounded_Wide_Wide_String) is
   begin
      Get_Line (Misc_Defs.SkelFile, Buffer);
   end Get_External;

  -- end_of_skeleton
  --
  -- DESCRIPTION
  -- returns true if there are no more lines left to output in the skeleton

  function END_OF_SKELETON return BOOLEAN is
  begin
    if (USE_EXTERNAL_SKELETON) then

      -- we're using an external skelfile
      return END_OF_FILE (MISC_DEFS.SKELFILE);
    else

      -- internal skeleton
      return CURRENT_LINE > SKEL_TEMPLATE'LAST;
    end if;
  end END_OF_SKELETON;

   -------------------
   -- Get_File_Line --
   -------------------

   procedure Get_File_Line (Buffer : in out Unbounded_Wide_Wide_String) is
   begin
      if Use_External_Skeleton then
         Get_External (Buffer);

      else
         Get_Internal (Buffer);
      end if;
   end Get_File_Line;

   --------------
   -- Skel_Out --
   --------------

   procedure Skel_Out is
-- UMASS CODES :
      Umass_Codes : Boolean := False;
      -- Indicates whether or not current line of the template
      -- is the Umass codes.
-- END OF UMASS CODES.
      Buf         : Unbounded_Wide_Wide_String;

   begin
      while not End_Of_Skeleton loop
         Get_File_Line (Buf);

         if Length (Buf) >= 2 and then Slice (Buf, 1, 2) = "%%" then
            exit;
         else
-- UMASS CODES :
--   In the template, the codes between "-- UMASS CODES : " and
--   "-- END OF UMASS CODES." are specific to be used by Ayacc
--   extension. Ayacc extension has more power in error recovery.
--   So we generate those codes only when Ayacc_Extension_Flag is True.
            if Buf = "-- UMASS CODES :" then
               Umass_Codes := True;
            end if;

            if not Umass_Codes
              or else Misc_Defs.Ayacc_Extension_Flag
            then
               Put_Line (Buf);
            end if;

            if Buf = "-- END OF UMASS CODES." then
               Umass_Codes := False;
            end if;
-- END OF UMASS CODES.

-- UCI CODES commented out :
--   The following line is commented out because it is done in Umass codes.
--      FILE_STRING.PUT_LINE(BUF);
         end if;
      end loop;
   end Skel_Out;

end Skeleton_Manager;
