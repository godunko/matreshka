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

with Ada.Command_Line;
with Ada.Wide_Wide_Text_IO;

with League.Application;
with League.Holders;
with League.String_Vectors;
with League.Strings;

with XML.SAX.Error_Handlers;
with XML.SAX.HTML5_Writers;
with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Output_Destinations.Strings;
with XML.SAX.Parse_Exceptions;
with XML.SAX.Simple_Readers;
with XML.Templates.Processors;

procedure XHTML2HTML5 is
   use type League.Strings.Universal_String;

   function "+"
    (Text : Wide_Wide_String) return League.Strings.Universal_String
      renames League.Strings.To_Universal_String;

   package Error_Handlers is
      type Error_Handler is new XML.SAX.Error_Handlers.SAX_Error_Handler with
         record
            Clean : Boolean := True;
         end record;

      overriding procedure Error
       (Self       : in out Error_Handler;
        Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
        Success    : in out Boolean);

      overriding function Error_String
       (Self : Error_Handler)
        return League.Strings.Universal_String is
        (League.Strings.Empty_Universal_String);

      overriding procedure Fatal_Error
       (Self       : in out Error_Handler;
        Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception);

   end Error_Handlers;

   --------------------
   -- Error_Handlers --
   --------------------

   package body Error_Handlers is

      -----------
      -- Error --
      -----------

      overriding procedure Error
       (Self       : in out Error_Handler;
        Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
        Success    : in out Boolean) is
      begin
         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            "Error:");
         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            Occurrence.Message.To_Wide_Wide_String);
         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            "  at " & Natural'Wide_Wide_Image (Occurrence.Line) &
            ":" & Natural'Wide_Wide_Image (Occurrence.Column));
         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            "  of " & Occurrence.System_Id.To_Wide_Wide_String &
                " - " & Occurrence.Public_Id.To_Wide_Wide_String);
         Ada.Wide_Wide_Text_IO.New_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error);
      end Error;

      -----------------
      -- Fatal_Error --
      -----------------

      overriding procedure Fatal_Error
       (Self       : in out Error_Handler;
        Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception)
      is
         Success : Boolean := True;
      begin
         Ada.Wide_Wide_Text_IO.Put
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            "Fatal_");
         Self.Error (Occurrence, Success);
      end Fatal_Error;

   end Error_Handlers;

   Args   : constant League.String_Vectors.Universal_String_Vector :=
        League.Application.Arguments;
   Input  : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
   Reader : aliased XML.SAX.Simple_Readers.Simple_Reader;
   Filter : aliased XML.Templates.Processors.Template_Processor;
   Writer : aliased XML.SAX.HTML5_Writers.HTML5_Writer;
   Output : aliased XML.SAX.Output_Destinations.Strings
     .String_Output_Destination;
   Error  : aliased Error_Handlers.Error_Handler;

begin
   for J in 1 .. (Args.Length - 1) / 3 loop
      if Args.Element (J * 3 - 2) = +"--bind-string" then
         Filter.Set_Parameter
           (Args.Element (J * 3 - 1),
            League.Holders.To_Holder (Args.Element (J * 3)));
      end if;
   end loop;

   Input.Open_By_File_Name (Args.Element (Args.Length));
   Reader.Set_Input_Source (Input'Unchecked_Access);
   Reader.Set_Content_Handler (Filter'Unchecked_Access);
   Reader.Set_Lexical_Handler (Filter'Unchecked_Access);
   Filter.Set_Content_Handler (Writer'Unchecked_Access);
   Filter.Set_Lexical_Handler (Writer'Unchecked_Access);
   Reader.Set_Error_Handler (Error'Unchecked_Access);
   Writer.Set_Output_Destination (Output'Unchecked_Access);
--   Writer.Set_Error_Handler (Error'Unchecked_Access);
   Reader.Parse;

   if Error.Clean then

      Ada.Wide_Wide_Text_IO.Put (Output.Get_Text.To_Wide_Wide_String);
   else

      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
   end if;
end XHTML2HTML5;
