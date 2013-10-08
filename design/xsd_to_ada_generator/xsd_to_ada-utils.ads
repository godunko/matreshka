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
--  $Revision: 3559 $ $Date: 2012-12-07 13:08:31 +0200 (Пт., 07 дек. 2012) $
------------------------------------------------------------------------------

with Ada.Containers.Indefinite_Vectors;

with XML.Schema.Models;
with XML.Schema.Type_Definitions;
with XML.Schema.Objects.Terms;

with XSD_To_Ada.Mappings;
with XSD_To_Ada.Mappings_XML;
with XSD_To_Ada.Writers;

with League.Strings;
with League.String_Vectors;

package XSD_To_Ada.Utils is

   type Types_Table_Type is
      record
         Type_Name  : League.Strings.Universal_String;
         Type_State : Boolean;
      end record;

   type Types_Table_Type_Array is array (1 .. 200) of Types_Table_Type;

   Types_Table    : Types_Table_Type_Array;

   Is_Vector_Type : League.String_Vectors.Universal_String_Vector;

   type Anonyn_Vector_Declatarion is
      record
         Print_Level : Natural := 2;
         Print_State : Boolean := False;
         Term_Level  : Natural := 2;
         Term_State  : Boolean := False;
      end record;

   type Anonyn_Vector_Declatarion_Array is
     array (1 .. 100) of Anonyn_Vector_Declatarion;

   Anonyn_Vector : Anonyn_Vector_Declatarion_Array;

   Now_Print_Level : Natural := 2;
   Now_Term_Level  : Natural := 2;

   Optional_Vector : League.String_Vectors.Universal_String_Vector;

   function Add_Separator
     (Text : Wide_Wide_String) return Wide_Wide_String;

   function Add_Separator
     (Text : League.Strings.Universal_String) return Wide_Wide_String;

   function Gen_Type_Line
     (Str : Wide_Wide_String := ""; Tab : Natural := 0)
      return Wide_Wide_String;

   procedure Create_Element_Type
     (Model  : XML.Schema.Models.XS_Model;
      Writer : in out XSD_To_Ada.Writers.Writer);

   procedure Create_Simple_Type
     (Model  : XML.Schema.Models.XS_Model;
      Writer : in out XSD_To_Ada.Writers.Writer);

   procedure Create_Enumeration_Simple_Type
     (Model  : XML.Schema.Models.XS_Model;
      Writer : in out XSD_To_Ada.Writers.Writer);

   procedure Create_Complex_Type (Model  : XML.Schema.Models.XS_Model);

   procedure Create_Vector_Package
     (Type_D_Name  : League.Strings.Universal_String;
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer);

   procedure Gen_Access_Type
     (Self   : in out XSD_To_Ada.Writers.Writer;
      Name   : Wide_Wide_String);

   procedure Gen_Line
     (Self : in out XSD_To_Ada.Writers.Writer; Str : Wide_Wide_String := "");

   procedure Gen_Proc_Header
     (Self   : in out XSD_To_Ada.Writers.Writer;
      Name   : Wide_Wide_String;
      Offset : Positive := 3);

   procedure Generate_Simple_Type
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      XS_Term      : XML.Schema.Objects.Terms.XS_Term;
      Type_Name    : League.Strings.Universal_String;
      Min_Occurs   : in out Boolean;
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer);

   function Has_Top_Level_Type
     (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
      Table  : Types_Table_Type_Array)
      return Boolean;
   --  This function returns True if Type_D has Top Level Types and
   --  it was not created.

   procedure Put_Header (Self : in out XSD_To_Ada.Writers.Writer);
   procedure New_Line (Self : in out XSD_To_Ada.Writers.Writer);

   procedure Print_Content_Type
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent       : String := "";
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer;
      Name         : League.Strings.Universal_String;
      Map          : XSD_To_Ada.Mappings_XML.Mapping_XML);

   procedure Print_Type_Definition
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent       : String := "";
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer;
      Name         : League.Strings.Universal_String;
      Is_Record    : Boolean := False;
      Map          : XSD_To_Ada.Mappings_XML.Mapping_XML;
      Table        : in out Types_Table_Type_Array;
      Is_Max_Occur : Boolean := False);

   procedure Print_Type_Title
     (Type_D      : XML.Schema.Type_Definitions.XS_Type_Definition;
      Writer      : in out XSD_To_Ada.Writers.Writer;
      Type_Writer : in out XSD_To_Ada.Writers.Writer);

   function Has_Element_Session
     (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition)
      return Boolean;

   function Read_Mapping
     (File_Name : League.Strings.Universal_String)
      return XSD_To_Ada.Mappings_XML.Mapping_XML;

   function Find_Type
     (Type_D_Name : League.Strings.Universal_String;
      Map         : XSD_To_Ada.Mappings_XML.Mapping_XML)
      return League.Strings.Universal_String;

   function Is_Type_In_Map
     (Type_D_Name : League.Strings.Universal_String;
      Map         : XSD_To_Ada.Mappings_XML.Mapping_XML)
      return Boolean;

   function Is_Type_In_Optional_Vector
     (Type_Name : League.Strings.Universal_String)
     return Boolean;

   Namespace : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
       ("http://www.actforex.com/iats");

   Map          : XSD_To_Ada.Mappings_XML.Mapping_XML;

end XSD_To_Ada.Utils;
