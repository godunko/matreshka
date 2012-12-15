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
with Matreshka.XML_Schema.AST;

package Matreshka.XML_Schema.Visitors is

   pragma Preelaborate;

   type Traverse_Control is
    (Continue,
     Abandon_Children,
     Abandon_Sibling,
     Terminate_Immediately);

   type Abstract_Visitor is limited interface;
   --  Abstract interface of visitor.

   not overriding procedure Enter_Annotation
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Annotation_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Annotation
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Annotation_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Assertion
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Assertion_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Assertion
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Assertion_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Attribute_Declaration
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Attribute_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Attribute_Declaration
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Attribute_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Attribute_Group_Definition
    (Self    : in out Abstract_Visitor;
     Node    :
       not null Matreshka.XML_Schema.AST.Attribute_Group_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Attribute_Group_Definition
    (Self    : in out Abstract_Visitor;
     Node    :
       not null Matreshka.XML_Schema.AST.Attribute_Group_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Attribute_Group_Reference
    (Self    : in out Abstract_Visitor;
     Node    :
       not null Matreshka.XML_Schema.AST.Attribute_Group_Reference_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Attribute_Group_Reference
    (Self    : in out Abstract_Visitor;
     Node    :
       not null Matreshka.XML_Schema.AST.Attribute_Group_Reference_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Attribute_Use
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Attribute_Use_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Attribute_Use
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Attribute_Use_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Complex_Type_Definition
    (Self    : in out Abstract_Visitor;
     Node    :
       not null Matreshka.XML_Schema.AST.Complex_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Complex_Type_Definition
    (Self    : in out Abstract_Visitor;
     Node    :
       not null Matreshka.XML_Schema.AST.Complex_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Element_Declaration
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Element_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Element_Declaration
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Element_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Enumeration
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Enumeration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Enumeration
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Enumeration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Identity_Constraint_Definition
    (Self    : in out Abstract_Visitor;
     Node    :
       not null Matreshka.XML_Schema.AST.Identity_Constraint_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Identity_Constraint_Definition
    (Self    : in out Abstract_Visitor;
     Node    :
       not null Matreshka.XML_Schema.AST.Identity_Constraint_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Min_Length
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Min_Length_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Min_Length
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Min_Length_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Model
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Model_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Model
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Model_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Model_Group
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Model_Group_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Model_Group
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Model_Group_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Model_Group_Definition
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Model_Group_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Model_Group_Definition
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Model_Group_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Namespace
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Namespace_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Namespace
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Namespace_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Notation_Declaration
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Notation_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Notation_Declaration
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Notation_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Particle
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Particle_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Particle
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Particle_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Schema
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Schema_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Schema
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Schema_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Simple_Type_Definition
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Simple_Type_Definition
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Type_Alternative
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Type_Alternative_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Type_Alternative
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Type_Alternative_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Wildcard
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Wildcard_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Wildcard
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Wildcard_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   type Abstract_Iterator is limited interface;
   --  Abstract interface of iterator.

   procedure Visit
    (Self    : in out Abstract_Iterator'Class;
     Visitor : in out Abstract_Visitor'Class;
     Element : not null Matreshka.XML_Schema.AST.Node_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Visit specified element by calling:
   --
   --   - Enter_<Class> operation on visitor;
   --
   --   - Visit_<Class> operation on iterator;
   --
   --   - Leave_<Class> operation on visitor.
   --
   --  Internal double dispatching mechanism is used by implementation.

   not overriding procedure Visit_Annotation
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Annotation_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Assertion
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Assertion_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Attribute_Declaration
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Attribute_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Attribute_Group_Definition
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    :
       not null Matreshka.XML_Schema.AST.Attribute_Group_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Attribute_Group_Reference
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    :
       not null Matreshka.XML_Schema.AST.Attribute_Group_Reference_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Attribute_Use
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Attribute_Use_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Complex_Type_Definition
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    :
       not null Matreshka.XML_Schema.AST.Complex_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Element_Declaration
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Element_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Enumeration
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Enumeration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Identity_Constraint_Definition
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    :
       not null Matreshka.XML_Schema.AST.Identity_Constraint_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Min_Length
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Min_Length_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Model
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Model_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Model_Group
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Model_Group_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Model_Group_Definition
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Model_Group_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Namespace
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Namespace_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Notation_Declaration
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Notation_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Particle
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Particle_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Schema
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Schema_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Simple_Type_Definition
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Type_Alternative
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Type_Alternative_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Wildcard
    (Self    : Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Wildcard_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

end Matreshka.XML_Schema.Visitors;
