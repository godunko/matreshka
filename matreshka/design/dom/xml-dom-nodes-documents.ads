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
-- Copyright © 2012-2013, Vadim Godunko <vgodunko@gmail.com>                --
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
with XML.DOM.Attributes;
with XML.DOM.Elements;

package XML.DOM.Nodes.Documents is

   pragma Preelaborate;

--  interface Document : Node {
--    // Modified in DOM Level 3:
--    readonly attribute DocumentType    doctype;
--    readonly attribute DOMImplementation implementation;
--    readonly attribute Element         documentElement;
--    Element            createElement(in DOMString tagName)
--                                        raises(DOMException);
--    DocumentFragment   createDocumentFragment();
--    Text               createTextNode(in DOMString data);
--    Comment            createComment(in DOMString data);
--    CDATASection       createCDATASection(in DOMString data)
--                                        raises(DOMException);
--    ProcessingInstruction createProcessingInstruction(in DOMString target, 
--                                                      in DOMString data)
--                                        raises(DOMException);
--    Attr               createAttribute(in DOMString name)
--                                        raises(DOMException);
--    EntityReference    createEntityReference(in DOMString name)
--                                        raises(DOMException);
--    NodeList           getElementsByTagName(in DOMString tagname);
--    // Introduced in DOM Level 2:
--    Node               importNode(in Node importedNode, 
--                                  in boolean deep)
--                                        raises(DOMException);
--    // Introduced in DOM Level 2:
--    NodeList           getElementsByTagNameNS(in DOMString namespaceURI, 
--                                              in DOMString localName);
--    // Introduced in DOM Level 2:
--    Element            getElementById(in DOMString elementId);
--    // Introduced in DOM Level 3:
--    readonly attribute DOMString       inputEncoding;
--    // Introduced in DOM Level 3:
--    readonly attribute DOMString       xmlEncoding;
--    // Introduced in DOM Level 3:
--             attribute boolean         xmlStandalone;
--                                        // raises(DOMException) on setting
--
--    // Introduced in DOM Level 3:
--             attribute DOMString       xmlVersion;
--                                        // raises(DOMException) on setting
--
--    // Introduced in DOM Level 3:
--             attribute boolean         strictErrorChecking;
--    // Introduced in DOM Level 3:
--             attribute DOMString       documentURI;
--    // Introduced in DOM Level 3:
--    Node               adoptNode(in Node source)
--                                        raises(DOMException);
--    // Introduced in DOM Level 3:
--    readonly attribute DOMConfiguration domConfig;
--    // Introduced in DOM Level 3:
--    void               normalizeDocument();
--    // Introduced in DOM Level 3:
--    Node               renameNode(in Node n, 
--                                  in DOMString namespaceURI, 
--                                  in DOMString qualifiedName)
--                                        raises(DOMException);
--  };

   type DOM_Document is new XML.DOM.Nodes.DOM_Node with private;
   Null_DOM_Document : constant DOM_Document;

   function Create_Attribute_NS
    (Self           : in out DOM_Document'Class;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return XML.DOM.Attributes.DOM_Attribute;
   --  Creates an attribute of the given qualified name and namespace URI.
   --
   --  Per [XML Namespaces], applications must use the value null as the
   --  namespaceURI parameter for methods if they wish to have no namespace.
   --
   --  Parameters
   --
   --    namespaceURI of type DOMString
   --
   --      The namespace URI of the attribute to create.
   --
   --    qualifiedName of type DOMString
   --
   --      The qualified name of the attribute to instantiate.
   --
   --  Return Value
   --
   --    A new Attr object with the following attributes:
   --
   --    Attribute       Value
   --    Node.nodeName   qualifiedName
   --    Node.namespaceURI       namespaceURI
   --    Node.prefix     prefix, extracted from qualifiedName, or null if there is no prefix
   --    Node.localName  local name, extracted from qualifiedName
   --    Attr.name       qualifiedName
   --    Node.nodeValue  the empty string
   --
   --  Exceptions
   --
   --    INVALID_CHARACTER_ERR: Raised if the specified qualifiedName is not an
   --    XML name according to the XML version in use specified in the
   --    Document.xmlVersion attribute.
   --
   --    NAMESPACE_ERR: Raised if the qualifiedName is a malformed qualified
   --    name, if the qualifiedName has a prefix and the namespaceURI is null,
   --    if the qualifiedName has a prefix that is "xml" and the namespaceURI
   --    is different from "http://www.w3.org/XML/1998/namespace", if the
   --    qualifiedName or its prefix is "xmlns" and the namespaceURI is
   --    different from "http://www.w3.org/2000/xmlns/", or if the namespaceURI
   --    is "http://www.w3.org/2000/xmlns/" and neither the qualifiedName nor
   --    its prefix is "xmlns".
   --
   --    NOT_SUPPORTED_ERR: Always thrown if the current document does not
   --    support the "XML" feature, since namespaces were defined by XML.

   function Create_Element_NS
    (Self           : in out DOM_Document'Class;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return XML.DOM.Elements.DOM_Element;
   --  Creates an element of the given qualified name and namespace URI.
   --
   --  Per [XML Namespaces], applications must use the value null as the
   --  namespaceURI parameter for methods if they wish to have no namespace.
   --
   --  Parameters
   --
   --    namespaceURI of type DOMString
   --
   --      The namespace URI of the element to create.
   --
   --    qualifiedName of type DOMString
   --
   --      The qualified name of the element type to instantiate.
   --
   --  Return Value
   --
   --    A new Element object with the following attributes:
   --
   --           Attribute       Value
   --           Node.nodeName   qualifiedName
   --           Node.namespaceURI       namespaceURI
   --           Node.prefix     prefix, extracted from qualifiedName, or null if there is no prefix
   --           Node.localName  local name, extracted from qualifiedName
   --           Element.tagName qualifiedName
   --
   --  Exceptions
   --
   --    DOMException
   --
   --      INVALID_CHARACTER_ERR: Raised if the specified qualifiedName is not
   --      an XML name according to the XML version in use specified in the
   --      Document.xmlVersion attribute.
   --
   --      NAMESPACE_ERR: Raised if the qualifiedName is a malformed qualified
   --      name, if the qualifiedName has a prefix and the namespaceURI is
   --      null, or if the qualifiedName has a prefix that is "xml" and the
   --      namespaceURI is different from
   --      "http://www.w3.org/XML/1998/namespace" [XML Namespaces], or if the
   --      qualifiedName or its prefix is "xmlns" and the namespaceURI is
   --      different from "http://www.w3.org/2000/xmlns/", or if the
   --      namespaceURI is "http://www.w3.org/2000/xmlns/" and neither the
   --      qualifiedName nor its prefix is "xmlns".
   --
   --      NOT_SUPPORTED_ERR: Always thrown if the current document does not
   --      support the "XML" feature, since namespaces were defined by XML.

private

   type DOM_Document is new XML.DOM.Nodes.DOM_Node with null record;

   Null_DOM_Document : constant DOM_Document :=
    (Ada.Finalization.Controlled with Node => null);

end XML.DOM.Nodes.Documents;
