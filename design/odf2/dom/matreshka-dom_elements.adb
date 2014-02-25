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
with Matreshka.DOM_Attributes;
with Matreshka.DOM_Documents;

package body Matreshka.DOM_Elements is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self     : not null access Element_Node'Class;
        Document : not null Matreshka.DOM_Nodes.Document_Access) is
      begin
         Matreshka.DOM_Nodes.Constructors.Initialize (Self, Document);
      end Initialize;

   end Constructors;

   ----------------
   -- Enter_Node --
   ----------------

   overriding procedure Enter_Node
    (Self    : not null access Element_Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Visitor.Enter_Element
       (XML.DOM.Elements.DOM_Element_Access (Self), Control);
   end Enter_Node;

   -------------------
   -- Get_Node_Type --
   -------------------

   overriding function Get_Node_Type
    (Self : not null access constant Element_Node)
       return XML.DOM.Node_Type
   is
      pragma Unreferenced (Self);

   begin
      return XML.DOM.Element_Node;
   end Get_Node_Type;

   ------------------
   -- Get_Tag_Name --
   ------------------

   overriding function Get_Tag_Name
    (Self : not null access constant Element_Node)
       return League.Strings.Universal_String
   is
      pragma Unreferenced (Self);

   begin
      raise Program_Error;
      return League.Strings.Empty_Universal_String;
   end Get_Tag_Name;

   ----------------
   -- Leave_Node --
   ----------------

   overriding procedure Leave_Node
    (Self    : not null access Element_Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Visitor.Leave_Element
       (XML.DOM.Elements.DOM_Element_Access (Self), Control);
   end Leave_Node;

   ---------------------------
   -- Set_Attribute_Node_NS --
   ---------------------------

   overriding function Set_Attribute_Node_NS
    (Self     : not null access Element_Node;
     New_Attr : not null XML.DOM.Attributes.DOM_Attribute_Access)
       return XML.DOM.Attributes.DOM_Attribute_Access
   is
      use XML.DOM.Elements;
--      use type XML.DOM.Elements.DOM_Element_Access;
      use type Matreshka.DOM_Nodes.Node_Access;
      use type League.Strings.Universal_String;

      New_Attribute : constant Matreshka.DOM_Nodes.Node_Access
        := Matreshka.DOM_Nodes.Node_Access (New_Attr);
      Old_Attribute : Matreshka.DOM_Nodes.Node_Access
        := Self.First_Attribute;

   begin
      Self.Check_Wrong_Document (New_Attr);

      if New_Attr.Get_Owner_Element /= null then
         Self.Raise_Inuse_Attribute_Error;
      end if;

      --  Lookup for existing attribute.

      while Old_Attribute /= null loop
         if Old_Attribute.all
              in Matreshka.DOM_Attributes.Abstract_Attribute_L2_Node'Class
         then
            if Old_Attribute = New_Attribute then
               return New_Attr;

            elsif Old_Attribute.Get_Local_Name = New_Attribute.Get_Local_Name
              and Old_Attribute.Get_Namespace_URI
                    = New_Attribute.Get_Namespace_URI
            then
               --  Detach old attribute from the list of element's attributes.

               if Self.First_Attribute = Old_Attribute then
                  Self.First_Attribute := Old_Attribute.Next;
               end if;

               if Self.Last_Attribute = Old_Attribute then
                  Self.Last_Attribute := Old_Attribute.Previous;
               end if;

               if Old_Attribute.Next /= null then
                  Old_Attribute.Next.Previous := Old_Attribute.Previous;
               end if;

               if Old_Attribute.Previous /= null then
                  Old_Attribute.Previous.Next := Old_Attribute.Next;
               end if;

               Old_Attribute.Parent := null;
               Old_Attribute.Previous := null;
               Old_Attribute.Next := null;

               --  And attach it to the list of detached nodes of document.
               --
               --  Note: at least one node (new attribute node) is in
               --  document's list of detached nodes, so some optimizations are
               --  used here.

               Old_Attribute.Previous := Self.Document.Last_Detached;
               Self.Document.Last_Detached.Next := Old_Attribute;
               Self.Document.Last_Detached := Old_Attribute;

               exit;
            end if;

            null;
         end if;

         Old_Attribute := Old_Attribute.Next;
      end loop;

      --  Append new attribute node to the list of element's attributes.

      if Self.First_Attribute = null then
         New_Attribute.Parent := Matreshka.DOM_Nodes.Node_Access (Self);
         New_Attribute.Previous := null;
         New_Attribute.Next := null;
         Self.First_Attribute := New_Attribute;
         Self.Last_Attribute := New_Attribute;

      else
         New_Attribute.Parent := Matreshka.DOM_Nodes.Node_Access (Self);
         New_Attribute.Previous := Self.Last_Attribute;
         New_Attribute.Next := null;
         Self.Last_Attribute.Next := New_Attribute;
         Self.Last_Attribute := New_Attribute;
      end if;

      return XML.DOM.Attributes.DOM_Attribute_Access (Old_Attribute);
   end Set_Attribute_Node_NS;

   ----------------
   -- Visit_Node --
   ----------------

   overriding procedure Visit_Node
    (Self     : not null access Element_Node;
     Iterator : in out XML.DOM.Visitors.Abstract_Iterator'Class;
     Visitor  : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control  : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      Iterator.Visit_Element
       (Visitor, XML.DOM.Elements.DOM_Element_Access (Self), Control);
   end Visit_Node;

end Matreshka.DOM_Elements;
