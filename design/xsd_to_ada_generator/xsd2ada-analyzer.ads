------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                              Tools Component                             --
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
--  This package analyze XML schema model.
------------------------------------------------------------------------------
with Ada.Containers.Vectors;

with League.Strings;

with XML.Schema.Type_Definitions;
with XML.Schema.Element_Declarations;
with XML.Schema.Models;

package XSD2Ada.Analyzer is

   type Item is tagged private;
   type Item_Access is access all Item'Class;

   function Type_Def
     (Self : Item) return XML.Schema.Type_Definitions.XS_Type_Definition;
   function Min (Self : Item) return Boolean;
   function Max (Self : Item) return Boolean;
   function Choice (Self : Item) return Boolean;
   function Anonym_Name (Self : Item) return League.Strings.Universal_String;
   function Element_Name (Self : Item) return League.Strings.Universal_String;
   function Short_Ada_Type_Name
     (Self : Item) return League.Strings.Universal_String;
   --  Short name of Ada type described by the element.
   function Full_Ada_Type_Name
     (Self : Item) return League.Strings.Universal_String;
   --  Full name of Ada type described by the element.
   function Full_Ada_Package_Name
     (Self : Item) return League.Strings.Universal_String;
   --  Full name of Ada compilation unit enclosing Ada type declaration.

   package Item_Vectors is
     new Ada.Containers.Vectors (Positive, Item_Access);

   subtype Items is Item_Vectors.Vector;

   ---------------------
   -- Old subprograms --
   ---------------------

   procedure Create_Element_Nodes
     (Model       : XML.Schema.Models.XS_Model;
      Node_Vector : in out Items);
   --  Add new node to Node_Vector for each Element declaration in Model
   --  Also add types from dependencies

   procedure Create_Element_Node
     (Element     : XML.Schema.Element_Declarations.XS_Element_Declaration;
      Node_Vector : in out XSD2Ada.Analyzer.Items);
   --  Add new node to Node_Vector for given Element declaration
   --  Also add types from dependencies

   procedure Create_Type_Node
     (Type_D      : XML.Schema.Type_Definitions.XS_Type_Definition;
      Node_Vector : in out XSD2Ada.Analyzer.Items);
   --  Add new node to Node_Vector for given type definition
   --  Also add types from dependencies

private

   type Item is tagged record
      Type_Def         : XML.Schema.Type_Definitions.XS_Type_Definition;
      Min, Max         : Boolean := False;
      Anonym_Name      : League.Strings.Universal_String;
      Element_Name     : League.Strings.Universal_String;

      Short_Ada_Type_Name   : League.Strings.Universal_String;
   end record;
end XSD2Ada.Analyzer;
