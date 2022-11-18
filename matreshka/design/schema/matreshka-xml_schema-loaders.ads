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
-- Copyright © 2012, Vadim Godunko <vgodunko@gmail.com>                     --
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
private with Ada.Containers.Hashed_Maps;

with League.IRIs;
with League.Strings;
private with League.Strings.Hash;

with Matreshka.XML_Schema.AST;

package Matreshka.XML_Schema.Loaders is

   type Model_Loader is tagged limited private;

   function Load
    (Self : in out Model_Loader'Class;
     URI  : League.Strings.Universal_String)
       return Matreshka.XML_Schema.AST.Model_Access;
   --  Loads complete schema from the specified URI.

   procedure Enqueue_Document
    (Self            : in out Model_Loader'Class;
     Namespace_URI   : League.Strings.Universal_String;
     Base_URI        : League.IRIs.IRI;
     Schema_Location : League.Strings.Universal_String);
   --  Add document to be loaded.

private

   type Document_Record is record
      URI    : League.Strings.Universal_String;
      Hint   : League.Strings.Universal_String;
      Schema : Matreshka.XML_Schema.AST.Schema_Access;
   end record;

   type Document_Access is access all Document_Record;

   package Document_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           Document_Access,
           League.Strings.Hash,
           League.Strings."=");

   type Model_Loader is tagged limited record
      Documents : Document_Maps.Map;
   end record;

end Matreshka.XML_Schema.Loaders;
