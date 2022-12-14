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
-- Copyright © 2011-2012, Vadim Godunko <vgodunko@gmail.com>                --
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
with AMF.Internals.UML_Elements;
with AMF.UML.Images;
with AMF.Visitors;

package AMF.Internals.UML_Images is

   type UML_Image_Proxy is
     limited new AMF.Internals.UML_Elements.UML_Element_Proxy
       and AMF.UML.Images.UML_Image with null record;

   overriding function Get_Content
    (Self : not null access constant UML_Image_Proxy)
       return AMF.Optional_String;
   --  Getter of Image::content.
   --
   --  This contains the serialization of the image according to the format.
   --  The value could represent a bitmap, image such as a GIF file, or
   --  drawing 'instructions' using a standard such as Scalable Vector Graphic
   --  (SVG) (which is XML based).

   overriding procedure Set_Content
    (Self : not null access UML_Image_Proxy;
     To   : AMF.Optional_String);
   --  Setter of Image::content.
   --
   --  This contains the serialization of the image according to the format.
   --  The value could represent a bitmap, image such as a GIF file, or
   --  drawing 'instructions' using a standard such as Scalable Vector Graphic
   --  (SVG) (which is XML based).

   overriding function Get_Format
    (Self : not null access constant UML_Image_Proxy)
       return AMF.Optional_String;
   --  Getter of Image::format.
   --
   --  This indicates the format of the content - which is how the string
   --  content should be interpreted. The following values are reserved: SVG,
   --  GIF, PNG, JPG, WMF, EMF, BMP. In addition the prefix 'MIME: ' is also
   --  reserved. This option can be used as an alternative to express the
   --  reserved values above, for example 'SVG' could instead be expressed as
   --  'MIME: image/svg+xml'.

   overriding procedure Set_Format
    (Self : not null access UML_Image_Proxy;
     To   : AMF.Optional_String);
   --  Setter of Image::format.
   --
   --  This indicates the format of the content - which is how the string
   --  content should be interpreted. The following values are reserved: SVG,
   --  GIF, PNG, JPG, WMF, EMF, BMP. In addition the prefix 'MIME: ' is also
   --  reserved. This option can be used as an alternative to express the
   --  reserved values above, for example 'SVG' could instead be expressed as
   --  'MIME: image/svg+xml'.

   overriding function Get_Location
    (Self : not null access constant UML_Image_Proxy)
       return AMF.Optional_String;
   --  Getter of Image::location.
   --
   --  This contains a location that can be used by a tool to locate the image
   --  as an alternative to embedding it in the stereotype.

   overriding procedure Set_Location
    (Self : not null access UML_Image_Proxy;
     To   : AMF.Optional_String);
   --  Setter of Image::location.
   --
   --  This contains a location that can be used by a tool to locate the image
   --  as an alternative to embedding it in the stereotype.

   overriding procedure Enter_Element
    (Self    : not null access constant UML_Image_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Leave_Element
    (Self    : not null access constant UML_Image_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Visit_Element
    (Self     : not null access constant UML_Image_Proxy;
     Iterator : in out AMF.Visitors.Abstract_Iterator'Class;
     Visitor  : in out AMF.Visitors.Abstract_Visitor'Class;
     Control  : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

end AMF.Internals.UML_Images;
