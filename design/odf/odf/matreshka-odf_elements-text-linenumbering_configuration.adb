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
with ODF.Constants;
with ODF.DOM.Elements.Text.Linenumbering_Configuration.Internals;
with ODF.DOM.Iterators;
with ODF.DOM.Visitors;

package body Matreshka.ODF_Elements.Text.Linenumbering_Configuration is

   -------------------
   -- Enter_Element --
   -------------------

   overriding procedure Enter_Element
    (Self    : not null access Text_Linenumbering_Configuration_Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      if Visitor in ODF.DOM.Visitors.ODF_Visitor'Class then
         ODF.DOM.Visitors.ODF_Visitor'Class
          (Visitor).Enter_Text_Linenumbering_Configuration
            (ODF.DOM.Elements.Text.Linenumbering_Configuration.Internals.Create
              (Text_Linenumbering_Configuration_Access (Self)),
             Control);

      else
         Matreshka.DOM_Nodes.Elements.Abstract_Element
          (Self.all).Enter_Element (Visitor, Control);
      end if;
   end Enter_Element;

   --------------------
   -- Get_Local_Name --
   --------------------

   overriding function Get_Local_Name
    (Self : not null access constant Text_Linenumbering_Configuration_Node)
       return League.Strings.Universal_String is
   begin
      return ODF.Constants.Linenumbering_Configuration_Name;
   end Get_Local_Name;

   -------------------
   -- Leave_Element --
   -------------------

   overriding procedure Leave_Element
    (Self    : not null access Text_Linenumbering_Configuration_Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      if Visitor in ODF.DOM.Visitors.ODF_Visitor'Class then
         ODF.DOM.Visitors.ODF_Visitor'Class
          (Visitor).Leave_Text_Linenumbering_Configuration
            (ODF.DOM.Elements.Text.Linenumbering_Configuration.Internals.Create
              (Text_Linenumbering_Configuration_Access (Self)),
             Control);

      else
         Matreshka.DOM_Nodes.Elements.Abstract_Element
          (Self.all).Leave_Element (Visitor, Control);
      end if;
   end Leave_Element;

   -------------------
   -- Visit_Element --
   -------------------

   overriding procedure Visit_Element
    (Self     : not null access Text_Linenumbering_Configuration_Node;
     Iterator : in out XML.DOM.Visitors.Abstract_Iterator'Class;
     Visitor  : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control  : in out XML.DOM.Visitors.Traverse_Control) is
   begin
      if Iterator in ODF.DOM.Iterators.ODF_Iterator'Class then
         ODF.DOM.Iterators.ODF_Iterator'Class
          (Iterator).Visit_Text_Linenumbering_Configuration
            (Visitor,
             ODF.DOM.Elements.Text.Linenumbering_Configuration.Internals.Create
              (Text_Linenumbering_Configuration_Access (Self)),
             Control);

      else
         Matreshka.DOM_Nodes.Elements.Abstract_Element
          (Self.all).Visit_Element (Iterator, Visitor, Control);
      end if;
   end Visit_Element;

end Matreshka.ODF_Elements.Text.Linenumbering_Configuration;
