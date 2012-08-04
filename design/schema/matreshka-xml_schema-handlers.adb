------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2012, Vadim Godunko <vgodunko@gmail.com>                     --
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

package body Matreshka.XML_Schema.Handlers is

   XML_Schema_Namespace_URI          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http:///");
   Schema_Element_Name               : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("schema");
   Attribute_Form_Default_Attribute_Name :
     constant League.Strings.Universal_String
       := League.Strings.To_Universal_String ("attributeFormDefault");
   Block_Default_Attribute_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("blockDefault");
   Default_Attributes_Attribute_Name : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("defaultAttributes");
   Element_Form_Default_Attribute_Name :
     constant League.Strings.Universal_String
       := League.Strings.To_Universal_String ("elementFormDefault");
   Final_Default_Attribute_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("finalDefault");
   Id_Attribute_Name                 : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("id");
   Target_Namespace_Attribute_Name   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("targetNamespace");
   Version_Attribute_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("version");
   Xpath_Default_Namespace_Attribute_Name :
     constant League.Strings.Universal_String
       := League.Strings.To_Universal_String ("xpathDefaultNamespace");

   procedure Start_Schema_Element
    (Self       : in out XML_Schema_Handler;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean);
   --  Process start of 'schema' element.

   -----------------
   -- End_Element --
   -----------------

   overriding procedure End_Element
    (Self           : in out XML_Schema_Handler;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean) is
   begin
      null;
   end End_Element;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : XML_Schema_Handler) return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out XML_Schema_Handler;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean)
   is
      use type League.Strings.Universal_String;

   begin
      if Namespace_URI = XML_Schema_Namespace_URI then
         if Local_Name = Schema_Element_Name then
            Start_Schema_Element (Self, Attributes, Success);

         else
            raise Program_Error;
         end if;

      else
         raise Program_Error;
      end if;
   end Start_Element;

   --------------------------
   -- Start_Schema_Element --
   --------------------------

   procedure Start_Schema_Element
    (Self       : in out XML_Schema_Handler;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean)
   is
      Index : Natural;

   begin
      Self.Schema := new Matreshka.XML_Schema.AST.Schemas.Schema_Node;

      --  XXX  attributeFormDefault
      --  XXX  blockDefault
      --  XXX  defaultAttributes
      --  XXX  elementFormDefault
      --  XXX  finalDefault
      --  XXX  id

      --  targetNamespace

      Index :=
        Attributes.Index
         (XML_Schema_Namespace_URI, Target_Namespace_Attribute_Name);

      if Index /= 0 then
         Self.Schema.Target_Namespace := Attributes.Value (Index);
         Self.Schema.Target_Namespace_Defined := True;

      else
         Self.Schema.Target_Namespace_Defined := False;
      end if;

      --  XXX  version
      --  XXX  xpathDefaultNamespace

      --  XXX  xml:lang

   end Start_Schema_Element;

end Matreshka.XML_Schema.Handlers;
