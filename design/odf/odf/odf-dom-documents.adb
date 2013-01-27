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
with ODF.Constants;

package body ODF.DOM.Documents is

   use ODF.Constants;

   function Get_Local_Name
    (Qualified_Name : League.Strings.Universal_String)
       return League.Strings.Universal_String;
   --  Returns local name part of the given qualified name.

   -----------------------
   -- Create_Element_NS --
   -----------------------

   overriding function Create_Element_NS
    (Self           : not null access ODF_Document;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return XML.DOM.Nodes.Elements.DOM_Element_Access
   is
      use type League.Strings.Universal_String;

      Local_Name : constant League.Strings.Universal_String
        := Get_Local_Name (Qualified_Name);

   begin
      if Namespace_URI = Office_URI then
         if Local_Name = Document_Styles_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Office_Document_Styles);

         elsif Local_Name = Font_Face_Decls_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Office_Font_Face_Decls);

         elsif Local_Name = Styles_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Office_Styles);

         else
            raise Program_Error;
         end if;

      elsif Namespace_URI = Style_URI then
         if Local_Name = Default_Style_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Default_Style);

         elsif Local_Name = Font_Face_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Font_Face);

         elsif Local_Name = Graphic_Properties_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Graphic_Properties);

         elsif Local_Name = Paragraph_Properties_Name then
            return
              XML.DOM.Nodes.Elements.DOM_Element_Access
               (Self.Create_Style_Paragraph_Properties);

         else
            raise Program_Error;
         end if;

      else
         raise Program_Error;
      end if;
   end Create_Element_NS;

   -----------------------------------
   -- Create_Office_Document_Styles --
   -----------------------------------

   function Create_Office_Document_Styles
    (Self : not null access ODF_Document'Class)
       return
         ODF.DOM.Elements.Office.Document_Styles.ODF_Office_Document_Styles_Access is
   begin
      return
        new ODF.DOM.Elements.Office.Document_Styles.ODF_Office_Document_Styles;
   end Create_Office_Document_Styles;

   -----------------------------------
   -- Create_Office_Font_Face_Decls --
   -----------------------------------

   function Create_Office_Font_Face_Decls
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Office.Font_Face_Decls.ODF_Office_Font_Face_Decls_Access is
   begin
      return
        new ODF.DOM.Elements.Office.Font_Face_Decls.ODF_Office_Font_Face_Decls;
   end Create_Office_Font_Face_Decls;

   --------------------------
   -- Create_Office_Styles --
   --------------------------

   function Create_Office_Styles
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Office.Styles.ODF_Office_Styles_Access is
   begin
      return new ODF.DOM.Elements.Office.Styles.ODF_Office_Styles;
   end Create_Office_Styles;

   --------------------------------
   -- Create_Style_Default_Style --
   --------------------------------

   function Create_Style_Default_Style
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style_Access is
   begin
      return new ODF.DOM.Elements.Style.Default_Style.ODF_Style_Default_Style;
   end Create_Style_Default_Style;

   ----------------------------
   -- Create_Style_Font_Face --
   ----------------------------

   function Create_Style_Font_Face
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Font_Face.ODF_Style_Font_Face_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Font_Face.ODF_Style_Font_Face;
   end Create_Style_Font_Face;

   -------------------------------------
   -- Create_Style_Graphic_Properties --
   -------------------------------------

   function Create_Style_Graphic_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Graphic_Properties.ODF_Style_Graphic_Properties_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Graphic_Properties.ODF_Style_Graphic_Properties;
   end Create_Style_Graphic_Properties;

   ---------------------------------------
   -- Create_Style_Paragraph_Properties --
   ---------------------------------------

   function Create_Style_Paragraph_Properties
    (Self : not null access ODF_Document'Class)
       return ODF.DOM.Elements.Style.Paragraph_Properties.ODF_Style_Paragraph_Properties_Access is
   begin
      return
        new ODF.DOM.Elements.Style.Paragraph_Properties.ODF_Style_Paragraph_Properties;
   end Create_Style_Paragraph_Properties;

   --------------------
   -- Get_Local_Name --
   --------------------

   function Get_Local_Name
    (Qualified_Name : League.Strings.Universal_String)
       return League.Strings.Universal_String
   is
      Index : constant Natural := Qualified_Name.Index (':');

   begin
      if Index = 0 then
         return Qualified_Name;

      else
         return Qualified_Name.Slice (Index + 1, Qualified_Name.Length);
      end if;
   end Get_Local_Name;

end ODF.DOM.Documents;
