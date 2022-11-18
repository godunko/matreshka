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
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
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

private with League.IRIs;
private with League.Strings;
private with Matreshka.Internals.SAX_Locators;
with XML.SAX.Readers;
with XML.Templates.Streams;

package XML.SAX.Event_Readers is

   pragma Preelaborate;

   type Event_Reader is limited new XML.SAX.Readers.SAX_Reader with private;

   procedure Parse
    (Self   : in out Event_Reader'Class;
     Stream : XML.Templates.Streams.XML_Stream_Element_Vectors.Vector);

private

   type Event_Reader_Shared_Locator is
     new Matreshka.Internals.SAX_Locators.Shared_Abstract_Locator with record
      System_Id : League.Strings.Universal_String;
      Line      : Natural;
      Column    : Natural;
   end record;

   type Event_Reader_Shared_Locator_Access is
     access all Event_Reader_Shared_Locator'Class;

   overriding function Line
    (Self : not null access constant Event_Reader_Shared_Locator)
       return Natural;

   overriding function Column
    (Self : not null access constant Event_Reader_Shared_Locator)
       return Natural;

   overriding function Encoding
    (Self : not null access constant Event_Reader_Shared_Locator)
       return League.Strings.Universal_String;

   overriding function Version
    (Self : not null access constant Event_Reader_Shared_Locator)
       return League.Strings.Universal_String;

   overriding function Public_Id
    (Self : not null access constant Event_Reader_Shared_Locator)
       return League.Strings.Universal_String;

   overriding function System_Id
    (Self : not null access constant Event_Reader_Shared_Locator)
       return League.Strings.Universal_String;

   overriding function Base_URI
    (Self : not null access constant Event_Reader_Shared_Locator)
       return League.IRIs.IRI;

   type Event_Reader is
     limited new Ada.Finalization.Limited_Controlled
       and XML.SAX.Readers.SAX_Reader with
   record
      Error_Handler   : XML.SAX.Readers.SAX_Error_Handler_Access;
      Content_Handler : XML.SAX.Readers.SAX_Content_Handler_Access;
      Lexical_Handler : XML.SAX.Readers.SAX_Lexical_Handler_Access;
      Locator         : Event_Reader_Shared_Locator_Access
        := new Event_Reader_Shared_Locator;
   end record;

   overriding procedure Finalize (Self : in out Event_Reader);

   overriding function Content_Handler
    (Self : Event_Reader) return XML.SAX.Readers.SAX_Content_Handler_Access;

   overriding function Declaration_Handler
    (Self : Event_Reader)
       return XML.SAX.Readers.SAX_Declaration_Handler_Access;

   overriding function DTD_Handler
    (Self : Event_Reader) return XML.SAX.Readers.SAX_DTD_Handler_Access;

   overriding function Entity_Resolver
    (Self : Event_Reader) return XML.SAX.Readers.SAX_Entity_Resolver_Access;

   overriding function Error_Handler
    (Self : Event_Reader) return XML.SAX.Readers.SAX_Error_Handler_Access;

   overriding function Feature
    (Self : Event_Reader;
     Name : League.Strings.Universal_String) return Boolean;

   overriding function Has_Feature
    (Self : Event_Reader;
     Name : League.Strings.Universal_String) return Boolean;

   overriding function Lexical_Handler
    (Self : Event_Reader) return XML.SAX.Readers.SAX_Lexical_Handler_Access;

   overriding procedure Set_Content_Handler
    (Self    : in out Event_Reader;
     Handler : XML.SAX.Readers.SAX_Content_Handler_Access);

   overriding procedure Set_Declaration_Handler
    (Self    : in out Event_Reader;
     Handler : XML.SAX.Readers.SAX_Declaration_Handler_Access);

   overriding procedure Set_DTD_Handler
    (Self    : in out Event_Reader;
     Handler : XML.SAX.Readers.SAX_DTD_Handler_Access);

   overriding procedure Set_Entity_Resolver
    (Self     : in out Event_Reader;
     Resolver : XML.SAX.Readers.SAX_Entity_Resolver_Access);

   overriding procedure Set_Error_Handler
    (Self    : in out Event_Reader;
     Handler : XML.SAX.Readers.SAX_Error_Handler_Access);

   overriding procedure Set_Feature
    (Self  : in out Event_Reader;
     Name  : League.Strings.Universal_String;
     Value : Boolean);

   overriding procedure Set_Lexical_Handler
    (Self    : in out Event_Reader;
     Handler : XML.SAX.Readers.SAX_Lexical_Handler_Access);

end XML.SAX.Event_Readers;
