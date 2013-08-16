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
with Matreshka.XML_Schema.Visitors;

package body Matreshka.XML_Schema.AST.Wildcards is

   ----------------
   -- Enter_Node --
   ----------------

   overriding procedure Enter_Node
    (Self    : not null access Wildcard_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      Visitor.Enter_Wildcard
       (Matreshka.XML_Schema.AST.Wildcard_Access (Self), Control);
   end Enter_Node;

   --------------
   -- Get_Name --
   --------------

   overriding function Get_Name
    (Self : not null access Wildcard_Node)
      return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Get_Name;

   --------------------------
   -- Get_Target_Namespace --
   --------------------------

   overriding function Get_Target_Namespace
    (Self : not null access Wildcard_Node)
      return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Get_Target_Namespace;


   --------------
   -- Get_Type --
   --------------

   overriding function Get_Type
    (Self : not null access Wildcard_Node) return XML.Schema.Component_Type
   is
      pragma Unreferenced (Self);

   begin
      return XML.Schema.Wildcard;
   end Get_Type;

   ----------------
   -- Leave_Node --
   ----------------

   overriding procedure Leave_Node
    (Self    : not null access Wildcard_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      Visitor.Leave_Wildcard
       (Matreshka.XML_Schema.AST.Wildcard_Access (Self), Control);
   end Leave_Node;

   ----------------
   -- Visit_Node --
   ----------------

   overriding procedure Visit_Node
    (Self     : not null access Wildcard_Node;
     Iterator : in out Matreshka.XML_Schema.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control  : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      Iterator.Visit_Wildcard
       (Visitor, Matreshka.XML_Schema.AST.Wildcard_Access (Self), Control);
   end Visit_Node;

end Matreshka.XML_Schema.AST.Wildcards;
