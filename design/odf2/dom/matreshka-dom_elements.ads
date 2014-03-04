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
with League.Strings;

with Matreshka.DOM_Nodes;
with XML.DOM.Attributes;
with XML.DOM.Elements;
with XML.DOM.Visitors;

package Matreshka.DOM_Elements is

   pragma Preelaborate;

   type Abstract_Element_Node is
     abstract new Matreshka.DOM_Nodes.Node
       and XML.DOM.Elements.DOM_Element with
   record
      First_Attribute : Matreshka.DOM_Nodes.Node_Access;
      Last_Attribute  : Matreshka.DOM_Nodes.Node_Access;
   end record;

   overriding procedure Enter_Node
    (Self    : not null access Abstract_Element_Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding function Get_Node_Type
    (Self : not null access constant Abstract_Element_Node)
       return XML.DOM.Node_Type;

   overriding function Get_Tag_Name
    (Self : not null access constant Abstract_Element_Node)
       return League.Strings.Universal_String;

   overriding function Get_Node_Name
    (Self : not null access constant Abstract_Element_Node)
       return League.Strings.Universal_String renames Get_Tag_Name;

   overriding procedure Leave_Node
    (Self    : not null access Abstract_Element_Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding function Set_Attribute_Node_NS
    (Self     : not null access Abstract_Element_Node;
     New_Attr : not null XML.DOM.Attributes.DOM_Attribute_Access)
       return XML.DOM.Attributes.DOM_Attribute_Access;

   overriding procedure Visit_Node
    (Self     : not null access Abstract_Element_Node;
     Iterator : in out XML.DOM.Visitors.Abstract_Iterator'Class;
     Visitor  : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control  : in out XML.DOM.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

   type Element_Node is new Abstract_Element_Node
     and XML.DOM.Elements.DOM_Element with
   record
      Namespace_URI : League.Strings.Universal_String;
      Prefix        : League.Strings.Universal_String;
      Local_Name    : League.Strings.Universal_String;
   end record;

   overriding function Get_Local_Name
    (Self : not null access constant Element_Node)
       return League.Strings.Universal_String;

   overriding function Get_Namespace_URI
    (Self : not null access constant Element_Node)
       return League.Strings.Universal_String;

   package Constructors is

      procedure Initialize
       (Self     : not null access Abstract_Element_Node'Class;
        Document : not null Matreshka.DOM_Nodes.Document_Access);

      procedure Initialize
       (Self          : not null access Element_Node'Class;
        Document      : not null Matreshka.DOM_Nodes.Document_Access;
        Namespace_URI : League.Strings.Universal_String;
        Prefix        : League.Strings.Universal_String;
        Local_Name    : League.Strings.Universal_String);

   end Constructors;

end Matreshka.DOM_Elements;
