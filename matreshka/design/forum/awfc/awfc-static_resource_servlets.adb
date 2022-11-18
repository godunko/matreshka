------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2015-2017, Vadim Godunko <vgodunko@gmail.com>                --
-- All rights reserved.                                                     --
--                                                                          --
-- Redistribution and use in source and binary forms, with or without       --
-- modification, are permitted provided that the following conditions       --
-- are met:                                                                 --
--                                                                          --
--  * Redistributions of source code must retain the above copyright        --
--    notice, this list of conditions and the following disclaimer.         --
--                                                                          --
--  * Redistributions in binary form must reproduce the above copyright     --
--    notice, this list of conditions and the following disclaimer in the   --
--    documentation and/or other materials provided with the distribution.  --
--                                                                          --
--  * Neither the name of the Vadim Godunko, IE nor the names of its        --
--    contributors may be used to endorse or promote products derived from  --
--    this software without specific prior written permission.              --
--                                                                          --
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     --
-- HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   --
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED --
-- TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   --
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   --
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     --
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       --
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------
with Ada.Directories;
with Ada.Streams.Stream_IO;

with League.Calendars.Ada_Conversions;
with League.IRIs;
with League.String_Vectors;
with Servlet.Contexts;

package body AWFC.Static_Resource_Servlets is

   function Get_File_Name
     (Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class)
       return League.Strings.Universal_String;
   --  Return virtual file name in context space

   ------------
   -- Do_Get --
   ------------

   overriding procedure Do_Get
     (Self     : in out Static_Resource_Servlet;
      Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
      Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class)
   is
      pragma Unreferenced (Self);

      use type Ada.Directories.File_Kind;

      Context   : constant access Servlet.Contexts.Servlet_Context'Class
        := Request.Get_Servlet_Context;
      File_Name : constant League.Strings.Universal_String
        := Get_File_Name (Request);
      Real_Name : constant League.Strings.Universal_String
        := Context.Get_Real_Path (File_Name);
      Name      : constant String := Real_Name.To_UTF_8_String;
      File      : Ada.Streams.Stream_IO.File_Type;
      Buffer    : Ada.Streams.Stream_Element_Array (1 .. 512);
      Last      : Ada.Streams.Stream_Element_Offset;
      Location  : League.IRIs.IRI;
      Path      : League.String_Vectors.Universal_String_Vector;

   begin
      if not Ada.Directories.Exists (Name) then
         Response.Set_Status (Servlet.HTTP_Responses.Not_Found);

         return;

      elsif Ada.Directories.Kind (Name) = Ada.Directories.Directory then
         --  Redirect browser to retrieve directory content.

         Location := Request.Get_Request_URL;
         Path     := Location.Get_Path;
         Path.Append (League.Strings.Empty_Universal_String);
         Location.Set_Absolute_Path (Path);
         Response.Send_Redirect (Location);

         return;
      end if;

      Response.Set_Status (Servlet.HTTP_Responses.OK);
      Response.Set_Content_Type (Context.Get_MIME_Type (File_Name));

      Ada.Streams.Stream_IO.Open
       (File, Ada.Streams.Stream_IO.In_File, Name, "SHARED=NO");
      --  Disable GNAT check to prevent open of file multiple times.

      while not Ada.Streams.Stream_IO.End_Of_File (File) loop
         Ada.Streams.Stream_IO.Read (File, Buffer, Last);
         Response.Get_Output_Stream.Write (Buffer (Buffer'First .. Last));
      end loop;

      Ada.Streams.Stream_IO.Close (File);
   end Do_Get;

   -------------------
   -- Get_File_Name --
   -------------------

   function Get_File_Name
     (Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class)
       return League.Strings.Universal_String
   is
      Servlet_Path : constant League.String_Vectors.Universal_String_Vector
        := Request.Get_Servlet_Path;
      Path_Info    : constant League.String_Vectors.Universal_String_Vector
        := Request.Get_Path_Info;
      Path         : League.String_Vectors.Universal_String_Vector;
   begin
      --  Add empty string to have leading '/'
      Path.Append (League.Strings.Empty_Universal_String);
      Path.Append (Servlet_Path);

      if not Path_Info.Is_Empty
        and then Path_Info (Path_Info.Length).Is_Empty
      then
         --  By convention, last element is empty string when directory content
         --  is requested. It is expected to be in 'index.html' file.

         Path.Append (Path_Info.Slice (1, Path_Info.Length - 1));
         Path.Append (League.Strings.To_Universal_String ("index.html"));

      else
         Path.Append (Path_Info);
      end if;

      return Path.Join ('/');
   end Get_File_Name;

   -----------------------
   -- Get_Last_Modified --
   -----------------------

   overriding function Get_Last_Modified
    (Self     : in out Static_Resource_Servlet;
     Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class)
      return League.Calendars.Date_Time
   is
      Context   : constant access Servlet.Contexts.Servlet_Context'Class
        := Request.Get_Servlet_Context;
      File_Name : constant League.Strings.Universal_String
        := Get_File_Name (Request);
      Real_Name : constant League.Strings.Universal_String
        := Context.Get_Real_Path (File_Name);
      Name      : constant String := Real_Name.To_UTF_8_String;
   begin
      if Ada.Directories.Exists (Name) then
         return League.Calendars.Ada_Conversions.From_Ada_Time
           (Ada.Directories.Modification_Time (Name));
      else
         return Servlet.HTTP_Servlets.HTTP_Servlet (Self).Get_Last_Modified
                  (Request);
      end if;
   end Get_Last_Modified;

   ----------------------
   -- Get_Servlet_Info --
   ----------------------

   overriding function Get_Servlet_Info (Self : Static_Resource_Servlet)
     return League.Strings.Universal_String
   is
      pragma Unreferenced (Self);
   begin
      return League.Strings.To_Universal_String ("Static Resources Servlet");
   end Get_Servlet_Info;

   -----------------
   -- Instantiate --
   -----------------

   overriding function Instantiate
    (Parameters : not null access
       Servlet.Generic_Servlets.Instantiation_Parameters'Class)
         return Static_Resource_Servlet
   is
      pragma Unreferenced (Parameters);
   begin
      return (Servlet.HTTP_Servlets.HTTP_Servlet with null record);
   end Instantiate;

end AWFC.Static_Resource_Servlets;
