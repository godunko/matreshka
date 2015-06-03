with League.Strings;
with SQL.Databases;
with SQL.Options;

with Servlet.Servlets;
with Servlet.Servlet_Registrations;

with Server.Globals;
with Server.Servlets.Static;
with Server.Servlets.Forum_Servlets;

package body Server.Initializers is

   type Servlet_Access is access all Servlet.Servlets.Servlet'Class;

   function Default_Options return SQL.Options.SQL_Options;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   ---------------------
   -- Default_Options --
   ---------------------

   function Default_Options return SQL.Options.SQL_Options is
      Result  : SQL.Options.SQL_Options;
   begin
      Result.Set
        (League.Strings.To_Universal_String ("dbname"),
         League.Strings.To_Universal_String ("forum"));

      return Result;
   end Default_Options;

   DB : aliased SQL.Databases.SQL_Database
     := SQL.Databases.Create
       (League.Strings.To_Universal_String ("POSTGRESQL"), Default_Options);

   ----------------
   -- On_Startup --
   ----------------

   overriding procedure On_Startup
     (Self    : in out Server_Initializer;
      Context : in out Servlet.Contexts.Servlet_Context'Class)
   is
      Servlet  : Servlet_Access;
      Registry : access
        Standard.Servlet.Servlet_Registrations.Servlet_Registration'Class;

   begin
      DB.Open;

      Server.Globals.My_Forum.Initialize (DB'Unchecked_Access);

      Servlet := new Server.Servlets.Static.Resource_Servlet;
      Registry := Context.Add_Servlet (+"StaticResources", Servlet);
      Registry.Add_Mapping (+"/forum.css");

      Servlet := new Server.Servlets.Forum_Servlets.Forum_Servlet;
      Registry := Context.Add_Servlet (+"ForumManager", Servlet);
      Registry.Add_Mapping (+"/account/*");

   end On_Startup;

end Server.Initializers;
