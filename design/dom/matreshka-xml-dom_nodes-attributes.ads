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

package Matreshka.XML.DOM_Nodes.Attributes is

   pragma Preelaborate;

   ------------------------
   -- Abstract_Attribute --
   ------------------------

   type Abstract_Attribute is
     abstract new Matreshka.XML.DOM_Nodes.Abstract_Node with null record;

   overriding function Get_Local_Name
    (Self : not null access Abstract_Attribute)
       return League.Strings.Universal_String is abstract;
   --  Returns the local part of the qualified name of this node.

   overriding function Get_Namespace_URI
    (Self : not null access Abstract_Attribute)
       return League.Strings.Universal_String is abstract;
   --  The namespace URI of this node, or null if it is unspecified (see XML
   --  Namespaces).

   overriding procedure Remove_From_Parent
    (Self : not null access Abstract_Attribute);
   --  Removes attribute node from corresponding list of nodes of parent node.
   --  In addition to default implementation it removes attribute node from
   --  the list of attribute nodes of parent element node.

   overriding procedure Enter_Element
    (Self    : not null access Abstract_Attribute;
     Visitor : in out Standard.XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out Standard.XML.DOM.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Leave_Element
    (Self    : not null access Abstract_Attribute;
     Visitor : in out Standard.XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out Standard.XML.DOM.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Visit_Element
    (Self     : not null access Abstract_Attribute;
     Iterator : in out Standard.XML.DOM.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Standard.XML.DOM.Visitors.Abstract_Visitor'Class;
     Control  : in out Standard.XML.DOM.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

   --------------------
   -- Attribute_Node --
   --------------------

   type Attribute_Node is new Abstract_Attribute with record
      Namespace_URI : League.Strings.Universal_String;
      Local_Name    : League.Strings.Universal_String;
   end record;

   overriding function Get_Local_Name
    (Self : not null access Attribute_Node)
       return League.Strings.Universal_String;
   --  Returns the local part of the qualified name of this node.

   overriding function Get_Namespace_URI
    (Self : not null access Attribute_Node)
       return League.Strings.Universal_String;
   --  The namespace URI of this node, or null if it is unspecified (see XML
   --  Namespaces).

   procedure Initialize
    (Self           : not null access Attribute_Node'Class;
     Document       : not null Matreshka.XML.DOM_Nodes.Document_Access;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String);

end Matreshka.XML.DOM_Nodes.Attributes;
