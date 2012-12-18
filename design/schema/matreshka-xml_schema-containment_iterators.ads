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
--  This package provides AST iterator based on containment of nodes. Two
--  synthetic nodes - Model_Node and Namespace_Node - are handled in the
--  special way: they are 'contain' all global components of the corresponding
--  model or namespace. Note, they are not contain Schema_Nodes.
------------------------------------------------------------------------------
private with Matreshka.XML_Schema.AST;
with Matreshka.XML_Schema.Visitors;

package Matreshka.XML_Schema.Containment_Iterators is

   pragma Preelaborate;

   type Containment_Iterator is
     limited new Matreshka.XML_Schema.Visitors.Abstract_Iterator with private;

private

   type Containment_Iterator is
     limited new Matreshka.XML_Schema.Visitors.Abstract_Iterator
       with null record;

   overriding procedure Visit_Attribute_Declaration
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Attribute_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Visit_Attribute_Group_Definition
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    :
       not null Matreshka.XML_Schema.AST.Attribute_Group_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Visit_Attribute_Use
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Attribute_Use_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Visit_Complex_Type_Definition
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    :
       not null Matreshka.XML_Schema.AST.Complex_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Visit_Element_Declaration
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Element_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Visit_Model
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Model_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Visit_Model_Group
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Model_Group_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Visit_Model_Group_Definition
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Model_Group_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Visit_Namespace
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Namespace_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Visit_Particle
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Particle_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Visit_Schema
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Schema_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Visit_Simple_Type_Definition
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

end Matreshka.XML_Schema.Containment_Iterators;
