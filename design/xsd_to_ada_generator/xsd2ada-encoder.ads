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
-- Copyright © 2013-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
with League.Strings;
with League.String_Vectors;

with XML.Schema.Terms;
with XML.Schema.Type_Definitions;

with XSD2Ada.Analyzer;
with XSD_To_Ada.Writers;

with XML.Schema.Model_Groups;

package XSD2Ada.Encoder is

   Payload_Type  : League.Strings.Universal_String;

   Elements_Name : League.String_Vectors.Universal_String_Vector;
   Type_Elements_Name : League.String_Vectors.Universal_String_Vector;

   Element_Name  : XSD_To_Ada.Writers.Writer;
   Type_Element_Name  : XSD_To_Ada.Writers.Writer;

   function Add_Indent
     (Spaces_Count : Integer)
      return League.Strings.Universal_String;

   procedure Generate_Complex_Type
     (XS_Term      : XML.Schema.Terms.XS_Term;
      Writer       : in out XSD_To_Ada.Writers.Writer;
      Element_Name : League.Strings.Universal_String;
      Base_Name    : League.Strings.Universal_String;
      Min_Occurs   : Boolean;
      Max_Occurs   : Boolean);

   procedure Generate_Overriding_Procedure_Encode_Header
     (Writer          : in out XSD_To_Ada.Writers.Writer;
      Spec_Writer     : in out XSD_To_Ada.Writers.Writer;
      Procedures_Name : League.Strings.Universal_String;
      Tag_Vector      : in out League.String_Vectors.Universal_String_Vector;
      Is_AnyType      : Boolean := False);

   procedure Generate_Package_Header
     (Payload_Writer : in out XSD_To_Ada.Writers.Writer);

   procedure Generate_Procedure_Encode_Header
     (Writer          : in out XSD_To_Ada.Writers.Writer;
      Spec_Writer     : in out XSD_To_Ada.Writers.Writer;
      Procedures_Name : League.Strings.Universal_String);

   procedure Generate_Simple_Type
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      XS_Term      : XML.Schema.Terms.XS_Term;
      Writer       : in out XSD_To_Ada.Writers.Writer;
      Element_Name : League.Strings.Universal_String;
      Base_Name    : League.Strings.Universal_String;
        Min_Occurs : Boolean;
      Max_Occurs   : Boolean);

   procedure Print_Type_Definition
     (Type_D        : XML.Schema.Type_Definitions.XS_Type_Definition;
      Encoder_Types : in out XSD_To_Ada.Writers.Writer;
      Encoder_Spec_Types   : in out XSD_To_Ada.Writers.Writer;
      Writer        : in out XSD_To_Ada.Writers.Writer;
      Writer_types  : in out XSD_To_Ada.Writers.Writer;
      Spec_Writer   : in out XSD_To_Ada.Writers.Writer;
      Name          : League.Strings.Universal_String;
      Element_Name  : League.Strings.Universal_String;
      Tag_Vector    : in out League.String_Vectors.Universal_String_Vector;
      Choice        : Boolean := False;
      Is_Min_Occur  : Boolean := False;
      Is_Max_Occur  : Boolean := False);

   procedure Print_Model
     (Model_Group  : XML.Schema.Model_Groups.XS_Model_Group;
      Writer       : in out XSD_To_Ada.Writers.Writer;
      Writer_types : in out XSD_To_Ada.Writers.Writer;
      Name         : League.Strings.Universal_String;
      Element_Name : League.Strings.Universal_String;
      Base_Name    : League.Strings.Universal_String
      := League.Strings.Empty_Universal_String;
      Choice       : Boolean := False);

   procedure Print_Type_Title
     (Node_Vector          : XSD2Ada.Analyzer.Items;
      Encoder_Types        : in out XSD_To_Ada.Writers.Writer;
      Encoder_Spec_Types   : in out XSD_To_Ada.Writers.Writer;
      Writer               : in out XSD_To_Ada.Writers.Writer;
      Spec_Writer          : in out XSD_To_Ada.Writers.Writer;
      Encoder_Names_Writer : in out XSD_To_Ada.Writers.Writer;
      Tag_Vector           : in out
        League.String_Vectors.Universal_String_Vector);

   function Write_End_Element
     (Name : League.Strings.Universal_String)
      return League.Strings.Universal_String;

   function Write_Start_Element
     (Name : League.Strings.Universal_String)
      return League.Strings.Universal_String;

end XSD2Ada.Encoder;
