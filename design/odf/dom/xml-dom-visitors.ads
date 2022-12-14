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
with XML.DOM.Nodes.Character_Datas.Texts;
with XML.DOM.Nodes.Documents;
with XML.DOM.Nodes.Elements;

package XML.DOM.Visitors is

   type Traverse_Control is
    (Continue,
     Abandon_Children,
     Abandon_Sibling,
     Terminate_Immediately);

   ----------------------
   -- Abstract_Visitor --
   ----------------------

   type Abstract_Visitor is limited interface;

   not overriding procedure Enter_Document
    (Self    : in out Abstract_Visitor;
     Element : not null XML.DOM.Nodes.Documents.DOM_Document_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Document
    (Self    : in out Abstract_Visitor;
     Element : not null XML.DOM.Nodes.Documents.DOM_Document_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Element
    (Self    : in out Abstract_Visitor;
     Element : not null XML.DOM.Nodes.Elements.DOM_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Element
    (Self    : in out Abstract_Visitor;
     Element : not null XML.DOM.Nodes.Elements.DOM_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Text
    (Self    : in out Abstract_Visitor;
     Element : not null XML.DOM.Nodes.Character_Datas.Texts.DOM_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Text
    (Self    : in out Abstract_Visitor;
     Element : not null XML.DOM.Nodes.Character_Datas.Texts.DOM_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   -----------------------
   -- Abstract_Iterator --
   -----------------------

   type Abstract_Iterator is limited interface;

   procedure Visit
    (Self    : in out Abstract_Iterator'Class;
     Visitor : in out Abstract_Visitor'Class;
     Element : not null XML.DOM.Nodes.DOM_Node_Access;
     Control : in out Traverse_Control);
   --  Visit specified element by calling:
   --
   --   - Enter_<Class> operation on visitor;
   --
   --   - Visit_<Class> operation on iterator;
   --
   --   - Leave_<Class> operation on visitor.

   not overriding procedure Visit_Document
    (Self    : in out Abstract_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null XML.DOM.Nodes.Documents.DOM_Document_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Element
    (Self    : in out Abstract_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null XML.DOM.Nodes.Elements.DOM_Element_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Text
    (Self    : in out Abstract_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Element : not null XML.DOM.Nodes.Character_Datas.Texts.DOM_Text_Access;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

end XML.DOM.Visitors;
