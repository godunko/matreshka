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
private with Ada.Finalization;

with League.JSON.Arrays;
with League.JSON.Objects;
with League.Stream_Element_Vectors;

package League.JSON.Documents is

   pragma Preelaborate;

   type JSON_Document is tagged private;

   function To_JSON_Document
    (Value : League.JSON.Arrays.JSON_Array) return JSON_Document;
   function To_JSON_Document
    (Value : League.JSON.Objects.JSON_Object) return JSON_Document;

   function From_JSON
    (JSON : League.Stream_Element_Vectors.Stream_Element_Vector)
       return JSON_Document;
   --  Parses a UTF-8 encoded JSON document and creates a JSON_Document from
   --  it.

   function To_JSON
    (Self : JSON_Document'Class)
       return League.Stream_Element_Vectors.Stream_Element_Vector;
   --  Converts the JSON_Document to a UTF-8 encoded JSON document.

   function Is_Array (Self : JSON_Document'Class) return Boolean;
   --  Returns true if the document contains an array.

   function Is_Empty (Self : JSON_Document'Class) return Boolean;
   --  Returns true if the document doesn't contain any data.

   function Is_Object (Self : JSON_Document'Class) return Boolean;
   --  Returns true if the document contains an object.

   procedure Set_Array
    (Self  : in out JSON_Document'Class;
     Value : League.JSON.Arrays.JSON_Array);
   --  Sets array as the main object of this document.

   procedure Set_Object
    (Self  : in out JSON_Document'Class;
     Value : League.JSON.Objects.JSON_Object);
   --  Sets object as the main object of this document.

   function To_Array
    (Self : JSON_Document'Class) return League.JSON.Arrays.JSON_Array;
   --  Returns the JSON_Array contained in the document.
   --
   --  Returns an empty array if the document contains an object.

   function To_Object
    (Self : JSON_Document'Class) return League.JSON.Objects.JSON_Object;
   --  Returns the JSON_Object contained in the document.
   --
   --  Returns an empty object if the document contains an array.

private

   type JSON_Document is new Ada.Finalization.Controlled with record
      null;
   end record;

end League.JSON.Documents;
