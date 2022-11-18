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
with Matreshka.XML_Schema.AST.Element_Declarations;
with Matreshka.XML_Schema.AST.Types;
with Matreshka.XML_Schema.AST.Complex_Types;

with XML.Schema.Complex_Type_Definitions.Internals;
with XML.Schema.Type_Definitions.Internals;

package body XML.Schema.Objects.Terms.Element_Declarations is

   function "+"
    (Self : Matreshka.XML_Schema.AST.Object_Access)
      return Matreshka.XML_Schema.AST.Element_Declaration_Access;

   ---------
   -- "+" --
   ---------

   function "+"
    (Self : Matreshka.XML_Schema.AST.Object_Access)
      return Matreshka.XML_Schema.AST.Element_Declaration_Access is
   begin
      return Matreshka.XML_Schema.AST.Element_Declaration_Access (Self);
   end "+";

   ------------------
   -- Get_Abstract --
   ------------------

   function Get_Abstract
    (Self : XS_Element_Declaration'Class) return Boolean
   is
      use type Matreshka.XML_Schema.AST.Element_Declaration_Access;

      Node : constant Matreshka.XML_Schema.AST.Element_Declaration_Access
        := +Self.Node;
   begin
      if Node = null then
         return False;
      else
         return Node.Is_Abstract;
      end if;
   end Get_Abstract;

   -------------------
   -- Get_Actual_VC --
   -------------------

   function Get_Actual_VC
    (Self : XS_Element_Declaration'Class) return League.Holders.Holder is
   begin
      raise Program_Error;
      return League.Holders.Empty_Holder;
   end Get_Actual_VC;

   ------------------------
   -- Get_Actual_VC_Type --
   ------------------------

   function Get_Actual_VC_Type
    (Self : XS_Element_Declaration'Class) return XML.Schema.Built_In_Type is
   begin
      raise Program_Error;
      return X : XML.Schema.Built_In_Type;
   end Get_Actual_VC_Type;

   --------------------
   -- Get_Annotation --
   --------------------

   function Get_Annotation
    (Self : XS_Element_Declaration'Class)
       return XML.Schema.Annotations.XS_Annotation is
   begin
      raise Program_Error;
      return X : XML.Schema.Annotations.XS_Annotation;
   end Get_Annotation;

   -------------------------
   -- Get_Constraint_Type --
   -------------------------

   function Get_Constraint_Type
    (Self : XS_Element_Declaration'Class) return XML.Schema.Value_Constraint
   is
      package T renames Matreshka.XML_Schema.AST.Types;

      use type Matreshka.XML_Schema.AST.Element_Declaration_Access;

      Convert : constant array (T.Value_Constraint_Variety) of
        XML.Schema.Value_Constraint
          := (T.Absent  => XML.Schema.VC_None,
              T.Default => XML.Schema.VC_Default,
              T.Fixed   => XML.Schema.VC_Fixed);

      Node : constant Matreshka.XML_Schema.AST.Element_Declaration_Access
        := +Self.Node;
   begin
      if Node = null then
         return XML.Schema.VC_None;
      else
         return Convert (Node.Value_Constraint.Variety);
      end if;
   end Get_Constraint_Type;

   --------------------------
   -- Get_Constraint_Value --
   --------------------------

   function Get_Constraint_Value
    (Self : XS_Element_Declaration'Class)
       return League.Strings.Universal_String
   is
      use type Matreshka.XML_Schema.AST.Element_Declaration_Access;

      Node : constant Matreshka.XML_Schema.AST.Element_Declaration_Access
        := +Self.Node;
   begin
      if Node = null then
         return League.Strings.Empty_Universal_String;
      else
         return Node.Value_Constraint.Value;
      end if;
   end Get_Constraint_Value;

   ----------------------------------
   -- Get_Disallowed_Substitutions --
   ----------------------------------

   function Get_Disallowed_Substitutions
    (Self : XS_Element_Declaration'Class) return XML.Schema.Derivation_Set is
   begin
      raise Program_Error;
      return XML.Schema.Derivation_None;
   end Get_Disallowed_Substitutions;

   ---------------------------------
   -- Get_Enclosing_CT_Definition --
   ---------------------------------

   function Get_Enclosing_CT_Definition
    (Self : XS_Element_Declaration'Class)
       return XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition
   is
      use type Matreshka.XML_Schema.AST.Element_Declaration_Access;

      Node : constant Matreshka.XML_Schema.AST.Element_Declaration_Access
        := +Self.Node;
   begin
      if Node = null then
         return
           XML.Schema.Complex_Type_Definitions.Null_XS_Complex_Type_Definition;
      else
         return XML.Schema.Complex_Type_Definitions.Internals.Create
           (Matreshka.XML_Schema.AST.Complex_Type_Definition_Access
             (Node.Type_Definition));
      end if;
   end Get_Enclosing_CT_Definition;

   ------------------------------
   -- Get_Identity_Constraints --
   ------------------------------

   function Get_Identity_Constraints
    (Self : XS_Element_Declaration'Class)
       return XML.Schema.Named_Maps.XS_Named_Map is
   begin
      raise Program_Error;
      return X : XML.Schema.Named_Maps.XS_Named_Map;
   end Get_Identity_Constraints;

   ------------------
   -- Get_Nillable --
   ------------------

   function Get_Nillable (Self : XS_Element_Declaration'Class) return Boolean is
      use type Matreshka.XML_Schema.AST.Element_Declaration_Access;

      Node : constant Matreshka.XML_Schema.AST.Element_Declaration_Access
        := +Self.Node;
   begin
      if Node = null then
         return False;
      else
         return Node.Nillable;
      end if;
   end Get_Nillable;

   ---------------
   -- Get_Scope --
   ---------------

   function Get_Scope
    (Self : XS_Element_Declaration'Class) return XML.Schema.Scope
   is
      package T renames Matreshka.XML_Schema.AST.Types;
      use type Matreshka.XML_Schema.AST.Element_Declaration_Access;

      Node : constant Matreshka.XML_Schema.AST.Element_Declaration_Access
        := +Self.Node;
   begin
      if Node = null then
         return XML.Schema.Scope_Global;
      else
         case Node.Scope.Variety is
            when T.Global =>
               return XML.Schema.Scope_Global;
            when T.Local =>
               return XML.Schema.Scope_Local;
         end case;
      end if;
   end Get_Scope;

   ----------------------------------------
   -- Get_Substitution_Group_Affiliation --
   ----------------------------------------

   function Get_Substitution_Group_Affiliation
    (Self : XS_Element_Declaration'Class) return XS_Element_Declaration is
   begin
      raise Program_Error;
      return Null_XS_Element_Declaration;
   end Get_Substitution_Group_Affiliation;

   ---------------------------------------
   -- Get_Substitution_Group_Exclusions --
   ---------------------------------------

   function Get_Substitution_Group_Exclusions
    (Self : XS_Element_Declaration'Class) return XML.Schema.Derivation_Set is
   begin
      raise Program_Error;
      return XML.Schema.Derivation_None;
   end Get_Substitution_Group_Exclusions;

   -------------------------
   -- Get_Type_Definition --
   -------------------------

   function Get_Type_Definition
    (Self : XS_Element_Declaration'Class)
       return XML.Schema.Type_Definitions.XS_Type_Definition
   is
      use type Matreshka.XML_Schema.AST.Element_Declaration_Access;

      Node : constant Matreshka.XML_Schema.AST.Element_Declaration_Access
        := +Self.Node;
   begin
      if Node = null then
         return XML.Schema.Type_Definitions.Null_XS_Type_Definition;

      else
         return XML.Schema.Type_Definitions.Internals.Create
           (Node.Type_Definition);
      end if;
   end Get_Type_Definition;

end XML.Schema.Objects.Terms.Element_Declarations;
