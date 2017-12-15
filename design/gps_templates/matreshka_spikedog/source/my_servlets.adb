package body My_Servlets is

   Text_Encoding : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("utf-8");
   Text_Plain    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("text/plain");

   ------------
   -- Do_Get --
   ------------

   overriding procedure Do_Get
    (Self     : in out My_Servlet;
     Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
     Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class) is
   begin
      Response.Set_Status (Servlet.HTTP_Responses.OK);
      Response.Set_Content_Type (Text_Plain);
      Response.Set_Character_Encoding (Text_Encoding);
      Response.Get_Output_Stream.Write
       (League.Strings.To_Universal_String ("Hello, World!"));
   end Do_Get;

   ----------------------
   -- Get_Servlet_Info --
   ----------------------

   overriding function Get_Servlet_Info
    (Self : My_Servlet) return League.Strings.Universal_String is
   begin
      return
        League.Strings.To_Universal_String ("Hello, World!");
   end Get_Servlet_Info;

   -----------------
   -- Instantiate --
   -----------------

   overriding function Instantiate
    (Parameters : not null access
       Servlet.Generic_Servlets.Instantiation_Parameters'Class)
         return My_Servlet
   is
      pragma Unreferenced (Parameters);

   begin
      return (Servlet.HTTP_Servlets.HTTP_Servlet with null record);
   end Instantiate;

end My_Servlets;
