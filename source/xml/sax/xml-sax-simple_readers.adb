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
-- Copyright © 2010-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
with League.Strings.Internals;
with Matreshka.Internals.URI_Utilities;
with XML.SAX.Constants;
with XML.SAX.Simple_Readers.Callbacks;
with XML.SAX.Simple_Readers.Parser;
with XML.SAX.Simple_Readers.Scanner;

package body XML.SAX.Simple_Readers is

   use Matreshka.Internals.Strings;
   use XML.SAX.Readers;
   use type League.Strings.Universal_String;

   procedure Reset (Self : in out Simple_Reader);
   --  Resets reader to start to read data from new input source.

   --------------
   -- Base_URI --
   --------------

   overriding function Base_URI
    (Self : not null access constant Simple_Shared_Locator)
       return League.IRIs.IRI is
   begin
      return Matreshka.Internals.XML.Base_Scopes.Base_URI (Self.Reader.Bases);
   end Base_URI;

   -----------
   -- Clear --
   -----------

   procedure Clear (Item : in out YYSType) is
   begin
      if Item.String /= null then
         Matreshka.Internals.Strings.Dereference (Item.String);
         Item.String        := null;
      end if;

      Item.Is_Whitespace := False;
      Item.Symbol        := Matreshka.Internals.XML.No_Symbol;
   end Clear;

   ------------
   -- Column --
   ------------

   overriding function Column
    (Self : not null access constant Simple_Shared_Locator) return Natural is
   begin
      return Self.Reader.Scanner_State.YY_Current_Column;
   end Column;

   ---------------------
   -- Content_Handler --
   ---------------------

   overriding function Content_Handler
    (Self : Simple_Reader) return XML.SAX.Readers.SAX_Content_Handler_Access is
   begin
      if Self.Content_Handler = Default_Handler'Access then
         return null;

      else
         return Self.Content_Handler;
      end if;
   end Content_Handler;

   -------------------------
   -- Declaration_Handler --
   -------------------------

   overriding function Declaration_Handler
    (Self : Simple_Reader)
       return XML.SAX.Readers.SAX_Declaration_Handler_Access is
   begin
      if Self.Declaration_Handler = Default_Handler'Access then
         return null;

      else
         return Self.Declaration_Handler;
      end if;
   end Declaration_Handler;

   -----------------
   -- DTD_Handler --
   -----------------

   overriding function DTD_Handler
    (Self : Simple_Reader) return XML.SAX.Readers.SAX_DTD_Handler_Access is
   begin
      if Self.DTD_Handler = Default_Handler'Access then
         return null;

      else
         return Self.DTD_Handler;
      end if;
   end DTD_Handler;

   --------------
   -- Encoding --
   --------------

   overriding function Encoding
    (Self : not null access constant Simple_Shared_Locator)
       return League.Strings.Universal_String
   is
      pragma Unreferenced (Self);

   begin
      return League.Strings.Empty_Universal_String;
   end Encoding;

   ---------------------
   -- Entity_Resolver --
   ---------------------

   overriding function Entity_Resolver
    (Self : Simple_Reader)
       return XML.SAX.Readers.SAX_Entity_Resolver_Access is
   begin
      return Self.Entity_Resolver;
   end Entity_Resolver;

   -------------------
   -- Error_Handler --
   -------------------

   overriding function Error_Handler
    (Self : Simple_Reader) return XML.SAX.Readers.SAX_Error_Handler_Access is
   begin
      if Self.Error_Handler = Default_Handler'Access then
         return null;

      else
         return Self.Error_Handler;
      end if;
   end Error_Handler;

   -------------
   -- Feature --
   -------------

   overriding function Feature
    (Self : Simple_Reader;
     Name : League.Strings.Universal_String)
       return Boolean is
   begin
      if Name = XML.SAX.Constants.Namespaces_Feature then
         return Self.Configuration.Enable_Namespaces;

      elsif Name = XML.SAX.Constants.Namespace_Prefixes_Feature then
         return Self.Configuration.Enable_Prefixes;

      elsif Name = XML.SAX.Constants.Validation_Feature then
         return Self.Configuration.Enable_Validation;

      elsif Name = XML.SAX.Constants.Load_External_DTD_Feature then
         return Self.Configuration.Load_External_DTD;
      end if;

      raise Constraint_Error;
   end Feature;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Simple_Reader) is
      Locator : Matreshka.Internals.SAX_Locators.Shared_Locator_Access
        := Matreshka.Internals.SAX_Locators.Shared_Locator_Access
            (Self.Locator);

   begin
      Self.Locator.Reader := null;
      Self.Locator := null;
      Matreshka.Internals.SAX_Locators.Dereference (Locator);
      Scanner.Finalize (Self);
      Matreshka.Internals.Strings.Dereference (Self.Character_Buffer);
      Matreshka.Internals.Strings.Dereference (Self.Character_Data);
      Matreshka.Internals.XML.Attribute_Tables.Finalize (Self.Attributes);
      Matreshka.Internals.XML.Base_Scopes.Finalize (Self.Bases);
      Matreshka.Internals.XML.Element_Tables.Finalize (Self.Elements);
      Matreshka.Internals.XML.Symbol_Tables.Finalize (Self.Symbols);
      Matreshka.Internals.XML.Entity_Tables.Finalize (Self.Entities);
      Matreshka.Internals.XML.Namespace_Scopes.Finalize (Self.Namespace_Scope);
      Matreshka.Internals.XML.Notation_Tables.Finalize (Self.Notations);
      Matreshka.Internals.XML.Attributes.Finalize (Self.Attribute_Set);
   end Finalize;

   -----------------
   -- Has_Feature --
   -----------------

   overriding function Has_Feature
    (Self : Simple_Reader;
     Name : League.Strings.Universal_String) return Boolean
   is
      pragma Unreferenced (Self);

   begin
      if Name = XML.SAX.Constants.Namespaces_Feature then
         return True;

      elsif Name = XML.SAX.Constants.Namespace_Prefixes_Feature then
         return True;

      elsif Name = XML.SAX.Constants.Validation_Feature then
         return True;

      elsif Name = XML.SAX.Constants.Load_External_DTD_Feature then
         return True;

      else
         return False;
      end if;
   end Has_Feature;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out Simple_Reader) is
   begin
      Matreshka.Internals.XML.Attributes.Initialize (Self.Attribute_Set);
      Matreshka.Internals.XML.Base_Scopes.Initialize (Self.Bases);
      Matreshka.Internals.XML.Namespace_Scopes.Initialize
       (Self.Namespace_Scope);
      Matreshka.Internals.XML.Entity_Tables.Initialize (Self.Entities);
      Matreshka.Internals.XML.Symbol_Tables.Initialize (Self.Symbols);
      XML.SAX.Simple_Readers.Parser.Initialize (Self.Parser_State);

      Self.Character_Buffer := Matreshka.Internals.Strings.Allocate (2);
      --  Preallocate internal buffer for character reference handling. One
      --  Unicode character can be represented in UTF-16 encoding by one or
      --  or two code units, thus preallocate enough space.

      Scanner.Initialize (Self);
      Self.Locator :=
        new Simple_Shared_Locator'
             (Matreshka.Internals.SAX_Locators.Shared_Abstract_Locator with
                Reader => Self'Unchecked_Access);
   end Initialize;

   ---------------------
   -- Lexical_Handler --
   ---------------------

   overriding function Lexical_Handler
    (Self : Simple_Reader) return XML.SAX.Readers.SAX_Lexical_Handler_Access is
   begin
      if Self.Lexical_Handler = Default_Handler'Access then
         return null;

      else
         return Self.Lexical_Handler;
      end if;
   end Lexical_Handler;

   ----------
   -- Line --
   ----------

   overriding function Line
    (Self : not null access constant Simple_Shared_Locator) return Natural is
   begin
      return Self.Reader.Scanner_State.YY_Current_Line;
   end Line;

   ----------
   -- Move --
   ----------

   procedure Move
    (To   : in out YYSType;
     From : in out YYSType) is
   begin
      To.String        := From.String;
      To.Is_Whitespace := From.Is_Whitespace;
      To.Symbol        := From.Symbol;

      From.String        := null;
      From.Is_Whitespace := False;
      From.Symbol        := Matreshka.Internals.XML.No_Symbol;
   end Move;

   -----------
   -- Parse --
   -----------

   procedure Parse
    (Self   : in out Simple_Reader;
     Source : not null access XML.SAX.Input_Sources.SAX_Input_Source'Class) is
   begin
      Self.Set_Input_Source (Source);
      Self.Configuration.Incremental := False;
      Self.Parse;
   end Parse;

   -----------
   -- Parse --
   -----------

   not overriding procedure Parse (Self : in out Simple_Reader) is
   begin
      if Self.Configuration.Reset then
         Reset (Self);
      end if;

      Parser.YYParse (Self);
      Ada.Exceptions.Reraise_Occurrence (Self.User_Exception);
   end Parse;

   ---------------
   -- Public_Id --
   ---------------

   overriding function Public_Id
    (Self : not null access constant Simple_Shared_Locator)
       return League.Strings.Universal_String is
   begin
      return
        League.Strings.Internals.Create
         (Matreshka.Internals.XML.Entity_Tables.Public_Id
           (Self.Reader.Entities, Self.Reader.Scanner_State.Entity));
   end Public_Id;

   -----------
   -- Reset --
   -----------

   procedure Reset (Self : in out Simple_Reader) is
      use Matreshka.Internals.XML;
      use Matreshka.Internals.XML.Entity_Tables;

      Entity : Entity_Identifier;

   begin
      --  Reset reader's state to initial.

      Matreshka.Internals.XML.Attribute_Tables.Reset (Self.Attributes);
      Matreshka.Internals.XML.Base_Scopes.Reset (Self.Bases);
      Matreshka.Internals.XML.Element_Tables.Reset (Self.Elements);
      Matreshka.Internals.XML.Entity_Tables.Reset (Self.Entities);
      Matreshka.Internals.XML.Namespace_Scopes.Reset (Self.Namespace_Scope);
      Matreshka.Internals.XML.Symbol_Tables.Reset (Self.Symbols);
      Matreshka.Internals.XML.Notation_Tables.Reset (Self.Notations);

      Self.Namespaces.Enabled  := Self.Configuration.Enable_Namespaces;
      Self.Namespaces.Prefixes := Self.Configuration.Enable_Prefixes;
      Self.Validation.Enabled  := Self.Configuration.Enable_Validation;
      Self.Validation.Load_DTD := Self.Configuration.Load_External_DTD;
      Self.Validation.Has_DTD  := False;

      if Self.Validation.Enabled then
         --  This feature is always on when validation is on.

         Self.Validation.Load_DTD := True;
      end if;

      Callbacks.Call_Set_Document_Locator (Self);
      Self.Version := XML_1_0;
      New_Document_Entity
       (Self.Entities,
        Self.Configuration.Source.Public_Id,
        Self.Configuration.Source.System_Id,
        Matreshka.Internals.URI_Utilities.Directory_Name
         (Self.Configuration.Source.System_Id),
        Entity);
      Self.Scanner_State :=
       (Entity      => Entity,
        Source      => Self.Configuration.Source,
        Data        => Matreshka.Internals.Strings.Shared_Empty'Access,
        Incremental => Self.Configuration.Incremental,
        others      => <>);
      Self.Parser_State.TOS        := 0;
      Self.Parser_State.Look_Ahead := True;
      Self.Parser_State.Error      := False;
      Scanner.Initialize (Self);

      --  Initialize base URI.

      Matreshka.Internals.XML.Base_Scopes.Push_Scope
       (Self.Bases,
        League.IRIs.From_Universal_String
         (Matreshka.Internals.URI_Utilities.Directory_Name
           (Self.Configuration.Source.System_Id)));

      Self.Configuration.Reset := False;
      Self.Configuration.Source := null;

      Self.In_Document_Content := False;
      Self.Is_Standalone := False;
   end Reset;

   -------------------------
   -- Set_Content_Handler --
   -------------------------

   overriding procedure Set_Content_Handler
    (Self    : in out Simple_Reader;
     Handler : XML.SAX.Readers.SAX_Content_Handler_Access) is
   begin
      if Handler = null then
         Self.Content_Handler := Default_Handler'Access;

      else
         Self.Content_Handler := Handler;
      end if;
   end Set_Content_Handler;

   -----------------------------
   -- Set_Declaration_Handler --
   -----------------------------

   overriding procedure Set_Declaration_Handler
    (Self    : in out Simple_Reader;
     Handler : XML.SAX.Readers.SAX_Declaration_Handler_Access) is
   begin
      if Handler = null then
         Self.Declaration_Handler := Default_Handler'Access;

      else
         Self.Declaration_Handler := Handler;
      end if;
   end Set_Declaration_Handler;

   ---------------------
   -- Set_DTD_Handler --
   ---------------------

   overriding procedure Set_DTD_Handler
    (Self    : in out Simple_Reader;
     Handler : XML.SAX.Readers.SAX_DTD_Handler_Access) is
   begin
      if Handler = null then
         Self.DTD_Handler := Default_Handler'Access;

      else
         Self.DTD_Handler := Handler;
      end if;
   end Set_DTD_Handler;

   -------------------------
   -- Set_Entity_Resolver --
   -------------------------

   overriding procedure Set_Entity_Resolver
    (Self     : in out Simple_Reader;
     Resolver : XML.SAX.Readers.SAX_Entity_Resolver_Access) is
   begin
      Self.Entity_Resolver := Resolver;
   end Set_Entity_Resolver;

   -----------------------
   -- Set_Error_Handler --
   -----------------------

   overriding procedure Set_Error_Handler
    (Self    : in out Simple_Reader;
     Handler : XML.SAX.Readers.SAX_Error_Handler_Access) is
   begin
      if Handler = null then
         Self.Error_Handler := Default_Handler'Access;

      else
         Self.Error_Handler := Handler;
      end if;
   end Set_Error_Handler;

   -----------------
   -- Set_Feature --
   -----------------

   overriding procedure Set_Feature
    (Self  : in out Simple_Reader;
     Name  : League.Strings.Universal_String;
     Value : Boolean) is
   begin
      if Name = XML.SAX.Constants.Namespaces_Feature then
         Self.Configuration.Enable_Namespaces := Value;

      elsif Name = XML.SAX.Constants.Namespace_Prefixes_Feature then
         Self.Configuration.Enable_Prefixes := Value;

      elsif Name = XML.SAX.Constants.Validation_Feature then
         Self.Configuration.Enable_Validation := Value;

      elsif Name = XML.SAX.Constants.Load_External_DTD_Feature then
         Self.Configuration.Load_External_DTD := Value;
      end if;
   end Set_Feature;

   ----------------------
   -- Set_Input_Source --
   ----------------------

   not overriding procedure Set_Input_Source
    (Self   : in out Simple_Reader;
     Source : not null access XML.SAX.Input_Sources.SAX_Input_Source'Class) is
   begin
      Self.Configuration.Source := Source.all'Unchecked_Access;
      Self.Configuration.Incremental := True;
      Self.Configuration.Reset := True;
   end Set_Input_Source;

   -------------------------
   -- Set_Lexical_Handler --
   -------------------------

   overriding procedure Set_Lexical_Handler
    (Self    : in out Simple_Reader;
     Handler : XML.SAX.Readers.SAX_Lexical_Handler_Access) is
   begin
      if Handler = null then
         Self.Lexical_Handler := Default_Handler'Access;

      else
         Self.Lexical_Handler := Handler;
      end if;
   end Set_Lexical_Handler;

   ----------------
   -- Set_String --
   ----------------

   procedure Set_String
    (Item          : in out YYSType;
     String        : League.Strings.Universal_String;
     Is_Whitespace : Boolean)
   is
      pragma Assert (Item.String = null);

   begin
      Item.String        := League.Strings.Internals.Internal (String);
      Item.Is_Whitespace := Is_Whitespace;
      Item.Symbol        := Matreshka.Internals.XML.No_Symbol;
      Matreshka.Internals.Strings.Reference (Item.String);
   end Set_String;

   -------------------------
   -- Set_String_Internal --
   -------------------------

   procedure Set_String_Internal
    (Item          : in out YYSType;
     String        : Matreshka.Internals.Strings.Shared_String_Access;
     Is_Whitespace : Boolean)
   is
      pragma Assert (Item.String = null);

   begin
      Item.String        := String;
      Item.Is_Whitespace := Is_Whitespace;
      Item.Symbol        := Matreshka.Internals.XML.No_Symbol;
   end Set_String_Internal;

   ----------------
   -- Set_Symbol --
   ----------------

   procedure Set_Symbol
    (Item   : in out YYSType;
     Symbol : Matreshka.Internals.XML.Symbol_Identifier)
   is
      pragma Assert (Item.String = null);

   begin
      Item.String        := null;
      Item.Is_Whitespace := False;
      Item.Symbol        := Symbol;
   end Set_Symbol;

   ---------------
   -- System_Id --
   ---------------

   overriding function System_Id
    (Self : not null access constant Simple_Shared_Locator)
       return League.Strings.Universal_String is
   begin
      return
        League.Strings.Internals.Create
         (Matreshka.Internals.XML.Entity_Tables.System_Id
           (Self.Reader.Entities, Self.Reader.Scanner_State.Entity));
   end System_Id;

   -------------
   -- Version --
   -------------

   overriding function Version
    (Self : not null access constant Simple_Shared_Locator)
       return League.Strings.Universal_String is
   begin
      case Self.Reader.Version is
         when XML_1_0 =>
            return League.Strings.To_Universal_String ("1.0");

         when XML_1_1 =>
            return League.Strings.To_Universal_String ("1.1");
      end case;
   end Version;

end XML.SAX.Simple_Readers;
