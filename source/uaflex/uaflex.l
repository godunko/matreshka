------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2011-2015, Vadim Godunko <vgodunko@gmail.com>                --
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

%x INRULE SECT2 DEF NAMELIST

NAME           [a-zA-Z][a-zA-Z0-9_]*
SPACE          [\t ]+
OPTSPACE       [\t ]*
NO_SPACE       [^\n\t ]+
CLASS          "["[^\n\]]+"]"
STRING         \"[^"\n]*\"
MASKED_SPACE   "\\ "
ADA_STRING     \"([^"]+|\"\")*\"

%%

{OPTSPACE}"--"[^\n]*\n					{Skip_Line}
"%"[Ss](tart)?						{On_Start}
"%"[Xx]							{On_Exclusive}
{NAME}							{On_Name}
"%%"[^\n]*\n						{On_Section_End}
{OPTSPACE}\n						{Skip_Line}

<DEF>{SPACE}						{Skip}
<DEF>[^ \t\n][^\n]*					{On_Regexp}
<DEF>\n							{End_Of_Macro}

<NAMELIST>\n						{End_Of_Name_List}
<NAMELIST>{NAME}					{On_Name_2}
<NAMELIST>{SPACE}					{Skip}

<SECT2>{OPTSPACE}"--"[^\n]*\n				{Skip_Line}
<SECT2>({NO_SPACE}|{CLASS}|{STRING}|{MASKED_SPACE})+	{On_Regexp_2}
<SECT2>{OPTSPACE}\n					{Skip_Line}
<SECT2>"%%"[^\n]*\n					{On_Section_End_2}

<INRULE>\{([^}"]+|{ADA_STRING})*\}			{On_Action}
<INRULE>{SPACE}						{Skip}
<INRULE>{OPTSPACE}\n					{On_End_Of_Rule}

%%
