with Ada.Wide_Wide_Text_IO;

with XML.SAX.Error_Handlers;
with XML.SAX.Event_Writers;
with XML.SAX.HTML5_Writers;
with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Output_Destinations.Strings;
with XML.SAX.Parse_Exceptions;
with XML.SAX.Simple_Readers;
with XML.Templates.Processors;
with XML.Templates.Streams.Holders;
with Servlet.Contexts;
with League.String_Vectors;
with League.JSON.Arrays;
with League.JSON.Objects;
with League.Holders.JSON_Arrays;
with League.JSON.Values;

with Server.Globals;

package body Server.Servlets.Forum_Servlets is

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   type Error_Handler is
     limited new XML.SAX.Error_Handlers.SAX_Error_Handler with record
      null;
   end record;

   overriding function Error_String
    (Self : Error_Handler) return League.Strings.Universal_String;
   --  Returns error message when processing was terminated by error handler.

   overriding procedure Fatal_Error
    (Self       : in out Error_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception);
   --  Process fatal error in XML data. Outputs message to standard error.

   ------------
   -- Do_Get --
   ------------

   overriding procedure Do_Get
     (Self     : in out Forum_Servlet;
      Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
      Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class)
   is
      Context   : constant access Servlet.Contexts.Servlet_Context'Class
        := Request.Get_Servlet_Context;
      Path      : constant League.String_Vectors.Universal_String_Vector
        := Request.Get_Servlet_Path;

      Input  : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
      Reader : XML.SAX.Simple_Readers.Simple_Reader;
      Filter : aliased XML.Templates.Processors.Template_Processor;
      Writer : aliased XML.SAX.HTML5_Writers.HTML5_Writer;
      Output :
        aliased XML.SAX.Output_Destinations.Strings.String_Output_Destination;
      Error  : aliased Error_Handler;
      Arr    : League.JSON.Arrays.JSON_Array;
   begin
      --  Link components.

      Reader.Set_Input_Source (Input'Unchecked_Access);
      Reader.Set_Content_Handler (Filter'Unchecked_Access);
      Reader.Set_Lexical_Handler (Filter'Unchecked_Access);
      Reader.Set_Error_Handler (Error'Unchecked_Access);
      Filter.Set_Content_Handler (Writer'Unchecked_Access);
      Filter.Set_Lexical_Handler (Writer'Unchecked_Access);
      Writer.Set_Output_Destination (Output'Unchecked_Access);

      --  Set parameters
      for J of Server.Globals.My_Forum.Get_Categories loop
         declare
            JSON   : League.JSON.Objects.JSON_Object;
         begin
            JSON.Insert
              (+"user",
               League.JSON.Values.To_JSON_Value (J.Object.Get_Title));
            Arr.Append (JSON.To_JSON_Value);
         end;
      end loop;

      Filter.Set_Parameter
        (+"list", League.Holders.JSON_Arrays.To_Holder (Arr));

      Response.Set_Status (Servlet.HTTP_Responses.OK);
      Response.Set_Character_Encoding (+"UTF-8");
      Response.Set_Content_Type (Context.Get_MIME_Type (Path (Path.Length)));

      --  Process template file.

      Input.Open_By_File_Name
       (Context.Get_Real_Path (+"/WEB-INF/templates/page.xhtml.tmpl"));
      Reader.Parse;

      Response.Get_Output_Stream.Write (Output.Get_Text);
   end Do_Get;

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

   ----------------------
   -- Get_Servlet_Info --
   ----------------------

   overriding function Get_Servlet_Info
     (Self : Forum_Servlet)
      return League.Strings.Universal_String
   is
   begin
      return League.Strings.To_Universal_String ("Forum Servlet");
   end Get_Servlet_Info;

end Server.Servlets.Forum_Servlets;
