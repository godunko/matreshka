------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                              Tools Component                             --
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
with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Simple_Readers;

package body XSD_To_Ada.Mappings.XML is

   Map_Tag : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("map");
   Ada_Tag : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("ada");

   Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("type");

   -----------------
   -- End_Element --
   -----------------

   overriding procedure End_Element
    (Self           : in out Mapping_XML;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean) is
   begin
      null;
   end End_Element;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : Mapping_XML) return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   ------------------
   -- Read_Mapping --
   ------------------

   function Read_Mapping
    (File_Name : League.Strings.Universal_String)
       return XSD_To_Ada.Mappings.XML.Mapping_XML
   is
      Source  : aliased
        Standard.XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
      Reader  : aliased Standard.XML.SAX.Simple_Readers.SAX_Simple_Reader;
      Handler : aliased XSD_To_Ada.Mappings.XML.Mapping_XML;

   begin
      Reader.Set_Content_Handler (Handler'Unchecked_Access);
      Source.Open_By_File_Name (File_Name);
      Reader.Parse (Source'Access);

      return Handler;
   end Read_Mapping;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out Mapping_XML;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : Standard.XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean)
   is
      use type League.Strings.Universal_String;

   begin
      if Qualified_Name = Map_Tag then
         Self.Current := Attributes.Value (Type_Attribute);

      elsif Qualified_Name = Ada_Tag then
         if Self.Mapping.Contains (Self.Current) then
            raise Constraint_Error
              with "Duplicate mapping for '"
                     & Self.Current.To_UTF_8_String & ''';

         else
            Self.Mapping.Insert
             (Self.Current, (Ada_Name => Attributes.Value (Type_Attribute)));
         end if;
      end if;
   end Start_Element;

end XSD_To_Ada.Mappings.XML;