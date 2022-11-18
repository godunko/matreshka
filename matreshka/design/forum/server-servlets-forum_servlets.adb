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
with League.Calendars.ISO_8601;
with League.Holders.Booleans;
with League.Holders.JSON_Arrays;
with League.Holders.JSON_Objects;
with League.JSON.Arrays;
with League.JSON.Objects;
with League.JSON.Values;

with AWFC.Accounts.Users;

with Forum.Categories.Objects;
with Forum.Posts.References;

package body Server.Servlets.Forum_Servlets is

   Page_Size : constant := 20;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   function Category_To_JSON
     (Self : Forum.Categories.References.Category)
      return League.JSON.Objects.JSON_Object;

   function Topic_To_JSON
     (Self : Forum.Topics.References.Topic)
      return League.JSON.Objects.JSON_Object;

   function Post_To_JSON
     (Self : Forum.Posts.References.Post)
      return League.JSON.Objects.JSON_Object;

   function Page_To_JSON
     (Page  : Positive;
      Total : Positive)
      return League.JSON.Objects.JSON_Object;

   function User_To_JSON
     (Self : AWFC.Accounts.Users.User_Access)
      return League.JSON.Objects.JSON_Object;

   Format : constant League.Strings.Universal_String :=
     +"yyyy-MM-dd HH:mm:ss";

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
         List.Append (Category_To_JSON (J).To_JSON_Value);
      end loop;

      Processor.Set_Parameter
        (+"base", League.Holders.To_Holder (Self.Base.To_Universal_String));

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
      Topics : constant Forum.Topics.References.Topic_Vector :=
        Self.Category.Object.Get_Topics
          (From => (Self.Page - 1) * Page_Size + 1,
           To   => Self.Page * Page_Size);
   begin
      Processor.Set_Parameter
        (+"category",
         League.Holders.JSON_Objects.To_Holder
           (Category_To_JSON (Self.Category)));

      Processor.Set_Parameter
        (+"page",
         League.Holders.JSON_Objects.To_Holder
           (Page_To_JSON (Self.Page, Self.Category.Object.Get_Topic_Count)));

      for J of Topics loop
         List.Append (Topic_To_JSON (J).To_JSON_Value);
      end loop;

      Processor.Set_Parameter
        (+"base", League.Holders.To_Holder (Self.Base.To_Universal_String));

      Processor.Set_Parameter
        (+"list", League.Holders.JSON_Arrays.To_Holder (List));
   end Bind_Parameters;

   ---------------------
   -- Bind_Parameters --
   ---------------------

   overriding procedure Bind_Parameters
    (Self      : in out Post_List_Page;
     Processor : in out XML.Templates.Processors.Template_Processor'Class)
   is
      List  : League.JSON.Arrays.JSON_Array;
      Posts : constant Forum.Posts.References.Post_Vector :=
        Self.Topic.Object.Get_Posts
          (From => (Self.Page - 1) * Page_Size + 1,
           To   => Self.Page * Page_Size);
   begin
      Processor.Set_Parameter
        (+"category",
         League.Holders.JSON_Objects.To_Holder
           (Category_To_JSON (Self.Category)));

      Processor.Set_Parameter
        (+"topic",
         League.Holders.JSON_Objects.To_Holder
           (Topic_To_JSON (Self.Topic)));

      Processor.Set_Parameter
        (+"page",
         League.Holders.JSON_Objects.To_Holder
           (Page_To_JSON (Self.Page, Self.Topic.Object.Get_Post_Count)));

      for J of Posts loop
         List.Append (Post_To_JSON (J).To_JSON_Value);
      end loop;

      Processor.Set_Parameter
        (+"base", League.Holders.To_Holder (Self.Base.To_Universal_String));

      Processor.Set_Parameter
        (+"list", League.Holders.JSON_Arrays.To_Holder (List));
   end Bind_Parameters;

   ----------------------
   -- Category_To_JSON --
   ----------------------

   function Category_To_JSON
     (Self : Forum.Categories.References.Category)
      return League.JSON.Objects.JSON_Object is
   begin
      return Result : League.JSON.Objects.JSON_Object do
         Result.Insert
           (+"id",
            League.JSON.Values.To_JSON_Value
              (Forum.Categories.Encode (Self.Object.Get_Identifier)));

         Result.Insert
           (+"title",
            League.JSON.Values.To_JSON_Value (Self.Object.Get_Title));

         Result.Insert
           (+"description",
            League.JSON.Values.To_JSON_Value (Self.Object.Get_Description));

         Result.Insert
           (+"topic_count",
            League.JSON.Values.To_JSON_Value
              (+Natural'Wide_Wide_Image (Self.Object.Get_Topic_Count)));

      end return;
   end Category_To_JSON;

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
      Topic    : Forum.Topics.Topic_Identifier;
      Page     : Positive := 1;
   begin
      if Path.Length = 0 then
         Self.Get_Categories (Request, Response);

         return;
      elsif Path.Length = 2 then
         if Forum.Categories.Decode (Path (1), Category)
           and then Get_Page_Number (Path (2), Page)
         then
            Self.Get_Topics (Category, Page, Request, Response);

            return;
         end if;
      elsif Path.Length = 3 then
         if Forum.Categories.Decode (Path (1), Category)
           and then Forum.Topics.Decode (Path (2), Topic)
           and then Get_Page_Number (Path (3), Page)
         then
            Self.Get_Posts (Category, Topic, Page, Request, Response);

            return;
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

   ---------------
   -- Get_Posts --
   ---------------

   not overriding procedure Get_Posts
     (Self     : in out Forum_Servlet;
      Category : Forum.Categories.Category_Identifier;
      Topic    : Forum.Topics.Topic_Identifier;
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

      Self.Post_List.Base.Set_Absolute_Path (Path);
      Self.Post_List.Page := Page;

      Self.Server.Get_Category
        (Identifier => Category,
         Value      => Self.Post_List.Category,
         Found      => Found);

      if not Found then
         Response.Set_Status (Servlet.HTTP_Responses.Not_Found);
         Response.Set_Content_Type (+"text/plain");
         return;
      end if;

      Self.Server.Get_Topic
        (Identifier => Topic,
         Category   => Category,
         Value      => Self.Post_List.Topic,
         Found      => Found);

      if not Found then
         Response.Set_Status (Servlet.HTTP_Responses.Not_Found);
         Response.Set_Content_Type (+"text/plain");
         return;
      end if;

      Response.Set_Status (Servlet.HTTP_Responses.OK);
      Response.Set_Content_Type (+"text/html");
      Response.Set_Character_Encoding (+"UTF-8");
      Response.Get_Output_Stream.Write (Self.Post_List.Render);
   end Get_Posts;

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

      Self.Topic_List.Base.Set_Absolute_Path (Path);
      Self.Topic_List.Page := Page;

      Self.Server.Get_Category
        (Identifier => Category,
         Value      => Self.Topic_List.Category,
         Found      => Found);

      if not Found then
         Response.Set_Status (Servlet.HTTP_Responses.Not_Found);
         Response.Set_Content_Type (+"text/plain");
         return;
      end if;

      Response.Set_Status (Servlet.HTTP_Responses.OK);
      Response.Set_Content_Type (+"text/html");
      Response.Set_Character_Encoding (+"UTF-8");
      Response.Get_Output_Stream.Write (Self.Topic_List.Render);
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
      Self.Post_List.Initialize
       (Config.Get_Servlet_Context,
        +"/WEB-INF/templates/page.xhtml.tmpl",
        +"/WEB-INF/templates/post_list.xhtml.tmpl");
   end Initialize;

   ------------------
   -- Page_To_JSON --
   ------------------

   function Page_To_JSON
     (Page  : Positive;
      Total : Positive)
      return League.JSON.Objects.JSON_Object
   is
      function To_JSON_Value
        (Value : Natural) return League.JSON.Values.JSON_Value;

      -------------------
      -- To_JSON_Value --
      -------------------

      function To_JSON_Value
        (Value : Natural) return League.JSON.Values.JSON_Value
      is
         Image : constant Wide_Wide_String := Natural'Wide_Wide_Image (Value);
      begin
         return League.JSON.Values.To_JSON_Value (+Image (2 .. Image'Last));
      end To_JSON_Value;

      Total_Pages : constant Positive :=
        (Total - 1 + Page_Size) / Page_Size;
   begin
      return Result : League.JSON.Objects.JSON_Object do
         Result.Insert (+"current", To_JSON_Value (Page));
         Result.Insert (+"total", To_JSON_Value (Total_Pages));
         Result.Insert (+"prev", To_JSON_Value (Page - 1));
         Result.Insert (+"next", To_JSON_Value (Page + 1));
         Result.Insert
           (+"has_prev",
            League.JSON.Values.To_JSON_Value (Page > 1));
         Result.Insert
           (+"has_next",
            League.JSON.Values.To_JSON_Value (Page < Total_Pages));
         Result.Insert
           (+"single",
            League.JSON.Values.To_JSON_Value (Total_Pages = 1));
      end return;
   end Page_To_JSON;

   ------------------
   -- Post_To_JSON --
   ------------------

   function Post_To_JSON
     (Self : Forum.Posts.References.Post)
      return League.JSON.Objects.JSON_Object is
   begin
      return Result : League.JSON.Objects.JSON_Object do
         Result.Insert
           (+"id",
            League.JSON.Values.To_JSON_Value
              (Forum.Posts.Encode (Self.Object.Get_Identifier)));
         Result.Insert
           (+"text",
            League.JSON.Values.To_JSON_Value (Self.Object.Get_Text));
         Result.Insert
           (+"creation_time",
            League.JSON.Values.To_JSON_Value
              (League.Calendars.ISO_8601.Image
                   (Format, Self.Object.Get_Creation_Time)));
         Result.Insert
           (+"author",
            User_To_JSON (Self.Object.Get_Author).To_JSON_Value);
      end return;
 end Post_To_JSON;

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
      Self.Base.Set_Absolute_Path (Path);

      return Self.Render;
   end Render;

   -------------------
   -- Topic_To_JSON --
   -------------------

   function Topic_To_JSON
     (Self : Forum.Topics.References.Topic)
      return League.JSON.Objects.JSON_Object
   is
   begin
      return Result : League.JSON.Objects.JSON_Object do
         Result.Insert
           (+"id",
            League.JSON.Values.To_JSON_Value
              (Forum.Topics.Encode (Self.Object.Get_Identifier)));
         Result.Insert
           (+"title",
            League.JSON.Values.To_JSON_Value (Self.Object.Get_Title));
         Result.Insert
           (+"description",
            League.JSON.Values.To_JSON_Value (Self.Object.Get_Description));
         Result.Insert
           (+"creation_time",
            League.JSON.Values.To_JSON_Value
              (League.Calendars.ISO_8601.Image
                   (Format, Self.Object.Get_Creation_Time)));
         Result.Insert
           (+"created_by",
            User_To_JSON (Self.Object.Get_Created_By).To_JSON_Value);
         Result.Insert
           (+"last_post",
            Post_To_JSON (Self.Object.Get_Last_Post).To_JSON_Value);
         Result.Insert
           (+"post_count",
            League.JSON.Values.To_JSON_Value
              (+Natural'Wide_Wide_Image (Self.Object.Get_Post_Count)));
      end return;
   end Topic_To_JSON;

   ------------------
   -- User_To_JSON --
   ------------------

   function User_To_JSON
     (Self : AWFC.Accounts.Users.User_Access)
      return League.JSON.Objects.JSON_Object
   is
      Email : constant League.Strings.Universal_String := Self.Get_Email;
   begin
      return Result : League.JSON.Objects.JSON_Object do
         Result.Insert
           (+"email",
            League.JSON.Values.To_JSON_Value (Email));
         Result.Insert
           (+"nick",
            League.JSON.Values.To_JSON_Value
              (Email.Head (Email.Index ("@") - 1)));
      end return;
   end User_To_JSON;

end Server.Servlets.Forum_Servlets;
