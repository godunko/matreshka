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
with League.Characters;

package body XML.Templates.Template_Processors is

   function Substitute
    (Self : in out Template_Processor'Class;
     Text : League.Strings.Universal_String)
       return League.Strings.Universal_String;
   --  Process text and substitute parameters.

   ----------------
   -- Substitute --
   ----------------

   function Substitute
    (Self : in out Template_Processor'Class;
     Text : League.Strings.Universal_String)
       return League.Strings.Universal_String
   is
      use type League.Characters.Universal_Character;

      Current : Positive := 1;
      First   : Positive;
      Last    : Natural;
      Result  : League.Strings.Universal_String;
      Object  : League.Holders.Holder;

   begin
      while Current <= Text.Length loop
         if Text (Current) = '$'
           and then Current < Text.Length
           and then Text (Current + 1) = '{'
         then
            First := Current + 2;
            Current := Current + 2;

            while Current <= Text.Length loop
               exit when Text (Current) = '}';
               Current := Current + 1;
            end loop;

            if Current <= Text.Length then
               Last := Current - 1;
               Object := Self.Parameters (Text.Slice (First, Last));

               if League.Holders.Is_Universal_String (Object) then
                  Result.Append (League.Holders.Element (Object));

               else
                  raise Program_Error;
               end if;

            else
               --  Invalid syntax.

               raise Program_Error;
            end if;

         else
            Result.Append (Text (Current));
         end if;

         Current := Current + 1;
      end loop;

      return Result;
   end Substitute;

   ----------------
   -- Characters --
   ----------------

   overriding procedure Characters
    (Self    : in out Template_Processor;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      Self.Content_Handler.Characters
       (Self.Substitute (Text), Success);
   end Characters;

   -------------
   -- Comment --
   -------------

   overriding procedure Comment
    (Self    : in out Template_Processor;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      Self.Lexical_Handler.Comment (Text, Success);
   end Comment;

   ---------------
   -- End_CDATA --
   ---------------

   overriding procedure End_CDATA
    (Self    : in out Template_Processor;
     Success : in out Boolean) is
   begin
      Self.Lexical_Handler.End_CDATA (Success);
   end End_CDATA;

   -------------
   -- End_DTD --
   -------------

   overriding procedure End_DTD
    (Self    : in out Template_Processor;
     Success : in out Boolean) is
   begin
      Self.Lexical_Handler.End_DTD (Success);
   end End_DTD;

   -----------------
   -- End_Element --
   -----------------

   overriding procedure End_Element
    (Self           : in out Template_Processor;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean) is
   begin
      Self.Namespaces.Pop_Context;
      Self.Content_Handler.End_Element
       (Namespace_URI, Local_Name, Qualified_Name, Success);
   end End_Element;

   -------------------
   -- Set_Parameter --
   -------------------

   procedure Set_Parameter
    (Self  : in out Template_Processor'Class;
     Name  : League.Strings.Universal_String;
     Value : League.Holders.Holder) is
   begin
      Self.Parameters.Include (Name, Value);
   end Set_Parameter;

   ------------------------
   -- End_Prefix_Mapping --
   ------------------------

   overriding procedure End_Prefix_Mapping
    (Self    : in out Template_Processor;
     Prefix  : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      Self.Content_Handler.End_Prefix_Mapping (Prefix, Success);
   end End_Prefix_Mapping;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : Template_Processor) return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   ----------------------------
   -- Processing_Instruction --
   ----------------------------

   overriding procedure Processing_Instruction
    (Self    : in out Template_Processor;
     Target  : League.Strings.Universal_String;
     Data    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      Self.Content_Handler.Processing_Instruction (Target, Data, Success);
   end Processing_Instruction;

   -------------------------
   -- Set_Content_Handler --
   -------------------------

   procedure Set_Content_Handler
    (Self    : in out Template_Processor'Class;
     Handler : XML.SAX.Readers.SAX_Content_Handler_Access) is
   begin
      Self.Content_Handler := Handler;
   end Set_Content_Handler;

   -------------------------
   -- Set_Lexical_Handler --
   -------------------------

   procedure Set_Lexical_Handler
    (Self    : in out Template_Processor'Class;
     Handler : XML.SAX.Readers.SAX_Lexical_Handler_Access) is
   begin
      Self.Lexical_Handler := Handler;
   end Set_Lexical_Handler;

   -----------------
   -- Start_CDATA --
   -----------------

   overriding procedure Start_CDATA
    (Self    : in out Template_Processor;
     Success : in out Boolean) is
   begin
      Self.Lexical_Handler.Start_CDATA (Success);
   end Start_CDATA;

   ---------------
   -- Start_DTD --
   ---------------

   overriding procedure Start_DTD
    (Self      : in out Template_Processor;
     Name      : League.Strings.Universal_String;
     Public_Id : League.Strings.Universal_String;
     System_Id : League.Strings.Universal_String;
     Success   : in out Boolean) is
   begin
      Self.Lexical_Handler.Start_DTD (Name, Public_Id, System_Id, Success);
   end Start_DTD;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out Template_Processor;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean)
   is
      Result : XML.SAX.Attributes.SAX_Attributes;

   begin
      Self.Namespaces.Push_Context;

      for J in 1 .. Attributes.Length loop
         if Attributes.Namespace_URI (J).Is_Empty then
            Result.Set_Value
             (Attributes.Qualified_Name (J), Self.Substitute (Attributes (J)));

         else
            Result.Set_Value
             (Attributes.Namespace_URI (J),
              Attributes.Local_Name (J),
              Self.Substitute (Attributes (J)));
         end if;
      end loop;

      Self.Content_Handler.Start_Element
       (Namespace_URI, Local_Name, Qualified_Name, Result, Success);
   end Start_Element;

   --------------------------
   -- Start_Prefix_Mapping --
   --------------------------

   overriding procedure Start_Prefix_Mapping
    (Self          : in out Template_Processor;
     Prefix        : League.Strings.Universal_String;
     Namespace_URI : League.Strings.Universal_String;
     Success       : in out Boolean) is
   begin
      Self.Namespaces.Declare_Prefix (Prefix, Namespace_URI);
      Self.Content_Handler.Start_Prefix_Mapping
       (Prefix, Namespace_URI, Success);
   end Start_Prefix_Mapping;

end XML.Templates.Template_Processors;
