------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Open Document Toolkit                           --
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
with Matreshka.DOM_Documents;

with Matreshka.ODF_String_Constants;
with ODF.DOM.Iterators;
with ODF.DOM.Visitors;

package body Matreshka.ODF_Text.Variable_Input_Elements is

   ------------
   -- Create --
   ------------

   overriding function Create
    (Parameters : not null access Matreshka.DOM_Elements.Element_L2_Parameters)
       return Text_Variable_Input_Element_Node is
   begin
      return Self : Text_Variable_Input_Element_Node do
         Matreshka.ODF_Text.Constructors.Initialize
          (Self'Unchecked_Access,
           Parameters.Document,
           Matreshka.ODF_String_Constants.Text_Prefix);
      end return;
   end Create;

   ----------------
   -- Enter_Node --
   ----------------

   overriding procedure Enter_Node
    (Self    : not null access Text_Variable_Input_Element_Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      if Visitor in ODF.DOM.Visitors.Abstract_ODF_Visitor'Class then
         ODF.DOM.Visitors.Abstract_ODF_Visitor'Class
          (Visitor).Enter_Text_Variable_Input
            (ODF.DOM.Text_Variable_Input_Elements.ODF_Text_Variable_Input_Access
              (Self),
             Control);

      else
         Matreshka.DOM_Elements.Abstract_Element_Node
          (Self.all).Enter_Node (Visitor, Control);
      end if;
   end Enter_Node;

   --------------------
   -- Get_Local_Name --
   --------------------

   overriding function Get_Local_Name
    (Self : not null access constant Text_Variable_Input_Element_Node)
       return League.Strings.Universal_String
   is
      pragma Unreferenced (Self);

   begin
      return Matreshka.ODF_String_Constants.Variable_Input_Element;
   end Get_Local_Name;

   ----------------
   -- Leave_Node --
   ----------------

   overriding procedure Leave_Node
    (Self    : not null access Text_Variable_Input_Element_Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      if Visitor in ODF.DOM.Visitors.Abstract_ODF_Visitor'Class then
         ODF.DOM.Visitors.Abstract_ODF_Visitor'Class
          (Visitor).Leave_Text_Variable_Input
            (ODF.DOM.Text_Variable_Input_Elements.ODF_Text_Variable_Input_Access
              (Self),
             Control);

      else
         Matreshka.DOM_Elements.Abstract_Element_Node
          (Self.all).Leave_Node (Visitor, Control);
      end if;
   end Leave_Node;

   ----------------
   -- Visit_Node --
   ----------------

   overriding procedure Visit_Node
    (Self     : not null access Text_Variable_Input_Element_Node;
     Iterator : in out XML.DOM.Visitors.Abstract_Iterator'Class;
     Visitor  : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control  : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      if Iterator in ODF.DOM.Iterators.Abstract_ODF_Iterator'Class then
         ODF.DOM.Iterators.Abstract_ODF_Iterator'Class
          (Iterator).Visit_Text_Variable_Input
            (Visitor,
             ODF.DOM.Text_Variable_Input_Elements.ODF_Text_Variable_Input_Access
              (Self),
             Control);

      else
         Matreshka.DOM_Elements.Abstract_Element_Node
          (Self.all).Visit_Node (Iterator, Visitor, Control);
      end if;
   end Visit_Node;

begin
   Matreshka.DOM_Documents.Register_Element
    (Matreshka.ODF_String_Constants.Text_URI,
     Matreshka.ODF_String_Constants.Variable_Input_Element,
     Text_Variable_Input_Element_Node'Tag);
end Matreshka.ODF_Text.Variable_Input_Elements;
