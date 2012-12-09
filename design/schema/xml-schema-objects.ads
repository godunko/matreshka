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
--  The XSObject is a base object for the XML Schema component model.
------------------------------------------------------------------------------
private with Ada.Finalization;

with League.Strings;

private with Matreshka.XML_Schema.AST.Objects;
limited with XML.Schema.Namespace_Items;
limited with XML.Schema.Objects.Terms.Element_Declarations;

package XML.Schema.Objects is

   pragma Preelaborate;

   type XS_Object is tagged private;

   function Get_Type (Self : XS_Object'Class) return XML.Schema.Component_Type;
   --  The type of this object, i.e. ELEMENT_DECLARATION.

   function Get_Name
    (Self : XS_Object'Class) return League.Strings.Universal_String;
   --  The name of type NCName, as defined in XML Namespaces, of this
   --  declaration specified in the {name} property of the component or null if
   --  the definition of this component does not have a {name} property. For
   --  anonymous types, the processor must construct and expose an anonymous
   --  type name that is distinct from the name of every named type and the
   --  name of every other anonymous type.

   function Get_Namespace
    (Self : XS_Object'Class) return League.Strings.Universal_String;
   --  The [target namespace] of this object, or null if it is unspecified.

   function Get_Namespace_Item
    (Self : XS_Object'Class)
       return XML.Schema.Namespace_Items.XS_Namespace_Item;
   --  A namespace schema information item corresponding to the target
   --  namespace of the component, if it is globally declared; or null
   --  otherwise.

   --  Object type classification subprograms.

   function Is_Attribute_Declaration (Self : XS_Object'Class) return Boolean;
   function Is_Element_Declaration (Self : XS_Object'Class) return Boolean;
   function Is_Type_Definition (Self : XS_Object'Class) return Boolean;
   function Is_Attribute_Use (Self : XS_Object'Class) return Boolean;
   function Is_Attribute_Group (Self : XS_Object'Class) return Boolean;
   function Is_Model_Group_Definition (Self : XS_Object'Class) return Boolean;
   function Is_Model_Group (Self : XS_Object'Class) return Boolean;
   function Is_Particle (Self : XS_Object'Class) return Boolean;
   function Is_Wildcard (Self : XS_Object'Class) return Boolean;
   function Is_Identity_Constraint (Self : XS_Object'Class) return Boolean;
   function Is_Notation_Declaration (Self : XS_Object'Class) return Boolean;
   function Is_Annotation (Self : XS_Object'Class) return Boolean;
   function Is_Facet (Self : XS_Object'Class) return Boolean;
   function Is_Multivalue_Facet (Self : XS_Object'Class) return Boolean;

   --  Object type conversion subprograms.

   function To_Element_Declaration
    (Self : XS_Object'Class)
       return
         XML.Schema.Objects.Terms.Element_Declarations.XS_Element_Declaration;

   function "=" (Left : XS_Object; Right : XS_Object) return Boolean;
   function "=" (Left : XS_Object; Right : XS_Object'Class) return Boolean;

private

   type XS_Object is new Ada.Finalization.Controlled with record
      Node : Matreshka.XML_Schema.AST.Objects.Object_Access;
   end record;

end XML.Schema.Objects;