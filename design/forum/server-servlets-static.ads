with League.Strings;

with Servlet.HTTP_Requests;
with Servlet.HTTP_Responses;
with Servlet.HTTP_Servlets;

package Server.Servlets.Static is

   type Resource_Servlet is
     new Servlet.HTTP_Servlets.HTTP_Servlet with null record;

   overriding procedure Do_Get
    (Self     : in out Resource_Servlet;
     Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
     Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class);

   overriding function Get_Servlet_Info
    (Self : Resource_Servlet) return League.Strings.Universal_String;

end Server.Servlets.Static;
