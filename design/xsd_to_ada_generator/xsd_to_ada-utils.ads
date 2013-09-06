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

with XSD_To_Ada.Writers;

with XML.Schema.Type_Definitions;
with XML.Schema.Objects.Terms;
with League.Strings;

package XSD_To_Ada.Utils is

   function Add_Separator
     (Text : Wide_Wide_String) return Wide_Wide_String;

   procedure Gen_Access_Type
     (Self   : in out XSD_To_Ada.Writers.Writer;
      Name   : Wide_Wide_String;
      Offset : Positive := 3);

   procedure Gen_Line
     (Self : in out XSD_To_Ada.Writers.Writer; Str : Wide_Wide_String := "");

   procedure Gen_Proc_Header
     (Self   : in out XSD_To_Ada.Writers.Writer;
      Name   : Wide_Wide_String;
      Offset : Positive := 3);

   procedure Put_Header (Self : in out XSD_To_Ada.Writers.Writer);
   procedure New_Line (Self : in out XSD_To_Ada.Writers.Writer);

   procedure Print_Type_Definition
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent       : String := "";
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer;
      Name         : League.Strings.Universal_String;
      Is_Record    : Boolean := False);

   procedure Print_Term
     (XS_Term : XML.Schema.Objects.Terms.XS_Term;
      Indent  : String := "";
      Writer  : in out Writers.Writer;
      Writer_types    : in out Writers.Writer;
      Name    : League.Strings.Universal_String);

   procedure Print_Type_Session
     (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent : String := "";
      Session : in out Boolean);

   Count  : Natural := 0;
   Choice : Natural := 0;
   Session_Bool : Boolean := False;
   Now_Add : Boolean := False;
   Add_Choise : Boolean := False;

   Add_Anonym : Boolean := False;

   Anonym_Type : Boolean := False;

   Name_Kind   : League.Strings.Universal_String;
   Name_Case   : League.Strings.Universal_String;
   Anonym_Kind : League.Strings.Universal_String;
end XSD_To_Ada.Utils;
