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
limited with XML.DOM.Nodes.Attrs;
limited with XML.DOM.Nodes.Character_Datas.Texts;
limited with XML.DOM.Nodes.Elements;

package XML.DOM.Nodes.Documents is

   type DOM_Document is new DOM_Node with private;

   type DOM_Document_Access is access all DOM_Document'Class;

   not overriding function Create_Attribute_NS
    (Self           : not null access DOM_Document;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return XML.DOM.Nodes.Attrs.DOM_Attr_Access;

   not overriding function Create_Element_NS
    (Self           : not null access DOM_Document;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String)
       return XML.DOM.Nodes.Elements.DOM_Element_Access;

   not overriding function Create_Text_Node
    (Self : not null access DOM_Document;
     Data : League.Strings.Universal_String)
       return XML.DOM.Nodes.Character_Datas.Texts.DOM_Text_Access;

private

   type DOM_Document is new DOM_Node with record
      null;
   end record;

   overriding procedure Enter_Element
    (Self    : not null access DOM_Document;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding function Get_Local_Name
    (Self : not null access constant DOM_Document)
       return League.Strings.Universal_String;

   overriding function Get_Namespace_URI
    (Self : not null access constant DOM_Document)
       return League.Strings.Universal_String;

   overriding procedure Leave_Element
    (Self    : not null access DOM_Document;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Visit_Element
    (Self     : not null access DOM_Document;
     Iterator : in out XML.DOM.Visitors.Abstract_Iterator'Class;
     Visitor  : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control  : in out XML.DOM.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

end XML.DOM.Nodes.Documents;
