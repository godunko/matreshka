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

procedure Demo is
begin
   --  Build DOM tree.

   declare
      use type League.Strings.Universal_String;

      Reader   : aliased XML.SAX.Simple_Readers.SAX_Simple_Reader;
      Source   : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
      Handler  : aliased Matreshka.DOM_Builders.DOM_Builder;
      Document : XML.DOM.Nodes.Documents.DOM_Document_Access;
      Indent   : Natural := 0;

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

   begin
      Reader.Set_Content_Handler (Handler'Unchecked_Access);
      Source.Open_By_File_Name (League.Application.Arguments.Element (1) & "/styles.xml");
      Reader.Parse (Source'Unchecked_Access);
      Source.Close;

      Document := Handler.Get_Document;
      Process (XML.DOM.Nodes.DOM_Node_Access (Document));
      XML.DOM.Nodes.Dereference (XML.DOM.Nodes.DOM_Node_Access (Document));
   end;

--   ODF.Internals.Reader.Read (League.Application.Arguments.Element (1));
end Demo;
