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
private with Ada.Containers.Hashed_Maps;

with League.Holders;
with League.Strings;
private with League.Strings.Hash;
private with XML.SAX.Attributes;
with XML.SAX.Content_Handlers;
with XML.SAX.Lexical_Handlers;
with XML.SAX.Readers;
private with XML.Utilities.Namespace_Supports;

private with XML.Templates.Streams;

package XML.Templates.Processors is

   type Template_Processor is
     limited new XML.SAX.Content_Handlers.SAX_Content_Handler
       and XML.SAX.Lexical_Handlers.SAX_Lexical_Handler with private;

   procedure Set_Content_Handler
    (Self    : in out Template_Processor'Class;
     Handler : XML.SAX.Readers.SAX_Content_Handler_Access);

   procedure Set_Lexical_Handler
    (Self    : in out Template_Processor'Class;
     Handler : XML.SAX.Readers.SAX_Lexical_Handler_Access);

   procedure Set_Parameter
    (Self  : in out Template_Processor'Class;
     Name  : League.Strings.Universal_String;
     Value : League.Holders.Holder);

private

   package String_Holder_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           League.Holders.Holder,
           League.Strings.Hash,
           League.Strings."=",
           League.Holders."=");

   type Template_Processor is
     limited new XML.SAX.Content_Handlers.SAX_Content_Handler
       and XML.SAX.Lexical_Handlers.SAX_Lexical_Handler with record
      Diagnosis        : League.Strings.Universal_String;
      Content_Handler  : XML.SAX.Readers.SAX_Content_Handler_Access;
      Lexical_Handler  : XML.SAX.Readers.SAX_Lexical_Handler_Access;
      Namespaces       : XML.Utilities.Namespace_Supports.XML_Namespace_Support;
      Parameters       : String_Holder_Maps.Map;
      Stream           : XML.Templates.Streams.XML_Stream_Element_Vectors.Vector;
      Accumulate       : Natural := 0;
      Accumulated_Text : League.Strings.Universal_String;
      --  Character data is accumulated in this member to simplify processing.
      Object_Name      : League.Strings.Universal_String;
      Container_Name   : League.Strings.Universal_String;
   end record;

   --  Override SAX event handling subprogram.

   overriding procedure Characters
    (Self    : in out Template_Processor;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean);

   overriding procedure Comment
    (Self    : in out Template_Processor;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean);

   overriding procedure End_CDATA
    (Self    : in out Template_Processor;
     Success : in out Boolean);

   overriding procedure End_DTD
    (Self    : in out Template_Processor;
     Success : in out Boolean);

   overriding procedure End_Element
    (Self           : in out Template_Processor;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean);

   overriding procedure End_Prefix_Mapping
    (Self    : in out Template_Processor;
     Prefix  : League.Strings.Universal_String;
     Success : in out Boolean);

   overriding function Error_String
    (Self : Template_Processor) return League.Strings.Universal_String;

   overriding procedure Ignorable_Whitespace
    (Self    : in out Template_Processor;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) renames Characters;

   overriding procedure Processing_Instruction
    (Self    : in out Template_Processor;
     Target  : League.Strings.Universal_String;
     Data    : League.Strings.Universal_String;
     Success : in out Boolean);

   overriding procedure Start_CDATA
    (Self    : in out Template_Processor;
     Success : in out Boolean);

   overriding procedure Start_DTD
    (Self      : in out Template_Processor;
     Name      : League.Strings.Universal_String;
     Public_Id : League.Strings.Universal_String;
     System_Id : League.Strings.Universal_String;
     Success   : in out Boolean);

   overriding procedure Start_Element
    (Self           : in out Template_Processor;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean);

   overriding procedure Start_Prefix_Mapping
    (Self          : in out Template_Processor;
     Prefix        : League.Strings.Universal_String;
     Namespace_URI : League.Strings.Universal_String;
     Success       : in out Boolean);

--   not overriding procedure End_Document
--    (Self    : in out SAX_Content_Handler;
--     Success : in out Boolean) is null;
--   --  The reader calls this subprogram after it has finished parsing. It is
--   --  called just once, and is the last subprogram called. It is called after
--   --  the reader has read all input or has abandoned parsing because of fatal
--   --  error.
--   --
--   --  If this subprogram sets Success to False the reader stops parsing and
--   --  reports an error. The reader uses the function Error_String to get the
--   --  error message.

