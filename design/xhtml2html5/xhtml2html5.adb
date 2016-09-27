------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2010, Vadim Godunko <vgodunko@gmail.com>                     --
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

with Ada.Wide_Wide_Text_IO;

with League.Application;
with League.String_Vectors;
with League.Strings;

with XML.SAX.HTML5_Writers;
with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Output_Destinations.Strings;
with XML.SAX.Simple_Readers;

procedure XHTML2HTML5 is
   Args   : constant League.String_Vectors.Universal_String_Vector :=
        League.Application.Arguments;
   Input  : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
   Reader : aliased XML.SAX.Simple_Readers.Simple_Reader;
   Writer : aliased XML.SAX.HTML5_Writers.HTML5_Writer;
   Output : aliased XML.SAX.Output_Destinations.Strings
     .String_Output_Destination;
   Errors : League.Strings.Universal_String;
begin
   Input.Open_By_File_Name (Args.Element (1));
   Reader.Set_Input_Source (Input'Unchecked_Access);
   Reader.Set_Content_Handler (Writer'Unchecked_Access);
   Reader.Set_Lexical_Handler (Writer'Unchecked_Access);
   Writer.Set_Output_Destination (Output'Unchecked_Access);
   Reader.Parse;
   Ada.Wide_Wide_Text_IO.Put (Output.Get_Text.To_Wide_Wide_String);
end XHTML2HTML5;
