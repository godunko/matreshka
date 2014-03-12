------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Open Document Toolkit                           --
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
with GNAT.Expect;

with Matreshka.DOM_Builders;
with Matreshka.DOM_Nodes;
with XML.DOM.Documents;
with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Simple_Readers;

with Matreshka.ODF_Packages;

package body ODF.Packages is

   procedure Load_XML_File
    (The_Package : not null ODF.DOM.Packages.ODF_Package_Access;
     File_Name   : League.Strings.Universal_String);

   ----------
   -- Load --
   ----------

   function Load
    (File_Name : League.Strings.Universal_String)
       return ODF.DOM.Packages.ODF_Package_Access
   is
      use type League.Strings.Universal_String;

      Result : constant Matreshka.DOM_Nodes.Node_Access
        := new Matreshka.ODF_Packages.Package_Node;
      Temp   : constant League.Strings.Universal_String
        := League.Strings.To_Universal_String ("tmp/document");

   begin
      Matreshka.ODF_Packages.Constructors.Initialize
       (Matreshka.ODF_Packages.Package_Node (Result.all)'Unchecked_Access);

      --  Unpack ZIP archive.

      declare
         Status : aliased Integer;
         Output : constant String
           := GNAT.Expect.Get_Command_Output
               ("unzip",
                (1 => new String'("-o"),
                 2 => new String'(File_Name.To_UTF_8_String),
                 3 => new String'("-d"),
                 4 => new String'(Temp.To_UTF_8_String)),
                "",
                Status'Access,
                True);

      begin
         if Status /= 0 then
            raise Program_Error;
         end if;
      end;

      Load_XML_File (ODF.DOM.Packages.ODF_Package_Access (Result), Temp & "/styles.xml");
      Load_XML_File (ODF.DOM.Packages.ODF_Package_Access (Result), Temp & "/content.xml");

      return ODF.DOM.Packages.ODF_Package_Access (Result);
   end Load;

   -------------------
   -- Load_XML_File --
   -------------------

   procedure Load_XML_File
    (The_Package : not null ODF.DOM.Packages.ODF_Package_Access;
     File_Name   : League.Strings.Universal_String)
   is
      Input   : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
      Builder : aliased Matreshka.DOM_Builders.DOM_Builder;
      Reader  : XML.SAX.Simple_Readers.SAX_Simple_Reader;

   begin
      Builder.Set_Document (XML.DOM.Documents.DOM_Document_Access (The_Package));
      Reader.Set_Content_Handler (Builder'Unchecked_Access);
      Input.Open_By_File_Name (File_Name);
      Reader.Parse (Input'Unchecked_Access);
   end Load_XML_File;

end ODF.Packages;
