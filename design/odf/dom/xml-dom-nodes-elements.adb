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
with League.Strings.Hash;

package body XML.DOM.Nodes.Elements is

   ----------
   -- Hash --
   ----------

   function Hash (Item : Qualified_Name) return Ada.Containers.Hash_Type is
      use type Ada.Containers.Hash_Type;

   begin
      return
        League.Strings.Hash (Item.Namespace_URI)
          + League.Strings.Hash (Item.Local_Name);
   end Hash;

   ------------------------
   -- Set_Attribute_Node --
   ------------------------

   function Set_Attribute_Node
    (Self     : not null access DOM_Element'Class;
     New_Attr : not null XML.DOM.Nodes.Attrs.DOM_Attr_Access)
       return XML.DOM.Nodes.Attrs.DOM_Attr_Access
   is
      Old           : XML.DOM.Nodes.Attrs.DOM_Attr_Access;
      Position      : Attribute_Maps.Cursor;
      Key           : Qualified_Name;

   begin
      --  Construct key to access attribute in the map.

      if New_Attr.Get_Local_Name.Is_Empty then
         raise Program_Error;

      else
         Key.Namespace_URI := New_Attr.Get_Namespace_URI;
         Key.Local_Name := New_Attr.Get_Local_Name;
      end if;

      --  Lookup for existing attribute.

      Position := Self.Attributes.Find (Key);

      if Attribute_Maps.Has_Element (Position) then
         Old := Attribute_Maps.Element (Position);
      end if;

      --  Insert or replace attribute in the map.

      XML.DOM.Nodes.Reference (XML.DOM.Nodes.DOM_Node_Access (New_Attr));
      Self.Attributes.Include (Key, New_Attr);

      return Old;
   end Set_Attribute_Node;

   ------------------------
   -- Set_Attribute_Node --
   ------------------------

   procedure Set_Attribute_Node
    (Self     : not null access DOM_Element'Class;
     New_Attr : not null XML.DOM.Nodes.Attrs.DOM_Attr_Access)
   is
      Aux : XML.DOM.Nodes.DOM_Node_Access
        := XML.DOM.Nodes.DOM_Node_Access (Self.Set_Attribute_Node (New_Attr));

   begin
      if Aux /= null then
         XML.DOM.Nodes.Dereference (Aux);
      end if;
   end Set_Attribute_Node;

end XML.DOM.Nodes.Elements;
