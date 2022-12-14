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
-- Copyright © 2016, Vadim Godunko <vgodunko@gmail.com>                     --
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
private with Ada.Containers.Vectors;

private with League.Strings;
private with XML.SAX.Attributes;
with XML.SAX.Content_Handlers;

package Matreshka.Spikedog_Deployment_Descriptors.Parsers is

   type Deployment_Descriptor_Parser is
     limited new XML.SAX.Content_Handlers.SAX_Content_Handler with private;

   procedure Set_Deployment_Descriptor
    (Self       : in out Deployment_Descriptor_Parser'Class;
     Descriptor : Deployment_Descriptor_Access);
   --  Set deployment descriptor object to be filled during parsing.

private

   type States is
    (Initial,
     Web_App,
     Library_Name,
     Servlet,
     Servlet_Name,
     Servlet_Tag,
     Servlet_Mapping,
     URL_Pattern);

   package State_Vectors is new Ada.Containers.Vectors (Positive, States);

   type Deployment_Descriptor_Parser is
     limited new XML.SAX.Content_Handlers.SAX_Content_Handler with record
      State        : States;
      Stack        : State_Vectors.Vector;
      Diagnosis    : League.Strings.Universal_String;
      Text         : League.Strings.Universal_String;
      Descriptor   : Deployment_Descriptor_Access;
      Servlet_Name : League.Strings.Universal_String;
      Servlet_Tag  : League.Strings.Universal_String;
      URL_Patterns : League.String_Vectors.Universal_String_Vector;
   end record;

   overriding procedure Characters
    (Self    : in out Deployment_Descriptor_Parser;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean);

   overriding procedure End_Element
    (Self           : in out Deployment_Descriptor_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean);

   overriding function Error_String
    (Self : Deployment_Descriptor_Parser)
       return League.Strings.Universal_String;

   overriding procedure Start_Document
    (Self    : in out Deployment_Descriptor_Parser;
     Success : in out Boolean);

   overriding procedure Start_Element
    (Self           : in out Deployment_Descriptor_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean);

   not overriding procedure Push
    (Self  : in out Deployment_Descriptor_Parser;
     State : States);
   --  Push given state into state stack.

   not overriding procedure Pop (Self : in out Deployment_Descriptor_Parser);
   --  Pop state stack to previous state.

   not overriding procedure Error_Unexpected_Tag
    (Self       : in out Deployment_Descriptor_Parser;
     Local_Name : League.Strings.Universal_String;
     Success    : out Boolean);
   --  Reports "unexpected tag" error. Sets Success to False.

end Matreshka.Spikedog_Deployment_Descriptors.Parsers;
