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

package body Matreshka.DOM_Attributes is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self     : not null access Attribute_L1_Node'Class;
        Document : not null Matreshka.DOM_Nodes.Document_Access) is
      begin
         Matreshka.DOM_Nodes.Constructors.Initialize (Self, Document);
      end Initialize;

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self     : not null access Attribute_L2_Node'Class;
        Document : not null Matreshka.DOM_Nodes.Document_Access) is
      begin
         Matreshka.DOM_Nodes.Constructors.Initialize (Self, Document);
      end Initialize;

   end Constructors;

   ----------------
   -- Enter_Node --
   ----------------

   overriding procedure Enter_Node
    (Self    : not null access Abstract_Attribute_Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control)
   is
      pragma Unreferenced (Self);
      pragma Unreferenced (Visitor);
      pragma Unreferenced (Control);

   begin
      raise Program_Error;
   end Enter_Node;

   --------------
   -- Get_Name --
   --------------

   overriding function Get_Name
    (Self : not null access constant Attribute_L1_Node)
       return League.Strings.Universal_String is
   begin
      raise Program_Error;
      return League.Strings.Empty_Universal_String;
   end Get_Name;

   --------------
   -- Get_Name --
   --------------

   overriding function Get_Name
    (Self : not null access constant Attribute_L2_Node)
       return League.Strings.Universal_String is
   begin
      raise Program_Error;
      return League.Strings.Empty_Universal_String;
   end Get_Name;

   ----------------------
   -- Get_Next_Sibling --
   ----------------------

   overriding function Get_Next_Sibling
    (Self : not null access constant Abstract_Attribute_Node)
       return XML.DOM.Nodes.DOM_Node_Access
   is
      pragma Unreferenced (Self);

   begin
      return null;
   end Get_Next_Sibling;

   -------------------
   -- Get_Node_Type --
   -------------------

   overriding function Get_Node_Type
    (Self : not null access constant Abstract_Attribute_Node)
       return XML.DOM.Node_Type
   is
      pragma Unreferenced (Self);

   begin
      return XML.DOM.Attribute_Node;
   end Get_Node_Type;

   -----------------------
   -- Get_Owner_Element --
   -----------------------

   overriding function Get_Owner_Element
    (Self : not null access constant Abstract_Attribute_Node)
       return XML.DOM.Elements.DOM_Element_Access is
   begin
      return XML.DOM.Elements.DOM_Element_Access (Self.Parent);
   end Get_Owner_Element;

   ---------------------
   -- Get_Parent_Node --
   ---------------------

   overriding function Get_Parent_Node
    (Self : not null access constant Abstract_Attribute_Node)
       return XML.DOM.Nodes.DOM_Node_Access
   is
      pragma Unreferenced (Self);

   begin
      return null;
   end Get_Parent_Node;

   --------------------------
   -- Get_Previous_Sibling --
   --------------------------

   overriding function Get_Previous_Sibling
    (Self : not null access constant Abstract_Attribute_Node)
       return XML.DOM.Nodes.DOM_Node_Access
   is
      pragma Unreferenced (Self);

   begin
      return null;
   end Get_Previous_Sibling;

   ---------------
   -- Get_Value --
   ---------------

   overriding function Get_Value
    (Self : not null access constant Attribute_L1_Node)
       return League.Strings.Universal_String is
   begin
      raise Program_Error;
      return League.Strings.Empty_Universal_String;
   end Get_Value;

   ---------------
   -- Get_Value --
   ---------------

   overriding function Get_Value
    (Self : not null access constant Attribute_L2_Node)
       return League.Strings.Universal_String is
   begin
      raise Program_Error;
      return League.Strings.Empty_Universal_String;
   end Get_Value;

   ----------------
   -- Leave_Node --
   ----------------

   overriding procedure Leave_Node
    (Self    : not null access Abstract_Attribute_Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control)
   is
      pragma Unreferenced (Self);
      pragma Unreferenced (Visitor);
      pragma Unreferenced (Control);

   begin
      raise Program_Error;
   end Leave_Node;

   ---------------
   -- Set_Value --
   ---------------

   overriding procedure Set_Value
    (Self      : not null access Attribute_L1_Node;
     New_Value : League.Strings.Universal_String) is
   begin
      raise Program_Error;
   end Set_Value;

   ---------------
   -- Set_Value --
   ---------------

   overriding procedure Set_Value
    (Self      : not null access Attribute_L2_Node;
     New_Value : League.Strings.Universal_String) is
   begin
      raise Program_Error;
   end Set_Value;

   ----------------
   -- Visit_Node --
   ----------------

   overriding procedure Visit_Node
    (Self     : not null access Abstract_Attribute_Node;
     Iterator : in out XML.DOM.Visitors.Abstract_Iterator'Class;
     Visitor  : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control  : in out XML.DOM.Visitors.Traverse_Control)
   is
      pragma Unreferenced (Self);
      pragma Unreferenced (Visitor);
      pragma Unreferenced (Control);

   begin
      raise Program_Error;
   end Visit_Node;

end Matreshka.DOM_Attributes;