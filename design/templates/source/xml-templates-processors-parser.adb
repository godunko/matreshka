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
--  $Revision$ $Date$
------------------------------------------------------------------------------

package body XML.Templates.Processors.Parser is

   type Token_Kinds is (Token_Identifier, Token_End_Of_Expression);

   type Scanner_Type is tagged record
      Text    : League.Strings.Universal_String;
      Current : Positive := 1;
      First   : Positive;
      Last    : Natural;
   end record;

   function Next_Token (Self : in out Scanner_Type'Class) return Token_Kinds;

   function Token_Image
    (Self : Scanner_Type'Class) return League.Strings.Universal_String;

   --------------------------------
   -- Evaluate_Simple_Expression --
   --------------------------------

   procedure Evaluate_Simple_Expression
    (Text    : League.Strings.Universal_String;
     Context : String_Holder_Maps.Map;
     Value   : out League.Holders.Holder;
     Success : out Boolean)
   is
      Scanner : Scanner_Type;
--      Token   : Token_Kinds;

   begin
      Scanner.Text := Text;

      Success := False;
--         Value : League.Holders.Holder;
--
--      begin
--         Token := Next_Token;
--
      case Scanner.Next_Token is
         when Token_Identifier =>
            Value := Context (Scanner.Token_Image);
            Success := True;
--
--               if League.Holders.Is_Universal_String (Value) then
--                  if In_Attribute then
--                     Result.Append (League.Holders.Element (Value));
--
--                  else
--                     Self.Content_Handler.Characters
--                      (League.Holders.Element (Value), Success);
--
--                     if not Success then
--                        Self.Diagnosis := Self.Content_Handler.Error_String;
--
--                        return;
--                     end if;
--                  end if;
--
--               elsif League.Holders.Has_Tag
--                      (Value, XML.Templates.Streams.Holders.Value_Tag)
--               then
--                  if In_Attribute then
--                     raise Program_Error;
--
--                  else
--                     Self.Process_Stream
--                      (XML.Templates.Streams.Holders.Element (Value),
--                       Success);
--
--                     if not Success then
--                        return;
--                     end if;
--                  end if;
--
--               else
--                  raise Program_Error;
--               end if;

         when Token_End_Of_Expression =>
            null;
      end case;
   end Evaluate_Simple_Expression;

   ----------------
   -- Next_Token --
   ----------------

   function Next_Token (Self : in out Scanner_Type'Class) return Token_Kinds is
   begin
      Self.First := Self.Current;

      --  Skip white spaces

      while Self.Current <= Self.Text.Length loop
         exit when not Self.Text (Self.Current).Is_White_Space;

         Self.Current := Self.Current + 1;
         Self.First   := Self.Current;
      end loop;

      if Self.First > Self.Text.Length then
         return Token_End_Of_Expression;
      end if;

      --  Extract identifier

      if Self.Text (Self.First).Is_ID_Start then
         Self.Current := Self.Current + 1;

         while Self.Current <= Self.Text.Length loop
            exit when not Self.Text (Self.Current).Is_ID_Continue;

            Self.Current := Self.Current + 1;
         end loop;

         Self.Last := Self.Current - 1;

         return Token_Identifier;
      end if;
   end Next_Token;

   -----------------
   -- Token_Image --
   -----------------

   function Token_Image
    (Self : Scanner_Type'Class) return League.Strings.Universal_String is
   begin
      return Self.Text.Slice (Self.First, Self.Last);
   end Token_Image;

end XML.Templates.Processors.Parser;
