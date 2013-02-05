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
private with Ada.Containers.Hashed_Maps;

with XML.DOM.Nodes.Attrs;

package XML.DOM.Nodes.Elements is

   type DOM_Element is abstract new DOM_Node with private;

   type DOM_Element_Access is access all DOM_Element'Class;

   function Set_Attribute_Node_NS
    (Self     : not null access DOM_Element'Class;
     New_Attr : not null XML.DOM.Nodes.Attrs.DOM_Attr_Access)
       return XML.DOM.Nodes.Attrs.DOM_Attr_Access;

   procedure Set_Attribute_Node_NS
    (Self     : not null access DOM_Element'Class;
     New_Attr : not null XML.DOM.Nodes.Attrs.DOM_Attr_Access);

   function Get_Attribute_Node_NS
    (Self          : not null access DOM_Element'Class;
     Namespace_URI : League.Strings.Universal_String;
     Local_Name    : League.Strings.Universal_String)
       return XML.DOM.Nodes.Attrs.DOM_Attr_Access;

private

   type Qualified_Name is record
      Namespace_URI : League.Strings.Universal_String;
      Local_Name    : League.Strings.Universal_String;
   end record;

   function Hash (Item : Qualified_Name) return Ada.Containers.Hash_Type;

   package Attribute_Maps is
     new Ada.Containers.Hashed_Maps
          (Qualified_Name,
           XML.DOM.Nodes.Attrs.DOM_Attr_Access,
           Hash,
           "=",
           XML.DOM.Nodes.Attrs."=");

   type DOM_Element is abstract new DOM_Node with record
      Attributes : Attribute_Maps.Map;
   end record;

end XML.DOM.Nodes.Elements;
