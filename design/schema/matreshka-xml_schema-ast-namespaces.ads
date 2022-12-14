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
--  Namespace_Node is synthetic node which represents all XML Schema components
--  from one namespace.
------------------------------------------------------------------------------
with League.Strings;

with Matreshka.XML_Schema.AST.Types;

package Matreshka.XML_Schema.AST.Namespaces is

   pragma Preelaborate;

   type Namespace_Node is new Abstract_Node with record
      Namespace_URI        : League.Strings.Universal_String;

      Type_Definitions     :
        Matreshka.XML_Schema.AST.Types.Type_Definition_Maps.Map;
      --  A set of Type Definition components.

      Element_Declarations :
        Matreshka.XML_Schema.AST.Types.Element_Declaration_Maps.Map;
      --  A set of Element Declaration components.

      Attribute_Declarations :
        Matreshka.XML_Schema.AST.Types.Attribute_Declaration_Maps.Map;
      --  A set of Attribute Declaration components.

      Attribute_Group_Definitions :
        Matreshka.XML_Schema.AST.Types.Attribute_Group_Maps.Map;
      --  A set of Attribute Group Definition components.

      Model_Group_Definitions :
        Matreshka.XML_Schema.AST.Types.Model_Group_Definition_Maps.Map;
      --  A set of Model Group Definition components.
   end record;

   function Get_Element_Declaration
    (Self : not null access constant Namespace_Node'Class;
     Name : League.Strings.Universal_String)
       return Matreshka.XML_Schema.AST.Element_Declaration_Access;
   --  Returns element declaration node or null if no such element declaration.

   function Get_Attribute_Declaration
    (Self : not null access constant Namespace_Node'Class;
     Name : League.Strings.Universal_String)
       return Matreshka.XML_Schema.AST.Attribute_Declaration_Access;
   --  Returns attribute declaration node or null if no such declaration exist.

   function Get_Attribute_Group_Definition
    (Self : not null access constant Namespace_Node'Class;
     Name : League.Strings.Universal_String)
       return Matreshka.XML_Schema.AST.Attribute_Group_Definition_Access;
   --  Returns attribute group definition node if any.

   function Get_Model_Group_Definition
    (Self : not null access constant Namespace_Node'Class;
     Name : League.Strings.Universal_String)
       return Matreshka.XML_Schema.AST.Model_Group_Definition_Access;
   --  Returns attribute group definition node if any.

   function Get_Type_Definition
    (Self : not null access constant Namespace_Node'Class;
     Name : League.Strings.Universal_String)
       return Matreshka.XML_Schema.AST.Type_Definition_Access;
   --  Returns type definition node or null if no such type definition.

   overriding procedure Enter_Node
    (Self    : not null access Namespace_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Leave_Node
    (Self    : not null access Namespace_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Visit_Node
    (Self     : not null access Namespace_Node;
     Iterator : in out Matreshka.XML_Schema.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control  : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

end Matreshka.XML_Schema.AST.Namespaces;
