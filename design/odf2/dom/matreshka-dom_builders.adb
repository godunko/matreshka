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
-- Copyright © 2013-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with XML.DOM.Attributes;
with XML.DOM.Elements;
with XML.DOM.Nodes;
with XML.DOM.Texts;

--  with ODF.DOM.Documents;

package body Matreshka.DOM_Builders is

   procedure Push (Self : in out DOM_Builder'Class);

   procedure Pop (Self : in out DOM_Builder'Class);

   ----------------
   -- Characters --
   ----------------

   overriding procedure Characters
    (Self    : in out DOM_Builder;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean)
   is
      Aux : XML.DOM.Texts.DOM_Text_Access
        := Self.Document.Create_Text_Node (Text);

   begin
      Self.Current.Append_Child (XML.DOM.Nodes.DOM_Node_Access (Aux));
--      XML.DOM.Nodes.Dereference (XML.DOM.Nodes.DOM_Node_Access (Aux));
   end Characters;

   -----------------
   -- End_Element --
   -----------------

   overriding procedure End_Element
    (Self           : in out DOM_Builder;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean) is
   begin
      Self.Pop;
   end End_Element;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : DOM_Builder) return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   ------------------
   -- Get_Document --
   ------------------

   function Get_Document
    (Self : DOM_Builder'Class) return XML.DOM.Documents.DOM_Document_Access is
   begin
      return Self.Document;
   end Get_Document;

   ---------
   -- Pop --
   ---------

   procedure Pop (Self : in out DOM_Builder'Class) is
   begin
      Self.Current := Self.Parent;

      if not Self.Stack.Is_Empty then
         Self.Parent := Self.Stack.Last_Element;
         Self.Stack.Delete_Last;

      else
         Self.Parent := null;
      end if;
   end Pop;

   ----------
   -- Push --
   ----------

   procedure Push (Self : in out DOM_Builder'Class) is
   begin
      Self.Stack.Append (Self.Parent);
      Self.Parent := Self.Current;
      Self.Current := null;
   end Push;

   --------------------
   -- Start_Document --
   --------------------

   overriding procedure Start_Document
    (Self    : in out DOM_Builder;
     Success : in out Boolean) is
   begin
--      Self.Document := new ODF.DOM.Documents.ODF_Document;
      Self.Current  := XML.DOM.Nodes.DOM_Node_Access (Self.Document);
   end Start_Document;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out DOM_Builder;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean)
   is
      Element   : XML.DOM.Elements.DOM_Element_Access;
      Attribute : XML.DOM.Attributes.DOM_Attribute_Access;

   begin
      Self.Push;

      if Local_Name.Is_Empty then
         raise Program_Error;

      else
         Put_Line
          ('{'
             & Namespace_URI.To_Wide_Wide_String
             & '}'
             & Local_Name.To_Wide_Wide_String
             & ' '
             & Qualified_Name.To_Wide_Wide_String);
         Element :=
           Self.Document.Create_Element_NS (Namespace_URI, Qualified_Name);
         Self.Current := XML.DOM.Nodes.DOM_Node_Access (Element);
         Self.Parent.Append_Child (Self.Current);
--         XML.DOM.Nodes.Dereference (XML.DOM.Nodes.DOM_Node_Access (Element));
      end if;

      --  Process attributes.

      for J in 1 .. Attributes.Length loop
         if Attributes.Local_Name (J).Is_Empty then
            raise Program_Error;

         else
            Attribute :=
              Self.Document.Create_Attribute_NS
               (Attributes.Namespace_URI (J), Attributes.Qualified_Name (J));
            XML.DOM.Elements.DOM_Element_Access
             (Self.Current).Set_Attribute_Node_NS (Attribute);
            Attribute.Set_Value (Attributes.Value (J));
--            XML.DOM.Nodes.Dereference
--             (XML.DOM.Nodes.DOM_Node_Access (Attribute));
         end if;
      end loop;
   end Start_Element;

end Matreshka.DOM_Builders;
