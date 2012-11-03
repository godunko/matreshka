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

with League.Strings;

with WSDL.AST.Bindings;
with WSDL.AST.Interfaces;
with WSDL.AST.Services;
with WSDL.Constants;

package body WSDL.Generator is

   use WSDL.Constants;

   procedure Put_Line (Item : WSDL.AST.Qualified_Name);
   --  Format and output qualified name.

   procedure Generate_Service
    (Service_Node : not null WSDL.AST.Services.Service_Access);

   procedure Lookup_Binding
    (Interface_Node : not null WSDL.AST.Interfaces.Interface_Access;
     Binding_Node   : out WSDL.AST.Bindings.Binding_Access);

   --------------
   -- Generate --
   --------------

   procedure Generate
    (Description : not null WSDL.AST.Descriptions.Description_Access) is
   begin
      for Service_Node of Description.Services loop
         Put_Line (Service_Node.Name);
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

      Binding_Node : WSDL.AST.Bindings.Binding_Access;

   begin
      Put_Line (Service_Node.Interface_Node.Name);

      Lookup_Binding (Service_Node.Interface_Node, Binding_Node);

      if Binding_Node = null then
         --  There is no binding for interface element specified.

         raise Program_Error;
      end if;

      Put_Line (Binding_Node.Name);

      if Binding_Node.Binding_Type /= SOAP_Binding_Type then
         --  This binding type is not supported.

         raise Program_Error;
      end if;

      if Binding_Node.SOAP.Version /= SOAP_Version_12_Literal then
         --  This version of SOAP is not supported.

         raise Program_Error;
      end if;
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
