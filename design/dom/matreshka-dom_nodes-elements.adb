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
with Matreshka.DOM_Lists;
with Matreshka.DOM_Nodes.Attributes;
with XML.DOM.Elements.Internals;
with XML.DOM.Visitors;

package body Matreshka.DOM_Nodes.Elements is

   -------------------
   -- Enter_Element --
   -------------------

   overriding procedure Enter_Element
    (Self    : not null access Abstract_Element;
     Visitor : in out Standard.XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out Standard.XML.DOM.Visitors.Traverse_Control) is
   begin
      Visitor.Enter_Element
       (Standard.XML.DOM.Elements.Internals.Create
         (Matreshka.DOM_Nodes.Element_Access (Self)),
        Control);
   end Enter_Element;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : not null access Abstract_Element) is
      Current : Matreshka.DOM_Nodes.Attribute_Access := Self.First_Attribute;

   begin
      while Current /= null loop
         Matreshka.DOM_Nodes.Dereference
          (Matreshka.DOM_Nodes.Node_Access (Current));
         Current := Self.First_Attribute;
      end loop;

      Matreshka.DOM_Nodes.Finalize
       (Matreshka.DOM_Nodes.Abstract_Node (Self.all)'Access);
   end Finalize;

   ------------------------
   -- Get_Attribute_Node --
   ------------------------

   function Get_Attribute_Node
    (Self          : not null access constant Abstract_Element;
     Namespace_URI : League.Strings.Universal_String;
     Local_Name    : League.Strings.Universal_String)
       return Matreshka.DOM_Nodes.Attribute_Access
   is
      use type League.Strings.Universal_String;

      Attribute : Matreshka.DOM_Nodes.Attribute_Access
        := Self.First_Attribute;

   begin
      while Attribute /= null loop
         exit when Attribute.Get_Namespace_URI = Namespace_URI
                     and Attribute.Get_Local_Name = Local_Name;

         Attribute :=
           Matreshka.DOM_Nodes.Attribute_Access (Attribute.Next);
      end loop;

      return Attribute;
   end Get_Attribute_Node;

   --------------------
   -- Get_Local_Name --
   --------------------

   overriding function Get_Local_Name
    (Self : not null access constant Element_V1_Node)
       return League.Strings.Universal_String is
   begin
      --  It is always null for attributes created with a DOM Level 1 methods.

      return League.Strings.Empty_Universal_String;
   end Get_Local_Name;

   --------------------
   -- Get_Local_Name --
   --------------------

   overriding function Get_Local_Name
    (Self : not null access constant Element_V2_Node)
       return League.Strings.Universal_String is
   begin
      return Self.Local_Name;
   end Get_Local_Name;

   -----------------------
   -- Get_Namespace_URI --
   -----------------------

   overriding function Get_Namespace_URI
    (Self : not null access constant Element_V1_Node)
       return League.Strings.Universal_String is
   begin
      --  It is always null for attributes created with a DOM Level 1 methods.

      return League.Strings.Empty_Universal_String;
   end Get_Namespace_URI;

   -----------------------
   -- Get_Namespace_URI --
   -----------------------

   overriding function Get_Namespace_URI
    (Self : not null access constant Element_V2_Node)
       return League.Strings.Universal_String is
   begin
      return Self.Namespace_URI;
   end Get_Namespace_URI;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self     : not null access Element_V1_Node'Class;
     Document : not null Matreshka.DOM_Nodes.Document_Access;
     Name     : League.Strings.Universal_String) is
   begin
      Matreshka.DOM_Nodes.Initialize (Self, Document);

      Self.Name := Name;
   end Initialize;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self           : not null access Element_V2_Node'Class;
     Document       : not null Matreshka.DOM_Nodes.Document_Access;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
   is
      Delimiter : constant Natural := Qualified_Name.Index (':');

   begin
      Matreshka.DOM_Nodes.Initialize (Self, Document);

      Self.Namespace_URI := Namespace_URI;

      if Delimiter /= 0 then
         Self.Local_Name :=
           Qualified_Name.Slice (Delimiter + 1, Qualified_Name.Length);

      else
         Self.Local_Name := Qualified_Name;
      end if;
   end Initialize;

   -------------------
   -- Leave_Element --
   -------------------

   overriding procedure Leave_Element
    (Self    : not null access Abstract_Element;
     Visitor : in out Standard.XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out Standard.XML.DOM.Visitors.Traverse_Control) is
   begin
      Visitor.Leave_Element
       (Standard.XML.DOM.Elements.Internals.Create
         (Matreshka.DOM_Nodes.Element_Access (Self)),
        Control);
   end Leave_Element;

   ------------------------
   -- Set_Attribute_Node --
   ------------------------

   function Set_Attribute_Node
    (Self : in out Abstract_Element'Class;
     Attr : Matreshka.DOM_Nodes.Attribute_Access)
       return Matreshka.DOM_Nodes.Attribute_Access
   is
      use type Matreshka.DOM_Nodes.Node_Access;

--      Current : Matreshka.XML.DOM_Nodes.Node_Access := Self.First_Attribute;

   begin
--      while Current /= null loop
--         Current := Current.Next;
--      end loop;

      Matreshka.DOM_Lists.Append_Attribute_Node (Self'Unchecked_Access, Attr);

      return null;
   end Set_Attribute_Node;

   -------------------
   -- Visit_Element --
   -------------------

   overriding procedure Visit_Element
    (Self     : not null access Abstract_Element;
     Iterator : in out Standard.XML.DOM.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Standard.XML.DOM.Visitors.Abstract_Visitor'Class;
     Control  : in out Standard.XML.DOM.Visitors.Traverse_Control) is
   begin
      Iterator.Visit_Element
       (Visitor,
        Standard.XML.DOM.Elements.Internals.Create
         (Matreshka.DOM_Nodes.Element_Access (Self)),
        Control);
   end Visit_Element;

end Matreshka.DOM_Nodes.Elements;
