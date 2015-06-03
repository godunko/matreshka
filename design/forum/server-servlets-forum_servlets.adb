with Servlet.Contexts;
with League.String_Vectors;

package body Server.Servlets.Forum_Servlets is

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   ------------
   -- Do_Get --
   ------------

   overriding procedure Do_Get
     (Self     : in out Forum_Servlet;
      Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
      Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class)
   is
      Context   : constant access Servlet.Contexts.Servlet_Context'Class
        := Request.Get_Servlet_Context;
      Path      : constant League.String_Vectors.Universal_String_Vector
        := Request.Get_Servlet_Path;
   begin
      Response.Set_Status (Servlet.HTTP_Responses.OK);
      Response.Set_Content_Type (Context.Get_MIME_Type (Path (Path.Length)));

      Response.Get_Output_Stream.Write (+"Hello world");
   end Do_Get;

   ----------------------
   -- Get_Servlet_Info --
   ----------------------

   overriding function Get_Servlet_Info
     (Self : Forum_Servlet)
      return League.Strings.Universal_String
   is
   begin
      return League.Strings.To_Universal_String ("Forum Servlet");
   end Get_Servlet_Info;

end Server.Servlets.Forum_Servlets;
