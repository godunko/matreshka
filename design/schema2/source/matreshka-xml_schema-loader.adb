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
with Ada.Containers.Vectors;

with League.Strings;
with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Simple_Readers;

with Matreshka.XML_Schema.AST.Models;
with Matreshka.XML_Schema.Document_Parsers;

package body Matreshka.XML_Schema.Loader is

   type Schema_Document_Information is record
      Location : League.Strings.Universal_String;
      Schema   : Matreshka.XML_Schema.AST.Schema_Access;
   end record;

   package Schema_Document_Vectors is
     new Ada.Containers.Vectors (Positive, Schema_Document_Information);

   ---------------------------
   -- Load_XML_Schema_Model --
   ---------------------------

   function Load_XML_Schema_Model
    (File_Name     : League.Strings.Universal_String;
     Error_Handler :
       not null access XML.SAX.Error_Handlers.SAX_Error_Handler'Class)
         return not null Matreshka.XML_Schema.AST.Model_Access
   is
      Model  : constant Matreshka.XML_Schema.AST.Model_Access
        := new Matreshka.XML_Schema.AST.Models.Model_Node;
      Input  : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
      Reader : aliased XML.SAX.Simple_Readers.SAX_Simple_Reader;
      Parser :
        aliased Matreshka.XML_Schema.Document_Parsers.Document_Parser (Model);

   begin
      Reader.Set_Content_Handler (Parser'Unchecked_Access);
      Reader.Set_Error_Handler (Error_Handler);
      Input.Open_By_File_Name (File_Name);
      Reader.Parse (Input'Unchecked_Access);

      return Model;
   end Load_XML_Schema_Model;

end Matreshka.XML_Schema.Loader;
