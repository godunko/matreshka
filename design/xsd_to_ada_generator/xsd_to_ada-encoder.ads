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
with League.Strings;
with League.String_Vectors;

with XSD_To_Ada.Mappings.XML;
with XSD_To_Ada.Writers;

package XSD_To_Ada.Encoder is

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

   type Writers_Array is array (1 .. 20) of Writers.Writer;

   Top_Level_Writer : Writers_Array;

   function Add_Separator
     (Text : Wide_Wide_String) return Wide_Wide_String;

   function Add_Separator
     (Text : League.Strings.Universal_String) return Wide_Wide_String;

   function Gen_Type_Line
     (Str : Wide_Wide_String := "";
      Tab : Natural := 0)
      return Wide_Wide_String;

   Namespace : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
       ("http://www.actforex.com/iats");

   Map : XSD_To_Ada.Mappings.XML.Mapping_XML;

   Encoder_Writer     : Writers.Writer;
   Encoder_Top_Writer : Writers.Writer;

   Spec_Writer  : XSD_To_Ada.Writers.Writer;
   Element_Name : XSD_To_Ada.Writers.Writer;

   Element_Vector : League.String_Vectors.Universal_String_Vector;

   Tag_Vector : League.String_Vectors.Universal_String_Vector;

end XSD_To_Ada.Encoder;
