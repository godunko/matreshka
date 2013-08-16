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

with Matreshka.XML_Schema.AST.Types;
with Matreshka.XML_Schema.AST.Objects;

with XML.Schema;

package Matreshka.XML_Schema.AST.Particles is

   pragma Preelaborate;

   type Particle_Node is
     new Matreshka.XML_Schema.AST.Objects.Abstract_Object_Node with record
      --  Properties:
      --

      Min_Occurs : Natural;
      --  {min occurs}
      --  An xs:nonNegativeInteger value. Required.

      Max_Occurs : Natural;
      --  {max occurs}
      --  Either a positive integer or unbounded. Required.

      Term : Types.Term_Access;
      --  {term}
      --  A Term component. Required.

      Annotations : Types.Annotation_Lists.List;
      --  {annotations}
      --  A sequence of Annotation components.

      --  Internal data.

      Element_Ref : Matreshka.XML_Schema.AST.Qualified_Name;
      --  element/@ref
      Group_Ref : Matreshka.XML_Schema.AST.Qualified_Name;
      --  group/@ref
   end record;

   overriding function Get_Type
    (Self : not null access Particle_Node)
      return XML.Schema.Component_Type;

   overriding function Get_Name
    (Self : not null access Particle_Node)
      return League.Strings.Universal_String;

   overriding function Get_Target_Namespace
    (Self : not null access Particle_Node)
      return League.Strings.Universal_String;

   overriding procedure Enter_Node
    (Self    : not null access Particle_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Leave_Node
    (Self    : not null access Particle_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Visit_Node
    (Self     : not null access Particle_Node;
     Iterator : in out Matreshka.XML_Schema.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control  : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

end Matreshka.XML_Schema.AST.Particles;
