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

package body XML.Schema.Namespace_Items is

   ------------------------
   -- Document_Locations --
   ------------------------

   function Document_Locations
    (Self : XS_Namespace_Item'Class)
       return League.String_Vectors.Universal_String_Vector is
   begin
      raise Program_Error;
      return League.String_Vectors.Empty_Universal_String_Vector;
   end Document_Locations;

   ---------------------
   -- Get_Annotations --
   ---------------------

   function Get_Annotations
    (Self : XS_Namespace_Item'Class)
       return XML.Schema.Object_Lists.XS_Object_List is
   begin
      raise Program_Error;
      return X : XML.Schema.Object_Lists.XS_Object_List;
   end Get_Annotations;

   -------------------------------
   -- Get_Attribute_Declaration --
   -------------------------------

   function Get_Attribute_Declaration
    (Self : XS_Namespace_Item'Class;
     Name : League.Strings.Universal_String)
       return XML.Schema.Attribute_Declarations.XS_Attribute_Declaration is
   begin
      raise Program_Error;
      return X : XML.Schema.Attribute_Declarations.XS_Attribute_Declaration;
   end Get_Attribute_Declaration;

   -------------------------
   -- Get_Attribute_Group --
   -------------------------

   function Get_Attribute_Group
    (Self : XS_Namespace_Item'Class;
     Name : League.Strings.Universal_String)
       return
         XML.Schema.Attribute_Group_Definitions.XS_Attribute_Group_Definition is
   begin
      raise Program_Error;
      return
        X :
          XML.Schema.Attribute_Group_Definitions.XS_Attribute_Group_Definition;
   end Get_Attribute_Group;

   --------------------
   -- Get_Components --
   --------------------

   function Get_Components
    (Self        : XS_Namespace_Item'Class;
     Object_Type : Extended_XML_Schema_Component_Type)
       return XML.Schema.Named_Maps.XS_Named_Map is
   begin
      raise Program_Error;
      return X : XML.Schema.Named_Maps.XS_Named_Map;
   end Get_Components;

   -----------------------------
   -- Get_Element_Declaration --
   -----------------------------

   function Get_Element_Declaration
    (Self : XS_Namespace_Item'Class;
     Name : League.Strings.Universal_String)
       return XML.Schema.Element_Declarations.XS_Element_Declaration is
   begin
      raise Program_Error;
      return X : XML.Schema.Element_Declarations.XS_Element_Declaration;
   end Get_Element_Declaration;

   --------------------------------
   -- Get_Model_Group_Definition --
   --------------------------------

   function Get_Model_Group_Definition
    (Self : XS_Namespace_Item'Class;
     Name : League.Strings.Universal_String)
       return XML.Schema.Model_Group_Definitions.XS_Model_Group_Definition is
   begin
      raise Program_Error;
      return X : XML.Schema.Model_Group_Definitions.XS_Model_Group_Definition;
   end Get_Model_Group_Definition;

   ------------------------------
   -- Get_Notation_Declaration --
   ------------------------------

   function Get_Notation_Declaration
    (Self : XS_Namespace_Item'Class;
     Name : League.Strings.Universal_String)
       return XML.Schema.Notation_Declarations.XS_Notation_Declaration is
   begin
      raise Program_Error;
      return X : XML.Schema.Notation_Declarations.XS_Notation_Declaration;
   end Get_Notation_Declaration;

   --------------------------
   -- Get_Schema_Namespace --
   --------------------------

   function Get_Schema_Namespace
    (Self : XS_Namespace_Item'Class) return League.Strings.Universal_String is
   begin
      raise Program_Error;
      return League.Strings.Empty_Universal_String;
   end Get_Schema_Namespace;

   -------------------------
   -- Get_Type_Definition --
   -------------------------

   function Get_Type_Definition
    (Self : XS_Namespace_Item'Class;
     Name : League.Strings.Universal_String)
       return XML.Schema.Type_Definitions.XS_Type_Definition is
   begin
      raise Program_Error;
      return X : XML.Schema.Type_Definitions.XS_Type_Definition;
   end Get_Type_Definition;

end XML.Schema.Namespace_Items;
