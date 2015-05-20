------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                            Web API Definition                            --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2014-2015, Vadim Godunko <vgodunko@gmail.com>                --
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
--  This package provides binding to interface Document.
------------------------------------------------------------------------------
with League.Strings;

with WebAPI.DOM.Comments;
with WebAPI.DOM.Document_Fragments;
with WebAPI.DOM.Document_Types;
with WebAPI.DOM.Elements;
with WebAPI.DOM.HTML_Collections;
with WebAPI.DOM.Nodes;
with WebAPI.DOM.Non_Element_Parent_Nodes;
with WebAPI.DOM.Parent_Nodes;
with WebAPI.DOM.Processing_Instructions;
with WebAPI.DOM.Texts;

package WebAPI.DOM.Documents is

   pragma Preelaborate;

   type Document is limited interface
     and WebAPI.DOM.Nodes.Node
     and WebAPI.DOM.Non_Element_Parent_Nodes.Non_Element_Parent_Node
     and WebAPI.DOM.Parent_Nodes.Parent_Node;

   type Document_Access is access all Document'Class
     with Storage_Size => 0;

   --  XXX Not binded yet:
   --    [SameObject] readonly attribute DOMImplementation implementation;

   not overriding function Get_URL
    (Self : not null access constant Document)
       return League.Strings.Universal_String is abstract
         with Import        => True,
              Convention    => JavaScript_Property_Getter,
              External_Name => "URL";
   --  Returns document's URL.

   not overriding function Get_Document_URI
    (Self : not null access constant Document)
       return League.Strings.Universal_String is abstract
         with Import        => True,
              Convention    => JavaScript_Property_Getter,
              External_Name => "documentURI";
   --  Returns document's URL.

   not overriding function Get_Compat_Mode
    (Self : not null access constant Document)
       return League.Strings.Universal_String is abstract
         with Import        => True,
              Convention    => JavaScript_Property_Getter,
              External_Name => "compatMode";
   --  Returns the string "CSS1Compat" if document is in no-quirks mode or
   --  limited-quirks mode, and "BackCompat", if document is in quirks mode.

   not overriding function Get_Character_Set
    (Self : not null access constant Document)
       return League.Strings.Universal_String is abstract
         with Import        => True,
              Convention    => JavaScript_Property_Getter,
              External_Name => "characterSet";
   --  Returns document's encoding.

   not overriding function Get_Content_Type
    (Self : not null access constant Document)
       return League.Strings.Universal_String is abstract
         with Import        => True,
              Convention    => JavaScript_Property_Getter,
              External_Name => "contentType";
   --  Returns document's content type.

   not overriding function Get_Doctype
    (Self : not null access constant Document)
       return WebAPI.DOM.Document_Types.Document_Type_Access is abstract
         with Import        => True,
              Convention    => JavaScript_Property_Getter,
              External_Name => "doctype";
   --  Returns the doctype or null if there is none.

   not overriding function Get_Document_Element
    (Self : not null access constant Document)
       return WebAPI.DOM.Elements.Element_Access is abstract
         with Import        => True,
              Convention    => JavaScript_Property_Getter,
              External_Name => "documentElement";
   --  Returns the document element.

   not overriding function Get_Elements_By_Tag_Name
    (Self       : not null access constant Document;
     Local_Name : League.Strings.Universal_String)
       return WebAPI.DOM.HTML_Collections.HTML_Collection is abstract
         with Import        => True,
              Convention    => JavaScript_Function,
              External_Name => "getElementsByTagName";
   --  If localName is "*" returns a HTMLCollection of all descendant elements.
   --
   --  Otherwise, returns a HTMLCollection of all descendant elements whose
   --  local name is localName. (Matches case-insensitively against elements in
   --  the HTML namespace within an HTML document.) 

   not overriding function Get_Elements_By_Tag_Name_NS
    (Self          : not null access constant Document;
     Namespace_URI : League.Strings.Universal_String;
     Local_Name    : League.Strings.Universal_String)
       return WebAPI.DOM.HTML_Collections.HTML_Collection is abstract
         with Import        => True,
              Convention    => JavaScript_Function,
              External_Name => "getElementsByTagNameNS";
   --  If namespace and localName are "*" returns a HTMLCollection of all
   --  descendant elements.
   --
   --  If only namespace is "*" returns a HTMLCollection of all descendant
   --  elements whose local name is localName.
   --
   --  If only localName is "*" returns a HTMLCollection of all descendant
   --  elements whose namespace is namespace.
   --
   --  Otherwise, returns a HTMLCollection of all descendant elements whose
   --  namespace is namespace and local name is localName.

   not overriding function Get_Elements_By_Class_Name
    (Self        : not null access constant Document;
     Class_Names : League.Strings.Universal_String)
       return WebAPI.DOM.HTML_Collections.HTML_Collection is abstract
         with Import        => True,
              Convention    => JavaScript_Function,
              External_Name => "getElementsByClassName";
   --  Returns a HTMLCollection of the elements in the object on which the
   --  method was invoked (a document or an element) that have all the classes
   --  given by classes.
   --
   --  The classes argument is interpreted as a space-separated list of
   --  classes.

   not overriding function Create_Element
    (Self       : not null access Document;
     Local_Name : League.Strings.Universal_String)
       return not null WebAPI.DOM.Elements.Element_Access is abstract
         with Import     => True,
              Convention => JavaScript_Function,
              Link_Name  => "createElement";
   --  Returns an element in the HTML namespace with localName as local name.
   --  (In an HTML document localName is lowercased.)
   --
   --  If localName does not match the Name production an
   --  "InvalidCharacterError" exception will be thrown.

   not overriding function Create_Element_NS
    (Self           : not null access Document;
     Namespace_URI  : League.Strings.Universal_String;
     Qialified_Name : League.Strings.Universal_String)
       return not null WebAPI.DOM.Elements.Element_Access is abstract
         with Import     => True,
              Convention => JavaScript_Function,
              Link_Name  => "createElementNS";
   --  Returns an element with namespace namespace. Its namespace prefix will
   --  be everything before ":" (U+003E) in qualifiedName or null. Its local
   --  name will be everything after ":" (U+003E) in qualifiedName or
   --  qualifiedName.
   --
   --  If localName does not match the Name production an
   --  "InvalidCharacterError" exception will be thrown.
   --
   --  If one of the following conditions is true a "NamespaceError" exception
   --  will be thrown:
   --
   --   - localName does not match the QName production.
   --   - Namespace prefix is not null and namespace is the empty string.
   --   - Namespace prefix is "xml" and namespace is not the XML namespace.
   --   - qualifiedName or namespace prefix is "xmlns" and namespace is not the
   --     XMLNS namespace.
   --   - namespace is the XMLNS namespace and neither qualifiedName nor
   --     namespace prefix is "xmlns". 

   not overriding function Create_Document_Fragment
    (Self : not null access Document)
       return not null WebAPI.DOM.Document_Fragments.Document_Fragment_Access
         is abstract
           with Import     => True,
                Convention => JavaScript_Function,
                Link_Name  => "createDocumentFragment";
   --  Returns a DocumentFragment node.

   not overriding function Create_Text_Node
    (Self : not null access Document;
     Data : League.Strings.Universal_String)
       return not null WebAPI.DOM.Texts.Text_Access is abstract
         with Import     => True,
              Convention => JavaScript_Function,
              Link_Name  => "createTextNode";
   --  Returns a Text node whose data is data.

   not overriding function Create_Comment
    (Self : not null access Document;
     Data : League.Strings.Universal_String)
       return WebAPI.DOM.Comments.Comment_Access is abstract
         with Import     => True,
              Convention => JavaScript_Function,
              Link_Name  => "createComment";
   --  Returns a Comment node whose data is data.

   not overriding function Create_Processing_Instruction
    (Self   : not null access Document;
     Target : League.Strings.Universal_String;
     Data   : League.Strings.Universal_String)
       return WebAPI.DOM.Processing_Instructions.Processing_Instruction_Access
         is abstract
           with Import     => True,
                Convention => JavaScript_Function,
                Link_Name  => "createProcessingInstruction";
   --  Returns a ProcessingInstruction node whose target is target and data is
   --  data.
   --
   --  If target does not match the Name production an "InvalidCharacterError"
   --  exception will be thrown.
   --
   --  If data contains "?>" an "InvalidCharacterError" exception will be
   --  thrown. 

   not overriding function Import_Node
    (Self : not null access Document;
     Node : not null access WebAPI.DOM.Nodes.Node'Class;
     Deep : Boolean := False)
       return WebAPI.DOM.Nodes.Node_Access is abstract
         with Import     => True,
              Convention => JavaScript_Function,
              Link_Name  => "importNode";
   --  Returns a copy of node. If deep is true, the copy also includes the
   --  node's descendants.
   --
   --  If node is a document throws a "NotSupportedError" exception. 

   not overriding function Adopt_Node
    (Self : not null access Document;
     Node : not null access WebAPI.DOM.Nodes.Node'Class)
       return WebAPI.DOM.Nodes.Node_Access is abstract
         with Import     => True,
              Convention => JavaScript_Function,
              Link_Name  => "adoptNode";
   procedure Adopt_Node
    (Self : not null access Document'Class;
     Node : not null access WebAPI.DOM.Nodes.Node'Class)
       with Import     => True,
            Convention => JavaScript_Function,
            Link_Name  => "adoptNode";
   --  Moves node from another document and returns it.
   --
   --  If node is a document throws a "NotSupportedError" exception.

   --  XXX Not binded yet:
   --    [NewObject] Event createEvent(DOMString interface);

   --  XXX Not binded yet:
   --    [NewObject] Range createRange();

   --  XXX Not binded yet:
   --    // NodeFilter.SHOW_ALL = 0xFFFFFFFF
   --    [NewObject] NodeIterator createNodeIterator(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
   --    [NewObject] TreeWalker createTreeWalker(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);

end WebAPI.DOM.Documents;
