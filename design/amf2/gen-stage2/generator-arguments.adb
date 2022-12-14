------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Ada Modeling Framework                          --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2012-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
with League.Application;

package body Generator.Arguments is

   ----------------------------------
   -- Parse_Command_Line_Arguments --
   ----------------------------------

   procedure Parse_Command_Line_Arguments is
      Arguments    : constant League.String_Vectors.Universal_String_Vector
        := League.Application.Arguments;
      Argument     : League.Strings.Universal_String;
      Next_Is_File : Boolean := False;

   begin
      --  Parse first and last years for copyright statement.

      First_Year :=
        Integer'Wide_Wide_Value (Arguments (1).To_Wide_Wide_String);
      Last_Year :=
        Integer'Wide_Wide_Value (Arguments (2).To_Wide_Wide_String);
      Module_Info.Ada_Name := Arguments (3);

      for J in 4 .. Arguments.Length loop
         Argument := Arguments (J);

         if Argument = +"--verbose" then
            --  Output verbose messages.

            Verbose := True;

         elsif Argument = +"--stubs" then
            --  In the implementation stubs mode only stubs code is generated.

            Generate_Attributes   := True;
            Generate_Constructors := True;
            Generate_Reflection   := True;
            Generate_Public_API   := False;
            Generate_API_Stubs    := True;

         elsif Argument = +"--mapping" then
            Next_Is_File := True;

         elsif Next_Is_File then
            Next_Is_File := False;
            Type_Mapping_File := Argument;

         else
            --  Command line argument is not recognized, treat it as metamodel
            --  URI.

            Metamodel_URIs.Append (Argument);
         end if;
      end loop;
   end Parse_Command_Line_Arguments;

end Generator.Arguments;
