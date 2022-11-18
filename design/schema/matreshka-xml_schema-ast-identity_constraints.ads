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

package Matreshka.XML_Schema.AST.Identity_Constraints is

   pragma Preelaborate;

   type Category is (Key, Keyref, Unique);

   type Identity_Constraint_Definition_Node is new Abstract_Node with record
      --  Properties:
      --

      Annotations : Types.Annotation_Lists.List;
      --  {annotations}
      --  A sequence of Annotation components.

      Name  : League.Strings.Universal_String;
      --  {name}
      --  An xs:NCName value. Required.

      Target_Namespace  : League.Strings.Universal_String;
      --  {target namespace}
      --  An xs:anyURI value. Optional.

      Identity_Constraint_Category : Category;
      --  {identity-constraint category}
      --  One of {key, keyref, unique}. Required.

      Selector : Types.XPath_Expression;
      --  {selector}
      --  An XPath Expression property record. Required.

      Fields : Types.XPath_Expression_Lists.List;
      --  {fields}
      --  A sequence of XPath Expression property records.

      Referenced_Key :
        Matreshka.XML_Schema.AST.Identity_Constraint_Definition_Access;
      --  {referenced key}
      --  An Identity-Constraint Definition component. Required
      --  if {identity-constraint category} is keyref,
      --  otherwise ({identity-constraint category} is key or unique) must be
      --  ·absent·.
      --  If a value is present, its {identity-constraint category} must be
      --  key or unique.
   end record;

   overriding procedure Enter_Node
    (Self    : not null access Identity_Constraint_Definition_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Leave_Node
    (Self    : not null access Identity_Constraint_Definition_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Visit_Node
    (Self     : not null access Identity_Constraint_Definition_Node;
     Iterator : in out Matreshka.XML_Schema.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control  : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

end Matreshka.XML_Schema.AST.Identity_Constraints;
