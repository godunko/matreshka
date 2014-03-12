with AWS.Config.Set;
with AWS.Server;
with AWS.Services.Dispatchers.URI;
with AWS.Services.Page_Server;

with League.Application;
pragma Unreferenced (League.Application);

with ODF.Web.AWS_Callbacks;

procedure Demo is
begin
   --  Run AWS.

   declare
      Config     : AWS.Config.Object := AWS.Config.Default_Config;
      Dispatcher : AWS.Services.Dispatchers.URI.Handler;
      Server     : AWS.Server.HTTP;

   begin
      AWS.Config.Set.WWW_Root (Config, "web");
      AWS.Config.Set.Reuse_Address (Config, True);
      AWS.Config.Set.Upload_Directory (Config, "tmp/attachments");

      Dispatcher.Register ("/uploadODF", ODF.Web.AWS_Callbacks.Upload_Callback'Access);
      Dispatcher.Register ("/getODF", ODF.Web.AWS_Callbacks.Get_Callback'Access);
      Dispatcher.Register ("/changeODF", ODF.Web.AWS_Callbacks.Change_Callback'Access);
      Dispatcher.Register_Regexp
       ("/.*", AWS.Services.Page_Server.Callback'Access);

      AWS.Server.Start (Server, Dispatcher, Config);
      AWS.Server.Wait (AWS.Server.No_Server);
   end;
end Demo;
