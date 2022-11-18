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
--  This interface represents a complex or simple type definition.
------------------------------------------------------------------------------

package XML.Schema.Objects.Type_Definitions is

   pragma Preelaborate;

   type XS_Type_Definition is new XS_Object with private;

   Null_XS_Type_Definition : constant XS_Type_Definition;

   function Get_Type_Category
    (Self : XS_Type_Definition'Class) return XML.Schema.Type_Category;
   --  Return whether this type definition is a simple type or complex type.

   function Get_Base_Type
    (Self : XS_Type_Definition'Class) return XS_Type_Definition;
   --  {base type definition}: either a simple type definition or a complex
   --  type definition.

   function Is_Final
    (Self        : XS_Type_Definition'Class;
     Restriction : XML.Schema.Type_Derivation_Control) return Boolean;
   --  {final}. For a complex type definition it is a subset of {extension,
   --  restriction}. For a simple type definition it is a subset of {extension,
   --  list, restriction, union}.
   --
   --  Parameters
   --
   --    restriction of type unsigned short
   --
   --      Extension, restriction, list, union constants (defined in
   --      XSConstants).
   --
   --  Return Value
   --
   --    True if restriction is in the final set, otherwise false.

   function Get_Final
    (Self : XS_Type_Definition'Class) return XML.Schema.Derivation_Set;
   --  For complex types the returned value is a bit combination of the subset
   --  of {DERIVATION_EXTENSION, DERIVATION_RESTRICTION} corresponding to final
   --  set of this type or DERIVATION_NONE. For simple types the returned value
   --  is a bit combination of the subset of { DERIVATION_RESTRICTION,
   --  DERIVATION_EXTENSION, DERIVATION_UNION, DERIVATION_LIST} corresponding
   --  to final set of this type or DERIVATION_NONE. 

   function Get_Anonymous (Self : XS_Type_Definition'Class) return Boolean;
   --  Convenience attribute. A boolean that specifies if the type definition
   --  is anonymous.

   function Derived_From_Type
    (Self              : XS_Type_Definition'Class;
     Ancestor_Type     : XS_Type_Definition'Class;
     Derivation_Method : XML.Schema.Derivation_Set) return Boolean;
   --  Convenience method which checks if this type is derived from the given
   --  ancestorType.
   --
   --  Parameters
   --
   --    ancestorType of type XSTypeDefinition
   --      An ancestor type definition.
   --
   --    derivationMethod of type unsigned short
   --      A bit combination representing a subset of {DERIVATION_RESTRICTION,
   --      DERIVATION_EXTENSION, DERIVATION_UNION, DERIVATION_LIST}.
   --
   --  Return Value
   --
   --    True if this type is derived from ancestorType using only derivation
   --    methods from the derivationMethod. 

   function Derived_From
    (Self              : XS_Type_Definition'Class;
     Namespace         : League.Strings.Universal_String;
     Name              : League.Strings.Universal_String;
     Derivation_Method : XML.Schema.Derivation_Set) return Boolean;
   --  Convenience method which checks if this type is derived from the given
   --  ancestor type.
   --
   --  Parameters
   --
   --    namespace of type GenericString
   --      An ancestor type namespace.
   --
   --    name of type GenericString
   --      An ancestor type name.
   --
   --    derivationMethod of type unsigned short
   --      A bit combination representing a subset of {DERIVATION_RESTRICTION,
   --      DERIVATION_EXTENSION, DERIVATION_UNION, DERIVATION_LIST}.
   --
   --  Return Value
   --
   --    True if this type is derived from ancestorType using only derivation
   --    methods from the derivationMethod. 

private

   type XS_Type_Definition is new XS_Object with null record;

   Null_XS_Type_Definition : constant XS_Type_Definition
     := (Ada.Finalization.Controlled with Node => null);

end XML.Schema.Objects.Type_Definitions;
