------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2011, Vadim Godunko <vgodunko@gmail.com>                     --
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
--  This package provides implementation of 'visitors' pattern to process XML
--  DOM.
------------------------------------------------------------------------------
with XML.DOM.Attributes;
with XML.DOM.Documents;
with XML.DOM.Elements;
with XML.DOM.Nodes;

package XML.DOM.Visitors is

   pragma Preelaborate;

   type Traverse_Control is
    (Continue,
     Abandon_Children,
     Abandon_Sibling,
     Terminate_Immediately);

   ----------------------
   -- Abstract_Visitor --
   ----------------------

   type Abstract_Visitor is limited interface;

   not overriding procedure Enter_Attribute
    (Self    : in out Abstract_Visitor;
     Node    : XML.DOM.Attributes.DOM_Attribute'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Attribute
    (Self    : in out Abstract_Visitor;
     Node    : XML.DOM.Attributes.DOM_Attribute'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Document
    (Self    : in out Abstract_Visitor;
     Node    : XML.DOM.Documents.DOM_Document'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Document
    (Self    : in out Abstract_Visitor;
     Node    : XML.DOM.Documents.DOM_Document'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Element
    (Self    : in out Abstract_Visitor;
     Node    : XML.DOM.Elements.DOM_Element'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Element
    (Self    : in out Abstract_Visitor;
     Node    : XML.DOM.Elements.DOM_Element'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   -----------------------
   -- Abstract_Iterator --
   -----------------------

   type Abstract_Iterator is limited interface;

   procedure Visit
    (Self    : in out Abstract_Iterator'Class;
     Visitor : in out Abstract_Visitor'Class;
     Node    : XML.DOM.Nodes.DOM_Node'Class;
     Control : in out Traverse_Control);
   --  Visit specified element by calling:
   --
   --   - Enter_<Node> operation on visitor;
   --
   --   - Visit_<Node> operation on iterator;
   --
   --   - Leave_<Node> operation on visitor.

   not overriding procedure Visit_Attribute
    (Self    : in out Abstract_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : XML.DOM.Attributes.DOM_Attribute'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Document
    (Self    : in out Abstract_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : XML.DOM.Documents.DOM_Document'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Element
    (Self    : in out Abstract_Iterator;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Node    : XML.DOM.Elements.DOM_Element'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is null;

end XML.DOM.Visitors;
