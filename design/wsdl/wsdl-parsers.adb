------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2012, Vadim Godunko <vgodunko@gmail.com>                     --
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

with League.String_Vectors;

with WSDL.AST.Bindings;
with WSDL.AST.Components;
with WSDL.AST.Messages;
with WSDL.AST.Operations;
with WSDL.AST.Types;

package body WSDL.Parsers is

   use type League.Strings.Universal_String;

   WSDL_Namespace  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("http://www.w3.org/ns/wsdl");

   Binding_Element       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("binding");
   Description_Element   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("description");
   Documentation_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("documentation");
   Fault_Element         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("fault");
   Infault_Element       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("infault");
   Include_Element       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("include");
   Input_Element         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("input");
   Interface_Element     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("interface");
   Import_Element        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("import");
   Operation_Element     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("operation");
   Outfault_Element      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("outfault");
   Output_Element        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("output");
   Service_Element       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("service");
   Types_Element         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("types");

   Element_Attribute          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("element");
   Extends_Attribute          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extends");
   Interface_Attribute        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("interface");
   Message_Label_Attribute    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("messageLabel");
   Name_Attribute             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("name");
   Pattern_Attribute          : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("pattern");
   Style_Attribute            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("style");
   Style_Default_Attribute    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("styleDefault");
   Target_Namespace_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("targetNamespace");
   Type_Attribute             : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("type");

   Any_Literal   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("#any");
   None_Literal  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("#none");
   Other_Literal : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("#other");

   Pattern_Default : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://www.w3.org/ns/wsdl/in-out");

   type Universal_String_Array is
     array (Positive range <>) of League.Strings.Universal_String;

   procedure Push
    (Self : in out WSDL_Parser'Class; State : Parser_State_Kind);

   procedure Pop (Self : in out WSDL_Parser'Class);

   procedure Start_Description_Element
    (Self       : in out WSDL_Parser'Class;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean);
   --  Handles start of 'description' element.

   procedure Start_Types_Element
    (Description : WSDL.AST.Descriptions.Description_Access;
     Success     : in out Boolean);
   --  Handles start of 'types' element.

   procedure Start_Interface_Element
    (Attributes  : XML.SAX.Attributes.SAX_Attributes;
     Namespaces  : Namespace_Maps.Map;
     Description : WSDL.AST.Descriptions.Description_Access;
     Node        : out WSDL.AST.Interfaces.Interface_Access;
     Success     : in out Boolean);
   --  Handles start of 'interface' element.

   procedure Start_Interface_Operation_Element
    (Attributes : XML.SAX.Attributes.SAX_Attributes;
     Parent     : WSDL.AST.Interfaces.Interface_Access;
     Node       : out WSDL.AST.Operations.Interface_Operation_Access;
     Success    : in out Boolean);
   --  Handles start of 'operation' element as child of 'interface' element.

   procedure Start_Input_Output_Element
    (Attributes : XML.SAX.Attributes.SAX_Attributes;
     Parent     : WSDL.AST.Operations.Interface_Operation_Access;
     Direction  : WSDL.AST.Messages.Message_Directions;
     Success    : in out Boolean);
   --  Handles start of 'input' element as child of 'operation' element as
   --  child of 'interface' element.

   procedure Start_Binding_Element
    (Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Descriptions.Description_Access;
--     Node       : out WSDL.AST.Interfaces.Interface_Access;
     Success    : in out Boolean);
   --  Handles start of 'interface' element.

--   procedure Check_WSDL_Attributes
--    (Attributes : XML.SAX.Attributes.SAX_Attributes;
--     Allowed    : Universal_String_Array;
--     Success    : in out Boolean);
--   --  Checks that each attribute without namespace is present in the set of
--   --  allowed attributes; and report error otherwise.
--
--   ---------------------------
--   -- Check_WSDL_Attributes --
--   ---------------------------
--
--   procedure Check_WSDL_Attributes
--    (Attributes : XML.SAX.Attributes.SAX_Attributes;
--     Allowed    : Universal_String_Array;
--     Success    : in out Boolean)
--   is
--      OK : Boolean;
--
--   begin
--      Put_Line (Integer'Wide_Wide_Image (Attributes.Length));
--      for J in 1 .. Attributes.Length loop
--         Put_Line (Attributes.Namespace_URI (J).To_Wide_Wide_String);
--
--         if Attributes.Namespace_URI (J).Is_Empty then
--         Put_Line (Attributes.Namespace_URI (J).To_Wide_Wide_String);
--            OK := False;
--
--            for K in Allowed'Range loop
--               if Attributes.Qualified_Name (J) = Allowed (K) then
--                  OK := True;
--
--                  exit;
--               end if;
--            end loop;
--
--            if not OK then
--               Success := False;
--
--               --  XXX error must be reported here.
--               raise Program_Error;
--            end if;
--         end if;
--      end loop;
--   end Check_WSDL_Attributes;

   -----------------
   -- End_Element --
   -----------------

   overriding procedure End_Element
    (Self           : in out WSDL_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean) is
   begin
      if Self.Ignore_Depth /= 0 then
         Self.Ignore_Depth := Self.Ignore_Depth - 1;

      elsif Namespace_URI = WSDL_Namespace then
         if Local_Name = Binding_Element then
            Self.Pop;

         elsif Local_Name = Description_Element then
            Self.Pop;

         elsif Local_Name = Input_Element then
            Self.Pop;

         elsif Local_Name = Interface_Element then
            Self.Pop;

         elsif Local_Name = Operation_Element then
            Self.Pop;

         elsif Local_Name = Output_Element then
            Self.Pop;

         elsif Local_Name = Types_Element then
            Self.Pop;
         end if;
      end if;
   end End_Element;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : WSDL_Parser) return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   ---------------------
   -- Get_Description --
   ---------------------

   function Get_Description
    (Self : WSDL_Parser'Class)
       return WSDL.AST.Descriptions.Description_Access is
   begin
      return Self.Description;
   end Get_Description;

   ---------
   -- Pop --
   ---------

   procedure Pop (Self : in out WSDL_Parser'Class) is
   begin
      Self.Current_State := Self.Previous_State;

      if Self.State_Stack.Is_Empty then
         Self.Previous_State := (None, others => <>);

      else
         Self.Previous_State := Self.State_Stack.Last_Element;
         Self.State_Stack.Delete_Last;
      end if;
   end Pop;

   ----------
   -- Push --
   ----------

   procedure Push
    (Self : in out WSDL_Parser'Class; State : Parser_State_Kind)
   is
      Aux : Parser_State (State);

   begin
      Self.State_Stack.Append (Self.Previous_State);
      Self.Previous_State := Self.Current_State;
      Self.Current_State := Aux;
   end Push;

   ---------------------------
   -- Start_Binding_Element --
   ---------------------------

   procedure Start_Binding_Element
    (Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces  : Namespace_Maps.Map;
     Parent     : WSDL.AST.Descriptions.Description_Access;
--     Node       : out WSDL.AST.Interfaces.Interface_Access;
     Success    : in out Boolean)
   is
      Name : constant League.Strings.Universal_String
        := Attributes.Value (Name_Attribute);
      Node : WSDL.AST.Bindings.Binding_Access;

   begin
      Node := new WSDL.AST.Bindings.Binding_Node;
      Node.Parent := WSDL.AST.Components.Description_Access (Parent);
      Node.Local_Name := Name;
      Parent.Bindings.Insert (Name, Node);

      --  Analyze 'interface' attribute.

      if Attributes.Is_Specified (Interface_Attribute) then
         declare
            Value : constant League.Strings.Universal_String
              := Attributes.Value (Interface_Attribute);
            Index : constant Natural := Value.Index (':');

         begin
            Node.Interface_Name :=
              (Namespaces.Element (Value.Slice (1, Index - 1)),
               Value.Slice (Index + 1, Value.Length));
         end;
      end if;

      --  Analyze 'type' attribute.

      Node.Binding_Type := Attributes.Value (Type_Attribute);
   end Start_Binding_Element;

   -------------------------------
   -- Start_Description_Element --
   -------------------------------

   procedure Start_Description_Element
    (Self       : in out WSDL_Parser'Class;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean) is
   begin
--            Check_WSDL_Attributes
--             (Attributes,
--              (1 => Target_Namespace_Attribute),
--              Success);

      Self.Description := new WSDL.AST.Descriptions.Description_Node;
      Self.Description.Target_Namespace :=
        Attributes.Value (Target_Namespace_Attribute);
   end Start_Description_Element;

   --------------------
   -- Start_Document --
   --------------------

   overriding procedure Start_Document
    (Self    : in out WSDL_Parser;
     Success : in out Boolean) is
   begin
      Self.Current_State := (Document, others => <>);
   end Start_Document;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out WSDL_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean) is
   begin
      if Self.Ignore_Depth /= 0 then
         Self.Ignore_Depth := Self.Ignore_Depth + 1;

      elsif Namespace_URI = WSDL_Namespace then
         Put_Line ("Start_Element '" & Qualified_Name.To_Wide_Wide_String & "'");

         if Local_Name = Binding_Element then
            if Self.Current_State.Kind = WSDL_Description then
               Self.Current_State.Last_Child_Kind := Interface_Binding_Service;
               Self.Push (WSDL_Binding);
               Start_Binding_Element
                (Attributes, Self.Namespaces, Self.Description, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Description_Element then
            if Self.Current_State.Kind = Document then
               Self.Push (WSDL_Description);
               Self.Start_Description_Element (Attributes, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Documentation_Element then
            if Self.Current_State.Kind = WSDL_Description then
               if Self.Current_State.Last_Child_Kind > Documentation then
                  --  Description-1005: Invalid order of children elements of
                  --  'description' element.

                  raise Program_Error;

               else
                  Self.Current_State.Last_Child_Kind := Documentation;
                  Self.Ignore_Depth := 1;
               end if;

            elsif Self.Current_State.Kind = WSDL_Binding
              or Self.Current_State.Kind = WSDL_Input
              or Self.Current_State.Kind = WSDL_Interface
              or Self.Current_State.Kind = WSDL_Operation
              or Self.Current_State.Kind = WSDL_Output
            then
               Self.Ignore_Depth := 1;

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Fault_Element then
            if Self.Current_State.Kind = WSDL_Interface then
               --  XXX all children elements are ignored for now.

               Self.Ignore_Depth := 1;

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Include_Element then
            if Self.Current_State.Kind = WSDL_Description then
               if Self.Current_State.Last_Child_Kind > Include_Import then
                  --  Description-1005: Invalid order of children elements of
                  --  'description' element.

                  raise Program_Error;

               else
                  Self.Current_State.Last_Child_Kind := Include_Import;
                  Self.Ignore_Depth := 1;
               end if;

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Infault_Element then
            if Self.Current_State.Kind = WSDL_Operation then
               --  XXX all children elements are ignored for now.

               Self.Ignore_Depth := 1;

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Input_Element then
            if Self.Current_State.Kind = WSDL_Operation then
               Self.Push (WSDL_Input);
               Start_Input_Output_Element
                (Attributes,
                 Self.Current_Operation,
                 WSDL.AST.Messages.In_Message,
                 Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Interface_Element then
            if Self.Current_State.Kind = WSDL_Description then
               Self.Current_State.Last_Child_Kind := Interface_Binding_Service;
               Self.Push (WSDL_Interface);
               Start_Interface_Element
                (Attributes,
                 Self.Namespaces,
                 Self.Description,
                 Self.Current_Interface,
                 Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Import_Element then
            if Self.Current_State.Kind = WSDL_Description then
               if Self.Current_State.Last_Child_Kind > Include_Import then
                  --  Description-1005: Invalid order of children elements of
                  --  'description' element.

                  raise Program_Error;

               else
                  Self.Current_State.Last_Child_Kind := Include_Import;
                  Self.Ignore_Depth := 1;
               end if;

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Operation_Element then
            if Self.Current_State.Kind = WSDL_Interface then
               Self.Push (WSDL_Operation);
               Start_Interface_Operation_Element
                (Attributes,
                 Self.Current_Interface,
                 Self.Current_Operation,
                 Success);

            elsif Self.Current_State.Kind = WSDL_Binding then
               --  XXX all children elements are ignored for now.

               Self.Ignore_Depth := 1;

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Outfault_Element then
            if Self.Current_State.Kind = WSDL_Operation then
               --  XXX all children elements are ignored for now.

               Self.Ignore_Depth := 1;

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Output_Element then
            if Self.Current_State.Kind = WSDL_Operation then
               Self.Push (WSDL_Output);
               Start_Input_Output_Element
                (Attributes,
                 Self.Current_Operation,
                 WSDL.AST.Messages.Out_Message,
                 Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Service_Element then
            if Self.Current_State.Kind = WSDL_Description then
               Self.Current_State.Last_Child_Kind := Interface_Binding_Service;

               --  XXX all children elements are ignored for now.

               Self.Ignore_Depth := 1;

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Types_Element then
            if Self.Current_State.Kind = WSDL_Description then
               if Self.Current_State.Last_Child_Kind > Types then
                  --  Description-1005: Invalid order of children elements of
                  --  'description' element.

                  raise Program_Error;

               else
                  Self.Current_State.Last_Child_Kind := Types;
                  Self.Push (WSDL_Types);
                  Start_Types_Element (Self.Description, Success);
               end if;

            else
               raise Program_Error;
            end if;

         else
            raise Program_Error;
         end if;

      else
         if Self.Current_State.Kind = WSDL_Description then
            --  Extension element can appair in two places of children of
            --  'description' element:
            --
            --   - in the set of 'include' and 'import' elements;
            --
            --   - in the set of 'interface', 'binding' and 'service' elements.
            --
            --  Code below sets current kind of children into the appropriate
            --  value.

            if Self.Current_State.Last_Child_Kind < Types then
               Self.Current_State.Last_Child_Kind := Include_Import;

            else
               Self.Current_State.Last_Child_Kind := Interface_Binding_Service;
            end if;

         elsif Self.Current_State.Kind = WSDL_Binding
           or Self.Current_State.Kind = WSDL_Input
           or Self.Current_State.Kind = WSDL_Interface
           or Self.Current_State.Kind = WSDL_Operation
           or Self.Current_State.Kind = WSDL_Output
         then
            --  Ignore unknown extensions of interface component.

            Self.Ignore_Depth := 1;

         elsif Self.Current_State.Kind = WSDL_Types then
            --  XXX all children elements are ignored for now.

            Self.Ignore_Depth := 1;

         else
            raise Program_Error;
         end if;
      end if;
   end Start_Element;

   --------------------------------
   -- Start_Input_Output_Element --
   --------------------------------

   procedure Start_Input_Output_Element
    (Attributes : XML.SAX.Attributes.SAX_Attributes;
     Parent     : WSDL.AST.Operations.Interface_Operation_Access;
     Direction  : WSDL.AST.Messages.Message_Directions;
     Success    : in out Boolean)
   is
      Node : constant WSDL.AST.Messages.Interface_Message_Access
        := new WSDL.AST.Messages.Interface_Message_Node;

   begin
      Node.Parent := WSDL.AST.Messages.Interface_Operation_Access (Parent);
      Node.Direction := Direction;
      Parent.Interface_Message_References.Append (Node);

      --  Analyze 'messageLabel' attribute.

      if Attributes.Is_Specified (Message_Label_Attribute) then
         Node.Message_Label := Attributes.Value (Message_Label_Attribute);
      end if;

      --  Analyze 'element' attribute.

      if Attributes.Is_Specified (Element_Attribute) then
         declare
            Value : constant League.Strings.Universal_String
              := Attributes.Value (Element_Attribute);

         begin
            if Value = Any_Literal then
               Node.Message_Content_Model := WSDL.AST.Messages.Any;

            elsif Value = None_Literal then
               Node.Message_Content_Model := WSDL.AST.Messages.None;

            elsif Value = Other_Literal then
               Node.Message_Content_Model := WSDL.AST.Messages.Other;

            else
               Node.Message_Content_Model := WSDL.AST.Messages.Element;
               Node.Element := Value;
            end if;
         end;

      else
         Node.Message_Content_Model := WSDL.AST.Messages.Other;
      end if;
   end Start_Input_Output_Element;

   -----------------------------
   -- Start_Interface_Element --
   -----------------------------

   procedure Start_Interface_Element
    (Attributes  : XML.SAX.Attributes.SAX_Attributes;
     Namespaces  : Namespace_Maps.Map;
     Description : WSDL.AST.Descriptions.Description_Access;
     Node        : out WSDL.AST.Interfaces.Interface_Access;
     Success     : in out Boolean)
   is
      Name : constant League.Strings.Universal_String
        := Attributes.Value (Name_Attribute);

   begin
      --  Interface-1010: For each Interface component in the {interfaces}
      --  property of a Description component, the {name} property MUST be
      --  unique.
      --
      --  Check whether name of the interface component is not used by another
      --  component.

      if Description.Interfaces.Contains (Name) then
         raise Program_Error;
      end if;

      Node := new WSDL.AST.Interfaces.Interface_Node;
      Node.Parent := WSDL.AST.Components.Description_Access (Description);
      Node.Local_Name := Name;
      Description.Interfaces.Insert (Name, Node);

      --  Analyze 'extends' attribute when specified.

      if Attributes.Is_Specified (Extends_Attribute) then
         declare
            Values : constant League.String_Vectors.Universal_String_Vector
              := Attributes.Value (Extends_Attribute).Split
                  (' ', League.Strings.Skip_Empty);
            Value  : League.Strings.Universal_String;
            Index  : Natural;
            Item   : WSDL.AST.Name_Pair;

         begin
            for J in 1 .. Values.Length loop
               Value := Values.Element (J);
               Index := Value.Index (':');
               Item :=
                (Namespaces.Element (Value.Slice (1, Index - 1)),
                 Value.Slice (Index + 1, Value.Length));

               --  Interface-1011: The list of xs:QName in an extends attribute
               --  information item MUST NOT contain duplicates.
               --
               --  Check whether this namespace/name pair is not in the set
               --  already.

               if Node.Extends.Contains (Item) then
                  raise Program_Error;
               end if;

               Node.Extends.Insert (Item);
            end loop;
         end;
      end if;

      --  Analyze 'styleDefault' attribute when specified.

      if Attributes.Is_Specified (Style_Default_Attribute) then
         Node.Style_Default :=
           Attributes.Value (Style_Default_Attribute).Split
            (' ', League.Strings.Skip_Empty);

         --  Interface-2012: The type of the styleDefault attribute information
         --  item is list of xs:anyURI. Its value, if present, MUST contain
         --  absolute IRIs (see [IETF RFC 3987]).
         --
         --  XXX This check is not implemented.
      end if;
   end Start_Interface_Element;

   ---------------------------------------
   -- Start_Interface_Operation_Element --
   ---------------------------------------

   procedure Start_Interface_Operation_Element
    (Attributes : XML.SAX.Attributes.SAX_Attributes;
     Parent     : WSDL.AST.Interfaces.Interface_Access;
     Node       : out WSDL.AST.Operations.Interface_Operation_Access;
     Success    : in out Boolean)
   is
      Name : constant League.Strings.Universal_String
        := Attributes.Value (Name_Attribute);

   begin
      Node := new WSDL.AST.Operations.Interface_Operation_Node;
      Node.Parent := WSDL.AST.Operations.Interface_Access (Parent);
      Node.Local_Name := Name;
      Parent.Interface_Operations.Insert (Name, Node);

      --  Analyze 'pattern' attribute.

      if Attributes.Is_Specified (Pattern_Attribute) then
         Node.Message_Exchange_Pattern := Attributes.Value (Pattern_Attribute);

      else
         Node.Message_Exchange_Pattern := Pattern_Default;
      end if;

      --  Analyze 'style' attribute.

      if Attributes.Is_Specified (Style_Attribute) then
         Node.Style :=
           Attributes.Value (Style_Attribute).Split
            (' ', League.Strings.Skip_Empty);

      else
         Node.Style := Node.Parent.Style_Default;
      end if;
   end Start_Interface_Operation_Element;

   --------------------------
   -- Start_Prefix_Mapping --
   --------------------------

   overriding procedure Start_Prefix_Mapping
    (Self          : in out WSDL_Parser;
     Prefix        : League.Strings.Universal_String;
     Namespace_URI : League.Strings.Universal_String;
     Success       : in out Boolean) is
   begin
      Self.Namespaces.Insert (Prefix, Namespace_URI);
   end Start_Prefix_Mapping;

   -------------------------
   -- Start_Types_Element --
   -------------------------

   procedure Start_Types_Element
    (Description : WSDL.AST.Descriptions.Description_Access;
     Success     : in out Boolean) is
   begin
      Description.Types := new WSDL.AST.Types.Types_Node;
      Description.Types.Parent :=
        WSDL.AST.Components.Description_Access (Description);
   end Start_Types_Element;

end WSDL.Parsers;
