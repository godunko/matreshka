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
with Matreshka.XML_Schema.AST.Complex_Types;
with Matreshka.XML_Schema.AST.Objects;
with Matreshka.XML_Schema.AST.Simple_Types;
with Matreshka.XML_Schema.AST.Types;
with XML.Schema.Namespace_Items;
with XML.Schema.Objects.Terms.Element_Declarations;
with XML.Schema.Objects.Type_Definitions.Internals;
with XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions.Internals;
with XML.Schema.Objects.Type_Definitions.Simple_Type_Definitions.Internals;

package body XML.Schema.Objects is

   use type Matreshka.XML_Schema.AST.Object_Access;

   ---------
   -- "=" --
   ---------

   function "=" (Left : XS_Object; Right : XS_Object) return Boolean is
   begin
      return Left.Node = Right.Node;
   end "=";

   ---------
   -- "=" --
   ---------

   function "=" (Left : XS_Object; Right : XS_Object'Class) return Boolean is
   begin
      return Left.Node = Right.Node;
   end "=";

   --------------
   -- Get_Name --
   --------------

   function Get_Name
    (Self : XS_Object'Class) return League.Strings.Universal_String is
   begin
      raise Program_Error;
      return League.Strings.Empty_Universal_String;
   end Get_Name;

   --------------
   -- Get_Name --
   --------------

   function Get_Namespace
    (Self : XS_Object'Class) return League.Strings.Universal_String is
   begin
      raise Program_Error;
      return League.Strings.Empty_Universal_String;
   end Get_Namespace;

   ------------------------
   -- Get_Namespace_Item --
   ------------------------

   function Get_Namespace_Item
    (Self : XS_Object'Class)
       return XML.Schema.Namespace_Items.XS_Namespace_Item is
   begin
      raise Program_Error;
      return X : XML.Schema.Namespace_Items.XS_Namespace_Item;
   end Get_Namespace_Item;

   --------------
   -- Get_Type --
   --------------

   function Get_Type
    (Self : XS_Object'Class) return XML.Schema.Component_Type is
   begin
      if Self.Node = null then
         return None;

      else
         return Self.Node.Get_Type;
      end if;
   end Get_Type;

   -------------------
   -- Is_Annotation --
   -------------------

   function Is_Annotation (Self : XS_Object'Class) return Boolean is
   begin
      return Self.Get_Type = Annotation;
   end Is_Annotation;

   ------------------------------
   -- Is_Attribute_Declaration --
   ------------------------------

   function Is_Attribute_Declaration (Self : XS_Object'Class) return Boolean is
   begin
      return Self.Get_Type = Attribute_Declaration;
   end Is_Attribute_Declaration;

   ------------------------
   -- Is_Attribute_Group --
   ------------------------

   function Is_Attribute_Group (Self : XS_Object'Class) return Boolean is
   begin
      return Self.Get_Type = Attribute_Group;
   end Is_Attribute_Group;

   ----------------------
   -- Is_Attribute_Use --
   ----------------------

   function Is_Attribute_Use (Self : XS_Object'Class) return Boolean is
   begin
      return Self.Get_Type = Attribute_Use;
   end Is_Attribute_Use;

   --------------------------------
   -- Is_Complex_Type_Definition --
   --------------------------------

   function Is_Complex_Type_Definition
    (Self : XS_Object'Class) return Boolean is
   begin
      return
        Self.Get_Type = Type_Definition
          and then Self.Node.all
                     in Matreshka.XML_Schema.AST.Complex_Types
                          .Complex_Type_Definition_Node'Class;
   end Is_Complex_Type_Definition;

   ----------------------------
   -- Is_Element_Declaration --
   ----------------------------

   function Is_Element_Declaration (Self : XS_Object'Class) return Boolean is
   begin
      return Self.Get_Type = Element_Declaration;
   end Is_Element_Declaration;

   --------------
   -- Is_Facet --
   --------------

   function Is_Facet (Self : XS_Object'Class) return Boolean is
   begin
      return Self.Get_Type = Facet;
   end Is_Facet;

   ----------------------------
   -- Is_Identity_Constraint --
   ----------------------------

   function Is_Identity_Constraint (Self : XS_Object'Class) return Boolean is
   begin
      return Self.Get_Type = Identity_Constraint;
   end Is_Identity_Constraint;

   --------------------
   -- Is_Model_Group --
   --------------------

   function Is_Model_Group (Self : XS_Object'Class) return Boolean is
   begin
      return Self.Get_Type = Model_Group;
   end Is_Model_Group;

   -------------------------------
   -- Is_Model_Group_Definition --
   -------------------------------

   function Is_Model_Group_Definition
    (Self : XS_Object'Class) return Boolean is
   begin
      return Self.Get_Type = Model_Group_Definition;
   end Is_Model_Group_Definition;

   -------------------------
   -- Is_Multivalue_Facet --
   -------------------------

   function Is_Multivalue_Facet (Self : XS_Object'Class) return Boolean is
   begin
      return Self.Get_Type = Multivalue_Facet;
   end Is_Multivalue_Facet;

   -----------------------------
   -- Is_Notation_Declaration --
   -----------------------------

   function Is_Notation_Declaration (Self : XS_Object'Class) return Boolean is
   begin
      return Self.Get_Type = Notation_Declaration;
   end Is_Notation_Declaration;

   -------------
   -- Is_Null --
   -------------

   function Is_Null (Self : XS_Object'Class) return Boolean is
   begin
      return Self.Node = null;
   end Is_Null;

   -----------------
   -- Is_Particle --
   -----------------

   function Is_Particle (Self : XS_Object'Class) return Boolean is
   begin
      return Self.Get_Type = Particle;
   end Is_Particle;

   -------------------------------
   -- Is_Simple_Type_Definition --
   -------------------------------

   function Is_Simple_Type_Definition
    (Self : XS_Object'Class) return Boolean is
   begin
      return
        Self.Get_Type = Type_Definition
          and then Self.Node.all
                     in Matreshka.XML_Schema.AST.Simple_Types
                          .Simple_Type_Definition_Node'Class;
   end Is_Simple_Type_Definition;

   ------------------------
   -- Is_Type_Definition --
   ------------------------

   function Is_Type_Definition (Self : XS_Object'Class) return Boolean is
   begin
      return Self.Get_Type = Type_Definition;
   end Is_Type_Definition;

   -----------------
   -- Is_Wildcard --
   -----------------

   function Is_Wildcard (Self : XS_Object'Class) return Boolean is
   begin
      return Self.Get_Type = Wildcard;
   end Is_Wildcard;

   --------------------------------
   -- To_Complex_Type_Definition --
   --------------------------------

   function To_Complex_Type_Definition
    (Self : XS_Object'Class)
       return
         XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions
           .XS_Complex_Type_Definition is
   begin
      if Self.Is_Null or else not Self.Is_Complex_Type_Definition then
         return
           XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions
             .Null_XS_Complex_Type_Definition;

      else
         return
           XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions
             .Internals.Create
               (Matreshka.XML_Schema.AST.Complex_Type_Definition_Access
                 (Self.Node));
      end if;
   end To_Complex_Type_Definition;

   ----------------------------
   -- To_Element_Declaration --
   ----------------------------

   function To_Element_Declaration
    (Self : XS_Object'Class)
       return
         XML.Schema.Objects.Terms.Element_Declarations.XS_Element_Declaration
   is
   begin
      raise Program_Error;
      return
        X :
          XML.Schema.Objects.Terms.Element_Declarations.XS_Element_Declaration;
   end To_Element_Declaration;

   -------------------------------
   -- To_Simple_Type_Definition --
   -------------------------------

   function To_Simple_Type_Definition
    (Self : XS_Object'Class)
       return
         XML.Schema.Objects.Type_Definitions.Simple_Type_Definitions
           .XS_Simple_Type_Definition is
   begin
      if Self.Is_Null or else not Self.Is_Simple_Type_Definition then
         return
           XML.Schema.Objects.Type_Definitions.Simple_Type_Definitions
             .Null_XS_Simple_Type_Definition;

      else
         return
           XML.Schema.Objects.Type_Definitions.Simple_Type_Definitions
             .Internals.Create
               (Matreshka.XML_Schema.AST.Simple_Type_Definition_Access
                 (Self.Node));
      end if;
   end To_Simple_Type_Definition;

   ------------------------
   -- To_Type_Definition --
   ------------------------

   function To_Type_Definition
    (Self : XS_Object'Class)
       return XML.Schema.Objects.Type_Definitions.XS_Type_Definition is
   begin
      if Self.Is_Null or else not Self.Is_Complex_Type_Definition then
         return XML.Schema.Objects.Type_Definitions.Null_XS_Type_Definition;

      else
         return
           XML.Schema.Objects.Type_Definitions.Internals.Create
            (Matreshka.XML_Schema.AST.Type_Definition_Access (Self.Node));
      end if;
   end To_Type_Definition;

end XML.Schema.Objects;
