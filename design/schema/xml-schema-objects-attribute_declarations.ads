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
-- Copyright © 2012-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
--  The interface represents the Attribute Declaration schema component.
------------------------------------------------------------------------------
with League.Holders;

with XML.Schema.Annotations;
with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Simple_Type_Definitions;

package XML.Schema.Objects.Attribute_Declarations is

   pragma Preelaborate;

   type XS_Attribute_Declaration is new XS_Object with private;

   Null_XS_Attribute_Declaration : constant XS_Attribute_Declaration;

   function Get_Type_Definition
    (Self : XS_Attribute_Declaration'Class)
       return XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;
   --  [type definition]: A simple type definition.

   function Get_Scope
    (Self : XS_Attribute_Declaration'Class) return XML.Schema.Scope;
   --  [scope]. One of SCOPE_GLOBAL, SCOPE_LOCAL, or SCOPE_ABSENT. If the scope
   --  is local, then the enclosingCTDefinition is present.

   function Get_Enclosing_CT_Definition
    (Self : XS_Attribute_Declaration'Class)
       return XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
   --  The complex type definition for locally scoped declarations (see scope),
   --  otherwise null if no such definition exists.

   function Get_Constraint_Type
    (Self : XS_Attribute_Declaration'Class) return XML.Schema.Value_Constraint;
   --  Value constraint: one of VC_NONE, VC_DEFAULT, VC_FIXED.

   function Get_Constraint_Value
    (Self : XS_Attribute_Declaration'Class)
       return League.Strings.Universal_String;
   --  Value constraint: The constraint value with respect to the [type
   --  definition], otherwise null.

   function Get_Actual_VC
    (Self : XS_Attribute_Declaration'Class) return League.Holders.Holder;
   --  Value Constraint: Binding specific actual constraint value or null if
   --  the value is in error or there is no value constraint.
   --
   --  Exceptions
   --
   --    XSException
   --      NOT_SUPPORTED_ERR: Raised if the implementation does not support
   --      this method.

   function Get_Actual_VC_Type
    (Self : XS_Attribute_Declaration'Class) return XML.Schema.Built_In_Type;
   --  The actual constraint value built-in datatype, e.g. STRING_DT, SHORT_DT.
   --  If the type definition of this value is a list type definition, this
   --  method returns LIST_DT. If the type definition of this value is a list
   --  type definition whose item type is a union type definition, this method
   --  returns LISTOFUNION_DT. To query the actual constraint value of the list
   --  or list of union type definitions use itemValueTypes. If the actualValue
   --  is null, this method returns UNAVAILABLE_DT.
   --
   --  Exceptions
   --
   --    XSException
   --
   --      NOT_SUPPORTED_ERR: Raised if the implementation does not support
   --      this method.

--   function Get_Item_Value_Types
--    (Self : XS_Attribute_Declaration'Class)
--       return XML.Schema.Built_In_Type_List;
   --  In the case the actual constraint value represents a list, i.e. the
   --  actualValueType is LIST_DT, the returned array consists of one type kind
   --  which represents the itemType. If the actual constraint value represents
   --  a list type definition whose item type is a union type definition, i.e.
   --  LISTOFUNION_DT, for each actual constraint value in the list the array
   --  contains the corresponding memberType kind. For examples, see
   --  ItemPSVI.itemValueTypes.
   --
   --  Exceptions
   --
   --    XSException
   --   
   --
   --      NOT_SUPPORTED_ERR: Raised if the implementation does not support
   --      this method.

   function Get_Annotation
    (Self : XS_Attribute_Declaration'Class)
       return XML.Schema.Annotations.XS_Annotation;
   --  An annotation if it exists, otherwise null.

private

   type XS_Attribute_Declaration is new XS_Object with null record;

   Null_XS_Attribute_Declaration : constant XS_Attribute_Declaration
     := (Ada.Finalization.Controlled with Node => null);

end XML.Schema.Objects.Attribute_Declarations;
