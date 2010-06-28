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
-- Copyright © 2010, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Matreshka.SAX.Locators.Internals;
with Matreshka.SAX.Simple_Readers.Handler_Callbacks;
with Matreshka.SAX.Simple_Readers.Parser;
with Matreshka.SAX.Simple_Readers.Scanner;

package body Matreshka.SAX.Simple_Readers is

   use Matreshka.SAX.Readers;

   ---------------------
   -- Content_Handler --
   ---------------------

   overriding function Content_Handler
    (Self : not null access constant SAX_Simple_Reader)
       return Matreshka.SAX.Readers.SAX_Content_Handler_Access is
   begin
      if Self.Content_Handler = Default_Handler'Access then
         return null;

      else
         return Self.Content_Handler;
      end if;
   end Content_Handler;

   ------------------
   -- Decl_Handler --
   ------------------

   overriding function Decl_Handler
    (Self : not null access constant SAX_Simple_Reader)
       return Matreshka.SAX.Readers.SAX_Decl_Handler_Access is
   begin
      if Self.Decl_Handler = Default_Handler'Access then
         return null;

      else
         return Self.Decl_Handler;
      end if;
   end Decl_Handler;

   -----------------
   -- DTD_Handler --
   -----------------

   overriding function DTD_Handler
    (Self : not null access constant SAX_Simple_Reader)
       return Matreshka.SAX.Readers.SAX_DTD_Handler_Access is
   begin
      if Self.DTD_Handler = Default_Handler'Access then
         return null;

      else
         return Self.DTD_Handler;
      end if;
   end DTD_Handler;

   ---------------------
   -- Entity_Resolver --
   ---------------------

   overriding function Entity_Resolver
    (Self : not null access constant SAX_Simple_Reader)
       return Matreshka.SAX.Readers.SAX_Entity_Resolver_Access is
   begin
      return Self.Entity_Resolver;
   end Entity_Resolver;

   -------------------
   -- Error_Handler --
   -------------------

   overriding function Error_Handler
    (Self : not null access constant SAX_Simple_Reader)
       return Matreshka.SAX.Readers.SAX_Error_Handler_Access is
   begin
      if Self.Error_Handler = Default_Handler'Access then
         return null;

      else
         return Self.Error_Handler;
      end if;
   end Error_Handler;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out SAX_Simple_Reader) is
   begin
      Matreshka.Internals.XML.Symbol_Tables.Finalize (Self.Symbols);
   end Finalize;

   ----------
   -- Hash --
   ----------

   function Hash
    (Item : League.Strings.Universal_String) return Ada.Containers.Hash_Type
   is
      pragma Assert
       (Ada.Containers.Hash_Type'Modulus = League.Strings.Hash_Type'Modulus);
      --  This implementation assume both types are modular and have same
      --  modulus.

   begin
      return Ada.Containers.Hash_Type (Item.Hash);
   end Hash;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out SAX_Simple_Reader) is
   begin
      Matreshka.Internals.XML.Symbol_Tables.Initialize (Self.Symbols);
   end Initialize;

   ---------------------
   -- Lexical_Handler --
   ---------------------

   overriding function Lexical_Handler
    (Self : not null access constant SAX_Simple_Reader)
       return Matreshka.SAX.Readers.SAX_Lexical_Handler_Access is
   begin
      if Self.Lexical_Handler = Default_Handler'Access then
         return null;

      else
         return Self.Lexical_Handler;
      end if;
   end Lexical_Handler;

   -----------
   -- Parse --
   -----------

   procedure Parse
    (Self : not null access SAX_Simple_Reader;
     Data : League.Strings.Universal_String) is
   begin
      Matreshka.SAX.Locators.Internals.Set_Location
       (Self.Locator, Self.YY_Base_Line, Self.YY_Base_Column);
      Handler_Callbacks.Call_Set_Document_Locator (Self, Self.Locator);
      Self.Scanner_State.Data := League.Strings.Internals.Get_Shared (Data);
