------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Ada Modeling Framework                          --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2010-2012, Vadim Godunko <vgodunko@gmail.com>                --
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
private with Ada.Containers.Hashed_Maps;

private with League.Strings.Hash;
private with XML.SAX.Attributes;
with XML.SAX.Content_Handlers;
with XML.SAX.Error_Handlers;
private with XML.SAX.Locators;
private with XML.SAX.Parse_Exceptions;

private with AMF.CMOF.Packages;
private with AMF.CMOF.Properties;
private with AMF.Elements;
with AMF.Internals.XMI_Readers;
with AMF.URI_Stores;

package AMF.Internals.XMI_Handlers is

   type XMI_Handler
    (Context : not null access AMF.Internals.XMI_Readers.XMI_Reader'Class) is
       limited new XML.SAX.Content_Handlers.SAX_Content_Handler
         and XML.SAX.Error_Handlers.SAX_Error_Handler with private;

   function Extent (Self : XMI_Handler) return AMF.URI_Stores.URI_Store_Access;

   function Extent
    (URI : League.Strings.Universal_String)
       return AMF.URI_Stores.URI_Store_Access;
   --  Returns extent with specified URI.
   --
   --  XXX Should be removed

private

   package Element_Vectors is
     new Ada.Containers.Vectors
          (Positive, AMF.Elements.Element_Access, AMF.Elements."=");

   type Postponed_Link is record
      Element   : AMF.Elements.Element_Access;
      Attribute : AMF.CMOF.Properties.CMOF_Property_Access;
      Id        : League.Strings.Universal_String;
   end record;

   package Postponed_Link_Vectors is
     new Ada.Containers.Vectors (Positive, Postponed_Link);

   package String_Element_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           AMF.Elements.Element_Access,
           League.Strings.Hash,
           League.Strings."=",
           AMF.Elements."=");

   package String_Package_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           AMF.CMOF.Packages.CMOF_Package_Access,
           League.Strings.Hash,
           League.Strings."=",
           AMF.CMOF.Packages."=");

   type XMI_Handler
    (Context : not null access AMF.Internals.XMI_Readers.XMI_Reader'Class) is
       limited new XML.SAX.Content_Handlers.SAX_Content_Handler
         and XML.SAX.Error_Handlers.SAX_Error_Handler with
   record
      Extent             : AMF.URI_Stores.URI_Store_Access;
      Current            : AMF.Elements.Element_Access;
      Stack              : Element_Vectors.Vector;
      Attribute          : AMF.CMOF.Properties.CMOF_Property_Access;
      Text               : League.Strings.Universal_String;
      Collect_Text       : Boolean := False;
      Mapping            : String_Element_Maps.Map;
      Postponed          : Postponed_Link_Vectors.Vector;
      Skip_Element       : Natural := 0;
      XMI_Namespace      : League.Strings.Universal_String;
      --  Actual namespace of the XMI document.
      URI_Package_Map    : String_Package_Maps.Map;
      Prefix_Package_Map : String_Package_Maps.Map;
      --  Mapping from namespace URI and namespace prefix to the package of the
      --  corresponding metamodel.
      Diagnosis          : League.Strings.Universal_String;
      Locator            : XML.SAX.Locators.SAX_Locator;
   end record;

   overriding procedure Characters
    (Self    : in out XMI_Handler;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean);

   overriding procedure End_Document
    (Self    : in out XMI_Handler;
     Success : in out Boolean);

   overriding procedure End_Element
    (Self           : in out XMI_Handler;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean);

   overriding function Error_String
    (Self : XMI_Handler) return League.Strings.Universal_String;

   overriding procedure Fatal_Error
    (Self       : in out XMI_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception);

   overriding procedure Set_Document_Locator
    (Self    : in out XMI_Handler;
     Locator : XML.SAX.Locators.SAX_Locator);

   overriding procedure Start_Document
    (Self    : in out XMI_Handler;
     Success : in out Boolean);

   overriding procedure Start_Element
    (Self           : in out XMI_Handler;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean);

   overriding procedure Start_Prefix_Mapping
    (Self          : in out XMI_Handler;
     Prefix        : League.Strings.Universal_String;
     Namespace_URI : League.Strings.Universal_String;
     Success       : in out Boolean);

end AMF.Internals.XMI_Handlers;
