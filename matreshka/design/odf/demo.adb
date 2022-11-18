with Ada.Text_IO; use Ada.Text_IO;

with League.Application;
with League.Strings;
with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Simple_Readers;

with XML.DOM.Documents.Internals;
with ODF.DOM.Documents;
with Matreshka.DOM_Builders;

with ODF.Web;

with AWS.Config.Set;
with AWS.Server;
with AWS.Services.Dispatchers.URI;
with AWS.Services.Page_Server;

procedure Demo is

   use type League.Strings.Universal_String;

   Styles  : XML.DOM.Documents.DOM_Document;
   Content : XML.DOM.Documents.DOM_Document;

begin
   --  Build DOM tree.

   declare
      Reader   : aliased XML.SAX.Simple_Readers.SAX_Simple_Reader;
      Source   : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
      Handler  : aliased Matreshka.DOM_Builders.DOM_Builder;
      Indent   : Natural := 0;

   begin
      Reader.Set_Content_Handler (Handler'Unchecked_Access);
      Source.Open_By_File_Name (League.Application.Arguments.Element (1) & "/styles.xml");
      Reader.Parse (Source'Unchecked_Access);
      Source.Close;

      Styles := XML.DOM.Documents.Internals.Wrap (Handler.Get_Document);
   end;

   --  Build DOM tree.

   declare
      Reader   : aliased XML.SAX.Simple_Readers.SAX_Simple_Reader;
      Source   : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
      Handler  : aliased Matreshka.DOM_Builders.DOM_Builder;
      Indent   : Natural := 0;

   begin
      Reader.Set_Content_Handler (Handler'Unchecked_Access);
      Source.Open_By_File_Name (League.Application.Arguments.Element (1) & "/content.xml");
      Reader.Parse (Source'Unchecked_Access);
      Source.Close;

      Content := XML.DOM.Documents.Internals.Wrap (Handler.Get_Document);
   end;

   --  Debug output.

   Put_Line
    (ODF.Web.To_JSON
      (ODF.DOM.To_ODF_Document (Styles),
       ODF.DOM.To_ODF_Document (Content)));

   ODF.Web.Document.Styles := ODF.DOM.To_ODF_Document (Styles);
   ODF.Web.Document.Content := ODF.DOM.To_ODF_Document (Content);

   --  Run AWS.

   declare
      Config     : AWS.Config.Object := AWS.Config.Default_Config;
      Dispatcher : AWS.Services.Dispatchers.URI.Handler;
      Server     : AWS.Server.HTTP;

   begin
      AWS.Config.Set.WWW_Root (Config, "web");
      AWS.Config.Set.Reuse_Address (Config, True);

      Dispatcher.Register ("/getODF", ODF.Web.Get_Callback'Access);
      Dispatcher.Register ("/changeODF", ODF.Web.Change_Callback'Access);
      Dispatcher.Register_Regexp
       ("/.*", AWS.Services.Page_Server.Callback'Access);

      AWS.Server.Start (Server, Dispatcher, Config);
      AWS.Server.Wait (AWS.Server.No_Server);
   end;
end Demo;
