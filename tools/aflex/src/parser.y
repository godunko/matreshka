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

-- TITLE parser for aflex
-- AUTHOR: John Self (UCI)
-- DESCRIPTION lalr(1) grammar for input to AYACC.
-- NOTES
-- $Header: /co/ua/self/arcadia/aflex/ada/src/RCS/parse.y,v 1.15 90/01/17 15:49:56 self Exp Locker: self $

%token CHAR NUMBER SECTEND SCDECL XSCDECL WHITESPACE NAME PREVCCL EOF_OP
%token NEWLINE PROP

{
  subtype YYSType is Integer;
}

%%
goal            :  initlex sect1 sect1end sect2 initforrule
			{ -- add default rule

			pat := ccl.cclinit;
			ccl.cclnegate( pat );

			def_rule := nfa.mkstate( -pat );

			nfa.finish_rule( def_rule, false, 0, 0 );

			for i in 1 .. lastsc loop
			    scset(i) := nfa.mkbranch( scset(i), def_rule );
			end loop;

			if ( spprdflt ) then
			    Put
                             (Temp_Action_File, "raise AFLEX_SCANNER_JAMMED;");
			else
			    Put (Temp_Action_File, "ECHO");

                            Put_Line (Temp_Action_File, ";");
			end if;
			}
		;

initlex         :
			{
			-- initialize for processing rules

       			-- create default DFA start condition
			sym.scinstal (+"INITIAL", False);
			}
		;

sect1		:  sect1 startconddecl WHITESPACE namelist1 NEWLINE
		|
		|  error NEWLINE
			{ misc.synerr( "unknown error processing section 1" );}
		;

sect1end	:  SECTEND
		;

startconddecl   :  SCDECL
			{
			 -- these productions are separate from the s1object
			 -- rule because the semantics must be done before
			 -- we parse the remainder of an s1object


			xcluflg := false;
			}

		|  XSCDECL
			{ xcluflg := true; }
		;

namelist1	:  namelist1 WHITESPACE NAME
			{ sym.scinstal (nmstr, xcluflg); }

		|  NAME
			{ sym.scinstal (nmstr, xcluflg); }

		|  error
                        { misc.synerr( "bad start condition list" ); }
		;

sect2           :  sect2 initforrule aflexrule NEWLINE
		|
		;

initforrule     :
			{
			-- initialize for a parse of one rule
			trlcontxt := false;
			variable_trail_rule := false;
			varlength := false;
			trailcnt := 0;
			headcnt := 0;
			rulelen := 0;
			current_state_enum := STATE_NORMAL;
			previous_continued_action := continued_action;
			nfa.new_rule;
			}
		;

aflexrule        :  scon '^' re eol
                        {
			pat := nfa.link_machines( $3, $4 );
			nfa.finish_rule( pat, variable_trail_rule,
				     headcnt, trailcnt );

			for i in 1 .. actvp loop
			    scbol(actvsc(i)) :=
				nfa.mkbranch( scbol(actvsc(i)), pat );
			end loop;

			if ( not bol_needed ) then
			    bol_needed := true;

			    if ( performance_report ) then
				Put (Standard_Error,
			"'^' operator results in sub-optimal performance");
			        New_Line (Standard_Error);
    	    	    	    end if;
			end if;
			}

		|  scon re eol
                        {
			pat := nfa.link_machines( $2, $3 );
			nfa.finish_rule( pat, variable_trail_rule,
				     headcnt, trailcnt );

			for i in 1 .. actvp loop
			    scset(actvsc(i)) :=
				nfa.mkbranch( scset(actvsc(i)), pat );
			end loop;
		        }
                |  '^' re eol
			{
			pat := nfa.link_machines( $2, $3 );
			nfa.finish_rule( pat, variable_trail_rule,
				     headcnt, trailcnt );

			-- add to all non-exclusive start conditions,
			-- including the default (0) start condition

			for i in 1 .. lastsc loop
			    if ( not scxclu(i) ) then
				scbol(i) := nfa.mkbranch( scbol(i), pat );
			    end if;
			end loop;

			if ( not bol_needed ) then
			    bol_needed := true;

			    if ( performance_report ) then
				Put (Standard_Error,
			"'^' operator results in sub-optimal performance");
			        New_Line (Standard_Error);
			    end if;
			end if;
    	    	    	}
                |  re eol
			{
			pat := nfa.link_machines( $1, $2 );
			nfa.finish_rule( pat, variable_trail_rule,
				     headcnt, trailcnt );

			for i in 1 .. lastsc loop
			    if ( not scxclu(i) ) then
				scset(i) := nfa.mkbranch( scset(i), pat );
			    end if;
			end loop;
			}

                |  scon EOF_OP
			{ Build_EOF_Action; }

                |  EOF_OP
			{
                  -- this EOF applies only to the INITIAL start cond.
                  actvp := 1;
                  actvsc(actvp) := 1;
                  Build_EOF_Action;
			}

                |  error
			{ misc.synerr( "unrecognized rule" ); }
		;

