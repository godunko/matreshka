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
with Matreshka.DOM_Nodes.Elements;
with XML.DOM.Nodes.Attributes.Internals;

package body XML.DOM.Nodes.Elements is

   ---------------------------
   -- Get_Attribute_Node_NS --
   ---------------------------

   function Get_Attribute_Node_NS
    (Self          : DOM_Element'Class;
     Namespace_URI : League.Strings.Universal_String;
     Local_Name    : League.Strings.Universal_String)
       return XML.DOM.Nodes.Attributes.DOM_Attribute is
   begin
      return
        XML.DOM.Nodes.Attributes.Internals.Create
         (Matreshka.DOM_Nodes.Element_Access
           (Self.Node).Get_Attribute_Node (Namespace_URI, Local_Name));
   end Get_Attribute_Node_NS;

   ----------------------
   -- Get_Attribute_NS --
   ----------------------

   function Get_Attribute_NS
    (Self          : in out DOM_Element'Class;
     Namespace_URI : League.Strings.Universal_String;
     Local_Name    : League.Strings.Universal_String)
       return League.Strings.Universal_String
   is
      Attribute : constant XML.DOM.Nodes.Attributes.DOM_Attribute
        := Self.Get_Attribute_Node_NS (Namespace_URI, Local_Name);

   begin
      if Attribute.Is_Null then
         return League.Strings.Empty_Universal_String;

      else
         return Attribute.Get_Value;
      end if;
   end Get_Attribute_NS;

   ---------------------------
   -- Set_Attribute_Node_NS --
   ---------------------------

   function Set_Attribute_Node_NS
    (Self : in out DOM_Element'Class;
     Attr : XML.DOM.Nodes.Attributes.DOM_Attribute)
       return XML.DOM.Nodes.Attributes.DOM_Attribute is
   begin
      return
        XML.DOM.Nodes.Attributes.Internals.Wrap
         (Matreshka.DOM_Nodes.Elements.Abstract_Element'Class
           (Self.Node.all).Set_Attribute_Node
             (XML.DOM.Nodes.Attributes.Internals.Internal (Attr)));
   end Set_Attribute_Node_NS;

end XML.DOM.Nodes.Elements;
