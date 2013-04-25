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
with Matreshka.DOM_Nodes.Attributes;
with Matreshka.DOM_Nodes.Documents;
with Matreshka.DOM_Nodes.Elements;
with Matreshka.DOM_Nodes.Texts;
with XML.DOM.Nodes.Attributes.Internals;
with XML.DOM.Nodes.Character_Datas.Texts.Internals;
with XML.DOM.Nodes.Documents.Internals;
with XML.DOM.Nodes.Elements.Internals;

package body XML.DOM.Nodes is

   use type Matreshka.DOM_Nodes.Node_Access;

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out DOM_Node) is
   begin
      if Self.Node /= null then
         Matreshka.DOM_Nodes.Reference (Self.Node);
      end if;
   end Adjust;

   ------------------
   -- Append_Child --
   ------------------

   function Append_Child
    (Self      : in out DOM_Node'Class;
     New_Child : DOM_Node'Class) return DOM_Node is
   begin
      if Self.Node /= null then
         Self.Node.Append_Child (New_Child.Node);

         return DOM_Node (New_Child);

      else
         raise Constraint_Error;
      end if;
   end Append_Child;

   ------------------
   -- Append_Child --
   ------------------

   procedure Append_Child
    (Self      : in out DOM_Node'Class;
     New_Child : DOM_Node'Class) is
   begin
      if Self.Node /= null then
         Self.Node.Append_Child (New_Child.Node);

      else
         raise Constraint_Error;
      end if;
   end Append_Child;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out DOM_Node) is
   begin
      if Self.Node /= null then
         Matreshka.DOM_Nodes.Dereference (Self.Node);
      end if;
   end Finalize;

   --------------------
   -- Get_Local_Name --
   --------------------

   function Get_Local_Name
    (Self : DOM_Node'Class) return League.Strings.Universal_String is
   begin
      if Self.Node /= null then
         return Self.Node.Get_Local_Name;

      else
         raise Constraint_Error;
      end if;
   end Get_Local_Name;

   -----------------------
   -- Get_Namespace_URI --
   -----------------------

   function Get_Namespace_URI
    (Self : DOM_Node'Class) return League.Strings.Universal_String is
   begin
      if Self.Node /= null then
         return Self.Node.Get_Namespace_URI;

      else
         raise Constraint_Error;
      end if;
   end Get_Namespace_URI;

   ------------------
   -- Is_Attribute --
   ------------------

   function Is_Attribute (Self : DOM_Node'Class) return Boolean is
   begin
      return
        Self.Node /= null
          and then Self.Node.all
             in Matreshka.DOM_Nodes.Attributes.Abstract_Attribute'Class;
   end Is_Attribute;

   -----------------
   -- Is_Document --
   -----------------

   function Is_Document (Self : DOM_Node'Class) return Boolean is
   begin
      return
        Self.Node /= null
          and then Self.Node.all
             in Matreshka.DOM_Nodes.Documents.Document_Node'Class;
   end Is_Document;

   ----------------
   -- Is_Element --
   ----------------

   function Is_Element (Self : DOM_Node'Class) return Boolean is
   begin
      return
        Self.Node /= null
          and then Self.Node.all
             in Matreshka.DOM_Nodes.Elements.Abstract_Element'Class;
   end Is_Element;

   -------------
   -- Is_Null --
   -------------

   function Is_Null (Self : DOM_Node'Class) return Boolean is
   begin
      return Self.Node = null;
   end Is_Null;

   -------------
   -- Is_Text --
   -------------

   function Is_Text (Self : DOM_Node'Class) return Boolean is
   begin
      return
        Self.Node /= null
          and then Self.Node.all in Matreshka.DOM_Nodes.Texts.Text_Node'Class;
   end Is_Text;

   ------------------
   -- To_Attribute --
   ------------------

   function To_Attribute
    (Self : DOM_Node'Class) return XML.DOM.Nodes.Attributes.DOM_Attribute is
   begin
      if Self.Is_Null then
         return XML.DOM.Nodes.Attributes.Null_DOM_Attribute;

      elsif Self.Is_Attribute then
         return
           XML.DOM.Nodes.Attributes.Internals.Create
            (Matreshka.DOM_Nodes.Attribute_Access (Self.Node));

      else
         raise Constraint_Error;
      end if;
   end To_Attribute;

   -----------------
   -- To_Document --
   -----------------

   function To_Document
    (Self : DOM_Node'Class) return XML.DOM.Nodes.Documents.DOM_Document is
   begin
      if Self.Is_Null then
         return XML.DOM.Nodes.Documents.Null_DOM_Document;

      elsif Self.Is_Document then
         return
           XML.DOM.Nodes.Documents.Internals.Create
            (Matreshka.DOM_Nodes.Document_Access (Self.Node));

      else
         raise Constraint_Error;
      end if;
   end To_Document;

   ----------------
   -- To_Element --
   ----------------

   function To_Element
    (Self : DOM_Node'Class) return XML.DOM.Nodes.Elements.DOM_Element is
   begin
      if Self.Is_Null then
         return XML.DOM.Nodes.Elements.Null_DOM_Element;

      elsif Self.Is_Element then
         return
           XML.DOM.Nodes.Elements.Internals.Create
            (Matreshka.DOM_Nodes.Element_Access (Self.Node));

      else
         raise Constraint_Error;
      end if;
   end To_Element;

   -------------
   -- To_Text --
   -------------

   function To_Text
    (Self : DOM_Node'Class)
       return XML.DOM.Nodes.Character_Datas.Texts.DOM_Text is
   begin
      if Self.Is_Null then
         return XML.DOM.Nodes.Character_Datas.Texts.Null_DOM_Text;

      elsif Self.Is_Text then
         return
           XML.DOM.Nodes.Character_Datas.Texts.Internals.Create
            (Matreshka.DOM_Nodes.Text_Access (Self.Node));

      else
         raise Constraint_Error;
      end if;
   end To_Text;

end XML.DOM.Nodes;
