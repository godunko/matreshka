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
with Matreshka.XML_Schema.AST.Simple_Types;
with XML.Schema.Objects.Type_Definitions.Internals;

package body XML.Schema.Objects.Type_Definitions is

   function "+"
    (Self : Matreshka.XML_Schema.AST.Object_Access)
      return Matreshka.XML_Schema.AST.Type_Definition_Access;

   ---------
   -- "+" --
   ---------

   function "+"
    (Self : Matreshka.XML_Schema.AST.Object_Access)
      return Matreshka.XML_Schema.AST.Type_Definition_Access is
   begin
      return Matreshka.XML_Schema.AST.Type_Definition_Access (Self);
   end "+";

   ------------------
   -- Derived_From --
   ------------------

   function Derived_From
    (Self              : XS_Type_Definition'Class;
     Namespace         : League.Strings.Universal_String;
     Name              : League.Strings.Universal_String;
     Derivation_Method : XML.Schema.Derivation_Set) return Boolean is
   begin
      raise Program_Error;
      return False;
   end Derived_From;

   -----------------------
   -- Derived_From_Type --
   -----------------------

   function Derived_From_Type
    (Self              : XS_Type_Definition'Class;
     Ancestor_Type     : XS_Type_Definition'Class;
     Derivation_Method : XML.Schema.Derivation_Set) return Boolean is
   begin
      raise Program_Error;
      return False;
   end Derived_From_Type;

   -------------------
   -- Get_Anonymous --
   -------------------

   function Get_Anonymous (Self : XS_Type_Definition'Class) return Boolean is
   begin
      raise Program_Error;
      return False;
   end Get_Anonymous;

   -------------------
   -- Get_Base_Type --
   -------------------

   function Get_Base_Type
    (Self : XS_Type_Definition'Class) return XS_Type_Definition is
      use type Matreshka.XML_Schema.AST.Type_Definition_Access;

      Node : constant Matreshka.XML_Schema.AST.Type_Definition_Access
        := +Self.Node;
   begin
      if Node = null then
         return XML.Schema.Objects.Type_Definitions.Null_XS_Type_Definition;
      else
         return XML.Schema.Objects.Type_Definitions.Internals.Create
            (Node.Base_Type_Definition);
      end if;
   end Get_Base_Type;

   ---------------
   -- Get_Final --
   ---------------

   function Get_Final
    (Self : XS_Type_Definition'Class) return XML.Schema.Derivation_Set is
      use type Matreshka.XML_Schema.AST.Type_Definition_Access;

      Node : constant Matreshka.XML_Schema.AST.Type_Definition_Access
        := +Self.Node;
   begin
      if Node = null then
         return XML.Schema.Derivation_None;
      else
         return Node.Final;
      end if;
   end Get_Final;

   -----------------------
   -- Get_Type_Category --
   -----------------------

   function Get_Type_Category
    (Self : XS_Type_Definition'Class) return XML.Schema.Type_Category is
      use type Matreshka.XML_Schema.AST.Type_Definition_Access;

      Node : constant Matreshka.XML_Schema.AST.Type_Definition_Access
        := +Self.Node;
   begin
      if Node = null then
         return XML.Schema.None;

      else
         return Node.Get_Type_Category;

      end if;
   end Get_Type_Category;

   --------------
   -- Is_Final --
   --------------

   function Is_Final
    (Self        : XS_Type_Definition'Class;
     Restriction : XML.Schema.Type_Derivation_Control) return Boolean is
   begin
      return Self.Get_Final (Restriction);
   end Is_Final;

end XML.Schema.Objects.Type_Definitions;
