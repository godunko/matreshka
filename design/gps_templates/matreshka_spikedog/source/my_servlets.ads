private with League.Strings;

private with Servlet.Generic_Servlets;
private with Servlet.HTTP_Requests;
private with Servlet.HTTP_Responses;
with Servlet.HTTP_Servlets;

package My_Servlets is

   type My_Servlet is
     new Servlet.HTTP_Servlets.HTTP_Servlet with private;

private

   type My_Servlet is
     new Servlet.HTTP_Servlets.HTTP_Servlet with null record;

   overriding procedure Do_Get
    (Self     : in out My_Servlet;
     Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
     Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class);
   --  Process "GET" requests

   overriding function Get_Servlet_Info
    (Self : My_Servlet) return League.Strings.Universal_String;
   --  Name of the servlet

   overriding function Instantiate
    (Parameters : not null access
       Servlet.Generic_Servlets.Instantiation_Parameters'Class)
         return My_Servlet;
   --  Creates instance of servlet

end My_Servlets;
