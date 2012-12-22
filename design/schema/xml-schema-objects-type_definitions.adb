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

package body XML.Schema.Objects.Type_Definitions is

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
   begin
      raise Program_Error;
      return X : XS_Type_Definition;
   end Get_Base_Type;

   ---------------
   -- Get_Final --
   ---------------

   function Get_Final
    (Self : XS_Type_Definition'Class) return XML.Schema.Derivation_Set is
   begin
      raise Program_Error;
      return (others => False);
   end Get_Final;

   -----------------------
   -- Get_Type_Category --
   -----------------------

   function Get_Type_Category
    (Self : XS_Type_Definition'Class) return XML.Schema.Type_Category is
   begin
      if Self.Is_Null then
         return XML.Schema.None;

      elsif Self.Node.all
              in Matreshka.XML_Schema.AST.Complex_Types
                   .Complex_Type_Definition_Node'Class
      then
         return XML.Schema.Complex_Type;

      elsif Self.Node.all
              in Matreshka.XML_Schema.AST.Simple_Types
                   .Simple_Type_Definition_Node'Class
      then
         return XML.Schema.Simple_Type;

      else
         raise Program_Error;
      end if;
   end Get_Type_Category;

   --------------
   -- Is_Final --
   --------------

   function Is_Final
    (Self        : XS_Type_Definition'Class;
     Restriction : XML.Schema.Type_Derivation_Control) return Boolean is
   begin
      raise Program_Error;
      return False;
   end Is_Final;

end XML.Schema.Objects.Type_Definitions;
