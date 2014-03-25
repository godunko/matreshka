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
with League.String_Vectors;

package body Matreshka.XML_Schema.Convertors is

   use type League.Strings.Universal_String;

   All_Image         : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("#all");
   Extension_Image   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("extension");
   List_Image        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("list");
   Restriction_Image : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("restriction");
   Union_Image       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("union");

   --------------------
   -- To_Final_Flags --
   --------------------

   function To_Final_Flags
    (Image   : League.Strings.Universal_String;
     Allowed : Matreshka.XML_Schema.AST.Final_Flags)
       return Matreshka.XML_Schema.AST.Final_Flags
   is
      use all type Matreshka.XML_Schema.AST.Final_Kinds;

      Result : Matreshka.XML_Schema.AST.Final_Flags := (others => False);
      Items  : League.String_Vectors.Universal_String_Vector;
      Item   : League.Strings.Universal_String;

   begin
      if Image = All_Image then
         Result := (others => True);

      else
         Items := Image.Split (' ');

         for J in 1 .. Items.Length loop
            Item := Items.Element (J);

            if Item = Extension_Image then
               if Allowed (Extension) then
                  Result (Extension) := True;

               else
                  raise Constraint_Error;
               end if;

            elsif Item = Restriction_Image then
               if Allowed (Restriction) then
                  Result (Restriction) := True;

               else
                  raise Constraint_Error;
               end if;

            elsif Item = List_Image then
               if Allowed (List) then
                  Result (List) := True;

               else
                  raise Constraint_Error;
               end if;

            elsif Item = Union_Image then
               if Allowed (Union) then
                  Result (Union) := True;

               else
                  raise Constraint_Error;
               end if;

            else
               raise Constraint_Error;
            end if;
         end loop;
      end if;

      return Result;
   end To_Final_Flags;

end Matreshka.XML_Schema.Convertors;