scon            :  '<' namelist2 '>'
		;

namelist2       :  namelist2 ',' NAME
                        {
			scnum := sym.sclookup (nmstr);
			if (scnum = 0 ) then
		            Put
                             (Standard_Error, "undeclared start condition ");
		            Put (Standard_Error, nmstr);
			    Main_Body.Aflex_End (1);

			else
			  actvp := actvp + 1;
			    actvsc(actvp) := scnum;
			end if;
			}

		|  NAME
			{
			scnum := sym.sclookup (nmstr);
			if (scnum = 0 ) then
		            Put
                             (Standard_Error, "undeclared start condition ");
		            Put (Standard_Error, nmstr);
			    Main_Body.Aflex_End (1);

			else
			    actvp := 1;
			    actvsc(actvp) := scnum;
			end if;
			}

		|  error
			{ misc.synerr( "bad start condition list" ); }
		;

eol             :  '$'
                        {
			if trlcontxt then
			    misc.synerr( "trailing context used twice" );
			    $$ := nfa.mkstate( SYM_EPSILON );
			else
			    trlcontxt := true;

			    if ( not varlength ) then
				headcnt := rulelen;
			    end if;

			    rulelen := rulelen + 1;
			    trailcnt := 1;

			    eps := nfa.mkstate( SYM_EPSILON );
			    $$ := nfa.link_machines( eps,
					  nfa.mkstate( CHARACTER'POS(ASCII.LF) ) );
    	    	    	end if;
			}

		|
		        {
		        $$ := nfa.mkstate( SYM_EPSILON );

			if ( trlcontxt ) then
			    if ( varlength and (headcnt = 0) ) then
				-- both head and trail are variable-length
				variable_trail_rule := true;
			    else
				trailcnt := rulelen;
			    end if;
    	    	    	end if;
		        }
		;

re              :  re '|' series
                        {
			varlength := true;

			$$ := nfa.mkor( $1, $3 );
			}

		|  re2 series
			{
			if ( transchar(lastst($2)) /= SYM_EPSILON ) then
			    -- provide final transition \now/ so it
			    -- will be marked as a trailing context
			    -- state

			    $2 := nfa.link_machines( $2, nfa.mkstate( SYM_EPSILON ) );
			end if;

			nfa.mark_beginning_as_normal( $2 );
			current_state_enum := STATE_NORMAL;

			if ( previous_continued_action ) then
			    -- we need to treat this as variable trailing
			    -- context so that the backup does not happen
			    -- in the action but before the action switch
			    -- statement.  If the backup happens in the
			    -- action, then the rules "falling into" this
			    -- one's action will *also* do the backup,
			    -- erroneously.

			    	if ( (not varlength) or  headcnt /= 0 ) then
				     Put (Standard_Error,
                              "aflex: warning - trailing context rule at line");
                                     Put (Standard_Error, Linenum);
				     Put (Standard_Error,
                           "made variable because of preceding '|' action" );
                                     Put (Standard_Error, Linenum);
    	    	    	    	end if;

			    -- mark as variable
			    varlength := true;
			    headcnt := 0;
    	    	    	end if;

			if ( varlength and (headcnt = 0) ) then
			    -- variable trailing context rule
			    -- mark the first part of the rule as the accepting
			    -- "head" part of a trailing context rule

			    -- by the way, we didn't do this at the beginning
			    -- of this production because back then
			    -- current_state_enum was set up for a trail
			    -- rule, and add_accept() can create a new
			    -- state ...

			    nfa.add_accept( $1,
    	    	    	    	   misc.set_yy_trailing_head_mask(num_rules) );
    	    	    	end if;

			$$ := nfa.link_machines( $1, $2 );
			}

		|  series
			{ $$ := $1; }
		;


re2		:  re '/'
			{
			-- this rule is separate from the others for "re" so
			-- that the reduction will occur before the trailing
			-- series is parsed

			if ( trlcontxt ) then
			    misc.synerr( "trailing context used twice" );
			else
			    trlcontxt := true;
			end if;

			if ( varlength ) then
			    -- we hope the trailing context is fixed-length
			    varlength := false;
			else
			    headcnt := rulelen;
			end if;

			rulelen := 0;

			current_state_enum := STATE_TRAILING_CONTEXT;
			$$ := $1;
			}
		;

series          :  series singleton
                        {
			-- this is where concatenation of adjacent patterns
			-- gets done

			$$ := nfa.link_machines( $1, $2 );
			}

		|  singleton
			{ $$ := $1; }
		;

singleton       :  singleton '*'
                        {
			varlength := true;

			$$ := nfa.mkclos( $1 );
			}

		|  singleton '+'
			{
			varlength := true;

			$$ := nfa.mkposcl( $1 );
			}

		|  singleton '?'
			{
			varlength := true;

			$$ := nfa.mkopt( $1 );
			}

		|  singleton '{' NUMBER ',' NUMBER '}'
			{
			varlength := true;

			if ( ($3 > $5) or ($3 < 0) ) then
			    misc.synerr( "bad iteration values" );
			    $$ := $1;
			else
			    if ( $3 = 0 ) then
				$$ := nfa.mkopt( nfa.mkrep( $1, $3, $5 ) );
			    else
				$$ := nfa.mkrep( $1, $3, $5 );
			    end if;
    	    	    	end if;
			}

		|  singleton '{' NUMBER ',' '}'
			{
			varlength := true;

			if ( $3 <= 0 ) then
			    misc.synerr( "iteration value must be positive" );
			    $$ := $1;
			else
			    $$ := nfa.mkrep( $1, $3, INFINITY );
			end if;
			}

		|  singleton '{' NUMBER '}'
			{
			-- the singleton could be something like "(foo)",
			-- in which case we have no idea what its length
			-- is, so we punt here.

			varlength := true;

			if ( $3 <= 0 ) then
			    misc.synerr( "iteration value must be positive" );
			    $$ := $1;
			else
			    $$ := nfa.link_machines( $1, nfa.copysingl( $1, $3 - 1 ) );
			end if;
			}

		|  '.'
			{
			if ( not madeany ) then
			    -- create the '.' character class
			    anyccl := ccl.cclinit;
			    ccl.ccl_add( anyccl, Unicode.LF );
			    ccl.cclnegate( anyccl );

			    if ( useecs ) then
				ecs.mkeccl(
		       ccltbl(cclmap(anyccl)..cclmap(anyccl) + ccllen(anyccl)),
					ccllen(anyccl), nextecm,
					ecgroup, CSIZE );
			    end if;
			    madeany := true;
    	    	    	end if;

			rulelen := rulelen + 1;

			$$ := nfa.mkstate( -anyccl );
			}

		|  fullccl
			{
			if ( not cclsorted ) then
			    -- sort characters for fast searching.  We use a
			    -- shell sort since this list could be large.

--			    misc.cshell( ccltbl + cclmap($1), ccllen($1) );
		      misc.cshell( ccltbl(cclmap($1)..cclmap($1) + ccllen($1)),
				   ccllen($1) );
			end if;

			if ( useecs ) then
		    ecs.mkeccl( ccltbl(cclmap($1)..cclmap($1) + ccllen($1)),
				ccllen($1),nextecm, ecgroup, CSIZE );
			end if;

			rulelen := rulelen + 1;

			$$ := nfa.mkstate( -$1 );
			}

		|  PREVCCL
			{
			rulelen := rulelen + 1;

			$$ := nfa.mkstate( -$1 );
			}

		|  '"' string '"'
			{ $$ := $2; }

		|  '(' re ')'
			{ $$ := $2; }

		|  CHAR
			{
			rulelen := rulelen + 1;

			if ( $1 = CHARACTER'POS(ASCII.NUL) ) then
			    misc.synerr( "null in rule" );
			end if;

			if ( caseins and ($1 >= CHARACTER'POS('A')) and ($1 <= CHARACTER'POS('Z')) ) then
			    $1 := misc.clower( $1 );
			end if;

			$$ := nfa.mkstate( $1 );
			}
                |  PROP
			{
			rulelen := rulelen + 1;

			declare
			   P : Matreshka.Internals.Unicode.Ucd.Boolean_Properties :=
			     Matreshka.Internals.Unicode.Ucd.Boolean_Properties'Val ((abs $1) - 1);
			   N : Boolean := $1 < 0;

			begin
                           if N then
                              $$ := Boolean_NCCL (P);

                           else
                              $$ := Boolean_CCL (P);
                           end if;

                           if $$ = 0 then
			      cclsorted := true;
			      lastchar := 0;
			      $$ := ccl.cclinit;

			      for J in Unicode_Character'Range loop
                                 if Element (Matreshka.Internals.Unicode.Ucd.Core.Property, Unicode_Character'Pos (J)).B (P) then
			            ccl.ccl_add ($$, J);
			            lastchar := Unicode_Character'Pos (J);
			         end if;
			      end loop;

			      if ( useecs ) then
			          ecs.mkeccl( ccltbl(cclmap($$)..cclmap($$) + ccllen($$)),
				      ccllen($$),nextecm, ecgroup, CSIZE );
			      end if;

			      if N then
			         ccl.cclnegate( $$ );
			         Boolean_NCCL (P) := $$;

			      else
			         Boolean_CCL (P) := $$;
			      end if;
			   end if;

			   $$ := nfa.mkstate( -$$ );
			end;
			}
		;

fullccl		:  '[' ccl ']'
			{ $$ := $2; }

		|  '[' '^' ccl ']'
			{
			-- *Sigh* - to be compatible Unix lex, negated ccls
			-- match newlines
			ccl.cclnegate( $3 );
			$$ := $3;
			}
		;

ccl             :  ccl CHAR '-' CHAR
                        {
			if ( $2 > $4 ) then
			    misc.synerr( "negative range in character class" );
			else
			    if ( caseins ) then
				if ( ($2 >= CHARACTER'POS('A')) and ($2 <= CHARACTER'POS('Z')) ) then
				    $2 := misc.clower( $2 );
				end if;
				if ( ($4 >= CHARACTER'POS('A')) and ($4 <= CHARACTER'POS('Z')) ) then
				    $4 := misc.clower( $4 );
				end if;
    	    	    	    end if;

			    for J in $2 .. $4 loop
			        ccl.ccl_add ($1, Unicode_Character'Val (J));
    	    	    	    end loop;

			    -- keep track if this ccl is staying in
			    -- alphabetical order

			    cclsorted := cclsorted and ($2 > lastchar);
			    lastchar := $4;
    	    	    	end if;

			$$ := $1;
			}

		|  ccl CHAR
		        {
			if ( caseins ) then
			    if ( ($2 >= CHARACTER'POS('A')) and ($2 <= CHARACTER'POS('Z')) ) then
				$2 := misc.clower( $2 );
    	    	    	    end if;
			end if;
			ccl.ccl_add ($1, Unicode_Character'Val ($2));
			cclsorted := cclsorted and ($2 > lastchar);
			lastchar := $2;
			$$ := $1;
			}
                |  ccl PROP
			{
			declare
			   P : Matreshka.Internals.Unicode.Ucd.Boolean_Properties :=
			     Matreshka.Internals.Unicode.Ucd.Boolean_Properties'Val ((abs $2) - 1);
			   N : Boolean := $2 < 0;

			begin
			   cclsorted := false;
			   lastchar := 0;

			   for J in Unicode_Character'Range loop
                              if N xor Element (Matreshka.Internals.Unicode.Ucd.Core.Property, Unicode_Character'Pos (J)).B (P) then
			         ccl.ccl_add ($1, J);
			      end if;
			   end loop;

			   $$ := $1;
			end;
			}

		|
			{
			cclsorted := true;
			lastchar := 0;
			$$ := ccl.cclinit;
			}
		;

string		:  string CHAR
                        {
			if ( caseins ) then
			    if ( ($2 >= CHARACTER'POS('A')) and ($2 <= CHARACTER'POS('Z')) ) then
				$2 := misc.clower( $2 );
			    end if;
			end if;

			rulelen := rulelen + 1;

			$$ := nfa.link_machines( $1, nfa.mkstate( $2 ) );
			}

		|
			{ $$ := nfa.mkstate( SYM_EPSILON ); }
		;

%%
##
  procedure build_eof_action;
  procedure yyerror(msg: string);
  procedure YYParse;
  def_rule:integer;
##
with Ada.Integer_Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded.Wide_Wide_Text_IO;
with Ada.Wide_Wide_Text_IO;

with Scanner;
with NFA, ccl, misc, misc_defs, sym, ecs;
with main_body;
with Matreshka.Internals.Unicode.Ucd.Core;
with Unicode;

##

   use Ada.Integer_Wide_Wide_Text_IO;
   use Ada.Strings.Wide_Wide_Unbounded;
   use Ada.Strings.Wide_Wide_Unbounded.Wide_Wide_Text_IO;
   use Ada.Wide_Wide_Text_IO;

   use Scanner;
   use Unicode;
   use Matreshka.Internals.Unicode.Ucd;
   use misc_defs;

   function "+" (Item : Wide_Wide_String) return Unbounded_Wide_Wide_String
     renames To_Unbounded_Wide_Wide_String;

   function Element is
     new Matreshka.Internals.Unicode.Ucd.Generic_Element
      (Matreshka.Internals.Unicode.Ucd.Core_Values,
       Matreshka.Internals.Unicode.Ucd.Core_Second_Stage,
       Matreshka.Internals.Unicode.Ucd.Core_Second_Stage_Access,
       Matreshka.Internals.Unicode.Ucd.Core_First_Stage);

   ----------------------
   -- Build_EOF_Action --
   ----------------------

   -- Build_EOF_Action - build the "<<EOF>>" action for the active start
   --                    conditions

   procedure Build_EOF_Action is
   begin
      Put (Temp_Action_File, "when ");

      for i in 1..actvp loop
         if sceof (actvsc (i)) then
            Put
              (Standard_Error, "multiple <<EOF>> rules for start condition ");
	    Put (Standard_Error, scname (actvsc (i)));
	    Main_Body.Aflex_End (1);

	else
	    sceof (actvsc (i)) := true;
	    Put (Temp_Action_File, "YY_END_OF_BUFFER +");
	    Put (Temp_Action_File, scname (actvsc (i)));
	    Put_Line (Temp_Action_File, " + 1 ");

            if (i /= actvp) then
               Put_Line (Temp_Action_File, " |");
            else
               Put_Line (Temp_Action_File, " =>");
	    end if;
         end if;
      end loop;

     misc.line_directive_out( temp_action_file );
   end Build_EOF_Action;

   -------------
   -- YYError --
   -------------

   --  yyerror - eat up an error message from the parser
   --
   --  synopsis
   --     char msg[];
   --     yyerror( msg );

   procedure YYError (msg : string) is
   begin
      null;
   end YYError;

##
