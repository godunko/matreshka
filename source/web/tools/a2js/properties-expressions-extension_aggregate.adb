------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Asis.Expressions;

with League.String_Vectors;

package body Properties.Expressions.Extension_Aggregate is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      Tag  : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Expression_Type (Element);
      List : constant Asis.Association_List :=
        Asis.Expressions.Record_Component_Associations (Element, True);
      Result : League.Strings.Universal_String;
      Names  : League.Strings.Universal_String;
      Text   : League.Strings.Universal_String;
   begin
      Result.Append ("_ec._extend (");
      Text := Engine.Text.Get_Property (Tag, Engines.Initialize);
      Result.Append (Text);
      Result.Append (", {");

      for J in List'Range loop
         Names := Engine.Text.Get_Property (List (J), Engines.Associations);
         Text := Engine.Text.Get_Property (List (J), Name);

         declare
            V : constant League.String_Vectors.Universal_String_Vector
              := Names.Split (',');
         begin
            for K in 1 .. V.Length loop
               if J /= List'First or K /= 1 then
                  Result.Append (",");
               end if;

               Result.Append (V.Element (K));
               Result.Append (":");
               Result.Append (Text);
            end loop;
         end;
      end loop;

      Result.Append ("})");
      return Result;
   end Code;

end Properties.Expressions.Extension_Aggregate;
