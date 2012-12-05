with League.Application;

with XML.Schema.Models;
with XML.Schema.Utilities;

with Matreshka.XML_Schema.URI_Rewriter;

procedure Driver is
   Model : XML.Schema.Models.XS_Model;

begin
   Matreshka.XML_Schema.URI_Rewriter.Initialize;

   Model :=
     XML.Schema.Utilities.Load (League.Application.Arguments.Element (1));
end Driver;