--   not overriding procedure Set_Document_Locator
--    (Self    : in out SAX_Content_Handler;
--     Locator : XML.SAX.Locators.SAX_Locator) is null;
--   --  The reader calls this subprogram before is starts parsing the document.
--   --  Argument Locator is object which allows the application to get the
--   --  parsing position within the document.
--   --
--   --  The locator allows the application to determine the end position of any
--   --  document-related event, even if the parser is not reporting an error.
--   --  Typically, the application will use this information for reporting its
--   --  own errors (such as character content that does not match an
--   --  application's business rules). The information returned by the locator
--   --  is probably not sufficient for use with a search engine.
--   --
--   --  Note that the locator will return correct information only during the
--   --  invocation SAX event callbacks after Start_Document returns and before
--   --  End_Document is called. The application should not attempt to use it at
--   --  any other time.
--
--   not overriding procedure Skipped_Entity
--    (Self    : in out SAX_Content_Handler;
--     Name    : League.Strings.Universal_String;
--     Success : in out Boolean) is null;
--   --  Some readers may skip entities if they have not seen the declaration.
--   --  If they do so they report that they skipped the entity called Name by
--   --  calling this subprogram.
--   --
--   --  This is not called for entity references within markup constructs such
--   --  as element start tags or markup declarations. (The XML recommendation
--   --  requires reporting skipped external entities. SAX also reports internal
--   --  entity expansion/non-expansion, except within markup constructs.)
--   --
--   --  Non-validating processors may skip entities if they have not seen the
--   --  declarations (because, for example, the entity was declared in an
--   --  external DTD subset). All processors may skip external entities,
--   --  depending on the values of the
--   --  http://xml.org/sax/features/external-general-entities and the
--   --  http://xml.org/sax/features/external-parameter-entities properties.
--   --
--   --  If this subprogram sets Success to False the reader stops parsing and
--   --  reports an error. The reader uses the function Error_String to get the
--   --  error message.
--
--   not overriding procedure Start_Document
--    (Self    : in out SAX_Content_Handler;
--     Success : in out Boolean) is null;
--   --  The reader calls this subprogram when it starts parsing the document.
--   --  The reader calls this subprogram just once, after the call to
--   --  Set_Document_Locator, and before and other subprogram in this
--   --  interface or in the SAX_DTD_Handler interface are called.
--   --
--   --  If this subprogram sets Success to False the reader stops parsing and
--   --  reports an error. The reader uses the function Error_String to get the
--   --  error message.

--   not overriding procedure End_Entity
--    (Self    : in out SAX_Lexical_Handler;
--     Name    : League.Strings.Universal_String;
--     Success : in out Boolean) is null;
--   --  The reader calls this subprogram to report the end of an entity called
--   --  Name.
--   --
--   --  If this subprogram sets Success to False the reader stops parsing and
--   --  reports an error. The reader uses the function Error_String to get the
--   --  error message.
--
--   not overriding procedure Start_Entity
--    (Self    : in out SAX_Lexical_Handler;
--     Name    : League.Strings.Universal_String;
--     Success : in out Boolean) is null;
--   --  The reader calls this subprogram to report the start of an internal or
--   --  external entity called Name.
--   --
--   --  General entities are reported with their regular names, parameter
--   --  entities have '%' prepended to their names, and the external DTD subset
--   --  has the pseudo-entity name "[dtd]".
--   --
--   --  Note that if the entity is unknown, the reader reports it through
--   --  SAX_Content_Handler's Skipped_Entity and not through this subprogram.
--   --
--   --  Because of the streaming event model that SAX uses, some entity
--   --  boundaries cannot be reported under any circumstances:
--   --
--   --    * general entities within attribute values
--   --    * parameter entities within declarations
--   --
--   --  These will be silently expanded, with no indication of where the
--   --  original entity boundaries were.
--   --
--   --  Note also that the boundaries of character references (which are not
--   --  really entities anyway) are not reported.
--   --
--   --  The reporting of parameter entities (including the external DTD subset)
--   --  is optional, and SAX2 drivers that report Lexical_Handler events may not
--   --  implement it; you can use the
--   --  http://xml.org/sax/features/lexical-handler/parameter-entities feature
--   --  to query or control the reporting of parameter entities.
--   --
--   --  If this subprogram sets Success to False the reader stops parsing and
--   --  reports an error. The reader uses the function Error_String to get the
--   --  error message.

end XML.Templates.Processors;
