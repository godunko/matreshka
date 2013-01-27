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
-- Copyright © 2013, Vadim Godunko <vgodunko@gmail.com>                     --
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
private with League.Strings;
with XML.DOM.Nodes.Documents;
private with XML.DOM.Nodes.Elements;

with ODF.DOM.Elements.Office.Document_Styles;
with ODF.DOM.Elements.Office.Font_Face_Decls;
with ODF.DOM.Elements.Office.Styles;
with ODF.DOM.Elements.Style.Default_Style;
with ODF.DOM.Elements.Style.Font_Face;
with ODF.DOM.Elements.Style.Graphic_Properties;
with ODF.DOM.Elements.Style.Paragraph_Properties;

package ODF.DOM.Documents is

   type ODF_Document is new XML.DOM.Nodes.Documents.DOM_Document with private;

   function Create_Office_Document_Styles
    (Self : not null access ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Document_Styles.ODF_Office_Document_Styles_Access;

   function Create_Office_Font_Face_Decls
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Office.Font_Face_Decls.ODF_Office_Font_Face_Decls_Access;

   function Create_Office_Styles
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Office.Styles.ODF_Office_Styles_Access;

   function Create_Style_Default_Style
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style_Access;

   function Create_Style_Font_Face
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Font_Face.ODF_Style_Font_Face_Access;

   function Create_Style_Graphic_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Graphic_Properties.ODF_Style_Graphic_Properties_Access;

   function Create_Style_Paragraph_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Paragraph_Properties.ODF_Style_Paragraph_Properties_Access;

private

   type ODF_Document is
     new XML.DOM.Nodes.Documents.DOM_Document with null record;

   overriding function Create_Element_NS
    (Self           : not null access ODF_Document;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return XML.DOM.Nodes.Elements.DOM_Element_Access;

end ODF.DOM.Documents;
