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
with Ada.Containers.Ordered_Maps;
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with League.Strings;

with WSDL.AST.Bindings;
with WSDL.AST.Interfaces;
with WSDL.AST.Messages;
with WSDL.AST.Operations;
with WSDL.AST.Services;
with WSDL.Constants;

package body WSDL.Generator is

   use WSDL.Constants;

   package Operation_Maps is
     new Ada.Containers.Ordered_Maps
          (League.Strings.Universal_String,
           WSDL.AST.Operations.Interface_Operation_Access,
           League.Strings."<",
           WSDL.AST.Operations."=");

   procedure Put (Item : League.Strings.Universal_String);

   procedure Put_Line (Item : League.Strings.Universal_String);

   procedure Put_Line (Item : WSDL.AST.Qualified_Name);
   --  Format and output qualified name.

   procedure Generate_Service
    (Service_Node : not null WSDL.AST.Services.Service_Access);

   procedure Lookup_Binding
    (Interface_Node : not null WSDL.AST.Interfaces.Interface_Access;
     Binding_Node   : out WSDL.AST.Bindings.Binding_Access);

   function Compute_All_Operations
    (Interface_Node : not null WSDL.AST.Interfaces.Interface_Access)
       return Operation_Maps.Map;

   ----------------------------
   -- Compute_All_Operations --
   ----------------------------

   function Compute_All_Operations
    (Interface_Node : not null WSDL.AST.Interfaces.Interface_Access)
       return Operation_Maps.Map
   is
      Result : Operation_Maps.Map;

      procedure Analyze_Interface
       (Interface_Node : not null WSDL.AST.Interfaces.Interface_Access);

      -----------------------
      -- Analyze_Interface --
      -----------------------

      procedure Analyze_Interface
       (Interface_Node : not null WSDL.AST.Interfaces.Interface_Access) is
      begin
         --  Fill result by own operations of the interface, but excluding
         --  all operations which names is in the result already because they
         --  come from extended interface.

         for Operation_Node of Interface_Node.Interface_Operations loop
            if not Result.Contains (Operation_Node.Local_Name) then
               Result.Insert (Operation_Node.Local_Name, Operation_Node);
            end if;
         end loop;

         for Extended_Interface_Node of Interface_Node.Extended_Interfaces loop
            Analyze_Interface (Extended_Interface_Node);
         end loop;
      end Analyze_Interface;

   begin
      Analyze_Interface (Interface_Node);

      return Result;
   end Compute_All_Operations;

   --------------
   -- Generate --
   --------------

   procedure Generate
    (Description : not null WSDL.AST.Descriptions.Description_Access) is
   begin
      for Service_Node of Description.Services loop
         Generate_Service (Service_Node);
      end loop;
   end Generate;

   ----------------------
   -- Generate_Service --
   ----------------------

   procedure Generate_Service
    (Service_Node : not null WSDL.AST.Services.Service_Access)
   is
      use type League.Strings.Universal_String;
      use type WSDL.AST.Bindings.Binding_Access;
      use type WSDL.AST.Messages.Message_Directions;
      use type WSDL.AST.Messages.Message_Content_Models;

      Binding_Node : WSDL.AST.Bindings.Binding_Access;
      Operations   : Operation_Maps.Map;

   begin
      --  Lookup for corresponding binding component.

      Lookup_Binding (Service_Node.Interface_Node, Binding_Node);

      if Binding_Node = null then
         --  There is no binding for interface element specified.

         raise Program_Error;
      end if;

      if Binding_Node.Binding_Type /= SOAP_Binding_Type then
         --  This binding type is not supported.

         raise Program_Error;
      end if;

      if Binding_Node.SOAP.Version /= SOAP_Version_12_Literal then
         --  This version of SOAP is not supported.

         raise Program_Error;
      end if;

      --  Compute set of all interface's operations, including inherited.

      Operations := Compute_All_Operations (Service_Node.Interface_Node);

      --  Generate package for Ada interface type specification.

      Put_Line ("package " & Service_Node.Interface_Node.Local_Name & " is");
      New_Line;
      Put_Line
       ("   type "
          & Service_Node.Interface_Node.Local_Name
          & " is limited interface;");

      for Operation_Node of Operations loop
         if Operation_Node.Message_Exchange_Pattern /= In_Out_MEP
           and Operation_Node.Message_Exchange_Pattern /= Robust_In_Only_MEP
         then
            --  Only in-out and robust-in-only MEPs are supported.

            raise Program_Error;
         end if;

         New_Line;
         Put_Line ("   not overriding procedure " & Operation_Node.Local_Name);
         Put
          ("    (Self   : in out "
             & Service_Node.Interface_Node.Local_Name);

         --  Generate input parameter, if any.

         for Message_Node of Operation_Node.Interface_Message_References loop
            if Message_Node.Direction = WSDL.AST.Messages.In_Message then
               if Message_Node.Message_Content_Model
                 not in WSDL.AST.Messages.None | WSDL.AST.Messages.Element
               then
                  --  Only '#none' and '#element' message content models are
                  --  supported.

                  raise Program_Error;
               end if;

               if Message_Node.Message_Content_Model
                    = WSDL.AST.Messages.Element
               then
                  Put_Line (";");
                  Put
                   ("     Input  : "
                      & Message_Node.Element
                      & "'Class");
               end if;

               exit;
            end if;
         end loop;

         --  Generate output parameter, if any.

         if Operation_Node.Message_Exchange_Pattern = In_Out_MEP then
            for Message_Node
                  of Operation_Node.Interface_Message_References
            loop
               if Message_Node.Direction = WSDL.AST.Messages.Out_Message then
                  Put_Line (";");
                  Put
                   ("     Output : out "
                      & Message_Node.Element
                      & "_Access");

                  exit;
               end if;
            end loop;
         end if;

         --  Generate output fault parameter, if eny.

--         Put_Line (";");
--         Put ("     Fault  : out SOAP_Fault_Access");

         Put_Line (");");
      end loop;

      New_Line;
      Put_Line ("end " & Service_Node.Interface_Node.Local_Name & ";");
   end Generate_Service;

   --------------------
   -- Lookup_Binding --
   --------------------

   procedure Lookup_Binding
    (Interface_Node : not null WSDL.AST.Interfaces.Interface_Access;
     Binding_Node   : out WSDL.AST.Bindings.Binding_Access)
   is
      use type WSDL.AST.Interfaces.Interface_Access;

   begin
      Binding_Node := null;

      for Binding of Interface_Node.Parent.Bindings loop
         --  Use default binding when found. Default value will be overwritten
         --  when interface specific binding will be found.

         if Binding.Interface_Node = null then
            Binding_Node := Binding;
         end if;

         --  Use interface specific binding when found.

         if Binding.Interface_Node = Interface_Node then
            Binding_Node := Binding;

            exit;
         end if;
      end loop;
   end Lookup_Binding;

   ---------
   -- Put --
   ---------

   procedure Put (Item : League.Strings.Universal_String) is
   begin
      Put (Item.To_Wide_Wide_String);
   end Put;

   --------------
   -- Put_Line --
   --------------

   procedure Put_Line (Item : League.Strings.Universal_String) is
   begin
      Put_Line (Item.To_Wide_Wide_String);
   end Put_Line;

   --------------
   -- Put_Line --
   --------------

   procedure Put_Line (Item : WSDL.AST.Qualified_Name) is
   begin
      Put ('{');
      Put (Item.Namespace_URI.To_Wide_Wide_String);
      Put ('}');
      Put (Item.Local_Name.To_Wide_Wide_String);
      New_Line;
   end Put_Line;

end WSDL.Generator;
