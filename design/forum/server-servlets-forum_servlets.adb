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
with League.Holders.JSON_Arrays;
with League.IRIs;
with League.JSON.Arrays;
with League.JSON.Objects;
with League.JSON.Values;
with League.String_Vectors;

with Server.Globals;
with Forum.Categories;

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

   procedure Get_Categories
     (Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class;
      Path     : League.String_Vectors.Universal_String_Vector;
      Filter   : in out XML.Templates.Processors.Template_Processor;
      Template : out League.Strings.Universal_String);

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
      Path      : League.String_Vectors.Universal_String_Vector
        := Request.Get_Servlet_Path;
      Path_Info : constant League.String_Vectors.Universal_String_Vector
        := Request.Get_Path_Info;

      Input  : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
      Reader : XML.SAX.Simple_Readers.Simple_Reader;
      Filter : aliased XML.Templates.Processors.Template_Processor;
      Writer : aliased XML.SAX.HTML5_Writers.HTML5_Writer;
      Output :
        aliased XML.SAX.Output_Destinations.Strings.String_Output_Destination;
      Error  : aliased Error_Handler;
      Template : League.Strings.Universal_String;
   begin
      --  Link components.

      Reader.Set_Input_Source (Input'Unchecked_Access);
      Reader.Set_Content_Handler (Filter'Unchecked_Access);
      Reader.Set_Lexical_Handler (Filter'Unchecked_Access);
      Reader.Set_Error_Handler (Error'Unchecked_Access);
      Filter.Set_Content_Handler (Writer'Unchecked_Access);
      Filter.Set_Lexical_Handler (Writer'Unchecked_Access);
      Writer.Set_Output_Destination (Output'Unchecked_Access);

      Path.Prepend
        (League.String_Vectors.Universal_String_Vector'
           (Request.Get_Context_Path));

      --  Set parameters
--      if Path_Info.Length = 0 then
         Get_Categories (Response, Path, Filter, Template);
---      end if;

      Filter.Set_Parameter
        (+"aaa", League.Holders.To_Holder
           (+Natural'Wide_Wide_Image (Path_Info.Length)));

      Response.Set_Status (Servlet.HTTP_Responses.OK);
      Response.Set_Content_Type (+"text/html");
      Response.Set_Character_Encoding (+"UTF-8");

      --  Process template file.

      Input.Open_By_File_Name (Context.Get_Real_Path (Template));
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

   --------------------
   -- Get_Categories --
   --------------------

   procedure Get_Categories
     (Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class;
      Path     : League.String_Vectors.Universal_String_Vector;
      Filter   : in out XML.Templates.Processors.Template_Processor;
      Template : out League.Strings.Universal_String)
   is
      Arr    : League.JSON.Arrays.JSON_Array;
   begin
      for J of Server.Globals.My_Forum.Get_Categories loop
         declare
            JSON : League.JSON.Objects.JSON_Object;
            IRI  : League.IRIs.IRI;
         begin
            IRI.Set_Absolute_Path (Path);
            IRI.Append_Segment
              (Forum.Categories.Encode (J.Object.Get_Identifier));

            JSON.Insert
              (+"id",
               League.JSON.Values.To_JSON_Value (IRI.To_Universal_String));
            JSON.Insert
              (+"title",
               League.JSON.Values.To_JSON_Value (J.Object.Get_Title));
            JSON.Insert
              (+"description",
               League.JSON.Values.To_JSON_Value (J.Object.Get_Description));
            Arr.Append (JSON.To_JSON_Value);
         end;
      end loop;

      Filter.Set_Parameter
        (+"list", League.Holders.JSON_Arrays.To_Holder (Arr));

      Template := +"/WEB-INF/templates/page.xhtml.tmpl";
   end Get_Categories;

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
