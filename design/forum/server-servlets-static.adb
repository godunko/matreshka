with Ada.Streams.Stream_IO;

with Servlet.Contexts;
with League.String_Vectors;

package body Server.Servlets.Static is

   use type League.Strings.Universal_String;

   ------------
   -- Do_Get --
   ------------

   overriding procedure Do_Get
     (Self     : in out Resource_Servlet;
      Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
      Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class)
   is
      Context   : constant access Servlet.Contexts.Servlet_Context'Class
        := Request.Get_Servlet_Context;
      Path      : constant League.String_Vectors.Universal_String_Vector
        := Request.Get_Servlet_Path;
      File_Name : constant League.Strings.Universal_String
        := Context.Get_Real_Path ('/' & Path.Join ('/'));
      File      : Ada.Streams.Stream_IO.File_Type;
      Buffer    : Ada.Streams.Stream_Element_Array (1 .. 512);
      Last      : Ada.Streams.Stream_Element_Offset;

   begin
      Response.Set_Status (Servlet.HTTP_Responses.OK);
      Response.Set_Content_Type (Context.Get_MIME_Type (Path (Path.Length)));

      Ada.Streams.Stream_IO.Open
       (File, Ada.Streams.Stream_IO.In_File, File_Name.To_UTF_8_String);

      while not Ada.Streams.Stream_IO.End_Of_File (File) loop
         Ada.Streams.Stream_IO.Read (File, Buffer, Last);
         Response.Get_Output_Stream.Write (Buffer (Buffer'First .. Last));
      end loop;

      Ada.Streams.Stream_IO.Close (File);
   end Do_Get;

   ----------------------
   -- Get_Servlet_Info --
   ----------------------

   overriding function Get_Servlet_Info
     (Self : Resource_Servlet)
      return League.Strings.Universal_String
   is
   begin
      return League.Strings.To_Universal_String ("Static Resources Servlet");
   end Get_Servlet_Info;

end Server.Servlets.Static;
