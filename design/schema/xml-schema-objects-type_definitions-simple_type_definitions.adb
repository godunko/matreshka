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
-- Copyright © 2013, Vadim Godunko <vgodunko@gmail.com>                     --
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

with Matreshka.XML_Schema.AST.Simple_Types;
with XML.Schema.Objects.Type_Definitions.Simple_Type_Definitions.Internals;
with XML.Schema.Object_Lists.Internals;

package body XML.Schema.Objects.Type_Definitions.Simple_Type_Definitions is

   function "+"
    (Self : Matreshka.XML_Schema.AST.Object_Access)
      return Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;

   ---------
   -- "+" --
   ---------

   function "+"
    (Self : Matreshka.XML_Schema.AST.Object_Access)
      return Matreshka.XML_Schema.AST.Simple_Type_Definition_Access is
   begin
      return Matreshka.XML_Schema.AST.Simple_Type_Definition_Access (Self);
   end "+";



   -------------------
   -- Built_In_Kind --
   -------------------

   function Built_In_Kind
     (Self : XS_Simple_Type_Definition'Class)
      return Built_In_Type
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Built_In_Kind unimplemented");
      raise Program_Error with "Unimplemented function Built_In_Kind";
      return Built_In_Kind (Self);
   end Built_In_Kind;

   --------------------
   -- Get_Annotation --
   --------------------

   function Get_Annotation
     (Self : XS_Simple_Type_Definition'Class)
      return XML.Schema.Annotations.XS_Annotation
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Annotation unimplemented");
      raise Program_Error with "Unimplemented function Get_Annotation";
      return Get_Annotation (Self);
   end Get_Annotation;

   -----------------
   -- Get_Bounded --
   -----------------

   function Get_Bounded
     (Self : XS_Simple_Type_Definition'Class)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Bounded unimplemented");
      raise Program_Error with "Unimplemented function Get_Bounded";
      return Get_Bounded (Self);
   end Get_Bounded;

   ------------------------
   -- Get_Defined_Facets --
   ------------------------

   function Get_Defined_Facets
     (Self : XS_Simple_Type_Definition'Class)
      return Facets
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Defined_Facets unimplemented");
      raise Program_Error with "Unimplemented function Get_Defined_Facets";
      return Get_Defined_Facets (Self);
   end Get_Defined_Facets;

   ----------------
   -- Get_Facets --
   ----------------

   function Get_Facets
     (Self : XS_Simple_Type_Definition'Class)
      return XML.Schema.Object_Lists.XS_Object_List
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Facets unimplemented");
      raise Program_Error with "Unimplemented function Get_Facets";
      return Get_Facets (Self);
   end Get_Facets;

   ----------------
   -- Get_Finite --
   ----------------

   function Get_Finite
     (Self : XS_Simple_Type_Definition'Class)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Finite unimplemented");
      raise Program_Error with "Unimplemented function Get_Finite";
      return Get_Finite (Self);
   end Get_Finite;

   ----------------------
   -- Get_Fixed_Facets --
   ----------------------

   function Get_Fixed_Facets
     (Self : XS_Simple_Type_Definition'Class)
      return Facets
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Fixed_Facets unimplemented");
      raise Program_Error with "Unimplemented function Get_Fixed_Facets";
      return Get_Fixed_Facets (Self);
   end Get_Fixed_Facets;

   -------------------
   -- Get_Item_Type --
   -------------------

   function Get_Item_Type
     (Self : XS_Simple_Type_Definition'Class)
      return XS_Simple_Type_Definition'Class
   is
      use type Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;

      Node : constant Matreshka.XML_Schema.AST.Simple_Type_Definition_Access
        := +Self.Node;
   begin
      if Node = null then
         return Null_XS_Simple_Type_Definition;
      else
         return Internals.Create (Node.Item_Type_Definition);
      end if;
   end Get_Item_Type;

   -----------------------------
   -- Get_Lexical_Enumeration --
   -----------------------------

   function Get_Lexical_Enumeration
     (Self : XS_Simple_Type_Definition'Class)
      return League.String_Vectors.Universal_String_Vector
   is
      use type Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;

      Node : constant Matreshka.XML_Schema.AST.Simple_Type_Definition_Access
        := +Self.Node;
   begin
      if Node = null then
         return League.String_Vectors.Empty_Universal_String_Vector;
      else
         return Node.Lexical_Enumeration;
      end if;

   end Get_Lexical_Enumeration;

   -----------------------------
   -- Get_Lexical_Facet_Value --
   -----------------------------

   function Get_Lexical_Facet_Value
     (Self  : XS_Simple_Type_Definition'Class;
      Facet : Facet_Kind)
      return League.Strings.Universal_String
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Lexical_Facet_Value unimplemented");
      raise Program_Error with "Unimplemented function Get_Lexical_Facet_Value";
      return Get_Lexical_Facet_Value (Self, Facet);
   end Get_Lexical_Facet_Value;

   -------------------------
   -- Get_Lexical_Pattern --
   -------------------------

   function Get_Lexical_Pattern
     (Self : XS_Simple_Type_Definition'Class)
      return League.String_Vectors.Universal_String_Vector
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Lexical_Pattern unimplemented");
      raise Program_Error with "Unimplemented function Get_Lexical_Pattern";
      return Get_Lexical_Pattern (Self);
   end Get_Lexical_Pattern;

   ----------------------------
   -- Get_Multi_Value_Facets --
   ----------------------------

   function Get_Multi_Value_Facets
     (Self : XS_Simple_Type_Definition'Class)
      return XML.Schema.Object_Lists.XS_Object_List
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Multi_Value_Facets unimplemented");
      raise Program_Error with "Unimplemented function Get_Multi_Value_Facets";
      return Get_Multi_Value_Facets (Self);
   end Get_Multi_Value_Facets;

   -----------------
   -- Get_Numeric --
   -----------------

   function Get_Numeric
     (Self : XS_Simple_Type_Definition'Class)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Numeric unimplemented");
      raise Program_Error with "Unimplemented function Get_Numeric";
      return Get_Numeric (Self);
   end Get_Numeric;

   -----------------
   -- Get_Ordered --
   -----------------

   function Get_Ordered
     (Self : XS_Simple_Type_Definition'Class)
      return Ordered_Kind
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Ordered unimplemented");
      raise Program_Error with "Unimplemented function Get_Ordered";
      return Get_Ordered (Self);
   end Get_Ordered;

   ------------------------
   -- Get_Primitive_Type --
   ------------------------

   function Get_Primitive_Type
     (Self : XS_Simple_Type_Definition'Class)
      return XS_Simple_Type_Definition'Class
   is
      use type Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;

      Node : constant Matreshka.XML_Schema.AST.Simple_Type_Definition_Access
        := +Self.Node;
   begin
      if Node = null then
         return Null_XS_Simple_Type_Definition;
      else
         return Internals.Create (Node.Simple_Type_Definition);
      end if;
   end Get_Primitive_Type;

   -----------------
   -- Get_Variety --
   -----------------

   function Get_Variety
     (Self : XS_Simple_Type_Definition'Class) return Variety
   is
      package A renames Matreshka.XML_Schema.AST;

      Convert : constant array (A.Simple_Type_Variety) of Variety :=
        (A.Absent => Variety_Absent,
         A.Atomic => Variety_Atomic,
         A.List   => Variety_List,
         A.Union  => Variety_Union);

      use type Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;

      Node : constant Matreshka.XML_Schema.AST.Simple_Type_Definition_Access
        := +Self.Node;
   begin
      if Node = null then
         return Variety_Absent;
      else
         return Convert (Node.Variety);
      end if;
   end Get_Variety;

   ----------------------
   -- Is_Defined_Facet --
   ----------------------

   function Is_Defined_Facet
    (Self  : XS_Simple_Type_Definition'Class;
     Facet : Facet_Kind)
       return Boolean is
   begin
      return Self.Get_Defined_Facets (Facet);
   end Is_Defined_Facet;

   --------------------
   -- Is_Fixed_Facet --
   --------------------

   function Is_Fixed_Facet
    (Self  : XS_Simple_Type_Definition'Class;
     Facet : Facet_Kind)
       return Boolean is
   begin
      return Self.Get_Fixed_Facets (Facet);
   end Is_Fixed_Facet;

   ------------------
   -- Member_Types --
   ------------------

   function Member_Types
     (Self : XS_Simple_Type_Definition'Class)
      return XML.Schema.Object_Lists.XS_Object_List
   is
      use type Matreshka.XML_Schema.AST.Simple_Type_Definition_Access;

      Node : constant Matreshka.XML_Schema.AST.Simple_Type_Definition_Access
        := +Self.Node;
   begin
      if Node = null then
         return XML.Schema.Object_Lists.Empty_XS_Object_List;
      else
         return XML.Schema.Object_Lists.Internals.Create
           (Node.Member_Type_Definitions);
      end if;
   end Member_Types;

end XML.Schema.Objects.Type_Definitions.Simple_Type_Definitions;
