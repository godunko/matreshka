------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Open Document Toolkit                           --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2014, Vadim Godunko <vgodunko@gmail.com>                     --
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
with League.Strings;

package Matreshka.ODF_String_Constants is

   Anim_URI         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:animation:1.0");
   Chart_URI        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:chart:1.0");
   Config_URI       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:config:1.0");
   DB_URI           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:database:1.0");
   Dr3D_URI         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0");
   Draw_URI         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:drawing:1.0");
   FO_URI           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0");
   Form_URI         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:form:1.0");
   GRDDL_URI        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://www.w3.org/2003/g/data-view#");
   Meta_URI         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:meta:1.0");
   Number_URI       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0");
   Office_URI       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:office:1.0");
   Presentation_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:presentation:1.0");
   Script_URI       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:script:1.0");
   SMIL_URI         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:smil-compatible:1.0");
   Style_URI        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:style:1.0");
   SVG_URI          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0");
   Table_URI        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:table:1.0");
   Text_URI         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("urn:oasis:names:tc:opendocument:xmlns:text:1.0");
   XForms_URI       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://www.w3.org/2002/xforms");
   XHTML_URI        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://www.w3.org/1999/xhtml");
   XLink_URI        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://www.w3.org/1999/xlink");
   XML_URI          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("");

     --  urn:oasis:names:tc:opendocument:xmlns:manifest:1.0
     --  urn:oasis:names:tc:opendocument:xmlns:digitalsignature:1.0
     --  urn:oasis:names:tc:opendocument:xmlns:of:1.2
     --
     --  http://docs.oasis-open.org/ns/office/1.2/meta/pkg#
     --  http://docs.oasis-open.org/ns/office/1.2/meta/odf#
     --  http://purl.org/dc/elements/1.1/
     --  http://www.w3.org/1998/Math/MathML
     --  http://www.w3.org/2000/09/xmldsig#
     --
     --
end Matreshka.ODF_String_Constants;
