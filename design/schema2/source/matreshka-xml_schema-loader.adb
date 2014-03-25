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
with Ada.IO_Exceptions;

with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Parse_Exceptions.Internals;
with XML.SAX.Simple_Readers;

with Matreshka.XML_Schema.AST.Models;
with Matreshka.XML_Schema.Document_Parsers;
with Matreshka.XML_Schema.Namespace_Builders;

package body Matreshka.XML_Schema.Loader is

   function Load_XML_Schema_Documents
    (File_Name     : League.Strings.Universal_String;
     Error_Handler :
       not null access XML.SAX.Error_Handlers.SAX_Error_Handler'Class)
         return not null Matreshka.XML_Schema.AST.Model_Access;
   --  Loads set of XML Schema documents to build model.

   procedure Build_Namespaces
    (Model : not null Matreshka.XML_Schema.AST.Model_Access);
   --  Builds namespaces from loaded XML Schema documents.

   ----------------------
   -- Build_Namespaces --
   ----------------------

   procedure Build_Namespaces
    (Model : not null Matreshka.XML_Schema.AST.Model_Access)
   is
      Processor : Matreshka.XML_Schema.Namespace_Builders.Namespace_Builder;

   begin
      for Namespace of Model.Namespaces loop
         Processor.Analyze (Namespace.Namespace, Namespace.Schema);
      end loop;
   end Build_Namespaces;

   -------------------------------
   -- Load_XML_Schema_Documents --
   -------------------------------

   function Load_XML_Schema_Documents
    (File_Name     : League.Strings.Universal_String;
     Error_Handler :
       not null access XML.SAX.Error_Handlers.SAX_Error_Handler'Class)
         return not null Matreshka.XML_Schema.AST.Model_Access
   is
      use type Matreshka.XML_Schema.AST.Schema_Access;
      use type Matreshka.XML_Schema.AST.Models.Schema_Document_Info_Access;

      Model    : constant Matreshka.XML_Schema.AST.Model_Access
        := new Matreshka.XML_Schema.AST.Models.Model_Node;
      Input    : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
      Reader   : aliased XML.SAX.Simple_Readers.SAX_Simple_Reader;
      Parser   :
        aliased Matreshka.XML_Schema.Document_Parsers.Document_Parser (Model);
      Info     : Matreshka.XML_Schema.AST.Models.Schema_Document_Info_Access;
      Success  : Boolean := True;

   begin
      Reader.Set_Content_Handler (Parser'Unchecked_Access);
      Reader.Set_Error_Handler (Error_Handler);
      Input.Open_By_File_Name (File_Name);
      Reader.Parse (Input'Unchecked_Access);
      Input.Close;

      loop
         Info := null;

         for Item of Model.Schema_Documents loop
            if not Item.Is_Loaded then
               Info := Item;
               Info.Is_Loaded := True;
               Info.Is_Resolved := False;

               exit;
            end if;
         end loop;

         exit when Info = null;

         begin
            Input.Open_By_URI (Info.Location);
            Info.Is_Resolved := True;

         exception
            when Ada.IO_Exceptions.Name_Error =>
               Error_Handler.Warning
                (XML.SAX.Parse_Exceptions.Internals.Create
                  (League.Strings.Empty_Universal_String,
                   Info.Location,
                   0,
                   0,
                   League.Strings.To_Universal_String
                    ("schema document is not resolved")),
                 Success);
         end;

         if Info.Is_Resolved then
            Reader.Parse (Input'Unchecked_Access);
            Input.Close;
         end if;
      end loop;

      return Model;
   end Load_XML_Schema_Documents;

   ---------------------------
   -- Load_XML_Schema_Model --
   ---------------------------

   function Load_XML_Schema_Model
    (File_Name     : League.Strings.Universal_String;
     Error_Handler :
       not null access XML.SAX.Error_Handlers.SAX_Error_Handler'Class)
         return not null Matreshka.XML_Schema.AST.Model_Access
   is
      Model : constant Matreshka.XML_Schema.AST.Model_Access
        := Load_XML_Schema_Documents (File_Name, Error_Handler);

   begin
      Build_Namespaces (Model);

      return Model;
   end Load_XML_Schema_Model;

end Matreshka.XML_Schema.Loader;
