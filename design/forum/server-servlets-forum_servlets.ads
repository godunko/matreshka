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
with League.IRIs;
with League.String_Vectors;
with League.Strings;
with XML.Templates.Processors;

with Servlet.Configs;
with Servlet.HTTP_Requests;
with Servlet.HTTP_Responses;
with Servlet.HTTP_Servlets;
with Servlet.HTTP_Sessions;

with AWFC.Page_Generators;

with Forum.Categories.References;
with Forum.Topics.References;
with Forum.Forums.Servers;

package Server.Servlets.Forum_Servlets is

   type Forum_List_Page is
     new AWFC.Page_Generators.Abstract_Page_Generator with record
      Base       : League.IRIs.IRI;
      Categories : Forum.Categories.References.Category_Vector;
   end record;

   function Render
    (Self       : in out Forum_List_Page'Class;
     Session    : Servlet.HTTP_Sessions.HTTP_Session'Class;
     Path       : League.String_Vectors.Universal_String_Vector;
     Categories : Forum.Categories.References.Category_Vector)
       return League.Strings.Universal_String;

   overriding procedure Bind_Parameters
    (Self      : in out Forum_List_Page;
     Processor : in out XML.Templates.Processors.Template_Processor'Class);

   type Topic_List_Page is
     new AWFC.Page_Generators.Abstract_Page_Generator with record
      Base     : League.IRIs.IRI;
      Category : Forum.Categories.References.Category;
      Page     : Positive;
   end record;

   overriding procedure Bind_Parameters
    (Self      : in out Topic_List_Page;
     Processor : in out XML.Templates.Processors.Template_Processor'Class);

   type Post_List_Page is
     new AWFC.Page_Generators.Abstract_Page_Generator with record
      Base     : League.IRIs.IRI;
      Category : Forum.Categories.References.Category;
      Topic    : Forum.Topics.References.Topic;
      Page     : Positive;
   end record;

   overriding procedure Bind_Parameters
    (Self      : in out Post_List_Page;
     Processor : in out XML.Templates.Processors.Template_Processor'Class);

   type Forum_Servlet is
     new Servlet.HTTP_Servlets.HTTP_Servlet with record
      Server     : Forum.Forums.Servers.Server_Forum;
      Forum_List : Forum_List_Page;
      Topic_List : Topic_List_Page;
      Post_List  : Post_List_Page;
   end record;

   type Forum_Servlet_Access is access all Forum_Servlet'Class;

   overriding procedure Do_Get
    (Self     : in out Forum_Servlet;
     Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
     Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class);

   overriding function Get_Servlet_Info
    (Self : Forum_Servlet) return League.Strings.Universal_String;

   overriding procedure Initialize
    (Self   : in out Forum_Servlet;
     Config : not null access Servlet.Configs.Servlet_Config'Class);

   not overriding procedure Get_Categories
     (Self     : in out Forum_Servlet;
      Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
      Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class);

   not overriding procedure Get_Topics
     (Self     : in out Forum_Servlet;
      Category : Forum.Categories.Category_Identifier;
      Page     : Positive;
      Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
      Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class);

   not overriding procedure Get_Posts
     (Self     : in out Forum_Servlet;
      Category : Forum.Categories.Category_Identifier;
      Topic    : Forum.Topics.Topic_Identifier;
      Page     : Positive;
      Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
      Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class);

end Server.Servlets.Forum_Servlets;
