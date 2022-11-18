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

package body XML.Schema.Objects.Attribute_Declarations is

   -------------------
   -- Get_Actual_VC --
   -------------------

   function Get_Actual_VC
    (Self : XS_Attribute_Declaration'Class) return League.Holders.Holder is
   begin
      raise Program_Error;
      return League.Holders.Empty_Holder;
   end Get_Actual_VC;

   ------------------------
   -- Get_Actual_VC_Type --
   ------------------------

   function Get_Actual_VC_Type
    (Self : XS_Attribute_Declaration'Class) return XML.Schema.Built_In_Type is
   begin
      raise Program_Error;
      return XML.Schema.Unavailable_DT;
   end Get_Actual_VC_Type;

   --------------------
   -- Get_Annotation --
   --------------------

   function Get_Annotation
    (Self : XS_Attribute_Declaration'Class)
       return XML.Schema.Annotations.XS_Annotation is
   begin
      raise Program_Error;
      return X : XML.Schema.Annotations.XS_Annotation;
   end Get_Annotation;

   -------------------------
   -- Get_Constraint_Type --
   -------------------------

   function Get_Constraint_Type
    (Self : XS_Attribute_Declaration'Class)
       return XML.Schema.Value_Constraint is
   begin
      raise Program_Error;
      return VC_None;
   end Get_Constraint_Type;

   --------------------------
   -- Get_Constraint_Value --
   --------------------------

   function Get_Constraint_Value
    (Self : XS_Attribute_Declaration'Class)
       return League.Strings.Universal_String is
   begin
      raise Program_Error;
      return League.Strings.Empty_Universal_String;
   end Get_Constraint_Value;

   ---------------------------------
   -- Get_Enclosing_CT_Definition --
   ---------------------------------

   function Get_Enclosing_CT_Definition
    (Self : XS_Attribute_Declaration'Class)
       return XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition is
   begin
      raise Program_Error;
      return
        X : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
   end Get_Enclosing_CT_Definition;

   --------------------------
   -- Get_Item_Value_Types --
   --------------------------

--   function Get_Item_Value_Types
--    (Self : XS_Attribute_Declaration'Class)
--       return XML.Schema.Built_In_Type_List;

   ---------------
   -- Get_Scope --
   ---------------

   function Get_Scope
    (Self : XS_Attribute_Declaration'Class) return XML.Schema.Scope is
   begin
      raise Program_Error;
      return Scope_Absent;
   end Get_Scope;

   -------------------------
   -- Get_Type_Definition --
   -------------------------

   function Get_Type_Definition
    (Self : XS_Attribute_Declaration'Class)
       return XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition is
   begin
      raise Program_Error;
      return X : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;
   end Get_Type_Definition;

end XML.Schema.Objects.Attribute_Declarations;
