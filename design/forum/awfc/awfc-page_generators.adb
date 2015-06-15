------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
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

with XML.SAX.Error_Handlers;
with XML.SAX.Event_Readers;
with XML.SAX.Event_Writers;
with XML.SAX.File_Input_Sources;
with XML.SAX.HTML5_Writers;
with XML.SAX.Parse_Exceptions;
with XML.SAX.Simple_Readers;
with XML.SAX.String_Output_Destinations;
with XML.Templates.Streams.Holders;

package body AWFC.Page_Generators is

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   function Get_Stream
    (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
     File    : League.Strings.Universal_String)
       return XML.Templates.Streams.XML_Stream_Element_Vectors.Vector;
   --  Loads XML file and converts it into stream of SAX events.

   type Error_Handler is
     limited new XML.SAX.Error_Handlers.SAX_Error_Handler with null record;
   --  XXX This type should be declared to be reusable and should be integrated
   --  into some general logging facility.

   overriding function Error_String
    (Self : Error_Handler) return League.Strings.Universal_String;
   --  Returns error message when processing was terminated by error handler.

   overriding procedure Fatal_Error
    (Self       : in out Error_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception);
   --  Process fatal error in XML data. Outputs message to standard error.

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : Error_Handler) return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   -----------------
   -- Fatal_Error --
   -----------------

   overriding procedure Fatal_Error
    (Self       : in out Error_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception)
   is
      Line   : constant Wide_Wide_String
        := Integer'Wide_Wide_Image (Occurrence.Line);
      Column : constant Wide_Wide_String
        := Integer'Wide_Wide_Image (Occurrence.Column);

   begin
      Ada.Wide_Wide_Text_IO.Put_Line
       (Ada.Wide_Wide_Text_IO.Standard_Error,
        Occurrence.System_Id.To_Wide_Wide_String
          & ':'
          & Line (Line'First + 1 .. Line'Last)
          & ':'
          & Column (Column'First + 1 .. Column'Last)
          & ": "
          & Occurrence.Message.To_Wide_Wide_String);
   end Fatal_Error;

   ----------------
   -- Get_Stream --
   ----------------

   function Get_Stream
    (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
     File    : League.Strings.Universal_String)
       return XML.Templates.Streams.XML_Stream_Element_Vectors.Vector
   is
      Input  : aliased XML.SAX.File_Input_Sources.File_Input_Source;
      Reader : XML.SAX.Simple_Readers.Simple_Reader;
      Writer : aliased XML.SAX.Event_Writers.Event_Writer;
      Error  : aliased Error_Handler;

   begin
      --  Configure reader.

      Reader.Set_Input_Source (Input'Unchecked_Access);
      Reader.Set_Content_Handler (Writer'Unchecked_Access);
      Reader.Set_Lexical_Handler (Writer'Unchecked_Access);
      Reader.Set_Error_Handler (Error'Unchecked_Access);

      --  Parse file.

      Input.Open_By_File_Name (Context.Get_Real_Path (File));
      Reader.Parse;
      Input.Close;

      return Writer.Get_Stream;
   end Get_Stream;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self             : in out Abstract_Page_Generator'Class;
     Context          :
       not null access constant Servlet.Contexts.Servlet_Context'Class;
     Page_Template    : League.Strings.Universal_String;
     Content_Template : League.Strings.Universal_String) is
   begin
      Self.Page    := Get_Stream (Context, Page_Template);
      Self.Content := Get_Stream (Context, Content_Template);
   end Initialize;

   ------------
   -- Render --
   ------------

   function Render
    (Self    : in out Abstract_Page_Generator'Class;
     Session : Servlet.HTTP_Sessions.HTTP_Session'Class)
       return League.Strings.Universal_String
   is
      Reader       : XML.SAX.Event_Readers.Event_Reader;
      Filter       : aliased XML.Templates.Processors.Template_Processor;
      Event_Writer : aliased XML.SAX.Event_Writers.Event_Writer;
      Error        : aliased Error_Handler;
      HTML_Writer  : aliased XML.SAX.HTML5_Writers.HTML5_Writer;
      Output       : aliased
        XML.SAX.String_Output_Destinations.String_Output_Destination;

   begin
      --  Connect components.

      Reader.Set_Content_Handler (Filter'Unchecked_Access);
      Reader.Set_Lexical_Handler (Filter'Unchecked_Access);
      Reader.Set_Error_Handler (Error'Unchecked_Access);

      --  Bind template parameters.

      Self.Bind_Parameters (Filter);

      --  Connect template processor to event stream writer.

      Filter.Set_Content_Handler (Event_Writer'Unchecked_Access);
      Filter.Set_Lexical_Handler (Event_Writer'Unchecked_Access);

      Reader.Parse (Self.Content);

      --  Bind generated content to parameter.

      Filter.Set_Parameter
       (+"pageContent",
        XML.Templates.Streams.Holders.To_Holder (Event_Writer.Get_Stream));

      --  Connect template processor to HTML5 writer.

      Filter.Set_Content_Handler (HTML_Writer'Unchecked_Access);
      Filter.Set_Lexical_Handler (HTML_Writer'Unchecked_Access);
      HTML_Writer.Set_Output_Destination (Output'Unchecked_Access);

      Reader.Parse (Self.Page);

      return Output.Get_Text;
   end Render;

end AWFC.Page_Generators;
