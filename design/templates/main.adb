with Ada.Wide_Wide_Text_IO;

with League.Holders;
with League.Strings;
with XML.SAX.Error_Handlers;
with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Output_Destinations.Strings;
with XML.SAX.Parse_Exceptions;
with XML.SAX.Pretty_Writers;
with XML.SAX.Simple_Readers;

with XML.Templates.Template_Processors;

procedure Main is

   type Error_Handler is
     limited new XML.SAX.Error_Handlers.SAX_Error_Handler with null record;

   overriding procedure Error
    (Self       : in out Error_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
     Success    : in out Boolean);

   overriding function Error_String
    (Self : Error_Handler) return League.Strings.Universal_String;

   overriding procedure Fatal_Error
    (Self       : in out Error_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception);

--   not overriding procedure Warning
--    (Self       : in out SAX_Error_Handler;
--     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
--     Success    : in out Boolean) is null;

   -----------
   -- Error --
   -----------

   overriding procedure Error
    (Self       : in out Error_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
     Success    : in out Boolean) is
   begin
      Ada.Wide_Wide_Text_IO.Put_Line (Occurrence.Message.To_Wide_Wide_String);
   end Error;

   -----------------
   -- Fatal_Error --
   -----------------

   overriding procedure Fatal_Error
    (Self       : in out Error_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception) is
   begin
      Ada.Wide_Wide_Text_IO.Put_Line (Occurrence.Message.To_Wide_Wide_String);
   end Fatal_Error;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : Error_Handler) return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   Input  : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
   Reader : aliased XML.SAX.Simple_Readers.SAX_Simple_Reader;
   Filter : aliased XML.Templates.Template_Processors.Template_Processor;
   Writer : aliased XML.SAX.Pretty_Writers.SAX_Pretty_Writer;
   Output : aliased XML.SAX.Output_Destinations.Strings.SAX_String_Output_Destination;
   ErrorH : aliased Error_Handler;
   Object : League.Holders.Holder;

begin
   Input.Open_By_File_Name
    (League.Strings.To_Universal_String ("page.tmpl"));

   --  Configure reader.

   Reader.Set_Input_Source (Input'Unchecked_Access);
   Reader.Set_Content_Handler (Filter'Unchecked_Access);
   Reader.Set_Lexical_Handler (Filter'Unchecked_Access);
   Reader.Set_Error_Handler (ErrorH'Unchecked_Access);

   --  Configure template processor.

   Filter.Set_Content_Handler (Writer'Unchecked_Access);
   Filter.Set_Lexical_Handler (Writer'Unchecked_Access);

   Filter.Set_Parameter
    (League.Strings.To_Universal_String ("class"),
     League.Holders.To_Holder (League.Strings.To_Universal_String ("bold")));
   Filter.Set_Parameter
    (League.Strings.To_Universal_String ("value"),
     League.Holders.To_Holder
      (League.Strings.To_Universal_String
        ("Hello, world! This is some special characters <> test.")));

   --  Configure XML writer.

   Writer.Set_Output (Output'Unchecked_Access);
--   Writer.Set_Output_Destination (Output'Unchecked_Access);

   --  Process template.

   Reader.Parse;

   --  Output result.

   Ada.Wide_Wide_Text_IO.Put (Output.Get_Text.To_Wide_Wide_String);
end Main;
