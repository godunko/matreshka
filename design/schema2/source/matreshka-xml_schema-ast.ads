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
with League.Strings;

limited with Matreshka.XML_Schema.AST.Models;
limited with Matreshka.XML_Schema.AST.Namespaces;
limited with Matreshka.XML_Schema.AST.Schemas;
limited with Matreshka.XML_Schema.AST.Simple;
limited with Matreshka.XML_Schema.Visitors;

package Matreshka.XML_Schema.AST is

   pragma Preelaborate;

   type Model_Access is
     access all Matreshka.XML_Schema.AST.Models.Model_Node'Class;
   type Namespace_Access is
     access all Matreshka.XML_Schema.AST.Namespaces.Namespace_Node'Class;
   type Schema_Access is
     access all Matreshka.XML_Schema.AST.Schemas.Schema_Node'Class;
   type Simple_Type_Access is
     access all Matreshka.XML_Schema.AST.Simple.Simple_Type_Node'Class;

   type Final_Kinds is (Extension, Restriction, List, Union);

   type Final_Flags is array (Final_Kinds) of Boolean;

   -------------------
   -- Abstract_Node --
   -------------------

   type Abstract_Node is abstract tagged record
      System_Id : League.Strings.Universal_String;
      Line      : Natural := 0;
      Column    : Natural := 0;
   end record;

   not overriding procedure Enter_Node
    (Self    : not null access Abstract_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
       is abstract;
   --  Dispatch call to corresponding subprogram of visitor interface.

   not overriding procedure Leave_Node
    (Self    : not null access Abstract_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
       is abstract;
   --  Dispatch call to corresponding subprogram of visitor interface.

   not overriding procedure Visit_Node
    (Self     : not null access Abstract_Node;
     Iterator : in out Matreshka.XML_Schema.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control  : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
       is abstract;
   --  Dispatch call to corresponding subprogram of iterator interface.

end Matreshka.XML_Schema.AST;
