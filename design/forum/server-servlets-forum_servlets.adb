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
with League.Holders.JSON_Arrays;
with League.Holders.JSON_Objects;
with League.IRIs;
with League.JSON.Arrays;
with League.JSON.Objects;
with League.JSON.Values;

with Forum.Topics.References;

package body Server.Servlets.Forum_Servlets is

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   ---------------------
   -- Bind_Parameters --
   ---------------------

   overriding procedure Bind_Parameters
    (Self      : in out Forum_List_Page;
     Processor : in out XML.Templates.Processors.Template_Processor'Class)
   is
      List : League.JSON.Arrays.JSON_Array;

   begin
      for J of Self.Categories loop
         declare
            Object : League.JSON.Objects.JSON_Object;
            IRI    : League.IRIs.IRI;

         begin
            --  Category URL has form <forum>/category/page
            IRI.Set_Absolute_Path (Self.Path);
            IRI.Append_Segment
              (Forum.Categories.Encode (J.Object.Get_Identifier));
            --  First page
            IRI.Append_Segment (+"1");

            Object.Insert
              (+"id",
               League.JSON.Values.To_JSON_Value (IRI.To_Universal_String));
            Object.Insert
              (+"title",
               League.JSON.Values.To_JSON_Value (J.Object.Get_Title));
            Object.Insert
              (+"description",
               League.JSON.Values.To_JSON_Value (J.Object.Get_Description));
            List.Append (Object.To_JSON_Value);
         end;
      end loop;

      Processor.Set_Parameter
        (+"list", League.Holders.JSON_Arrays.To_Holder (List));
   end Bind_Parameters;

   ---------------------
   -- Bind_Parameters --
   ---------------------

   overriding procedure Bind_Parameters
    (Self      : in out Topic_List_Page;
     Processor : in out XML.Templates.Processors.Template_Processor'Class)
   is
      List : League.JSON.Arrays.JSON_Array;
      Last : constant Integer :=
        Self.Category.Object.Get_Topic_Count;
      Topics : constant Forum.Topics.References.Topic_Vector :=
        Self.Category.Object.Get_Topics (1, Last);
   begin
      declare
         Object : League.JSON.Objects.JSON_Object;
      begin
         Object.Insert
           (+"title",
            League.JSON.Values.To_JSON_Value (Self.Category.Object.Get_Title));

         Object.Insert
           (+"description",
            League.JSON.Values.To_JSON_Value
              (Self.Category.Object.Get_Description));

         Processor.Set_Parameter
           (+"category", League.Holders.JSON_Objects.To_Holder (Object));
      end;

      for J of Topics loop
         declare
            Object : League.JSON.Objects.JSON_Object;
            IRI    : League.IRIs.IRI;

         begin
            --  Topic URL has form <forum>/category/topic/page
            IRI.Set_Absolute_Path (Self.Path);
            IRI.Append_Segment
              (Forum.Categories.Encode (Self.Category.Object.Get_Identifier));

            IRI.Append_Segment
              (Forum.Topics.Encode (J.Object.Get_Identifier));

            --  First page
            IRI.Append_Segment (+"1");

            Object.Insert
              (+"id",
               League.JSON.Values.To_JSON_Value (IRI.To_Universal_String));
            Object.Insert
              (+"title",
               League.JSON.Values.To_JSON_Value (J.Object.Get_Title));
            Object.Insert
              (+"description",
               League.JSON.Values.To_JSON_Value (J.Object.Get_Description));
            List.Append (Object.To_JSON_Value);
         end;
      end loop;

      Processor.Set_Parameter
        (+"list", League.Holders.JSON_Arrays.To_Holder (List));
   end Bind_Parameters;

   ------------
   -- Do_Get --
   ------------

   overriding procedure Do_Get
    (Self     : in out Forum_Servlet;
     Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
     Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class)
   is

      function Get_Page_Number
        (Image : League.Strings.Universal_String;
         Page  : out Positive) return Boolean;

      ---------------------
      -- Get_Page_Number --
      ---------------------

      function Get_Page_Number
        (Image : League.Strings.Universal_String;
         Page  : out Positive) return Boolean
      is
      begin
         Page := Positive'Wide_Wide_Value (Image.To_Wide_Wide_String);
         return True;
      exception
         when Constraint_Error =>
            return False;
      end Get_Page_Number;

      Path : constant League.String_Vectors.Universal_String_Vector
        := Request.Get_Path_Info;
      Category : Forum.Categories.Category_Identifier;
      Page     : Positive := 1;
   begin
      if Path.Length = 0 then
         Self.Get_Categories (Request, Response);

         return;
      elsif Path.Length in 1 .. 2 then
         if Forum.Categories.Decode (Path (1), Category) then

            if Path.Length = 1 or else Get_Page_Number (Path (2), Page) then
               Self.Get_Topics (Category, Page, Request, Response);

               return;
            end if;
         end if;
      end if;

      --  Report error when decoding of URL fails
      Response.Set_Status (Servlet.HTTP_Responses.Not_Found);
      Response.Set_Content_Type (+"text/plain");

   end Do_Get;

   --------------------
   -- Get_Categories --
   --------------------

   not overriding procedure Get_Categories
     (Self     : in out Forum_Servlet;
      Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
      Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class)
   is
      Forum_List : Forum_List_Page;

      Path : League.String_Vectors.Universal_String_Vector
        := Request.Get_Servlet_Path;

   begin
      Path.Prepend
        (League.String_Vectors.Universal_String_Vector'
           (Request.Get_Context_Path));

      Response.Set_Status (Servlet.HTTP_Responses.OK);
      Response.Set_Content_Type (+"text/html");
      Response.Set_Character_Encoding (+"UTF-8");
      Response.Get_Output_Stream.Write
       (Self.Forum_List.Render
         (Request.Get_Session.all, Path, Self.Server.Get_Categories));
   end Get_Categories;

   ----------------------
   -- Get_Servlet_Info --
   ----------------------

   overriding function Get_Servlet_Info
    (Self : Forum_Servlet) return League.Strings.Universal_String is
   begin
      return League.Strings.To_Universal_String ("Forum Servlet");
   end Get_Servlet_Info;

   ----------------
   -- Get_Topics --
   ----------------

   not overriding procedure Get_Topics
     (Self     : in out Forum_Servlet;
      Category : Forum.Categories.Category_Identifier;
      Page     : Positive;
      Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
      Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class)
   is
      Found : Boolean;
      Path  : League.String_Vectors.Universal_String_Vector
        := Request.Get_Servlet_Path;

   begin
      Path.Prepend
        (League.String_Vectors.Universal_String_Vector'
           (Request.Get_Context_Path));

      Self.Topic_List.Path := Path;

      Self.Server.Get_Category
        (Identifier => Category,
         Category   => Self.Topic_List.Category,
         Found      => Found);

      if not Found then
         Response.Set_Status (Servlet.HTTP_Responses.Not_Found);
         Response.Set_Content_Type (+"text/plain");
         return;
      end if;

      Response.Set_Status (Servlet.HTTP_Responses.OK);
      Response.Set_Content_Type (+"text/html");
      Response.Set_Character_Encoding (+"UTF-8");
      Response.Get_Output_Stream.Write
       (Self.Topic_List.Render (Request.Get_Session.all));
   end Get_Topics;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize
    (Self   : in out Forum_Servlet;
     Config : not null access Servlet.Configs.Servlet_Config'Class) is
   begin
      Servlet.HTTP_Servlets.HTTP_Servlet (Self).Initialize (Config);
      Self.Forum_List.Initialize
       (Config.Get_Servlet_Context,
        +"/WEB-INF/templates/page.xhtml.tmpl",
        +"/WEB-INF/templates/forum_list.xhtml.tmpl");
      Self.Topic_List.Initialize
       (Config.Get_Servlet_Context,
        +"/WEB-INF/templates/page.xhtml.tmpl",
        +"/WEB-INF/templates/topic_list.xhtml.tmpl");
   end Initialize;

   ------------
   -- Render --
   ------------

   function Render
    (Self       : in out Forum_List_Page'Class;
     Session    : Servlet.HTTP_Sessions.HTTP_Session'Class;
     Path       : League.String_Vectors.Universal_String_Vector;
     Categories : Forum.Categories.References.Category_Vector)
       return League.Strings.Universal_String is
   begin
      Self.Categories := Categories;
      Self.Path       := Path;

      return Self.Render (Session);
   end Render;

end Server.Servlets.Forum_Servlets;
