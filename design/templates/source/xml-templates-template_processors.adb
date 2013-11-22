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
with League.JSON.Arrays;
with League.JSON.Values;
with League.Holders.JSON_Arrays;

with XML.Templates.Streams.Holders;

package body XML.Templates.Template_Processors is

   use type League.Strings.Universal_String;

   Template_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://forge.ada-ru.org/matreshka/template");

   For_Name     : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("for");
   In_Name      : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("in");
   Object_Name  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("object");

   procedure Substitute
    (Self         : in out Template_Processor'Class;
     Text         : League.Strings.Universal_String;
     In_Attribute : Boolean;
     Result       : out League.Strings.Universal_String;
     Success      : in out Boolean);
   --  Process text and substitute parameters.

   procedure Process_Stream
    (Self    : in out Template_Processor'Class;
     Stream  : XML.Templates.Streams.XML_Stream_Element_Vectors.Vector;
     Success : in out Boolean);
   --  Process specified stream be dispatching each event to the template
   --  processor's event handler.

   procedure Process_Characters
    (Self    : in out Template_Processor'Class;
     Success : in out Boolean);
   --  Process accumulated character data.

   ----------------
   -- Characters --
   ----------------

   overriding procedure Characters
    (Self    : in out Template_Processor;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      if Self.Accumulate /= 0 then
         Self.Stream.Append ((XML.Templates.Streams.Text, Text));

      else
         Self.Accumulated_Text.Append (Text);
      end if;
   end Characters;

   -------------
   -- Comment --
   -------------

   overriding procedure Comment
    (Self    : in out Template_Processor;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      if Self.Accumulate /= 0 then
         Self.Stream.Append ((XML.Templates.Streams.Comment, Text));

      else
         Self.Process_Characters (Success);

         if not Success then
            return;
         end if;

         Self.Lexical_Handler.Comment (Text, Success);

         if not Success then
            Self.Diagnosis := Self.Lexical_Handler.Error_String;
         end if;
      end if;
   end Comment;

   ---------------
   -- End_CDATA --
   ---------------

   overriding procedure End_CDATA
    (Self    : in out Template_Processor;
     Success : in out Boolean) is
   begin
      if Self.Accumulate /= 0 then
         Self.Stream.Append ((Kind => XML.Templates.Streams.End_CDATA));

      else
         Self.Process_Characters (Success);

         if not Success then
            return;
         end if;

         Self.Lexical_Handler.End_CDATA (Success);

         if not Success then
            Self.Diagnosis := Self.Lexical_Handler.Error_String;
         end if;
      end if;
   end End_CDATA;

   -------------
   -- End_DTD --
   -------------

   overriding procedure End_DTD
    (Self    : in out Template_Processor;
     Success : in out Boolean) is
   begin
      if Self.Accumulate /= 0 then
         Self.Stream.Append ((Kind => XML.Templates.Streams.End_DTD));

      else
         Self.Lexical_Handler.End_DTD (Success);

         if not Success then
            Self.Diagnosis := Self.Lexical_Handler.Error_String;
         end if;
      end if;
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
      if Self.Accumulate /= 0 then
         Self.Accumulate := Self.Accumulate - 1;

         if Self.Accumulate /= 0 then
            Self.Stream.Append
             ((XML.Templates.Streams.End_Element,
               Namespace_URI,
               Local_Name,
               Qualified_Name));

         elsif Namespace_URI = Template_URI then
            if Local_Name = For_Name then
               Self.Namespaces.Pop_Context;

               declare
                  Container : League.JSON.Arrays.JSON_Array
                    := League.Holders.JSON_Arrays.Element
                        (Self.Parameters (Self.Container_Name));
                  Object    : League.JSON.Values.JSON_Value;
                  Holder    : League.Holders.Holder;
                  Success   : Boolean := True;

               begin
                  for Index in 1 .. Container.Length loop
                     Object := Container.Element (Index);

                     case League.JSON.Values.Kind (Object) is
                        when League.JSON.Values.Empty_Value
                          | League.JSON.Values.Boolean_Value
                          | League.JSON.Values.Number_Value
                          | League.JSON.Values.Array_Value
                          | League.JSON.Values.Object_Value
                          | League.JSON.Values.Null_Value
                        =>
                           raise Program_Error;

                        when League.JSON.Values.String_Value =>
                           Holder :=
                             League.Holders.To_Holder (Object.To_String);
                     end case;

                     Self.Parameters.Include (Self.Object_Name, Holder);
                     Self.Process_Stream (Self.Stream, Success);

                     if not Success then
                        return;
                     end if;
                  end loop;

                  Self.Parameters.Delete (Self.Object_Name);
                  Self.Stream.Clear;
               end;
            end if;
         end if;

      else
         Self.Process_Characters (Success);

         if not Success then
            return;
         end if;

         Self.Namespaces.Pop_Context;
         Self.Content_Handler.End_Element
          (Namespace_URI, Local_Name, Qualified_Name, Success);

         if not Success then
            Self.Diagnosis := Self.Content_Handler.Error_String;
         end if;
      end if;
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
      if Self.Accumulate /= 0 then
         Self.Stream.Append
          ((XML.Templates.Streams.End_Prefix_Mapping, Prefix));

      else
--         if Self.Namespaces.Namespace_URI (Prefix) /= Template_URI then
            Self.Content_Handler.End_Prefix_Mapping (Prefix, Success);

            if not Success then
               Self.Diagnosis := Self.Content_Handler.Error_String;
            end if;
--         end if;
      end if;
   end End_Prefix_Mapping;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : Template_Processor) return League.Strings.Universal_String is
   begin
      return Self.Diagnosis;
   end Error_String;

   ------------------------
   -- Process_Characters --
   ------------------------

   procedure Process_Characters
    (Self    : in out Template_Processor'Class;
     Success : in out Boolean)
   is
      Text : constant League.Strings.Universal_String := Self.Accumulated_Text;
      Aux  : League.Strings.Universal_String;

   begin
      if not Text.Is_Empty then
         Self.Accumulated_Text.Clear;
         Self.Substitute (Text, False, Aux, Success);
      end if;
   end Process_Characters;

   --------------------
   -- Process_Stream --
   --------------------

   procedure Process_Stream
    (Self    : in out Template_Processor'Class;
     Stream  : XML.Templates.Streams.XML_Stream_Element_Vectors.Vector;
     Success : in out Boolean) is
   begin
      for Event of Stream loop
         case Event.Kind is
            when XML.Templates.Streams.Empty =>
               raise Program_Error;

            when XML.Templates.Streams.Text =>
               Self.Characters (Event.Text, Success);

            when XML.Templates.Streams.Start_Element =>
               Self.Start_Element
                (Event.Namespace_URI,
                 Event.Local_Name,
                 Event.Qualified_Name,
                 Event.Attributes,
                 Success);

            when XML.Templates.Streams.End_Element =>
               Self.End_Element
                (Event.Namespace_URI,
                 Event.Local_Name,
                 Event.Qualified_Name,
                 Success);

            when XML.Templates.Streams.Start_Prefix_Mapping =>
               Self.Start_Prefix_Mapping
                (Event.Prefix, Event.Mapped_Namespace_URI, Success);

            when XML.Templates.Streams.End_Prefix_Mapping =>
               Self.End_Prefix_Mapping (Event.Prefix, Success);

            when XML.Templates.Streams.Processing_Instruction =>
               Self.Processing_Instruction (Event.Target, Event.Data, Success);

            when XML.Templates.Streams.Comment =>
               Self.Comment (Event.Text, Success);

            when XML.Templates.Streams.Start_CDATA =>
               Self.Start_CDATA (Success);

            when XML.Templates.Streams.End_CDATA =>
               Self.End_CDATA (Success);

            when XML.Templates.Streams.Start_DTD =>
               Self.Start_DTD
                (Event.Name, Event.Public_Id, Event.System_Id, Success);

            when XML.Templates.Streams.End_DTD =>
               Self.End_DTD (Success);
         end case;

         if not Success then
            return;
         end if;
      end loop;
   end Process_Stream;

   ----------------------------
   -- Processing_Instruction --
   ----------------------------

   overriding procedure Processing_Instruction
    (Self    : in out Template_Processor;
     Target  : League.Strings.Universal_String;
     Data    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      if Self.Accumulate /= 0 then
         Self.Stream.Append
          ((XML.Templates.Streams.Processing_Instruction, Target, Data));

      else
         Self.Process_Characters (Success);

         if not Success then
            return;
         end if;

         Self.Content_Handler.Processing_Instruction (Target, Data, Success);

         if not Success then
            Self.Diagnosis := Self.Content_Handler.Error_String;
         end if;
      end if;
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
      if Self.Accumulate /= 0 then
         Self.Stream.Append ((Kind => XML.Templates.Streams.Start_CDATA));

      else
         Self.Process_Characters (Success);

         if not Success then
            return;
         end if;

         Self.Lexical_Handler.Start_CDATA (Success);

         if not Success then
            Self.Diagnosis := Self.Lexical_Handler.Error_String;
         end if;
      end if;
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
      if Self.Accumulate /= 0 then
         Self.Stream.Append
          ((XML.Templates.Streams.Start_DTD, Name, Public_Id, System_Id));

      else
         Self.Lexical_Handler.Start_DTD (Name, Public_Id, System_Id, Success);

         if not Success then
            Self.Diagnosis := Self.Lexical_Handler.Error_String;
         end if;
      end if;
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
      Aux    : League.Strings.Universal_String;

   begin
      Self.Namespaces.Push_Context;

      if Self.Accumulate /= 0 then
         Self.Accumulate := Self.Accumulate + 1;
         Self.Stream.Append
          ((XML.Templates.Streams.Start_Element,
            Namespace_URI,
            Local_Name,
            Qualified_Name,
            Attributes));

      else
         Self.Process_Characters (Success);

         if not Success then
            return;
         end if;

         if Namespace_URI = Template_URI then
            if Local_Name = For_Name then
            --  Enable accumulation of SAX events for future processing.

               Self.Accumulate := 1;
               Self.Object_Name := Attributes (Object_Name);
               Self.Container_Name := Attributes (In_Name);

            else
               raise Program_Error;
            end if;

         else
            for J in 1 .. Attributes.Length loop
               Self.Substitute (Attributes (J), True, Aux, Success);

               if not Success then
                  return;
               end if;

               if Attributes.Namespace_URI (J).Is_Empty then
                  Result.Set_Value (Attributes.Qualified_Name (J), Aux);

               else
                  Result.Set_Value
                   (Attributes.Namespace_URI (J),
                    Attributes.Local_Name (J),
                    Aux);
               end if;
            end loop;

            Self.Content_Handler.Start_Element
             (Namespace_URI, Local_Name, Qualified_Name, Result, Success);

            if not Success then
               Self.Diagnosis := Self.Content_Handler.Error_String;
            end if;
         end if;
      end if;
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
      if Self.Accumulate /= 0 then
         Self.Stream.Append
          ((XML.Templates.Streams.Start_Prefix_Mapping,
            Prefix,
            Namespace_URI));

      else
         Self.Namespaces.Declare_Prefix (Prefix, Namespace_URI);

         if Namespace_URI /= Template_URI then
            Self.Content_Handler.Start_Prefix_Mapping
             (Prefix, Namespace_URI, Success);

            if not Success then
               Self.Diagnosis := Self.Content_Handler.Error_String;
            end if;
         end if;
      end if;
   end Start_Prefix_Mapping;

   ----------------
   -- Substitute --
   ----------------

   procedure Substitute
    (Self         : in out Template_Processor'Class;
     Text         : League.Strings.Universal_String;
     In_Attribute : Boolean;
     Result       : out League.Strings.Universal_String;
     Success      : in out Boolean)
   is
      use type League.Characters.Universal_Character;

      procedure Process_Expression (Text : League.Strings.Universal_String);
      --  Parse and execute expression.

      ------------------------
      -- Process_Expression --
      ------------------------

      procedure Process_Expression (Text : League.Strings.Universal_String) is

         type Token_Kinds is (Token_Identifier, Token_End_Of_Expression);

         function Next_Token return Token_Kinds;

         Current     : Positive := 1;
         Slice_First : Positive;
         Slice_Last  : Natural;

         ----------------
         -- Next_Token --
         ----------------

         function Next_Token return Token_Kinds is
            First : Positive := Current;

         begin
            --  Skip white spaces

            while Current <= Text.Length loop
               exit when not Text (Current).Is_White_Space;

               Current := Current + 1;
               First   := Current;
            end loop;

            if First > Text.Length then
               return Token_End_Of_Expression;
            end if;

            --  Extract identifier

            if Text (First).Is_ID_Start then
               Current := Current + 1;

               while Current <= Text.Length loop
                  exit when not Text (Current).Is_ID_Continue;

                  Current := Current + 1;
               end loop;

               Slice_First := First;
               Slice_Last  := Current - 1;

               return Token_Identifier;
            end if;
         end Next_Token;

         Token : Token_Kinds;
         Value : League.Holders.Holder;

      begin
         Token := Next_Token;

         case Token is
            when Token_Identifier =>
               Value := Self.Parameters (Text.Slice (Slice_First, Slice_Last));

               if League.Holders.Is_Universal_String (Value) then
                  if In_Attribute then
                     Result.Append (League.Holders.Element (Value));

                  else
                     Self.Content_Handler.Characters
                      (League.Holders.Element (Value), Success);

                     if not Success then
                        Self.Diagnosis := Self.Content_Handler.Error_String;

                        return;
                     end if;
                  end if;

               elsif League.Holders.Has_Tag
                      (Value, XML.Templates.Streams.Holders.Value_Tag)
               then
                  if In_Attribute then
                     raise Program_Error;

                  else
                     Self.Process_Stream
                      (XML.Templates.Streams.Holders.Element (Value),
                       Success);

                     if not Success then
                        return;
                     end if;
                  end if;

               else
                  raise Program_Error;
               end if;

            when Token_End_Of_Expression =>
               raise Program_Error;
         end case;
      end Process_Expression;

      First  : Positive := 1;
      Dollar : Natural;
      Last   : Natural;

   begin
      Result.Clear;

      while First <= Text.Length loop
         Dollar := Text.Index (First, '$');

         if Dollar = 0 then
            if In_Attribute then
               Result.Append (Text.Slice (First, Text.Length));

            else
               Self.Content_Handler.Characters
                (Text.Slice (First, Text.Length), Success);

               if not Success then
                  Self.Diagnosis := Self.Content_Handler.Error_String;

                  return;
               end if;
            end if;

            First := Text.Length + 1;

         else
            if In_Attribute then
               Result.Append (Text.Slice (First, Dollar - 1));

            else
               Self.Content_Handler.Characters
                (Text.Slice (First, Dollar - 1), Success);

               if not Success then
                  Self.Diagnosis := Self.Content_Handler.Error_String;

                  return;
               end if;
            end if;

            if Dollar < Text.Length
              and then Text (Dollar + 1) = '$'
            then
               --  Escaped dollar sign.

               if In_Attribute then
                  Result.Append ('$');

               else
                  Self.Content_Handler.Characters
                   (Text.Slice (Dollar + 1, Dollar + 1), Success);

                  if not Success then
                     Self.Diagnosis := Self.Content_Handler.Error_String;

                     return;
                  end if;
               end if;

            elsif Dollar <= Text.Length
              and then Text (Dollar + 1) = '{'
            then
               --  Expression.

               First := Dollar + 2;
               Dollar := Text.Index (First, '}');

               if Dollar = 0 then
                  raise Program_Error;

               else
                  Last := Dollar - 1;
                  Process_Expression (Text.Slice (First, Last));
                  First := Dollar + 1;
               end if;
            end if;
         end if;
      end loop;
   end Substitute;

end XML.Templates.Template_Processors;
