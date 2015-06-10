with League.Strings;
with SQL.Databases;
with SQL.Options;

with Servlet.Servlets;
with Servlet.Servlet_Registrations;
with Spikedog.Servlet_Contexts;

with Forum.Forums.Servers;
with Server.Servlets.Static;
with Server.Servlets.Forum_Servlets;
with Server.Sessions.Controller;

with Matreshka.Internals.SQL_Drivers.PostgreSQL.Factory;

package body Server.Initializers is

   type Servlet_Access is access all Servlet.Servlets.Servlet'Class;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   ----------------
   -- On_Startup --
   ----------------

   overriding procedure On_Startup
     (Self    : in out Server_Initializer;
      Context : in out Servlet.Contexts.Servlet_Context'Class)
   is
      Options  : SQL.Options.SQL_Options;
      Servlet  : constant Server.Servlets.Forum_Servlets.Forum_Servlet_Access
        :=  new Server.Servlets.Forum_Servlets.Forum_Servlet;
      Registry : access
        Standard.Servlet.Servlet_Registrations.Servlet_Registration'Class;

   begin
      --  Initialize persistance manager.

      Options.Set
        (League.Strings.To_Universal_String ("dbname"),
         League.Strings.To_Universal_String ("forum"));
      Forum.Forums.Servers.Initialize
       (Servlet.Server,
        League.Strings.To_Universal_String ("POSTGRESQL"),
        Options);

      --  Replace default session manager.

      Spikedog.Servlet_Contexts.Spikedog_Servlet_Context'Class
       (Context).Set_Session_Manager
         (Servlet.Server.Get_HTTP_Session_Manager);

      --  Create and register servlets.

      Registry := Context.Add_Servlet
        (+"StaticResources",
         Servlet_Access'(new Server.Servlets.Static.Resource_Servlet));

      Registry.Add_Mapping (+"/forum.css");

      Registry := Context.Add_Servlet (+"ForumManager", Servlet);
      Registry.Add_Mapping (+"/forum/*");

   end On_Startup;

end Server.Initializers;