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
--  This package provides name resolver, which resolves references between
--  components. It accepts complete Model_Node constructed by applying
--  namespace builder to each root Schema_Node.
------------------------------------------------------------------------------
private with Matreshka.XML_Schema.AST;
with Matreshka.XML_Schema.Visitors;

package Matreshka.XML_Schema.Name_Resolvers is

--   pragma Preelaborate;

   type Name_Resolver is
     limited new Matreshka.XML_Schema.Visitors.Abstract_Visitor with private;

private

   type Name_Resolver is
     limited new Matreshka.XML_Schema.Visitors.Abstract_Visitor with
   record
      Model : Matreshka.XML_Schema.AST.Model_Access;
   end record;

   not overriding function Resolve_Type
    (Self    : in out Name_Resolver;
     Name    : Matreshka.XML_Schema.AST.Qualified_Name)
     return Matreshka.XML_Schema.AST.Type_Definition_Access;
   --  Resolve given type name

   not overriding function Resolve_Simple_Type
    (Self    : in out Name_Resolver;
     Name    : Matreshka.XML_Schema.AST.Qualified_Name)
     return Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;
   --  The same, but simple type expected

   not overriding function Resolve_Element
    (Self    : in out Name_Resolver;
     Name    : Matreshka.XML_Schema.AST.Qualified_Name)
     return Matreshka.XML_Schema.AST.Element_Declaration_Access;
   --  Resolve given element name

   not overriding function Resolve_Attribute
    (Self    : in out Name_Resolver;
     Name    : Matreshka.XML_Schema.AST.Qualified_Name)
     return Matreshka.XML_Schema.AST.Attribute_Declaration_Access;
   --  Resolve given attribute name

   overriding procedure Enter_Attribute_Declaration
    (Self    : in out Name_Resolver;
     Node    : not null Matreshka.XML_Schema.AST.Attribute_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Enter_Attribute_Use
    (Self    : in out Name_Resolver;
     Node    : not null Matreshka.XML_Schema.AST.Attribute_Use_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Enter_Complex_Type_Definition
    (Self    : in out Name_Resolver;
     Node    :
       not null Matreshka.XML_Schema.AST.Complex_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Enter_Element_Declaration
    (Self    : in out Name_Resolver;
     Node    : not null Matreshka.XML_Schema.AST.Element_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Enter_Model
    (Self    : in out Name_Resolver;
     Node    : not null Matreshka.XML_Schema.AST.Model_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Enter_Particle
    (Self    : in out Name_Resolver;
     Node    : not null Matreshka.XML_Schema.AST.Particle_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

   overriding procedure Enter_Simple_Type_Definition
    (Self    : in out Name_Resolver;
     Node    : not null Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

--   overriding procedure Enter_Schema
--    (Self    : in out Name_Resolver;
--     Node    : not null Matreshka.XML_Schema.AST.Schema_Access;
--     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);

end Matreshka.XML_Schema.Name_Resolvers;
