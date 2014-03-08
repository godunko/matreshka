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
with Ada.Strings.Hash;
with System.Address_Image;

with AWS.Translator;

with League.JSON.Documents;
with League.Stream_Element_Vectors;
with XML.DOM.Visitors;

with ODF.DOM.Iterators.Containment;

with ODF.Web.Applier;
with ODF.Web.Builder;

package body ODF.Web is

   Json_Mime_Type : constant String := "application/json";
   Text_Mime_Type : constant String := "text/text";

   ---------------------
   -- Change_Callback --
   ---------------------

   function Change_Callback
    (Request : AWS.Status.Data) return AWS.Response.Data is
   begin
      ODF.Web.Applier.Apply
       (League.JSON.Documents.From_JSON
         (League.Stream_Element_Vectors.To_Stream_Element_Vector
           (AWS.Status.Binary_Data (Request))).To_Object);

      return AWS.Response.Build (Text_Mime_Type, "OK");
   end Change_Callback;

   ------------------
   -- Get_Callback --
   ------------------

   function Get_Callback
    (Request : AWS.Status.Data) return AWS.Response.Data is
   begin
      return
        AWS.Response.Build
         (JSON_Mime_Type, To_JSON (Document.Styles, Document.Content));
   end Get_Callback;

   ----------
   -- Hash --
   ----------

   function Hash (Item : Positive) return Ada.Containers.Hash_Type is
   begin
      return Ada.Containers.Hash_Type (Item);
   end Hash;

--   ----------
--   -- Hash --
--   ----------
--
--   function Hash
--    (Item : XML.DOM.Nodes.DOM_Node) return Ada.Containers.Hash_Type
--   is
----      use type XML.DOM.Nodes.DOM_Node_Access;
--
--   begin
--      if Item = null then
--         return 0;
--
--      else
--         return Ada.Strings.Hash (System.Address_Image (Item.all'Address));
--      end if;
--   end Hash;

   -------------
   -- To_JSON --
   -------------

   function To_JSON
    (Styles  : not null ODF.DOM.Office_Document_Styles_Elements.ODF_Office_Document_Styles_Access;
     Content : not null ODF.DOM.Office_Document_Content_Elements.ODF_Office_Document_Content_Access)
       return String
   is
      Builder  : ODF.Web.Builder.JSON_Builder;
      Iterator : ODF.DOM.Iterators.Containment.ODF_Containment_Iterator;
      Control  : XML.DOM.Visitors.Traverse_Control
        := XML.DOM.Visitors.Continue;

   begin
      Iterator.Visit (Builder, XML.DOM.Nodes.DOM_Node_Access (Styles), Control);
      Iterator.Visit (Builder, XML.DOM.Nodes.DOM_Node_Access (Content), Control);

      return
        League.JSON.Documents.To_JSON_Document
         (Builder.Get_Document).To_JSON.To_UTF_8_String;
--      return GNATCOLL.JSON.Write (Builder.Get_Document);
--      return GNATCOLL.JSON.Write (Builder.Get_Document);
   end To_JSON;

end ODF.Web;
