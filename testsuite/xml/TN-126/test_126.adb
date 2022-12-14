------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                            Testsuite Component                           --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2011-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
--  Initial implementation of SAX writer has bugs in namespace mapping
--  management.
------------------------------------------------------------------------------
with Ada.Command_Line;

with League.Characters;
with League.Strings;
with Put_Line;
with Read_File;
with XML.SAX.Pretty_Writers;
with XML.SAX.Simple_Readers;
with XML.SAX.String_Input_Sources;
with XML.SAX.String_Output_Destinations;

procedure Test_126 is

   use type League.Strings.Universal_String;

   Source : aliased XML.SAX.String_Input_Sources.String_Input_Source;
   Output : aliased
     XML.SAX.String_Output_Destinations.String_Output_Destination;
   Reader : aliased XML.SAX.Simple_Readers.Simple_Reader;
   Writer : aliased XML.SAX.Pretty_Writers.XML_Pretty_Writer;

   Root     : constant String := Ada.Command_Line.Argument (1);
   Input    : constant League.Strings.Universal_String
     := Read_File (Root & "a.xml");
   Expected : constant League.Strings.Universal_String
     := Read_File (Root & "a-expected.xml");

begin
   Reader.Set_Content_Handler (Writer'Unchecked_Access);
   Writer.Set_Output_Destination (Output'Unchecked_Access);
   Writer.Set_Value_Delimiter (League.Characters.To_Universal_Character ('"'));

   --  Parse XML document.

   Source.Set_String (Input);
   Reader.Parse (Source'Access);

   --  Check output document.

   if Output.Get_Text /= Expected then
      Put_Line ("Expected: '" & Expected & ''');
      Put_Line ("Actual  : '" & Output.Get_Text & ''');

      raise Program_Error;
   end if;
end Test_126;
