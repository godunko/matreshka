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

-- TITLE scanner generation
-- AUTHOR: John Self (UCI)
-- DESCRIPTION
-- NOTES does actual generation (writing) of output aflex scanners
-- $Header: /dc/uc/self/arcadia/aflex/ada/src/RCS/genB.a,v 1.25 1992/10/02 23:08:41 self Exp self $

with Ada.Characters.Conversions;
with Ada.Integer_Wide_Wide_Text_IO;
with Ada.Strings.Unbounded;
with Ada.Strings.Wide_Wide_Unbounded.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Fixed;
with Ada.Wide_Wide_Text_IO;

with MISC_DEFS, MISC;
with Scanner, SKELETON_MANAGER, EXTERNAL_FILE_MANAGER;
use MISC_DEFS;
with Parser_Tokens; use Parser_Tokens;
with Unicode;

package body Gen is

   use Ada.Characters.Conversions;
   use Ada.Integer_Wide_Wide_Text_IO;
   use Ada.Strings;
   use Ada.Strings.Wide_Wide_Fixed;
   use Ada.Strings.Wide_Wide_Unbounded;
   use Ada.Strings.Wide_Wide_Unbounded.Wide_Wide_Text_IO;
   use Ada.Wide_Wide_Text_IO;
   use Unicode;

  INDENT_LEVEL : INTEGER := 0;  -- each level is 3 spaces

  MAX_SHORT    : constant INTEGER := 32767;
  procedure INDENT_UP is
  begin
    INDENT_LEVEL := INDENT_LEVEL + 1;
  end INDENT_UP;
  pragma INLINE(INDENT_UP);
  procedure INDENT_DOWN is
  begin
    INDENT_LEVEL := INDENT_LEVEL - 1;
  end INDENT_DOWN;
  pragma INLINE(INDENT_DOWN);

  procedure SET_INDENT(INDENT_VAL : in INTEGER) is
  begin
    INDENT_LEVEL := INDENT_VAL;
  end SET_INDENT;

   ---------------
   -- Do_Indent --
   ---------------

   --  Indent to the current level.

   procedure Do_Indent is
   begin
      Set_Col (Ada.Wide_Wide_Text_IO.Count (INDENT_LEVEL) * 3 + 1);
   end Do_Indent;

  -- generate the code to keep backtracking information

  procedure GEN_BACKTRACKING is
  begin
    if (NUM_BACKTRACKING = 0) then
      return;
    end if;

    INDENT_PUTS("if (yy_accept(yy_current_state) /= 0 ) then");
    INDENT_UP;
    INDENT_PUTS("yy_last_accepting_state := yy_current_state;");
    INDENT_PUTS("yy_last_accepting_cpos := yy_cp;");
    INDENT_DOWN;
    INDENT_PUTS("end if;");
  end GEN_BACKTRACKING;

  -- generate the code to perform the backtrack

  procedure GEN_BT_ACTION is
  begin
    if (NUM_BACKTRACKING = 0) then
      return;
    end if;

    SET_INDENT(4);

    INDENT_PUTS ("when 0 => -- must backtrack");
    INDENT_UP;

    if (FULLTBL) then
      INDENT_PUTS ("yy_cp := yy_last_accepting_cpos + 1;");
    else

      -- backtracking info for compressed tables is taken \after/
      -- yy_cp has been incremented for the next state
      INDENT_PUTS("yy_cp := yy_last_accepting_cpos;");
    end if;

    INDENT_PUTS("yy_current_state := yy_last_accepting_state;");
    NEW_LINE;
    INDENT_PUTS("goto next_action;");
    INDENT_DOWN;
    NEW_LINE;

    SET_INDENT(0);
  end GEN_BT_ACTION;

  -- generate equivalence-class table

   procedure GENECS is
      I         : INTEGER;
      NUMROWS   : INTEGER;
      Most_Used : Primary_Stage_Index := 0;

   begin

      --  Handle case insensitive mapping, converts values to positive range

      for J in 1 .. CSIZE loop
         if CASEINS
           and then (J >= CHARACTER'POS('A') and J <= CHARACTER'POS('Z'))
         then
            ECGROUP (J) := ECGROUP (MISC.CLOWER (J));
         end if;

         ECGROUP (J) := abs ECGROUP (J);
      end loop;

      --  Compact data using two stage table technique

      for J in ECGROUP_Use_Count'Range loop
         ECGROUP_Use_Count (J) := 0;
      end loop;

      for J in ECGROUP_Plane'Range loop
         for K in 0 .. J loop
            if ECGROUP (Integer (J) * 256 .. Integer (J) * 256 + 255) =
              ECGROUP (Integer (K) * 256 .. Integer (K) * 256 + 255)
            then
               ECGROUP_Plane (J) := K;
               ECGROUP_Use_Count (K) := ECGROUP_Use_Count (K) + 1;

               exit;
            end if;
         end loop;
      end loop;

      for J in ECGROUP_Use_Count'Range loop
         if ECGROUP_Use_Count (J) > ECGROUP_Use_Count (Most_Used) then
            Most_Used := J;
         end if;
      end loop;

      Put_Line ("type Secondary_Stage_Index is range 0 .. 16#FF#;");
      Put_Line ("type Primary_Stage_Index is range 0 .. 16#10FF#;");
      Put_Line
        ("type Secondary_Stage_Array is"
         & " array (Secondary_Stage_Index) of Short;");
      Put_Line
        ("type Secondary_Stage_Array_Access is"
         & " access constant Secondary_Stage_Array;");

      for J in ECGROUP_Plane'Range loop
         if ECGROUP_Plane (J) = J then
            Put_Line
              ("yy_ec_"
               & Trim (Primary_Stage_Index'Wide_Wide_Image (J), Both)
               & " : aliased constant Secondary_Stage_Array :=");
            Put_Line ("    (");

            for K in Secondary_Stage_Index'Range loop
               Misc.MKDATA (ECGROUP (Integer (J) * 256 + Integer (K)));
            end loop;

            Misc.DATAEND;
         end if;
      end loop;

      Put_Line ("yy_ec_base : constant");
      Put_Line ("  array (Primary_Stage_Index) of Secondary_Stage_Array_Access :=");

      for J in ECGROUP_Plane'Range loop
         if ECGROUP_Plane (J) /= Most_Used then
            if J = ECGROUP_Plane'First then
               Put ("   (");

            elsif J mod 3 = 0 then
               Put_Line (",");
               Put ("    ");

            else
               Put (", ");
            end if;

            Put (Integer (J), 6);
            Put
              (" => yy_ec_"
               & Trim
                 (Primary_Stage_Index'Wide_Wide_Image
                    (ECGROUP_Plane (J)), Both)
               & "'Access");
         end if;
      end loop;

      Put_Line
        (", others => yy_ec_"
         & Trim (Primary_Stage_Index'Wide_Wide_Image (Most_Used), Both)
         & "'Access);");

      --  Generate function to replace yy_ec constant without modification of
      --  all code around.

      New_Line;
      Put_Line ("function yy_ec (Item : Wide_Wide_Character) return short is");
      Put_Line ("   Code   : constant Integer := Wide_Wide_Character'Pos (Item);");
      Put_Line ("   Group  : constant Primary_Stage_Index :=");
      Put_Line ("     Primary_Stage_Index (Code / 256);");
      Put_Line ("   Offset : constant Secondary_Stage_Index :=");
      Put_Line ("     Secondary_Stage_Index (Code mod 256);");
      New_Line;
      Put_Line ("begin");
      Put_Line ("   return yy_ec_base (Group) (Offset);");
      Put_Line ("end yy_ec;");

      --  XXX It can be useful to output pack infomation

      if TRACE then
         NEW_LINE(STANDARD_ERROR);
         NEW_LINE(STANDARD_ERROR);
         PUT(STANDARD_ERROR, "Equivalence Classes:");
         NEW_LINE(STANDARD_ERROR);
         NEW_LINE(STANDARD_ERROR);
         NUMROWS := (CSIZE + 1)/8;

         for J in 1 .. NUMROWS loop
            I := J;

            while (I <= CSIZE) loop
               PUT
                 (STANDARD_ERROR,
                  To_Wide_Wide_String
                    (Ada.Strings.Unbounded.To_String
                       (MISC.Readable_Form(Wide_Wide_Character'Val (I)))));
               PUT(STANDARD_ERROR, " = ");
               PUT(STANDARD_ERROR, ECGROUP(I), 1);
               PUT(STANDARD_ERROR, "   ");
               I := I + NUMROWS;
            end loop;

            NEW_LINE(STANDARD_ERROR);
         end loop;
      end if;
   end GENECS;

  -- generate the code to find the action number

  procedure GEN_FIND_ACTION is
  begin
    INDENT_PUTS("yy_act := yy_accept(yy_current_state);");
  end GEN_FIND_ACTION;

  -- genftbl - generates full transition table

  procedure GENFTBL is
    END_OF_BUFFER_ACTION : constant INTEGER := NUM_RULES + 1;
    -- *everything* is done in terms of arrays starting at 1, so provide
    -- a null entry for the zero element of all C arrays
  begin
    PUT("yy_accept : constant array(0..");
    PUT(LASTDFA, 1);
    PUT_LINE(") of short :=");
    PUT_LINE("    (   0,");

    DFAACC(END_OF_BUFFER_STATE).DFAACC_STATE := END_OF_BUFFER_ACTION;

    for I in 1 .. LASTDFA loop
      declare
        ANUM : constant INTEGER := DFAACC(I).DFAACC_STATE;
      begin
        MISC.MKDATA(ANUM);

        if (TRACE and (ANUM /= 0)) then
          PUT(STANDARD_ERROR, "state # ");
          PUT(STANDARD_ERROR, I, 1);
          PUT(STANDARD_ERROR, " accepts: [");
          PUT(STANDARD_ERROR, ANUM, 1);
          PUT(STANDARD_ERROR, "]");
          NEW_LINE(STANDARD_ERROR);
        end if;
      end;
    end loop;

    MISC.DATAEND;

    if (USEECS) then
      GENECS;
    end if;

  -- don't have to dump the actual full table entries - they were created
  -- on-the-fly
  end GENFTBL;

  -- generate the code to find the next compressed-table state

  procedure GEN_NEXT_COMPRESSED_STATE is
  begin
    Indent_Puts ("Index := yy_cp;");
    Indent_Puts ("Next (yy_ch_buf, Index, Code);");

    if USEECS then
      INDENT_PUTS("yy_c := yy_ec(Code);");
    else
      INDENT_PUTS("yy_c := Code;");
    end if;
--    if (USEECS) then
--      INDENT_PUTS("yy_c := yy_ec(Current (yy_ch_buf, yy_cp));");
--    else
--      INDENT_PUTS("yy_c := Current (yy_ch_buf, yy_cp);");
--    end if;

    -- save the backtracking info \before/ computing the next state
    -- because we always compute one more state than needed - we
    -- always proceed until we reach a jam state
    GEN_BACKTRACKING;

    INDENT_PUTS(
      "while ( yy_chk(yy_base(yy_current_state) + yy_c) /= yy_current_state ) loop"
      );
    INDENT_UP;
    INDENT_PUTS("yy_current_state := yy_def(yy_current_state);");

    if (USEMECS) then

      -- we've arrange it so that templates are never chained
      -- to one another.  This means we can afford make a
      -- very simple test to see if we need to convert to
      -- yy_c's meta-equivalence class without worrying
      -- about erroneously looking up the meta-equivalence
      -- class twice
      Do_Indent;

      -- lastdfa + 2 is the beginning of the templates
      Put_Line ("if yy_current_state >= YY_FIRST_TEMPLATE then");

      INDENT_UP;
      INDENT_PUTS("yy_c := yy_meta(yy_c);");
      INDENT_DOWN;
      INDENT_PUTS("end if;");
    end if;

    INDENT_DOWN;
    INDENT_PUTS("end loop;");

    INDENT_PUTS("yy_current_state := yy_nxt(yy_base(yy_current_state) + yy_c);")
      ;
    INDENT_DOWN;
  end GEN_NEXT_COMPRESSED_STATE;

  -- generate the code to find the next match

  procedure GEN_NEXT_MATCH is
  -- note - changes in here should be reflected in get_next_state
  begin
    if (FULLTBL) then

      INDENT_PUTS(
        "yy_current_state := yy_nxt(yy_current_state, Current (yy_ch_buf, yy_cp)));");
      INDENT_PUTS("while ( yy_current_state > 0 ) loop");
      INDENT_UP;
      INDENT_PUTS("yy_cp := Index;");
      INDENT_PUTS(
        "yy_current_state := yy_nxt(yy_current_state, Current (yy_ch_buf, yy_cp));");
      INDENT_DOWN;
      INDENT_PUTS("end loop;");
      INDENT_PUTS("yy_current_state := -yy_current_state;");

      if (NUM_BACKTRACKING > 0) then
        GEN_BACKTRACKING;
      end if;

      NEW_LINE;
    else

      -- compressed
      INDENT_PUTS("loop");

      INDENT_UP;

      GEN_NEXT_STATE;

      INDENT_PUTS("yy_cp := Index;");

      if (INTERACTIVE) then
        Put_Line ("   exit when yy_base (yy_current_state) = YY_JAMBASE;");
      else
        Put_Line ("   exit when yy_current_state = YY_JAMSTATE;");
      end if;

      INDENT_DOWN;

      Do_Indent;

      PUT_LINE("end loop;");

      if (not INTERACTIVE) then
        INDENT_PUTS("yy_cp            := yy_last_accepting_cpos;");
        INDENT_PUTS("yy_current_state := yy_last_accepting_state;");
      end if;
    end if;
  end GEN_NEXT_MATCH;

  -- generate the code to find the next state

  procedure GEN_NEXT_STATE is
  -- note - changes in here should be reflected in get_next_match
  begin
    INDENT_UP;
    if (FULLTBL) then
      INDENT_PUTS("yy_current_state := yy_nxt(yy_current_state,");
      INDENT_PUTS("                           Current (yy_ch_buf, yy_cp));");
      GEN_BACKTRACKING;
    else
      GEN_NEXT_COMPRESSED_STATE;
    end if;
  end GEN_NEXT_STATE;

  -- generate the code to find the start state

  procedure GEN_START_STATE is
  begin
    INDENT_PUTS("yy_current_state := yy_start;");

    if (BOL_NEEDED) then
      INDENT_PUTS("if Previous (yy_ch_buf, yy_bp) = Ada.Characters.Wide_Wide_Latin_1.LF then");
      INDENT_UP;
      INDENT_PUTS("yy_current_state := yy_current_state + 1;");
      INDENT_DOWN;
      INDENT_PUTS("end if;");
    end if;

  end GEN_START_STATE;

  -- gentabs - generate data statements for the transition tables

  procedure GENTABS is
    I, K, TOTAL_STATES   : INTEGER;
    ACC_ARRAY            : INT_PTR;
    END_OF_BUFFER_ACTION : constant INTEGER := NUM_RULES + 1;
    -- *everything* is done in terms of arrays starting at 1, so provide
    -- a null entry for the zero element of all C arrays

  begin
    ACC_ARRAY := ALLOCATE_INTEGER_ARRAY(CURRENT_MAX_DFAS);
    NUMMT := 0;

    -- the compressed table format jams by entering the "jam state",
    -- losing information about the previous state in the process.
    -- In order to recover the previous state, we effectively need
    -- to keep backtracking information.
    NUM_BACKTRACKING := NUM_BACKTRACKING + 1;

    DFAACC(END_OF_BUFFER_STATE).DFAACC_STATE := END_OF_BUFFER_ACTION;

    for CNT in 1 .. LASTDFA loop
      ACC_ARRAY(CNT) := DFAACC(CNT).DFAACC_STATE;
    end loop;


    ACC_ARRAY(LASTDFA + 1) := 0;

    -- add accepting number for the jam state

    -- spit out ALIST array, dumping the accepting numbers.

    -- "lastdfa + 2" is the size of ALIST; includes room for arrays
    -- beginning at 0 and for "jam" state
    K := LASTDFA + 2;

    PUT("yy_accept : constant array(0..");
    PUT(K - 1, 1);
    PUT_LINE(") of short :=");
    PUT_LINE("    (   0,");
    for CNT in 1 .. LASTDFA loop
      MISC.MKDATA(ACC_ARRAY(CNT));

      if (TRACE and (ACC_ARRAY(CNT) /= 0)) then
        PUT(STANDARD_ERROR, "state # ");
        PUT(STANDARD_ERROR, CNT, 1);
        PUT(STANDARD_ERROR, " accepts: [");
        PUT(STANDARD_ERROR, ACC_ARRAY(CNT), 1);
        PUT(STANDARD_ERROR, ']');
        NEW_LINE(STANDARD_ERROR);
      end if;
    end loop;

    -- add entry for "jam" state
    MISC.MKDATA(ACC_ARRAY(LASTDFA + 1));

    MISC.DATAEND;

    if (USEECS) then
      GENECS;
    end if;

    if (USEMECS) then

      -- write out meta-equivalence classes (used to index templates with)
      if (TRACE) then
        NEW_LINE(STANDARD_ERROR);
        NEW_LINE(STANDARD_ERROR);
        PUT_LINE(STANDARD_ERROR, "Meta-Equivalence Classes:");
      end if;

      PUT("yy_meta : constant array(0..");
      PUT(NUMECS, 1);
      PUT_LINE(") of short :=");
      PUT_LINE("    (   0,");
      for CNT in 1 .. NUMECS loop
        if (TRACE) then
          PUT(STANDARD_ERROR, CNT, 1);
          PUT(STANDARD_ERROR, " = ");
          PUT(STANDARD_ERROR, abs(TECBCK(CNT)), 1);
          NEW_LINE(STANDARD_ERROR);
        end if;
        MISC.MKDATA(abs(TECBCK(CNT)));
      end loop;

      MISC.DATAEND;
    end if;

    TOTAL_STATES := LASTDFA + NUMTEMPS;

    PUT("yy_base : constant array(0..");
    PUT(TOTAL_STATES, 1);
    if (TBLEND > MAX_SHORT) then
      PUT_LINE(") of integer :=");
    else
      PUT_LINE(") of short :=");
    end if;
    PUT_LINE("    (   0,");

    for CNT in 1 .. LASTDFA loop
      declare
        D : constant INTEGER := DEF(CNT);
      begin
        if (BASE(CNT) = JAMSTATE_CONST) then
          BASE(CNT) := JAMBASE;
        end if;

        if (D = JAMSTATE_CONST) then
          DEF(CNT) := JAMSTATE;
        else
          if (D < 0) then

            -- template reference
            TMPUSES := TMPUSES + 1;
            DEF(CNT) := LASTDFA - D + 1;
          end if;
        end if;
        MISC.MKDATA(BASE(CNT));
      end;
    end loop;

    -- generate jam state's base index
    I := LASTDFA + 1;
    MISC.MKDATA(BASE(I));

    -- skip jam state
    I := I + 1;

    for CNT in I .. TOTAL_STATES loop
      MISC.MKDATA(BASE(CNT));
      DEF(CNT) := JAMSTATE;
    end loop;

    MISC.DATAEND;

    PUT("yy_def : constant array(0..");
    PUT(TOTAL_STATES, 1);
    if (TBLEND > MAX_SHORT) then
      PUT_LINE(") of integer :=");
    else
      PUT_LINE(") of short :=");
    end if;
    PUT_LINE("    (   0,");

    for CNT in 1 .. TOTAL_STATES loop
      MISC.MKDATA(DEF(CNT));
    end loop;

    MISC.DATAEND;
    PUT("yy_nxt : constant array(0..");
    PUT(TBLEND, 1);
    if (LASTDFA > MAX_SHORT) then
      PUT_LINE(") of integer :=");
    else
      PUT_LINE(") of short :=");
    end if;
    PUT_LINE("    (   0,");

    for CNT in 1 .. TBLEND loop
      if ((NXT(CNT) = 0) or (CHK(CNT) = 0)) then
        NXT(CNT) := JAMSTATE;

      -- new state is the JAM state
      end if;
      MISC.MKDATA(NXT(CNT));
    end loop;

    MISC.DATAEND;

    PUT("yy_chk : constant array(0..");
    PUT(TBLEND, 1);
    if (LASTDFA > MAX_SHORT) then
      PUT_LINE(") of integer :=");
    else
      PUT_LINE(") of short :=");
    end if;
    PUT_LINE("    (   0,");

    for CNT in 1 .. TBLEND loop
      if (CHK(CNT) = 0) then
        NUMMT := NUMMT + 1;
      end if;

      MISC.MKDATA(CHK(CNT));
    end loop;

    MISC.DATAEND;
  exception
    when STORAGE_ERROR =>
      Misc.Aflex_Fatal ("dynamic memory failure in gentabs()");
  end GENTABS;

   -----------------
   -- INDENT_PUTS --
   -----------------

   -- write out a string at the current indentation level, adding a final
   -- newline

   procedure INDENT_PUTS(STR : Wide_Wide_String) is
   begin
      Do_Indent;
      PUT_LINE (STR);
   end INDENT_PUTS;

   -- do_sect3_out - dumps section 3.

   procedure DO_SECT3_OUT is
      GARBAGE : TOKEN;
      pragma Unreferenced (GARBAGE);

   begin
      Scanner.CALL_YYLEX := TRUE;
      GARBAGE := Scanner.YYLex;
   end DO_SECT3_OUT;

  -- make_tables - generate transition tables
  --
  --
  -- Generates transition tables and finishes generating output file

   -----------------
   -- Body_Header --
   -----------------

   procedure Body_Header is
      Output_Body_File : File_Type;

   begin
      Put_Line ("package " & Misc.Basename & " is");

      DO_SECT3_OUT;

      Put_Line ("end " & Misc.Basename & ";");

      External_File_Manager.Get_Scanner_Body_File (Output_Body_File);
      Skeleton_Manager.Skel_Out;

      DO_SECT3_OUT;

      Put ("with " & Misc.Basename & ".DFA; ");
      Put_Line ("use " & Misc.Basename & ".DFA;");
      Put ("with " & Misc.Basename & ".IO; ");
      Put_Line ("use " & Misc.Basename & ".IO;");
      Put_Line ("package body " & Misc.Basename & " is");

      DO_SECT3_OUT;
   end Body_Header;

  procedure MAKE_TABLES is
    DID_EOF_RULE : BOOLEAN := FALSE;
    BUF          : Unbounded_Wide_Wide_String;

  begin
    if (not FULLTBL) then

      -- if we used full tables this is already output
      DO_SECT3_OUT;

      BODY_HEADER;

      -- intent of this call is to get everything up to ##
      SKELETON_MANAGER.SKEL_OUT;

    -- output YYLex code up to part about tables.
    end if;

    PUT("      YY_END_OF_BUFFER : constant := ");
    PUT(NUM_RULES + 1, 1);
    PUT_LINE(";");

    if INTERACTIVE then
       Put ("      YY_JAMBASE : constant := ");
       Put (JAMBASE, 1);
       Put_Line (";");

    else
       Put ("      YY_JAMSTATE : constant := ");
       Put (JAMSTATE, 1);
       Put_Line (";");
    end if;

    --  lastdfa + 2 is the beginning of the templates
    Put ("      YY_FIRST_TEMPLATE : constant := ");
    Put (LASTDFA + 2, 1);
    Put_Line (";");

    INDENT_PUTS("YY_Current_State : YY_State_Type;");

    -- now output the constants for the various start conditions
    RESET (DEF_FILE, IN_FILE);

    while not END_OF_FILE(DEF_FILE) loop
      GET_LINE (DEF_FILE, BUF);
      PUT_LINE (BUF);
    end loop;

    if (FULLTBL) then
      GENFTBL;
    else
      GENTABS;
    end if;

    RESET (TEMP_ACTION_FILE, IN_FILE);

    -- generate code for yy_get_previous_state
    SET_INDENT(1);
    SKELETON_MANAGER.SKEL_OUT;

    if (BOL_NEEDED) then
      INDENT_PUTS("yy_bp : integer := yytext_ptr;");
    end if;
    SKELETON_MANAGER.SKEL_OUT;

    GEN_START_STATE;
    SKELETON_MANAGER.SKEL_OUT;
    GEN_NEXT_STATE;
    SKELETON_MANAGER.SKEL_OUT;

    SET_INDENT(2);

    INDENT_PUTS("yy_bp := yy_cp;");

    GEN_START_STATE;
    GEN_NEXT_MATCH;

    SKELETON_MANAGER.SKEL_OUT;

    SET_INDENT(3);
    GEN_FIND_ACTION;

    SET_INDENT(1);
    SKELETON_MANAGER.SKEL_OUT;

    INDENT_UP;
    GEN_BT_ACTION;

    MISC.ACTION_OUT;
    MISC.ACTION_OUT;

      --  Generate cases for any missing EOF rules.

      SET_INDENT (4);

      for I in 1 .. LASTSC loop
         if not SCEOF (I) then
            Do_Indent;

            if not DID_EOF_RULE then
               PUT ("when ");

            else
               PUT ("  | ");
            end if;

            PUT ("YY_END_OF_BUFFER + ");
            PUT (SCNAME (I));
            PUT (" + 1 ");
            DID_EOF_RULE := TRUE;
         end if;
      end loop;

      if DID_EOF_RULE then
         Do_Indent;
         Put_Line ("=>");
      end if;

      if DID_EOF_RULE then
         INDENT_UP;
         INDENT_PUTS("return End_Of_Input;");
         INDENT_DOWN;
      end if;

    SKELETON_MANAGER.SKEL_OUT;

    -- copy remainder of input to output
    MISC.LINE_DIRECTIVE_OUT;
    DO_SECT3_OUT;

  -- copy remainder of input, after ##, to the scanner file.
  end MAKE_TABLES;

end GEN;
