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
--  This file is generated, don't edit it.
------------------------------------------------------------------------------
--  The most general class for Styles in UML.
------------------------------------------------------------------------------
with AMF.DI.Styles;
with AMF.UML.Packageable_Elements;

package AMF.UMLDI.UML_Styles is

   pragma Preelaborate;

   type UMLDI_UML_Style is limited interface
     and AMF.UML.Packageable_Elements.UML_Packageable_Element
     and AMF.DI.Styles.DI_Style;

   type UMLDI_UML_Style_Access is
     access all UMLDI_UML_Style'Class;
   for UMLDI_UML_Style_Access'Storage_Size use 0;

   not overriding function Get_Font_Name
    (Self : not null access constant UMLDI_UML_Style)
       return AMF.Optional_String is abstract;
   --  Getter of UMLStyle::fontName.
   --
   --  Name of a font used to render strings.

   not overriding procedure Set_Font_Name
    (Self : not null access UMLDI_UML_Style;
     To   : AMF.Optional_String) is abstract;
   --  Setter of UMLStyle::fontName.
   --
   --  Name of a font used to render strings.

   not overriding function Get_Font_Size
    (Self : not null access constant UMLDI_UML_Style)
       return AMF.Optional_Real is abstract;
   --  Getter of UMLStyle::fontSize.
   --
   --  Size of a font for rendering strings, given in typographical points.

   not overriding procedure Set_Font_Size
    (Self : not null access UMLDI_UML_Style;
     To   : AMF.Optional_Real) is abstract;
   --  Setter of UMLStyle::fontSize.
   --
   --  Size of a font for rendering strings, given in typographical points.

end AMF.UMLDI.UML_Styles;
