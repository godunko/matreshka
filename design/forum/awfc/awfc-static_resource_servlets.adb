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
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Ada.Streams.Stream_IO;

with Servlet.Contexts;
with League.String_Vectors;

package body AWFC.Static_Resource_Servlets is

   use type League.Strings.Universal_String;

   ------------
   -- Do_Get --
   ------------

   overriding procedure Do_Get
     (Self     : in out Static_Resource_Servlet;
      Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
      Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class)
   is
      Context      : constant access Servlet.Contexts.Servlet_Context'Class
        := Request.Get_Servlet_Context;
      Servlet_Path : constant League.String_Vectors.Universal_String_Vector
        := Request.Get_Servlet_Path;
      Path_Info    : constant League.String_Vectors.Universal_String_Vector
        := Request.Get_Path_Info;
      File_Name    : constant League.Strings.Universal_String
        := Context.Get_Real_Path
            ((if Servlet_Path.Is_Empty
                then League.Strings.Empty_Universal_String
                else '/' & Servlet_Path.Join ('/'))
               & (if Path_Info.Is_Empty
                    then League.Strings.Empty_Universal_String
                    else '/' & Path_Info.Join ('/')));
      --  Servlet_Path or Path_Info can be empty depending of used servlet
      --  mapping.
      File      : Ada.Streams.Stream_IO.File_Type;
      Buffer    : Ada.Streams.Stream_Element_Array (1 .. 512);
      Last      : Ada.Streams.Stream_Element_Offset;

   begin
      Response.Set_Status (Servlet.HTTP_Responses.OK);
      Response.Set_Content_Type
       (Context.Get_MIME_Type
         (if not Path_Info.Is_Empty
            then Path_Info (Path_Info.Length)
            else Servlet_Path (Servlet_Path.Length)));
      --  Path_Info can be empty depending of used servlet mapping.
      --  Servlet_Path contains all path information in this case.

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
    (Self : Static_Resource_Servlet) return League.Strings.Universal_String is
   begin
      return League.Strings.To_Universal_String ("Static Resources Servlet");
   end Get_Servlet_Info;

end AWFC.Static_Resource_Servlets;
