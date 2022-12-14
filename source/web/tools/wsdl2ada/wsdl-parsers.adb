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
-- Copyright © 2012-2015, Vadim Godunko <vgodunko@gmail.com>                --
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
with League.String_Vectors;

with WSDL.AST.Bindings;
pragma Unreferenced (WSDL.AST.Bindings);
--  GNAT Pro 7.2.0w (20130423): package is needed to access to type's
--  components.
with WSDL.AST.Descriptions;
pragma Unreferenced (WSDL.AST.Descriptions);
--  GNAT Pro 7.2.0w (20130423): package is needed to access to type's
--  components.
with WSDL.AST.Endpoints;
with WSDL.AST.Faults;
with WSDL.AST.Interfaces;
with WSDL.AST.Messages;
with WSDL.AST.Operations;
with WSDL.AST.Types;
with WSDL.Constants;
with WSDL.Diagnoses;
with WSDL.MEPs;
with WSDL.Parsers.MEP;
with WSDL.Parsers.SOAP;

package body WSDL.Parsers is

   use WSDL.Constants;
   use type League.Strings.Universal_String;
   use type WSDL.AST.Message_Directions;
   use type WSDL.AST.Qualified_Name;

   procedure Push
    (Self : in out WSDL_Parser'Class; State : Parser_State_Kind);

   procedure Pop (Self : in out WSDL_Parser'Class);

   function To_Qualified_Name
    (Namespaces : Namespace_Maps.Map;
     Name       : League.Strings.Universal_String)
       return WSDL.AST.Qualified_Name;
   --  Construct qualified name from the given prefix:localName string.

   procedure Start_Description_Element
    (Self       : in out WSDL_Parser'Class;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean);
   --  Handles start of 'description' element.

   procedure Start_Types_Element
    (Description : WSDL.AST.Description_Access;
     Success     : in out Boolean);
   --  Handles start of 'types' element.

   procedure Start_Interface_Element
    (Parser      : in out WSDL_Parser;
     Attributes  : XML.SAX.Attributes.SAX_Attributes;
     Namespaces  : Namespace_Maps.Map;
     Description : WSDL.AST.Description_Access;
     Node        : out WSDL.AST.Interface_Access;
     Success     : in out Boolean);
   --  Handles start of 'interface' element.

   procedure Start_Interface_Fault_Element
    (Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Interface_Access;
--     Node       : out WSDL.AST.Faults.Interface_Fault_Access;
     Success    : in out Boolean);
   --  Handles start of 'fault' element as child of 'interface' element.

   procedure Start_Interface_Operation_Element
    (Parser     : WSDL_Parser;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Parent     : not null WSDL.AST.Interface_Access;
     Node       : out WSDL.AST.Interface_Operation_Access;
     Success    : in out Boolean);
   --  Handles start of 'operation' element as child of 'interface' element.

   procedure Start_Input_Output_Element
    (Parser     : WSDL_Parser;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Interface_Operation_Access;
     Direction  : WSDL.AST.Message_Directions;
     Success    : in out Boolean);
   --  Handles start of 'input' and 'output' element as child of 'operation'
   --  element as child of 'interface' element.

   procedure Start_Input_Output_Fault_Element
    (Parser     : WSDL_Parser;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Interface_Operation_Access;
     Direction  : WSDL.AST.Message_Directions;
     Success    : in out Boolean);
   --  Handles start of 'infault' and 'outfault' element as child of
   --  'operation' element as child of 'interface' element.

   procedure Start_Binding_Element
    (Parser     : WSDL_Parser;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Description_Access;
     Node       : out WSDL.AST.Binding_Access;
     Success    : in out Boolean);
   --  Handles start of 'interface' element.

   procedure End_Binding_Element
    (Parser  : WSDL_Parser;
     Node    : WSDL.AST.Binding_Access;
     Success : in out Boolean);
   --  Handles start of 'interface' element.

   procedure Start_Binding_Fault_Element
    (Parser     : WSDL_Parser;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Binding_Access;
     Success    : in out Boolean);
   --  Handles start of 'fault' element as child of 'binding' element.

   procedure Start_Binding_Operation_Element
    (Parser     : WSDL_Parser;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Binding_Access;
--     Node       : out WSDL.AST.Operations.Interface_Operation_Access;
     Success    : in out Boolean);
   --  Handles start of 'operation' element as child of 'binding' element.

   procedure Start_Service_Element
    (Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Description_Access;
     Node       : out WSDL.AST.Services.Service_Access;
     Success    : in out Boolean);
   --  Handles start of 'service' element.

   procedure Start_Endpoint_Element
    (Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Services.Service_Access;
     Success    : in out Boolean);
   --  Handles start of 'service' element.

   -------------------------
   -- End_Binding_Element --
   -------------------------

   procedure End_Binding_Element
    (Parser  : WSDL_Parser;
     Node    : WSDL.AST.Binding_Access;
     Success : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      if Node.Interface_Name.Local_Name.Is_Empty
        and (not Node.Binding_Operations.Is_Empty
               or not Node.Binding_Faults.Is_Empty)
      then
         --  Binding-1044: "If a Binding component specifies any
         --  operation-specific binding details (by including Binding Operation
         --  components) or any fault binding details (by including Binding
         --  Fault components), then it MUST specify an interface the Binding
         --  component applies to, so as to indicate which interface the
         --  operations come from."

         Parser.Report (WSDL.Assertions.Binding_1044);

         raise WSDL_Error;
      end if;
   end End_Binding_Element;

   -----------------
   -- End_Element --
   -----------------

   overriding procedure End_Element
    (Self           : in out WSDL_Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean)
   is
      pragma Unreferenced (Qualified_Name);

   begin
      if Self.Ignore_Depth /= 0 then
         Self.Ignore_Depth := Self.Ignore_Depth - 1;

      elsif Namespace_URI = WSDL_Namespace_URI then
         if Local_Name = Binding_Element then
            End_Binding_Element (Self, Self.Current_Binding, Success);
            Self.Pop;

         elsif Local_Name = Description_Element then
            Self.Pop;

         elsif Local_Name = Endpoint_Element then
            Self.Pop;

         elsif Local_Name = Fault_Element then
            Self.Pop;

         elsif Local_Name = Infault_Element then
            Self.Pop;

         elsif Local_Name = Input_Element then
            Self.Pop;

         elsif Local_Name = Interface_Element then
            Self.Pop;

         elsif Local_Name = Operation_Element then
            Self.Pop;

         elsif Local_Name = Outfault_Element then
            Self.Pop;

         elsif Local_Name = Output_Element then
            Self.Pop;

         elsif Local_Name = Service_Element then
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
    (Self : WSDL_Parser) return League.Strings.Universal_String
   is
      pragma Unreferenced (Self);

   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   ---------------------
   -- Get_Description --
   ---------------------

   function Get_Description
    (Self : WSDL_Parser'Class) return WSDL.AST.Description_Access is
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

   ------------
   -- Report --
   ------------

   procedure Report
    (Self      : WSDL_Parser;
     Assertion : WSDL.Assertions.WSDL_Assertion) is
   begin
      WSDL.Assertions.Report
       (Self.Locator.System_Id,
        WSDL.Diagnoses.Line_Number (Self.Locator.Line),
        WSDL.Diagnoses.Column_Number (Self.Locator.Column),
        Assertion);
   end Report;

   --------------------------
   -- Set_Document_Locator --
   --------------------------

   overriding procedure Set_Document_Locator
    (Self    : in out WSDL_Parser;
     Locator : XML.SAX.Locators.SAX_Locator) is
   begin
      Self.Locator := Locator;
   end Set_Document_Locator;

   ---------------------------
   -- Start_Binding_Element --
   ---------------------------

   procedure Start_Binding_Element
    (Parser     : WSDL_Parser;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Description_Access;
     Node       : out WSDL.AST.Binding_Access;
     Success    : in out Boolean)
   is
      Name : constant League.Strings.Universal_String
        := Attributes.Value (Name_Attribute);

   begin
      --  Binding-1049: "For each Binding component in the {bindings} property
      --  of a Description component, the {name} property MUST be unique."

      if Parent.Bindings.Contains (Name) then
         Parser.Report (WSDL.Assertions.Binding_1049);

         raise WSDL_Error;
      end if;

      Node := WSDL.AST.Bindings.Constructors.Create_Binding (Parent, Name);

      --  Analyze 'interface' attribute.

      if Attributes.Is_Specified (Interface_Attribute) then
         Node.Interface_Name :=
            To_Qualified_Name
             (Namespaces, Attributes.Value (Interface_Attribute));
      end if;

      --  Analyze 'type' attribute.

      Node.Binding_Type := Attributes.Value (Type_Attribute);

      --  Binding-1048: "This xs:anyURI MUST be an absolute IRI as defined by
      --  [IETF RFC 3987]."
      --
      --  XXX Not implemented yet.

      --  Analyze SOAP Binding extension's attributes.

      if Node.Binding_Type = SOAP_Binding_Type then
         --  Call SOAP Binding handler.

         WSDL.Parsers.SOAP.Start_Binding_Element (Attributes, Node, Success);
      end if;
   end Start_Binding_Element;

   ---------------------------------
   -- Start_Binding_Fault_Element --
   ---------------------------------

   procedure Start_Binding_Fault_Element
    (Parser     : WSDL_Parser;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Binding_Access;
     Success    : in out Boolean)
   is
      pragma Unreferenced (Success);

      use type WSDL.AST.Binding_Fault_Access;

      Node : WSDL.AST.Binding_Fault_Access;

   begin
      Node := new WSDL.AST.Faults.Binding_Fault_Node;
      Node.Parent := Parent;
      Parent.Binding_Faults.Append (Node);

      --  Analyze 'ref' attribute.

      Node.Ref := To_Qualified_Name (Namespaces, Attributes.Value (Ref_Attribute));

      --  BindingFault-1050: "For each Binding Fault component in the {binding
      --  faults} property of a Binding component, the {interface fault}
      --  property MUST be unique."

      for J of Parent.Binding_Faults loop
         if J /= Node and J.Ref = Node.Ref then
            Parser.Report (WSDL.Assertions.BindingFault_1050);

            raise WSDL_Error;
         end if;
      end loop;
   end Start_Binding_Fault_Element;

   -------------------------------------
   -- Start_Binding_Operation_Element --
   -------------------------------------

   procedure Start_Binding_Operation_Element
    (Parser     : WSDL_Parser;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Binding_Access;
--     Node       : out WSDL.AST.Operations.Interface_Operation_Access;
     Success    : in out Boolean)
   is
      use type WSDL.AST.Binding_Operation_Access;

      Node : WSDL.AST.Binding_Operation_Access;

   begin
      Node := new WSDL.AST.Operations.Binding_Operation_Node;
      Node.Parent := Parent;
      Parent.Binding_Operations.Append (Node);

      --  Analyze 'ref' attribute.

      Node.Ref :=
        To_Qualified_Name (Namespaces, Attributes.Value (Ref_Attribute));

      --  BindingOperation-1051: "For each Binding Operation component in the
      --  {binding operations} property of a Binding component, the {interface
      --  operation} property MUST be unique."

      for J of Parent.Binding_Operations loop
         if J /= Node and J.Ref = Node.Ref then
            Parser.Report (WSDL.Assertions.BindingOperation_1051);

            raise WSDL_Error;
         end if;
      end loop;

      --  Analyze SOAP Binding extension's attributes.

      if Parent.Binding_Type = SOAP_Binding_Type then
         --  Call SOAP Binding handler.

         WSDL.Parsers.SOAP.Start_Binding_Operation_Element
          (Attributes, Node, Success);
      end if;
   end Start_Binding_Operation_Element;

   -------------------------------
   -- Start_Description_Element --
   -------------------------------

   procedure Start_Description_Element
    (Self       : in out WSDL_Parser'Class;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      Self.Description := new WSDL.AST.Descriptions.Description_Node;
      Self.Description.Target_Namespace :=
        Attributes.Value (Target_Namespace_Attribute);

      --  Description-1006: "IRI of target namespace must be absolute."
      --
      --  XXX Not implemented yet.
   end Start_Description_Element;

   --------------------
   -- Start_Document --
   --------------------

   overriding procedure Start_Document
    (Self    : in out WSDL_Parser;
     Success : in out Boolean)
   is
      pragma Unreferenced (Success);

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
     Success        : in out Boolean)
   is
      pragma Unreferenced (Qualified_Name);

   begin
      if Self.Ignore_Depth /= 0 then
         Self.Ignore_Depth := Self.Ignore_Depth + 1;

      elsif Namespace_URI = WSDL_Namespace_URI then
         if Local_Name = Binding_Element then
            if Self.Current_State.Kind = WSDL_Description then
               Self.Current_State.Last_Child_Kind := Interface_Binding_Service;
               Self.Push (WSDL_Binding);
               Start_Binding_Element
                (Self,
                 Attributes,
                 Self.Namespaces,
                 Self.Description,
                 Self.Current_Binding,
                 Success);

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
                  --  Description-1005: "Invalid order of children elements of
                  --  'description' element."

                  Self.Report (WSDL.Assertions.Description_1005);

                  raise WSDL_Error;

               else
                  Self.Current_State.Last_Child_Kind := Documentation;
                  Self.Ignore_Depth := 1;
               end if;

            elsif Self.Current_State.Kind = WSDL_Binding
              or Self.Current_State.Kind = WSDL_Binding_Operation
              or Self.Current_State.Kind = WSDL_Endpoint
              or Self.Current_State.Kind = WSDL_Input
              or Self.Current_State.Kind = WSDL_Interface
              or Self.Current_State.Kind = WSDL_Interface_Operation
              or Self.Current_State.Kind = WSDL_Output
              or Self.Current_State.Kind = WSDL_Service
            then
               Self.Ignore_Depth := 1;

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Endpoint_Element then
            if Self.Current_State.Kind = WSDL_Service then
               Self.Push (WSDL_Endpoint);
               Start_Endpoint_Element
                (Attributes, Self.Namespaces, Self.Current_Service, Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Fault_Element then
            if Self.Current_State.Kind = WSDL_Interface then
               Self.Push (WSDL_Interface_Fault);
               Start_Interface_Fault_Element
                (Attributes,
                 Self.Namespaces,
                 Self.Current_Interface,
--                 Self.Current_Fault,
                 Success);

            elsif Self.Current_State.Kind = WSDL_Binding then
               Self.Push (WSDL_Binding_Fault);
               Start_Binding_Fault_Element
                (Self,
                 Attributes,
                 Self.Namespaces,
                 Self.Current_Binding,
                 Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Include_Element then
            if Self.Current_State.Kind = WSDL_Description then
               if Self.Current_State.Last_Child_Kind > Include_Import then
                  --  Description-1005: "Invalid order of children elements of
                  --  'description' element."

                  Self.Report (WSDL.Assertions.Description_1005);

                  raise WSDL_Error;

               else
                  Self.Current_State.Last_Child_Kind := Include_Import;
                  Self.Ignore_Depth := 1;
               end if;

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Infault_Element then
            if Self.Current_State.Kind = WSDL_Binding_Operation then
               --  XXX all children elements are ignored for now.

               Self.Ignore_Depth := 1;

            elsif Self.Current_State.Kind = WSDL_Interface_Operation then
               Self.Push (WSDL_Infault);
               Start_Input_Output_Fault_Element
                (Self,
                 Attributes,
                 Self.Namespaces,
                 Self.Current_Operation,
                 WSDL.AST.In_Message,
                 Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Input_Element then
            if Self.Current_State.Kind = WSDL_Binding_Operation then
               --  XXX all children elements are ignored for now.

               Self.Ignore_Depth := 1;

            elsif Self.Current_State.Kind = WSDL_Interface_Operation then
               Self.Push (WSDL_Input);
               Start_Input_Output_Element
                (Self,
                 Attributes,
                 Self.Namespaces,
                 Self.Current_Operation,
                 WSDL.AST.In_Message,
                 Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Interface_Element then
            if Self.Current_State.Kind = WSDL_Description then
               Self.Current_State.Last_Child_Kind := Interface_Binding_Service;
               Self.Push (WSDL_Interface);
               Start_Interface_Element
                (Self,
                 Attributes,
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
                  --  "Description-1005: Invalid order of children elements of
                  --  'description' element."

                  Self.Report (WSDL.Assertions.Description_1005);

                  raise WSDL_Error;

               else
                  Self.Current_State.Last_Child_Kind := Include_Import;
                  Self.Ignore_Depth := 1;
               end if;

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Operation_Element then
            if Self.Current_State.Kind = WSDL_Interface then
               Self.Push (WSDL_Interface_Operation);
               Start_Interface_Operation_Element
                (Self,
                 Attributes,
                 Self.Current_Interface,
                 Self.Current_Operation,
                 Success);

            elsif Self.Current_State.Kind = WSDL_Binding then
               Self.Push (WSDL_Binding_Operation);
               Start_Binding_Operation_Element
                (Self,
                 Attributes,
                 Self.Namespaces,
                 Self.Current_Binding,
                 Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Outfault_Element then
            if Self.Current_State.Kind = WSDL_Binding_Operation then
               --  XXX all children elements are ignored for now.

               Self.Ignore_Depth := 1;

            elsif Self.Current_State.Kind = WSDL_Interface_Operation then
               Self.Push (WSDL_Outfault);
               Start_Input_Output_Fault_Element
                (Self,
                 Attributes,
                 Self.Namespaces,
                 Self.Current_Operation,
                 WSDL.AST.Out_Message,
                 Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Output_Element then
            if Self.Current_State.Kind = WSDL_Binding_Operation then
               --  XXX all children elements are ignored for now.

               Self.Ignore_Depth := 1;

            elsif Self.Current_State.Kind = WSDL_Interface_Operation then
               Self.Push (WSDL_Output);
               Start_Input_Output_Element
                (Self,
                 Attributes,
                 Self.Namespaces,
                 Self.Current_Operation,
                 WSDL.AST.Out_Message,
                 Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Service_Element then
            if Self.Current_State.Kind = WSDL_Description then
               Self.Current_State.Last_Child_Kind := Interface_Binding_Service;
               Self.Push (WSDL_Service);
               Start_Service_Element
                (Attributes,
                 Self.Namespaces,
                 Self.Description,
                 Self.Current_Service,
                 Success);

            else
               raise Program_Error;
            end if;

         elsif Local_Name = Types_Element then
            if Self.Current_State.Kind = WSDL_Description then
               if Self.Current_State.Last_Child_Kind > Types then
                  --  Description-1005: "Invalid order of children elements of
                  --  'description' element."

                  Self.Report (WSDL.Assertions.Description_1005);

                  raise WSDL_Error;

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

      elsif Namespace_URI = WSDL_1x_Namespace_URI then
         --  WSDL 1.x is not supported.

         WSDL.Diagnoses.Report
          (Self.Locator.System_Id,
           WSDL.Diagnoses.Line_Number (Self.Locator.Line),
           WSDL.Diagnoses.Column_Number (Self.Locator.Column),
           League.Strings.To_Universal_String ("WSDL 1.x is not supported"));

         raise WSDL_Error;

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
           or Self.Current_State.Kind = WSDL_Binding_Operation
           or Self.Current_State.Kind = WSDL_Endpoint
           or Self.Current_State.Kind = WSDL_Input
           or Self.Current_State.Kind = WSDL_Interface
           or Self.Current_State.Kind = WSDL_Interface_Operation
           or Self.Current_State.Kind = WSDL_Output
           or Self.Current_State.Kind = WSDL_Service
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

   ----------------------------
   -- Start_Endpoint_Element --
   ----------------------------

   procedure Start_Endpoint_Element
    (Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Services.Service_Access;
     Success    : in out Boolean)
   is
      pragma Unreferenced (Success);

      Name : constant League.Strings.Universal_String
        := Attributes.Value (Name_Attribute);
      Node : WSDL.AST.Endpoints.Endpoint_Access;

   begin
      Node := new WSDL.AST.Endpoints.Endpoint_Node;
      Node.Parent := WSDL.AST.Endpoints.Service_Access (Parent);
      Node.Local_Name := Name;
      Parent.Endpoints.Insert (Name, Node);

      --  Analyze 'binding' attribute.

      Node.Binding_Name :=
        To_Qualified_Name (Namespaces, Attributes.Value (Binding_Attribute));

      --  Analyze 'address' attribute.

      if Attributes.Is_Specified (Address_Attribute) then
         Node.Address := Attributes.Value (Address_Attribute);
      end if;
   end Start_Endpoint_Element;

   --------------------------------------
   -- Start_Input_Output_Fault_Element --
   --------------------------------------

   procedure Start_Input_Output_Fault_Element
    (Parser     : WSDL_Parser;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Interface_Operation_Access;
     Direction  : WSDL.AST.Message_Directions;
     Success    : in out Boolean)
   is
      pragma Unreferenced (Success);

      Node              : constant WSDL.AST.Interface_Fault_Reference_Access
        := new WSDL.AST.Faults.Interface_Fault_Reference_Node;
      Message_Direction : WSDL.AST.Message_Directions;
      Found             : Boolean;

   begin
      Node.Parent := Parent;
      Parent.Interface_Fault_References.Append (Node);

      --  InterfaceFaultReference-1037: "The value of this property MUST match
      --  the name of a placeholder message defined by the message exchange
      --  pattern."
      --
      --  Enforced by construction.

      --  InterfaceFaultReference-1038: "The direction MUST be consistent with
      --  the direction implied by the fault propagation ruleset used in the
      --  message exchange pattern of the operation."
      --
      --  Enforced by construction.

      Node.Interface_Fault_Name :=
        To_Qualified_Name (Namespaces, Attributes.Value (Ref_Attribute));

      Node.Direction := Direction;

      case Node.Direction is
         when WSDL.AST.In_Message =>
            --  MessageLabel-1034: "If the local name is infault then the
            --  message exchange pattern MUST support at least one fault in the
            --  "In" direction."

            if not Parent.Message_Exchange_Pattern.Has_In_Fault then
               Parser.Report (WSDL.Assertions.MessageLabel_1034);

               raise WSDL_Error;
            end if;

         when WSDL.AST.Out_Message =>
            --  MessageLabel-1035: "If the local name is outfault then the
            --  message exchange pattern MUST support at least one fault in the
            --  "Out" direction."

            if not Parent.Message_Exchange_Pattern.Has_Out_Fault then
               Parser.Report (WSDL.Assertions.MessageLabel_1034);

               raise WSDL_Error;
            end if;
      end case;

      --  Compute corresponding message direction depending on Fault
      --  Propagation Rule.

      case Parent.Message_Exchange_Pattern.FPR is
         when WSDL.MEPs.Fault_Replaces_Message =>
            Message_Direction := Direction;

         when WSDL.MEPs.Message_Triggers_Fault =>
            case Direction is
               when WSDL.AST.In_Message =>
                  Message_Direction := WSDL.AST.Out_Message;

               when WSDL.AST.Out_Message =>
                  Message_Direction := WSDL.AST.In_Message;
            end case;

         when WSDL.MEPs.No_Faults =>
            --  Must never be happen, it violates MessageLabel-1034 and
            --  MessageLabel-1035 assertions tested above.

            raise Program_Error;
      end case;

      --  Analyze 'messageLabel' attribute.

      if Attributes.Is_Specified (Message_Label_Attribute) then
         Node.Message_Label := Attributes.Value (Message_Label_Attribute);

      else
         --  InterfaceFaultReference-1040: "The messageLabel attribute
         --  information item MUST be present in the XML representation of an
         --  Interface Fault Reference component with a given {direction}, if
         --  the {message exchange pattern} of the parent Interface Operation
         --  component has more than one fault with that direction."

         case Node.Direction is
            when WSDL.AST.In_Message =>
               if not Parent.Message_Exchange_Pattern.Has_Single_In_Fault then
                  Parser.Report (WSDL.Assertions.InterfaceFaultReference_1040);

                  raise WSDL_Error;
               end if;

            when WSDL.AST.Out_Message =>
               if not Parent.Message_Exchange_Pattern.Has_Single_Out_Fault then
                  Parser.Report (WSDL.Assertions.InterfaceFaultReference_1040);

                  raise WSDL_Error;
               end if;
         end case;

         --  MessageLabel-1043: "If the messageLabel attribute information item
         --  of an interface fault reference element information item is absent
         --  then there MUST be a unique placeholder message with {direction}
         --  equal to the message direction."

         case Message_Direction is
            when WSDL.AST.In_Message =>
               if not Parent.Message_Exchange_Pattern.Has_In then
                  Parser.Report (WSDL.Assertions.MessageLabel_1043);

                  raise WSDL_Error;
               end if;

            when WSDL.AST.Out_Message =>
               if not Parent.Message_Exchange_Pattern.Has_Out then
                  Parser.Report (WSDL.Assertions.MessageLabel_1043);

                  raise WSDL_Error;
               end if;
         end case;

         --  MessageLabel-1041: "The messageLabel attribute information item of
         --  an interface fault reference element information item MUST be
         --  present if the message exchange pattern has more than one
         --  placeholder message with {direction} equal to the message
         --  direction."

         case Message_Direction is
            when WSDL.AST.In_Message =>
               if not Parent.Message_Exchange_Pattern.Has_Single_In then
                  Parser.Report (WSDL.Assertions.MessageLabel_1041);

                  raise WSDL_Error;
               end if;

            when WSDL.AST.Out_Message =>
               if not Parent.Message_Exchange_Pattern.Has_Single_Out then
                  Parser.Report (WSDL.Assertions.MessageLabel_1041);

                  raise WSDL_Error;
               end if;
         end case;
      end if;

      --  Lookup for placeholder message in the operation's MEP.

      Found := False;

      for J in Parent.Message_Exchange_Pattern.Placeholders'Range loop
         if Parent.Message_Exchange_Pattern.Placeholders (J).Direction
              = Message_Direction
           and (Node.Message_Label.Is_Empty
                  or Parent.Message_Exchange_Pattern.Placeholders (J).Label
                       = Node.Message_Label)
         then
            --  InterfaceFaultReference-1039: "For each Interface Fault
            --  Reference component in the {interface fault references}
            --  property of an Interface Operation component, the combination
            --  of its {interface fault} and {message label} properties MUST be
            --  unique."
            --
            --  All declared faults corresponding to message placeholder are
            --  stored in maps to checks unique of their names.

            if Parent.Message_Exchange_Pattern.Placeholders (J).Faults.Contains
                (Node.Interface_Fault_Name)
            then
               Parser.Report (WSDL.Assertions.InterfaceFaultReference_1039);

               raise WSDL_Error;
            end if;

            Parent.Message_Exchange_Pattern.Placeholders (J).Faults.Insert
             (Node.Interface_Fault_Name, Node);
            Node.Message_Label :=
              Parent.Message_Exchange_Pattern.Placeholders (J).Label;
            Found := True;

            exit;
         end if;
      end loop;

      if not Found then
         --  MessageLabel-1042: "If the messageLabel attribute information item
         --  of an interface fault reference element information item is
         --  present then its actual value MUST match the {message label} of
         --  some placeholder message with {direction} equal to the message
         --  direction."
         --
         --  When messageLabel attribute of interface fault reference
         --  element is not specified, it always found because there is only
         --  one placeholder message in the MEP. Thus, additional checks are
         --  not needed here.

         Parser.Report (WSDL.Assertions.MessageLabel_1042);

         raise WSDL_Error;
      end if;
   end Start_Input_Output_Fault_Element;

   --------------------------------
   -- Start_Input_Output_Element --
   --------------------------------

   procedure Start_Input_Output_Element
    (Parser     : WSDL_Parser;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Interface_Operation_Access;
     Direction  : WSDL.AST.Message_Directions;
     Success    : in out Boolean)
   is
      pragma Unreferenced (Success);

      use type WSDL.AST.Interface_Message_Access;

      Node  : constant WSDL.AST.Interface_Message_Access
        := new WSDL.AST.Messages.Interface_Message_Node;
      Found : Boolean;

   begin
      Node.Parent := Parent;
      Parent.Interface_Message_References.Append (Node);

      --  InterfaceMessageReference-1025: "An xs:token with one of the values
      --  in or out, indicating whether the message is coming to the service or
      --  going from the service, respectively."
      --
      --  This assertion is enforced by construction.

      --  InterfaceMessageReference-1026: "The direction MUST be the same as
      --  the direction of the message identified by the {message label}
      --  property in the {message exchange pattern} of the Interface Operation
      --  component this is contained within."
      --
      --  This assertion is enforced by construction.

      --  MessageLabel-1024: "The value of this property MUST match the name of
      --  placeholder message defined by the message exchange pattern."
      --
      --  This assertion is enforced by construction.

      Node.Direction := Direction;

      case Direction is
         when WSDL.AST.In_Message =>
            --  MessageLabel-1032: "If the local name is input then the message
            --  exchange pattern MUST have at least one placeholder message
            --  with direction "In"."

            if not Parent.Message_Exchange_Pattern.Has_In then
               Parser.Report (WSDL.Assertions.MessageLabel_1032);

               raise WSDL_Error;
            end if;

         when WSDL.AST.Out_Message =>
            --  MessageLabel-1033: "If the local name is output then the
            --  message exchange pattern MUST have at least one placeholder
            --  message with direction "Out"."

            if not Parent.Message_Exchange_Pattern.Has_Out then
               Parser.Report (WSDL.Assertions.MessageLabel_1033);

               raise WSDL_Error;
            end if;
      end case;

      --  Analyze 'messageLabel' attribute.

      if Attributes.Is_Specified (Message_Label_Attribute) then
         Node.Message_Label := Attributes.Value (Message_Label_Attribute);

      else
         --  MessageLabel-1031: "If the messageLabel attribute information item
         --  of an interface message reference element information item is
         --  absent then there MUST be a unique placeholder message with
         --  {direction} equal to the message direction."

         case Direction is
            when WSDL.AST.In_Message =>
               if not Parent.Message_Exchange_Pattern.Has_Single_In then
                  Parser.Report (WSDL.Assertions.MessageLabel_1031);

                  raise WSDL_Error;
               end if;

            when WSDL.AST.Out_Message =>
               if not Parent.Message_Exchange_Pattern.Has_Single_Out then
                  Parser.Report (WSDL.Assertions.MessageLabel_1031);

                  raise WSDL_Error;
               end if;
         end case;
      end if;

      --  Lookup for placeholder in the operation's MEP.

      Found := False;

      for J in Parent.Message_Exchange_Pattern.Placeholders'Range loop
         if Parent.Message_Exchange_Pattern.Placeholders (J).Direction
              = Direction
           and (Node.Message_Label.Is_Empty
                  or Parent.Message_Exchange_Pattern.Placeholders (J).Label
                       = Node.Message_Label)
         then
            --  InterfaceMessageReference-1029: "For each Interface Message
            --  Reference component in the {interface message references}
            --  property of an Interface Operation component, its {message
            --  label} property MUST be unique."
            --
            --  This code assumes that MEP uses unique labels for messages and
            --  takes in sense the fact that Message member is filled by
            --  interface message reference once it is processed.

            if Parent.Message_Exchange_Pattern.Placeholders (J).Message /= null then
               Parser.Report (WSDL.Assertions.InterfaceMessageReference_1029);

               raise WSDL_Error;
            end if;

            Parent.Message_Exchange_Pattern.Placeholders (J).Message := Node;
            Node.Message_Label :=
              Parent.Message_Exchange_Pattern.Placeholders (J).Label;
            Found := True;

            exit;
         end if;
      end loop;

      if not Found then
         --  MessageLabel-1030: "If the messageLabel attribute information item
         --  of an interface message reference element information item is
         --  present, then its actual value MUST match the {message label} of
         --  some placeholder message with {direction} equal to the message
         --  direction."

         Parser.Report (WSDL.Assertions.MessageLabel_1030);

         raise WSDL_Error;
      end if;

      --  Analyze 'element' attribute.

      --  InterfaceMessageReference-1027: "An xs:token with one of the values
      --  #any, #none, #other, or #element."
      --
      --  This assertion is enforced by construction.

      --  InterfaceMessageReference-1028: "When the {message content model}
      --  property has the value #any or #none, the {element declaration}
      --  property MUST be empty."
      --
      --  This assertion is enforced by construction.

      if Attributes.Is_Specified (Element_Attribute) then
         declare
            Value : constant League.Strings.Universal_String
              := Attributes.Value (Element_Attribute);

         begin
            if Value = Any_Literal then
               Node.Message_Content_Model := WSDL.AST.Any;

            elsif Value = None_Literal then
               Node.Message_Content_Model := WSDL.AST.None;

            elsif Value = Other_Literal then
               Node.Message_Content_Model := WSDL.AST.Other;

            else
               Node.Message_Content_Model := WSDL.AST.Element;
               Node.Element := To_Qualified_Name (Namespaces, Value);
            end if;
         end;

      else
         Node.Message_Content_Model := WSDL.AST.Other;
      end if;
   end Start_Input_Output_Element;

   -----------------------------
   -- Start_Interface_Element --
   -----------------------------

   procedure Start_Interface_Element
    (Parser      : in out WSDL_Parser;
     Attributes  : XML.SAX.Attributes.SAX_Attributes;
     Namespaces  : Namespace_Maps.Map;
     Description : WSDL.AST.Description_Access;
     Node        : out WSDL.AST.Interface_Access;
     Success     : in out Boolean)
   is
      pragma Unreferenced (Success);

      Name : constant League.Strings.Universal_String
        := Attributes.Value (Name_Attribute);

   begin
      --  Interface-1010: "For each Interface component in the {interfaces}
      --  property of a Description component, the {name} property MUST be
      --  unique."
      --
      --  Check whether name of the interface component is not used by another
      --  component.

      if Description.Interfaces.Contains (Name) then
         Parser.Report (WSDL.Assertions.Interface_1010);

         raise WSDL_Error;
      end if;

      Node := new WSDL.AST.Interfaces.Interface_Node;
      Node.Parent := Description;
      Node.Local_Name := Name;
      Description.Interfaces.Insert (Name, Node);

      --  Analyze 'extends' attribute when specified.

      if Attributes.Is_Specified (Extends_Attribute) then
         declare
            Values : constant League.String_Vectors.Universal_String_Vector
              := Attributes.Value (Extends_Attribute).Split
                  (' ', League.Strings.Skip_Empty);
            Item   : WSDL.AST.Qualified_Name;

         begin
            for J in 1 .. Values.Length loop
               Item := To_Qualified_Name (Namespaces, Values.Element (J));

               --  Interface-1011: "The list of xs:QName in an extends
               --  attribute information item MUST NOT contain duplicates."
               --
               --  Check whether this namespace/name pair is not in the set
               --  already.

               if Node.Extends.Contains (Item) then
                  Parser.Report (WSDL.Assertions.Interface_1011);

                  raise WSDL_Error;
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

         --  Interface-1012: "The type of the styleDefault attribute
         --  information item is list of xs:anyURI. Its value, if present, MUST
         --  contain absolute IRIs (see [IETF RFC 3987])."
         --
         --  XXX This check is not implemented.
      end if;
   end Start_Interface_Element;

   -----------------------------------
   -- Start_Interface_Fault_Element --
   -----------------------------------

   procedure Start_Interface_Fault_Element
    (Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Interface_Access;
--     Node       : out WSDL.AST.Faults.Interface_Fault_Access;
     Success    : in out Boolean)
   is
      pragma Unreferenced (Success);

      Name : constant League.Strings.Universal_String
        := Attributes.Value (Name_Attribute);
      Node : WSDL.AST.Interface_Fault_Access;

   begin
      Node := new WSDL.AST.Faults.Interface_Fault_Node;
      Node.Parent := Parent;
      Node.Local_Name := Name;
      Parent.Interface_Faults.Insert (Name, Node);

      --  Analyze 'element' attribute.

      --  Note, there are two assertion is applied to {message content model}
      --  and {element declaration} properties of interface's fault component:
      --
      --  InterfaceFault-1013: "An xs:token with one of the values #any, #none,
      --  #other, or #element."
      --
      --  InterfaceFault-1014: "When the {message content model} property has
      --  the value #any or #none the {element declaration} property MUST be
      --  empty."
      --
      --  Both assertions not need to be tested at runtime, they are enforced
      --  by construction.

      if Attributes.Is_Specified (Element_Attribute) then
         declare
            Value : constant League.Strings.Universal_String
              := Attributes.Value (Element_Attribute);

         begin
            if Value = Any_Literal then
               Node.Message_Content_Model := WSDL.AST.Any;

            elsif Value = None_Literal then
               Node.Message_Content_Model := WSDL.AST.None;

            elsif Value = Other_Literal then
               Node.Message_Content_Model := WSDL.AST.Other;

            else
               Node.Message_Content_Model := WSDL.AST.Element;
               Node.Element := To_Qualified_Name (Namespaces, Value);
            end if;
         end;

      else
         Node.Message_Content_Model := WSDL.AST.Other;
      end if;
   end Start_Interface_Fault_Element;

   ---------------------------------------
   -- Start_Interface_Operation_Element --
   ---------------------------------------

   procedure Start_Interface_Operation_Element
    (Parser     : WSDL_Parser;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Parent     : not null WSDL.AST.Interface_Access;
     Node       : out WSDL.AST.Interface_Operation_Access;
     Success    : in out Boolean)
   is
      pragma Unreferenced (Success);

      Name    : constant League.Strings.Universal_String
        := Attributes.Value (Name_Attribute);
      MEP_IRI : League.Strings.Universal_String;

   begin
      Node := new WSDL.AST.Operations.Interface_Operation_Node;
      Node.Parent := Parent;
      Node.Local_Name := Name;
      Parent.Interface_Operations.Insert (Name, Node);

      --  Analyze 'pattern' attribute.

      if Attributes.Is_Specified (Pattern_Attribute) then
         MEP_IRI := Attributes.Value (Pattern_Attribute);

         --  InterfaceOperation-1018: "This xs:anyURI MUST be an absolute IRI
         --  (see [IETF RFC 3987])."
         --
         --  XXX Not implemented yet.

      else
         MEP_IRI := In_Out_MEP;
      end if;

      Node.Message_Exchange_Pattern := WSDL.Parsers.MEP.Resolve (Parser, MEP_IRI);

      --  Analyze 'style' attribute.

      if Attributes.Is_Specified (Style_Attribute) then
         Node.Style :=
           Attributes.Value (Style_Attribute).Split
            (' ', League.Strings.Skip_Empty);

         for J in 1 .. Node.Style.Length loop
            --  InterfaceOperation-1019: "These xs:anyURIs MUST be absolute
            --  IRIs (see [IETF RFC 3986])."
            --
            --  XXX Not implemented yet.

            null;
         end loop;

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
     Success       : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      Self.Namespaces.Insert (Prefix, Namespace_URI);
   end Start_Prefix_Mapping;

   ---------------------------
   -- Start_Service_Element --
   ---------------------------

   procedure Start_Service_Element
    (Attributes : XML.SAX.Attributes.SAX_Attributes;
     Namespaces : Namespace_Maps.Map;
     Parent     : WSDL.AST.Description_Access;
     Node       : out WSDL.AST.Services.Service_Access;
     Success    : in out Boolean)
   is
      pragma Unreferenced (Success);

      Name : constant League.Strings.Universal_String
        := Attributes.Value (Name_Attribute);

   begin
      --  Service-1060: "For each Service component in the {services} property
      --  of a Description component, the {name} property MUST be unique."

      if Parent.Services.Contains (Name) then
         raise Program_Error;
      end if;

      Node := new WSDL.AST.Services.Service_Node;
      Node.Parent := Parent;
      Node.Local_Name := Name;
      Parent.Services.Insert (Name, Node);

      --  Analyze 'interface' attribute.

      Node.Interface_Name :=
        To_Qualified_Name (Namespaces, Attributes.Value (Interface_Attribute));
   end Start_Service_Element;

   -------------------------
   -- Start_Types_Element --
   -------------------------

   procedure Start_Types_Element
    (Description : WSDL.AST.Description_Access;
     Success     : in out Boolean)
   is
      pragma Unreferenced (Success);

   begin
      Description.Types := new WSDL.AST.Types.Types_Node;
      Description.Types.Parent := Description;
   end Start_Types_Element;

   -----------------------
   -- To_Qualified_Name --
   -----------------------

   function To_Qualified_Name
    (Namespaces : Namespace_Maps.Map;
     Name       : League.Strings.Universal_String)
       return WSDL.AST.Qualified_Name
   is
      Index : constant Natural := Name.Index (':');

   begin
      return
       (Namespace_URI => Namespaces.Element (Name.Slice (1, Index - 1)),
        Local_Name    => Name.Slice (Index + 1, Name.Length));
   end To_Qualified_Name;

end WSDL.Parsers;
