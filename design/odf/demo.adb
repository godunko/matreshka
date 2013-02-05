with Ada.Text_IO; use Ada.Text_IO;
with Ada.Tags;    use Ada.Tags;

with League.Application;
with League.Strings;
with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Simple_Readers;

with ODF.Internals.Reader;

with XML.DOM.Nodes.Documents;
--with XML.DOM.Nodes.Elements;
with ODF.DOM.Documents;
with ODF.DOM.Elements;
with Matreshka.DOM_Builders;

with ODF.Web;

with AWS.Config.Set;
with AWS.Server;
with AWS.Services.Dispatchers.URI;
with AWS.Services.Page_Server;

procedure Demo is

   use type League.Strings.Universal_String;

   procedure Process (Node : XML.DOM.Nodes.DOM_Node_Access);

   procedure Process (Node : XML.DOM.Nodes.DOM_Node_Access) is
      use type XML.DOM.Nodes.DOM_Node_Access;

      Child : XML.DOM.Nodes.DOM_Node_Access := Node.Get_First_Child;

   begin
      Put_Line (External_Tag (Node'Tag));

      while Child /= null loop
         Process (Child);
         Child := Child.Get_Next_Sibling;
      end loop;
   end Process;

   Styles  : XML.DOM.Nodes.Documents.DOM_Document_Access;
   Content : XML.DOM.Nodes.Documents.DOM_Document_Access;

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

      Styles := Handler.Get_Document;
      Process (XML.DOM.Nodes.DOM_Node_Access (Styles));
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

      Content := Handler.Get_Document;
      Process (XML.DOM.Nodes.DOM_Node_Access (Content));
   end;

   --  Debug output.

   Put_Line
    (ODF.Web.To_JSON
      (ODF.DOM.Documents.ODF_Document_Access (Styles),
       ODF.DOM.Documents.ODF_Document_Access (Content)));

   ODF.Web.Document.Styles := ODF.DOM.Documents.ODF_Document_Access (Styles);
   ODF.Web.Document.Content := ODF.DOM.Documents.ODF_Document_Access (Content);

   --  Run AWS.

   declare
      Config     : AWS.Config.Object := AWS.Config.Default_Config;
      Dispatcher : AWS.Services.Dispatchers.URI.Handler;
      Server     : AWS.Server.HTTP;

   begin
      AWS.Config.Set.WWW_Root (Config, "web");
      AWS.Config.Set.Reuse_Address (Config, True);

      Dispatcher.Register ("/getODF", ODF.Web.Callback'Access);
      Dispatcher.Register_Regexp
       ("/.*", AWS.Services.Page_Server.Callback'Access);

      AWS.Server.Start (Server, Dispatcher, Config);
      AWS.Server.Wait (AWS.Server.No_Server);
   end;

   XML.DOM.Nodes.Dereference (XML.DOM.Nodes.DOM_Node_Access (Styles));
   XML.DOM.Nodes.Dereference (XML.DOM.Nodes.DOM_Node_Access (Content));
end Demo;
