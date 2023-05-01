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
-- Copyright © 2015-2023, Vadim Godunko <vgodunko@gmail.com>                --
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

with XML.SAX.Locators.Internals;
with XML.SAX.Parse_Exceptions.Internals;

package body XML.SAX.Event_Readers is

   procedure Set
    (Locator : not null access Event_Reader_Shared_Locator'Class;
     Element : XML.Templates.Streams.XML_Stream_Element);

   procedure Reset
    (Locator : not null access Event_Reader_Shared_Locator'Class);

   --------------
   -- Base_URI --
   --------------

   overriding function Base_URI
    (Self : not null access constant Event_Reader_Shared_Locator)
       return League.IRIs.IRI is
   begin
      return X : League.IRIs.IRI;
   end Base_URI;

   ------------
   -- Column --
   ------------

   overriding function Column
    (Self : not null access constant Event_Reader_Shared_Locator)
       return Natural is
   begin
      return Self.Column;
   end Column;

   ---------------------
   -- Content_Handler --
   ---------------------

   overriding function Content_Handler
    (Self : Event_Reader) return XML.SAX.Readers.SAX_Content_Handler_Access is
   begin
      return Self.Content_Handler;
   end Content_Handler;

   -------------------------
   -- Declaration_Handler --
   -------------------------

   overriding function Declaration_Handler
    (Self : Event_Reader)
       return XML.SAX.Readers.SAX_Declaration_Handler_Access is
   begin
      return null;
   end Declaration_Handler;

   -----------------
   -- DTD_Handler --
   -----------------

   overriding function DTD_Handler
    (Self : Event_Reader) return XML.SAX.Readers.SAX_DTD_Handler_Access is
   begin
      return null;
   end DTD_Handler;

   --------------
   -- Encoding --
   --------------

   overriding function Encoding
    (Self : not null access constant Event_Reader_Shared_Locator)
       return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Encoding;

   ---------------------
   -- Entity_Resolver --
   ---------------------

   overriding function Entity_Resolver
    (Self : Event_Reader) return XML.SAX.Readers.SAX_Entity_Resolver_Access is
   begin
      return null;
   end Entity_Resolver;

   -------------------
   -- Error_Handler --
   -------------------

   overriding function Error_Handler
    (Self : Event_Reader) return XML.SAX.Readers.SAX_Error_Handler_Access is
   begin
      return Self.Error_Handler;
   end Error_Handler;

   -------------
   -- Feature --
   -------------

   overriding function Feature
    (Self : Event_Reader;
     Name : League.Strings.Universal_String) return Boolean is
   begin
      raise Program_Error;
      return False;
   end Feature;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Event_Reader) is
   begin
      Matreshka.Internals.SAX_Locators.Dereference
       (Matreshka.Internals.SAX_Locators.Shared_Locator_Access (Self.Locator));
   end Finalize;

   -----------------
   -- Has_Feature --
   -----------------

   overriding function Has_Feature
    (Self : Event_Reader;
     Name : League.Strings.Universal_String) return Boolean is
   begin
      return False;
   end Has_Feature;

   ---------------------
   -- Lexical_Handler --
   ---------------------

   overriding function Lexical_Handler
    (Self : Event_Reader) return XML.SAX.Readers.SAX_Lexical_Handler_Access is
   begin
      return Self.Lexical_Handler;
   end Lexical_Handler;

   ----------
   -- Line --
   ----------

   overriding function Line
    (Self : not null access constant Event_Reader_Shared_Locator)
       return Natural is
   begin
      return Self.Line;
   end Line;

   -----------
   -- Parse --
   -----------

   procedure Parse
    (Self   : in out Event_Reader'Class;
     Stream : XML.Templates.Streams.XML_Stream_Element_Vectors.Vector)
   is
      Success : Boolean := True;

   begin
      Self.Content_Handler.Set_Document_Locator
       (XML.SAX.Locators.Internals.Create
         (Matreshka.Internals.SAX_Locators.Shared_Locator_Access
           (Self.Locator)));

      for Item of Stream loop
         case Item.Kind is
            when XML.Templates.Streams.Empty =>
               null;

            when XML.Templates.Streams.Text =>
               Set (Self.Locator, Item);
               Self.Content_Handler.Characters
                (Text    => Item.Text,
                 Success => Success);

               if not Success then
                  Self.Error_Handler.Fatal_Error
                   (XML.SAX.Parse_Exceptions.Internals.Create
                     (Public_Id => League.Strings.Empty_Universal_String,
                      System_Id => Item.Location.System_Id,
                      Line      => Item.Location.Line,
                      Column    => Item.Location.Column,
                      Message   => Self.Content_Handler.Error_String));

                  return;
               end if;

            when XML.Templates.Streams.Start_Element =>
               Set (Self.Locator, Item);
               Self.Content_Handler.Start_Element
                (Namespace_URI  => Item.Namespace_URI,
                 Local_Name     => Item.Local_Name,
                 Qualified_Name => Item.Qualified_Name,
                 Attributes     => Item.Attributes,
                 Success        => Success);

               if not Success then
                  Self.Error_Handler.Fatal_Error
                   (XML.SAX.Parse_Exceptions.Internals.Create
                     (Public_Id => League.Strings.Empty_Universal_String,
                      System_Id => Item.Location.System_Id,
                      Line      => Item.Location.Line,
                      Column    => Item.Location.Column,
                      Message   => Self.Content_Handler.Error_String));

                  return;
               end if;

            when XML.Templates.Streams.End_Element =>
               Set (Self.Locator, Item);
               Self.Content_Handler.End_Element
                (Namespace_URI  => Item.Namespace_URI,
                 Local_Name     => Item.Local_Name,
                 Qualified_Name => Item.Qualified_Name,
                 Success        => Success);

               if not Success then
                  Self.Error_Handler.Fatal_Error
                   (XML.SAX.Parse_Exceptions.Internals.Create
                     (Public_Id => League.Strings.Empty_Universal_String,
                      System_Id => Item.Location.System_Id,
                      Line      => Item.Location.Line,
                      Column    => Item.Location.Column,
                      Message   => Self.Content_Handler.Error_String));

                  return;
               end if;

            when XML.Templates.Streams.Start_Prefix_Mapping =>
               Set (Self.Locator, Item);
               Self.Content_Handler.Start_Prefix_Mapping
                (Prefix        => Item.Prefix,
                 Namespace_URI => Item.Mapped_Namespace_URI,
                 Success       => Success);

               if not Success then
                  Self.Error_Handler.Fatal_Error
                   (XML.SAX.Parse_Exceptions.Internals.Create
                     (Public_Id => League.Strings.Empty_Universal_String,
                      System_Id => Item.Location.System_Id,
                      Line      => Item.Location.Line,
                      Column    => Item.Location.Column,
                      Message   => Self.Content_Handler.Error_String));

                  return;
               end if;

            when XML.Templates.Streams.End_Prefix_Mapping =>
               Set (Self.Locator, Item);
               Self.Content_Handler.End_Prefix_Mapping
                (Prefix  => Item.Prefix,
                 Success => Success);

               if not Success then
                  Self.Error_Handler.Fatal_Error
                   (XML.SAX.Parse_Exceptions.Internals.Create
                     (Public_Id => League.Strings.Empty_Universal_String,
                      System_Id => Item.Location.System_Id,
                      Line      => Item.Location.Line,
                      Column    => Item.Location.Column,
                      Message   => Self.Content_Handler.Error_String));

                  return;
               end if;

            when XML.Templates.Streams.Processing_Instruction =>
               Set (Self.Locator, Item);
               Self.Content_Handler.Processing_Instruction
                (Target  => Item.Target,
                 Data    => Item.Data,
                 Success => Success);

               if not Success then
                  Self.Error_Handler.Fatal_Error
                   (XML.SAX.Parse_Exceptions.Internals.Create
                     (Public_Id => League.Strings.Empty_Universal_String,
                      System_Id => Item.Location.System_Id,
                      Line      => Item.Location.Line,
                      Column    => Item.Location.Column,
                      Message   => Self.Content_Handler.Error_String));

                  return;
               end if;

            when XML.Templates.Streams.Comment =>
               Set (Self.Locator, Item);
               Self.Lexical_Handler.Comment
                (Text    => Item.Text,
                 Success => Success);

               if not Success then
                  Self.Error_Handler.Fatal_Error
                   (XML.SAX.Parse_Exceptions.Internals.Create
                     (Public_Id => League.Strings.Empty_Universal_String,
                      System_Id => Item.Location.System_Id,
                      Line      => Item.Location.Line,
                      Column    => Item.Location.Column,
                      Message   => Self.Content_Handler.Error_String));

                  return;
               end if;

            when XML.Templates.Streams.Start_CDATA =>
               Set (Self.Locator, Item);
               Self.Lexical_Handler.Start_CDATA (Success => Success);

               if not Success then
                  Self.Error_Handler.Fatal_Error
                   (XML.SAX.Parse_Exceptions.Internals.Create
                     (Public_Id => League.Strings.Empty_Universal_String,
                      System_Id => Item.Location.System_Id,
                      Line      => Item.Location.Line,
                      Column    => Item.Location.Column,
                      Message   => Self.Content_Handler.Error_String));

                  return;
               end if;

            when XML.Templates.Streams.End_CDATA =>
               Set (Self.Locator, Item);
               Self.Lexical_Handler.End_CDATA (Success => Success);

               if not Success then
                  Self.Error_Handler.Fatal_Error
                   (XML.SAX.Parse_Exceptions.Internals.Create
                     (Public_Id => League.Strings.Empty_Universal_String,
                      System_Id => Item.Location.System_Id,
                      Line      => Item.Location.Line,
                      Column    => Item.Location.Column,
                      Message   => Self.Content_Handler.Error_String));

                  return;
               end if;

            when XML.Templates.Streams.Start_DTD =>
               Set (Self.Locator, Item);
               Self.Lexical_Handler.Start_DTD
                (Name      => Item.Name,
                 Public_Id => Item.Public_Id,
                 System_Id => Item.System_Id,
                 Success   => Success);

               if not Success then
                  Self.Error_Handler.Fatal_Error
                   (XML.SAX.Parse_Exceptions.Internals.Create
                     (Public_Id => League.Strings.Empty_Universal_String,
                      System_Id => Item.Location.System_Id,
                      Line      => Item.Location.Line,
                      Column    => Item.Location.Column,
                      Message   => Self.Content_Handler.Error_String));

                  return;
               end if;

            when XML.Templates.Streams.End_DTD =>
               Set (Self.Locator, Item);
               Self.Lexical_Handler.End_DTD (Success => Success);

               if not Success then
                  Self.Error_Handler.Fatal_Error
                   (XML.SAX.Parse_Exceptions.Internals.Create
                     (Public_Id => League.Strings.Empty_Universal_String,
                      System_Id => Item.Location.System_Id,
                      Line      => Item.Location.Line,
                      Column    => Item.Location.Column,
                      Message   => Self.Content_Handler.Error_String));

                  return;
               end if;
         end case;
      end loop;

      Reset (Self.Locator);
   end Parse;

   ---------------
   -- Public_Id --
   ---------------

   overriding function Public_Id
    (Self : not null access constant Event_Reader_Shared_Locator)
       return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Public_Id;

   -----------
   -- Reset --
   -----------

   procedure Reset
    (Locator : not null access Event_Reader_Shared_Locator'Class) is
   begin
      Locator.System_Id.Clear;
      Locator.Line   := 0;
      Locator.Column := 0;
   end Reset;

   ---------
   -- Set --
   ---------

   procedure Set
    (Locator : not null access Event_Reader_Shared_Locator'Class;
     Element : XML.Templates.Streams.XML_Stream_Element) is
   begin
      Locator.System_Id := Element.Location.System_Id;
      Locator.Line      := Element.Location.Line;
      Locator.Column    := Element.Location.Column;
   end Set;

   -------------------------
   -- Set_Content_Handler --
   -------------------------

   overriding procedure Set_Content_Handler
    (Self    : in out Event_Reader;
     Handler : XML.SAX.Readers.SAX_Content_Handler_Access) is
   begin
      Self.Content_Handler := Handler;
   end Set_Content_Handler;

   -----------------------------
   -- Set_Declaration_Handler --
   -----------------------------

   overriding procedure Set_Declaration_Handler
    (Self    : in out Event_Reader;
     Handler : XML.SAX.Readers.SAX_Declaration_Handler_Access) is
   begin
      raise Program_Error;
   end Set_Declaration_Handler;

   ---------------------
   -- Set_DTD_Handler --
   ---------------------

   overriding procedure Set_DTD_Handler
    (Self    : in out Event_Reader;
     Handler : XML.SAX.Readers.SAX_DTD_Handler_Access) is
   begin
      raise Program_Error;
   end Set_DTD_Handler;

   -------------------------
   -- Set_Entity_Resolver --
   -------------------------

   overriding procedure Set_Entity_Resolver
    (Self     : in out Event_Reader;
     Resolver : XML.SAX.Readers.SAX_Entity_Resolver_Access) is
   begin
      raise Program_Error;
   end Set_Entity_Resolver;

   -----------------------
   -- Set_Error_Handler --
   -----------------------

   overriding procedure Set_Error_Handler
    (Self    : in out Event_Reader;
     Handler : XML.SAX.Readers.SAX_Error_Handler_Access) is
   begin
      Self.Error_Handler := Handler;
   end Set_Error_Handler;

   -----------------
   -- Set_Feature --
   -----------------

   overriding procedure Set_Feature
    (Self  : in out Event_Reader;
     Name  : League.Strings.Universal_String;
     Value : Boolean) is
   begin
      raise Program_Error;
   end Set_Feature;

   -------------------------
   -- Set_Lexical_Handler --
   -------------------------

   overriding procedure Set_Lexical_Handler
    (Self    : in out Event_Reader;
     Handler : XML.SAX.Readers.SAX_Lexical_Handler_Access) is
   begin
      Self.Lexical_Handler := Handler;
   end Set_Lexical_Handler;

   ---------------
   -- System_Id --
   ---------------

   overriding function System_Id
    (Self : not null access constant Event_Reader_Shared_Locator)
       return League.Strings.Universal_String is
   begin
      return Self.System_Id;
   end System_Id;

   -------------
   -- Version --
   -------------

   overriding function Version
    (Self : not null access constant Event_Reader_Shared_Locator)
       return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Version;

end XML.SAX.Event_Readers;
