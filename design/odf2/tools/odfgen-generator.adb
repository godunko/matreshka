------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Open Document Toolkit                           --
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
with Ada.Wide_Wide_Text_IO;

with League.RegExps;
with League.String_Vectors;

package body ODFGen.Generator is

   procedure Generate_Element_API
    (API_Template : League.String_Vectors.Universal_String_Vector;
     Element      : Element_Information);

   function Load_Template
    (File_Name : String) return League.String_Vectors.Universal_String_Vector;

   --------------
   -- Generate --
   --------------

   procedure Generate is
      Element_API_Template : League.String_Vectors.Universal_String_Vector
        := Load_Template ("tools/templates/element_api.ads.tmpl");

   begin
      for Element of Elements loop
         Generate_Element_API (Element_API_Template, Element);
      end loop;
   end Generate;

   --------------------------
   -- Generate_Element_API --
   --------------------------

   procedure Generate_Element_API
    (API_Template : League.String_Vectors.Universal_String_Vector;
     Element      : Element_Information)
   is
      use type League.Strings.Universal_String;

      Parameter_Rexexp : constant League.Regexps.Regexp_Pattern
        := League.Regexps.Compile
            (League.Strings.To_Universal_String ("\@([A-Za-z0-9_]+)\@"));
      Match            : League.Regexps.Regexp_Match;
      Line             : League.Strings.Universal_String;

   begin
      for J in 1 .. API_Template.Length loop
         Line := API_Template (J);

         loop
            Match := Parameter_Rexexp.Find_Match (Line);

            exit when not Match.Is_Matched;

            if Match.Capture (1)
                 = League.Strings.To_Universal_String ("GROUP")
            then
               Line :=
                 Line.Slice (1, Match.First_Index - 1)
                   & Element.Group_Ada_Name
                   & Line.Slice (Match.Last_Index + 1, Line.Length);

            elsif Match.Capture (1)
                 = League.Strings.To_Universal_String ("ELEMENT")
            then
               Line :=
                 Line.Slice (1, Match.First_Index - 1)
                   & Element.Element_Ada_Name
                   & Line.Slice (Match.Last_Index + 1, Line.Length);

            else
               Ada.Wide_Wide_Text_IO.Put_Line (Line.To_Wide_Wide_String);

               raise Program_Error;
            end if;
         end loop;

         Ada.Wide_Wide_Text_IO.Put_Line (Line.To_Wide_Wide_String);
      end loop;
   end Generate_Element_API;

   -------------------
   -- Load_Template --
   -------------------

   function Load_Template
    (File_Name : String) return League.String_Vectors.Universal_String_Vector
   is
      File     : Ada.Wide_Wide_Text_IO.File_Type;
      Buffer   : Wide_Wide_String (1 .. 128);
      Last     : Natural;
      Template : League.String_Vectors.Universal_String_Vector;

   begin
      Ada.Wide_Wide_Text_IO.Open
       (File,
        Ada.Wide_Wide_Text_IO.In_File,
        "tools/templates/element_api.ads.tmpl");

      while not Ada.Wide_Wide_Text_IO.End_Of_File (File) loop
         Ada.Wide_Wide_Text_IO.Get_Line (File, Buffer, Last);
         Template.Append
          (League.Strings.To_Universal_String (Buffer (1 .. Last)));
      end loop;

      Ada.Wide_Wide_Text_IO.Close (File);

      return Template;
   end Load_Template;

end ODFGen.Generator;
