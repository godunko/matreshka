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
with League.Strings;
with League.String_Vectors;

with Matreshka.XML_Schema.AST.Types;
with XML.Schema;

package Matreshka.XML_Schema.AST.Wildcards is

   pragma Preelaborate;

   type Process_Content_Kind is (Skip, Strict, Lax);

   type Namespace_Constraint_Variety is (Any, Enumeration, A_Not);

   type Namespaces is record
      URIs       : League.String_Vectors.Universal_String_Vector;
      Has_Absent : Boolean;
   end record;

   type Disallowed_Names is record
      Names       : League.String_Vectors.Universal_String_Vector;
      Has_Defined : Boolean;
      Has_Sibling : Boolean;
   end record;

   type Namespace_Constraint is record
      Variety : Namespace_Constraint_Variety;
      --  {variety}
      --  One of {any, enumeration, not}. Required.

      Namespaces : Wildcards.Namespaces;
      --  {namespaces}
      --  A set each of whose members is either an xs:anyURI value or
      --  the distinguished value ·absent·. Required.

      Disallowed_Names : Wildcards.Disallowed_Names;
      --  {disallowed names}
      --  A set each of whose members is either an xs:QName value or
      --  the keyword defined or the keyword sibling. Required.
   end record;

   type Wildcard_Node is new AST.Types.Term_Node with record
      --  Properties:
      --

      Annotations : Types.Annotation_Lists.List;
      --  {annotations}
      --  A sequence of Annotation components.

      Namespace_Constraint : Wildcards.Namespace_Constraint;
      --  {namespace constraint}
      --  A Namespace Constraint property record. Required.

      Process_Contents : Process_Content_Kind;
      --  {process contents}
      --  One of {skip, strict, lax}. Required.
   end record;

   overriding function Get_Type
    (Self : not null access Wildcard_Node) return XML.Schema.Component_Type;

   overriding procedure Enter_Node
    (Self    : not null access Wildcard_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Leave_Node
    (Self    : not null access Wildcard_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Visit_Node
    (Self     : not null access Wildcard_Node;
     Iterator : in out Matreshka.XML_Schema.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control  : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

end Matreshka.XML_Schema.AST.Wildcards;
