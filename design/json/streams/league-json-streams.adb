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
with League.Holders;
with League.JSON.Values;

package body League.JSON.Streams is

   procedure Add
    (Self  : not null access JSON_Stream'Class;
     Value : League.JSON.Values.JSON_Value);
   --  Adds value to result.

   procedure Push
    (Self : not null access JSON_Stream'Class;
     Kind : State_Kinds);
   --  Push current state into the stack and initialize new current state.

   procedure Pop (Self : not null access JSON_Stream'Class);
   --  Unwind state stack and add constructed value to new state.

   ---------
   -- Add --
   ---------

   procedure Add
    (Self  : not null access JSON_Stream'Class;
     Value : League.JSON.Values.JSON_Value) is
   begin
      case Self.Current.Kind is
         when Array_State =>
            Self.Current.Current_Array.Append (Value);

         when Object_State =>
            Self.Current.Current_Object.Insert
             (Self.Current.Key, Value);
      end case;
   end Add;

   ---------------
   -- End_Array --
   ---------------

   procedure End_Array (Self : not null access JSON_Stream'Class) renames Pop;

   ----------------
   -- End_Object --
   ----------------

   procedure End_Object (Self : not null access JSON_Stream'Class) renames Pop;

   ---------------------------------------
   -- Generic_Integer_Stream_Operations --
   ---------------------------------------

   package body Generic_Integer_Stream_Operations is

      ----------
      -- Read --
      ----------

      procedure Read
       (Stream : in out JSON_Stream'Class;
        Item   : out T) is
      begin
         raise Program_Error;
      end Read;

      -----------
      -- Write --
      -----------

      procedure Write
       (Stream : in out JSON_Stream'Class;
        Item   : T) is
      begin
         Stream.Add
          (League.JSON.Values.To_JSON_Value
            (League.Holders.Universal_Integer (Item)));
      end Write;

   end Generic_Integer_Stream_Operations;

   -----------------------
   -- Get_JSON_Document --
   -----------------------

   function Get_JSON_Document
    (Self : not null access JSON_Stream'Class)
       return League.JSON.Documents.JSON_Document is
   begin
      return Self.Current.Current_Array.To_JSON_Document;
   end Get_JSON_Document;

   ---------
   -- Key --
   ---------

   procedure Key
    (Self : not null access JSON_Stream'Class;
     Key  : League.Strings.Universal_String) is
   begin
      Self.Current.Key := Key;
   end Key;

   ---------
   -- Pop --
   ---------

   procedure Pop (Self : not null access JSON_Stream'Class) is
      Value : constant League.JSON.Values.JSON_Value
        := (case Self.Current.Kind is
              when Array_State => Self.Current.Current_Array.To_JSON_Value,
              when Object_State => Self.Current.Current_Object.To_JSON_Value);

   begin
      Self.Current := Self.Stack.Last_Element;
      Self.Stack.Delete_Last;
      Self.Add (Value);
   end Pop;

   ----------
   -- Push --
   ----------

   procedure Push
    (Self : not null access JSON_Stream'Class;
     Kind : State_Kinds) is
   begin
      Self.Stack.Append (Self.Current);

      case Kind is
         when Array_State =>
            Self.Current := (Array_State, League.JSON.Arrays.Empty_JSON_Array);
         when Object_State =>
            Self.Current :=
             (Object_State,
              League.JSON.Objects.Empty_JSON_Object,
              League.Strings.Empty_Universal_String);
      end case;
   end Push;

   ----------
   -- Read --
   ----------

   overriding procedure Read
     (Stream : in out JSON_Stream;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset) is
   begin
      raise Program_Error;
   end Read;

   -----------------
   -- Start_Array --
   -----------------

   procedure Start_Array (Self : not null access JSON_Stream'Class) is
   begin
      Self.Push (Array_State);
   end Start_Array;

   ------------------
   -- Start_Object --
   ------------------

   procedure Start_Object (Self : not null access JSON_Stream'Class) is
   begin
      Self.Push (Object_State);
   end Start_Object;

   -----------
   -- Write --
   -----------

   overriding procedure Write
     (Stream : in out JSON_Stream;
      Item   : Ada.Streams.Stream_Element_Array) is
   begin
      raise Program_Error;
   end Write;

end League.JSON.Streams;
