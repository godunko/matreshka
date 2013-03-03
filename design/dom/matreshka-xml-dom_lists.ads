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
--  This package provides implementation of doubly linked lists of nodes and
--  attributes.
------------------------------------------------------------------------------
with Matreshka.XML.DOM_Nodes;

package Matreshka.XML.DOM_Lists is

   pragma Preelaborate;

   procedure Append_Detached_Node
    (Document : not null Matreshka.XML.DOM_Nodes.Document_Access;
     Node     : not null Matreshka.XML.DOM_Nodes.Node_Access);
   --  Appends detached (newly created) node to the list of detaches nodes of
   --  the document.

   procedure Append_Attribute_Node
    (Element   : not null Matreshka.XML.DOM_Nodes.Element_Access;
     Attribute : not null Matreshka.XML.DOM_Nodes.Attribute_Access);
   --  Append attribute node to the list of attribute nodes of element node.
   --  Attribute node must be detached node.

   procedure Append_Child_Node
    (Node  : not null Matreshka.XML.DOM_Nodes.Node_Access;
     Child : not null Matreshka.XML.DOM_Nodes.Node_Access);
   --  Append node to the list of children nodes of node.

   procedure Detach_From_Parent
    (Node : not null Matreshka.XML.DOM_Nodes.Node_Access);
   --  Remove node from the corresponding list of the parent node and
   --  decrements counters accordingly.

--   ---------------
--   -- Node_List --
--   ---------------
--
--   type Node_List is private;
--
--   type Node_List_Entry is private;
--
----   procedure Append
----    (Owner : not null Matreshka.XML.DOM_Nodes.Node_Access;
----     List  : in out Node_List;
----     Node  : not null Matreshka.XML.DOM_Nodes.Node_Access;
----     Item  : in out Node_List_Entry);
--
--   --------------------
--   -- Attribute_List --
--   --------------------
--
--   type Attribute_List is private;
--
--   type Attribute_List_Entry is private;
--
--private
--
--   type Node_List is record
--      First : Matreshka.XML.DOM_Nodes.Node_Access;
--      Last  : Matreshka.XML.DOM_Nodes.Node_Access;
--   end record;
--
--   type Node_List_Entry is record
--      Previous : Matreshka.XML.DOM_Nodes.Node_Access;
--      Next     : Matreshka.XML.DOM_Nodes.Node_Access;
--   end record;
--
--   type Attribute_List is record
--      First : Matreshka.XML.DOM_Nodes.Attribute_Access;
--      Last  : Matreshka.XML.DOM_Nodes.Attribute_Access;
--   end record;
--
--   type Attribute_List_Entry is record
--      Previous : Matreshka.XML.DOM_Nodes.Attribute_Access;
--      Next     : Matreshka.XML.DOM_Nodes.Attribute_Access;
--   end record;

end Matreshka.XML.DOM_Lists;
