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
-- Copyright © 2011-2013, Vadim Godunko <vgodunko@gmail.com>                --
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
with Ada.Containers.Hashed_Maps;
with Ada.Tags.Generic_Dispatching_Constructor;

with League.Strings.Hash;
with Matreshka.DOM_Nodes.Attributes;
with Matreshka.DOM_Nodes.Documents;
with Matreshka.DOM_Nodes.Elements;

package body Matreshka.DOM_Builders is

   function Create_Document_Node is
     new Ada.Tags.Generic_Dispatching_Constructor
          (Matreshka.DOM_Nodes.Documents.Abstract_Document,
           Matreshka.DOM_Nodes.Documents.Document_Type,
           Matreshka.DOM_Nodes.Documents.Create);

   function Hash
    (Item : Matreshka.DOM_Nodes.Documents.Document_Type)
       return Ada.Containers.Hash_Type;

   package Registry_Maps is
     new Ada.Containers.Hashed_Maps
          (Matreshka.DOM_Nodes.Documents.Document_Type,
           Ada.Tags.Tag,
           Hash,
           Matreshka.DOM_Nodes.Documents."=",
           Ada.Tags."=");

   Registry : Registry_Maps.Map;

   procedure Push (Self : in out DOM_Builder'Class);

   procedure Pop (Self : in out DOM_Builder'Class);

   ---------------------------
   -- Attribute_Declaration --
   ---------------------------

   overriding procedure Attribute_Declaration
    (Self          : in out DOM_Builder;
     E_Name        : League.Strings.Universal_String;
     A_Name        : League.Strings.Universal_String;
     A_Type        : League.Strings.Universal_String;
     Value_Default : League.Strings.Universal_String;
     Value         : League.Strings.Universal_String;
     Success       : in out Boolean) is
   begin
      null;
   end Attribute_Declaration;

   ----------------
   -- Characters --
   ----------------

   overriding procedure Characters
    (Self    : in out DOM_Builder;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean)
   is
--      Node : Matreshka.DOM_Nodes.Text_Access
--        := Self.Document.Create_Text_Node (Text);

   begin
--      Self.Current.Append_Child (Node);
--      Matreshka.DOM_Nodes.Dereference (Node);
      null;
   end Characters;

   -------------
   -- Comment --
   -------------

   overriding procedure Comment
    (Self    : in out DOM_Builder;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      null;
   end Comment;

   ---------------
   -- End_CDATA --
   ---------------

   overriding procedure End_CDATA
    (Self    : in out DOM_Builder;
     Success : in out Boolean) is
   begin
      null;
   end End_CDATA;

   ------------------
   -- End_Document --
   ------------------

   overriding procedure End_Document
    (Self    : in out DOM_Builder;
     Success : in out Boolean) is
   begin
      null;
   end End_Document;

   -------------
   -- End_DTD --
   -------------

   overriding procedure End_DTD
    (Self    : in out DOM_Builder;
     Success : in out Boolean) is
   begin
      null;
   end End_DTD;

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

   ----------------
   -- End_Entity --
   ----------------

   overriding procedure End_Entity
    (Self    : in out DOM_Builder;
     Name    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      null;
   end End_Entity;

   ------------------------
   -- End_Prefix_Mapping --
   ------------------------

   overriding procedure End_Prefix_Mapping
    (Self    : in out DOM_Builder;
     Prefix  : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      null;
   end End_Prefix_Mapping;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : DOM_Builder) return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   ---------------------------------
   -- External_Entity_Declaration --
   ---------------------------------

   overriding procedure External_Entity_Declaration
    (Self      : in out DOM_Builder;
     Name      : League.Strings.Universal_String;
     Public_Id : League.Strings.Universal_String;
     System_Id : League.Strings.Universal_String;
     Success   : in out Boolean) is
   begin
      null;
   end External_Entity_Declaration;

   ------------------
   -- Get_Document --
   ------------------

   function Get_Document
    (Self : DOM_Builder'Class) return Matreshka.DOM_Nodes.Document_Access is
   begin
      return Self.Document;
   end Get_Document;

   ----------
   -- Hash --
   ----------

   function Hash
    (Item : Matreshka.DOM_Nodes.Documents.Document_Type)
       return Ada.Containers.Hash_Type
   is
      use type Ada.Containers.Hash_Type;

   begin
      return
        League.Strings.Hash (Item.Namespace_URI)
          + League.Strings.Hash (Item.Local_Name);
   end Hash;

   --------------------------
   -- Ignorable_Whitespace --
   --------------------------

   overriding procedure Ignorable_Whitespace
    (Self    : in out DOM_Builder;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      null;
   end Ignorable_Whitespace;

   ---------------------------------
   -- Internal_Entity_Declaration --
   ---------------------------------

   overriding procedure Internal_Entity_Declaration
    (Self    : in out DOM_Builder;
     Name    : League.Strings.Universal_String;
     Value   : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      null;
   end Internal_Entity_Declaration;

   --------------------------
   -- Notation_Declaration --
   --------------------------

   overriding procedure Notation_Declaration
    (Self      : in out DOM_Builder;
     Name      : League.Strings.Universal_String;
     Public_Id : League.Strings.Universal_String;
     System_Id : League.Strings.Universal_String;
     Success   : in out Boolean) is
   begin
      null;
   end Notation_Declaration;

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

   ----------------------------
   -- Processing_Instruction --
   ----------------------------

   overriding procedure Processing_Instruction
    (Self    : in out DOM_Builder;
     Target  : League.Strings.Universal_String;
     Data    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      null;
   end Processing_Instruction;

   ----------
   -- Push --
   ----------

   procedure Push (Self : in out DOM_Builder'Class) is
   begin
      Self.Stack.Append (Self.Parent);
      Self.Parent := Self.Current;
      Self.Current := null;
   end Push;

   --------------
   -- Register --
   --------------

   procedure Register
    (Namespace_URI : League.Strings.Universal_String;
     Local_Name    : League.Strings.Universal_String;
     Tag           : Ada.Tags.Tag) is
   begin
      Registry.Insert ((Namespace_URI, Local_Name), Tag);
   end Register;

   --------------------------
   -- Set_Document_Locator --
   --------------------------

   overriding procedure Set_Document_Locator
    (Self    : in out DOM_Builder;
     Locator : Standard.XML.SAX.Locators.SAX_Locator) is
   begin
      null;
   end Set_Document_Locator;

   --------------------
   -- Skipped_Entity --
   --------------------

   overriding procedure Skipped_Entity
    (Self    : in out DOM_Builder;
     Name    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      null;
   end Skipped_Entity;

   -----------------
   -- Start_CDATA --
   -----------------

   overriding procedure Start_CDATA
    (Self    : in out DOM_Builder;
     Success : in out Boolean) is
   begin
      null;
   end Start_CDATA;

   --------------------
   -- Start_Document --
   --------------------

   overriding procedure Start_Document
    (Self    : in out DOM_Builder;
     Success : in out Boolean) is
   begin
      null;
   end Start_Document;

   ---------------
   -- Start_DTD --
   ---------------

   overriding procedure Start_DTD
    (Self      : in out DOM_Builder;
     Name      : League.Strings.Universal_String;
     Public_Id : League.Strings.Universal_String;
     System_Id : League.Strings.Universal_String;
     Success   : in out Boolean) is
   begin
      null;
   end Start_DTD;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out DOM_Builder;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : Standard.XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean)
   is
      use type Matreshka.DOM_Nodes.Document_Access;

      Element   : Matreshka.DOM_Nodes.Element_Access;
      Attribute : Matreshka.DOM_Nodes.Attribute_Access;
      Dummy     : Matreshka.DOM_Nodes.Attribute_Access;

   begin
      if Self.Document = null then
         --  Root element of the processed document, use its do detect kind of
         --  the document and create document node.

         declare
            Tag           : Ada.Tags.Tag
              := Matreshka.DOM_Nodes.Documents.Document_Node'Tag;
            Document_Type : aliased Matreshka.DOM_Nodes.Documents.Document_Type
              := (Namespace_URI, Local_Name);

         begin
            if Registry.Contains (Document_Type) then
               Tag := Registry.Element (Document_Type);
            end if;

            Self.Document :=
              new Matreshka.DOM_Nodes.Documents.Abstract_Document'Class'
                   (Create_Document_Node (Tag, Document_Type'Access));
            Self.Current := Matreshka.DOM_Nodes.Node_Access (Self.Document);
         end;
      end if;

      Self.Push;

      if Local_Name.Is_Empty then
         raise Program_Error;

      else
--         Put_Line
--          ('{'
--             & Namespace_URI.To_Wide_Wide_String
--             & '}'
--             & Local_Name.To_Wide_Wide_String
--             & ' '
--             & Qualified_Name.To_Wide_Wide_String);
         Element :=
           Self.Document.Create_Element (Namespace_URI, Qualified_Name);
         Self.Current := Matreshka.DOM_Nodes.Node_Access (Element);
         Self.Parent.Append_Child (Self.Current);
         Matreshka.DOM_Nodes.Dereference
          (Matreshka.DOM_Nodes.Node_Access (Element));
      end if;

      --  Process attributes.

      for J in 1 .. Attributes.Length loop
         if Attributes.Local_Name (J).Is_Empty then
            raise Program_Error;

         else
            Attribute :=
              Self.Document.Create_Attribute
               (Attributes.Namespace_URI (J), Attributes.Qualified_Name (J));
--            Attribute.Set_Value (Attributes.Value (J));
            Dummy :=
              Matreshka.DOM_Nodes.Element_Access
               (Self.Current).Set_Attribute_Node (Attribute);
            Matreshka.DOM_Nodes.Dereference
             (Matreshka.DOM_Nodes.Node_Access (Attribute));
         end if;
      end loop;
   end Start_Element;

   ------------------
   -- Start_Entity --
   ------------------

   overriding procedure Start_Entity
    (Self    : in out DOM_Builder;
     Name    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      null;
   end Start_Entity;

   --------------------------
   -- Start_Prefix_Mapping --
   --------------------------

   overriding procedure Start_Prefix_Mapping
    (Self          : in out DOM_Builder;
     Prefix        : League.Strings.Universal_String;
     Namespace_URI : League.Strings.Universal_String;
     Success       : in out Boolean) is
   begin
      null;
   end Start_Prefix_Mapping;

   ---------------------------------
   -- Unparsed_Entity_Declaration --
   ---------------------------------

   overriding procedure Unparsed_Entity_Declaration
    (Self          : in out DOM_Builder;
     Name          : League.Strings.Universal_String;
     Public_Id     : League.Strings.Universal_String;
     System_Id     : League.Strings.Universal_String;
     Notation_Name : League.Strings.Universal_String;
     Success       : in out Boolean) is
   begin
      null;
   end Unparsed_Entity_Declaration;

end Matreshka.DOM_Builders;
