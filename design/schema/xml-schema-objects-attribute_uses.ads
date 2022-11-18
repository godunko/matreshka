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
with League.Holders;

with XML.Schema.Objects.Attribute_Declarations;

package XML.Schema.Objects.Attribute_Uses is

   pragma Preelaborate;

   type XS_Attribute_Use is new XS_Object with private;

   Null_XS_Attribute_Use : constant XS_Attribute_Use;

   function Get_Required (Self : XS_Attribute_Use'Class) return Boolean;
   --  [required]: determines whether this use of an attribute declaration
   --  requires an appropriate attribute information item to be present, or
   --  merely allows it.

   function Get_Attr_Declaration
    (Self : XS_Attribute_Use'Class)
       return
         XML.Schema.Objects.Attribute_Declarations.XS_Attribute_Declaration;
   --  [attribute declaration]: provides the attribute declaration itself,
   --  which will in turn determine the simple type definition used.

   function Get_Constraint_Type
    (Self : XS_Attribute_Use'Class) return XML.Schema.Value_Constraint;
   --  Value Constraint: one of default, fixed.

   function Get_Constraint_Value
    (Self : XS_Attribute_Use'Class) return League.Strings.Universal_String;
   --  Value Constraint: The constraint value, otherwise null.

   function Get_Actual_VC
    (Self : XS_Attribute_Use'Class) return League.Holders.Holder;
   --  Value Constraint: Binding specific actual constraint value or null if
   --  the value is in error or there is no value constraint.
   --
   --  Exceptions on retrieval
   --
   --    XSException
   --
   --      NOT_SUPPORTED_ERR: Raised if the implementation does not support
   --      this method.

   function Get_Actual_VC_Type
    (Self : XS_Attribute_Use'Class) return XML.Schema.Built_In_Type;
   --  The actual constraint value built-in datatype, e.g. STRING_DT, SHORT_DT.
   --  If the type definition of this value is a list type definition, this
   --  method returns LIST_DT. If the type definition of this value is a list
   --  type definition whose item type is a union type definition, this method
   --  returns LISTOFUNION_DT. To query the actual constraint value of the list
   --  or list of union type definitions use itemValueTypes. If the
   --  actualNormalizedValue is null, this method returns UNAVAILABLE_DT.
   --
   --  Exceptions on retrieval
   --
   --    XSException
   --
   --      NOT_SUPPORTED_ERR: Raised if the implementation does not support
   --      this method.

--   function Get_Item_Value_Types
--    (Self : XS_Attribute_Use'Class) return XML.Schema.Built_In_Type_List;
   --  In the case the actual constraint value represents a list, i.e. the
   --  actualValueType is LIST_DT, the returned array consists of one type kind
   --  which represents the itemType. If the actual constraint value represents
   --  a list type definition whose item type is a union type definition, i.e.
   --  LISTOFUNION_DT, for each actual constraint value in the list the array
   --  contains the corresponding memberType kind. For examples, see
   --  ItemPSVI.itemValueTypes.
   --
   --  Exceptions on retrieval
   --
   --    XSException
   --
   --      NOT_SUPPORTED_ERR: Raised if the implementation does not support
   --      this method.

private

   type XS_Attribute_Use is new XS_Object with null record;

   Null_XS_Attribute_Use : constant XS_Attribute_Use
     := (Ada.Finalization.Controlled with Node => null);

end XML.Schema.Objects.Attribute_Uses;
