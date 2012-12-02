with League.Application;

with XML.Schema.Models;
with XML.Schema.Utilities;

procedure Driver is
   Model : XML.Schema.Models.XS_Model;

begin
   Model :=
     XML.Schema.Utilities.Load (League.Application.Arguments.Element (1));
end Driver;
