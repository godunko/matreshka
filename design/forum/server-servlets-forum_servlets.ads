with League.Strings;

with Servlet.HTTP_Requests;
with Servlet.HTTP_Responses;
with Servlet.HTTP_Servlets;

with Forum.Forums.Servers;

package Server.Servlets.Forum_Servlets is

   type Forum_Servlet is
     new Servlet.HTTP_Servlets.HTTP_Servlet with record
      Server : Forum.Forums.Servers.Server_Forum;
   end record;

   type Forum_Servlet_Access is access all Forum_Servlet'Class;

   overriding procedure Do_Get
    (Self     : in out Forum_Servlet;
     Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
     Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class);

   overriding function Get_Servlet_Info
    (Self : Forum_Servlet) return League.Strings.Universal_String;

end Server.Servlets.Forum_Servlets;
