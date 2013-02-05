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
with GNATCOLL.JSON;

with XML.DOM.Visitors;

with ODF.DOM.Iterators;

with ODF.Web.Builder;

package body ODF.Web is

   Json_Mime_Type : constant String := "application/json";

   --------------
   -- Callback --
   --------------

   function Callback (Request : AWS.Status.Data) return AWS.Response.Data is
   begin
      return
        AWS.Response.Build
         (JSON_Mime_Type, To_JSON (Document.Styles, Document.Content));
   end Callback;

   -------------
   -- To_JSON --
   -------------

   function To_JSON
    (Styles  : not null ODF.DOM.Documents.ODF_Document_Access;
     Content : not null ODF.DOM.Documents.ODF_Document_Access)
       return String
   is
      Builder  : ODF.Web.Builder.JSON_Builder;
      Iterator : ODF.DOM.Iterators.ODF_Iterator;
      Control  : XML.DOM.Visitors.Traverse_Control
        := XML.DOM.Visitors.Continue;

   begin
      Iterator.Visit (Builder, Styles.Get_First_Child, Control);
      Iterator.Visit (Builder, Content.Get_First_Child, Control);
      --  XXX It is better to use 'element' instead of 'firstChild'.

      return GNATCOLL.JSON.Write (Builder.Get_Document);
   end To_JSON;

end ODF.Web;
