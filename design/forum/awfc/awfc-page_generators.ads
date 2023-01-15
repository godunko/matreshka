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
-- Copyright © 2015-2023, Vadim Godunko <vgodunko@gmail.com>                --
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

--  Base type to generate HTML page using two templates: page template and
--  content template.

with League.Strings;
with Servlet.Contexts;
with XML.Templates.Processors;
with XML.Templates.Streams;

package AWFC.Page_Generators is

   type Abstract_Rendering_Context is abstract tagged limited null record;
   --  Rendering context is a set of application specific data to bind
   --  parameters of templates processor.

   type Abstract_Page_Generator is abstract tagged limited private;

   procedure Initialize
    (Self             : in out Abstract_Page_Generator'Class;
     Context          :
       not null access constant Servlet.Contexts.Servlet_Context'Class;
     Page_Template    : League.Strings.Universal_String;
     Content_Template : League.Strings.Universal_String);

   function Render
    (Self    : in out Abstract_Page_Generator'Class;
     Context : Abstract_Rendering_Context'Class)
       return League.Strings.Universal_String;

   not overriding procedure Bind_Parameters
    (Self    : in out Abstract_Page_Generator;
     Context : Abstract_Rendering_Context'Class;
     Writer  : in out XML.Templates.Processors.Template_Processor'Class)
       is null;
   --  Derived type can override this subprogram to bind own parameters for
   --  template parser.

   function Get_Page_Template_Stream
     (Self : Abstract_Page_Generator'Class)
      return XML.Templates.Streams.XML_Stream_Element_Vectors.Vector;
   --  Return XML event stream of the page template.

private

   type Abstract_Page_Generator is abstract tagged limited record
      Page : XML.Templates.Streams.XML_Stream_Element_Vectors.Vector;
   end record;

end AWFC.Page_Generators;
