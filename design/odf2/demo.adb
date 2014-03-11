with Ada.Text_IO;

with AWS.Config.Set;
with AWS.Server;
with AWS.Services.Dispatchers.URI;
with AWS.Services.Page_Server;

with League.Application;

with ODF.DOM.Packages;
with ODF.Packages;

with ODF.Web.AWS_Callbacks;

procedure Demo is
   The_Package : ODF.DOM.Packages.ODF_Package_Access;

begin
   The_Package := ODF.Packages.Load (League.Application.Arguments.Element (1));

   --  Debug output.

   Ada.Text_IO.Put_Line (ODF.Web.To_JSON (The_Package.Get_Styles, The_Package.Get_Content));

   ODF.Web.Document.Styles := The_Package.Get_Styles;
   ODF.Web.Document.Content := The_Package.Get_Content;

   --  Run AWS.

   declare
      Config     : AWS.Config.Object := AWS.Config.Default_Config;
      Dispatcher : AWS.Services.Dispatchers.URI.Handler;
      Server     : AWS.Server.HTTP;

   begin
      AWS.Config.Set.WWW_Root (Config, "web");
      AWS.Config.Set.Reuse_Address (Config, True);

      Dispatcher.Register ("/getODF", ODF.Web.AWS_Callbacks.Get_Callback'Access);
      Dispatcher.Register ("/changeODF", ODF.Web.AWS_Callbacks.Change_Callback'Access);
      Dispatcher.Register_Regexp
       ("/.*", AWS.Services.Page_Server.Callback'Access);

      AWS.Server.Start (Server, Dispatcher, Config);
      AWS.Server.Wait (AWS.Server.No_Server);
   end;
end Demo;
