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
with Ada.Tags;    use Ada.Tags;
with Ada.Text_IO; use Ada.Text_IO;

with XML.DOM.Nodes;

with ODF.DOM.Elements.Office.Bodies;
with ODF.DOM.Elements.Office.Document_Content;
with ODF.DOM.Elements.Office.Text;
with ODF.DOM.Elements.Table.Table;
with ODF.DOM.Elements.Text.P;
with ODF.DOM.Elements.Text.Sequence_Decls;

with GNATCOLL.JSON;

package body ODF.Web is

   use type XML.DOM.Nodes.DOM_Node_Access;

   Json_Mime_Type : constant String := "application/json";

   function Text_To_JSON
    (Text : not null ODF.DOM.Elements.Office.Text.ODF_Office_Text_Access)
       return String;

   procedure To_JSON
    (Node   : not null ODF.DOM.Elements.Table.Table.ODF_Table_Table_Access;
     Object : out GNATCOLL.JSON.JSON_Value);

   procedure To_JSON
    (Node   : not null ODF.DOM.Elements.Text.P.ODF_Text_P_Access;
     Object : out GNATCOLL.JSON.JSON_Value);

   --------------
   -- Callback --
   --------------

   function Callback (Request : AWS.Status.Data) return AWS.Response.Data is
   begin
      return AWS.Response.Build (JSON_Mime_Type, To_JSON (Document));
   end Callback;

   ------------------
   -- Text_To_JSON --
   ------------------

   function Text_To_JSON
    (Text : not null ODF.DOM.Elements.Office.Text.ODF_Office_Text_Access)
       return String
   is
      Node     : XML.DOM.Nodes.DOM_Node_Access := Text.Get_First_Child;
      Object   : GNATCOLL.JSON.JSON_Value := GNATCOLL.JSON.Create_Object;
      Children : GNATCOLL.JSON.JSON_Array;
      Aux      : GNATCOLL.JSON.JSON_Value;

   begin
      while Node /= null loop
         if Node.all
           in ODF.DOM.Elements.Text.Sequence_Decls.ODF_Text_Sequence_Decls'Class
         then
            null;

         elsif Node.all
           in ODF.DOM.Elements.Table.Table.ODF_Table_Table'Class
         then
            To_JSON
             (ODF.DOM.Elements.Table.Table.ODF_Table_Table_Access (Node), Aux);
            GNATCOLL.JSON.Append (Children, Aux);

         elsif Node.all in ODF.DOM.Elements.Text.P.ODF_Text_P'Class then
            To_JSON (ODF.DOM.Elements.Text.P.ODF_Text_P_Access (Node), Aux);
            GNATCOLL.JSON.Append (Children, Aux);

         else
            Put_Line (External_Tag (Node'Tag));

            raise Program_Error;
         end if;

         Node := Node.Get_Next_Sibling;
      end loop;

      Object.Set_Field ("children", Children);
      Object.Set_Field ("__type", "OdfOfficeText");

      return GNATCOLL.JSON.Write (Object);
   end Text_To_JSON;

   -------------
   -- To_JSON --
   -------------

   function To_JSON
    (Document : not null ODF.DOM.Documents.ODF_Document_Access)
       return String
   is
      Node : XML.DOM.Nodes.DOM_Node_Access := Document.Get_First_Child;

   begin
      --  Check for office:document-content element.

      if Node.all
        not in ODF.DOM.Elements.Office.Document_Content.ODF_Office_Document_Content'Class
      then
         raise Program_Error;
      end if;

      --  Lookop for office:body element.

      Node := Node.Get_First_Child;

      while Node /= null loop
         exit when Node.all
           in ODF.DOM.Elements.Office.Bodies.ODF_Office_Body'Class;

         Node := Node.Get_Next_Sibling;
      end loop;

      --  Lookup for office:text element.

      Node := Node.Get_First_Child;

      while Node /= null loop
         exit when Node.all
           in ODF.DOM.Elements.Office.Text.ODF_Office_Text'Class;

         Node := Node.Get_Next_Sibling;
      end loop;

      return
        Text_To_JSON
         (ODF.DOM.Elements.Office.Text.ODF_Office_Text_Access (Node));
   end To_JSON;

   -------------
   -- To_JSON --
   -------------

   procedure To_JSON
    (Node   : not null ODF.DOM.Elements.Table.Table.ODF_Table_Table_Access;
     Object : out GNATCOLL.JSON.JSON_Value) is
   begin
      Object := GNATCOLL.JSON.Create_Object;
      Object.Set_Field ("__type", "OdfTableTable");
   end To_JSON;

   -------------
   -- To_JSON --
   -------------

   procedure To_JSON
    (Node   : not null ODF.DOM.Elements.Text.P.ODF_Text_P_Access;
     Object : out GNATCOLL.JSON.JSON_Value) is
   begin
      Object := GNATCOLL.JSON.Create_Object;
      Object.Set_Field ("__type", "OdfTextP");
   end To_JSON;

end ODF.Web;
