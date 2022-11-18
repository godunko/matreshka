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
with XML.DOM.Nodes;
with Matreshka.DOM_Documents;

package body Matreshka.ODF_Packages is

   use type XML.DOM.Nodes.DOM_Node_Access;

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize (Self : not null access Package_Node'Class) is
      begin
         --  XXX Constructors nested package must be added for ODF_Documents.
--         Matreshka.ODF_Documents.Constructors.Initialize (Self);
         Matreshka.DOM_Documents.Constructors.Initialize (Self);
      end Initialize;

   end Constructors;

   ----------------
   -- Get_Styles --
   ----------------

   overriding function Get_Styles
    (Self : not null access constant Package_Node)
       return ODF.DOM.Office_Document_Styles_Elements.ODF_Office_Document_Styles_Access
   is
      Current : XML.DOM.Nodes.DOM_Node_Access := Self.Get_First_Child;

   begin
      while Current /= null loop
         exit when Current.all in ODF.DOM.Office_Document_Styles_Elements.ODF_Office_Document_Styles'Class;

         Current := Current.Get_Next_Sibling;
      end loop;

      return ODF.DOM.Office_Document_Styles_Elements.ODF_Office_Document_Styles_Access (Current);
   end Get_Styles;

   -----------------
   -- Get_Content --
   -----------------

   overriding function Get_Content
    (Self : not null access constant Package_Node)
       return ODF.DOM.Office_Document_Content_Elements.ODF_Office_Document_Content_Access
   is
      Current : XML.DOM.Nodes.DOM_Node_Access := Self.Get_First_Child;

   begin
      while Current /= null loop
         exit when Current.all in ODF.DOM.Office_Document_Content_Elements.ODF_Office_Document_Content'Class;

         Current := Current.Get_Next_Sibling;
      end loop;

      return ODF.DOM.Office_Document_Content_Elements.ODF_Office_Document_Content_Access (Current);
   end Get_Content;

end Matreshka.ODF_Packages;
