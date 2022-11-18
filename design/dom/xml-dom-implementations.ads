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
--  The DOMImplementation interface provides a number of methods for performing
--  operations that are independent of any particular instance of the document
--  object model.
------------------------------------------------------------------------------
with League.Strings;

with XML.DOM.Document_Types;
with XML.DOM.Documents;

package XML.DOM.Implementations is

--  interface DOMImplementation {
--    boolean            hasFeature(in DOMString feature, 
--                                  in DOMString version);
--    // Introduced in DOM Level 2:
--    DocumentType       createDocumentType(in DOMString qualifiedName, 
--                                          in DOMString publicId, 
--                                          in DOMString systemId)
--                                        raises(DOMException);
--    // Introduced in DOM Level 3:
--    DOMObject          getFeature(in DOMString feature, 
--                                  in DOMString version);
--  };

   type DOM_Implementation is tagged private;

   function Create_Document
    (Self           : DOM_Implementation'Class;
     Namespace_URI  : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String;
     Qualified_Name : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String;
     Doctype        : XML.DOM.Document_Types.DOM_Document_Type'Class
       := XML.DOM.Document_Types.Null_DOM_Document_Type)
       return XML.DOM.Documents.DOM_Document;
   --  Creates a DOM Document object of the specified type with its document
   --  element.
   --
   --  Note that based on the DocumentType given to create the document, the
   --  implementation may instantiate specialized Document objects that support
   --  additional features than the "Core", such as "HTML" [DOM Level 2 HTML].
   --  On the other hand, setting the DocumentType after the document was
   --  created makes this very unlikely to happen. Alternatively, specialized
   --  Document creation methods, such as createHTMLDocument [DOM Level 2
   --  HTML], can be used to obtain specific types of Document objects.
   --
   --  Parameters
   --
   --    namespaceURI of type DOMString
   --
   --      The namespace URI of the document element to create or null.
   --
   --    qualifiedName of type DOMString
   --
   --      The qualified name of the document element to be created or null.
   --
   --    doctype of type DocumentType
   --
   --      The type of document to be created or null.
   --
   --      When doctype is not null, its Node.ownerDocument attribute is set to
   --      the document being created.
   --
   --  Return Value
   --
   --    A new Document object with its document element. If the NamespaceURI,
   --    qualifiedName, and doctype are null, the returned Document is empty
   --    with no document element.
   --
   --  Exceptions
   --
   --    DOMException
   --
   --      INVALID_CHARACTER_ERR: Raised if the specified qualified name is not
   --      an XML name according to [XML 1.0].
   --
   --      NAMESPACE_ERR: Raised if the qualifiedName is malformed, if the
   --      qualifiedName has a prefix and the namespaceURI is null, or if the
   --      qualifiedName is null and the namespaceURI is different from null,
   --      or if the qualifiedName has a prefix that is "xml" and the
   --      namespaceURI is different from
   --      "http://www.w3.org/XML/1998/namespace" [XML Namespaces], or if the
   --      DOM implementation does not support the "XML" feature but a non-null
   --      namespace URI was provided, since namespaces were defined by XML.
   --
   --      WRONG_DOCUMENT_ERR: Raised if doctype has already been used with a
   --      different document or was created from a different implementation.
   --
   --      NOT_SUPPORTED_ERR: May be raised if the implementation does not
   --      support the feature "XML" and the language exposed through the
   --      Document does not support XML Namespaces (such as [HTML 4.01]). 

private

   type DOM_Implementation is tagged null record;

end XML.DOM.Implementations;
