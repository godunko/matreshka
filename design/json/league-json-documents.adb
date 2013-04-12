------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
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
with League.JSON.Arrays.Internals;
with League.JSON.Objects.Internals;
with Matreshka.JSON_Parser;
with Matreshka.JSON_Types;

package body League.JSON.Documents is

   use type Matreshka.JSON_Types.Shared_JSON_Array_Access;
   use type Matreshka.JSON_Types.Shared_JSON_Object_Access;

--   function To_JSON_Document
--    (Value : League.JSON.Arrays.JSON_Array) return JSON_Document;
--   function To_JSON_Document
--    (Value : League.JSON.Objects.JSON_Object) return JSON_Document;

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out JSON_Document) is
   begin
      Matreshka.JSON_Documents.Reference (Self.Data);
   end Adjust;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out JSON_Document) is
      use type Matreshka.JSON_Documents.Shared_JSON_Document_Access;

   begin
      --  Finalize can be called more than once (as specified by language
      --  standard), thus implementation should provide protection from
      --  multiple finalization.

      if Self.Data /= null then
         Matreshka.JSON_Documents.Dereference (Self.Data);
      end if;
   end Finalize;

   ---------------
   -- From_JSON --
   ---------------

   function From_JSON
    (Data : League.Stream_Element_Vectors.Stream_Element_Vector)
       return JSON_Document is
   begin
      --  Parses an encoded JSON document and creates a JSON_Document from it.
      --  Data can be encoded using UTF-8, UTF-16 and UTF-32 encoding. Encoding
      --  is detected automatically accroding to RFC-4627.

      raise Program_Error;
      return Empty_JSON_Document;
   end From_JSON;

   ---------------
   -- From_JSON --
   ---------------

   function From_JSON
    (Data : League.Strings.Universal_String) return JSON_Document
   is
      Result  : League.JSON.Documents.JSON_Document;
      Success : Boolean;

   begin
      Matreshka.JSON_Parser.Parse (Data, Result, Success);

      if Success then
         return Result;

      else
         return Empty_JSON_Document;
      end if;
   end From_JSON;

   --------------
   -- Is_Array --
   --------------

   function Is_Array (Self : JSON_Document'Class) return Boolean is
   begin
      return Self.Data.Array_Value /= null;
   end Is_Array;

   --------------
   -- Is_Empty --
   --------------

   function Is_Empty (Self : JSON_Document'Class) return Boolean is
   begin
      return Self.Data.Array_Value = null and Self.Data.Object_Value = null;
   end Is_Empty;

   ---------------
   -- Is_Object --
   ---------------

   function Is_Object (Self : JSON_Document'Class) return Boolean is
   begin
      return Self.Data.Object_Value /= null;
   end Is_Object;

   ---------------
   -- Set_Array --
   ---------------

   procedure Set_Array
    (Self  : in out JSON_Document'Class;
     Value : League.JSON.Arrays.JSON_Array) is
   begin
      Matreshka.JSON_Documents.Mutate (Self.Data);

      --  Cleanup.

      if Self.Data.Array_Value /= null then
         Matreshka.JSON_Types.Dereference (Self.Data.Array_Value);
      end if;

      if Self.Data.Object_Value /= null then
         Matreshka.JSON_Types.Dereference (Self.Data.Object_Value);
      end if;

      --  Set new value.

      Self.Data.Array_Value := League.JSON.Arrays.Internals.Internal (Value);
      Matreshka.JSON_Types.Reference (Self.Data.Array_Value);
   end Set_Array;

   ----------------
   -- Set_Object --
   ----------------

   procedure Set_Object
    (Self  : in out JSON_Document'Class;
     Value : League.JSON.Objects.JSON_Object) is
   begin
      Matreshka.JSON_Documents.Mutate (Self.Data);

      --  Cleanup.

      if Self.Data.Array_Value /= null then
         Matreshka.JSON_Types.Dereference (Self.Data.Array_Value);
      end if;

      if Self.Data.Object_Value /= null then
         Matreshka.JSON_Types.Dereference (Self.Data.Object_Value);
      end if;

      --  Set new value.

      Self.Data.Object_Value := League.JSON.Objects.Internals.Internal (Value);
      Matreshka.JSON_Types.Reference (Self.Data.Object_Value);
   end Set_Object;

   --------------
   -- To_Array --
   --------------

   function To_Array
    (Self : JSON_Document'Class) return League.JSON.Arrays.JSON_Array is
   begin
      if Self.Data.Array_Value /= null then
         return League.JSON.Arrays.Internals.Create (Self.Data.Array_Value);

      else
         return League.JSON.Arrays.Empty_JSON_Array;
      end if;
   end To_Array;

   -------------
   -- To_JSON --
   -------------

   function To_JSON
    (Self     : JSON_Document'Class;
     Encoding : JSON_Encoding := UTF8)
       return League.Stream_Element_Vectors.Stream_Element_Vector is
   begin
      --  Converts the JSON_Document to an encoded JSON document. Encoding can
      --  be selected by Encoding parameter.

      raise Program_Error;
      return League.Stream_Element_Vectors.Empty_Stream_Element_Vector;
   end To_JSON;

   -------------
   -- To_JSON --
   -------------

   function To_JSON
    (Self : JSON_Document'Class) return League.Strings.Universal_String is
   begin
      --  Converts the JSON_Document to an encoded JSON document.

      raise Program_Error;
      return League.Strings.Empty_Universal_String;
   end To_JSON;

   ---------------
   -- To_Object --
   ---------------

   function To_Object
    (Self : JSON_Document'Class) return League.JSON.Objects.JSON_Object is
   begin
      if Self.Data.Object_Value /= null then
         return League.JSON.Objects.Internals.Create (Self.Data.Object_Value);

      else
         return League.JSON.Objects.Empty_JSON_Object;
      end if;
   end To_Object;

end League.JSON.Documents;