--      Self.Validation := (others => True);
      Parser.YYParse (Self);
      Ada.Exceptions.Reraise_Occurrence (Self.User_Exception);
   end Parse;

   -------------------------
   -- Set_Content_Handler --
   -------------------------

   overriding procedure Set_Content_Handler
    (Self    : not null access SAX_Simple_Reader;
     Handler : Matreshka.SAX.Readers.SAX_Content_Handler_Access) is
   begin
      if Handler = null then
         Self.Content_Handler := Default_Handler'Access;

      else
         Self.Content_Handler := Handler;
      end if;
   end Set_Content_Handler;

   ----------------------
   -- Set_Decl_Handler --
   ----------------------

   overriding procedure Set_Decl_Handler
    (Self    : not null access SAX_Simple_Reader;
     Handler : Matreshka.SAX.Readers.SAX_Decl_Handler_Access) is
   begin
      if Handler = null then
         Self.Decl_Handler := Default_Handler'Access;

      else
         Self.Decl_Handler := Handler;
      end if;
   end Set_Decl_Handler;

   ---------------------
   -- Set_DTD_Handler --
   ---------------------

   overriding procedure Set_DTD_Handler
    (Self    : not null access SAX_Simple_Reader;
     Handler : Matreshka.SAX.Readers.SAX_DTD_Handler_Access) is
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
    (Self     : not null access SAX_Simple_Reader;
     Resolver : Matreshka.SAX.Readers.SAX_Entity_Resolver_Access) is
   begin
      Self.Entity_Resolver := Resolver;
   end Set_Entity_Resolver;

   -----------------------
   -- Set_Error_Handler --
   -----------------------

   overriding procedure Set_Error_Handler
    (Self    : not null access SAX_Simple_Reader;
     Handler : Matreshka.SAX.Readers.SAX_Error_Handler_Access) is
   begin
      if Handler = null then
         Self.Error_Handler := Default_Handler'Access;

      else
         Self.Error_Handler := Handler;
      end if;
   end Set_Error_Handler;

   -------------------------
   -- Set_Lexical_Handler --
   -------------------------

   overriding procedure Set_Lexical_Handler
    (Self    : not null access SAX_Simple_Reader;
     Handler : Matreshka.SAX.Readers.SAX_Lexical_Handler_Access) is
   begin
      if Handler = null then
         Self.Lexical_Handler := Default_Handler'Access;

      else
         Self.Lexical_Handler := Handler;
      end if;
   end Set_Lexical_Handler;

   use Matreshka.Internals.Strings;

   ----------------
   -- Set_String --
   ----------------

   procedure Set_String
    (Item          : in out YYSType;
     String        : League.Strings.Universal_String;
     Is_Whitespace : Boolean;
     Is_CData      : Boolean)
   is
      pragma Assert (Item.String = null);

   begin
      Item.String        := League.Strings.Internals.Get_Shared (String);
      Item.Is_Whitespace := Is_Whitespace;
      Item.Is_CData      := Is_CData;
      Item.Symbol        := Matreshka.Internals.XML.Symbol_Tables.No_Symbol;
      Matreshka.Internals.Strings.Reference (Item.String);
   end Set_String;

   -------------------------
   -- Set_String_Internal --
   -------------------------

   procedure Set_String_Internal
    (Item          : in out YYSType;
     String        : Matreshka.Internals.Strings.Shared_String_Access;
     Is_Whitespace : Boolean;
     Is_CData      : Boolean)
   is
      pragma Assert (Item.String = null);

   begin
      Item.String        := String;
      Item.Is_Whitespace := Is_Whitespace;
      Item.Is_CData      := Is_CData;
      Item.Symbol        := Matreshka.Internals.XML.Symbol_Tables.No_Symbol;
   end Set_String_Internal;

   ----------------
   -- Set_Symbol --
   ----------------

   procedure Set_Symbol
    (Item    : in out YYSType;
      Symbol : Matreshka.Internals.XML.Symbol_Tables.Symbol_Identifier)
   is
      pragma Assert (Item.String = null);

   begin
      Item.String        := null;
      Item.Is_Whitespace := False;
      Item.Is_CData      := False;
      Item.Symbol        := Symbol;
   end Set_Symbol;

   ----------
   -- Move --
   ----------

   procedure Move
    (To   : in out YYSType;
     From : in out YYSType) is
   begin
      To.String        := From.String;
      To.Is_Whitespace := From.Is_Whitespace;
      To.Is_CData      := From.Is_CData;
      To.Symbol        := From.Symbol;

      From.String        := null;
      From.Is_Whitespace := False;
      From.Is_CData      := False;
      From.Symbol        := Matreshka.Internals.XML.Symbol_Tables.No_Symbol;
   end Move;

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
      Item.Is_CData      := False;
      Item.Symbol        := Matreshka.Internals.XML.Symbol_Tables.No_Symbol;
   end Clear;

end Matreshka.SAX.Simple_Readers;
