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
with Matreshka.XML_Schema.AST.Attribute_Uses;

package body XML.Schema.Objects.Attribute_Uses is

   use type Matreshka.XML_Schema.AST.Attribute_Use_Access;

   -------------------
   -- Get_Actual_VC --
   -------------------

   function Get_Actual_VC
    (Self : XS_Attribute_Use'Class) return League.Holders.Holder is
   begin
      raise Program_Error;
      return League.Holders.Empty_Holder;
   end Get_Actual_VC;

   ------------------------
   -- Get_Actual_VC_Type --
   ------------------------

   function Get_Actual_VC_Type
    (Self : XS_Attribute_Use'Class) return XML.Schema.Built_In_Type is
   begin
      raise Program_Error;
      return XML.Schema.Unavailable_DT;
   end Get_Actual_VC_Type;

   --------------------------
   -- Get_Attr_Declaration --
   --------------------------

   function Get_Attr_Declaration
    (Self : XS_Attribute_Use'Class)
       return
         XML.Schema.Objects.Attribute_Declarations.XS_Attribute_Declaration
   is
   begin
      raise Program_Error;
      return
        XML.Schema.Objects.Attribute_Declarations
          .Null_XS_Attribute_Declaration;
   end Get_Attr_Declaration;

   -------------------------
   -- Get_Constraint_Type --
   -------------------------

   function Get_Constraint_Type
    (Self : XS_Attribute_Use'Class) return XML.Schema.Value_Constraint is
   begin
      raise Program_Error;
      return XML.Schema.VC_Fixed;
   end Get_Constraint_Type;

   --------------------------
   -- Get_Constraint_Value --
   --------------------------

   function Get_Constraint_Value
    (Self : XS_Attribute_Use'Class) return League.Strings.Universal_String is
   begin
      raise Program_Error;
      return League.Strings.Empty_Universal_String;
   end Get_Constraint_Value;

   --------------------------
   -- Get_Item_Value_Types --
   --------------------------

--   function Get_Item_Value_Types
--    (Self : XS_Attribute_Use'Class) return XML.Schema.Built_In_Type_List;

   ------------------
   -- Get_Required --
   ------------------

   function Get_Required (Self : XS_Attribute_Use'Class) return Boolean is
      Node : constant Matreshka.XML_Schema.AST.Attribute_Use_Access
        := Matreshka.XML_Schema.AST.Attribute_Use_Access (Self.Node);

   begin
      if Node = null then
         return False;

      else
         return Node.Required;
      end if;
   end Get_Required;

end XML.Schema.Objects.Attribute_Uses;
